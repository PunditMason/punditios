<?php
 error_reporting(0);
 class Banner_model extends CI_Model {

   /**
    * Validate the login's data with the database
    * @param string $email
    * @param string $password
    * @return user name
    */
    
    
    
    function get_banner()
    {
        $this->db->select('*');
        $this->db->from('banner');
        $query = $this->db->get();
        return $query->result_array();
    }

     public function get_banner_id($id)
    {
        $this->db->select('*');
        $this->db->from('banner');
        $this->db->where('id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    function add_banner($data)
    {
        $insert = $this->db->insert('banner', $data);
        return $insert;
    }

    function update_banner($id,$data)
    {
        $this->db->where('id',$id);
       $update = $this->db->update('banner', $data);
 return $update;
      /* $report = array();
        $report['error'] = $this->db->number();
        $report['message'] = $this->db->message();
        if($report !== 0){
            return true;
        }else{
            return false;
        }*/
    }
    function delete_banner($id){
        $this->db->where('id', $id);
        $this->db->delete('banner');
    }
    
  }

  ?>
