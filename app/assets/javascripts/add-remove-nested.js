$(document).on("change", "#compilation-collection select", function(event) {
  var type = $(this).attr("data-type");
  var collection_id = $("option:selected", this).val();
  console.log("collection_id: " + collection_id)
  $.post("/collections/finishes/" + collection_id + "?type=" + type, function(data){
    console.log($("#compilation-finish"))
    $("#compilation-finish").empty();
    $("#compilation-finish").html(data);
    console.log(data);
  });
});

$(document).on("change", "#compilation-finish select", function(event) {
  var type = $(this).attr("data-type");
  var finish_id = $("option:selected", this).val();

  $.post("/finishes/skus/" + finish_id + "?type=" + type, function(data){
    console.log($("#compilation-skus"))
    $("#compilation-skus").empty();
    $("#compilation-skus").html(data);
    console.log(data);
  });
});

$(document).on("change", "[id^='component']", function(event) {
  console.log($(this).attr("data-parent"))
  if ($(this).attr("data-parent") == 0) {
    if ($(this).is(":checked")) {
      $(this).parent().find("input:checkbox").prop("checked", true);
    } else {
      $(this).parent().find("input:checkbox").prop("checked", false);
    }
  } 
});

$(document).on("click", "a.remove", function(event) {
  var group = $(this).parent().parent().parent();
  var container = $(this).parent().parent();
  var field = container.find("input[type=hidden].destroy");
  field.val("true");
  container.hide();

  console.log("triggering event from remove");
  group.parent().trigger('contentChanged', ["remove", group.parent()]);

  return event.preventDefault();
});

$(document).on("click", ".button", function(event) {
  var a = $("a", $(this));
  var group = $("#" + a.attr("data-container"))
  var container = group.find(" > .addable-group");
  var id = a.attr("data-id");
  var association = a.attr("data-association");
  var content = a.attr("data-content");
  var newId = new Date().getTime();

  console.log("group: " + group.attr("class"))
  console.log("container: " + container.attr("class"))
  console.log("id: " + id)
  console.log("association: " + association)
  console.log("content: " + content);

  var regexp = new RegExp(id, "g");
  console.log("newId: " + newId)
  content = jQuery($.parseHTML(content.replace(regexp, newId)));

  console.log("appending image field to " + container);
  container.append(content);

  console.log("triggering event from add");
  group.trigger('contentChanged', ["add", group]);

  var cloudinaryInput = content.find("input");
  
  //Initializes Cloudinary Input 
  cloudinaryInput.cloudinary_fileupload({replaceFileInput: false});

  return event.preventDefault();
});

$(document).on('contentChanged', '.singular-addable', function(event, toggler, container){
  console.log("bind - catching event; event.toggler: " + toggler);

  if ($(this)[0] == $(container)[0]) {
    var groups = $(this).find(".image-field-group");
    console.log("Groups: " + groups)

    if (toggler == "add") {
      if (groups.length > 0) {
        console.log("Groups length: " + groups.length)
        groups.each(function(index) {
          console.log("Hiding group: " + groups[index])
          $(groups[index]).hide();
        })

        console.log("Showing group[0]")

        $(groups[0]).show();
        $(groups[0]).find("input[type=hidden]").val(false);

        console.log("$(this).parent(): " + $(this).parent())

        $(this).parent().find(".addable").hide();
      }
    } else if (toggler == "remove") {
      // console.log("Removing elements")
      //groups.parent().empty();
      // console.log("Hiding add button")
      $(this).parent().find(".addable").show();
    }
  } else {
    console.log("Elements did not match");
    console.log("$(this)[0]: " + $(this)[0]);
    console.log("$(container)[0]: " + $(container)[0]);
  }
});

