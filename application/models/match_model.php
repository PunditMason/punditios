<?php
error_reporting('0');
class Match_model extends CI_Model {

    private $teams;

    public function __construct()
    {
        $this->load->database();
        $this->get_teams();
    }

    function get_teams() {
        if(!$this->teams) {
            $this->db->select('*');
            $this->db->from('team');
            $query = $this->db->get();
            $teams = array();
            if(count($query) > 0) {
                foreach( $query->result_array() as $row ) {
                    $teams[] = $row['name'];
                }
            }
            $this->teams = $teams;
        }

        return $this->teams;
    }

    public function get_match_by_id($id)
    {
        $this->db->select('*');
        $this->db->from('match');
        $this->db->where('id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_match()
    {
        $this->db->select('*');
        $this->db->from('match');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_match_name()
    {
        $this->db->select('*');
        $this->db->from('match');
        $query = $this->db->get();

        $matches = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $matches[] = $this->teams[$row['team1_id']] . ' VS ' . $this->teams[$row['team2_id']];
            }
        }
        return $matches;
    }

    public function get_all_match_name_indexed()
    {
        $this->db->select('*');
        $this->db->from('match');
        $query = $this->db->get();

        $matches = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $matches[$row['id']] = $this->teams[$row['team1_id']] . ' VS ' . $this->teams[$row['team2_id']];
            }
        }
        return $matches;
    }

    function add_match($data)
    {
        $insert = $this->db->insert('match', $data);
        return $insert;
    }

    function update_match($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('match', $data);
        $report = array();
        $report['error'] = $this->db->_error_number();
        $report['message'] = $this->db->_error_message();
        if($report !== 0){
            return true;
        }else{
            return false;
        }
    }

    function delete_match($id){
        $this->db->where('id', $id);
        $this->db->delete('match');
    }

    function get_match_from_season( $seasons )
    {
        $matches = array();

        if(count($seasons) > 0) {
            $this->db->select('id');
            $this->db->from('match');
            $this->db->where('season_id', $seasons[0]['id']);
            $season_count = count($seasons);

            for($i = 1; $i < $season_count; $i++) {
                $this->db->or_where('season_id', $seasons[$i]['id']);
            }
            $query = $this->db->get();
            if(count($query) > 0) {
                $matches = $query->result_array();
            }
        }

        return $matches;
    }
}
?>	
