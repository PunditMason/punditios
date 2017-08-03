<?php
error_reporting(0);
ini_set('max_execution_time', 12000);
defined('BASEPATH') OR exit('No direct script access allowed');

// This can be removed if you use __autoload() in config.php OR use Modular Extensions
require APPPATH . '/libraries/REST_Controller.php';

	class Search extends REST_Controller {
			  
		 public function test(){
			 echo "test";
			 
		 }
		 
		 //search team and user 
		 
		 public function sport_search_post(){
			 
			 $this->load->model('Search_model');
			 
			  $search_type = $this->post('search_type');
			 $search_text = $this->post('search_text');
			  $live = $this->post('live');
			 
			 
			 
			 if($search_type !=''){
				 if($search_type == 'user'){
					
					 if($live == 0){
					 $user_list = $this->Search_model->user_sport_search($search_text);
			        $array = array('data' => $user_list);
			               if(empty($user_list)){
						
						   $array = array('data' => 'No Data found');
					   }
						 echo json_encode($array);  
					 }
					 
					 else{
 
						 $user_list = $this->Search_model->user_sport_channel_search($search_text);
						
			         $array = array('data' => $user_list);
			          
			          foreach ($user_list as $result) {
		
	                if(isset($result['channel_info'])){
						
				         $array1[] = $result;
				
			            }
			     else{
					
				       $array2[] = $result;
				
			       }
		      }
		
		          if(empty($array1)){
					 
			                 $array = array('data' =>$user_list);
			                 //echo json_encode($array); 
		             }
		             else if(empty($array2)){
						 $array = array('data' =>$array1);
					 }
		          else{
					  
                      $array4 = array_merge($array1,$array2);
                      $array = array('data' =>$array4);

     
			//echo json_encode($array3); 
				//echo json_encode($array); 
			}
			           if(empty($user_list)){
						
						   $array = array('data' => 'No Data found');
					   }
			             echo json_encode($array);  
						 
					 }
			       }
				 else if($search_type == 'team'){
					 if($live == 0){
					     $user_list = $this->Search_model->team_sport_search($search_text);
			             $array = array('data' => $user_list);
			           if(empty($user_list)){
						
						   $array = array('data' => 'No Data found');
					   }
					   
			   			 echo json_encode($array);  
					 }
					  else{
						 $user_list = $this->Search_model->team_sport_channel_search($search_text);
			          $array = array('data' => $user_list);
			         foreach ($user_list as $result) {
			
	                if(isset($result['channel_info'])){
				         $array1[] = $result;
				
			            }
			     else{
				       $array2[] = $result;
				
			       }
		      }
		
		          if(empty($array1)){
			                 $array = array('data' =>$user_list);
			                 //echo json_encode($array); 
		             }
		              else if(empty($array2)){
						 $array = array('data' =>$array1);
					 }
		          else{
                      $array4 = array_merge($array1,$array2);
                      $array = array('data' =>$array4);
}
			           if(empty($user_list)){
						
						   $array = array('data' => 'No Data found');
					   }
			             echo json_encode($array);  
						 
					 }
			       }
			       else{
					     $array = array('data' => 'enter valid response');
						 echo json_encode($array);
					   
				   }
	 }
	 
	 else{
		 
		  $array = array('Response' => 'Please enter any data');
		echo json_encode($array);
		 
	 }
 }
 
 public function league_search_post(){
	 
	         $this->load->model('Search_model');
	         
	          $sport_id = $this->post('sport_id');
			  $search_type = $this->post('search_type');
			  $search_text = $this->post('search_text');
			  $live = $this->post('live');
			 
			 if($search_type != '')
			 {
				   if($search_type == 'user'){
					
					 if($live == 0){
					 $user_list = $this->Search_model->user_sport_search($search_text);
			          $array = array('data' => $user_list);
			               if(empty($user_list)){
						
						   $array = array('data' => 'No Data found');
					   }
						 echo json_encode($array);  
					 }
					 
					 else{
 
						 $user_list = $this->Search_model->user_sport_channel_search($search_text);
						
			          $array = array('data' => $user_list);
			           if(empty($user_list)){
						
						   $array = array('data' => 'No Data found');
					   }
			             echo json_encode($array);  
						 
					 }
			       }
			       else if($search_type =='team'){
				 if($live == 0){
				  $user_list = $this->Search_model->team_league_search($sport_id,$search_text);
			          $array = array('data' => $user_list);
			           if(empty($user_list)){
						
						   $array = array('data' => 'No Data found');
					   }
						 echo json_encode($array);  
				 }
				 else{
					 $user_list = $this->Search_model->team_league_channel_search($sport_id,$search_text);
			          $array = array('data' => $user_list);
			           if(empty($user_list)){
						
						   $array = array('data' => 'No Data found');
					   }
						 echo json_encode($array);  
					 
					 
				 }
			 }
			 else{
				    $array = array('data' => 'enter valid response');
						 echo json_encode($array);
			 }
		 }
			 else{
				  $array = array('Response' => 'Please enter any data');
		echo json_encode($array);
			 }
			 
              }
 

}
					
						
						
				
