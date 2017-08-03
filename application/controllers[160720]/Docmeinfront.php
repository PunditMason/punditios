<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Docmeinfront extends CI_Controller {

   public function verifyemail()
    {
	if(isset($_GET['email']) && !empty($_GET['email']) AND isset($_GET['hash']) && !empty($_GET['hash'])){
		
         // Verify data
		    $query = $this->db->get_where('tb_appusers',array('useremail' => $_GET['email'],'hashverify' => $_GET['hash']));
			$getfindquery = $query->result_array();
			//echo "<pre>";
			//print_r($getfindquery);
			//exit;
			if(count($getfindquery)==1){
				
			$data = array(
               'userstatus' => '2',
            );
            $this->db->where(array('useremail' => $_GET['email'],'hashverify' => $_GET['hash']));
			$this->db->update('tb_appusers', $data);
			$this->load->helper('url');
            $this->load->view('front/thankyou');
				
			} else {
				echo "something went wrong!!!Email has not verified try again";
				exit;
				// Invalid approach
			}
	}else{
		echo "something went wrong!!!Email has not verified try again";
		exit;
		// Invalid approach
	}
		
    }
	
	
	
	
}
