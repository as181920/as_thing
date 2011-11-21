
$(document).ready(function() {
  var _this = this;
  return $("#as_notes").sortable().bind('sortstop', function(event, ui) {
    return $.ajax({
      url: "/as_notes",
      type: "get",
      success: $("body").append(ui.numericalPosition)
    });
  });
});
