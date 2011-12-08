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

 
	$('#search_form').submit(function() {
		if($('#people_value').val() != '') {
			$('#people_value').attr('name', $('#people input[type=radio]:checked').val());
		}
		var date_type = $('input[type=radio]:checked').val();
		if($('#start_date').val() != '') {
			$('#start_date').attr('name', date_type + '_start_date');
		}
		if($('#end_date').val() != '') {
			$('#end_date').attr('name', date_type + '_end_date');
		}

		//Hack: To send only fields with values and minimize
		//crud sent through form
		//Also tried data and data.param, but doesn't work as easily
		//with fields allowing multiple values
		var new_form = $('#search_form').clone();
		if($('#search_form #mime_type').val() != '') {
			var selected_option = $('#search_form #mime_type').children("option:selected");
			if(selected_option.length) {
				$(new_form).append($('<input>').attr('name', selected_option.data("class")).val(selected_option.attr("value")));
			}
		}
		$.each(new_form.find('input'), function(i, v) {
			var field = $(v);
			if(field.attr('name') == 'utf8' || field.attr('type') == 'radio' || field.val() == '') {
				field.remove();
			}
		});
		new_form.submit();
		return false;
	}); 

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
		var bulk_delete = $('#bulk-delete');
		$(bulk_delete).children('input').remove();
		Zone1.clone_downloadable_checkboxes_to(bulk_delete);
		var count = $(bulk_delete).children("input:checked").length;
		$(bulk_delete).append($('<input>').attr('type', 'hidden').attr('name', 'previous_search').val(location.href));
		$('<p>').html("Are you sure you want to delete the " + count + " items?").dialog({
			buttons: [
				{
					text: "Yes",
					click: function() { 
						$(this).dialog('close');
						$(bulk_delete).submit();
						return true;
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

	$('.quick_edit_link').click(function() {
		$('#response').slideUp();
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
