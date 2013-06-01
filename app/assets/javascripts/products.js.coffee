$(document).on "click", "a.remove-fields", (event) ->
  field = $(this).parent().find("input[type=hidden]")
  console.log field
  field.val "1"
  $(this).parent().parent().hide()

  event.preventDefault()

$(document).ready ->
  $(".add-fields").click (event) ->
    container   = $("#" + $(this).attr("data-container"));
    association = $(this).attr("data-association")
    content     = $(this).attr("data-content");
    newId       = new Date().getTime()
    regexp      = new RegExp("new_" + association, "g")

    container.append(content.replace(regexp, newId))

    event.preventDefault()