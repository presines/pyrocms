    <div class="prods_catalog">
	<?php foreach ($featured_items as $item) {
		$href=site_url($item->url); ?>
        <!-- producto o categoria -->
    	<div class="prods_featured_item">
        	<div class="prods_featured_item_thumb">
            	<a href="<?php echo $href; ?>"><img src="<?php echo base_url() . "uploads/divisiones/thumbnails/". $item->thumbnail ?>" /></a>
            </div>
            <div class="prods_featured_item_title">
            	<a href="<?php echo $href; ?>"><span><?php echo $item->title; ?></span></a>
            </div>
        </div>
     <?php } ?>
    </div> 
