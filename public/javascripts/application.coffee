$(document).ready ->
  $("#as_notes")
    .sortable()
    .bind 'sortstop', (event,ui) =>
      $.ajax
        url: "/as_notes/sort"
        type: "post"
        data: $('#as_notes').sortable('serialize')
        success: (data, textStatus, jqXHR) ->
          #$("#logo_side").append $('#as_notes').sortable('serialize')
        error: (jqXHR, textStatus, errorThrown) ->
          $("#logo_side").append "ajax error!"

$(document).ready ->
  $("#as_labels")
    .sortable()
    .bind 'sortstop', (event,ui) =>
      href=location.href
      url=href.substring(0,href.length-7)+"as_labels/sort"
      $.ajax
        url: url
        type: "post"
        data: $('#as_labels').sortable('serialize')
        success: (data, textStatus, jqXHR) ->
          #$("#logo_side").append $('#as_labels').sortable('serialize')
        error: (jqXHR, textStatus, errorThrown) ->
          $("#logo_side").append "ajax error!"
