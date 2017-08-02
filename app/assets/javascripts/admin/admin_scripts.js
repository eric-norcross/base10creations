// ==================================================================================================
// Clear Placeholder text on focus
// ==================================================================================================
  $(document).on("focus", "input", function(event) {
    var placeholder = $(this).attr('placeholder');

    // console.log("FOCUS - placeholder: ", placeholder);

    $(this).attr('data-placeholder-text', placeholder);
    // console.log("FOCUS - WTF: ", $(this).attr('data-placeholder-text'));
    $(this).attr('placeholder', "");
  });

  $(document).on("blur", "input", function(event) {
    var placeholder = $(this).attr('data-placeholder-text') || $(this).attr('placeholder');

    // console.log("BLUR - placeholder: ", placeholder);

    $(this).attr('placeholder', placeholder);
  });


// ==================================================================================================
// jQuery Ready
// ==================================================================================================
  $(document).on('turbolinks:load', function() {


  });