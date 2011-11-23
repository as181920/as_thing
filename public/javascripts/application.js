
$(document).ready(function() {
  var _this = this;
  return $("#as_notes").sortable().bind('sortstop', function(event, ui) {
    return $.ajax({
      url: "/as_notes/sort",
      type: "post",
      data: $('#as_notes').sortable('serialize'),
      success: function() {},
      error: function() {
        return $("#logo_side").append("ajax error!");
      }
    });
  });
});

$(document).ready(function() {
  var _this = this;
  return $("#as_labels").sortable().bind('sortstop', function(event, ui) {
    var href, url;
    href = location.href;
    url = href.substring(0, href.length - 7) + "as_labels/sort";
    return $.ajax({
      url: url,
      type: "post",
      data: $('#as_labels').sortable('serialize'),
      success: function(data, textStatus, jqXHR) {},
      error: function(jqXHR, textStatus, errorThrown) {
        return $("#logo_side").append("ajax error!");
      }
    });
  });
});

$(document).ready(function() {
  var _this = this;
  return $("#s_position").bind('change', function(event, ui) {
    var href, url;
    href = location.href;
    url = href.substring(0, href.length - 7) + "sort_all";
    return $.ajax({
      url: url,
      type: "post",
      data: $('#s_position'),
      success: function(data, textStatus, jqXHR) {},
      error: function(jqXHR, textStatus, errorThrown) {
        return $("#logo_side").append("ajax error!");
      }
    });
  });
});
