<?php

defined('BASEPATH') OR exit('No direct script access allowed');

// This can be removed if you use __autoload() in config.php OR use Modular Extensions
require APPPATH . '/libraries/REST_Controller.php';

/**
 * This is an example of a few basic user interaction methods you could use
 * all done with a hardcoded array
 *
 * @package         CodeIgniter
 * @subpackage      Rest Server
 * @category        Controller
 * @author          Phil Sturgeon, Chris Kacerguis
 * @license         MIT
 * @link            https://github.com/chriskacerguis/codeigniter-restserver
 */
class App extends REST_Controller {

    function __construct()
    {
        // Construct the parent class
        parent::__construct();

        // Configure limits on our controller methods
        // Ensure you have created the 'limits' table and enabled 'limits' within application/config/rest.php
        $this->methods['user_get']['limit'] = 500; // 500 requests per hour per user/key
        $this->methods['user_post']['limit'] = 100; // 100 requests per hour per user/key
        $this->methods['user_delete']['limit'] = 50; // 50 requests per hour per user/key
    }
	
	
	public function checkversion_post(){
	 $appVersion = $this->post('appVersion');	 
	 $webservicesappVersion = '0.1';
	 if(($appVersion) != ($webservicesappVersion)){
		 $this->response(['responsestatus' => FALSE,'app_store_link'=> 'Live link coming soon','message' => 'Please update your application'], REST_Controller::HTTP_UNAUTHORIZED);
	 } else {
		 
		 $this->response(['responsestatus' => TRUE], REST_Controller::HTTP_ACCEPTED);
		  }
	}
	
	
	private function generateRandomString($length = 30) {
		
		$characters = strtotime(date("Y-m-d G:i:s")).'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$charactersLength = strlen($characters);
		$randomString = '';
		for ($i = 0; $i < $length; $i++) {
			$randomString .= $characters[rand(0, $charactersLength - 1)];
		}
		return $randomString;
    }
	
	
	private function checkEmailExistance($email){
		$this->load->database();
		$row = $this->db->get_where('tb_appusers', array('useremail' => $email))->row();
		if(count($row) == 1){
			return 0;
		} else { 
			
			return 1;
			}
	}
	
	private function htmlemailsend($toemail,$hashverify){
		$this->load->helper('url');
		
        $config = Array(       
            'protocol' => 'sendmail',
            'smtp_host' => 'smtp.gmail.com',
            'smtp_port' => 465,
            'smtp_user' => 'abhinandan.arrowbits@gmail.com',
            'smtp_pass' => 'abhinandan@arrowbits',
            'smtp_timeout' => '4',
            'mailtype'  => 'html',
            'charset'   => 'iso-8859-1'
        );
        $this->load->library('email', $config);
        $this->email->set_newline("\r\n");
        $this->email->from('docmein@gmail.com', 'Arrowbits');
        $data = array(
             'touseremail' => $toemail,
			 'hashcode' => $hashverify
                 );
        $this->email->to($toemail);  // replace it with receiver mail id
        $this->email->subject('Docmein - Email Verification'); // replace it with relevant subject
   
        $body = $this->load->view('email/verify',$data,TRUE);
		
        $this->email->message($body);  
        //$this->email->send();
		if($this->email->send()){
			return '1';
		} else {
			return '0';
		}
    }
	
	
	
	private function forgotpassemail($toemail){
		$this->load->helper('url');
		
        $config = Array(       
            'protocol' => 'sendmail',
            'smtp_host' => 'smtp.gmail.com',
            'smtp_port' => 465,
            'smtp_user' => 'abhinandan.arrowbits@gmail.com',
            'smtp_pass' => 'abhinandan@arrowbits',
            'smtp_timeout' => '4',
            'mailtype'  => 'html',
            'charset'   => 'iso-8859-1'
        );
        $this->load->library('email', $config);
        $this->email->set_newline("\r\n");
        $this->email->from('docmein@gmail.com', 'Arrowbits');
        $data = array(
             'touseremail' => $toemail,
			 'hashcode' => $hashverify
                 );
        $this->email->to($toemail);  // replace it with receiver mail id
        $this->email->subject('Docmein - Email Verification'); // replace it with relevant subject
   
        $body = $this->load->view('email/verify',$data,TRUE);
		
        $this->email->message($body);  
        //$this->email->send();
		if($this->email->send()){
			return '1';
		} else {
			return '0';
		}
    }
	
