{pyro:theme:partial name="breadcrumbs"}
<div class="prods_divheader">
    <div class="prods_headerimg">
      <?php if(count($images)>0): ?>
        <a href="<?php echo site_url('products/full_image') . '/'. $images[0]->filename ?>" title="<?php echo $images[0]->name ?>" class="zoomable_image" rel="product_images">
            <img src="<?php echo site_url('products/header_image') . '/'. $images[0]->filename ?>" />
        </a>
      <?php else: ?>
        <img src="<?php echo base_url() . 'uploads/products/headers/default.jpg' ?>" />
      <?php endif; ?>
    </div>
    <div class="prods_headerside">
        <div id="titlediv"><h2><?php echo  $product->title ?></h2>
        </div>
        <div id="descrdiv">
          <?php echo  $product->description ?>
        </div>
    </div>
</div>
<div class="prods_detail_1">
  <?php echo  $template['partials']['detail_1_thumbs'] ?>
  <?php echo  $product->body ?>
</div>
<script type="text/javascript">
    function init() {
        // fancybox options
        $("a.zoomable_image").fancybox({
            'hideOnContentClick': true,
            'titlePosition' : 'inside'
        });        
    }

    $(init); // on DOM ready
</script>