(function($){
	//Usage: $('#upload_data').serializeJSON(); 
	$.fn.serializeJSON = function() {
		// Does not support checkboxes
		var json = {};
		jQuery.map($(this).serializeArray(), function(n, i){
			json[n['name']] = n['value'];
		});
		return json;
	};
})( jQuery );

$(function() {
	var UPLOAD = {
		results : [],
		fail : function(file, msg) {
			this.results.push( { file: file, success: false, message: msg } );
			return false;
		},
		ok : function(file) {
			this.results.push( { file: file, success: true } );
			return true;
		}
	};

	// Events: http://www.plupload.com/example_events.php
	$("#uploader").plupload({
		// General settings
		runtimes : 'html5,html4',
		url : $('#upload_data').attr('action'),
		max_file_size : $('#max_web_upload_file_size').val(), //'2000mb',
		file_data_name : 'file',  //=> params[:file]
		max_file_count: 200,
		unique_names : false,
		multiple_queues : true, //allow user to upload multiple times from this single page view
		multipart : true, //Does not work on WebKit using the HTML 5 runtime.
		rename: false,

		// PreInit events, bound before any internal events
		preinit : {
			Init: function(up, info) {
				$('#uploader_container').attr('title', '');
				var b = $('#uploader_start');
				b.appendTo('#button_section');
				var b = $('#uploader_stop');
				b.appendTo('#button_section');
			},
			UploadFile: function(up, file) {
				// Gets called immediately before a single file is POSTed
				up.settings.multipart_params = $('#upload_data').serializeJSON(); 
			}
		},
		// Post init events, bound after the internal events
		init : {
			StateChanged: function(up) {
				// Called when the state of the queue is changed
			},
			FilesAdded: function(up, files) {
				plupload.each(files, function(file) {
					//console.log('  File:', file);
				});
			},
			FileUploaded: function(up, file, info) {
				// Called when a single file has finished uploading
				return track_upload_result(file, info);
			},
			UploadComplete:  function() { 
				for (x in UPLOAD.results) {
					var result = UPLOAD.results[x];
					if (!result.success) {
						mark_failed_upload(result.file, result.message);
					}
				}
			},
			Error: function(up, args) {
				// Called when a fatal server error has occured
				// Perhaps this should go in FilesAdded instead?
				var file = args.file;
				if (file.size !== undefined && file.size > up.settings.max_file_size) {
					var msg = "Sorry, but this file is too large to upload using this interface:";
					msg += '\nFilename: ' + file.name;
					msg += '\nFile size: ' + file.size;
					msg += '\nMaximum file size: ' + up.settings.max_file_size;
					msg += "\n\nPlease use the SFTP interface below.";
					alert(msg);
					init_sftp();
					return false;
				}
			}
		}
	});

	var track_upload_result = function(file, info_json) {
		// Track each upload result so we can inform the user later
		//TODO: Would be nice to include SFTP-specific flag here
    try {
      var result = $.parseJSON( info_json['response'] );
      return result['success'] ? UPLOAD.ok(file) : UPLOAD.fail(file, result['message']);
	  } catch(err) {
        return UPLOAD.fail(file, err.message);
    }
  };

	var mark_failed_upload = function(file, msg) {
		// UI changes to better indicate which uploads failed and why
		// We have to do this after the uploads are done, otherwise
		// PLupload blows away our custom error message.
		var rowId = '#' + file.id;
		$(rowId).removeClass('plupload_done').addClass('ui-state-error').addClass('plupload_failed');

    var spanId = rowId + ' td.plupload_cell span';
		$(spanId).text( $(spanId).text() + '  [ERROR: ' + msg + ']' );

    var iconDivId = rowId + "td.plupload_file_action div.ui-icon";
		$(iconDivId).removeClass('ui-icon-circle-check').addClass('ui-icon-alert');
	};

	var SFTP_INITIALIZED = false;
	var SFTP_DONE = false;
	var username_id = '#sftp_username';
	var password_id = '#sftp_password';

	// prevent lazy firefox reload from leaving old credentials visible
	$(username_id).val('');
	$(password_id).val('');
	$(username_id).focus(function() {this.select();});
	$(password_id).focus(function() {this.select();});

	$('#sftp_toggler').click(function() {
		$('#sftp').slideToggle('fast', function() {
			if (! SFTP_INITIALIZED) {
				init_sftp();
			}
		});
	});

	$('#sftp_tester').click(function() {
		init_sftp();
	});

	var display_sftp_credentials = function(credentials) {
		$(username_id).val(credentials['u']);
		$(password_id).val(credentials['p']);
	}

	var post_sftp = function(uploader) {
		if (! SFTP_INITIALIZED) {return;} 
		SFTP_DONE = true;
		//console.log('POSTING SFTP Only!');
		var post_data = $('#upload_data').serializeJSON();
		post_data['sftp_only'] = 1;
		$.post(
			uploader.settings.url, 
			post_data,
			function(data) {
				//alert('Successfully queued 42 files for import');
				//console.log('sftpPOST done');
			}
		).error( function(data) {
			var response = $.parseJSON(data.responseText);
			alert("Error : " + response['message']);
		});
	};

	var init_sftp = function() {
		if (SFTP_INITIALIZED) {return;}

		$('#sftp').slideDown('fast', function() {});

		SFTP_INITIALIZED = true;

		$.post(
			'/sftp_users', 
			function(data) { 
				display_sftp_credentials(data);
				// Bind event for sftp-only upload hook
				$('#uploader_start').button('enable');
				var uploader = $('#uploader').plupload('getUploader');
				uploader.bind('StateChanged', function(up) { 
					if (!SFTP_DONE && (up.state == plupload.STARTED)) {
						post_sftp(up);
					}
				}
			);
		}).error( function(data) {
			// we have to parse this json manually because it had an error response code
			var response = $.parseJSON(data.responseText);
			alert("Error generating temporary SFTP credentials: " + response['message']);
		});
	};

});


