$(document).ready(function() {	
	var editUrl = document.location.href + '/edit';
	$( ".actions" ).click(function() {
		$.ajax({
			cache: false,
			url: editUrl,
			success: function(html) {
				var node = $('<div></div>').attr('id', 'dialog').html(html);
				node.dialog({
					title:  'Edit File',
					modal:   true,
					width:  400,
					height: 'auto',
					buttons: {
						submit:	function(event, ui) {
							$("#dialog").find("form").ajaxSubmit({
								dataType: "JSON",
								success: function() {
									window.location.reload(true)
								}
							});
						}
					}
				}).dialog('open');		
			}
		});
	});
});
