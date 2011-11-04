$(function() {
        $("#created_at_start_date").datepicker();
        $("#created_at_end_date").datepicker();
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
	$('#close_quick_edit').live("click", function() {
		$('.file').css('background', '#FFF');
		$('#quick_edit_panel').hide();
		//return false;
	});
	$('.file').click(function() {
	  //Reset state
	  $("#quick_edit_panel").hide();
	  $('.file').css('background', '#FFF');

	  //Select file and highlight
	  var current_file = $(this);
	  current_file.css('background', '#d3d3d3');

	  //Position quick pannel, the ajax call will show it
  	  var p = current_file.position();
	  var left_shift = ($('#results').hasClass('thumb') ? 120 : 500);
	  $('#quick_edit_panel').css({ top: p.top, left: p.left + left_shift });
	});
});
