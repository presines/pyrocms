{pyro:theme:partial name="breadcrumbs"}
<div class="prods_divheader">
    <div class="prods_headerimg">
      <?php if($product->headerimg_path): ?>
        <img src="<?php echo base_url() . 'uploads/products/headers/'. $product->headerimg_path ?>" />
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