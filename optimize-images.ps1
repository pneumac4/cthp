<#
    optimize-images.ps1
    --------------------
    Redimensionne et compresse les images du portfolio (dossier /images)
    qui sont beaucoup plus grandes que nécessaire pour un affichage web
    (ex: affiche.jpg = 15,7 Mo, carteqgis.png = 13,3 Mo).

    - Les originaux sont d'abord sauvegardés dans /images_originaux
      (rien n'est jamais perdu, tu peux toujours revenir en arrière).
    - Les images sont redimensionnées à une largeur max de 1600px
      (largement suffisant pour un site web, même en plein écran).
    - Les .jpg sont recompressés en qualité 80 (très bonne qualité visuelle,
      taille très réduite).
    - Les .png gardent leur format (pas de perte de transparence) mais
      sont redimensionnés, ce qui réduit déjà énormément leur poids.
    - Les .gif sont ignorés (footer-bg.gif est probablement animé,
      le redimensionner avec cet outil casserait l'animation) :
      compresse-le à part avec https://ezgif.com/optimize si besoin.
    - Les petites icônes (favicon, emoji, voir) sont ignorées, elles sont
      déjà légères.

    UTILISATION :
    1. Clique droit sur ce fichier > "Exécuter avec PowerShell"
       (ou ouvre un terminal dans ce dossier et lance : .\optimize-images.ps1)
    2. Relis le résumé affiché à la fin.
    3. Vérifie que les pages du site s'affichent bien.
    4. Si tout va bien, tu peux supprimer /images_originaux plus tard.
#>

Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$imagesDir = Join-Path $root "images"
$backupDir = Join-Path $root "images_originaux"
$maxWidth = 1600
$jpegQuality = 80L
$excludedNames = @("favicon.png", "emoji.png", "voir.png")

if (-not (Test-Path $imagesDir)) {
    Write-Host "Dossier introuvable : $imagesDir" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

function Get-JpegEncoder {
    [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
        Where-Object { $_.MimeType -eq "image/jpeg" }
}

$jpegEncoder = Get-JpegEncoder
$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
    [System.Drawing.Imaging.Encoder]::Quality, $jpegQuality
)

$files = Get-ChildItem -Path $imagesDir -Recurse -File |
    Where-Object {
        $_.Extension -match '\.(jpg|jpeg|png)$' -and
        $excludedNames -notcontains $_.Name -and
        $_.FullName -notlike "$backupDir*"
    }

$totalBefore = 0
$totalAfter = 0
$results = @()

foreach ($file in $files) {
    $relativePath = $file.FullName.Substring($imagesDir.Length).TrimStart('\')
    $backupPath = Join-Path $backupDir $relativePath
    $backupFolder = Split-Path $backupPath -Parent

    if (Test-Path $backupPath) {
        # Déjà traité lors d'une exécution précédente : on passe.
        continue
    }

    if (-not (Test-Path $backupFolder)) {
        New-Item -ItemType Directory -Path $backupFolder -Force | Out-Null
    }

    $sizeBefore = $file.Length
    Copy-Item $file.FullName $backupPath

    try {
        $img = [System.Drawing.Image]::FromFile($file.FullName)

        if ($img.Width -gt $maxWidth) {
            $newWidth = $maxWidth
            $newHeight = [int]($img.Height * ($maxWidth / $img.Width))
        } else {
            $newWidth = $img.Width
            $newHeight = $img.Height
        }

        $bitmap = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.DrawImage($img, 0, 0, $newWidth, $newHeight)
        $img.Dispose()

        $tempPath = "$($file.FullName).tmp"

        if ($file.Extension -match '\.(jpg|jpeg)$') {
            $bitmap.Save($tempPath, $jpegEncoder, $encoderParams)
        } else {
            $bitmap.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Png)
        }
        $graphics.Dispose()
        $bitmap.Dispose()

        Move-Item -Force $tempPath $file.FullName

        $sizeAfter = (Get-Item $file.FullName).Length
        $totalBefore += $sizeBefore
        $totalAfter += $sizeAfter

        $results += [PSCustomObject]@{
            Fichier   = $relativePath
            Avant     = "{0:N1} Mo" -f ($sizeBefore / 1MB)
            Apres     = "{0:N1} Mo" -f ($sizeAfter / 1MB)
            Reduction = "{0:P0}" -f (1 - ($sizeAfter / $sizeBefore))
        }
    }
    catch {
        Write-Host "Erreur sur $relativePath : $_" -ForegroundColor Red
        # on restaure l'original si quelque chose a mal tourné
        Copy-Item $backupPath $file.FullName -Force
    }
}

$results | Format-Table -AutoSize

if ($totalBefore -gt 0) {
    Write-Host ""
    Write-Host ("Poids total avant : {0:N1} Mo" -f ($totalBefore / 1MB))
    Write-Host ("Poids total apres : {0:N1} Mo" -f ($totalAfter / 1MB))
    Write-Host ("Gain : {0:P0}" -f (1 - ($totalAfter / $totalBefore))) -ForegroundColor Green
} else {
    Write-Host "Aucune nouvelle image a traiter (tout est deja optimise, ou deja present dans images_originaux)." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Les fichiers originaux sont conserves dans : $backupDir" -ForegroundColor Cyan
Write-Host "N'oublie pas de verifier le site avant de supprimer ce dossier de sauvegarde."
