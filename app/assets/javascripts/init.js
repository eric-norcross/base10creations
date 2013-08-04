$(document).ready(function(){
  $("a.print").click(function(event) {
    window.print();
  });
  
  $(".gallery").each(function(index) {
    var gallery = new Gallery($(this));
    gallery.init();
  });

  $('.carousel').carousel({
    interval: 3000
  });
  
  $('.clear-input').focus(function(){
    if ($(this).val() == $(this).attr("data-message")) {
      $(this).val("");
    }
  });

  $('.clear-input').blur(function(){
    if ($(this).val() == ""){
      $(this).val($(this).attr("data-message"));
    }
  });

  $('.cloudinary-fileupload').fileupload('option', 'replaceFileInput', false);
});