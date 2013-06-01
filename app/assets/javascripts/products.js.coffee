$(document).on "click", "a.remove", (event) ->
  field = $(this).parent().find("input[type=hidden]")
  console.log field
  field.val "1"
  $(this).parent().parent().hide()

  $(this).parent().parent().trigger('contentChanged');

  console.log $(this).parent().parent()

  event.preventDefault()

$(document).ready ->
  $(".add-fields").click (event) ->
    container   = $("#" + $(this).attr("data-container"));
    association = $(this).attr("data-association")
    content     = $(this).attr("data-content");
    newId       = new Date().getTime()
    regexp      = new RegExp("new_" + association, "g")

    container.append(content.replace(regexp, newId))

    container.trigger('contentChanged');

    # if container.find("input[type=file]")
    #   console.log "found"
    # else
    #   console.log "none"

    event.preventDefault()