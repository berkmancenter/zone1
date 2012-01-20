$(function() {
	zone_one_single.setup_datepickers();
	zone_one_single.setup_delete_listener();
});

var zone_one_single = {
	setup_datepickers: function() {
		$("#stored_file_original_date").datepicker({
			maxDate: '+0d'
		});
	},
	setup_delete_listener: function() {
		$('#edit_stored_file .delete').click(function() {
			$('#stored_file_delete').submit();
			return false;
		});
	}
};


function toggle_flag_note(checkbox) {
    var checkbox_id = checkbox.id;
    var textarea_id = '#' + checkbox_id.replace('_destroy', '') + 'note';
    if (checkbox.checked) {
        $(textarea_id).slideDown('fast');
    }
    else {
        $(textarea_id).slideUp('fast');
    }
};

