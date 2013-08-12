var imageUploads;
var uploadsComplete;

$(document).on("focus", ".clear-input", function(event) {
  if ($(this).val() == $(this).attr("data-message")) {
    $(this).val("");
  }
});

$(document).on("blur", ".clear-input", function(event) {
  if ($(this).val() == ""){
    $(this).val($(this).attr("data-message"));
  }
});

$(document).on("fileuploadadd", function(event) {
  var submitButton = $("input[type=submit]");
  submitButton.attr("disabled", "disabled");
  submitButton.addClass("disabled")
  submitButton.attr("value", "Please wait for image(s) to finish uploading.");

  // submitButton.css({ 'opacity' : 0.5 });
  console.log(submitButton)
  console.log(imageUploads.length)
  imageUploads.push(event.target)
  console.log("Added file to " + event.target)
})

$(document).on("fileuploaddone", function(event) {
  var submitButton = $("input[type=submit]");
  submitButton.removeAttr('disabled');
  submitButton.removeClass("disabled")
  submitButton.attr("value", "Save");

  uploadsComplete.push(event.target)
  if (imageUploads.length == uploadsComplete.length) {
    console.log("Ok to save!")
  }
})

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

  $('.cloudinary-fileupload').fileupload('option', 'replaceFileInput', false);

  imageUploads = [];
  uploadsComplete = [];
});