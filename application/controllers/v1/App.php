<?php
error_reporting(0);
ini_set('max_execution_time', 12000);
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
    
       private function generateRandomString($length = 20) {
        
        $characters = strtotime(date("Y-m-d G:i:s")).'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) 
        {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }
    
    public function loginuser_post(){
		$user = array();
		$name = $this->post('name');
		 $email =  $this->post('email');
		  $fbid =  $this->post('facebookId');
                $data = array(
                   'first_name' => $this->post('name'),
                   'email' => $this->post('email'),
                   'fb_id' => $fbid
                    );
            
            $this->db->select('*');
            $this->db->from('user');
            $this->db->where('email',$email);
            $this->db->where('fb_id',$fbid);
            $query1 = $this->db->get()->result_array();
   
            if(count($query1) > 0) {
				$user[] = $query1;
            }else {
				
		   $this->db->insert('user',$data);
					 //Query again
            $this->db->select('*');
            $this->db->from('user');
           $this->db->where('email', $email);
            $query1 = $this->db->get()->result_array();
				
				if(count($query1) > 0) {
                   $user[] = $query1;
	     
            }
				
				
				}
				//print_r($user);
				foreach($user as $res){
				
				$this->response(['user' =>$res,'responsestatus' => TRUE,'message' => 'Registration successfull!!!']);
            } 
       
        }
        
        public function mount_post()
		{
			
						$channel_name = $this->post('name');
						$match_id = $this->post('match_id');
						$broadcaster_id = $this->post('broadcaster_id');
						
						$broadcaster_name = $this->post('broadcaster_name');
						$station = $this->post('station');
					    $appName = $this->post('appName');
						//$streamName = $this->post('streamName');
						$channeltype = $this->post('channel_type');
						$publish_date = date("h:i:s");
				    	$token = $this->generateRandomString(5);
			 
					   $data_to_store = array(
												 'name' => $channel_name,
												 'match_id' => $match_id,
												 'station' => $broadcaster_id.'-'.$match_id.'-'.$token,
												 'live' =>1,
												 'broadcaster_id' => $broadcaster_id, 
												 'broadcaster_name' => $broadcaster_name,
												 'appName' => $appName,
												 'streamName' => $broadcaster_id.'-'.$match_id.'-'.$token,
												 'channel_type' => $channeltype,
												 'start_time' => $publish_date
												 
                                           );
            
          $this->db->insert('channel', $data_to_store);
          $user_last_insert_id = $this->db->insert_id();
       
             $this->db->select('*');
             $this->db->from('channel');
             $this->db->where('id',$user_last_insert_id);  
             $query = $this->db->get()->result_array();
             
             foreach($query as $result){
				     
       
		  $this->response(['channelid' =>$user_last_insert_id,'responsestatus' => TRUE,'message' => 'Channel created', 'data'=>$result]);
		}
		}
		
		 public function mountest_post()
		{
			
						$channel_name = $this->post('name');
						$match_id = $this->post('match_id');
						$broadcaster_id = $this->post('broadcaster_id');
						$sport_id = $this->post('sport_id');
						$league_id = $this->post('league_id');
						$broadcaster_name = $this->post('broadcaster_name');
						$station = $this->post('station');
					    $appName = $this->post('appName');
						//$streamName = $this->post('streamName');
						$channeltype = $this->post('channel_type');
						$publish_date = date("h:i:s");
				    	$token = $this->generateRandomString(5);
			 
					   $data_to_store = array(
												 'name' => $channel_name,
												 'match_id' => $match_id,
												 'station' => $broadcaster_id.'-'.$match_id.'-'.$token,
												 'live' =>1,
												 'broadcaster_id' => $broadcaster_id, 
												 'broadcaster_name' => $broadcaster_name,
												 'appName' => $appName,
												 'streamName' => $broadcaster_id.'-'.$match_id.'-'.$token,
												 'channel_type' => $channeltype,
												 'start_time' => $publish_date,
												 'sport_id' => $sport_id,
												 'league_id' => $league_id
                                           );
            
          $this->db->insert('channel', $data_to_store);
          $user_last_insert_id = $this->db->insert_id();
       
             $this->db->select('*');
             $this->db->from('channel');
             $this->db->where('id',$user_last_insert_id);  
             $query = $this->db->get()->result_array();
             
             foreach($query as $result){
				     
       
		  $this->response(['channelid' =>$user_last_insert_id,'responsestatus' => TRUE,'message' => 'Channel created', 'data'=>$result]);
		}
		}
        
         public function login_post(){
		
			$user = array();
			$name = $this->post('name');
			 $email =  $this->post('email');
			  $fbid =  $this->post('facebookId');
		  
		   $baseimage = $this->post('cover_photo');
          
             //if(!empty($baseimage)){
            $profilepic = $this->imageconversion($baseimage);      
                 // $profilepic = $this->imageconversionandroid($baseimage);
           
		  
                $data = array(
                   'first_name' => $this->post('name'),
                   'email' => $this->post('email'),
                   'fb_id' => $fbid,
                   'avatar' => $profilepic,
                   'UUID' =>1
                    );
                 
           // }
            $this->db->select('*');
            $this->db->from('user');
            $this->db->where('fb_id',$fbid);
            $query1 = $this->db->get()->result_array();
   
            if(count($query1) > 0) {
				$user[] = $query1;
            }else {
				
		   $this->db->insert('user',$data);
					 //Query again
            $this->db->select('*');
            $this->db->from('user');
           $this->db->where('fb_id', $fbid);
            $query1 = $this->db->get()->result_array();
				
				if(count($query1) > 0) {
                   $user[] = $query1;
	     
            }
				
				
				}
				//print_r($user);
				foreach($user as $res){
				
				$this->response(['user' =>$res,'responsestatus' => TRUE,'message' => 'Registration successfull!!!']);
            } 
       
        }
        
       public function userLogin_post(){
		
				$user = array();
			$name = $this->post('name');
			 $email =  $this->post('email');
			  $fbid =  $this->post('facebookId');
		  $uuid = $this->post('uuid');
		   $baseimage = $this->post('cover_photo');
          
             if(!empty($baseimage)){
            $profilepic = $this->imageconversion($baseimage);      
                 // $profilepic = $this->imageconversionandroid($baseimage);
           
		  
                $data = array(
                   'first_name' => $this->post('name'),
                   'email' => $this->post('email'),
                   'fb_id' => $fbid,
                   'avatar' => $profilepic,
                   'UUID' => $uuid
                    );
                 
            }
            $this->db->select('*');
            $this->db->from('user');
            $this->db->where('fb_id',$fbid);
            $query1 = $this->db->get()->result_array();
   
            if(count($query1) > 0) {
				$user[] = $query1;
            }else {
				
		   $this->db->insert('user',$data);
					 //Query again
            $this->db->select('*');
            $this->db->from('user');
           $this->db->where('fb_id', $fbid);
            $query1 = $this->db->get()->result_array();
				
				if(count($query1) > 0) {
                   $user[] = $query1;
	     
            }
				
				
				}
				//print_r($user);
				foreach($user as $res){
				
				$this->response(['user' =>$res,'responsestatus' => TRUE,'message' => 'Registration successfull!!!']);
            } 
       
        }
    
    
    public function imageconversionandroid($baseimage){
      
        define('UPLOAD_DIR', '../pundit-web/profileusrimg/');
        //$img = $_POST['img'];
        $img = str_replace('data:image/jpeg;base64,', '', $baseimage);
        $img = str_replace(' ', '+', $img);
        $data = base64_decode($img);
        $filname = strtotime(date('Y-m-d')).uniqid() . '.jpeg';
        $target_dir = 'profileusrimg/';
        $file = UPLOAD_DIR . $filname;
        $success = file_put_contents($file, $data);
        return $filname;
        
      }
     
     
      private function imageconversion($baseimage){
      /*$baseimage="data:image/jpeg;base64,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";*/
        // requires php5
       define('UPLOAD_DIR', 'profileusrimg/');
       // define('UPLOAD_DIR', 'profileusrimg/');
        //$img = $_POST['img'];
        $img = str_replace('data:image/jpeg;base64,', '', $baseimage);
        $img = str_replace(' ', '+', $img);
               $data = base64_decode($img);
        $filname = strtotime(date('Y-m-d')).uniqid() . '.jpeg';
        $file = UPLOAD_DIR . $filname;
        $success = file_put_contents($file, $data);
        return $filname;
           }
           
       public function update_post(){
		        $baseimage = $this->post('avatar');
                $avatar = $this->imageconversion($baseimage);  
             //   $avatar = $this->imageconversionandroid($baseimage);
              /*  $baseimage1 = $this->post('cover_photo');
                $coverphoto = $this->imageconversion($baseimage1);*/
                 
                 $id = $this->post('id');
                  $first_name = $this->post('name');
                 // $last_name = $this->post('last_name');
                  $email = $this->post('email');
                   $coverphoto = $this->post('coverphoto');
                   $userbio = $this->post('userbio');
                   $countryid =$this->post('countryid');
                   $facebook =$this->post('facebook');
                   $twitter =$this->post('twitter');
                   $youtube =$this->post('youtube');
                   $tags = $this->post('tags');
					 $data = array(
						'first_name' => $first_name,
					  
						'email' => $email,
					  'avatar' => $avatar,
					 //   'cover_photo' => $coverphoto,
						'user_bio' => $userbio,
						'country_id' => $countryid,
						'facebook' => $facebook,
						'twitter' => $twitter,
						'youtube' => $youtube
							//'password' => $this->input->post('password')
						 );
						 $profile = $this->hashtag($id,$tags);
					 $this->db->where('id', $id);
				   $update= $this->db->update('user', $data);
					 if($update){
						 $this->db->select('*');
						 $this->db->from('user');
						 $this->db->where('id',$id);
						 $query = $this->db->get()->result_array();
						 foreach ($query as $result) {
							 
						 $this->response(['responsestatus' => TRUE,'message' => 'Update successfull!!!','result' =>$result]);
					 }
				 }
		 
	 }
			 public function delete_hash_tag($id){
				$this->db->where('user_id', $id);
				$this->db->delete('hash_tag');
			}
	 public function insert_hash_tag($id,$tags){
		
		$data = array(
            'user_id' => $id,
            'tags' => $tags
	   );
	   $this->db->insert('hash_tag',$data);
		
       }
		 public function hashtag($id,$tags){
		
		  $this->db->select('*');
	      $this->db->from('hash_tag');
	      $this->db->where('user_id',$id);
	      $query = $this->db->get()->result_array();
	      $count = count($query);
	      //echo $count;
			if(count($query)>=0)
        {
	         $this->delete_hash_tag($id);
	           $this->insert_hash_tag($id,$tags);
        }
         else
         {
	         $this->insert_hash_tag($userid,$tags);
	      }
       }




       public function user_profile_list($userid)
        {
	
     
         $profiledetail = array();
         $this->db->distinct();
         $this->db->select('user.first_name,user.last_name,     user.email,user.password,user.avatar,user.user_bio,    user.facebook,user.twitter,user.youtube,follow_table.follower_id');
         $this->db->from('user');
        
         $this->db->join('follow_table', 'user.id = follow_table.follower_id', 'left');
         
		  $this->db->where('user.id',$userid);
         $query = $this->db->get();
	
		   
         $this->db->select('user.first_name,user.last_name,     user.email,user.password,user.avatar,user.cover_photo,user.user_bio,    user.country_id,user.facebook,user.twitter,user.youtube,user.datecreated,follow_table.follower_id');
         $this->db->from('user');
         $this->db->where('user.id',$userid);
          $this->db->where('follow_table.live',1);
         $this->db->join('follow_table', 'user.id = follow_table.follower_id', 'left');
         
         $query1 = $this->db->get();
         $count = $query1->num_rows();
         $query1 = $query->result_array();
	
         $this->db->from('user');
         $this->db->where('user.id',$userid);
             $this->db->where('follow_table.live',1);
         $this->db->join('follow_table', 'user.id = follow_table.following_id', 'right');
         
         $query2 = $this->db->get();
         	
          $count1 = $query2->num_rows();

        
		
        if($query->num_rows() != 0)
        {
            $follower[] = $this->count_follower();
            $tags = $this->hashtag_list($userid);
            
            foreach( $query->result_array() as $row ) {
               
              $profile = $row;
              $profile['follower'] = $count;
              $profile['following'] = $count1;
              $profiledetail[] = $profile;
            
        }
        }
           return $profiledetail;
       
          }

          public function hashtag_list($userid)
          {
			   $hastag= array();
			  $this->db->select("*");
			  $this->db->from("hash_tag");
			  $this->db->where('user_id',$userid);
			  $query = $this->db->get()->result_array();
			 
		       foreach($query as $row){
			  $hastag[] = $row;
		  }
			  return $hastag;
		 }
		 
		 
		 
	public function count_follower()
      {
         $this->db->select('*');
         $this->db->from('follow_table');
         $query = $this->db->get()->result_array();
             return $query;
         }
         
         
         
         
			 public function get_profile_post()
			 {
				 //echo "get profile";
				 $userid = $this->post('userid');
			
				$user_profile = $this->user_profile_list($userid);
				
				
			 $hash_tag = $this->hashtag_list($userid);
			 
			 foreach($hash_tag as $tags){
				 $tag= $tags;
				 
				 }
				
			  foreach($user_profile as $user){
			 
			// $array = array('userDetail'=>$user,'tags' => $hash_tag);
			//}
			   //echo json_encode($array);
			  $this->response(['responsestatus' => TRUE,'message' =>$user,'tags' =>$tag]);
					
				  }
			   }
     
			 public function searchsport_post(){
				
			
				
				
				$abc = array();
				$keyword = $this->post('keyword');
				
				$this->db->select('*');
				$this->db->from('sport');

		        $this->db->where("`name` LIKE '%$keyword%'");
				
				$query1 = $this->db->get()->result_array();
			
				$abc[] = $query1;
				foreach($abc as $res){
				 $this->response(['responsestatus' => TRUE,'data' => $res]);
					}
				    
				}
				 
				 private function getleague(){
					
					 
					 $this->db->select('*');
					 $this->db->from('league');
					 $query = $this->db->get()->result_array();
					 return $query;
					
				 }
				 	
				public function searchleague_post(){
				
			
				 $abc = array();
				$keyword = $this->post('keyword');
				//echo $keyword;
				
				$this->db->select('*');
				$this->db->from('league');

		        $this->db->where("`name` LIKE '%$keyword%'");
				
				$query1 = $this->db->get()->result_array();
			
			$abc[] = $query1;
				foreach($abc as $res){
				 $this->response(['responsestatus' => TRUE,'data' => $res]);
					}
			   }
			   
			//Follow
			public function follow($follow_id, $follower_id)
			{
				
				$this->load->model('Api_model');
				if ($this->input->server('REQUEST_METHOD') == 'GET')
					  {
				
					 $follow_id = $this->input->get('follow_id');
					 $follower_id = $this->input->get('follower_id');
			
				   }else if ($this->input->server('REQUEST_METHOD') == 'POST'){
			  
			  $follow_id = $this->input->post('follow_id');
					$follower_id = $this->input->post('follower_id');
						 
			  } 
				$followid = $this->Api_model->active_channel($follow_id, $follower_id);

				$array = array('data' => $followid);
				echo json_encode($array);
			}

				public function unfollow($follow_id, $follower_id)
				{
					$this->load->model('Api_model');
					$follow_update = $this->Api_model->deactive_channel($follow_id, $follower_id);

					$array = array('data' => $follow_update);
					echo json_encode($array);
				}
				
     
    
    
    
    
    
		
     
    }
?>
