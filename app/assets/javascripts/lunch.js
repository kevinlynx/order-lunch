
function deleteFoods(e) {
    if (!confirm('are you sure?')) return ;
    $(e).closest('form').submit();
}

function orderOne(e) {
    // TODO:
}

function setTableHover(t) {
  $(t + " tbody tr")
      .mouseover(function() { $(this).addClass("hover"); })
      .mouseout(function() { $(this).removeClass("hover"); })
}

