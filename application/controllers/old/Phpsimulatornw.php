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
	
	public function getusercategory(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/getusercategory');
		
	}
	public function getusersubcategory(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/getusersubcategory');
		
	}
	
	public function addusercategory(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/addusercategory');
		
	}
	
	public function getprofile()
    {
		$this->load->helper('url');
        $this->load->view('phpsimulator/getprofile');
    }
	
	public function updateprofile()
    {
		$this->load->helper('url');
        $this->load->view('phpsimulator/updateprofile');
    }
	
	public function logout(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/logout');
		
	}
	
	public function forgotpassword(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/forgotpassword');
    }
	
	public function addcontact(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/addcontact');
		
	}
	
	public function getcontactlist(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/getcontactlist');
		
	}
	
	public function getcontactdetail(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/getcontactdetail');
		
	}
	
	public function updatecontactdetail(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/updatecontactdetail');
		
	}
	
	public function deletecontact(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/deletecontact');
		
	}
	
	public function adddocument(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/adddocument');
		
	}
	
	public function getdocument(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/getdocument');
		
	}
	
	public function updatedocument(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/updatedocument');
		
	}
	
	public function deletedocument(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/deletedocument');
		
	}
	
	
	public function resendverification(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/resendverification');
		
	}
	
	public function contactus(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/contactus');
		
	}
	
	public function aboutus(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/aboutus');
		
	}
	
	public function getcontactdocuments(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/getcontactdocuments');
		
	}
	
	
	public function fblogin(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/fblogin');
    }
	public function gpluslogin(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/gpluslogin');
    }
	public function changepassword(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/changepassword');
    }
		public function importcontacts(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/importcontacts');
    }
		public function privacypolicy(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/privacypolicy');
    }
	public function terms_condition(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/terms_condition');
    }
    
		
		public function upprofile_post(){
		$this->load->helper('url');
        $this->load->view('phpsimulator/upprofile_post');
    }
    
    
	
	
	
	
	
	
	
	
	
	
	
}
