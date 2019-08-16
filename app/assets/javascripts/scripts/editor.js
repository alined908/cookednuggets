import $ from 'jquery';
var hello = "";

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
  $("#add-section").click(function(){
    if ($("#admin-action-add").css('display') == 'none'){
      $("#admin-action-add").show();
    }
    else {
      $("#admin-action-add").hide();
    }
  });
  $("#add-team").click(function(){
    if ($(".team-selector").length){
      $("#event-add-teams").append(
        "<div class='team-selector'>" +$(".team-selector").html() + "</div>"
      );
    }else {
      $("#event-add-teams").append(hello);
    }
  });

  $(document).on('click', '.remove-team', function(){
    hello = $(this).parent()
    $(this).parent().remove();
  });
});
