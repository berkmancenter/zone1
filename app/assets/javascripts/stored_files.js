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
					width:  650,
					height: 'auto',
					buttons: {
						Update: function(event, ui) {
							$("#dialog").find("form").ajaxSubmit({
								dataType: "JSON",
								type: "POST",
								data: { "stored_file[delete_flag]": 0 },
								success: function() {
									window.location.reload(true)
								}
							});
						},
						Delete: function(event, ui) {
							$("#dialog").find("form").ajaxSubmit({
								dataType: "JSON",
								type: "POST",
								data: { "stored_file[delete_flag]": 1 },
								success: function() {
									document.location = '/search' 
								}
							});
						}
					}
				}).dialog('open');
			}
		});
	});

/*
	$('#edit_stored_file .flags input').click(function() {
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

	$('#edit_stored_file .access-level input').click(function() {
		var id = $('h1').data('id');
		$.ajax({
			cache: false,
			url: "/stored_files/" + id + "/toggle_method",
			type: "POST",
			data: { method: $(this).data('method') },
			dataType: "JSON",
			success: function(data) {
				alert("Success");
			},
			error: function() {
				alert("Sorry, you do not have permissions to make this change");
			}
		});
	});
*/
});

