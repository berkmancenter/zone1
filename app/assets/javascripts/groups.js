$(function() {
	zone_one_groups.setup_quickview();
});

var zone_one_groups = {
	setup_quickview: function() {
		$('#quick_edit_panel .delete').live("click", function() {
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

			alert('deleted!');
		});
	}
};
