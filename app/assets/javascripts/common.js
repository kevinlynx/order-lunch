function markAll(check) {
    var form = check.form
	for (var i=0; i < form.elements.length; i++) {
		var e = form.elements[i];
		if (e.name != check.name)
            e.checked = check.checked;
	}
}
