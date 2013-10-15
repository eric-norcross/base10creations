var uploadsStarted = [];
var uploadsCompleted = [];
var timer;

// $(document).on("click", ".share", function(event) {
//   if ($(this).attr("data-link")) {
//     console.log($(this).attr("data-link"))
//     window.open('https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(location.href), 
//       'facebook-share-dialog', 
//       'width=626,height=436');
//   }

//   return event.preventDefault(); 
// })

$(document).on("mouseenter", ".tooltip", function(event) {
  //console.log("TT enter")

  if (timer) {
    timer.stop();
  }
});

$(document).on("mouseleave", ".tooltip", function(event) {
  //console.log("TT leave")

  timer = $.timer(function() {
    //console.log('This message was sent by a timer.');
    $('.tt').tooltip('hide');
  });

  timer.set({ time : 3000, autostart : true });
});

// Fallback for placeholder attribute
$(document).on("focus", ".clear-input", function(event) {
  if (!("placeholder" in document.createElement("input"))) {
    if ($(this).val() == $(this).attr("placeholder")) {
      $(this).val("");
    }
  }
});

// Fallback for placeholder attribute
$(document).on("blur", ".clear-input", function(event) {
  if (!("placeholder" in document.createElement("input"))) {
    if ($(this).val() == ""){
      $(this).val($(this).attr("placeholder"));
    }
  }
});

// Toggle Compilation images
$(document).on("click", ".toggle-image", function(event) {
  var image = $(this);
  var id = image.attr("data-id");
  var active = false;

  if (image.hasClass("disabled")) {
    active = true;
  }

  $.ajax({
    type: "POST",
    dataType: "script",
    url: '/images/set_active/' + id,
    contentType: 'application/json',
    data: JSON.stringify({ image:{active:active}, _method:'post' })
  }).done(function(msg) {
    console.log("Set");
    console.log("Image: " + jQuery(image).attr("class"))
    console.log("Active: " + active);

    if (active) {
      image.removeClass("disabled");
    } else {
      image.addClass("disabled");
    }
  });
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
    return event.preventDefault();
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

  //Sets input value to placeholder text when placeholder isn't supported
  if (!("placeholder" in document.createElement("input"))) {
    $(":input").each(function(index, element) {
      if (!$(this).val() && $(this).attr("placeholder")) {
        $(this).val($(this).attr("placeholder"));
      }
    });
  }

  $('.tt').tooltip({    
    //selector: "a[rel=tooltip]"
    html: true,
    placement: "bottom",
    trigger: "click", 
    animation: true
  })

  $('.tt').click(function(event) {
    return event.preventDefault();
  })



  // $(function() {  
  //   $("textarea[maxlength]").bind('input propertychange', function() {  
  //     var maxLength = $(this).attr('maxlength');  
  //     if ($(this).val().length > maxLength) {  
  //       $(this).val($(this).val().substring(0, maxLength));  
  //     }  
  //   })  
  // });
});