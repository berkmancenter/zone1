$(function() {
	zone_one_base.setup_accordion();
	zone_one_base.setup_listgrid();
	zone_one_base.setup_quickview();
	zone_one_base.setup_search();
	zone_one_base.setup_menu_actions();
	zone_one_base.setup_datepickers();
	zone_one_base.setup_username();
});

var zone_one_base = {
	setup_username: function() {
		$('#userlinks').hover(function() {
			$('#userlinks').addClass('hovered');
		}, function() {
			$('#userlinks').removeClass('hovered');
		});
	},
	setup_accordion: function() {
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
				$(this).removeClass('expanded').html('Expand All<span></span>');
			} else {
				$('#accordion .ui-accordion-content').slideDown();
				$('#accordion h3').addClass('ui-state-active').addClass('ui-state-focus');
				$(this).addClass('expanded').html('Collapse All<span></span>');
			}
		});
	},
	setup_listgrid: function() {
		//Toggle between list and thumb
		$('#list,#grid').click(function() {
			$.cookie("list_grid", $(this).attr('id'), { path: "/" });
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
		if($.cookie("list_grid")) {
			$('#' + $.cookie('list_grid')).click();
		} else {
			$('#list').attr('checked', true);
		}
	},
	setup_quickview: function() {
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
	},
	setup_search: function() {
		$('#tips').click(function() {
			$('#search_tips').dialog({ resizable: false });
		});
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

			//Form must be appended to doc in order to submit in FF
			new_form.hide();
			$('body').prepend(new_form);
			new_form.submit();
			return false;
		});
	}, 
	setup_menu_actions: function() {
		//UI
		$.each(['display_options', 'set_options', 'sort_options'], function(i, v) {
			$('#show_' + v).click(function() {
				var par = $(this).parent();
				$('.displayed').not(par).removeClass('displayed');
				par.toggleClass('displayed');
			});
		});
		$("input[type='checkbox'].toggle_column").click(function() {
			var selector = "span." + $(this).data("column-class");
			if($(this).attr("checked")=="checked") {
				$(selector).show();
			} else {
				$(selector).hide();
			}
		});
	},
	setup_datepickers: function() {
		//Calendar Datepicker	
		$("#dates input[type=text]").datepicker({
			beforeShow: zone_one_base.custom_range
		});
	},
	custom_range: function(input) {
		if (input.id == 'end_date') {
			return {
				minDate: jQuery('#start_date').datepicker("getDate"),
				maxDate: '+0d'
			};
		} else if (input.id == 'start_date') {
			if(jQuery('#end_date').datepicker("getDate")) {
				return {
						maxDate: jQuery('#end_date').datepicker("getDate")
				};
			} else {
				return {
						maxDate: '+0d'
				};
			}
		}
	},
	close_quickview: function(message) {
		$('#response').slideUp();
		if(message != "") {
			$('#response').html(message).slideDown();
		}
		$('#quick_edit_panel').parent().remove();
		$('#quick_edit_panel').remove();
	}
};
