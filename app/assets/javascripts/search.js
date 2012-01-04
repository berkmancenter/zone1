$("#bulk_select").live("click", function () {
  var checked_state = $("#bulk_select").attr("checked");
  $("input.downloadable[type='checkbox']").each( function(index) {
    if(checked_state) {
      $(this).attr('checked', true);
    } else {
      $(this).attr('checked', false);
    }
  });
});
