<?php
class Country_model extends CI_Model {

    public function __construct()
    {
        $this->load->database();
    }

    public function get_all_countries()
    {
        $this->db->select('name');
        $this->db->from('countries');
        $query = $this->db->get();

        $countries = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $val ) {
                $countries[] = $val['name'];
            }
        }
        return $countries;
    }

    public function get_all_national_flags()
    {
        $this->db->select('alpha_2');
        $this->db->from('countries');
        $query = $this->db->get();

        $national_flag = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $val ) {
                $national_flag[] = $val['alpha_2'];
            }
        }
        return $national_flag;
    }
}
?>
