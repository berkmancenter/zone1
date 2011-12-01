$(function() {
	$('#accordion').accordion({
		collapsible: true,
		changestart: function(event, ui) {
			$('#accordion .ui-accordion-content').slideUp();
			$('#accordion h3').removeClass('ui-state-active').removeClass('ui-state-focus');
			ui.newContent.slideDown();
		}
	});
    $('#expand a').click(function() {
		if($(this).hasClass('expanded')) {
			$('#accordion .ui-accordion-content').slideUp();
			$('#accordion h3').removeClass('ui-state-active').removeClass('ui-state-focus');
			$(this).removeClass('expanded').html('Expand All');
		} else {
			$('#accordion .ui-accordion-content').slideDown();
			$('#accordion h3').addClass('ui-state-active').addClass('ui-state-focus');
			$(this).addClass('expanded').html('Collapse All');
		}
	});

	$('#show_display_options').click(function() {
		$('#display_options').toggle();
	});
	$('#show_set_options').click(function() {
		$('#set_options').toggle();
	});
	
	$("#created_at_start_date, #created_at_end_date").datepicker();

	$('#list,#thumb').click(function() {
		if($('#results').hasClass($(this).attr('id'))) {
			return false;
		}
		$('#quick_edit_panel').hide();
		$('#results').toggleClass('list').toggleClass('thumb');
		$('#display_options').hide();
		return false;
	});

	$('.downloadable').attr('checked', false);
	$('.downloadable').click(function() {
		if($('.downloadable:checked').size() > 1) {
			$('#download-submit').show();
						$('#bulk-edit-submit').show();
		} else {
			$('#download-submit').hide();
						$('#bulk-edit-submit').hide();
		}
	});

	$('#download-set').submit(function() {
		Zone1.clone_downloadable_checkboxes_to($(this));
	});
	$('#bulk-edit').submit(function() {
		Zone1.clone_downloadable_checkboxes_to($(this));
	});

	$('#people form').submit(function() {
/*
		if($('#people input[type=radio]:checked').length) {
			$('#people form input').attr('name', $('#people input[type=radio]:checked'));
		} else {
			$('#people form input').attr('name', 'author');
		} */
		return true;
	});

	$('#close_quick_edit').live("click", function() {
		$('.file').css('background', '#FFF');
		$('#quick_edit_panel').hide();
		//return false;
	});

/*
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
*/
});

if(!window.Zone1) {
  //Initializes namespace for functions
  Zone1 = {};
}

Zone1.clone_downloadable_checkboxes_to = function(destination) {
  destination.children("input:checked").remove();
  destination.append($('.downloadable:checked').clone());
  return true;
};
