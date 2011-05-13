(function($) {
	$(function(){

		form = $('form.crud');
		
		$('input[name="title"]', form).keyup($.debounce(350, function(e){
			$.post(SITE_URL + 'ajax/url_title', { title : $(this).val() }, function(slug){
				$('input[name="slug"]', form).val( slug );
			});
		}));

	});
})(jQuery);