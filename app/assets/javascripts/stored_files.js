$(function() {
	zone_one_single.setup_datepickers();
});

var zone_one_single = {
	setup_datepickers: function() {
		$("#stored_file_original_date").datepicker({
			maxDate: '+0d'
		});
	}
};
