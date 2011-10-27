$(function() {
	$('.downloadable').attr('checked', false);
	$('.downloadable').click(function() {
		if($('.downloadable:checked').size() > 0) {
			$('#download-submit').show();
		} else {
			$('#download-submit').hide();
		}
	});
	$('#download-set').submit(function() {
		$('#download-set input:checked').remove();
		$('#download-set').append($('.downloadable:checked').clone());
		return true;
	});
	$('.file').click(function() {
		var current_file = $(this);
		var id = current_file.data('id');

		$('.file').css('background', '#FFF');
		$('#full_edit').attr('href', '/stored_files/' + id + '/edit');
		current_file.css('background', '#d3d3d3');

		//Populate data and fields
		$('#snippet').html(current_file.find('.filename	a').html());
		$.each($('#meta_data span'), function(i, j) {
			$(j).html($(j).attr('id') + ': ' + current_file.find('.' + $(j).attr('id')).html());
		});
		$('#tag_list').val(current_file.find('.tags').html());
		$('#flags input').attr('checked', false);
		$.each(current_file.find('.flags input[checked=checked]'), function(i, j) {
			$('#' + $(j).data('method')).attr('checked', true);
		});

		var p = current_file.position();
		$('#quick_edit_panel').css({ top: p.top, left: p.left + 500 }).show();

		// set onclick for update and delete
		$('#delete').unbind('click').click(function() {
			alert('This will delete stored file ' + id + ' via ajax');
		});
		$('#update').unbind('click').click(function() {
			alert('This will update stored file ' + id);
		});
	})
});
