<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Phpsimulatornw extends CI_Controller {

   public function checkversion()
    {
		$this->load->helper('url');
        $this->load->view('phpsimulator/checkversion');
    }
	
	public function registeruser()
    {
		$this->load->helper('url');
        $this->load->view('phpsimulator/registeruser');
    }
	
	public function applogin(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/loginuser');
		
	}
	public function fblogin(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/fblogin');
    }
	public function gpluslogin(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/gpluslogin');
    }
	public function forgotpassword(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/forgotpassword');
    }
	
	public function addmember(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/forgotpassword');
		
	}
	
	public function addcategory(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/addcategory');
		
	}
	
	public function logout(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/logout');
		
	}
	
	
	
	
}
