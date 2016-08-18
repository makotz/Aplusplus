// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require moment
//= require fullcalendar
//= require_tree .
$(document).ready(function(){
  //Hide all grade related forms
  $('.update-form-manual-imp').hide()
  $('.update-form-percentage-imp').hide()
  $('.update-form-manual').hide()
  $('.update-form-percentage').hide()
  $('.desired-grade-form').hide()

  //Toggle all grade related forms
  $(".update-button-percentage").click(function() {
    $(this).parent().children(".update-form-percentage").toggle()
  });
  $(".update-button-manual").click(function() {
    $(this).parent().children(".update-form-manual").toggle()
  });
  $(".update-button-percentage-imp").click(function() {
    $(this).parent().children(".update-form-percentage-imp").toggle()
  });
  $(".update-button-manual-imp").click(function() {
    $(this).parent().children(".update-form-manual-imp").toggle()
  });
  $(".update-desired-grade").click(function() {
    $(this).parent().children(".desired-grade-form").toggle()
  });

  //Alert dissappers after 3 seconds
  $("body > div > div.alert.alert-dismissible.alert-success").delay(3000).fadeOut('slow');
});
