{pyro:theme:partial name="breadcrumbs"}
<div class="prods_divheader">
    <div class="prods_headerimg">
        <img src="<?php echo base_url() . 'uploads/pr/headers/'. $category->headerimg_path ?>" />
    </div>
    <div class="prods_headerside">
        <div id="titlediv"><h2><?php echo  $category->title ?></h2>
        </div>
        <div id="descrdiv">
          <?php echo  $category->description ?>
        </div>
    </div>
</div>
<div class="prods_catalog">
    <?php echo  $template['partials']['item_list'] ?>
</div>
    	