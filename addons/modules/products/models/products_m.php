<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Products_m extends MY_Model {

	protected $_table = 'products';

    function get_all()
    {
        $this->db->select('products.*, c.title AS category_title, c.slug AS category_slug');
        $this->db->join('product_categories c', 'products.product_category_id = c.id', 'left');

        $this->db->order_by('title', 'DESC');

        $query=$this->db->get($this->_table);
        
        return $query->result();
    }


    function get_by_category($cat_id){
        $this->db->select('*');
        $this->db->where('product_category_id',$cat_id);

        $this->db->order_by('ordering','ASC');

        $query=$this->db->get($this->_table);

        return $query->result();
    }

    function get_many_by($params = array()){
        $this->set_filters($params);

		// Limit the results based on 1 number or 2 (2nd is offset)
		if (isset($params['limit']) && is_array($params['limit']))
			$this->db->limit($params['limit'][0], $params['limit'][1]);
		elseif (isset($params['limit']))
			$this->db->limit($params['limit']);

		return $this->get_all();
    }

    function count_by($params = array()){
        $this->set_filters($params);


		$this->db->select('products.*, c.title AS category_title, c.slug AS category_slug');
		$this->db->join('product_categories c', 'products.product_category_id = c.id', 'left');

        return $this->db->count_all_results($this->_table);
    }


    function distinct_values_by($field, $params = array()){
        $this->set_filters($params);

        $this->db->select($field);
		$this->db->join('product_categories c', 'products.product_category_id = c.id', 'left');
        $this->db->group_by($field);

        $query=$this->db->get($this->_table);

		return $query->result();
    }


	function publish($id = 0)
	{
		return parent::update($id, array('status' => 'live'));
	}

	function set_filters($params = array())
	{
		$this->load->helper('date');

		if (!empty($params['category']))
		{
			if (is_numeric($params['category']))
				$this->db->where('c.id', $params['category']);
			else
				$this->db->where('c.slug', $params['category']);
		}


        if (!empty($params['keyword'])){
            $keywords=explode(' ',$params['keyword']);
            foreach($keywords as $keyword){
                $this->db->where("(`products`.`title` like '%$keyword' " .
                                 "or `products`.`body` like '%$keyword%'" .
                                 "or `products`.`description` like '%$keyword%'" .
                                 ")");
            }
        }

        foreach($params as $field=>$value){
            if(substr($field,0,4)=='products_'  and !empty($value)
                                           and (!in_array($field,array('user_id','first_name','last_name',
                                                                      'address_1','address_2','city','state',
                                                                      'phone','email')) or $this->ion_auth->is_admin())){
                $field=str_replace(':lte',' <=',$field);
                $field=str_replace(':lt',' <',$field);
                $field=str_replace(':gte',' >=',$field);
                $field=str_replace(':gt',' >',$field);
                $field=str_replace(':ne',' !=',$field);
                $this->db->where('products.' . substr($field,4),$value);
            }
        }
		        
		// Is a status set?
		if (!empty($params['status']))
		{
			// If it's all, then show whatever the status
			if ($params['status'] != 'all')
			{
				// Otherwise, show only the specific status
				$this->db->where('status', $params['status']);
			}
		}

		// Nothing mentioned, show live only (general frontend stuff)
		else
		{
			$this->db->where('status', 'live');
		}
	}

}