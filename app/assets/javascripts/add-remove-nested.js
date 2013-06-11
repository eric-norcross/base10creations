$(document).on("click", "a.remove", function(event) {
  var group = $(this).parent().parent();
  var field = group.find("input[type=hidden]");
  field.val("1");
  group.hide();

  console.log("triggering event from remove");
  group.parent().trigger('contentChanged', ["remove", group.parent()]);

  return event.preventDefault();
});

$(document).on("click", ".add-fields", function(event) {
  var container = $("#" + $(this).attr("data-container"));
  var id = $(this).attr("data-id");
  var association = $(this).attr("data-association");
  var content = $(this).attr("data-content");
  var newId = new Date().getTime();
  // var regexp = new RegExp("new_" + association, "g");

  var regexp = new RegExp(id, "g");

  // var time = new Date().getTime()
  // regexp = new RegExp($(this).data('id'), 'g')
  // $(this).before($(this).data('fields').replace(regexp, time))

  console.log("newId: " + newId)
  content = content.replace(regexp, newId)

  console.log("appending image field");
  container.append(content);

  console.log("triggering event from add");
  container.trigger('contentChanged', ["add", container]);

  return event.preventDefault();
});

$('.singular-image').on('contentChanged', function(event, toggler, container) {
  console.log("bind - catching event; event.toggler: " + toggler);

  if ($(this)[0] == $(container)[0]) {
    console.log("yep")
    var groups = $(".image-field-group");

    if (toggler == "add") {
      if (groups.length > 0) {
        groups.each(function(index) {
          $(groups[index]).hide();
        })

        $(groups[0]).show();
        $(groups[0]).find("input[type=hidden]").val(false);
        $(this).parent().find(".add-fields").hide();
      }
    } else if (toggler == "remove") {
      $(this).parent().find(".add-fields").show();
    }
  } else {
    console.log("Elements did not match");
  }
});

$(document).ready(function() {
});
