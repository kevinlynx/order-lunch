
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

function numstr(num) {
    return num < 10 ? "0" + num : num;
}

function refresh_time_span(remain) {
    var hour = Math.floor(remain / 60 / 60);
    var min = Math.floor(remain / 60 % 60);
    var sec = Math.floor(remain % 60);
    var desc = numstr(hour) + ":" + numstr(min) + ":" + numstr(sec);
    $('#remain_time').html(desc);
}

function decrease_remain_time(remain) {
    remain --;
    refresh_time_span(remain);
    if (remain > 0) {
        start_count_remain_time(remain);
    }
    else {
        $('#remain_time').closest('form').submit();
    }
}

function start_count_remain_time(remain) {
    setTimeout(function() { decrease_remain_time(remain); }, 1000);
}

