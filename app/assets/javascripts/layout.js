$(function() {
	zone_one_base.setup_accordion();
	zone_one_base.setup_listgrid();
	zone_one_base.setup_quickview();
	zone_one_base.setup_search();
	zone_one_base.setup_menu_actions();
	zone_one_base.setup_datepickers();
	zone_one_base.setup_username();
	zone_one_base.setup_admin_username();
	zone_one_base.setup_watermarks();
  zone_one_base.setup_dropdown();
  zone_one_base.setup_message();
});

(function($){
	//Usage: $('#your-form-id').serializeJSON(); 
	$.fn.serializeJSON = function() {
		var json = {};
		jQuery.map($(this).serializeArray(), function(n, i){
			json[n['name']] = n['value'];
		});
		return json;
	};
})( jQuery );

var zone_one_base = {
  setup_message: function() {
    if($("#message").html() != "") {
      $("#message").slideDown().delay(5000).slideUp().html();
    }
  },
  setup_watermarks: function() {
		$("#people_value").watermark("Enter name");
	},
	setup_username: function() {
		$('#userlinks').hover(function() {
			$(this).addClass('hovered');
		}, function() {
			$(this).removeClass('hovered');
		});
		$("#import-csv").click(function(e){
			e.preventDefault();
			zone_one_base.display_import_csv_dialog();
		});

	},
	setup_admin_username: function() {
		$('#adminlinks').hover(function() {
			$(this).addClass('hovered');
		}, function() {
			$(this).removeClass('hovered');
		});
	},
	setup_accordion: function() {
		$('#accordion .acc_header').click(function() {
			if(!$(this).hasClass('active')) {
				$('.acc_header').removeClass('active');
				$('.acc_content').slideUp();
				$(this).addClass('active');
				$(this).next('.acc_content').slideDown();
			}
			return false;
		});
		$('#expand a').click(function() {
			if($(this).hasClass('expanded')) {
				$('.acc_header').removeClass('active');
				$('.acc_content').slideUp();
				$(this).removeClass('expanded').html('Expand All<span></span>');
			} else {
				$('.acc_header').addClass('active');
				$('.acc_content').slideDown();
				$(this).addClass('expanded').html('Collapse All<span></span>');
			}
		});
	},
	setup_listgrid: function() {
   		$('#list_view').click( function() { $('#list').click(); } );
   		$('#grid_view').click( function() { $('#grid').click(); } );
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
			return false;
		});
		$('.close-quickview').live("click", function() {
			zone_one_base.close_quickview("");
		});
		$('#quick_edit_form .delete').live("click", function() {
			$('#fail_response').slideUp();
			$('<p>').html("Are you sure you want to delete this file?").dialog({
				modal: true,
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
  setup_dropdown: function() {
    var timeout;
    $('.dropdown').mouseout(function() {
      var element = $(this);
      timeout = setTimeout(function(){ 
        element.parent('li').removeClass('displayed');
      }, 250 );
    });
    $('.dropdown').mouseover(function() {
      clearTimeout(timeout);
    });
  },
	setup_search: function() {
		$('#tips').click(function() {
			$('#search_tips').dialog({
				buttons: [
					{
						text: "Close",
						click: function() { $(this).dialog('close'); }	
					}
				]
			});
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

			//Hack: To send only fields with values and minimize unnecessary fields sent 
			//through form. Also tried data and data.param, but doesn't work as easily
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
	reset_column_widths: function() {
		//When visible columns are toggled, their widths are
		//adjusted to fit across the top, with some larger than others,
		//based on their pad data attribute
		var visible = $('#files .menu span:visible');
		var visible_count = visible.size();
		var padding_extra = 0;
		$.each(visible, function(i, j) {
			padding_extra += $(j).data('pad');
		});
		padding_extra += visible_count*8;
		var base_width = (660-padding_extra)/visible_count;
		$.each(visible, function(i, j) {
			var new_width = base_width + $(j).data('pad');
			$('.file span.' + $(j).data('type')).width(new_width);
			$(j).resizable('option', 'maxWidth', $(j).width());
		});
	},
	search_result_column: function(column_name) {
		// Helper function to find the search column consistently
		// across different functions.
		return $("div#files span." + column_name).toggle();
	},
	toggle_header_dropdown: function(menudiv) {
		var par = $(menudiv).parent();
		$('.displayed').not(par).removeClass('displayed');
		par.toggleClass('displayed');
	},
	setup_menu_actions: function() {
		//UI
		$.each(['display_options', 'set_options', 'sort_options'], function(i, v) {
			$('#show_' + v).click(function(e) {
				e.preventDefault();
				zone_one_base.toggle_header_dropdown(this);
			});
		});
		$("div.list_options input:checkbox.toggle_column").click(function() {
			var column_name = $(this).data("column-class");
			if($(this).attr("checked")=="checked") {
				zone_one_base.search_result_column(column_name).show();
				// checked column = clear cookie
				$.cookie("toggle_column_" + column_name, null);
				zone_one_base.reset_column_widths();
			} else {
				zone_one_base.search_result_column(column_name).hide();
				//record checkbox ids which need to be unchecked
				$.cookie("toggle_column_" + column_name, $(this).attr('id'), { path: "/" });
				zone_one_base.reset_column_widths();
			}
		});
		$.each(['filename', 'size', 'date', 'tags', 'flags', 'author', 'license', 'batch'], function(i, v) {
			$('#files .menu span.' + v).resizable({
				alsoResize: '.file span.' + v,
				handles: 'e',
				containment: 'parent',
				minWidth: 60,
				start: function(event, ui) {
					//After any item is resized, all other resizable item 
					//maxWidths are reset to prevent wrapping of columns
					var visible = $('#files .menu span:visible');
					var total_width = 0;
					$.each(visible, function(a, b) {
						total_width += $(b).width();
					});
					var adjust_width = 1200 - total_width - visible.size()*8;
					$.each(visible, function(a, b) {
						$(b).resizable('option', 'maxWidth', $(b).width() + adjust_width);
					});
				}		
			});
		});

		// Show all columns by default
		// Loop through all columns, use name to check cookies
		// If cookie is present, uncheck box, hide column
		$("div.list_options input:checkbox.toggle_column").each(function () {
			var column_name = $(this).data("column-class");
			if($.cookie("toggle_column_" + column_name)) {
				//cookie exists = hide column
				$(this).attr('checked', null)
				zone_one_base.search_result_column(column_name).hide();
			}
			zone_one_base.reset_column_widths();
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
				minDate: $('#start_date').datepicker("getDate"),
				maxDate: '+0d'
			};
		} else if (input.id == 'start_date') {
			if($('#end_date').datepicker("getDate")) {
				return {
					maxDate: $('#end_date').datepicker("getDate")
				};
			} else {
				return {
					maxDate: '+0d'
				};
			}
		}
	},
	close_quickview: function(message) {
		if(message != "") {
			$('#message').html(message).slideDown().delay(5000).slideUp();
		}
		$('#quick_edit_panel').parent().remove();
		$('#quick_edit_panel').remove();
	},
	display_import_csv_dialog: function() {
		$("#import-csv-dialog").dialog({
			modal: true,
			width: 'auto',
			dialogClass: 'import-csv-dialog',
			title: 'CSV Edit Import',
			buttons: [
				{
					text: "Close",
					click: function() { $(this).dialog('close'); }
				}
			]
		});
		zone_one_base.init_csv_edit_uploader();
	},
	get_uploader: function() {
		// This method is implemented in multiple namespaces for other uploaders as well
		var uploader = $('#csv_edit_uploader').plupload('getUploader');
		return uploader.state == undefined ? undefined : uploader;
	},
	init_csv_edit_uploader: function() {
		// You could use $("#csv_edit_uploader").plupload('notify', 'error', 'lol') if .plupload_header was displayed.
		//zone_one_base.reset_ui_labels();
		
		var uploader = zone_one_base.get_uploader();
		if (uploader) {
			// Reset existing csv edit upload widget and return 
			uploader.splice();
			//uploader.reset_ui_labels();
			return;
		}

		uploader = $('#csv_edit_uploader').plupload({
			runtimes : 'html5,html4', //flash does not play nicely with sessions in Rails
			buttons : { stop: false },
			url : $('#csv-edit-upload').attr('action'),
			multipart_params: $('#csv-edit-upload').serializeJSON(),
			multiple_queues : true,
			filters : [ {title : "CSV Format", extensions : "csv"} ],
			preinit : {
				// PreInit events, bound before any internal events
				Init: function(up, info) {
					$('#csv_edit_uploader_container').removeAttr('title');
				},
				FileUploaded: function(up, file, server_response) {
					// Called when a single file has finished uploading. This has to
					// be inside preinit so the 'return false' below works correctly.
					var response = $.parseJSON(server_response.response);

					if (! response.success) {
						var message = "Error for file ID: " + response.stored_file_id + ": " + response.message;
						alert('None of your CSV edits were applied because:\n\n' + message);
						zone_one_base.set_plupload_file_failed(up, file, message);
					}
					up.reset_ui_labels();
				},
				PostInit: function(uploader) {
					// Fix for html5 runtime on Google Chrome
					$('#' + uploader.id + '_html5_container').click( function(e) {
						e.stopPropagation();
					});
					// Add any uploader specific data we want to store, rather than putting it in page space
					// All uploaders should have a reset_ui_labels() that points to external function
					plupload.extend(uploader, {
						last_upload_successful: true,
						reset_ui_labels: zone_one_base.reset_ui_labels_csv_edit
					});
					uploader.reset_ui_labels();
				}
			},
			init : {
				// Post init events, bound after the internal events
				QueueChanged: function(up) {
					up.reset_ui_labels();
				},
				FilesRemoved: function(up, files) {
					up.reset_ui_labels();
				},
				UploadComplete: function(up, files) {
					up.reset_ui_labels();
					if (up.last_upload_successful) {
						alert('Success: All your CSV edits have been applied');
					}
					up.last_upload_successful = true;  //reset
				},
				Error: function(up, error) {
					// Only used for plupload-internal errors, not server errors
					up.reset_ui_labels();
					if (error.code == plupload.FILE_EXTENSION_ERROR) {
						alert('Error: Only .CSV files can be imported for CSV Edits.');
					}
				},
			},
		});
		//var uploader = $('#csv_edit_uploader').plupload('getUploader');
	},
	reset_ui_labels_csv_edit: function() {
		// Customize widget CSS and text labels. We use this a lot because PLupload redraws its
		// buttons a lot, and we cannot use plupload.addI18n() because that would be global to 
		// all PLupload widgets on the page.
		setTimeout(function() {
			var browse_text = 'Add CSV Edit File';
			$('#import-csv-dialog #csv_edit_uploader_browse .ui-button-text').html(browse_text);
			$('#import-csv-dialog .plupload_droptext').html('Drag your CSV Edit file here or click "' + browse_text + '"');
			$('#import-csv-dialog #csv_edit_uploader_start .ui-button-text').html('Apply Edits');
		}, 25);
	},
	set_plupload_file_failed: function(uploader, file, message) {
		uploader.last_upload_successful = false;

		$(document).on( 'click', '#' + file.id + ' .plupload_file_action', function() {
			uploader.removeFile( file );
			uploader.reset_ui_labels();
		} );

		setTimeout( function() {
			$('#' + file.id).attr('title', 'Error: ' + message);
			file.status = plupload.FAILED; 
			uploader.trigger('UploadProgress', file);
		}, 25);
	}
};
