<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * User: pablo
 * Date: 04/05/11
 * Time: 14:41
 * To change this template use File | Settings | File Templates.
 */
 
class Ads_prices_m extends MY_Model {

    function get_by_duration_and_category($id,$cat_id){
        $this->db->select('*');
        $this->db->where('id',$id);
        $this->db->where('ad_category_id',$cat_id);
        $query=$this->db->get($this->_table);
        if(!$row=$query->row()){
            $this->db->select('*');
            $this->db->where('id',$id);
            $this->db->where('ad_category_id',0);
            $query=$this->db->get($this->_table);
            $row=$query->row();
        };
        return $row;
    }


    function options_list_by_category($cat_id){
        //If there are no category specific values, use the general values
        If(!$values=$this->db->where('ad_category_id',$cat_id)
                        ->get($this->_table)->result()){
            $values=$this->db->where('ad_category_id',0)
                        ->get($this->_table)->result();
        }
        $list=array();
        foreach($values as $value){
            $list[$value->id]=$value->title;
        }
        return $list;
    }

}
