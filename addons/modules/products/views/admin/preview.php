<h1><?php echo $product->title; ?></h1>

<p style="float:left; width: 40%;">
	<?php echo anchor('products/view/'. $product->slug, NULL, 'target="_blank"'); ?>
</p>

<p style="float:right; width: 40%; text-align: right;">
	<?php echo anchor('admin/products/edit/'. $product->id, lang('products_edit_label'), ' target="_parent"'); ?>
</p>

<iframe src="<?php echo site_url('products/view/'. $product->slug); ?>" width="99%" height="400"></iframe>