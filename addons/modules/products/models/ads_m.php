<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Ads_m extends MY_Model {

	protected $_table = 'ads';

	function get_all()
	{
		$this->db->select('ads.*, c.title AS category_title, c.slug AS category_slug');
		$this->db->join('ads_categories c', 'ads.ad_category_id = c.id', 'left');

		$this->db->order_by('title', 'DESC');

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


		$this->db->select('ads.*, c.title AS category_title, c.slug AS category_slug');
		$this->db->join('ads_categories c', 'ads.ad_category_id = c.id', 'left');

        return $this->db->count_all_results($this->_table);
    }


    function distinct_values_by($field, $params = array()){
        $this->set_filters($params);

        $this->db->select($field);
		$this->db->join('ads_categories c', 'ads.ad_category_id = c.id', 'left');
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

		if (!empty($params['month']))
		{
			$this->db->where('MONTH(FROM_UNIXTIME(created_on))', $params['month']);
		}

		if (!empty($params['year']))
		{
			$this->db->where('YEAR(FROM_UNIXTIME(created_on))', $params['year']);
		}

		if (empty($params['date_range']) or $params['date_range']!='all') {
            //show only current ads
            $this->db->where('start_date<=now()',NULL,false);
            $this->db->where('expiration_date>=now()',NULL,false);
        }

        if (!empty($params['starred'])) {
            if($params['starred']=='section' or $params['starred']=='true' ){
                $this->db->where("(starred='section' or starred='home')",NULL,false);
            } elseif($params['starred']=='home'){
                $this->db->where("starred='home'",NULL,false);
            }

            $this->db->order_by('RAND()','DESC');
        }

        if (!empty($params['keyword'])){
            $keywords=explode(' ',$params['keyword']);
            foreach($keywords as $keyword){
                if ($this->ion_auth->is_admin()){
                    $admin_fields="or `ads`.`first_name` like '%$keyword%'" .
                                  "or `ads`.`last_name` like '%$keyword%'" .
                                  "or `ads`.`address_1` like '%$keyword%'" .
                                  "or `ads`.`address_2` like '%$keyword%'" .
                                  "or `ads`.`city` like '%$keyword%'" .
                                  "or `ads`.`state` like '%$keyword%'" .
                                  "or `ads`.`phone` like '%$keyword%'" .
                                  "or `ads`.`email` like '%$keyword%'";
                } else {
                    $admin_fields="";
                }
                $this->db->where("(`ads`.`title` like '%$keyword' " .
                                 "or `ads`.`body` like '%$keyword%'" .
                                 "or `ads`.`city` like '%$keyword%'" .
                                 "or `ads`.`state` like '%$keyword%'" .
                                 "or `ads`.`ad_city` like '%$keyword%'" .
                                 "or `ads`.`ad_state` like '%$keyword%'" .
                                 "or `ads`.`ad_rs_property_type` like '%$keyword%'" .
                                 "or `ads`.`ad_rs_offer_type` like '%$keyword%'" .
                                 "or `ads`.`ad_motor_make` like '%$keyword%'" .
                                 "or `ads`.`ad_motor_model` like '%$keyword%'" .
                                 "or `ads`.`ad_motor_year` like '%$keyword%'" .
                                 $admin_fields .
                                 ")");
            }
        }

        foreach($params as $field=>$value){
            if(substr($field,0,4)=='ads_'  and !empty($value)
                                           and (!in_array($field,array('user_id','first_name','last_name',
                                                                      'address_1','address_2','city','state',
                                                                      'phone','email')) or $this->ion_auth->is_admin())){
                $field=str_replace(':lte',' <=',$field);
                $field=str_replace(':lt',' <',$field);
                $field=str_replace(':gte',' >=',$field);
                $field=str_replace(':gt',' >',$field);
                $field=str_replace(':ne',' !=',$field);
                $this->db->where('ads.' . substr($field,4),$value);
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