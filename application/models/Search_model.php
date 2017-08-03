<?php
error_reporting(0);  

class Search_model extends CI_Model {

    private $teams;
    private $season;
    private $users;

    public function __construct()
    {
        $this->load->database();
    }
    
     function get_teams() {
        if(!$this->teams) {
            $this->load->model("Team_model");
            $this->teams = $this->Team_model->get_all_team_name_indexed();
        }
 
        return $this->teams;
    } 
    
    public function user_sport_search($search_text){
		
		$this->db->select('*');
		$this->db->from('user');
		$this->db->or_where("`first_name` LIKE '%$search_text%'");
		$query = $this->db->get()->result_array();
		
		return $query;
		
	}	
	

	
	
	public function get_channel_info($broadcaster_id){
		
		$this->db->select('channel.* ,league.mark_image	');
		$this->db->from('channel');
		$this->db->join('league', 'league.id = channel.league_id', 'left');
		$this->db->where('broadcaster_id',$broadcaster_id);
		$this->db->where('channel.live',1);
		$data = $this->db->get()->result_array();
		
		$match_info = array();
		$team_info = array();
		//$result_data = array();
		
		$result_data['channel']	= $data ; 
		
		
		if($result_data['channel']['channel_type'] =='match'){
			$result_data['match_info'] = $this->get_match_info($result_data['channel']['match_id']);
		}
		if($result_data['channel']['channel_type'] =='team'){
			$result_data['team_info'] = $this->get_team_info($result_data['channel']['match_id']);
		}
	
		return $result_data;
		
		
	}
    public function get_match_info($match_id){
		
		$this->db->select('*');
		$this->db->from('match');
		$this->db->where('match_id',$match_id);		
		$data = $this->db->get()->row_array();
		$match = array();
		
		$teams = $this->get_teams();		
		$match = $data;
		
		$match['team1_name'] = $teams[$data['team1_id']];
		$match['team2_name'] = $teams[$data['team2_id']];
		 
	
		return 	$match;
		
	}
    
    public function get_team_info($team_id){
		
		$this->db->select('*');
		$this->db->from('team');
		$this->db->join('standings','standings.contestantId = team.id','left');
		$this->db->where('team.id',$team_id);		
		$data = $this->db->get()->row_array();
	
		return 	$data;
	}
    
    
    public function user_sport_channel_search($search_text){
		
		$this->db->select('*');	
		$this->db->from('user');	
		$this->db->like('first_name',$search_text, 'both'); 
	//	$this->db->or_where("`first_name` LIKE '%$search_text%'");
		$query = $this->db->get()->result_array();	
		  
		$result = array();
	
	
		if(count($query) >0 ){
			
			foreach($query as $user){
		
			
				$channel = $this->get_channel_info($user['id']); 
		
				 	$user['live'] =0;	
				if(!empty($channel['channel'])){
	
					//echo '<pre>'; print_r($channel);  echo '</pre>';	
					$user['live'] =1;	
					$user['channel_info'] = array($channel); 	
					
				}
				
				$result[] = $user; 
				
			}
				
		}
		//echo '<pre>'; print_r($result);  echo '</pre>';
		return $result;
		
	}
	
	public function get_team_channel_info($team_id){
		
		$this->db->select('*');
		$this->db->from('channel');
		//$this->db->join('league', 'league.id = channel.league_id', 'left');
		$this->db->where('match_id',$team_id);
		$this->db->where('channel.live',1);
		$data = $this->db->get()->result_array();

		
	
		//$result_data = array();
		
		$result_data[]	= $data ; 
		
		
	
	
		return $data;
	//	return $data;
		
	}
	
