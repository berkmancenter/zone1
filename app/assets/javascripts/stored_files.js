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

	$('.flags input').click(function() {
		var id = $('h1').data('id');
		$.ajax({
			cache: false,
			url: "/stored_files/" + id + "/toggle_method",
			type: "POST",
			data: { method: $(this).val(), checked: $(this).attr('checked') },
			dataType: "JSON",
			success: function(data) {
				alert("Success");
			},
			error: function() {
				alert("Sorry, you do not have permissions to make this change");
			}
		});
	});

	$('.access-level input').click(function() {
		var id = $('h1').data('id');
		$.ajax({
			cache: false,
			url: "/stored_files/" + id + "/toggle_method",
			type: "POST",
			data: { method: $(this).val() },
			dataType: "JSON",
			success: function(data) {
				alert("Success");
			},
			error: function() {
				alert("Sorry, you do not have permissions to make this change");
			}
		});
	});
});
