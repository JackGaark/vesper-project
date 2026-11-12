
import ProgressBar from 'progressbar.js'



document.addEventListener("DOMContentLoaded", function(event) {

  if (document.querySelector('.banner-main')) {

    // setInterval(function(){


      document.getElementById('container-lols').removeAttribute('hidden');
      // var ProgressBar = require('progressbar');

      var bar = new ProgressBar.Path('#heart-path', {
        easing: 'easeInOut',
        duration: 2000
      });

      bar.set(0);
      bar.animate(1);  // Number from 0.0 to 1.0

      var bar2 = new ProgressBar.Path('#heart-path2', {
        easing: 'easeInOut',
        duration: 2000
      });

      bar2.set(0);
      bar2.animate(1);  // Number from 0.0 to 1.0


      var bar3 = new ProgressBar.Path('#hearth-path0', {
        easing: 'easeInOut',
        duration: 2000
      });

      bar3.set(0);
      bar3.animate(1);  // Number from 0.0 to 1.0

    // }, 2000);
  }

  if (document.getElementById('mdl-slider')) {

      // setInterval(function(){


        // document.getElementById('container-lols').removeAttribute('hidden');
        // var ProgressBar = require('progressbar');

        var bar = new ProgressBar.Path('#heart-path', {
          easing: 'bounce',
          duration: 750
        });

        bar.set(0);
        // bar.animate(1);  // Number from 0.0 to 1.0

        var bar2 = new ProgressBar.Path('#heart-path2', {
          easing: 'bounce',
          duration: 750
        });

        bar2.set(0);
        bar2.animate(0);  // Number from 0.0 to 1.0


        var bar3 = new ProgressBar.Path('#hearth-path0', {
          easing: 'bounce',
          duration: 750
        });

        bar3.set(0);
        // bar3.animate(1);  // Number from 0.0 to 1.0

      // }, 2000);
      if (document.getElementById('mdl-slider')) {

        const packageCards = document.querySelectorAll('.package-card');
      // console.log(packageCards);
      const firstPackageCard = packageCards[0]
      const secondPackageCard = packageCards[1]
      const thirdPackageCard = packageCards[2]

      const firstPath = document.getElementById('heart-path');
      const secondPath = document.getElementById('heart-path2');
      const thirdPath = document.getElementById('heart-path0');

      var slider = document.getElementById("mdl-slider");
      var output = document.getElementById("contribution-input");
      if (output) {
        output.innerHTML = slider.value; // Display the default slider value
      }

      // ATTEMPT AT FIXING EVERYTHIN :

    const firstBreak = 90;
    const secondBreak = 180;
    const thirdBreak = 270;
    const contributionTotalEl = document.getElementById('contribution-total');
    let contributionTotal = 0;
    let animationValue = 0;
    // Update the current slider value (each time you drag the slider handle)
    slider.oninput = function() {

      output.innerHTML = this.value;

    }
    // $basketAmount.bind("DOMSubtreeModified", versandkosten);
    $('#contribution-total').bind("DOMSubtreeModified",function(){
      // console.log('fired');
      contributionTotal = parseInt(contributionTotalEl.innerHTML);

      animationValue = contributionTotal / 270;
      // console.log(animationValue);
      // console.log(contributionTotal);

      // console.log(this.value /100);
      if (contributionTotal < 90) {
        if ((animationValue /25) < 1) {
          bar.animate(contributionTotal /90);
          bar2.animate(0);
          bar3.animate(0);
          firstPackageCard.classList.add('grayscale');
          secondPackageCard.classList.add('grayscale');
          thirdPackageCard.classList.add('grayscale');
        }
        firstPackageCard.style.zIndex = 2;
        firstPackageCard.style.zIndex = 2;
        secondPackageCard.style.zIndex = 2;
        firstPackageCard.classList.remove('current-package');

      } else if ( contributionTotal < 180) {
        if (((animationValue /25) - 1.2) < 1) {
          bar.animate(1);
          bar2.animate((contributionTotal - 90) /90);
          bar3.animate(0);
          firstPackageCard.style.zIndex = 2;
          secondPackageCard.style.zIndex = 2;
          firstPackageCard.classList.add('current-package');
          firstPackageCard.classList.remove('grayscale');
          secondPackageCard.classList.remove('current-package');
          secondPackageCard.classList.add('grayscale');
          thirdPackageCard.classList.add('grayscale');
          thirdPackageCard.classList.remove('current-package');
        }

      } else {
        if ((animationValue - 2.4) < 1) {
          // console.log('doing both');
          bar3.animate((contributionTotal - 180) /90);
          firstPackageCard.style.zIndex = 1;
          secondPackageCard.style.zIndex = 2;
          secondPackageCard.classList.add('current-package');
          thirdPackageCard.classList.remove('current-package');
          thirdPackageCard.classList.add('grayscale');
        }

        if (contributionTotal >= 270) {
          thirdPackageCard.classList.add('current-package');
          thirdPackageCard.classList.remove('grayscale');
          bar3.animate(1);
          firstPackageCard.style.zIndex = 1;
          secondPackageCard.style.zIndex = 1;
          secondPackageCard.classList.remove('current-package');

        }
        bar.animate(1);
        bar2.animate(1);
        firstPackageCard.classList.remove('grayscale');
        firstPackageCard.classList.remove('current-package');
        secondPackageCard.classList.remove('grayscale');

      }
    })

    // ATTEMPT AT FIXING EVERYTHIN

    // if (slider) {
    //   // Update the current slider value (each time you drag the slider handle)
    //   slider.oninput = function() {

    //     output.innerHTML = this.value;
    //     // console.log(this.value /100);
    //     if (this.value < 33) {
    //       if ((this.value /25) < 1) {
    //         bar.animate(this.value /25);
    //         bar2.animate(0);
    //         bar3.animate(0);
    //         firstPackageCard.classList.add('grayscale');
    //         secondPackageCard.classList.add('grayscale');
    //         thirdPackageCard.classList.add('grayscale');
    //       }
    //       firstPackageCard.style.zIndex = 2;
    //       firstPackageCard.style.zIndex = 2;
    //       secondPackageCard.style.zIndex = 2;
    //       firstPackageCard.classList.remove('current-package');

    //     } else if ( this.value < 63) {
    //       if (((this.value /25) - 1.2) < 1) {
    //         bar.animate(1);
    //         bar2.animate((this.value /25) - 1.2);
    //         bar3.animate(0);
    //         secondPackageCard.style.zIndex = 2;
    //         firstPackageCard.classList.add('current-package');
    //         firstPackageCard.classList.remove('grayscale');
    //         secondPackageCard.classList.remove('current-package');
    //         secondPackageCard.classList.add('grayscale');
    //         thirdPackageCard.classList.add('grayscale');
    //         thirdPackageCard.classList.remove('current-package');
    //       }

    //     } else {
    //       if (((this.value /25) - 2.4) < 1) {
    //         bar3.animate((this.value /25) - 2.4);
    //         firstPackageCard.style.zIndex = 1;
    //         secondPackageCard.style.zIndex = 2;
    //         secondPackageCard.classList.add('current-package');
    //         thirdPackageCard.classList.remove('current-package');
    //         thirdPackageCard.classList.add('grayscale');
    //       }

    //       if (this.value > 90) {
    //         thirdPackageCard.classList.add('current-package');
    //         thirdPackageCard.classList.remove('grayscale');
    //         bar3.animate(1);
    //         firstPackageCard.style.zIndex = 1;
    //         secondPackageCard.style.zIndex = 1;
    //         secondPackageCard.classList.remove('current-package');

    //       }
    //       bar.animate(1);
    //       bar2.animate(1);
    //       firstPackageCard.classList.remove('grayscale');
    //       firstPackageCard.classList.remove('current-package');
    //       secondPackageCard.classList.remove('grayscale');

    //     }
    //   }
    // }
  }
}
});
