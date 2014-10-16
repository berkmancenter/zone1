$(function() {
	zone_one_groups.setup_quickview();
});

var zone_one_groups = {
	setup_quickview: function() {
		$(document).on('click', '#groups_body #quick_edit_panel .delete', function() {
			$('#fail_response').slideUp();
			$('<p>').html("Are you sure you want to delete this group?").dialog({
				buttons: [
					{   
						text: "Yes",
						click: function() { 
							$('#quick_edit_delete').submit();
							$(this).dialog('close');
						}   
					},  
					{   
						text: "No",
						click: function() { $(this).dialog('close'); }
					}   
				]   
			}); 
			return false;
		});
        $(document).on('click', "input[type='checkbox'][readonly='readonly']", function () {
          // The readonly attribute is designed to prevent modification to the
          // input's value, not its state.  Clicking a checkbox changes its state.
          // This prevents that.
          return false;
        });
        $(document).on('ajax:success', '.resend_invite', function() {
            var span = $(this).parent().addClass('re-sent').html('(Invite Re-sent)');
        });
	}
};
