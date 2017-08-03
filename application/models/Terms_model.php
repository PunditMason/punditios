<?php
error_reporting('0');
class Terms_model extends CI_Model {

    public function __construct()
    {
        $this->load->database();
        
    }

   public function get_terms_by_id($id)
    {
        $this->db->select('*');
        $this->db->from('tb_term_condition');
        $this->db->where('id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_terms()
    {
        $this->db->select('*');
        $this->db->from('tb_term_condition');
        $query = $this->db->get();
        return $query->result_array();
    }

    
    function add_terms($data)
    {
        $insert = $this->db->insert('tb_term_condition', $data);
        return $insert;
    }

    public function update_terms($id, $data)
    {
		$this->db->where('id', $id);
        $update = $this->db->update('tb_term_condition', $data);
        return $update;

     
    }

    function delete_terms($id){
        $this->db->where('id', $id);
        $this->db->delete('tb_term_condition');
    }

    
}
?>	
