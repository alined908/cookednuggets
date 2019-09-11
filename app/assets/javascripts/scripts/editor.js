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

  $(".admin-panel").click(function(){
    var num = $(this).attr('class').split(" ")[1];
    if ($("#panel-" + num).css('display') == 'none'){
      $("#panel-" + num).show();
    }
    else {
      $("#panel-" + num).hide();
    }
  })

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

  $(".post-collapsable").click(function(){
    var post = $(this).parent().parent().parent();
    var parent = $(post).parent().parent();
    var children = $(parent).find(".parent-post").length;

    if ($(this).html().indexOf("–") >= 0) {
      if (children >= 1) {
        $(parent).children().eq(1).hide();
      }
      $(post).children().slice(1).hide();
      $(this).html("&#43; " + children + " children");
    }
    else {
      if (children >= 1) {
        $(parent).children().eq(1).show();
      }
      $(post).children().show();
      $(this).html("&#8211;");
    }
  });
  $(".navbar-toggle").click(function(){
    var height = $("#header").height() + "px";
    if($(".navbar-items").width() == 0){
      document.getElementById("nav-icon3").classList.add("open");
      document.getElementById("side-nav").style.width = "200px";
      document.getElementById("side-nav").style.top = height;
      document.getElementsByTagName("main")[0].style.opacity = 0.5;
      document.getElementsByTagName("footer")[0].style.opacity = 0.5;
    }
    else{
      document.getElementById("nav-icon3").classList.remove("open");
      document.getElementById("side-nav").style.width = "0";
      document.getElementsByTagName("main")[0].style.opacity = 1;
      document.getElementsByTagName("footer")[0].style.opacity = 1;
    }
  });

});
