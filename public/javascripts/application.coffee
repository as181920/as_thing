$(document).ready ->
  $("#sub_header_right")
    .bind 'mouseenter', (event,ui) =>
      #$("#sub_header_right").append "lalala"

$(document).ready ->
  $(".numero")
    .bind 'mouseenter', (event,ui) =>
      console.log event.currentTarget.lastElementChild.style.display = "block"
    .bind 'mouseleave', (event,ui) =>
      console.log event.currentTarget.lastElementChild.style.display = "none"

$(document).ready ->
  $("#header")
    .bind 'mouseenter', (event,ui) =>
      $(".header_menu").show()
      $("#header").append $(".header_menu")
    .bind 'mouseleave', (event,ui) =>
      $(".header_menu").hide()

$(document).ready ->
  $("#as_notes")
    .sortable()
    .bind 'sortstop', (event,ui) =>
      $.ajax
        url: "/as_notes/sort"
        type: "post"
        data: $('#as_notes').sortable('serialize')
        success: ->
          #$("#header").append $('#as_notes').sortable('serialize')
        error: ->
          $("#header").append "ajax error!"

$(document).ready ->
  $("#as_labels")
    .sortable()
    .bind 'sortstop', (event,ui) =>
      href=location.href
      url=href+"/sort"
      $.ajax
        url: url
        type: "post"
        data: $('#as_labels').sortable('serialize')
        success: (data, textStatus, jqXHR) ->
          #$("#header").append $('#as_labels').sortable('serialize')
        error: (jqXHR, textStatus, errorThrown) ->
          $("#header").append "ajax error!"

$(document).ready ->
  $("#s_position")
    .bind 'change', (event, ui) =>
      href=location.href
      url=href.substring(0,href.length-4)+"sort_all"
      $.ajax
        url: url
        type: "post"
        data: $('#s_position')
        success: (data, textStatus, jqXHR) ->
          #$("#header").append $('#s_position')[0].value
        error: (jqXHR, textStatus, errorThrown) ->
          $("#header").append "ajax error!"

#$(document).ready ->
#  $(".mceEditor")
#    .resizable()

