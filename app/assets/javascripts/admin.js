$(function() {
    $( ".draggable" ).draggable({revert: 'invalid', scope:'mime-types'});
    $( ".droppable" ).droppable({
        scope: 'mime-types',
        drop: function( event, ui ) { 
            var mime_type = $(ui.draggable[0]);
            var category_changed = (mime_type.parents('.mime-type-category')[0] != this);
            mime_type.appendTo($(this).find("div"));
            mime_type.css({left:0, top:0}); 

            if (category_changed) {
                $.ajax({
                    type: 'PUT',
                    complete: function(xhr, status) {
                        $('.mime-types .message').html(xhr.responseText).show();
                        setTimeout("$('.mime-types .message').hide()", 3000);
                    },
                    url: $($(this).parents('form')[0]).attr('action') + '/' + mime_type.attr('data-id'),
                    data: {mime_type:{mime_type_category_id:$(this).attr('data-id') }}
                });
            }
        }
    });
});

