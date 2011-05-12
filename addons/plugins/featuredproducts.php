<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * Ads Plugin
 *
 * @package		SevendeYa
 * @author		Pablo Resines
 * @copyright	Copyright (c) 2008 - 2011, Pablo Resines
 *
 */
class Plugin_Featuredproducts extends Plugin
{

	function links()
	{
		$this->load->model('products/products_categories_m');
		$featured_items = $this->products_categories_m->get_featured();


        $output='<!-- Featured Products plugin -->'."\n";
        $output=$output . '<div class="myJac"><ul>'."\n";
        foreach($featured_items as $item){
            $href=site_url($item->url);
            $output=$output . '<li><div class="prods_featured_item">'."\n";
            $output=$output . '	 <div class="prods_featured_item_thumb">'."\n";
            $output=$output . '    <a href="' . $href .'"><img src="' . base_url() . "uploads/categories/thumbnails/". $item->thumbnail_path . '" /></a>'."\n";
            $output=$output . '  </div>'."\n";
            $output=$output . '  <div class="prods_featured_item_title">'."\n";
            $output=$output . '    <a href="' . $href . '"><span>' . $item->title . '</span></a>'."\n";
            $output=$output . '  </div>'."\n";
            $output=$output . '</div></li>'."\n";
        }
        $output=$output . '</ul></div>'."\n";
        return $output;
	}
}

/* End of file plugin.php */