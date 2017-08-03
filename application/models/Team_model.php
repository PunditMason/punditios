<?php
class Team_model extends CI_Model {

    public function __construct()
    {
        $this->load->database();
    }

    public function get_team_by_id($id)
    {
        $this->db->select('*');
        $this->db->from('team');
        $this->db->where('id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_team()
    {
        $this->db->select('*');
        $this->db->from('team');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_team_name()
    {
        $this->db->select('*');
        $this->db->from('team');
        $query = $this->db->get();

        $teams = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $teams[] = $row['name'];
            }
        }
        return $teams;
    }

    public function get_all_team_name_indexed()
    {
        $this->db->select('*');
        $this->db->from('team');
        $query = $this->db->get();
  
        $teams = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $teams[$row['id']] = $row['name'];
            }
        }
		 //print_r($teams);
        return $teams;
    }

    public function get_team($team_id = null, $search_string = null, $order = null, $order_type = 'Asc', $limit_start, $limit_end)
    {

        $this->db->select('*');
        $this->db->from('team');
        if($team_id != null && $team_id != 0){
            $this->db->where('id', $team_id);
        }
        if($search_string){
            $this->db->like('name', $search_string);
        }

        $this->db->group_by('team.id');

        if($order){
            $this->db->order_by($order, $order_type);
        }else{
            $this->db->order_by('id', $order_type);
        }

        $this->db->limit($limit_start, $limit_end);
        //$this->db->limit('4', '4');

        $query = $this->db->get();

        return $query->result_array();
    }

    function count_teams($team_id = null, $search_string = null, $order = null)
    {
        $this->db->select('*');
        $this->db->from('team');
        if($team_id != null && $team_id != 0){
            $this->db->where('id', $team_id);
        }
        if($search_string){
            $this->db->like('name', $search_string);
        }
        if($order){
            $this->db->order_by($order, 'Asc');
        }else{
            $this->db->order_by('id', 'Asc');
        }
        $query = $this->db->get();
        return $query->num_rows();
    }

    function add_team($data)
    {
        $insert = $this->db->insert('team', $data);
        return $insert;
    }

    function update_team($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('team', $data);
        $report = array();
        $report['error'] = $this->db->_error_number();
        $report['message'] = $this->db->_error_message();
        if($report !== 0){
            return true;
        }else{
            return false;
        }
    }

    function delete_team($id){
        $this->db->where('id', $id);
        $this->db->delete('team');
    }

}
?>	