	public function registeruser_post(){
		if($this->post('userEmail')!='' && $this->post('userPassword')!=''){
			if($this->checkEmailExistance($this->post('userEmail'))){
				/********Start category folder creation***********/
				$usermainfoldername = $this->generateRandomString();
				/********End category folder creation***********/
				$hashVerify = md5( rand(0,1000) );
				$toemail = $this->post('userEmail');
				$data = array(
				   'useremail' => $this->post('userEmail'),
				   'password' => md5($this->post('userPassword')),
				   'hashverify' => $hashVerify,
				   'userfolder'=> $usermainfoldername,
				   'datecreated' => date('Y-m-d'),
				 );
				$this->db->insert('tb_appusers', $data);
				$user_last_insert_id = $this->db->insert_id();
					if(!empty($user_last_insert_id) && $user_last_insert_id != ''){
						$notificationData = array(
					   'gcm_apns_Id' => $this->post('deviceId'),
					   'devicetype' => $this->post('deviceType'),
					   'userid' => $user_last_insert_id,
					   'notidatecreated' => date('Y-m-d'),
						);
					$this->db->insert('tb_appnotifications', $notificationData);
					/****Start folder creation*****/
					if (!file_exists('catfolder/'.$usermainfoldername)) {
                        mkdir('catfolder/'.$usermainfoldername, 0777, true);
					}
					$newcontent="<!DOCTYPE html>
<html>
<head>
<title>403 Forbidden</title>
</head>
<body>
<p>Directory access is forbidden.</p>
</body>
</html>";
					if (!file_exists('catfolder/'.$usermainfoldername.'/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/personal')) {
                        mkdir('catfolder/'.$usermainfoldername.'/personal', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/personal/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/personal/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/financial')) {
                        mkdir('catfolder/'.$usermainfoldername.'/financial', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/financial/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/financial/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/medical')) {
                        mkdir('catfolder/'.$usermainfoldername.'/medical', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/medical/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/medical/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/home')) {
                        mkdir('catfolder/'.$usermainfoldername.'/home', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/home/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/home/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/vehicle')) {
                        mkdir('catfolder/'.$usermainfoldername.'/vehicle', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/vehicle/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/vehicle/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/business')) {
                        mkdir('catfolder/'.$usermainfoldername.'/business', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/business/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/business/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/taxes')) {
                        mkdir('catfolder/'.$usermainfoldername.'/taxes', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/taxes/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/taxes/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/education')) {
                        mkdir('catfolder/'.$usermainfoldername.'/education', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/education/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/education/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/assets')) {
                        mkdir('catfolder/'.$usermainfoldername.'/assets', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/assets/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/assets/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/other')) {
                        mkdir('catfolder/'.$usermainfoldername.'/other', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/other/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/other/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					/****End folder creation*****/
					/****Start Email Verification*****/
					$sendemail = $this->htmlemailsend($toemail,$hashVerify);
					/****End Email Verification*****/
					
						if($sendemail==1){
							$this->response(['userid' => $user_last_insert_id,'responsestatus' => TRUE], REST_Controller::HTTP_CREATED); // OK (200) being the HTTP response code
						} else{
							
							echo "please resend verify link";
							exit;
						}
					} else{
						
						$this->response(['userid' => 0,'responsestatus' => FALSE,'message' => 'Registration Unsuccessfull!!!'], REST_Controller::HTTP_BAD_REQUEST);
					}
			} else{
				$this->response(['userid' => 0,'responsestatus' => FALSE,'message' => 'User Email already Exists!!!'], REST_Controller::HTTP_NOT_ACCEPTABLE);
			}
        } else {
			    $this->response(['userid' => 0,'responsestatus' => FALSE,'message' => 'Registration Unsuccessfull!!!'], REST_Controller::HTTP_BAD_REQUEST);
		}
	}
	
	
	public function loginuser_post(){
		if($this->post('loginType')=='applogin'){
			if($this->post('userEmail')!='' && $this->post('userPassword')!=''){
			$row = $this->db->get_where('tb_appusers', array('useremail' => $this->post('userEmail'),'password' => md5($this->post('userPassword'))))->row();
			
			if(count($row) == 1)
			   {
				  if($row->userstatus=='1'){ //Check for Account email verified or not
					  $this->response(['responsestatus' => FALSE,'message' => 'Please verify your email first'], REST_Controller::HTTP_ACCEPTED);
				  }
				  
				  if($row->userstatus=='3'){ //Check for Account Block or not
					  $this->response(['responsestatus' => FALSE,'message' => 'Your account has been blocked by admin'], REST_Controller::HTTP_ACCEPTED);
				  }
				  $loggedInuserId = $row->userid;
				  $checkIdExist = $this->db->get_where('tb_appnotifications', array('gcm_apns_Id' => $this->post('deviceId') ,'userid' => $loggedInuserId))->row();
				  if(count($checkIdExist)==0){
					  $notificationData = array(
					   'gcm_apns_Id' => $this->post('deviceId'),
					   'devicetype' => $this->post('deviceType'),
					   'userid' => $loggedInuserId,
						);
					$this->db->insert('tb_appnotifications', $notificationData);
				} 
				  
				  $this->response(['userid' => $loggedInuserId,'responsestatus' => TRUE], REST_Controller::HTTP_ACCEPTED); // OK (202) being the HTTP response code The server successfully accepted a new resource
			   } else {
				$this->response(['responsestatus' => FALSE,'message' => 'Unauthorized Login'], REST_Controller::HTTP_UNAUTHORIZED);
			   }
		}
		else {
			
			$this->response(['responsestatus' => FALSE,'message' => 'Invalid Login'], REST_Controller::HTTP_BAD_REQUEST);
		}
			
			
		} else if($this->post('loginType')=='fblogin'){
			
			
			
			if($this->post('userEmail')!=''){
			$row = $this->db->get_where('tb_appusers', array('useremail' => $this->post('userEmail')))->row();
			
			
			
			if(count($row) == 1)
			   {
				   
				  /*if($row->userstatus=='1'){ //Check for Account email verified or not
					  $this->response(['responsestatus' => FALSE,'message' => 'Please verify your email first'], REST_Controller::HTTP_ACCEPTED);
				  }*/
				  
				  if($row->userstatus=='3'){ //Check for Account Block or not
					  $this->response(['responsestatus' => FALSE,'message' => 'Your account has been blocked by admin'], REST_Controller::HTTP_ACCEPTED);
				  }
				  
					$updatedata = array(
					   'facebook' => '1',
					   'userstatus' => '2'
					   
					);
					$this->db->where('userid', $row->userid);
					$this->db->update('tb_appusers', $updatedata);

				  $loggedInuserId = $row->userid;
				  $checkIdExist = $this->db->get_where('tb_appnotifications', array('gcm_apns_Id' => $this->post('deviceId') ,'userid' => $loggedInuserId))->row();
				  if(count($checkIdExist)==0){
					  $notificationData = array(
					   'gcm_apns_Id' => $this->post('deviceId'),
					   'devicetype' => $this->post('deviceType'),
					   'userid' => $loggedInuserId,
					   'notidatecreated' => date('Y-m-d'),
						);
					$this->db->insert('tb_appnotifications', $notificationData);
				} 
				  
				  $this->response(['userid' => $loggedInuserId,'responsestatus' => TRUE], REST_Controller::HTTP_ACCEPTED); // OK (202) being the HTTP response code The server successfully accepted a new resource
			   } else {
				   //echo "new registration at the time of login";
				   //exit;
				   
				   
				/********Start category folder creation***********/
				$usermainfoldername = $this->generateRandomString();
				/********End category folder creation***********/
				//$hashVerify = md5( rand(0,1000) );
				//$toemail = $this->post('userEmail');
				$data = array(
				   'useremail' => $this->post('userEmail'),
				   'password' => '',
				   'hashverify' => '',
				   'userfolder'=> $usermainfoldername,
				   'datecreated' => date('Y-m-d'),
				   'facebook' => '1',
				   'userstatus' => '2'
				 );
				$this->db->insert('tb_appusers', $data);
				$user_last_insert_id = $this->db->insert_id();
					if(!empty($user_last_insert_id) && $user_last_insert_id != ''){
						/*$notificationData = array(
					   'gcm_apns_Id' => $this->post('deviceId'),
					   'devicetype' => $this->post('deviceType'),
					   'userid' => $user_last_insert_id,
					   'notidatecreated' => date('Y-m-d'),
						);
					$this->db->insert('tb_appnotifications', $notificationData);*/
					$checkIdExist = $this->db->get_where('tb_appnotifications', array('gcm_apns_Id' => $this->post('deviceId') ,'userid' => $user_last_insert_id))->row();
				  if(count($checkIdExist)==0){
					  $notificationData = array(
					   'gcm_apns_Id' => $this->post('deviceId'),
					   'devicetype' => $this->post('deviceType'),
					   'userid' => $user_last_insert_id,
					   'notidatecreated' => date('Y-m-d'),
						);
					$this->db->insert('tb_appnotifications', $notificationData);
				} 
					
					
					/****Start folder creation*****/
					if (!file_exists('catfolder/'.$usermainfoldername)) {
                        mkdir('catfolder/'.$usermainfoldername, 0777, true);
					}
					$newcontent="<!DOCTYPE html>
<html>
<head>
<title>403 Forbidden</title>
</head>
<body>
<p>Directory access is forbidden.</p>
</body>
</html>";
					if (!file_exists('catfolder/'.$usermainfoldername.'/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/personal')) {
                        mkdir('catfolder/'.$usermainfoldername.'/personal', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/personal/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/personal/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/financial')) {
                        mkdir('catfolder/'.$usermainfoldername.'/financial', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/financial/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/financial/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/medical')) {
                        mkdir('catfolder/'.$usermainfoldername.'/medical', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/medical/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/medical/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/home')) {
                        mkdir('catfolder/'.$usermainfoldername.'/home', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/home/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/home/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/vehicle')) {
                        mkdir('catfolder/'.$usermainfoldername.'/vehicle', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/vehicle/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/vehicle/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/business')) {
                        mkdir('catfolder/'.$usermainfoldername.'/business', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/business/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/business/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/taxes')) {
                        mkdir('catfolder/'.$usermainfoldername.'/taxes', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/taxes/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/taxes/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/education')) {
                        mkdir('catfolder/'.$usermainfoldername.'/education', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/education/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/education/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/assets')) {
                        mkdir('catfolder/'.$usermainfoldername.'/assets', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/assets/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/assets/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/other')) {
                        mkdir('catfolder/'.$usermainfoldername.'/other', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/other/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/other/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					/****End folder creation*****/
					/****Start Email Verification*****/
					//$sendemail = $this->htmlemailsend($toemail,$hashVerify);
					/****End Email Verification*****/
					
						
							$this->response(['userid' => $user_last_insert_id,'responsestatus' => TRUE], REST_Controller::HTTP_CREATED); // OK (200) being the HTTP response code
						
					} else{
						
						$this->response(['userid' => 0,'responsestatus' => FALSE,'message' => 'Registration Unsuccessfull!!!'], REST_Controller::HTTP_BAD_REQUEST);
					}
			
				   
				   
				   
				   
				//$this->response(['responsestatus' => FALSE,'message' => 'Unauthorized Login'], REST_Controller::HTTP_UNAUTHORIZED);
			   }
		}
		else {
			
			$this->response(['responsestatus' => FALSE,'message' => 'Invalid Login'], REST_Controller::HTTP_BAD_REQUEST);
		}
			
			
			
		} else if($this->post('loginType')=='gpluslogin'){
			
			
			
			
			
			if($this->post('userEmail')!=''){
			$row = $this->db->get_where('tb_appusers', array('useremail' => $this->post('userEmail')))->row();
			
			
			
			if(count($row) == 1)
			   {
				   
				  /*if($row->userstatus=='1'){ //Check for Account email verified or not
					  $this->response(['responsestatus' => FALSE,'message' => 'Please verify your email first'], REST_Controller::HTTP_ACCEPTED);
				  }*/
				  
				  if($row->userstatus=='3'){ //Check for Account Block or not
					  $this->response(['responsestatus' => FALSE,'message' => 'Your account has been blocked by admin'], REST_Controller::HTTP_ACCEPTED);
				  }
				  
					$updatedata = array(
					   'googleplus' => '1',
					   'userstatus' => '2'
					   
					);
					$this->db->where('userid', $row->userid);
					$this->db->update('tb_appusers', $updatedata);

				  $loggedInuserId = $row->userid;
				  $checkIdExist = $this->db->get_where('tb_appnotifications', array('gcm_apns_Id' => $this->post('deviceId') ,'userid' => $loggedInuserId))->row();
				  if(count($checkIdExist)==0){
					  $notificationData = array(
					   'gcm_apns_Id' => $this->post('deviceId'),
					   'devicetype' => $this->post('deviceType'),
					   'userid' => $loggedInuserId,
					   'notidatecreated' => date('Y-m-d'),
						);
					$this->db->insert('tb_appnotifications', $notificationData);
				} 
				  
				  $this->response(['userid' => $loggedInuserId,'responsestatus' => TRUE], REST_Controller::HTTP_ACCEPTED); // OK (202) being the HTTP response code The server successfully accepted a new resource
			   } else {
				   
				   //echo "new registration at the time of login";
				   //exit;
				   
				   
				/********Start category folder creation***********/
				$usermainfoldername = $this->generateRandomString();
				/********End category folder creation***********/
				$hashVerify = md5( rand(0,1000) );
				//$toemail = $this->post('userEmail');
				$data = array(
				   'useremail' => $this->post('userEmail'),
				   'password' => '',
				   'hashverify' => '',
				   'userfolder'=> $usermainfoldername,
				   'datecreated' => date('Y-m-d'),
				   'googleplus' => '1',
				   'userstatus' => '2'
				 );
				$this->db->insert('tb_appusers', $data);
				$user_last_insert_id = $this->db->insert_id();
					if(!empty($user_last_insert_id) && $user_last_insert_id != ''){
						/*$notificationData = array(
					   'gcm_apns_Id' => $this->post('deviceId'),
					   'devicetype' => $this->post('deviceType'),
					   'userid' => $user_last_insert_id,
					   'notidatecreated' => date('Y-m-d'),
						);
					$this->db->insert('tb_appnotifications', $notificationData);*/
					
					
					$checkIdExist = $this->db->get_where('tb_appnotifications', array('gcm_apns_Id' => $this->post('deviceId') ,'userid' => $user_last_insert_id))->row();
				  if(count($checkIdExist)==0){
					  $notificationData = array(
					   'gcm_apns_Id' => $this->post('deviceId'),
					   'devicetype' => $this->post('deviceType'),
					   'userid' => $user_last_insert_id,
					   'notidatecreated' => date('Y-m-d'),
						);
					$this->db->insert('tb_appnotifications', $notificationData);
				} 
					/****Start folder creation*****/
					if (!file_exists('catfolder/'.$usermainfoldername)) {
                        mkdir('catfolder/'.$usermainfoldername, 0777, true);
					}
					$newcontent="<!DOCTYPE html>
<html>
<head>
<title>403 Forbidden</title>
</head>
<body>
<p>Directory access is forbidden.</p>
</body>
</html>";
					if (!file_exists('catfolder/'.$usermainfoldername.'/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/personal')) {
                        mkdir('catfolder/'.$usermainfoldername.'/personal', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/personal/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/personal/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/financial')) {
                        mkdir('catfolder/'.$usermainfoldername.'/financial', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/financial/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/financial/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/medical')) {
                        mkdir('catfolder/'.$usermainfoldername.'/medical', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/medical/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/medical/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/home')) {
                        mkdir('catfolder/'.$usermainfoldername.'/home', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/home/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/home/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/vehicle')) {
                        mkdir('catfolder/'.$usermainfoldername.'/vehicle', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/vehicle/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/vehicle/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/business')) {
                        mkdir('catfolder/'.$usermainfoldername.'/business', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/business/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/business/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/taxes')) {
                        mkdir('catfolder/'.$usermainfoldername.'/taxes', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/taxes/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/taxes/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/education')) {
                        mkdir('catfolder/'.$usermainfoldername.'/education', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/education/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/education/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/assets')) {
                        mkdir('catfolder/'.$usermainfoldername.'/assets', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/assets/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/assets/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					
					
					if (!file_exists('catfolder/'.$usermainfoldername.'/other')) {
                        mkdir('catfolder/'.$usermainfoldername.'/other', 0777, true);
					}
					if (!file_exists('catfolder/'.$usermainfoldername.'/other/index.html')) { $handle = fopen('catfolder/'.$usermainfoldername.'/other/index.html','w+'); fwrite($handle,$newcontent); fclose($handle); }
					/****End folder creation*****/
					/****Start Email Verification*****/
					//$sendemail = $this->htmlemailsend($toemail,$hashVerify);
					/****End Email Verification*****/
					
						
							$this->response(['userid' => $user_last_insert_id,'responsestatus' => TRUE], REST_Controller::HTTP_CREATED); // OK (200) being the HTTP response code
						
					} else{
						
						$this->response(['userid' => 0,'responsestatus' => FALSE,'message' => 'Registration Unsuccessfull!!!'], REST_Controller::HTTP_BAD_REQUEST);
					}
			
				   
				   
				   
				   
				//$this->response(['responsestatus' => FALSE,'message' => 'Unauthorized Login'], REST_Controller::HTTP_UNAUTHORIZED);
			   }
		}
		else {
			
			$this->response(['responsestatus' => FALSE,'message' => 'Invalid Login'], REST_Controller::HTTP_BAD_REQUEST);
		}
			
			
			
			
		}
		
	}
	
	
	
	public function forgotpassword_post(){
		
		
		if($this->post('userEmail')!=''){
			$checkEmailForForgotPass = $this->checkEmailExistance($this->post('userEmail'));
			if($checkEmailForForgotPass == '0'){
				$toemail = $this->post('userEmail');
				
				$generatedPassword = $this->generateRandomString(10);
				$dataUpdation = array('userpassword'=>md5($generatedPassword));
				$this->db->where('useremail',trim($this->post('userEmail')));
				$this->db->update('tb_appusers',$dataUpdation);
			
				/****Start Email Verification*****/
				$sendemail = $this->forgotpassemail($toemail);
				/****End Email Verification*****/
		            if($sendemail==1){
				    $this->response(['status' => TRUE,'message' => 'Email has been sent successfully'], REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
					} else {
					$this->response(['status' => TRUE,'message' => 'Please try again'], REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
					}
			} else { 
				$this->response(['userId' => 0,'status' => FALSE,'message' => 'Please enter registered email'], REST_Controller::HTTP_NOT_FOUND);
				}
		} else {
			    $this->response(['status' => FALSE], REST_Controller::HTTP_BAD_REQUEST);
			   }
	}
	
	public function logout_post(){
		
		echo "hjhj";
		exit;
	}
	

    public function users_get()
    {
        // Users from a data store e.g. database
        $users = [
            ['id' => 1, 'name' => 'John', 'email' => 'john@example.com', 'fact' => 'Loves coding'],
            ['id' => 2, 'name' => 'Jim', 'email' => 'jim@example.com', 'fact' => 'Developed on CodeIgniter'],
            ['id' => 3, 'name' => 'Jane', 'email' => 'jane@example.com', 'fact' => 'Lives in the USA', ['hobbies' => ['guitar', 'cycling']]],
        ];

        $id = $this->get('id');

        // If the id parameter doesn't exist return all the users

        if ($id === NULL)
        {
            // Check if the users data store contains users (in case the database result returns NULL)
            if ($users)
            {
                // Set the response and exit
                $this->response($users, REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
            }
            else
            {
                // Set the response and exit
                $this->response([
                    'status' => FALSE,
                    'message' => 'No users were found'
                ], REST_Controller::HTTP_NOT_FOUND); // NOT_FOUND (404) being the HTTP response code
            }
        }

        // Find and return a single record for a particular user.

        $id = (int) $id;

        // Validate the id.
        if ($id <= 0)
        {
            // Invalid id, set the response and exit.
            $this->response(NULL, REST_Controller::HTTP_BAD_REQUEST); // BAD_REQUEST (400) being the HTTP response code
        }

        // Get the user from the array, using the id as key for retreival.
        // Usually a model is to be used for this.

        $user = NULL;

        if (!empty($users))
        {
            foreach ($users as $key => $value)
            {
                if (isset($value['id']) && $value['id'] === $id)
                {
                    $user = $value;
                }
            }
        }

        if (!empty($user))
        {
            $this->set_response($user, REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
        }
        else
        {
            $this->set_response([
                'status' => FALSE,
                'message' => 'User could not be found'
            ], REST_Controller::HTTP_NOT_FOUND); // NOT_FOUND (404) being the HTTP response code
        }
    }

    public function users_post()
    {
        // $this->some_model->update_user( ... );
        $message = [
            'id' => 100, // Automatically generated by the model
            'name' => $this->post('name'),
            'email' => $this->post('email'),
            'message' => 'Added a resource'
        ];

        $this->set_response($message, REST_Controller::HTTP_CREATED); // CREATED (201) being the HTTP response code
    }

    public function users_delete()
    {
        $id = (int) $this->get('id');

        // Validate the id.
        if ($id <= 0)
        {
            // Set the response and exit
            $this->response(NULL, REST_Controller::HTTP_BAD_REQUEST); // BAD_REQUEST (400) being the HTTP response code
        }

        // $this->some_model->delete_something($id);
        $message = [
            'id' => $id,
            'message' => 'Deleted the resource'
        ];

        $this->set_response($message, REST_Controller::HTTP_NO_CONTENT); // NO_CONTENT (204) being the HTTP response code
    }

}
