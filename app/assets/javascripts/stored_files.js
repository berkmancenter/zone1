$(function() {
	zone_one_single.setup_datepickers();
	zone_one_single.setup_delete_listener();
	zone_one_single.setup_comment_delete_listener();
	zone_one_single.setup_toggle_flag_note_listener();
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
	},
    setup_comment_delete_listener: function() {
        $(document).on('ajax:success', '.delete-comment', function() {
            $(this).parent().slideUp();
        });
    },
    setup_toggle_flag_note_listener: function() {
      $(".flagging input:checked").siblings("textarea").show();
      $('.flagging .flag').click( function() {
            zone_one_single.toggle_flag_note(this);
        }); 
    },
    toggle_flag_note: function(checkbox) {
        var textarea_id = '#' + checkbox.id.replace('_destroy', '') + 'note';
        if (checkbox.checked) {
            $(textarea_id).slideDown('fast');
        }
        else {
            $(textarea_id).slideUp('fast');
        }
    }
};



