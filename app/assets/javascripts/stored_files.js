$(document).ready(function() {

	$("#stored_file_original_date").datepicker();

	$('#new-comment').submit(function() {
		$(this).ajaxSubmit({
			dataType: "JSON",
			type: "POST",
			success: function(data) {
				if(data.success) {
					window.location.reload(true);
				} else {
					alert("could not create comment: " + data.message);
				}
			},
			failure: function(data) {
				alert("could not create comment: " + data.message);
			}
		});
		return false;
	});
	
  $('.delete-comment').click(function() {
		$.ajax({
			cache: false,
			url: $(this).attr('href'),
			type: "DELETE",
			dataType: "JSON",
			success: function(data) {
				if(data.success) {
					window.location.reload(true);
				} else {
					alert('could not delete comment: ' + data.message);
				}
			},
			failure: function(data) {
				alert('could not delete comment');
			}
		});
		return false;
	});
});

