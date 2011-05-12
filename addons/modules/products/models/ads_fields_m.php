<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * User: pablo
 * Date: 04/05/11
 * Time: 14:41
 * To change this template use File | Settings | File Templates.
 */
 
class Ads_fields_m extends MY_Model {
    function get_with_category(){
        $this->db->select('ads_fields.*, c.id as ad_category_id, c.title AS category_title, c.slug AS category_slug');
		$this->db->join('ads_fields_categories as fc', 'ads_fields.id = fc.field_id');
		$this->db->join('ads_categories c', 'fc.ad_category_id = c.id');

		$this->db->order_by('`order`', 'ASC');

        $query=$this->db->get($this->_table);

		return $query->result();
    }

    function values_list($field_name){
        if($field=$this->db->where('name',$field_name)->get($this->_table)->row()){
            $values=$this->db->select('title, value')
                            ->where('field_id',$field->id)
                            ->get('ads_fields_values')->result();
            $list=array();
            foreach($values as $value){
                $list[$value->value]=$value->title;
            }
            return $list;
        } else {
            return array();
        }

    }

    function states_list(){
        $states=$this->db->select('state_name')->get('ads_cat_states')->result();
        $list=array();
        foreach($states as $state){
            $list[$state->state_name]=$state->state_name;
        }
        return $list;
    }

    function counties_list($state){
        if($state=$this->db->where('state_name',$state)->get('ads_cat_states')->row()){
            $cities=$this->db->select('county_name')
                            ->where('state_id',$state->id)
                            ->get('ads_cat_counties')->result();
            $list=array();
            foreach($cities as $city){
                $list[$city->county_name]=$city->county_name;
            }
            return $list;
        } else {
            return array(''=>'Selecciona el Estado');
        }

    }

}
