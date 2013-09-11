var uploadsStarted = [];
var uploadsCompleted = [];

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
  $('.gallery-image').zoom({url: $('.gallery-image').find("img").attr("data-full")});
  
  $(".enlarge").click(function(event) {
    if (!litebox) {
      var litebox = new LiteBox();

      var src = $(this).find("a").attr("href");
      var content = "<img src=" + src + ">"
      var contentWidth,
          contentHeight;

      var image = $('<img />');
      image.attr('src', src);

      image.load(function() {
        contentWidth = this.width;
        contentHeight = this.height;

        litebox.open(content, contentWidth, contentHeight);
      })
    }

    return event.preventDefault();
  });

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

  uploadsStarted = [];
  uploadsCompleted = [];

  // $(function() {  
  //   $("textarea[maxlength]").bind('input propertychange', function() {  
  //     var maxLength = $(this).attr('maxlength');  
  //     if ($(this).val().length > maxLength) {  
  //       $(this).val($(this).val().substring(0, maxLength));  
  //     }  
  //   })  
  // });
});