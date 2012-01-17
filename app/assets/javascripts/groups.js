$(function() {
	zone_one_groups.setup_quickview();
});

var zone_one_groups = {
	setup_quickview: function() {
		$('#groups_body #quick_edit_panel .delete').live("click", function() {
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
    $("input[type='checkbox'][readonly='readonly']").live("click", function () {
      // The readonly attribute is designed to prevent modification to the
      // input's value, not it's state.  Clicking a checkbox changes it's state.
      // This prevents that.
      return false;
    });
	}
};
