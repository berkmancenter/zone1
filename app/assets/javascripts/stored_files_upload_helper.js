$(function() {
    if (zone_one_stored_file_upload.get_uploader()) {
        // Only bother with all this if we're on the upload page
        zone_one_stored_file_upload.init_stored_file_uploader();
        zone_one_stored_file_upload.setup_handlers();
    }
});

var zone_one_stored_file_upload = {

    get_uploader: function() {
        // This method is implemented in multiple namespaces for other uploaders as well
        var uploader = $('#stored_files_uploader').plupload('getUploader');
        return uploader.length == 0 ? undefined : uploader;
    },
    setup_handlers: function() {
    	// prevent lazy firefox reload from leaving old credentials visible
    	$('#sftp_url').val('loading...');
    	$('#sftp_password').val('loading...');

    	$('#sftp_url').focus(function() {this.select();});
    	$('#sftp_password').focus(function() {this.select();});

    	$('#sftp_init_button').click(function(e) {
    		e.preventDefault();
            zone_one_stored_file_upload.init_sftp();
    	});
    },
    init_stored_file_uploader: function() {
    	$("#stored_files_uploader").plupload({
    		runtimes : 'html5,html4',  //flash does not play nicely with sessions for us
    		url : $('#stored-file-upload').attr('action'),
    		max_file_size : $('#max_web_upload_file_size').val(),
    		max_file_count: 200,
    		preinit : {
                // PreInit events, bound before any internal events
    			Init: function(up, info) {
    				$('#stored_files_uploader_container').removeAttr('title')
    			},
    			UploadFile: function(up, file) {
    				// Gets called immediately before a single file is POSTed
    				up.settings.multipart_params = $('#stored-file-upload').serializeJSON(); 
    			},
                PostInit: function(uploader) {
                    // Fix for html5 runtime on Google Chrome
                    $('#' + uploader.id + '_html5_container').click( function(e) {
                        e.stopPropagation();
                    });

                    // Add any uploader specific data we want to store, rather than putting it in page space
                    plupload.extend(uploader, {
                        sftp_initialized: false,
                        sftp_click_event_added: false,
                        sftp_done: false,
                        // All uploaders should have a reset_ui_labels() that points to external function
                        reset_ui_labels: zone_one_stored_file_upload.reset_ui_labels_stored_file
                    });

                    // Do this one UI change once instead of reset_ui_labels
                    $('#stored_files_uploader .plupload_droptext').html('Drag your files here or click "Add Files"');
                }
    		},
    		init : {
        		// Post init events, bound after the internal events
    			FileUploaded: function(up, file, server_response) {
    				// Called when a single file has finished uploading and the server returns HTTP 200 response
    				var response = $.parseJSON(server_response.response);

    				if (! response.success) {
                        // Happens for blacklisted files, etc.
                        var message = response.message;
                        zone_one_stored_file_upload.mark_failed_upload(file, message);
    					zone_one_base.set_plupload_file_failed(up, file, message);
                    }
    			},
    			UploadComplete: function(up, files) {
                    // Triggered when all queued files finish uploading. If the server returns
                    // an HTTP response code other than 200, plupload will trigger the Error
                    // event, then this event.

                    // Re-do our UI updates for failed files because PLupload will undo them
                    // partially if there were multiple files queued.
                    zone_one_stored_file_upload.mark_all_failed_uploads(files);

                    // If any uploaded file was successful, display the confirmation message
                    if ( up.files.some( function(file) {return file.status == plupload.DONE} )) {
                        zone_one_stored_file_upload.status_upload_complete();
                    }

                    if (up.sftp_initialized && !up.sftp_done) {
                        // SFTP upload is still pending, so re-enable the button
                        zone_one_stored_file_upload.enable_upload_button();
                    }
    			},
    			Error: function(up, error) {
    				// Triggered for both internal and server-side errors

                    // Handle server-side error
                    if (error.status) {
                        zone_one_stored_file_upload.mark_failed_upload(error.file, error.message);
                        return;
                    }

                    // Handle client-side error
    				if (error.code == plupload.FILE_SIZE_ERROR) {
        				var file = error.file;
    					var msg = "This file is too large to upload using this interface:";
    					msg += '\nFilename: ' + file.name;
    					msg += '\nFile size: ' + file.size;
    					msg += '\nMaximum file size: ' + up.settings.max_file_size;
    					msg += "\n\nPlease use the SFTP interface to the right.";
    					alert(msg);
    					zone_one_stored_file_upload.init_sftp();
    					return;
    				}
    			}
    		}
    	});
    },
    mark_all_failed_uploads: function(files) {
        files.forEach( function(file) {
            if (file.status == plupload.FAILED) {
                zone_one_stored_file_upload.mark_failed_upload(file, file.zone_one_error_message);
            }
        });
    },
    reset_ui_labels_stored_file: function() {
    },
    mark_sftp_complete: function(remote_file_count) {
        zone_one_stored_file_upload.get_uploader().sftp_done = true;
        alert('Successfully queued ' + remote_file_count + ' SFTP files for import');
    },
    mark_failed_upload: function(file, msg) {
        file.status = plupload.FAILED;

        // Cache error message inside file object for easy access (instead of 
        // using some external home-grown data structure.)
        file.zone_one_error_message = file.zone_one_error_message || msg;

        var display_text = file.name + '  [ERROR: ' + msg + ']';
        var selector = $( '#' + file.id + ' td.plupload_cell span' );
        if (selector.text() != display_text) {
            setTimeout( function() {
	        	selector.text( display_text );
            }, 50);
        }
	},
    conditional_sftp_post: function() {
        // Checks for any pending web uploads. If none found, fires post_sftp for
        // a SFTP-only type upload.
        var uploader = zone_one_stored_file_upload.get_uploader();
        if (! uploader.files.some( function(file) {return file.status == plupload.QUEUED} )) {
            zone_one_stored_file_upload.post_sftp(uploader);
        }
    },
    init_sftp: function() {
        var uploader = zone_one_stored_file_upload.get_uploader();
		if (uploader.sftp_initialized) {return;}
		uploader.sftp_initialized = true;

		$('#sftp_init_button').hide();
		$('#sftp_container').removeClass('centered');
		$('#sftp_credentials').show('slide', {}, 700 );

		$.post(
			'/sftp_users', 
			function(data) { 
				zone_one_stored_file_upload.display_sftp_credentials(data);
                zone_one_stored_file_upload.enable_upload_button();
			}
		).error( function(data) {
			// Parse this json manually because it had an error response code
			var response = $.parseJSON(data.responseText);
			alert("Error generating temporary SFTP credentials: " + response['message']);
		});
	},
    display_sftp_credentials: function(credentials) {
		$('#sftp_url').val(credentials['sftp_url']);
		$('#sftp_username').val(credentials['u']);
		$('#sftp_password').val(credentials['p']);
        $('#sftp_url').select();
	},
    post_sftp: function(uploader) {
        // Does a SFTP-only POST
		if (! uploader.sftp_initialized) {return;} 

		var post_data = $('#stored-file-upload').serializeJSON();
		post_data['sftp_only'] = 1;
		$.post(
			uploader.settings.url, 
			post_data,
			function(response) {
                zone_one_stored_file_upload.handle_sftp_only_response(response);
			}
		).error(function(response) {
            zone_one_stored_file_upload.handle_sftp_only_response(response);
		});
	},
    enable_upload_button: function() {
        $('#stored_files_uploader_start').button('enable');

        var uploader = zone_one_stored_file_upload.get_uploader();
        if (! uploader.sftp_click_event_added) {
            // Make sure we only add this event handler once
            uploader.sftp_click_event_added = true;
            $('#stored_files_uploader_start').click( function() {
                zone_one_stored_file_upload.conditional_sftp_post();
            });
        }
    },
    handle_sftp_only_response: function(response) {
        try {
            if (response.success) {
                var file_count = response.remote_file_count;
                if (file_count > 0) {
                    $('#stored_files_uploader_start').button('disable');
                    zone_one_stored_file_upload.status_upload_complete();
                    zone_one_stored_file_upload.mark_sftp_complete(result['remote_file_count']);
                    return;
                }
                else {
                    zone_one_stored_file_upload.upload_status('No SFTP files found for import. Perhaps you forgot to upload them to the SFTP server <em>before</em> clicking the Start Upload button? (You can still do that now if you\'d like.)');
                    zone_one_stored_file_upload.enable_upload_button();
                    return;
                }
            }
            else {
                var msg = response.message || '(Unknown error)';
                zone_one_stored_file_upload.upload_status('SFTP Import Error: ' + msg);
                zone_one_stored_file_upload.enable_upload_button();
                return;
            }
        }
        catch(err) {
            zone_one_stored_file_upload.update_status("We're sorry. There was an unexpected error and your SFTP import could not be queued up at this time.");
        }
    },
    status_upload_complete: function() {
    	var href = $('#manage_files').attr('href');
    	var msg = 'Files uploaded!<br />You can upload more files in this batch or <a href="' + href + '">see your files</a>';
	    zone_one_stored_file_upload.upload_status(msg);
    },
    upload_status: function(msg) {
        $('#upload_table_status').html(msg).slideDown();
    }
};


