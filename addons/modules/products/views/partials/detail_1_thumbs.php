
  <div id="thumb_container">
    <?php $cont=0; ?>
    <?php foreach($images as $image): ?>
    <?php if($cont>0): ?>
        <div class="prods_thumb">
            <div class="prods_catalog_item_thumb">
                <a href="<?php echo site_url('products/full_image') . '/'. $image->filename ?>" title="<?php echo $image->name ?>" class="zoomable_image" rel="product_images">
                    <img src="<?php echo site_url('products/thumbnail') . '/'. $image->filename ?>" />
                </a>
            </div>
        </div>
    <?php endif; ?>
    <?php $cont++; ?>
    <?php endforeach; ?>
  </div>