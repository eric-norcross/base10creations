$(document).on("click", "a.remove", function(event) {
  var group = $(this).parent().parent().parent();
  var container = $(this).parent().parent();
  var field = group.find("input[type=hidden]");
  field.val("1");
  container.hide();

  console.log("triggering event from remove");
  group.parent().trigger('contentChanged', ["remove", group.parent()]);

  return event.preventDefault();
});

$(document).on("click", ".add-fields", function(event) {
  var group = $("#" + $(this).attr("data-container"))
  var container = group.find(" > .addable-group");
  var id = $(this).attr("data-id");
  var association = $(this).attr("data-association");
  var content = $(this).attr("data-content");
  var newId = new Date().getTime();

  console.log("group: " + group.attr("class"))
  console.log("container: " + container.attr("class"))
  console.log("id: " + id)
  console.log("association: " + association)
  console.log("content: " + content);
  //console.log("newId: " + newId)

  var regexp = new RegExp(id, "g");

  // var time = new Date().getTime()
  // regexp = new RegExp($(this).data('id'), 'g')
  // $(this).before($(this).data('fields').replace(regexp, time))

  console.log("newId: " + newId)
  content = content.replace(regexp, newId)

  console.log("appending image field to " + container);
  container.append(content);

  console.log(group)

  console.log("triggering event from add");
  group.trigger('contentChanged', ["add", group]);

  return event.preventDefault();
});

$(document).on('contentChanged', '.singular-addable', function(event, toggler, container){
  console.log("bind - catching event; event.toggler: " + toggler);

  if ($(this)[0] == $(container)[0]) {
    var groups = $(this).find(".image-field-group");
    console.log("Groups: " + groups)

    if (toggler == "add") {
      //console.log("Showing add button")


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


$(document).ready(function() {
  // console.log($('#product-collection select'));

  // $('#product-collection select').on('change', function() {
  //   console.log("test")
  //   // make a POST call and replace the content
  //   var collection_id = $("option:selected", this).val() || 0;

  //   //if (collection_id == "") { collection_id = "0" };

  //   //$.post('/components/get_components', {id: that.val()}, null, "script");
  //   $.post('/components/get_components/' + collection_id, function(data){
  //     //$("#cities").html(data);
  //     console.log(data);
  //   })
  //   return false;
  // });
});

