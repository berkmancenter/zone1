$(document).ready(function() {	
	var editUrl = document.location.href + '/edit';
	$( ".actions" ).click(function() {
		$.ajax({
			cache: false,
			url: editUrl,
			success: function(html) {
				$( "#dialog" ).html(html);
				$( "#dialog" ).dialog({
					title:  'Edit File',
					modal:   true,
					width:  400,
					height: 'auto',
					buttons: {
						submit:	function(event, ui) {
							$("#dialog").find("form").ajaxSubmit({
								dataType: "JSON",
								success: window.location.reload(true)
							});
						}
					}
				}).dialog('open');		
			}
		});
	});
});
