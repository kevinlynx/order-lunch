function show_popupex(pannel, target, manual) {
    var pos = target.position();
    var height = target.outerHeight();
    pannel.css('left', pos.left + 'px');
    pannel.css('top', pos.top + height + 'px');
    pannel.show();
    if (!manual) {
        pannel.mouseleave(function() { pannel.hide(); });
    }
}

function show_popup(pannel_id, target_id, manual) {
    var target = $(target_id);
    var pannel = $(pannel_id);
    show_popupex(pannel, target, manual);
}

function hide_popup(pannel_id) {
    $(pannel_id).hide();
}

