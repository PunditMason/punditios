<?php
error_reporting(0);

	class Game extends CI_Controller {
			   /* public function __construct()
				{
					//$this->load->model('api_model');
					echo "hello";
				}  */  

					function pp($print){
						
						
						echo "<pre>";
						print($print);
						
						
						}
						
						// get_match_list get data with in 30 days//
					public function test( $sport = '', $league = '',$match_start_date='' )
					{
						   $this->load->model('Api_model');
						   
						   if ($this->input->server('REQUEST_METHOD') == 'GET')
						  {
							   echo $sport = $this->input->get('sport_id');
							  echo $league = $this->input->get('league_id');
							   echo $match_start_date = $this->input->get('match_start_date');
				   
						  }else if ($this->input->server('REQUEST_METHOD') == 'POST'){
							  
							   echo $sport = $this->input->post('sport_id');
							   echo $league = $this->input->post('league_id');
							   echo $match_start_date = $this->input->post('match_start_date');
							  }
						
						
						
						$match_list_filter = $this->Api_model->get_match_data($sport, $league,$match_start_date);

						$array = array('data' => $match_list_filter);
						 echo json_encode($array);  
					}
					
						
					// get_match_list get data with in 30 days//
					public function get_match_list( $sport, $league,$match_start_date )
					{
						   $this->load->model('Api_model');
						 if ($this->input->server('REQUEST_METHOD') == 'GET')
						  {
								$sport = $this->input->get('sport_id');
							   $league = $this->input->get('league_id');
								$match_start_date = $this->input->get('match_start_date');
				   
						  }else if ($this->input->server('REQUEST_METHOD') == 'POST'){
							  
							   $sport = $this->input->post('sport_id');
								$league = $this->input->post('league_id');
								$match_start_date = $this->input->post('match_start_date');
							  }
						$match_list_filter = $this->Api_model->get_match_data($sport, $league,$match_start_date);

						$array = array('data' => $match_list_filter);
						 echo json_encode($array);  
					}
					
				   // get_match_list_filtern get data with in 7days//
				
					public function get_match_list_filter( $sport, $league,$match_start_date )
					{
						$this->load->model('Api_model');
						//echo $sport = $_POST['sport_id'];
						//echo $league = $_POST['league_id'];
						//echo $match_start_date = $_POST['match_start_date'];
						
						
						$match_list_filter = $this->Api_model->get_match_data_filter($sport, $league,$match_start_date);

						$array = array('data' => $match_list_filter);
						 echo json_encode($array);  
					}

					// public function active_user( $sport = '1', $league = '1' )
					// {
					//     $this->load->model('Api_model');
					//     $active_user = $this->Api_model->get_active();
					//     print_r($active_user);

					// }


						//Get channel list with Sport and league Id//
					 public function get_channel_list( $sport,$league,$match_start_date )
					  { 
						$this->load->model('Api_model');
					
						 $channel_list = $this->Api_model->get_channel_data($sport,$league,$match_start_date);
						$array = array('data' => $channel_list);
						echo json_encode($array);
					 }
					 
					  public function get_channel_test( $sport,$league,$match_start_date )
					  { 
						$this->load->model('Api_model');
					
						 $channel_list = $this->Api_model->get_channel_testdata($sport,$league,$match_start_date);
						$array = array('data' => $channel_list);
						echo json_encode($array);
					 }


					//Get Match status with match//
					public function getScore($match_id)
					{ 	 
						
						 $this->load->model('Api_model');
						 //echo $match_id = $_POST['match_id'];
						
					
						$getScore = $this->Api_model->get_match_score($match_id);
						$array = array('data' => $getScore);
						 echo json_encode($array);
					}
					
					 // Get Match LIve Feeds with Match Id//
					public function getMatchLiveFeed($match_id,$broadcaster_id,$user_id)
					{ 
					
					
						$this->load->model('Api_model');
				
				
					
						$matchFeed = $this->Api_model->matchFeed($match_id);
						$competitionFeed = $this->Api_model->competitionFeed($match_id);
						$tournamentCalendarFeedFeed = $this->Api_model->tournamentCalendarFeed($match_id);
						$contestantFeed = $this->Api_model->contestantFeed($match_id);
						$goalFeed = $this->Api_model->goalFeed($match_id);
						//$scoresFeed = $this->Api_model->scoresFeed($match_id,$matchDate);
						$missedPenFeed = $this->Api_model->missedPenFeed($match_id);
						$cardFeed = $this->Api_model->cardFeed($match_id);
						$substituteFeed = $this->Api_model->substituteFeed($match_id);
						
						
							$follow_info=array();
							
						
						$array=array('matchinfo'=>array($matchFeed,'competition'=>$competitionFeed,'tournamentCalendar'=>$tournamentCalendarFeedFeed,'contestant'=>$contestantFeed,'goal'=>$goalFeed,'missedPen'=>$missedPenFeed,'card'=>$cardFeed,'substitute'=>$substituteFeed));
						
						echo json_encode($array);
					}
					
					public function getMatchLiveFeedsdata($match_id)
					{ 
					
					
						$this->load->model('Api_model');
				
				
					
						$matchFeed = $this->Api_model->get_rseult($match_id);
						
						
						echo json_encode($matchFeed);
					}
				
					 //Get Live feeds with Match ID//
					public function liveFeeds($match_id)
					{ 
					
						$this->load->model('Api_model');
						//$match_id = $this->input->post('match_id');
						$matchFeed = $this->Api_model->matchFeed($match_id);
						$competitionFeed = $this->Api_model->competitionFeed($match_id);
						$tournamentCalendarFeedFeed = $this->Api_model->tournamentCalendarFeed($match_id);
						$contestantFeed = $this->Api_model->contestantFeed($match_id);
						$goalFeed = $this->Api_model->goalFeed($match_id);
						//$scoresFeed = $this->Api_model->scoresFeed($match_id,$matchDate);
						$missedPenFeed = $this->Api_model->missedPenFeed($match_id);
						$cardFeed = $this->Api_model->cardFeed($match_id);
						$substituteFeed = $this->Api_model->substituteFeed($match_id);
						
						
						
						
						$array=array('matchinfo'=>array($matchFeed,'competition'=>$competitionFeed,'tournamentCalendar'=>$tournamentCalendarFeedFeed,'contestant'=>$contestantFeed,'goal'=>$goalFeed,'missedPen'=>$missedPenFeed,'card'=>$cardFeed,'substitute'=>$substituteFeed));
						 echo json_encode($array);
					}
				
				   //Get Sports name//
					public function getSportsname()
					{ 
					$this->load->model('Api_model');
				
					$sport_name = $this->Api_model->sport_name();
						
					  
						$array = array('data' => $sport_name);
						echo json_encode($array);
					}
					
					//Get League name//
					public function getleaguename()
					{ 
					
						$this->load->model('Api_model');
						//echo $league_id = $_POST['league_id'];
						$league_name = $this->Api_model->league_name();
						$array = array('data' => $league_name);
						echo json_encode($array);
					}
						public function getweekmatch($sport = '1', $league = '1',$week,$match_date)
						{ 
						$this->load->model('Api_model');
							$week_match = $this->Api_model->get_week_match($sport = '1', $league = '1',$week,$match_date);
							 $array = array('data' => $week_match);
							 echo json_encode($array);
						}
					
				
				  //Get Leaugue team standing Rank//
					public function leaguestat($sport, $league)
					{ 
						 $this->load->model('Api_model');
						 //$sport = $_POST['sport_id'];
						 //$league = $_POST['league_id'];
						 $leaguestat = $this->Api_model->get_league_stat($sport,$league);
						
						$tmp = array();
						foreach(array_reverse($leaguestat) as $v) {
						$id = $v['id'];
						isset($tmp[$id]) or $tmp[$id] = $v;
						  }
						$leaguestat = array_reverse(array_values($tmp));
					
						$array = array('data' => $leaguestat);  
						echo json_encode($array);
					  }
					
						//Get Team channel List//
						public function getteamchannellist($sport, $league)
						{ 
							$this->load->model('Api_model');
							$teamchannellist = $this->Api_model->get_team_channel_list($sport,$league);
							$array = array('data' => $teamchannellist);
							 echo json_encode($array);
						}
						
				
					  //get channel List//
						public function channellist()
						{ 
							$this->load->model('Api_model');
							$teamchannellist = $this->Api_model->channel_list();
							$array = array('data' => $teamchannellist);
							 
							  echo json_encode($array);
							
						}
				
						//Count Live Number of Broadcasters//
						function get_team_count()
						{
							   
							$this->load->model('Api_model');
							$teamchannellist = $this->Api_model->broadcasters();
							$array = array('data' => array("live_team"=>$teamchannellist,));
								
							echo json_encode($array);
							
						}
						
						/*public function follow($follow_id, $follower_id)
				        {
				
					$this->load->model('Api_model');
				
					$followid = $this->Api_model->active_channel($follow_id, $follower_id);

					$array = array('data' => $followid);
					echo json_encode($array);
				}*/
				
					public function follow($follow_id, $follower_id)
				{
					//echo "fgdfg";
					$this->load->model('Api_model');
				
					$followid = $this->Api_model->active_channel($follow_id, $follower_id);

					$array = array('data' => $followid);
					echo json_encode($array);
				}
					
						//Get follow user//
						 public function get_follow($follower, $following,$status)
						{
					
							$this->load->model('Api_model'); 
							//echo "hello";
							//print_r($_POST);
							$follow = $this->Api_model->get_follow($follower, $following,$status);

							$array = array('data' => $follow);
							echo json_encode($array);  
						}
						
						public function get_about()
							{ 
								$this->load->model('Api_model');
								$array = $this->Api_model->aboutus();
								$privacy_policy = $this->Api_model->privacy_policy();
								$about = array_merge($array,$privacy_policy);
								
								
									
									$aboutus = array('data' => $about);
									
								
								echo json_encode($aboutus);
							}
							public function get_privacy_policy()
							{ 
								$this->load->model('Api_model');
								$privacy_policy = $this->Api_model->privacy_policy();
								foreach($privacy_policy as $privacypolicy){
									
									$pripolicy = array('data' => $privacypolicy);
									
									}
								echo json_encode($pripolicy);
							}
							public function get_term_condition()
							{ 
								$this->load->model('Api_model');
								$term_condition = $this->Api_model->term_condition();
								foreach($term_condition as $term_conditions){
									
									$termcondi = array('data' => $term_conditions);
									
									}
								echo json_encode($termcondi);
							}
							
							 public function news()
							  { 
								$this->load->model('Api_model');
								$news_data = $this->Api_model->get_news();
								$array = array('data' => $news_data);
							  //print_r($array);  
								echo json_encode($array);
				
			              	}
							
					public function getmatchdata($sport_id,$league_id,$match_start_date)
					{ 
					$this->load->model('Api_model'); 
					
					$match_data = $this->Api_model->match_data($sport_id,$league_id,$match_start_date);
						
					  
						$array = array('data' =>$match_data);
						echo json_encode($array);
					}
					public function getmatch($sport_id,$league_id,$match_start_date)
					{ 
					$this->load->model('Api_model'); 
					
					$match_data = $this->Api_model->matchdata($sport_id,$league_id,$match_start_date);
					$team_broadcaster_count = $this->Api_model->team_broadcaster_count($sport_id,$league_id);
						
					  
						$array = array('data' =>$match_data,"team_broadcaster_count"=>$team_broadcaster_count);
						echo json_encode($array);
					}
					
					//get image
					public function get_image(){
					
					$this->load->model('Api_model');
					$images = $this->Api_model->images();
					$array = array('data' => $images);
					//print_r($array);  
					echo json_encode($array);
					
					
					}
					
					
					public function leaguestatest($sport, $league)
				    { 
					 $this->load->model('Api_model');
					
					 $leaguestat = $this->Api_model->leagueststest($sport,$league);
					
					 $tmp = array();
						 
							foreach(array_reverse($leaguestat) as $v) {
							$id = $v['id'];
							isset($tmp[$id]) or $tmp[$id] = $v;
							}
							$leaguestat = array_reverse(array_values($tmp));
							$array = array('data' => $leaguestat);  
							
							echo json_encode($array);
				   }
				
				public function follow_check($broadcaster_id,$user_id,$channel_id){
					
					$this->load->model('Api_model');
					
					$follow_info = $this->Api_model->follow_check($broadcaster_id,$user_id);
					
					
					$data = array(
					 'user_id' => $broadcaster_id,
					 'channel_id' => $channel_id
					
					);
					
					$this->db->select('*');
					$this->db->from('listeners');
					$this->db->where(array('channel_id'=>$channel_id,'user_id'=>$user_id));
					$query = $this->db->get()->result_array();
				    $count = count($query);
					
					if($count == 0){
					     $listeners = $this->Api_model->listeners_mount($data);
				
					$data_info  = array();
					foreach($follow_info as $info){
						
						$data_info['info'] = $info;
						$data_info['listener_id'] = $listeners;
							
						
					}
				}
			
				else{
					$data_info  = array();
					foreach($follow_info as $info){
						
						$data_info['info'] = $info;
						$data_info['listener_id'] = 0;
				                   }
				}
					echo json_encode($data_info);
				
			}
				
				public function listeners_unmount($id){
						$this->load->model('Api_model');
					   $result = $this->Api_model->delete_listeners($id);
					   
					   if($result){
						   $array = array('msg' =>'eleted successfully');
					   }
					   
					   else{
						      $array = array('msg' =>'eleted successfully');
						   
					   }
					    
					   echo json_encode($array);
				} 
				
				public function ChannelListener_count($channel_id){
					
					$this->load->model('Api_model');
					$listener_count = $this->Api_model->channellistener_count($channel_id);
					$array = array('count' => $listener_count);
					
					echo json_encode($array); 
					
					} 
					
			public function listeners_count()
			{
					$this->load->model('Api_model');
					$listener_count = $this->Api_model->listeners_count();
					$broadcaster_count = $this->Api_model->broadcaster_count();
					$array = array('listeners_count' =>$listener_count,'broadcaster_count'=>$broadcaster_count);
					
					echo json_encode($array); 
			}
					
				
				public function broadcaster_detail($match_id){
					 $this->load->model('Api_model');
					
					$broadcaster_info = $this->Api_model->broadcaster_detail($match_id);
					  	$array = array('channel' => $broadcaster_info);  
					echo json_encode($array);
					
					
				}
				
		    public function getSports()
		 			{ 
					$this->load->model('Api_model');
				
					$sport_name = $this->Api_model->sport_nametest();
						
					  
						$array = array('data' => $sport_name);
						echo json_encode($array);
					}
				    
				public function count(){
				
						$this->load->model('Api_model');
					$listener_count = $this->Api_model->listeners_count();
					$broadcaster_count = $this->Api_model->broadcaster_count();
					$array = array('listeners_count' =>$listener_count,'broadcaster_count'=>$broadcaster_count);
					
					echo json_encode($array); 
					}
					
					public function match_count(){
					
					$this->load->model('Api_model');
				
				//	$broadcaster_count = $this->Api_model->match_count();	
					$listener_count = $this->Api_model->broadcaster_count();
				
				
					$array = array('listeners_count' =>$listener_count);
					
					echo json_encode($array); 
						
					}
					public function count_match(){
						
						$this->load->model('Api_model');
				
				//	$broadcaster_count = $this->Api_model->match_count();	
					$listener_count = $this->Api_model->match_count();
				
				
					$array = array('listeners_count' =>$listener_count);
					
					echo json_encode($array); 
					}
					
					
				//}   
				
						 public function getUsersData(){
							 
								$this->load->model('Api_model');
								
								$broadcast_list = $this->Api_model->getuserbroadcastlist();
				                $array = array('users_list' =>$broadcast_list);
								
								echo json_encode($array); 
						     } 	
						     
						     	 public function getUsersDataTest(){
							 
								$this->load->model('Api_model');
								
								$broadcast_list = $this->Api_model->getuserbroadcastlisttest();
								
				                $array = array('users_list' =>$broadcast_list);
								
							
								
								echo json_encode($array); 
						     } 	
						     
		public function get_users_match_info(){

			$this->load->model('Api_model');

			$broadcast_list = $this->Api_model->get_users_info();
			$array = array('users_list' =>$broadcast_list);
			
	

		foreach ($broadcast_list as $order) {
			
	        if(isset($order['channel_info'])){
				$array1[] = $order;
				
			}
			else{
				$array2[] = $order;
				
			}
		}
		
		if(empty($array1)){
			$array = array('users_list' =>$broadcast_list);
			echo json_encode($array); 
		}
		else{
        
   $array4 = array_merge($array1,$array2);
    
            
         $array3 = array('users_list' =>$array4);

     
			echo json_encode($array3); 
				//echo json_encode($array); 
			}
		} 
	

			
		
			public function get_users_match_info_test(){

			$this->load->model('Api_model');

			$broadcast_list = $this->Api_model->get_users_info_test();
			$array = array('users_list' =>$broadcast_list);
			
	

		foreach ($broadcast_list as $order) {
			
	        if(isset($order['channel_info'])){
				$array1[] = $order;
				
			}
			else{
				$array2[] = $order;
				
			}
		}
		
		if(empty($array1)){
			$array = array('users_list' =>$broadcast_list);
			echo json_encode($array); 
		}
		else{
        
   $array4 = array_merge($array1,$array2);
    
            
         $array3 = array('users_list' =>$array4);

     
			echo json_encode($array3); 
				//echo json_encode($array); 
			}
		} 
	

						 
			}
