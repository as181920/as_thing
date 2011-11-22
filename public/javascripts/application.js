
$(document).ready(function() {
  var _this = this;
  return $("#as_notes").sortable().bind('sortstop', function(event, ui) {
    return $.ajax({
      url: "/as_notes/sort",
      type: "post",
      data: $('#as_notes').sortable('serialize'),
      success: function(data, textStatus, jqXHR) {},
      error: function(jqXHR, textStatus, errorThrown) {
        return $("#logo_side").append("ajax error!");
      }
    });
  });
});
