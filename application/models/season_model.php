<?php
error_reporting(0);
class Season_model extends CI_Model {

    public function __construct()
    {
        $this->load->database();
    }

    public function get_season_by_id($id)
    {
        $this->db->select('*');
        $this->db->from('season');
        $this->db->where('tb_id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_season()
    {
        $this->db->select('*');
        $this->db->from('season');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_season_name()
    {
        $this->db->select('*');
        $this->db->from('season');
        $query = $this->db->get();

        $seasons = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $seasons[] = $row['name'];
            }
        }
        return $seasons;
    }

    public function get_all_season_name_indexed()
    {
        $this->db->select('*');
        $this->db->from('season');
        $query = $this->db->get();

        $seasons = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $seasons[$row['id']] = $row['name'];
            }
        }
        return $seasons;
    }

    function add_season($data)
    {
        $insert = $this->db->insert('season', $data);
        return $insert;
    }

    function update_season($id, $data)
    {
        $this->db->where('tb_id', $id);
       $update = $this->db->update('season', $data);
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

    function delete_season($id){
        $this->db->where('tb_id', $id);
        $this->db->delete('season');
    }

    function get_season_from_sport( $sport = '0', $league = '0' )
    {
        $season = array();

        $this->db->select('id');
        $this->db->from('season');
        if($sport != '0') {
            $this->db->where('sport_id', $sport);
        }
        if($league != '0') {
            $this->db->where('league_id', $league);
        }

        $query = $this->db->get();
        if(count($query) > 0) {
            $season = $query->result_array();
        }

        return $season;
    }
}
?>	