	 public function team_sport_channel_search($search_text){
		
			$this->db->select('team.*,s.id AS s_id,s.rank,s.rankStatus,s.lastRank,s.contestantId,s.contestantName,s.contestantShortName,s.contestantClubName,s.contestantCode,s.points,s.matchesPlayed,s.matchesWon,s.matchesLost,s.matchesDrawn,s.goalsFor,s.goalsAgainst,s.goaldifference,s.last_update,league.id AS l_id,league.name AS league_name,league.position,league.competition_id,league.stage_id,league.mark_image');
		$this->db->from('team');
		$this->db->join('standings s', 's.contestantId = team.id','left');
		$this->db->join('league', 'league.id = team.league_id', 'left');
		//$this->db->or_where("`name` LIKE '%$search_text%'");
		$this->db->like('team.name',$search_text, 'both'); 
		$query = $this->db->get()->result_array();
		$result = array();
	   
	
		if(count($query) >0 ){
			
			
			foreach($query as $team){
			$channel = $this->get_team_channel_info($team['id']); 
				$abc = $team; 
		           
		
		
				 	$abc['live'] =0;	
				if(!empty($channel)){
	         foreach($channel as $result){
		
					//echo '<pre>'; print_r($channel);  echo '</pre>';	
					$abc['live'] =1;	
					$abc['channel_info'][] = $result; 	
					
				}
			
			}
					$res[] = $abc;
				
				
			}
				
		}
		//echo '<pre>'; print_r($result);  echo '</pre>';
		return $res;
		
	}
	
	 public function team_sport_search($search_text){
		
		$this->db->select('team.*,s.id,s.rank,s.rankStatus,s.lastRank,s.contestantId,s.contestantName,s.contestantShortName,s.contestantClubName,s.contestantCode,s.points,s.matchesPlayed,s.matchesWon,s.matchesLost,s.matchesDrawn,s.goalsFor,s.goalsAgainst,s.goaldifference,s.last_update,league.id AS l_id,league.name AS league_name,league.position,league.competition_id,league.stage_id,league.mark_image');
		$this->db->from('team');
		$this->db->join('standings s', 's.contestantId = team.id','left');
		$this->db->join('league', 'league.id = team.league_id', 'left');
		//$this->db->or_where("`name` LIKE '%$search_text%'");
		$this->db->like('team.name',$search_text, 'both'); 
		$query = $this->db->get()->result_array();
		
		return $query;
		
	}
	
	public function team_search($league_id,$search_text){
		
		$this->db->select('*');
		$this->db->from('team');
		$this->db->or_where("`name` LIKE '%$search_text%'");
	//	$this->db->where('league_id',$league_id);
		
		
		$query = $this->db->get()->result_array();
		
		return $query;
		
	}
	
	public function team_league_channel_search($sport_id,$search_text){
		
		$this->db->select('team.*,league.id AS league_id');
		$this->db->from('league');
		$this->db->join('team','team.league_id = league.id','left');
		$this->db->where('league.sport_id',$sport_id);
		$this->db->like('team.name',$search_text, 'both'); 
		
		$query = $this->db->get()->result_array();
		$result = array();
	
	
		if(count($query) >0 ){
			
			foreach($query as $team){
			
			
				$channel = $this->get_team_channel_info($team['id']); 
			    $team['live'] =0;	
				  if(!empty($channel['channel'])){
	
						//echo '<pre>'; print_r($channel);  echo '</pre>';	
						$team['live'] =1;	
						$team['channel_info'] = array($channel); 	
					
				}
				
				$result[] = $team; 
				
			}
				
		}
		//echo '<pre>'; print_r($result);  echo '</pre>';
		return $result;
		
		
	}
	
	public function team_league_search($sport_id,$search_text){
		
		$this->db->select('team.*,league.id');
		$this->db->from('league');
		$this->db->join('team','team.league_id = league.id','left');
		$this->db->where('league.sport_id',$sport_id);
		//$this->db->where("`team.name` LIKE '%$search_text%'");
		 $this->db->like('team.name',$search_text, 'both'); 
		
		$query = $this->db->get()->result_array();
		$result = array();
		
		
		return $query;
	}
	
	}
