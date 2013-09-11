function LiteBox() {
  // console.log("LiteBox - Constructor");

  //PRIVATE VARS
  // var itemsList     = gallery.find("ul"),
  //     btnNext       = gallery.find(".next"),
  //     btnPrevious   = gallery.find(".previous"),
  //     galleryImage  = gallery.find(".gallery-image").find("img"),

  //     items         = itemsList.find("li"),
  //     images        = [],
  //     loadedImages  = [],
  //     params        = {
  //                       offset:             0,
  //                       totalItems:         0, 
  //                       itemWidth:          0,
  //                       totalWidth:         0,
  //                       visibleWidth:       0,
  //                       stopPosition:       0
  //                     };
      
      
  //PUBLIC PROPERTIES
  var public = {
    //PUBLIC VARS
    id:                   null,

    
    //PUBLIC METHODS
    open: function(content, contentWidth, contentHeight) {
      console.log("LiteBox - open()");
      $("body").append('<div class="overlay"></div><div class="container"></div>');

      var overlayWidth = $(window).width();
      var overlayHeight = $(window).height();

      if ($(document).width() > $(window).width()) {
        overlayWidth = $(document).width();
      }

      if ($(document).height() > $(window).height()) {
        overlayHeight = $(document).height();
      }

      $(".overlay").click(this.close);
      $(".overlay").css({"width":overlayWidth, "height":overlayHeight});
        //.css({"overflow-y":"hidden"});

      //animate the semitransparant layer
      $(".overlay").animate({"opacity":"0.8"}, 400, "linear");

      //add the litebox image to the DOM
      $(".container").append(content);

      $(".container").css({
        "top":          "50%",
        "left":         "50%",        
        "width":        contentWidth,
        "height":       contentHeight,
        "margin-top":   - (contentHeight / 2),
        "margin-left":  - (contentWidth / 2) //to position it in the middle
      })
      //position it correctly after downloading
      $(".container").animate({"opacity":"1"}, 400, "linear");
      /*
      Add back/next functionality
      */
      // btnNext.click(params, next);
      // btnPrevious.click(params, previous);
    }, 

    close: function() {
      $(".container, .overlay").animate({"opacity":"0"}, 200, "linear", function(){
        $(".container, .overlay").remove(); 
      });
    }
  }

  //PRIVATE METHODS
  var configure = function() {
    console.log("LiteBox - loadCompleteHandler()");
  }

  var next = function(params) {
    console.log("LiteBox - next()");
    return false;
  }

  var previous = function(params) {
    console.log("LiteBox - previous()");
    return false;
  }

  //RETURN PUBLIC PROPERTIES
  return public;
}