<?php
 error_reporting(0);
 class Cover_model extends CI_Model {

   /**
    * Validate the login's data with the database
    * @param string $email
    * @param string $password
    * @return user name
    */
    
    
    
    function get_cover()
    {
        $this->db->select('*');
        $this->db->from('cover_image');
        $query = $this->db->get();
        return $query->result_array();
    }

     public function get_cover_id($id)
    {
        $this->db->select('*');
        $this->db->from('cover_image');
        $this->db->where('id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    function add_cover($data)
    {
        $insert = $this->db->insert('cover_image', $data);
        return $insert;
    }

    function update_cover($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('cover_image', $data);
        $report = array();
        $report['error'] = $this->db->_error_number();
        $report['message'] = $this->db->_error_message();
        if($report !== 0){
            return true;
        }else{
            return false;
        }
    }
    function delete_cover($id){
        $this->db->where('id', $id);
        $this->db->delete('cover_image');
    }
    
  }

  ?>
