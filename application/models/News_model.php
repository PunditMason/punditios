<?php
error_reporting('0');
class news_model extends CI_Model {

    public function __construct()
    {
        $this->load->database();
        
    }

   public function get_news_by_id($id)
    {
        $this->db->select('*');
        $this->db->from('news');
        $this->db->where('id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_news()
    {
        $this->db->select('*');
        $this->db->from('news');
        $query = $this->db->get();
        return $query->result_array();
    }

    
    function add_news($data)
    {
        $insert = $this->db->insert('news', $data);
        return $insert;
    }

    function update_news($id, $data)
    {
        $this->db->where('id', $id);
       $update= $this->db->update('news', $data);
       return $update;
       /* $report = array();
        $report['error'] = $this->db->error();
        $report['message'] = $this->db->error();
        if($report !== 0){
            return true;
        }else{
            return false;
        }*/
    }

    function delete_news($id){
        $this->db->where('id', $id);
        $this->db->delete('news');
    }

    
}
?>	
