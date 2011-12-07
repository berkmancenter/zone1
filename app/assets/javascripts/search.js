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
	$.each(['display_options', 'set_options', 'sort_options'], function(i, v) {
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
		$('.list_options').toggleClass('greyed');
		if($('.list_options').hasClass('greyed')) {
			$('.list_options input').attr('disabled', true);
		} else {
			$('.list_options input').removeAttr('disabled');
		}
		$("#display_options input[type='radio']").attr("checked", false);
		$(this).attr("checked", true);
		return true;
	});
	$('#list').attr('checked', true);

	$("input[type='checkbox'].toggle_column").click(function() {
		var selector = "span." + $(this).data("column-class");
		if($(this).attr("checked")=="checked") {
			$(selector).show();
		} else {
			$(selector).hide();
		}
	});

	$('#download-submit, #bulk-edit-submit').click(function() {
		Zone1.clone_downloadable_checkboxes_to($(this).parent());
		$(this).parent().submit();
		return false;
	});

	$('#bulk-delete-submit').click(function() {
		Zone1.clone_downloadable_checkboxes_to($(this));
		var count = $(this).children("input:checked").length;
		var confirm_delete;
		confirm_delete = confirm("Are you sure you want to delete " + count + " items?");
		if(confirm_delete) {
			$(this).parent().submit();
		} 
		return false;
	});

	$('.quick_edit_link').click(function() {
		$('#response').slideUp();
	});
	$('#close_quick_edit').live("click", function() {
		$('#quick_edit_panel').hide();
	});
	$('#quick_edit').live("click", function() {
		$('#quick_edit_form').slideToggle();
	});
	$('#quick_edit_form .delete').live("click", function() {
		$('#fail_response').slideUp();
		$('<p>').html("Are you sure you want to delete this file?").dialog({
			buttons: [
				{
					text: "Yes",
					click: function() { 
						$('#quick_edit_delete').submit();
						$(this).dialog('close');
					}	
				},
				{
					text: "No",
					click: function() { $(this).dialog('close'); }	
				}
			]
		});
		return false;
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
