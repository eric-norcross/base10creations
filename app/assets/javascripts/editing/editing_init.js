var uploadsStarted = [];
var uploadsCompleted = [];

$(document).on("fileuploadadd", function(event) {
  var submitButton = $("input[type=submit]");

  uploadsStarted.push(event.target);

  submitButton.attr("disabled", "disabled");
  submitButton.addClass("disabled")
  submitButton.attr("value", ("Plase wait for " + (uploadsStarted.length - uploadsCompleted.length) + " image(s) to finish uploading."));
})

$(document).on("fileuploaddone", function(event) {
  var submitButton = $("input[type=submit]");
  uploadsCompleted.push(event.target);

  if (uploadsStarted.length == uploadsCompleted.length) {
    submitButton.removeAttr('disabled');
    submitButton.removeClass("disabled");
    submitButton.attr("value", "Save");
  } else {
    submitButton.attr("value", ("Plase wait for " + (uploadsStarted.length - uploadsCompleted.length) + " image(s) to finish uploading."));
  }
})


$(document).ready(function(){
  $('.cloudinary-fileupload').fileupload('option', 'replaceFileInput', false);

  uploadsStarted = [];
  uploadsCompleted = [];
});