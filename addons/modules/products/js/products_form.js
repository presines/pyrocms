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

jQuery(function($){
	var store_func = function(){};

	$('.images-manage ul#product_images_list').sortable({
		handle: 'img',
		start: function(event, ui) {
			ui.helper.find('a').unbind('click').die('click');
		},
		update: function() {
			order = new Array();
			$('li', this).each(function(){
				order.push( $(this).find('input[name="action_to[]"]').val() );
			});
			order = order.join(',');

			$.post(SITE_URL + 'admin/products/ajax_update_order', { order: order });
		}

	}).disableSelection();

});
