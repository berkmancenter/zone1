$(function() {
	//Accordion Functionality
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

	//UI
	$.each(['display_options', 'set_options'], function(i, v) {
		$('#show_' + v).click(function() {
			$(this).parent().toggleClass('displayed');
			$('#' + v).toggle();
		});
	});

	//Calendar Datepicker	
	$("#dates input[type=text]").datepicker();

	//Toggle between list and thumb
	$('#list,#grid').click(function() {
		if($('#results').hasClass($(this).attr('id'))) {
			return false;
		}
		$('#results').toggleClass('list').toggleClass('grid');
		$('.displayed').removeClass('displayed');
		$('#display_options').hide();
		return false;
	});

	//Set options
/*
	$('.downloadable').attr('checked', false);
	$('.downloadable').click(function() {
		if($('.downloadable:checked').size() > 1) {
			$('#bulk-edit-submit,#download-submit').show();
		} else {
			$('#bulk-edit-submit,#download-submit').hide();
		}
	});
*/

	$('#download-set').submit(function() {
		Zone1.clone_downloadable_checkboxes_to($(this));
	});
	$('#bulk-edit').submit(function() {
		Zone1.clone_downloadable_checkboxes_to($(this));
	});
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
