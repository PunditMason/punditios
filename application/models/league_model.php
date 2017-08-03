<?php
class League_model extends CI_Model {

    public function __construct()
    {
        $this->load->database();
    }

    public function get_league_by_id($id)
    {
	
        $this->db->select('*');
        $this->db->from('league');
        $this->db->where('tb_id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_league()
    {
        $this->db->select('*');
        $this->db->from('league');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_leagues_indexed()
    {
        $this->db->select('*');
        $this->db->from('league');
        $query = $this->db->get();

        $leagues = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $leagues[$row['id']] = $row['name'];
            }
        }
        return $leagues;
    }

    public function get_all_league_name()
    {
        $this->db->select('*');
        $this->db->from('league');
        $query = $this->db->get();

        $leagues = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $leagues[] = $row['name'];
            }
        }
        return $leagues;
    }

    function add_league($data)
    {
        $insert = $this->db->insert('league', $data);
        return $insert;
    }

    function update_league($id, $data)
    {
        $this->db->where('tb_id', $id);
        $update = $this->db->update('league', $data);
        return $update;
      /*  $report = array();
        $report['error'] = $this->db->_error_number();
        $report['message'] = $this->db->_error_message();
        if($report !== 0){
            return true;
        }else{
            return false;
        }*/
    }

    function delete_league($id){
        $this->db->where('tb_id', $id);
        $this->db->delete('league');
    }

}
?>	
