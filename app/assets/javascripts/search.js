$(function() {
	zone_one_search.setup_bulk_actions();
	zone_one_search.setup_per_page_refresh();
  zone_one_search.init_autocomplete();
});

var zone_one_search = {

    update_export_repo_collections: function (collections) {
      var first_option = $('#export-collections').children().first();

      if (collections.length > 0) {
          first_option.siblings().remove();
          collections.forEach(function(val) {
              $('#export-collections').append($('<option>').text(val).attr('value', val));
          });
          first_option.text(' (please select) ');
          if (collections.length == 1) {
              //Auto-select the only one we got back
              $(first_option.parent().children()[1]).attr('selected', true);
          }
      }
      else {
          first_option.text('No collections found');
          first_option.siblings().remove();
      }
      $('#export-collections').effect('highlight', {}, 'slow');
    },
	setup_per_page_refresh: function () {

	cache : {},
  lastXhr : null,
  init_autocomplete: function () {
    $("#tags input").autocomplete({
      minLength: 2,
      source: function( request, response ) {
        var term = request.term;
        if ( term in zone_one_search.cache ) {
          response( zone_one_search.cache[ term ] );
          return;
        }
        zone_one_search.lastXhr = $.getJSON( "search/tags", request, 
          function( data, status, xhr ) {
            zone_one_search.cache[ term ] = data; 
            if ( xhr === zone_one_search.lastXhr ) {
              response( data );
              }
            });
       }
     }); 
   },

  setup_per_page_refresh: function () {
		// The #per_page_user_input text field is not inside the rest of
        // the search filter form.  Populate hidden field inside form
        // when user clicks refresh.

        $("#refresh-per-page").live("click", function () {
			$("#per_page").val($("#per_page_user_input").val());
			$("#execute_search_image").click();
		});

        // Click refresh on enter
        $("#per_page_user_input").keyup(function(event) {
            if(event.keyCode == 13) {
                $("#refresh-per-page").click();
            }
        });
	},
	setup_bulk_actions: function () {

		$('#dash-refresh-collections').click(function() {
            var username = $('#dash-username').val();
            var password = $('#dash-password').val();
            $.ajax({
              url: '/stored_files/export_refresh_collections',
              type: 'POST',
              data: { repo: 'dash', username: username, password: password },
              dataType: 'json',
              success: function(data) {
                  zone_one_search.update_export_repo_collections(data['collections']);
              },
              error: function(data) {
                  if (data.status == 401) {
                      alert('Error: Incorrect DASH Username or Password');
                  }
                  else {
                      alert('Error refreshing collections: ' + data.responseText);
                  }
              },
            });
			return false;
		});

		$('#export-to-repo-submit').click(function() {
			var target_form = $('#export-to-repo');
			zone_one_search.clone_downloadable_checkboxes_to(target_form);
			var count = target_form.children("input:checked").length;
            if (count == 0) {
                return false;
            }

            var file_string = (count == 1) ? 'file' : 'files';
            var dialog_title = 'Export ' + count + ' ' + file_string + ' to DASH';

            $('#export-to-repo-dialog').dialog({
				width: '315',
				title: dialog_title,
				modal: true,
				buttons: [
					{
						text: "Export Now",
						click: function() {
                            if ($('#export-collections').val() == '') {
                                $('#export-collections').effect('pulsate');
                                return false;
                            }

                            // re-clone checkboxes in case they added any while dialog was active
                            zone_one_search.clone_downloadable_checkboxes_to(target_form);
							target_form.submit();
							$(this).dialog('close');
						}	
					},
					{
						text: "Close",
						click: function() { $(this).dialog('close'); }	
					}
                ],
			});

            zone_one_base.toggle_header_dropdown( $('#show_set_options')[0] );
            return false;
        });

        $(document).on('ajax:success', '#export-to-repo', function() {
			var count = $('#export-to-repo').children("input:checked").length;
            alert('ExportConfirmationMessage: ' + count + " files have been marked for a background export to DASH.\n\nYou should receive an export results email soon.");
        });

		$('#download-submit, #bulk-edit-submit').click(function() {
			zone_one_search.clone_downloadable_checkboxes_to($(this).parent());
			var count = $(this).parent().children("input:checked").length;
            if (count == 0) {
                return false;
            }
            $(this).parent().submit();
			zone_one_base.toggle_header_dropdown( $('#show_set_options')[0] );
            return false;
		});
		$('#bulk-delete-submit').click(function() {
			var bulk_delete = $('#bulk-delete');
			$(bulk_delete).children('input').remove();
			zone_one_search.clone_downloadable_checkboxes_to(bulk_delete);
			var count = $(bulk_delete).children("input:checked").length;
			if (count == 0) {
                return false;
            }

			$(bulk_delete).append($('<input>').attr('type', 'hidden').attr('name', 'previous_search').val(location.href));
			$('<p>').html("Are you sure you want to delete the " + count + " items?").dialog({
				modal: true,
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
						text: "Cancel",
						click: function() { $(this).dialog('close'); }	
					}
				]
			});
			return false;
		});
													
		// Use change instead of click for more robust handling of
		// check/uncheck by javascript
		$("#bulk_select").live("change", function () {

			// checked = true, unchecked = undefined
			var checked_state = $("#bulk_select").attr("checked");

			if(checked_state) { 

				// loop and check
				$("input.downloadable[type='checkbox']").each( function(index) {
					$(this).attr('checked', true);
				});

				$("#offer-select-all").show(); 
			} else {

				//loop and uncheck
				$("input.downloadable[type='checkbox']").each( function(index) {
					$(this).attr('checked', false);
				});
			
				//loop and uncheck other pages as well
				$("input.downloadable-other-pages[type='checkbox']").each( function(index) {
					$(this).attr('checked', false);
				});
				$("#offer-clear-selection").hide();
				$("#offer-select-all").hide();
			} 
		});

		$("#select-all-results").live("click", function () {
			$("input.downloadable-other-pages[type='checkbox']").each( function(index) {
				$(this).attr('checked', true);
			});
			$("#offer-select-all").hide();
			$("#offer-clear-selection").show();
		});

		$("#clear-select-all-results").live("click", function () {
		 $("#offer-clear-selection").hide();
		 
		 // Fires the change function above
		 $("#bulk_select").click(); 
		});
	},
	clone_downloadable_checkboxes_to: function(destination) {
		destination.children("input:checked").remove();
		destination.append($('.downloadable:checked').clone());
		destination.append($('.downloadable-other-pages:checked').clone());
		destination.children("input:checked").hide();
	}
}
