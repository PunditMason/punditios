<?php

class Users extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('Users_model');
	}

	public function add( $name = '', $email = '' )
	{
		$this->Users_model->add($name, $email,$cover_photo,$facebook,$youtube);
	}
	public function update($name = '', $email = '' )	
	{
		if ($this->input->server('REQUEST_METHOD') == 'GET')
              {
			$name = $this->input->get('name');
             $email = $this->input->get('email');
			 $cover_photo = $this->input->get('cover_photo');
			 $facebook = $this->input->get('facebook');
			 $twitter = $this->input->get('twitter');
			 $youtube = $this->input->get('youtube');
       
    
           }
		   else if ($this->input->server('REQUEST_METHOD') == 'POST'){
      
               $name = $this->input->post('name');
             $email = $this->input->post('email');
			 $cover_photo = $this->input->post('cover_photo');
			  $facebook = $this->input->post('facebook');
			  $twitter = $this->input->post('twitter');
			  $youtube = $this->input->post('youtube');
                 
      }
	$result = $this->Users_model->update($name,$email,$cover_photo,$facebook,$twitter,$youtube);
	
	echo $result;
	
	}

	public function login( $name = '', $email = '' )
	{
		if ($this->input->server('REQUEST_METHOD') == 'GET')
              {
        $name = $this->input->get('name');
             $email = $this->input->get('email');
			 $cover_photo = $this->input->get('cover_photo');
			 $facebook = $this->input->get('facebook');
			 $twitter = $this->input->get('twitter');
			 $youtube = $this->input->get('youtube');
       
    
           }
		   else if ($this->input->server('REQUEST_METHOD') == 'POST'){
      
       $name = $this->input->post('name');
              $email = $this->input->post('email');
			  $cover_photo = $this->input->post('cover_photo');
			  $facebook = $this->input->post('facebook');
			  $twitter = $this->input->post('twitter');
			  $youtube = $this->input->post('youtube');
                 
      }
		$user_id = $this->Users_model->login(utf8_decode(urldecode($name)), utf8_decode(urldecode($email)), utf8_decode(urldecode($cover_photo)), utf8_decode(urldecode($facebook)),utf8_decode(urldecode($twitter)),utf8_decode(urldecode($youtube)));

		$array = array('user' => $user_id);
		
		if(!$array['user']==""){
		echo json_encode($array);
	   }else{
		
		echo '{"status":"Failed"}';
		
		}
	}


	public function active_users()
	{

      $active = $this->Users_model->activation();

      //print_r($active);

      echo json_encode($active);

	}

	public function create_active($userName='',$appName='',$streamName='',$matchID='',$matchBetween='',$startDate='',$Activation='')
	{

      $new_member_insert_data = array(
                'userName' => $userName,
                'appName' => $appName,
                'streamName' => $streamName,
                'matchID' => $matchID,
                'matchBetween' => $matchBetween,
                'startDate' => $startDate,
                'Activation' => $Activation
            );
            $insert = $this->db->insert('active_users', $new_member_insert_data);
           print_r($insert);

      //echo json_encode($create);

	}

	public function check($name='',$email='')
	{

   echo json_encode($email);
	}


}
