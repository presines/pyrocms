(function($) {
	$(function(){

		form = $('form.crud');
		
		$('input[name="title"]', form).keyup($.debounce(350, function(e){
			$.post(SITE_URL + 'ajax/url_title', { title : $(this).val() }, function(slug){
				$('input[name="slug"]', form).val( slug );
			});
		}));

        var upload_form = $('#files-uploader form');

		// Files -------------------------------------------------------

		$(".edit_file").livequery(function(){
			$(this).colorbox({
				scrolling	: false,
				width		: '600',
				height		: '480',
				onComplete: function(){
					var form = $('form#files_crud'),
						$loading = $('#cboxLoadingOverlay, #cboxLoadingGraphic');

					$.colorbox.resize();

					form.find(':input:last').keypress(function(e){
						if (e.keyCode == 9 && ! e.shiftKey)
						{
							e.preventDefault();
							form.find(':input:first').focus();
						}
					});

					form.find(':input:first').keypress(function(e){
						if (e.keyCode == 9 && e.shiftKey)
						{
							e.preventDefault();
							form.find(':input:last').focus();
						}
					});

					form.submit(function(e){

						e.preventDefault();

						form.parent().fadeOut(function(){

							$loading.show();

							pyro.clear_notifications();

							$.post(form.attr('action'), form.serialize(), function(data){

								// Update title
								data.title && $('#cboxLoadedContent h2:eq(0)').text(data.title);

								if (data.status == 'success')
								{
									$(window).hashchange();

									// TODO: Create a countdown with an option to cancel before close
									setTimeout(function(){
										$.colorbox.close();
									}, 1800);
								}

								$loading.hide();

								form.parent().fadeIn(function(){

									// Show notification & resize colorbox
									pyro.add_notification(data.message, {ref: '#cboxLoadedContent', method: 'prepend'}, $.colorbox.resize);

								});

							}, 'json');

						});
					});
				},
				onClosed: function(){}
			});
		});

		$('.open-files-uploader').livequery(function(){
			$(this).colorbox({
				scrolling	: false,
				inline		: true,
				href		: '#files-uploader',
				width		: '800',
				height		: '80%',
				onComplete	: function(){
					$('#files-uploader-queue').empty();
					$.colorbox.resize();
				},
				onCleanup : function(){
                    /* Todo: Refrescar la vista. */
					//$(window).hashchange();
				}
			});
		});

        upload_form.fileUploadUI({
            fieldName		: 'userfile',
            uploadTable		: $('#files-uploader-queue'),
            downloadTable	: $('#product_images_list'),
            previewSelector	: '.file_upload_preview div',
            buildUploadRow	: function(files, index, handler){
                return $('<li><div class="file_upload_preview ui-corner-all"><div class="ui-corner-all"></div></div>' +
                        '<div class="filename"><label for="file-name">' + files[index].name + '</label>' +
                        '<input class="file-name" type="hidden" name="name" value="'+files[index].name+'" />' +
                        '</div>' +
                        '<div class="file_upload_progress"><div></div></div>' +
                        '<div class="file_upload_cancel buttons buttons-small">' +
                        '<button class="button start ui-helper-hidden-accessible"><span>' + 'Subir' + '</span></button>'+
                        '<button class="button cancel"><span>' + 'Cancelar' + '</span></button>' +
                        '</div>' +
                        '</li>');
            },
            buildDownloadRow: function(data){
                if (data.status == 'success')
                {
                    return $('<li><a href="' + SITE_URL + 'admin/products/image_edit/' + data.file.id +'" class="upload_colorbox">' +
                             '<img src="' + SITE_URL +  'products/tiny_thumbnail/' + data.file.name +'" />' +
                             '<input type="hidden" name="action_to[]" value="' + data.file.id +'"></a></li>');
                }
                return false;
            },
            beforeSend: function(event, files, index, xhr, handler, callBack){
                handler.uploadRow.find('button.start').click(function(){
                    handler.formData = {
                        name: handler.uploadRow.find('input.file-name').val()
                    };
                    callBack();
                });
            },
            onComplete: function (event, files, index, xhr, handler){
                handler.onCompleteAll(files);
            },
            onCompleteAll: function (files){
                if ( ! files.uploadCounter)
                {
                    files.uploadCounter = 1;
                }
                else
                {
                    files.uploadCounter = files.uploadCounter + 1;
                }

                if (files.uploadCounter === files.length)
                {
                    $('#files-uploader a.cancel-upload').click();
                }
            }
        });

        $('#files-uploader a.start-upload').click(function(e){
            e.preventDefault();
            $('#files-uploader-queue button.start').click();
        });

        $('#files-uploader a.cancel-upload').click(function(e){
            e.preventDefault();
            $('#files-uploader-queue button.cancel').click();
            $.colorbox.close();
        });

        $('a[rel="colorbox"]').livequery(function(){
            $(this).colorbox({
                maxWidth	: '80%',
                maxHeight	: '80%'
            });
        });

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
