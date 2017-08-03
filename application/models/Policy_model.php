<?php
error_reporting('0');
class Policy_model extends CI_Model {

    public function __construct()
    {
        $this->load->database();
        
    }

   public function get_policy_by_id($id)
    {
        $this->db->select('*');
        $this->db->from('tb_privacy_policy');
        $this->db->where('id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_policy()
    {
        $this->db->select('*');
        $this->db->from('tb_privacy_policy');
        $query = $this->db->get();
        return $query->result_array();
    }

    
    function add_policy($data)
    {
        $insert = $this->db->insert('tb_privacy_policy', $data);
        return $insert;
    }

    function update_policy($id, $data)
    {
        $this->db->where('id', $id);
       $update = $this->db->update('tb_privacy_policy', $data);
       return $update;
      /*  $report = array();
        $report['error'] = $this->db->error();
        $report['message'] = $this->db->error();
        if($report !== 0){
            return true;
        }else{
            return false;
        }*/
    }

    function delete_policy($id){
        $this->db->where('id', $id);
        $this->db->delete('tb_privacy_policy');
    }

    
}
?>	
