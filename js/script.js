const hamburger = document.querySelector(".hamburger");
hamburger.addEventListener("click",function(){
    document.querySelector(".portfolio-navbar").classList.toggle("show");
})

// Récupérer les divs avec la classe "lien"
const lienPDF0 = document.getElementById("lienPDF0");
const lienPDF1 = document.getElementById("lienPDF1");
const lienPDF2 = document.getElementById("lienPDF2");
const lienPDF3 = document.getElementById("lienPDF3");
const lienPDF4 = document.getElementById("lienPDF4");
const lienPDF5 = document.getElementById("lienPDF5");
const lienPDF6 = document.getElementById("lienPDF6");
const lienPDF7 = document.getElementById("lienPDF7");

// Fonction pour ouvrir une nouvelle fenêtre avec le fichier PDF
function ouvrirPDF0() {
  window.open("certificats/entrepreneuriat.pdf", "_blank");
}
function ouvrirPDF1() {
  window.open("certificats/ecommerce.pdf", "_blank");
}
function ouvrirPDF2() {
  window.open("certificats/attestation.pdf", "_blank");
}
function ouvrirPDF3() {
  window.open("certificats/reconnaissance.pdf", "_blank");
}
function ouvrirPDF4() {
  window.open("certificats/ieschool.pdf", "_blank");
}
function ouvrirPDF5() {
  window.open("certificats/pabc.pdf", "_blank");
}
function ouvrirPDF6() {
  window.open("certificats/honneuretmerites.pdf", "_blank");
}
function ouvrirPDF7() {
  window.open("certificats/alliancefrancaise.pdf", "_blank");
}

// Ajouter des écouteurs d'événements aux divs pour détecter les clics
lienPDF0.addEventListener("click", ouvrirPDF0);
lienPDF1.addEventListener("click", ouvrirPDF1);
lienPDF2.addEventListener("click", ouvrirPDF2);
lienPDF3.addEventListener("click", ouvrirPDF3);
lienPDF4.addEventListener("click", ouvrirPDF4);
lienPDF5.addEventListener("click", ouvrirPDF5);
lienPDF6.addEventListener("click", ouvrirPDF6);
lienPDF7.addEventListener("click", ouvrirPDF7);


function toggleForm() {
	var forme7 = document.querySelector('.service-box:nth-child(7)');
	var forme8 = document.querySelector('.service-box:nth-child(8)');
	var voirPlusBtn = document.getElementById('voirPlusBtn');
  
	if (forme7.classList.contains('hidden') && forme8.classList.contains('hidden')) {
	  forme7.classList.remove('hidden');
	  forme8.classList.remove('hidden');
	  voirPlusBtn.textContent = 'Voir moins';
	} else {
	  forme7.classList.add('hidden');
	  forme8.classList.add('hidden');
	  voirPlusBtn.textContent = 'Voir plus';
	}
  }

  const ButtonView = document.getElementById("ButtonView");
  const formesContainer = document.getElementById("formesContainer");

  ButtonView.addEventListener("click", function() {
		formesContainer.classList.toggle("hide");
	  if (formesContainer.classList.contains("hide")) {
			ButtonView.textContent = "Voir plus";
	  } else {
			ButtonView.textContent = "Voir moins";
		}
  });

  // Récupérer le bouton par son ID
	const bouton = document.getElementById("monBouton");
  
	// Ajouter un gestionnaire d'événement pour le clic sur le bouton
	bouton.addEventListener("click", function() {
	  // Rediriger vers la page spécifiée lorsque le bouton est cliqué
	  window.location.href = "contact.html#contact";
	});


// Magnific Popup
$('.unique').magnificPopup({
	delegate: '.overlay a',
	type: 'image',
	gallery:{
		enabled: true
	}
})

$('.hide').magnificPopup({
	delegate: '.overlay a',
	type: 'image',
	gallery:{
		enabled: true
	}
})
