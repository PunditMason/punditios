<?php
error_reporting(0);
class Sport_model extends CI_Model {

    public function __construct()
    {
        $this->load->database();
    }

    public function get_sport_by_id($id)
    {
        $this->db->select('*');
        $this->db->from('sport');
        $this->db->where('tb_id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_sport_icon()
    {
        $this->db->select('*');
        $this->db->from('sport');
     
        $query = $this->db->get();

        $sports_icon = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $sports_icon[] = $row['avatar'];
            }
        }
        return $sports_icon;
    }

    public function get_all_sport_icon_indexed()
    {
        $this->db->select('*');
        $this->db->from('sport');
        $query = $this->db->get();

        $sports_icon = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $sports_icon[$row['tb_id']] = $row['image'];
            }
        }
        return $sports_icon;
    }

    public function get_all_sport_name()
    {
        $this->db->select('*');
        $this->db->from('sport');
      
        $query = $this->db->get();

        $sports = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $sports[] = $row['name'];
            }
        }
        return $sports;
    }

    public function get_all_sport_name_indexed()
    {
        $this->db->select('*');
        $this->db->from('sport');
        $query = $this->db->get();

        $sports = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $sports[$row['id']] = $row['name'];
            }
        }
        return $sports;
    }

    public function get_all_sport()
    {
        $this->db->select('*');
        $this->db->from('sport');
             $this->db->order_by('position','asc');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_sport($sport_id = null, $search_string = null, $order = null, $order_type = 'Asc', $limit_start, $limit_end)
    {

        $this->db->select('*');
        $this->db->from('sport');
        if($sport_id != null && $sport_id != 0){
            $this->db->where('tb_id', $sport_id);
        }
        if($search_string){
            $this->db->like('name', $search_string);
        }

        $this->db->group_by('sport.id');

        if($order){
            $this->db->order_by($order, $order_type);
        }else{
            $this->db->order_by('tb_id', $order_type);
        }

        $this->db->limit($limit_start, $limit_end);
        //$this->db->limit('4', '4');

        $query = $this->db->get();

        return $query->result_array();
    }

    function count_sports($sport_id = null, $search_string = null, $order = null)
    {
        $this->db->select('*');
        $this->db->from('sport');
        if($sport_id != null && $sport_id != 0){
            $this->db->where('tb_id', $sport_id);
        }
        if($search_string){
            $this->db->like('name', $search_string);
        }
        if($order){
            $this->db->order_by($order, 'Asc');
        }else{
            $this->db->order_by('tb_id', 'Asc');
        }
        $query = $this->db->get();
        return $query->num_rows();
    }

    function add_sport($data)
    {
        $insert = $this->db->insert('sport', $data);
        return $insert;
    }

    function update_sport($id, $data)
    {
        $this->db->where('tb_id', $id);
       $update = $this->db->update('sport', $data);
        return $update;
       /* $report = array();
        $report['error'] = $this->db->_error_number();
        $report['message'] = $this->db->_error_message();
        if($report !== 0){
            return true;
        }else{
            return false;
        }*/
    }

    function delete_sport($id){
        $this->db->where('tb_id', $id);
        $this->db->delete('sport');
    }

}
?>	
