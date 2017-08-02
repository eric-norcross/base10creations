// $(document).on('fileuploadadd',         function (e, data)  { console.log("fileUploadAdd:"); })
// $(document).on('fileuploadsubmit',      function (e, data)  { console.log("fileUploadSubmit:"); })
// $(document).on('fileuploadsend',        function (e, data)  { console.log("fileUploadSend:"); })
// $(document).on('fileuploaddone',        function (e, data)  { console.log("fileUploadDone:"); })
// $(document).on('fileuploadfail',        function (e, data)  { console.log("fileUploadFail:"); })
// $(document).on('fileuploadalways',      function (e, data)  { console.log("fileUploadAlways:"); })
// $(document).on('fileuploadprogress',    function (e, data)  { console.log("fileUploadProgress:"); })
// $(document).on('fileuploadprogressall', function (e, data)  { console.log("fileUploadProgressAll:"); })
// $(document).on('fileuploadstart',       function (e)        { console.log("fileUploadStart:"); })
// $(document).on('fileuploadstop',        function (e)        { console.log("fileUploadStop:"); })
// $(document).on('fileuploadchange',      function (e, data)  { console.log("fileUploadChange:"); })
// $(document).on('fileuploadpaste',       function (e, data)  { console.log("fileUploadPaste:"); })
// $(document).on('fileuploaddrop',        function (e, data)  { console.log("fileUploadDrop:"); })
// $(document).on('fileuploaddragover',    function (e)        { console.log("fileUploadDragOver:"); })
// $(document).on('fileuploadchunksend',   function (e, data)  { console.log("fileUploadChunkSend:"); })
// $(document).on('fileuploadchunkdone',   function (e, data)  { console.log("fileUploadChunkDone:"); })
// $(document).on('fileuploadchunkfail',   function (e, data)  { console.log("fileUploadChunkFail:"); })
// $(document).on('fileuploadchunkalways', function (e, data)  { console.log("fileUploadChunkAlways:"); });

// ==================================================================
// Cloudinary
// ==================================================================
  var uploadsStarted    = [];
  var uploadsCompleted  = [];

  var cloudinaryUploaderInit = function() {
    // console.log("cloudinaryUploaderInit");
    if ($.fn.cloudinary_fileupload !== undefined) {
      $("input.cloudinary-fileupload[type=file]").each(function() {
        $(this).cloudinary_fileupload();
      });
    } else {
      // console.log("`cloudinary_fileupload` is undefined");
    }

    // Configures new set of nested partials after the user adds a new association
    // This also needs to run after anything is dynamically inserted
    configureCocoonAddLinks(event);
  }

  // File Upload Add
  $(document).on("fileuploadadd", function(event, data) {
    console.log("");
    console.log("------------------------------------------------------");
    console.log("fileuploadadd ~ file upload add");
    // console.log("fileuploadadd ~ event: ", event);
    // console.log("fileuploadadd ~ data: ", data);
    // console.log("fileuploadadd ~ data.result: ", data.result);
    console.log("------------------------------------------------------");
    console.log("");

    uploadsStarted.push(event.target);
    disableSubmitButton();
  })

  // File Upload Fail
  $(document).on("fileuploadfail", function(event, data) {
    console.log("");
    console.log("------------------------------------------------------");
    console.log("fileuploadfail ~ event: ", event);
    console.log("fileuploadfail ~ data: ", data);
    console.log("------------------------------------------------------");
    console.log("");

    alert("An error occurred while attempting to upload the image. Please refresh the page and try again. If this error persists, contact the administrator.");
  })

  // Cloudinary Done
  $(document).on("cloudinarydone", function(event, data) {
    console.log("");
    console.log("------------------------------------------------------");
    console.log("cloudinarydone ~ file upload done");
    console.log("cloudinarydone ~ event: ", event);
    // console.log("cloudinarydone ~ $(event.target): ", $(event.target));
    // console.log("cloudinarydone ~ $(event.target).parent(): ", $(event.target).parent());
    console.log("cloudinarydone ~ data: ", data);
    // console.log("cloudinarydone ~ data.result: ", data.result);
    console.log("------------------------------------------------------");
    console.log("");

    var figure          = $(event.target);
    var figureGroup     = figure.parent().parent().parent().parent().parent().parent();
    var interfaceType   = figureGroup.attr("data-interface-type");

    // var skuSetContainer = figure.parent().parent().parent().parent().parent().parent().parent().parent().parent();


    // Set thumb background and Legend / Title
    var thumbContainer  = $(event.target).parent().parent().parent();
    var title           = $(event.target).parent().parent().find('.title');
    var thumbImage      = $.cloudinary.url(data.result.public_id, { transformation: 'padded_thumb' });

    thumbContainer.css("background-image", "url(" + thumbImage + ")");
    title.removeClass("untouched");

    console.log("");
    console.log("------------------------------------------------------");
    console.log("cloudinarydone ~ thumbContainer: ", thumbContainer);
    console.log("------------------------------------------------------");
    console.log("");

    // Standard From Save
    if (interfaceType === "form") {
      uploadsCompleted.push(event.target);
      enableSubmitButton();
    }

    // Dynamic Save
    else {
      var existingId          = figureGroup.attr("data-id");
      var figureableType      = figureGroup.attr("data-figureable-type");
      var figureableId        = figureGroup.attr("data-figureable-id");
      var imagePath           = data.result.path;
      var imageAsset          = data.result.resource_type + "/" + data.result.type + "/" + imagePath + "#" + data.result.signature;
      // var imageAsset           = data.result.path + "#" + data.result.signature;
      

      console.log("");
      console.log("------------------------------------------------------");
      console.log("cloudinarydone ~ existingId: ", existingId);
      console.log("cloudinarydone ~ figureableType: ", figureableType);
      console.log("cloudinarydone ~ figureableId: ", figureableId);
      console.log("cloudinarydone ~ imageAsset: ", imageAsset);
      console.log("------------------------------------------------------");
      console.log("");

      var method    = "POST";
      var path      = "figures";
      var payload   = { figure: { figureable_type: figureableType, figureable_id: figureableId, image: imageAsset } };

      if (existingId) {
        // Create New Image
        method      = "PUT";
        path       += "/" + existingId;
        payload     = { figure: { id: existingId, image: imageAsset } };
      }
      
      var request   = $.ajax({
                        url:  path,
                        type: method,
                        data: payload
                      });
      
      request.done(function(data, textStatus, jqXHR) {
        console.log("--Success--");
        // console.log("data: ", data);
        // console.log("textStatus: ", textStatus);
        // console.log("jqXHR: ", jqXHR);
        // console.log("jqXHR.status: ", jqXHR.status);
        // console.log("jqXHR.getResponseHeader('response'): ", jqXHR.getResponseHeader('response')); //This is a custom message e.g.: Success!
      
        setFigureProperties(figureGroup, data);

        if (existingId) {
          updateFigureThumb(existingId, "Skus::Sku", thumbImage);
        } else {
          addFigureToContainers(figureGroup, data, "Skus::Sku")
        }
      });
       
      request.fail(function(jqXHR, textStatus, errorThrown) {
        console.log("--Failure--");
        console.log("jqXHR: ", jqXHR);
        console.log("textStatus: ", textStatus);
        console.log("errorThrown: ", errorThrown);
        console.log("jqXHR.status: ", jqXHR.status);
      });
    }
  });

  var disableSubmitButton = function() {
    var submitButton = $("button[type=submit]");

    if (submitButton) {
      var buttonContent = submitButton.find(".button-content");
      
      submitButton.attr("disabled", "disabled");
      submitButton.addClass("disabled");

      buttonContent.attr("data-button-text", buttonContent.text());
      buttonContent.html("Please wait for " + (uploadsStarted.length - uploadsCompleted.length) + " image(s) to finish uploading");
    }
  }

  var enableSubmitButton = function() {
    var submitButton = $("button[type=submit]");

    if (submitButton) {
      var buttonContent = submitButton.find(".button-content");

      if (uploadsStarted.length == uploadsCompleted.length) {

        submitButton.removeAttr('disabled');
        submitButton.removeClass("disabled");
        submitButton.removeClass("disabled");
        
        buttonContent.html(buttonContent.attr("data-button-text"));
      } else {
        buttonContent.html("Please wait for " + (uploadsStarted.length - uploadsCompleted.length) + " image(s) to finish uploading");
      }
    }
  }


