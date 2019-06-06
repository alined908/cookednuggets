// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('change', '.custom-file-input', function(){
  var fileName = $(this)[0].files[0].name;
  $(this).next('.custom-file-label').addClass("selected").html(fileName);
});
