import $ from 'jquery';

$(document).ready(function() {
  $(".reply-button").click(function(){
      var num = $(this).attr('class').split(" ")[1];
      if ($("#reply-" + num).css('display') == 'none'){
        $("#reply-" + num).show();
      }
      else {
        $("#reply-" + num).hide();
      }
  });
  $(".edit-button").click(function(){
      var num = $(this).attr('class').split(" ")[1];
      if ($("#edit-" + num).css('display') == 'none'){
        $("#edit-" + num).show();
        $("#edit-" + num).prev().hide();
      }
      else {
        $("#edit-" + num).hide();
        $("#edit-" + num).prev().show();
      }
  });
  $("#edit-thread").click(function(){
    if ($("#admin-action-edit").css('display') == 'none'){
      $("#admin-action-edit").show();
    }
    else {
      $("#admin-action-edit").hide();
    }
  });
});