// ==================================================================
// Cocoon
// ==================================================================
  // $(document).ready(function() {
  //   $(".add_sub_task a").
  //     data("association-insertion-method", 'append').
  //     data("association-insertion-node", function(link){
  //       return link.closest('.row').next('.row').find('.sub_tasks_form')
  //     });
  // });

  var configureCocoonAddLinks = function(event) {
    console.log("Running: configureCocoonAddLinks()");
    $("a.base10-admin-add-association").each( function() {
      // console.log($(this));
      $(this).data("association-insertion-method", 'append');
      // data("association-insertion-traversal", 'closest').
      $(this).data("association-insertion-node", function(link) {
        // console.log("");
        // console.log("--------------------------------------------------");
        // console.log("$(link): ", $(link));
        // console.log("$(link).parent(): ", $(link).parent());
        // console.log("$(link).parent().parent(): ", $(link).parent().parent());
        // console.log("$(link).parent().parent().first('.container'): ", $(link).parent().first('.container'));
        // console.log("$(link).parent().parent().find('.container'): ", $(link).parent().find('.container'));
        // console.log("$(link).parent().parent().find('.container:first'): ", $(link).parent().parent().find('.container:first'));
        // console.log("--------------------------------------------------");
        // console.log("");

        console.log("");
        console.log("--------------------------------------------------");
        console.log("link: ", link);
        console.log("link.parent(): ", link.parent());
        console.log("link.parent().parent(): ", link.parent().parent());
        console.log("link.parent().parent().first('.container'): ", link.parent().first('.container'));
        console.log("link.parent().parent().find('.container'): ", link.parent().find('.container'));
        console.log("link.parent().parent().find('.container:first'): ", link.parent().parent().find('.container:first'));
        console.log("--------------------------------------------------");
        console.log("");
        
        // .association-groups
        return link.parent().parent().find('.container:first');

        // $(".popContent:first").html()

        // console.log("$(link).parent().parent().first('.container'): ", $(link).parent().first('.container'));
        // return $(link).parent().parent().first('.container');
      });
    });

    // Initialize Cloudinary Uploader after Cocoon insert
    // cloudinaryUploaderInit();
  }

  $(document).on('cocoon:before-insert', function(event, partial) {
    console.log("before-insert event: ", event);
    console.log("before-insert partial: ", partial);
  })

  $(document).on('cocoon:after-insert', function(event, partial) {
    console.log("after-insert event: ", event);
    console.log("before-insert partial: ", partial);

    cloudinaryUploaderInit();
  })




// ==================================================================
// Init
// ==================================================================
  $(document).on('turbolinks:load', function() {

    // Init Cloudinary Fields
    $(function() {
      cloudinaryUploaderInit();
    });

    // configureCocoonAddLinks();
  });
