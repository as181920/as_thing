
$(document).ready(function() {
  var _this = this;
  return $("#sub_header_right").bind('mouseenter', function(event, ui) {});
});

$(document).ready(function() {
  var _this = this;
  return $(".numero").bind('mouseenter', function(event, ui) {
    return console.log(event.currentTarget.lastElementChild.style.display = "block");
  }).bind('mouseleave', function(event, ui) {
    return console.log(event.currentTarget.lastElementChild.style.display = "none");
  });
});

$(document).ready(function() {
  var _this = this;
  return $("#header").bind('mouseenter', function(event, ui) {
    $(".header_menu").show();
    return $("#header").append($(".header_menu"));
  }).bind('mouseleave', function(event, ui) {
    return $(".header_menu").hide();
  });
});

$(document).ready(function() {
  var _this = this;
  return $("#as_notes").sortable().bind('sortstop', function(event, ui) {
    return $.ajax({
      url: "/as_notes/sort",
      type: "post",
      data: $('#as_notes').sortable('serialize'),
      success: function() {},
      error: function() {
        return $("#header").append("ajax error!");
      }
    });
  });
});

$(document).ready(function() {
  var _this = this;
  return $("#as_labels").sortable().bind('sortstop', function(event, ui) {
    var href, url;
    href = location.href;
    url = href + "/sort";
    return $.ajax({
      url: url,
      type: "post",
      data: $('#as_labels').sortable('serialize'),
      success: function(data, textStatus, jqXHR) {},
      error: function(jqXHR, textStatus, errorThrown) {
        return $("#header").append("ajax error!");
      }
    });
  });
});

$(document).ready(function() {
  var _this = this;
  return $("#s_position").bind('change', function(event, ui) {
    var href, url;
    href = location.href;
    url = href.substring(0, href.length - 4) + "sort_all";
    return $.ajax({
      url: url,
      type: "post",
      data: $('#s_position'),
      success: function(data, textStatus, jqXHR) {},
      error: function(jqXHR, textStatus, errorThrown) {
        return $("#header").append("ajax error!");
      }
    });
  });
});
