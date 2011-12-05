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
		$('.list_options').toggle();
		$("#display_options input[type='radio']").attr("checked", false);
		$(this).attr("checked", true);
		return true;
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
	$("input[type='checkbox'].toggle_column").click(function() {
		var selector = "span." + $(this).data("column-class");
		if($(this).attr("checked")=="checked") {
			$(selector).show();
		} else {
			$(selector).hide();
		}
	});
	$('#open-tabs').submit(function() {
		$('.downloadable:checked').each(function(index) {
			window.open('/stored_files/'+$(this).data('stored-file-id') + '/edit');
		});
		return false;
	});

	$('#download-set').submit(function() {
		Zone1.clone_downloadable_checkboxes_to($(this));
		return true; //submit form
	});
	$('#bulk-edit').submit(function() {
		Zone1.clone_downloadable_checkboxes_to($(this));
		return true; //submit form
	});
	$('#bulk-delete').submit(function() {
		Zone1.clone_downloadable_checkboxes_to($(this));
		var count = $(this).children("input:checked").length;
		var confirm_delete;
		confirm_delete = confirm("Are you sure you want to delete " + count + " items?");
		return confirm_delete;
	});

	$('#close_quick_edit').live("click", function() {
		$('#quick_edit_panel').hide();
	});
});

if(!window.Zone1) {
	//Initializes namespace for functions
	Zone1 = {};
}

Zone1.clone_downloadable_checkboxes_to = function(destination) {
	destination.children("input:checked").remove();
	destination.append($('.downloadable:checked').clone());
	destination.children("input:checked").hide();
};
