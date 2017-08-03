<?php
error_reporting(0); 
  
         class Broadcast extends CI_Controller {

				public function __construct(){
								
						parent::__construct();
						 $this->load->database();
								  
									//$this->load->model('user_model');
							}
				public function get_pundit_list( $match_id )
				{
					$this->load->model('Api_model');
					$pundit_list = $this->Api_model->get_pundit_data($match_id);
                    $array = array('data' => $pundit_list);
					echo json_encode($array);
				}
				
				
				
				

			    public function mount()
				{
					echo "mount";
			             $this->load->model('Channel_model');
				
			
					 if ($this->input->server('REQUEST_METHOD') == 'GET')
						  {
							 
							   $channel_name = $this->input->get('name');
							   $match_id = $this->input->get('match_id');
							   $broadcaster_id = $this->input->get('broadcaster_id');
							   $station = $this->input->get('station');
							   $appName = $this->input->get('appName');
							   $streamName = $this->input->get('streamName');
							   $channeltype = $this->input->get('channel_type');
				   
						  }else if ($this->input->server('REQUEST_METHOD') == 'POST'){
							   $channel_name = $this->input->post('name');
							   $match_id = $this->input->post('match_id');
							   $broadcaster_id = $this->input->post('broadcaster_id');
							   $station = $this->input->post('station');
							   $appName = $this->input->post('appName');
							   $streamName = $this->input->post('streamName');
							   $channeltype = $this->input->post('channel_type');
						 }
					
					$channel_id = $this->Channel_model->active_channel($channel_name,$match_id, $broadcaster_id, $station ,$appName,$streamName,$channeltype);
echo "<pre>";
print_r($channel_id);
echo "</pre>";
					$array = array('data' => $channel_id);
					if(empty($array)){
					echo "NO Found";
						
						}else{
					echo json_encode($array);
				}
				}

						public function unmount($channel_id )
						{
							$this->load->model('Channel_model');
					
							$channel_update = $this->Channel_model->deactive_channel($channel_id);

							$array = array('data' => $channel_update);
						
							echo json_encode($array);
						}

						public function count( $sport = '0', $league = '0' )
						{
							$broadcasters = array();

							$this->load->model('Sport_model');
							$sports = $this->Sport_model->get_all_sport();

							$sport_count = count($sports);
							for($i = 0; $i < $sport_count; $i++) {
								$broadcasters[$sports[$i]['name']] = $this->get_broadcast_count($sports[$i]['id'], $league);
							}

							if($sport != '0' && $league != '0') {
								// Get league
								$this->load->model('League_model');
								$league = $this->League_model->get_all_league();

								$league_count = count($league);
								for($i = 0; $i < $league_count; $i++) {
									$broadcasters[$league[$i]['name']] = $this->get_broadcast_count($sport, $league[$i]['id']);
								}
							}

							echo json_encode($broadcasters);
						}

						public function get_broadcast_count( $sport = '0', $league = '0' )
						{
							// get seasons from sport and league
							$this->load->model('Season_model');
							$seasons = $this->Season_model->get_season_from_sport($sport, $league);

							// then get matches from season
							$this->load->model('Match_model');
							$matches = $this->Match_model->get_match_from_season($seasons);

							// then get channels from match
							$this->load->model('Channel_model');
							$channels = $this->Channel_model->get_channel_from_match($matches);

							return count($channels);
						}
						public function listeners_count($channel_id)
						{
							  echo "count listeners";
							
							 $CI =& get_instance(); 
							 // use get_instance, it is less prone to failure
						   //  print_r($CI);          
						      // in this context.
							  $CI->load->model("Channel_model");
							
							 print_r($res);
							 
							 if($load)
							 {
								 echo "fine";
							 }
							 else
							 {
							 echo "fail";
							 }
							 
							 $this->load->model('Listeners_model');
							 $this->Listeners_model->get_listeners_count($channel_id);
						}
						 public function getChannelByMatchId($match_id)
						 {
						 
							$this->load->model('Channel_model');
							 
							$channel_id = $this->Channel_model->get_Channel_ByMatchId($match_id);

							$array = array('data' => $channel_id);
							 
							 if(!$array['data']==''){
								 echo json_encode($array);
							
							   }else{
								echo "no data";
							
							 }
						 
						 }
						 
				
					}
