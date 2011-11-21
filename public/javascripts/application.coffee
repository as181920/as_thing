$(document).ready ->
  $("#as_notes")
    .sortable()
    .bind 'sortstop', (event,ui) =>
      $.ajax
        url: "/as_notes"
        type: "get"
        success: $("body").append ui.numericalPosition
        #success: $("body").append $('#as_notes').sortable('serialize')
# add flash message when successed or failed




#$(function(){
#  $( "#as_notes" ).sortable({
#    stop: function(event, ui) { 
#      /*
#      $.ajax({
#        url: "/as_notes",
#        type: "get",
#        data: $('#as_notes').sortable('serialize'),
#        dataType: 'script',
#        complete: function(request){
#            $('#as_notes').effect('highlight');
#          }
#        })
#        */
#      }
#    });
#});
