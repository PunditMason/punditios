<?php class upload_model extends CI_Model {
	  function __construct() { 
         parent::__construct(); 
      } 
 public function insert($data)
	  {
		  if ($this->db->insert("sport",$data)){
			  return true;
		  }
	  }
}
?>
