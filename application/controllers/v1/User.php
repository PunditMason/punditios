<?php

class User extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		//$this->output->enable_profiler(TRUE);
		$this->load->helper('url_helper');
        $this->load->library('form_validation');
        $this->load->library('session');
	//	$this->load->model('User_model');
	}
   
   public function updateprofile()
   {
	    $userid = $this->input->post('userId');
     //$email = $_POST['email'];
    // $id = $_REQUEST['name'];
	   if(isset($userid)){
		   echo "fine";
		   if($userid!= ''){
			   echo "not null";
		   }
	    } 
	    
	/*    if(isset($email)){
		   echo "email fine";
		   if($email!= ''){
			   echo "not null email";
		   }
	    } 
	        if(isset($id)){
		   echo "name fine";
		   if($id!= ''){
			   echo "not null name";
		   }
	    } */
	   // var_dump($_POST);
	    if ($_SERVER['REQUEST_METHOD'] == 'GET'){
   echo "get";
}
else if ($_SERVER['REQUEST_METHOD'] == 'POST'){
echo "post";
}
	}
}
   ?>
