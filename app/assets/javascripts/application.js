//= require_tree .
//= require jquery
//= require jquery_ujs
//= require jquery.slick

function initializeSlick() {
  $('.venue-social-pictures').slick({
    dots: true,
    infinite: true,
    speed: 500,
    fade: true,
    cssEase: 'linear',
    prevArrow: false,
    nextArrow: false,
    autoplay: true,
    autoplaySpeed: 1500,
  });

  $('.squad-details').slick({
    dots: true,
    infinite: true,
    speed: 500,
    fade: true,
    cssEase: 'linear',
    prevArrow: false,
    nextArrow: false,
    autoplay: true,
    autoplaySpeed: 3000,
  });
}
$(document).ready(function(){
  initializeSlick();
});

