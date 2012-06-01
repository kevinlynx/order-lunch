
function deleteFoods(e) {
    if (!confirm('are you sure?')) return ;
    $(e).closest('form').submit();
}

function orderOne(e) {
    // TODO:
}

function setTableHover(t, hover_fn) {
  $(t + " tbody tr")
      .mouseover(function() { $(this).addClass("hover"); if (hover_fn) hover_fn();})
      .mouseout(function() { $(this).removeClass("hover"); })
}

$(document).ready(function() {
    setTableHover("table");
});
