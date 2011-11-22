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
