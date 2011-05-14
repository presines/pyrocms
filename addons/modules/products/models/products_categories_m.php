<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
/**
 * Categories model
 *
 * @package		PyroCMS
 * @subpackage	Categories Module
 * @category	Modules
 */
class Products_categories_m extends MY_Model
{

	protected $_table = 'product_categories';

    public function get_featured(){
        $this->db->select("*, CONCAT('products/category/',`slug`) as `url`");
		$this->db->order_by('ordering', 'ASC');
        $this->db->where('featured',1);
        $query=$this->db->get($this->_table);

		return $query->result();    
    }

    public function get_children($id=0){
        $this->db->select("*, CONCAT('products/category/',`slug`) as `url`");
		$this->db->order_by('ordering', 'ASC');
        $this->db->where('parent_id',$id);
        $query=$this->db->get($this->_table);

		return $query->result();
    }


	// ------------------------------------------------------------------------

	/**
	 * Category Tree
	 *
	 * Get category in an array
	 *
	 * @uses category_subtree
	 */
	public function category_tree($parent_id = 0, $depth = 0, &$arr = array())
	{
		$arr = $arr ? $arr : array();

		if ($parent_id === 0)
		{
			$arr	= array();
			$depth	= 0;
		}

		$categories = $this
			->order_by('ordering')
			->get_many_by(array('parent_id' => $parent_id));

		if ( ! $categories)
		{
			return $arr;
		}

		static $root = NULL;

		foreach ($categories as $category)
		{
			$category->name_indent		= repeater('&raquo; ', $depth) . $category->title;
			$category->depth				= $depth;
			$category->count_products		= sizeof($this->db->get_where('products', array('product_category_id' => $category->id))->result());
			$arr[$category->id]			= $category;
			$old_size					= sizeof($arr);

			$this->category_tree($category->id, $depth+1, $arr);

			$category->count_subcategories	= sizeof($arr) - $old_size;
		}

		return $arr;
	}


	// ------------------------------------------------------------------------

	/**
	 * Get Categories
	 *
	 * Get the full array of categories
	 *
	 * @return 	array
	 */
	public function get_categories($id = 0)
	{
        $categories=array();
		$this->category_tree($id,0,$categories);

		return $categories;
	}

	/**
	 * Insert a new category into the database
	 * @access public
	 * @param array $input The data to insert
	 * @return string
	 */
	public function insert($input = array())
    {
    	$this->load->helper('text');
    	parent::insert(array(
        	'title'=>$input['title'],
        	'slug'=>url_title(strtolower(convert_accented_characters($input['title'])))
        ));
        return $input['title'];
    }
    
	/**
	 * Update an existing category
	 * @access public
	 * @param int $id The ID of the category
	 * @param array $input The data to update
	 * @return bool
	 */
    public function update($id, $input)
	{
		return parent::update($id, array(
            'title'	=> $input['title'],
            'slug'	=> url_title(strtolower(convert_accented_characters($input['title'])))
		));
    }

	/**
	 * Callback method for validating the title
	 * @access public
	 * @param string $title The title to validate
	 * @return mixed
	 */
	public function check_title($title = '')
	{
		return parent::count_by('slug', url_title($title)) > 0;
	}
	
	/**
	 * Insert a new category into the database via ajax
	 * @access public
	 * @param array $input The data to insert
	 * @return int
	 */
	public function insert_ajax($input = array())
	{
		$this->load->helper('text');
		return parent::insert(array(
				'title'=>$input['title'],
				//is something wrong with convert_accented_characters?
				//'slug'=>url_title(strtolower(convert_accented_characters($input['title'])))
				'slug' => url_title(strtolower($input['title']))
				));
	}

    public function options_list(){
        $values=$this->db->get($this->_table)->result();
        $list=array();
        foreach($values as $value){
            $list[$value->id]=$value->title;
        }
        return $list;
    }
}