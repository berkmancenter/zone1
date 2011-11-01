$(function() {
	$('#list,#thumb').click(function() {
		if($('#results').hasClass($(this).attr('id'))) {
			return false;
		}
		$('.file').css('background', '#FFF');
		$('#quick_edit_panel').hide();
		$('#results').toggleClass('list').toggleClass('thumb');
		return false;
	});
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
	$('#close_quick_edit').click(function() {
		$('.file').css('background', '#FFF');
		$('#quick_edit_panel').hide();
		return false;
	});
	$('.file').click(function() {
		var current_file = $(this);
		var id = current_file.data('id');

		$('.file').css('background', '#FFF');
		$('#full_edit').attr('href', '/stored_files/' + id + '/edit');
		$('#full_show').attr('href', '/stored_files/' + id);
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
		var left_shift = ($('#results').hasClass('thumb') ? 120 : 500);
		$('#quick_edit_panel').css({ top: p.top, left: p.left + left_shift }).show();

		// set onclick for update and delete
		$('#delete').unbind('click').click(function() {
			$.ajax({
				cache: false,
				url: '/stored_files/' + id,
				type: 'DELETE',
				success: function(data) {
					if(data.success) {
						$('.response').html('deleted!');
						current_file.remove();
						$('#quick_edit_panel').hide();
					} else {
						$('.response').html(data.message);
					}
				},
				error: function() {
					$('.response').html('Sorry, you do not have permissions, or fail.');
				}
			});	
		});
		// TODO: Finish updating this, to pass tags, flags, permissions per quick edit
		$('#update').unbind('click').click(function() {
			$('.response').html('Not implemented yet');
			$.ajax({
				cache: false,
				url: '/stored_files/' + id,
				type: 'PUT',
				data: { "stored_file" : {} },
				success: function(data) {
					if(data.success) {
						$('.response').html('updated!');
					} else {
						$('.response').html(data.message);
					}
				},
				error: function() {
					$('.response').html('Sorry, you do not have permissions, or fail.');
				}
			});	
		});
	})
});
