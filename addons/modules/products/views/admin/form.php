<?php if ($this->method == 'create'): ?>
	<h3><?php echo lang('products_create_title'); ?></h3>
<?php else: ?>
		<h3><?php echo sprintf(lang('products_edit_title'), $product->title); ?></h3>
<?php endif; ?>

<div class="hidden">
	<div id="files-uploader">
		<div class="files-uploader-browser">
			<?php echo form_open_multipart('admin/products/upload/' . $product->id ); ?>
				<label for="userfile" class="upload">Subir Archivos</label>
				<?php echo form_upload('userfile', NULL, 'class="no-uniform" multiple="multiple"'); ?>
			<?php echo form_close(); ?>
			<ul id="files-uploader-queue" class="ui-corner-all"></ul>
		</div>
		<div class="buttons align-right padding-top">
			<a href="#" title="" class="button start-upload"><?php echo 'Subir'; ?></a>
			<a href="#" title="" class="button cancel-upload"><?php echo 'Cancelar';?></a>
		</div>
	</div>
</div>

<?php echo form_open_multipart(uri_string(), 'class="crud"'); ?>

<div class="tabs">

	<ul class="tab-menu">
		<li><a href="#products-content-tab"><span><?php echo lang('products_content_label'); ?></span></a></li>
		<li><a href="#products-images-tab"><span><?php echo lang('products_images_label'); ?></span></a></li>
	</ul>

	<!-- Content tab -->
	<div id="products-content-tab">
		<ol>
			<li>
				<label for="title"><?php echo lang('products_title_label'); ?></label>
				<?php echo form_input('title', htmlspecialchars_decode($product->title), 'maxlength="100"'); ?>
				<span class="required-icon tooltip"><?php echo lang('required_label'); ?></span>
			</li>
			<li class="even">
				<label for="slug"><?php echo lang('products_slug_label'); ?></label>
				<?php echo form_input('slug', $product->slug, 'maxlength="100" class="width-20"'); ?>
				<span class="required-icon tooltip"><?php echo lang('required_label'); ?></span>
			</li>
			<li>
				<label for="product_category_id"><?php echo lang('products_category_label'); ?></label>
				<?php echo form_dropdown('product_category_id', array(lang('products_no_category_select_label')) + $categories, @$product->product_category_id) ?>
			</li>
			<li  class="even">
				<label class="description" for="description"><?php echo lang('product_description_label'); ?></label>
				<?php echo form_textarea(array('id' => 'description', 'name' => 'description', 'value' => $product->description, 'rows' => 5, 'class' => 'wysiwyg-simple')); ?>
			</li>
			<li>
				<?php echo form_textarea(array('id' => 'body', 'name' => 'body', 'value' => stripslashes($product->body), 'rows' => 50, 'class' => 'wysiwyg-advanced')); ?>
			</li>
			<li class="even">
				<label for="status"><?php echo lang('products_status_label'); ?></label>
				<?php echo form_dropdown('status', array('draft' => lang('products_draft_label'), 'live' => lang('products_live_label')), $product->status) ?>
			</li>
	
		</ol>
	</div>

	<!-- Images tab -->
	<div id="products-images-tab">

        <?php if ($this->method == 'create'): ?>
            <div class="blank-slate">
	            <h2>Debe guardar primero el producto para poder administrar las imágenes.</h2>
            </div>
        <?php else: ?>
        <ol>
            <li>
                <label for="nothing"><?php echo lang('products_thumbnail_path_label'); ?></label>
                <?php echo form_upload('thumbnail'); ?>
            </li>
            <?php if (isset($product_images) && $product_images): ?>
            <li class="images-manage even">
                <label for="product_images"><?php echo lang('products_images_area_label'); ?></label>
                <p><?php echo lang('products_images_area_instructions'); ?></p>
                <div class="buttons buttons-small">
                    <a href="<?php echo site_url() . 'admin/products/upload/' . $product->id ?>" class="button upload open-files-uploader">Subir Archivos</a>
                </div>
                <div class="clear-both"></div>
                <ul id="product_images_list">
                    <?php if ( $product_images !== FALSE ): ?>
                    <?php foreach ( $product_images as $image ): ?>
                    <li id="product-image-<?php echo $image->id; ?>">
                        <a href="<?php echo site_url() . 'admin/products/image_edit/' . $image->id; ?>" class="edit_image">
                            <img src="<?php echo site_url() . 'products/tiny_thumbnail/' . $image->filename; ?> " alt="<?php echo $image->name ?>" title="<?php echo 'Title: ' . $image->name; ?>" />
                            <?php echo form_hidden('action_to[]', $image->id); ?>
                        </a>
                        <a href="<?php echo site_url() . 'admin/products/image_delete/' . $image->id; ?>" class="delete_button delete_image">Eliminar</a>
                    </li>
                    <?php endforeach; ?>
                    <?php endif; ?>
                </ul>
                <div class="clear-both"></div>
            </li>
            <?php endif; ?>
		</ol>
        <?php endif; ?>
	</div>

</div>

<div class="buttons float-right padding-top">
	<?php $this->load->view('admin/partials/buttons', array('buttons' => array('save', 'save_exit', 'cancel'))); ?>
</div>
<?php echo form_close(); ?>
