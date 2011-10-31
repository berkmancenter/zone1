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

	var track_upload_result = function(file, info_json) {
		// Track each upload result so we can inform the user later
		var result = $.parseJSON( info_json['response'] );
		return result['success'] ? UPLOAD.ok(file) : UPLOAD.fail(file, result['message']);
	};

	var mark_failed_upload = function(file, msg) {
		// UI changes to better indicate which uploads failed and why
		var rowId = '#' + file.id;
		$(rowId).removeClass('plupload_done');
		$(rowId).addClass('ui-state-error');
		$(rowId).addClass('plupload_failed');
		//$(rowId).attr('title', 'borkened');

		var iconDiv = $(rowId + '.plupload_done td.plupload_cell div.ui-icon-circle-check');
		$(iconDiv).removeClass('ui-icon-circle-check');
		$(iconDiv).addClass('ui-icon-alert');

		var spanId = rowId + ' td.plupload_cell span';
		$(spanId).text( $(spanId).text() + '  [ERROR: ' + msg + ']' );
	};

	// Events: http://www.plupload.com/example_events.php
	$("#uploader").plupload({
		// General settings
		//multipart_params : //all set in UploadFile preinit event.
		runtimes : 'html5,html4', // 'flash,html5,html4',
		url : '/stored_file/new',
		max_file_size : '2000mb',
		max_file_count: 200,
		unique_names : false,
		multiple_queues : true, //allow user to upload multiple times from this single page view
		multipart : true, //Does not work on WebKit using the HTML 5 runtime.
		rename: true,
		flash_swf_url : '/javascripts/plupload/plupload.flash.swf',

		// PreInit events, bound before any internal events
		preinit : {
			Init: function(up, info) {
				$('#uploader_container').attr('title', '');
			},
			UploadFile: function(up, file) {
				// Gets called immediately before a single file is uploaded
				up.settings.url = $('#upload_data').attr('action');
				up.settings.multipart_params = $('#upload_data').serializeJSON(); 
			}
		},
		// Post init events, bound after the internal events
		init : {
			StateChanged: function(up) {
				// Called when the state of the queue is changed
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
				UPLOAD['uploads_failed'][args.file] = args.message;
				return false;
			}
		}
  	});
});
