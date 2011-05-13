<?php foreach($subcategories as $item): ?>
    	<div class="prods_catalog_item">
        	<div class="prods_catalog_item_thumb">
            	<a href="<?php echo site_url() . $item->url; ?>"><img src="<?php echo base_url() . 'uploads/categories/thumbnails/' . $item->thumbnail_path; ?>" /></a>
            </div>
            <div class="prods_catalog_item_title">
            	<a href="<?php echo site_url() . $item->url; ?>"><span><?php echo $item->title; ?></span></a>
            </div>
        </div>
<?php endforeach; ?>
<?php foreach($products as $item): ?>
    	<div class="prods_catalog_item">
        	<div class="prods_catalog_item_thumb">
            	<a href="<?php echo site_url('products/view') . '/'. $item->slug; ?>"><img src="<?php echo base_url() . 'uploads/products/thumbnails/' . $item->thumbnail_path; ?>" /></a>
            </div>
            <div class="prods_catalog_item_title">
            	<a href="<?php echo site_url('products/view') . '/'. $item->slug; ?>"><span><?php echo $item->title; ?></span></a>
            </div>
        </div>
<?php endforeach; ?>
 
