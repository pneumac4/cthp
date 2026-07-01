const hamburger = document.querySelector(".hamburger");
hamburger.addEventListener("click",function(){
    document.querySelector(".portfolio-navbar").classList.toggle("show");
})

// Année dynamique dans le pied de page
const yearEl = document.getElementById("year");
if (yearEl) {
  yearEl.textContent = new Date().getFullYear();
}

// Ouvrir le certificat PDF correspondant au clic (un seul écouteur pour toutes les cartes)
document.querySelectorAll("[data-pdf]").forEach(function (box) {
  box.addEventListener("click", function () {
    window.open(box.dataset.pdf, "_blank");
  });
});


function toggleForm() {
	var forme7 = document.querySelector('.service-box:nth-child(7)');
	var forme8 = document.querySelector('.service-box:nth-child(8)');
	var forme9 = document.querySelector('.service-box:nth-child(9)');
	var voirPlusBtn = document.getElementById('voirPlusBtn');
  
	if (forme7.classList.contains('hidden') && forme8.classList.contains('hidden') && forme9.classList.contains('hidden')) {
	  forme7.classList.remove('hidden');
	  forme8.classList.remove('hidden');
	  forme9.classList.remove('hidden');
	  voirPlusBtn.textContent = 'Voir moins';
	} else {
	  forme7.classList.add('hidden');
	  forme8.classList.add('hidden');
	  forme9.classList.add('hidden');
	  voirPlusBtn.textContent = 'Voir plus';
	}
  }

  const ButtonView = document.getElementById("ButtonView");
  const formesContainer = document.getElementById("formesContainer");

  if (ButtonView && formesContainer) {
    ButtonView.addEventListener("click", function() {
      formesContainer.classList.toggle("hide");
      if (formesContainer.classList.contains("hide")) {
        ButtonView.textContent = "Voir plus";
      } else {
        ButtonView.textContent = "Voir moins";
      }
    });
  }

  // Bouton "Prendre contact" (présent uniquement sur portfolio.html)
	const bouton = document.getElementById("monBouton");
	if (bouton) {
	  bouton.addEventListener("click", function() {
	    window.location.href = "contact.html#contact";
	  });
	}


// Magnific Popup (jQuery n'est chargé que sur portfolio.html)
if (window.jQuery) {
  $('.showallimg').magnificPopup({
    delegate: '.overlay a',
    type: 'image',
    gallery: {
      enabled: true
    }
  });
}

