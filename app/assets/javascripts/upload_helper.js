(function($){
	//Usage: $('#upload_data').serializeJSON(); 
	$.fn.serializeJSON = function() {
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

    // var uploader = $('#uploader').plupload('getUploader');

	// Events: http://www.plupload.com/example_events.php
	$("#uploader").plupload({
		// General settings
		runtimes : 'html5,html4',
		url : $('#upload_data').attr('action'),
		max_file_size : $('#max_web_upload_file_size').val(),
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
                if (up.state == plupload.STARTED && SFTP_INITIALIZED) {
                    conditional_sftp_post(up);
                }
			},
			FilesAdded: function(up, files) {
                //plupload.each(files, function(file) {
                //});
			},
			FileUploaded: function(up, file, info) {
				// Called when a single file has finished uploading
				return track_upload_result(file, info);
			},
			UploadComplete:  function() {
                // Called when all queued files finish uploading
				for (x in UPLOAD.results) {
					var result = UPLOAD.results[x];
					if (result.success) {
                        status_upload_complete();
					}
                    else {
						mark_failed_upload(result.file, result.message);
                    }
				}
                if (SFTP_INITIALIZED && !SFTP_DONE) {
                    // SFTP upload is still pending, so re-enable the button
                    enable_upload_button();
                }
			},
			Error: function(up, args) {
				// Called when a fatal server error has occured
				// Perhaps this should go in FilesAdded instead?
				var file = args.file;
				if (file.size !== undefined && file.size > up.settings.max_file_size) {
					var msg = "This file is too large to upload using this interface:";
					msg += '\nFilename: ' + file.name;
					msg += '\nFile size: ' + file.size;
					msg += '\nMaximum file size: ' + up.settings.max_file_size;
					msg += "\n\nPlease use the SFTP interface to the right.";
					alert(msg);
					init_sftp();
					return false;
				}
			}
		}
	});

    var mark_sftp_complete = function(remote_file_count) {
        SFTP_DONE = true;
        //TODO: Replace the username/pass SFTP credentials with this msg?
        alert('Successfully queued ' + remote_file_count + ' SFTP files for import');
    } 

	var track_upload_result = function(file, info_json) {
		// Track each upload result so we can inform the user later
        try {
            var result = $.parseJSON( info_json['response'] );
            if (result['success']) {
                if (result['remote_file_count'] > 0) {
                    mark_sftp_complete(result['remote_file_count']);
                }
                return UPLOAD.ok(file);
            }
            else {
                return UPLOAD.fail(file, result['message']);
            }
        }
        catch(err) {
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

	var SFTP_INITIALIZED = SFTP_DONE = false;
	var sftp_url_id = '#sftp_url';
	var username_id = '#sftp_username';
	var password_id = '#sftp_password';

	// prevent lazy firefox reload from leaving old credentials visible
	$(sftp_url_id).val('loading...');
	$(password_id).val('loading...');
	$(sftp_url_id).focus(function() {this.select();});
	$(password_id).focus(function() {this.select();});

	$('#sftp_init_button').click(function() {
        init_sftp();
        return false;
	});

    var conditional_sftp_post = function(uploader) {
        // Checks for any pending web uploads. If none found, fires post_sftp for
        // a SFTP-only type upload
        var has_queued_web_uploads = false;

        uploader.files.forEach( function(file) {
            if (file.status == plupload.QUEUED) {has_queued_web_uploads = true;}
        });
        if (!has_queued_web_uploads) {
            post_sftp(uploader);
        }
    }

	var init_sftp = function() {
		if (SFTP_INITIALIZED) {return;}
		SFTP_INITIALIZED = true;
		$('#sftp_init_button').hide();
		$('#sftp_container').removeClass('centered');
		$('#sftp_credentials').show('slide', {}, 700 );

		$.post(
			'/sftp_users', 
			function(data) { 
				display_sftp_credentials(data);
                enable_upload_button();
			}
		).error( function(data) {
			// Parse this json manually because it had an error response code
			var response = $.parseJSON(data.responseText);
			alert("Error generating temporary SFTP credentials: " + response['message']);
		});
	};

	var display_sftp_credentials = function(credentials) {
		$(sftp_url_id).val(credentials['sftp_url']);
		$(username_id).val(credentials['u']);
		$(password_id).val(credentials['p']);
	}

	var post_sftp = function(uploader) {
        // Does a SFTP-only POST 
		if (! SFTP_INITIALIZED) {return;} 

		var post_data = $('#upload_data').serializeJSON();
		post_data['sftp_only'] = 1;
		$.post(
			uploader.settings.url, 
			post_data,
			function(response) {
                handle_sftp_only_response(response);
			}
		).error(function(response) {
            handle_sftp_only_response(response);
		});
	};

    var enable_upload_button = function() {
        $('#uploader_start').button('enable');
    }

    var handle_sftp_only_response = function(response) {
        try {
            if (response.success) {
                var file_count = response.remote_file_count;
                if (file_count > 0) {
                    $('#uploader_start').button('disable');
                    status_upload_complete();
                    mark_sftp_complete(result['remote_file_count']);
                    return;
                }
                else if (file_count == 0) {
                    upload_status('No SFTP files found for import. Perhaps you forgot to upload them to the SFTP server <em>before</em> clicking the Start Upload button?');
                    enable_upload_button();
                    return;
                }
            }
            else {
                var msg = response.message;
                if (typeof(msg) === 'undefined') {msg = '(Unknown error)';}
                upload_status('SFTP Import Error: ' + msg);
                enable_upload_button();
                return;
            }
        }
        catch(err) {
            update_status("We're sorry. There was an unexpected error and your SFTP import could not be queued up at this time.");
        }
    }

});

function status_upload_complete() {
    var href = $('#manage_files').attr('href');
    var msg = 'Files uploaded!<br />You can upload more files in this batch or <a href="' + href + '">see your files</a>';
    upload_status(msg);
}

function upload_status(msg) {
    var div = '#upload_table_status';
    $(div).show();
    $(div).html(msg + '<br />');
}
