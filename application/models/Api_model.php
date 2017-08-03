<?php
error_reporting(0);  

class Api_model extends CI_Model {

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


    // function get_active() {
    //   $this->db->select(*);
    //    $this->db->from('active_users');
    //    $query = $this->db->get();
    //    return $query;
    // }

    function get_season() {
        if(!$this->season) {
            $this->load->model("Season_model");
            $this->season = $this->Season_model->get_all_season_name_indexed();
        }

        return $this->season;
    }

		function get_users() {
			if(!$this->users) {
				$this->load->model("Users_model");
				$this->users = $this->Users_model->get_all_user_name_indexed();
			}

			return $this->users;
		}



     public function get_match_data( $sport, $league,$match_start_date)
    {
        
        
        $start_date = strtotime("-30 day", strtotime($match_start_date));        
        $startdate = date("Y-m-d", $start_date);
        $end_date = strtotime("+60 day", strtotime($match_start_date));
        $enddate = date("Y-m-d", $end_date);
        
        $matches = array();
        
        $this->db->distinct();
        $this->db->select('a.*, a.id AS data_id');
        $this->db->from('match a');
        $this->db->join('season b', 'b.id = a.season_id', 'left');
        $this->db->where('b.sport_id',1);
        $this->db->where('b.league_id',1);
        //$this->db->where('a.match_start_date',$match_start_date); 
        //$this->db->where('a.match_start_date BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND NOW()');
        //$this->db->where("a.match_start_date ='".$startdate."' OR a.match_start_date ='".$enddate."'");
        
        $this->db->where('a.match_start_date >=', $startdate);
        $this->db->where('a.match_start_date <=', $enddate);
        
        $this->db->order_by('a.id', 'asc');
        $this->db->group_by('a.match_id');
        $query = $this->db->get();

        if($query->num_rows() != 0)
        {
            $teams = $this->get_teams();
			
            $seasons = $this->get_season();
               
            foreach( $query->result_array() as $row ) {
               
                $match = $row;
                $match['team1_name'] = $teams[$row['team1_id']];
                $match['team2_name'] = $teams[$row['team2_id']];
                $match['season_name'] = $seasons[$row['season_id']];

            //$matches[] = array_filter($match);
            $matches[] = $match;
            
        }
        }

        return $matches;
    }
    
    public function listeners_mount($data){
		
		$insert = $this->db->insert('listeners', $data);
		 $user_last_insert_id = $this->db->insert_id();
		 
		
		return $user_last_insert_id;
		
		
	}
	
		 public function delete_listeners($id){
		 
		    $this->db->where('id',$id);
			$delete = $this->db->delete('listeners');
			return $delete;
		 
	 }
	 
	 public function channellistener_count($channel_id){
		
		 $this->db->select('l.*');
		 $this->db->from('channel');
		 $this->db->join('listeners l', 'l.channel_id = channel.id','right');
		 $this->db->where('channel.live',1);
		 $this->db->where('l.channel_id',$channel_id);
		 
		 $query = $this->db->get()->result_array();
		 $count = count($query);
		
		 
		 return $count;   
		 
	 } 
	 
	 public function listeners_count(){
		 
		 $this->db->select('l.*');
		 $this->db->from('channel');
		 $this->db->join('listeners l', 'l.channel_id = channel.id','right');
		 $this->db->where('channel.live',1);
         $query = $this->db->get()->result_array();
        
       
		 
		 
		 
		
		 
		 $count = count($query);
		 
		 return $count;
		 
	 }
    
     public function get_match_data_filter($sport,$league,$match_start_date)
    {
        
        
        $start_date = strtotime("0 day", strtotime($match_start_date));        
        $startdate = date("Y-m-d", $start_date);
        $end_date = strtotime("1 day", strtotime($match_start_date));
        $enddate = date("Y-m-d", $end_date);
        
        $matches = array();
        $this->db->distinct();
        $this->db->select('a.*, a.id AS data_id');
        $this->db->from('match a');
        $this->db->join('season b', 'b.id = a.league_id', 'left');
        $this->db->where('b.sport_id',$sport);
        $this->db->where('b.league_id',$league);
         $this->db->where('a.match_start_date', $match_start_date);
        //$this->db->where('a.match_start_date',$match_start_date); 
        //$this->db->where('a.match_start_date BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND NOW()');
        //$this->db->where("a.match_start_date ='".$startdate."' OR a.match_start_date ='".$enddate."'");
        //$this->db->where('a.match_start_date >=', $startdate);
        //$this->db->where('a.match_start_date <=', $enddate);
        
        $this->db->order_by('a.id', 'asc');
        $this->db->group_by('a.match_id');
        $query = $this->db->get();

        if($query->num_rows() != 0)
        {
            $teams = $this->get_teams();
			
            $seasons = $this->get_season();
               
            foreach( $query->result_array() as $row ) {
               
                $match = $row;
                $match['team1_name'] = $teams[$row['team1_id']];
                $match['team2_name'] = $teams[$row['team2_id']];
                $match['season_name'] = $seasons[$row['season_id']];
                $matches[] = $match;
            
        }
        }

        return $matches;
    }


       function images(){
			   
			   $imagesbanner = array();

				$this->db->select('*');
				$this->db->from('banner');
				$this->db->order_by('id', 'DESC');
				//$this->db->limit('1','1');
				 $query = $this->db->get();
				   if(count($query) > 0) {
						$images = $query->result_array();
						
						
						foreach($images as $row){
							
							$imagesbanner = $row;
							
							}
					}

				return $imagesbanner;
			   
			   }
			   
    public function get_channel_data( $sport,$league,$match_start_date)
    {
        $channels = array();
        $this->db->select('*, a.id AS data_id');
        $this->db->from('channel a');
        $this->db->join('match b', 'b.match_id = a.match_id', 'left');
        $this->db->join('season c', 'c.id = b.league_id', 'left');
        $this->db->where('a.live', '1');
        $this->db->where('c.sport_id',$sport);
        $this->db->where('c.league_id',$league);
         $this->db->where('b.match_start_date',$match_start_date);
        $this->db->order_by('a.id', 'asc');
        $query = $this->db->get();

        if($query->num_rows() != 0)
        {
            $teams = $this->get_teams();
            $seasons = $this->get_season();
            $users = $this->get_users();

            foreach( $query->result_array() as $row ) {
                $channel = $row;
                $channel['team1_name'] = $teams[$row['team1_id']];
                $channel['team2_name'] = $teams[$row['team2_id']];
                $channel['season_name'] = $seasons[$row['season_id']];
                $channel['broadcaster_name'] = $users[$row['broadcaster_id']];

                $channels[] = $channel;
            }
        }

        return $channels;
    }

     public function get_channel_testdata( $sport,$league,$match_start_date)
    {
	
		 $match = array();
		 $channels = array();
		$this->db->select('*');
		$this->db->from('match');
		$this->db->where('match_start_date',$match_start_date);
		$query = $this->db->get();
		
		$this->db->select('*');
		$this->db->from('channel');
		$this->db->where('live', '1');
		$query1 = $this->db->get();
		
		foreach( $query->result_array() as $row ) {
			      $match = $row;
			      echo "<prematch>";
			      print_r($row);
			      echo "</prematch>";
		foreach( $query1->result_array() as $row1 ) {
			 echo "<pre>";
			      print_r($row);
			      echo "</pre>";
			 $channels = $row1;
			
			 if($row['match_id'] == $row1['match_id']){
			
			 }
	
  }
}

       //return $match;
    }
    
    public function get_pundit_data( $match_id )
    {
        $pundits = array();

        $this->db->select('*, a.id AS data_id, COUNT(d.id) AS listeners');
        $this->db->from('channel a');
        $this->db->join('match b', 'b.match_id = a.match_id', 'left');
        $this->db->join('season c', 'c.id = b.season_id', 'left');
        $this->db->join('listeners d', 'd.channel_id = a.id', 'left');

        $this->db->where('a.match_id', $match_id);
        $this->db->where('a.live', '1');
        $this->db->order_by('a.id', 'asc');
        $query = $this->db->get();

        if($query->num_rows() != 0)
        {
            $teams = $this->get_teams();
            $seasons = $this->get_season();
            $users = $this->get_users();

            foreach( $query->result_array() as $row ) {
               
                $pundit = $row;
                $pundit['team1_name'] = $teams[$row['team1_id']];
                $pundit['team2_name'] = $teams[$row['team2_id']];
                $pundit['season_name'] = $seasons[$row['season_id']];
                $pundit['broadcaster_name'] = $users[$row['broadcaster_id']];
                $channel['appName'] = $users[$row['appName']];
                $channel['streamName'] = $users[$row['streamName']];
                $pundits[] = $pundit;



            }
        }

        return $pundits;
    }
    
    public function broadcaster_count(){
		$this->db->select('*');
		$this->db->from('channel');
		$this->db->where('live',1);
		$query = $this->db->get()->result_array();
		$count = count($query);
		return $count;
		
	}
    
    public function sport_count(){
		
	 $this->db->select('sport_id, COUNT(sport_id) as total');
     $this->db->group_by('sport_id'); 
      $this->db->from('channel');
      $this->db->where('live',1);
		$query = $this->db->get()->result_array();
	
	    return $query;
		
		
	}
    
	public function get_match_score($match_id = '')
    {
        $pundits = array();

        $this->db->select('*');
        $this->db->from('match');
        $this->db->where('match_id',$match_id);
        
        $query = $this->db->get();
           if(count($query) > 0) {
                $getscore = $query->result_array();
				
            }

        return $getscore;
    }
    
    public function matchFeed($match_id)
    {
        $matchFeed = array();

         $this->db->select('*');
         $this->db->from('match');
         $this->db->where('match_id',$match_id);
        
       
         $query = $this->db->get();
           if(count($query) > 0) {
                $matchFeed = $query->result_array();
				
            }

        return $matchFeed;
    }
    public function competitionFeed($match_id)
    {
        $competitionFeed = array();

         $this->db->select('*');
         $this->db->from('competition');
         $this->db->where('match_id',$match_id);
         
         $query = $this->db->get();
           if(count($query) > 0) {
                $competitionFeed = $query->result_array();
				
            }

        return $competitionFeed;
    }
    //follow_live_match
   
    public function follow_live_match($match_id,$broadcaster_id,$user_id)
    {	
        $follow_info = '';
        //select * form channel where userid='' and broadcast_id ='' and live =1
        
        //foreach channel_id check user_id in  listeners 
        
		 $this->db->distinct();	
         $this->db->select('*');
         $this->db->from('channel');
         $this->db->join('listeners','channel.id =listeners.channel_id AND channel.match_id = "'.$match_id.'" AND channel.broadcaster_id="'.$broadcaster_id.'"');
         $this->db->join('follow_table','follow_table.follower_id =listeners.user_id AND follow_table.follower_id='.$user_id.'');
         $this->db->join('user','follow_table.follower_id =user.id AND user.id='.$broadcaster_id.'');
		 $this->db->group_by('user.id');
        
         $query = $this->db->get();
         $num = $query ->num_rows();  
         
         //Count followers
         $this->db->select('*');
		 $this->db->from('follow_table');
		 $this->db->where('live','1');
		 $this->db->where('follower_id',$broadcaster_id);
		 $follower_count = $this->db->get();	
		 $data =$follower_count->row();
		//print_r($this->db->last_query());
		 		
		 $f_num = $follower_count ->num_rows();  
        
		 //echo '<pre>'; print_r($data); echo'</pre>';
         if($num > 0) {
              $follow_info = $query->result_array();	
              $follow_info['follow'] = 1;			
              $follow_info['follower_count'] = $f_num;			
           //   $follow_info['follower_id'] = $data->follower_id;			              		
         }
		else{
			
			$this->db->select('*');
			$this->db->from('user');
			$this->db->join('hash_tag','user.id =hash_tag.user_id AND user.id="'.$broadcaster_id.'"');			
			$query = $this->db->get();
			$follow_info = $query->result_array();
			//$follow_info = $this->db->get()->result();
			//echo "<pre>";print_r($follow_info);
			$follow_info['follow'] = 0;
			$follow_info['follower_count'] = $f_num;
		//	 $follow_info['follower_id'] = $data->follower_id;			
         //     $follow_info['following_id'] = $data->following_id;		
		}						

        return $follow_info;
    }
    
     public function leagueststest($sport_id,$league_id)
        {
			
        $m = array();
        $match_data = array();
        	 $this->db->select('s.id,c.id as c_id,s.rank,s.rankStatus,s.lastRank,s.contestantId,s.contestantName,s.contestantShortName,s.contestantClubName,s.contestantCode,s.points,s.matchesPlayed,s.matchesWon,s.matchesLost,s.matchesDrawn,s.goalsFor,s.goalsAgainst,s.goaldifference,s.last_update,c.match_id,c.channel_type,c.live, count(s.contestantId) as count_match');   
				$this->db->from('standings s');
				
				$this->db->join('channel c', 's.contestantId = c.match_id','left');
				$this->db->where('s.sport_id',$sport_id);
				$this->db->where('s.league_id',$league_id);
		    	//$this->db->where('c.live','1');
				$this->db->group_by(array("s.contestantId", "c.live", "c.channel_type"));

				$this->db->order_by('s.rank',"asc");
        
        
             $query = $this->db->get();
             $result = $query->result_array();

               if(count($query) > 0) {
			   $channel_data = $this->channel_data();
		        foreach($channel_data as $value){
			   foreach($value as $abc)
					 {
					
					 $jkl[]=$abc;
				 }
			  }
            foreach( $query->result_array() as $row ) {
				
					$match = $row;
			$match['channel'] = $m;
              foreach($jkl as $res)
			  {
                     if($row['contestantId'] == $res['match_id'])
					 {
						   
						 if($res['live'] == '1' && $res['channel_type'] =='team'){
						  //$match['league'] =$res['sport_id'];
						
						  $match['channel'][] = $res;
						  }
						/* else{
								$match['channel1']= $m;
						  }*/
					 
					
					 }
					
					 
		 } 
	
			
			 $match_data[] = $match;
		   }
		   
		   }
		   
		   
        return $match_data;
       
    }
    
     public function tournamentCalendarFeed($match_id)
    {
        $tournamentCalendarFeed = array();

         $this->db->select('*');
         $this->db->from('tournamentCalendar');
         $this->db->where('match_id',$match_id);
         
        $query = $this->db->get();
           if(count($query) > 0) {
                $tournamentCalendarFeed = $query->result_array();
				
            }

        return $tournamentCalendarFeed;
    }
    public function contestantFeed($match_id)
    {
        $contestantFeed = array();

         $this->db->select('*');
         $this->db->from('contestant');
         $this->db->where('match_id',$match_id);
        
         $query = $this->db->get();
           if(count($query) > 0) {
                $contestantFeed = $query->result_array();
				
            }

        return $contestantFeed;
    }
    
    
     public function missedPenFeed($match_id)
    {
        $cardLiveFeed = array();

         $this->db->select('*');
         $this->db->from('missedPen');
         $this->db->where('match_id',$match_id);
          $this->db->order_by("timeMin", "asc");
       
         $query = $this->db->get();
           if(count($query) > 0) {
                $cardLiveFeed = $query->result_array();
				
            }

        return $cardLiveFeed;
    }
    
    
    public function cardFeed($match_id)
    {
        $cardLiveFeed = array();

         $this->db->select('*');
         $this->db->from('card');
         $this->db->where('match_id',$match_id);
          $this->db->order_by("timeMin", "asc");
       
         $query = $this->db->get();
           if(count($query) > 0) {
                $cardLiveFeed = $query->result_array();
				
            }

        return $cardLiveFeed;
    }
    public function scoresFeed($match_id)
    {
        $scoresLiveFeed = array();

         $this->db->select('*');
         $this->db->from('scores');
         $this->db->where('match_id',$match_id);
        
         $query = $this->db->get();
           if(count($query) > 0) {
                $scoresLiveFeed = $query->result_array();
				
            }

        return $scoresLiveFeed;
    }
    public function goalFeed($match_id)
    {
        $goalLiveFeed = array();

         $this->db->select('*');
         $this->db->from('goal');
         $this->db->where('match_id',$match_id);
         $this->db->order_by("timeMin", "asc");
       
         $query = $this->db->get();
           if(count($query) > 0) {
                $goalLiveFeed = $query->result_array();
				
            }

        return $goalLiveFeed;
    }
    public function substituteFeed($match_id)
    {
        $substituteLiveFeed = array();

         $this->db->select('*');
         $this->db->from('substitute');
         $this->db->where('match_id',$match_id);
         $this->db->order_by("timeMin", "asc");
       
         $query = $this->db->get();
           if(count($query) > 0) {
                $substituteLiveFeed = $query->result_array();
				
            }

        return $substituteLiveFeed;
    }
	
	
	public function league_name()
    {
		
        $pundits = array();

        $this->db->select('*');
        $this->db->from('sport s');
         $this->db->join('league l', 'l.sport_id=s.id', 'right');
		//$this->db->where('l.sport_id',$id);
		//$this->db->order_by("s.sport_id", "desc");
		//$this->db->where('s.id','4');
        $query = $this->db->get();
		//echo $query->num_rows();
		//print_r($query);
           if(count($query) > 0) {
                $league_name[] = $query->result_array();
                foreach($league_name as $val){
				//$league_name = $val;
				}
				
            }

        return $league_name;
    }
    
    public function match_count(){
		
		
		 $this->db->select('league_id, COUNT(league_id) as total');
		 $this->db->group_by('league_id'); 
		 $this->db->order_by('total', 'desc'); 
		 $this->db->from('channel');
		  $this->db->where('live',1);
		 $query = $this->db->get()->result_array();
 
           return $query;
		
	}
    
    public function league_nametest()
    {
		
        $pundits = array();
        $count = array();
        $this->db->select('*');
        $this->db->from('sport s');
         $this->db->join('league l', 'l.sport_id=s.id', 'right');
		
        $query = $this->db->get();
	
           if(count($query) > 0) {
                $league_name[] = $query->result_array();
           $league_count= $this->match_count();

          
                foreach($query->result_array() as $val){
				$league = $val;
					$league['broadcaster_count'] = 0;
				
				foreach($league_count as $count){
					if($val['id'] == $count['league_id']){
				$league['broadcaster_count'] = $count['total'];
			}
		
			
		}
				$pundits6[]= $league;
				}
				$pundits[] = $pundits6;
			
            }

        return $pundits;
    }
	
	public function league_count($match_id){
		
		 $this->db->select('*');
        $this->db->from('sport s');
         $this->db->join('league l', 'l.sport_id=s.id', 'right');

        $query = $this->db->get();

           if(count($query) > 0) {
                $league_name[] = $query->result_array();
                $broadcaster = $this->broadcasterleague_count();
               // $league_name['count'] =78;
                foreach($query->result_array() as $val){
				$league = $val;
				$league['broadcaster_count'] = 12;
				$pundits6[]= $league;
				}
				$pundits[] = $pundits6;
			
            }
		
	}
	
	public function broadcasterleague_count(){
		$this->db->select('*');
		$this->db->from('channel');
		$this->db->join('match','match.match_id = channel.match_id','right');
		$this->db->where('channel.channel_type','match');
		$query = $this->db->get();
		$result = $query->result_array();
		$league = $this->league_count($match_id);
		
	    return $result;
	}
	
	public function sport_name()
    {
        $sport_name = array();

        $this->db->select('*');
        $this->db->from('sport s');
          $this->db->order_by('s.id', 'asc');
	
        $query = $this->db->get();
           if(count($query) > 0) {
                //$sport_name = $query->result_array();
				
				$league_name = $this->league_name();
			   $broadcaster_count = $this->sport_count();
			
			  foreach($league_name as $value){
				
					 foreach($value as $abc)
					 {
						 
					 $jkl[]=$abc;
				 }
			  }
            foreach( $query->result_array() as $row ) {
					$match = $row;
              foreach($jkl as $res)
			  {
		
			 //echo "<pre>";
			 //print_r($res);
							  
					 if($row['id']==$res['sport_id'])
					 {
						  //$match['league'] =$res['sport_id'];
						
						  $match['league'][] = $res;
					 }
		 } 
			  
			  
	
				
					 
					
            //$matches[] = array_filter($match);
           
			// } */
			 
				 
				
          
			 $sport_name[] = $match;
		   }
		   }
        return $sport_name;
    }
	
	
	public function sport_nametest()
    {        $sport_name = array();

        $this->db->select('*');
        $this->db->from('sport s');
          $this->db->order_by('s.id', 'asc');
	
        $query = $this->db->get();
           if(count($query) > 0) {
                //$sport_name = $query->result_array();
				
				$league_name = $this->league_nametest();
			 $sport_count = $this->sport_count();
			   //$league = $this->league_count();
			
			  foreach($league_name as $value){
				
					 foreach($value as $abc)
					 {
						 
					 $jkl[]=$abc;
				 }
			  }
            foreach( $query->result_array() as $row ) {
					$match = $row;
					$match['broadcaster_count']=0;
					foreach($sport_count as $count){
						if($row['id'] == $count['sport_id']){
					$match['broadcaster_count']=$count['total'];
				}
				
			}
              foreach($jkl as $res)
			  {
		
			 //echo "<pre>";
			 //print_r($res);
							  
					 if($row['id']==$res['sport_id'])
					 {
						  //$match['league'] =$res['sport_id'];
						
						  $match['league'][] = $res;
					 }
		 } 
			  
			  
	
				
					 
					
            //$matches[] = array_filter($match);
           
			// } */
			 
				 
				
          
			 $sport_name[] = $match;
		   }
		   }
        return $sport_name;
    }
	
    
    public function get_week_match( $sport = '1', $league = '1',$week,$match_date)
    {
      
        $matches = array();
        $this->db->distinct();
        $this->db->select('a.*, a.id AS data_id');
        $this->db->from('match a');
        $this->db->join('season b', 'b.id = a.season_id', 'left');
        $this->db->where('b.sport_id', $sport);
        $this->db->where('b.league_id', $league);
        $this->db->where('a.match_week',$week);
        $this->db->where('a.match_date',$match_date); 
        //$this->db->where('a.match_start_date BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND NOW()');
        //$this->db->where("a.match_start_date ='".$startdate."' OR a.match_start_date ='".$enddate."'");
        $this->db->order_by('a.id', 'asc');
        $this->db->group_by('a.match_id');
        $query = $this->db->get();

        if($query->num_rows() != 0)
        {
            $teams = $this->get_teams();
			
            $seasons = $this->get_season();
               
            foreach( $query->result_array() as $row ) {
               
                $match = $row;
                $match['team1_name'] = $teams[$row['team1_id']];
                $match['team2_name'] = $teams[$row['team2_id']];
                $match['season_name'] = $seasons[$row['season_id']];

            //$matches[] = array_filter($match);
            $matches[] = $match;
            
        }
        }

        return $matches;
    }
    
   public function live_teams()
    {
		
		$getsteamtype = array();

        $this->db->select('*');   
        $this->db->from('channel a');
        $this->db->join('standings s', 'a.match_id = s.contestantId', 'left');
        $this->db->where('a.live', '1');
        $this->db->where('a.channel_type', 'team');
        
         $query = $this->db->get();
           if(count($query) > 0) {
                $getsteamtype = $query->result_array();
				
            }

        return $getsteamtype;
		
		
		}
		
		
		public function get_league_stat($sport,$league)
        {
        $league_stat = array();
        
         $this->db->select('s.id,s.rank,s.rankStatus,s.lastRank,s.contestantId,s.contestantName,s.contestantShortName,s.contestantClubName,s.contestantCode,s.points,s.matchesPlayed,s.matchesWon,s.matchesLost,s.matchesDrawn,s.goalsFor,s.goalsAgainst,s.goaldifference,s.last_update,c.match_id,c.channel_type,c.live, count(s.contestantId) as count_match');   
        $this->db->from('standings s');
		 //$this->db->from('channel c');
        $this->db->join('channel c', 's.contestantId = c.match_id','left');
        //$this->db->where('c.live', '0');
		$this->db->group_by(array("s.contestantId", "c.live", "c.channel_type"));
		$this->db->where('s.sport_id', $sport);
        $this->db->where('s.league_id', $league);
		//$this->db->group_by('c.station');
		 //$this->db->order_by('s.contestantId',"asc");
		 $this->db->order_by('s.rank',"asc");
         $query = $this->db->get();
           
        //$c=$query->num_rows();
		$c=1;
		$m=0;
		
		   if(count($query) > 0) {
                //$league_stat = $query->result_array();
				$live = $this->live_teams();
				foreach( $query->result_array() as $row ) {
					$channel = $row;
					//$channel['live_listeners'] =count($live[$row['channel_type']]);
                //$j=$channel['live'];
				//$k=$channel['channel_type'];
				if($channel['live']==1 && $channel['channel_type']=='team')
				{
					//$channel['jk']=1;
					if($channel['count_match']>=0)
					{
						//$channel['jkl']=2;
					//$c+=1;
						$channel['live_listeners'] =$channel['count_match'];
				}
				}
				else{
					$channel['live_listeners']=$m;
				}
			
				 $league_stat[] = $channel;
				 //$league_stat = $query->result_array();
				}
			
           /* if(count($query) > 0) {
                $league_stat = $query->result_array();
				$live = $this->live_teams();
                foreach($query->result_array() as $ress){
					$channel = $row;
					//$channel['live_listeners'] =count($live[$row['channel_type']]);
                 $channel['live_listeners'] =$c;
				 $league_stat[] = $channel;
					
					 //$channel = $ress;
					//echo "<pre>";
					//print_r($ress);
					 //echo $channell= count($ress['live']);
					 //$channel['live_listeners']= count($ress['live']);
					 //$league_stat[] = $channel;
					
					}
			 */	
            }

        return $league_stat;
    }
    /*public function get_league_stat()
    {
        $league_stat = array();
        
        $this->db->select('*');
        $this->db->from('standings');
        $query = $this->db->get();
           
           if(count($query) != 0) {
			   
			    //$live_teams = $this->live_teams();
			    //echo "<pre>";
			    //print_r($live_teams);
			    
			    foreach($query->result_array() as $res){
					
					
		        $channel = $res;
                $channel['live_listeners'] = $live_teams[$res['live']];
                $league_stat[] = $channel;
					 
					
					}
                $league_stat = $query->result_array();
				
            }
       return $league_stat;
    }*/

    
    function get_team_channel_list($sport,$league)
    {
     
       $teamchannels = array();
        $this->db->select('*, a.id AS data_id');
        $this->db->from('channel a');
        $this->db->join('match b', 'b.match_id = a.match_id', 'left');
        $this->db->join('season c', 'c.id = b.season_id', 'left');
        $this->db->where('c.sport_id', $sport);
        $this->db->where('c.league_id', $league);
        $this->db->order_by('a.id', 'asc');
        $query = $this->db->get();

        if($query->num_rows() != 0)
        {
            $teams = $this->get_teams();
            $seasons = $this->get_season();
            $users = $this->get_users();

            foreach( $query->result_array() as $row ) {
                $channel = $row;
                $channel['team1_name'] = $teams[$row['team1_id']];
                $channel['team2_name'] = $teams[$row['team2_id']];
                $channel['season_name'] = $seasons[$row['season_id']];
                $channel['broadcaster_name'] = $users[$row['broadcaster_id']];

                $teamchannels[] = $channel;
            }
        }

        return $teamchannels;
    
    
    }
     
    
    public function teamstat($contestantId)
    {
        $pundits = array();

        $this->db->select('*');
        $this->db->from('standings');
        $this->db->where('contestantId',$contestantId);
        
        $query = $this->db->get();
           if(count($query) > 0) {
                $getscore = $query->result_array();
               
                
				
            }

        return $getscore;
    }
    
    
    
    public function broadcasters()
    {
		
		$count=0;
		$getsteamtype = array();
        $this->db->select('*');   
        $this->db->from('channel');
        $this->db->where('live', '1');
        $this->db->where('channel_type', 'team');
        $query = $this->db->get();
        
		if(count($query) > 0) {
			$getsteamtype = $query->result_array();
			$count = $query->num_rows();
			
		}

        return $count;
		
		
	}
    
    
    
    public function channel_list( $sport = '1', $league = '1' )
    {
        $channels = array();

        $this->db->select('*, a.id AS data_id');
        $this->db->from('channel a');
        $this->db->join('match b', 'b.match_id = a.match_id', 'left');
        $this->db->join('season c', 'c.id = b.season_id', 'left');
        //$this->db->where('a.live', '1');
        $this->db->where('c.sport_id', $sport);
        $this->db->where('c.league_id', $league);
        $this->db->order_by('a.id', 'asc');
        $query = $this->db->get();

        if($query->num_rows() != 0)
        {
            $teams = $this->get_teams();
            $seasons = $this->get_season();
            $users = $this->get_users();

            foreach( $query->result_array() as $row ) {
                $channel = $row;
                $channel['team1_name'] = $teams[$row['team1_id']];
                $channel['team2_name'] = $teams[$row['team2_id']];
                $channel['season_name'] = $seasons[$row['season_id']];
                $channel['broadcaster_name'] = $users[$row['broadcaster_id']];

                $channels[] = $channel;
            }
        }

        return $channels;
    }
    
    
    function add_follow($data)
    {
        $insert = $this->db->insert('follow', $data);
        return $insert;
    }
    
     public function get_follow($follower_id, $following_id,$status)
    {
		
		 $active_follower = 1;
        
          $publish_date = date("Y-m-d-H-i-s");
        
        //$station = $station."-".$publish_date;
        $streamName = $station;
        
        // check if follower is already exist
        $this->db->select('*');
        $this->db->from('follow');
        $this->db->where('follower_id', $follower_id);
        $query = $this->db->get();

        if(count($query) > 0) {
            // same follower is already exist
            //$active_channel_id = $query[0]['id'];
             $active_follower = $query->result_array();
		}
            /* $this->db->select('*');
            $this->db->from('follow');
            $this->db->where('follower_id', $follower_id);
            $data_to_update = array(
                'follower_id' => $follower_id,
                'following_id' => $following_id,
                'status' =>$status
            );
            $this->db->update('follow', $data_to_update); */
         else {
            // follower is not exist, should create new
            $data_to_store = array(
                'follower_id' => $follower_id,
                'following_id' => $following_id,
                'status' =>$status,
                'follow_on_time' => $publish_date
                  
            );
            //$this->add_follow($data_to_store);
            //$this->db->insert('follow', $data_to_store);
$this->add($data_to_store);
            $this->db->select('*');
            $this->db->from('follow');
            $this->db->where('follower_id', $follower_id);
            
            $query = $this->db->get();

            if(count($query) > 0) {
                //$active_channel_id = $query[0]['id'];
                 $active_follower = $query->result_array();
            }
        }

        return $active_follower;
    }
    
    function add_channel($data)
			{
				$insert = $this->db->insert('follow_table', $data);
				return $insert;
			}
    
    /* public function active_channel($follow_id, $follower_id)
    {
	
  

		$start_time=date("Y-m-d h:i:sa");
        //$active_channel_id = 1;
        $this->db->select('*');
        $this->db->from('follow_table');
        $this->db->where('follower_id', $follow_id);
        $this->db->where('following_id', $follower_id);
        
        $query = $this->db->get()->result_array();
       // check if channel is already exist
        if(count($query) > 0) {
            // same channel is already exist
			foreach($query as $res)
			{
			 //$active_channel_id = $query[0]['id'];
			 $this->db->select('*');
            $this->db->from('follow_table');
            $this->db->where('id', $res['id']);
            $data_to_update = array(
                'live' => '1'
            );
				
			$this->db->update('follow_table', $data_to_update);
			 $this->db->select('*');
		 $this->db->from('follow_table');
		 $this->db->where('live','1');
		 $this->db->where('follower_id',$follow_id);
	     $follower_count1 = $this->db->get();	
        
         $f_num1 = $follower_count1 ->num_rows(); 
			
	    	$res['result']=0;
	    	$res['count']= $f_num1;
				if($res['live']=='1')
				{
				
			$this->db->select('*');
            $this->db->from('follow_table');
            $this->db->where('id', $res['id']);
            
			

			$data_to_update = array(
                'live' => '0'
            );
			
			$this->db->update('follow_table', $data_to_update);
			 $this->db->select('*');
		 $this->db->from('follow_table');
		 $this->db->where('live','1');
		 $this->db->where('follower_id',$follow_id);
	     $follower_count1 = $this->db->get();	
        
         $f_num2 = $follower_count1 ->num_rows(); 
            $res['result'] = 1;
            	$res['count']= $f_num2;
			}
			 
         
			}
            
			
        } else {
            // channel is not exist, should create new
            $data_to_store = array(
                'follower_id' => $follow_id,
                'following_id' => $follower_id,
				'start_time'=>$start_time
               
            );
            $this->add_channel($data_to_store);

            $this->db->select('*');
            $this->db->from('follow_table');
            $this->db->where('follower_id', $follow_id);
            $this->db->where('following_id', $follower_id);
			
            $query = $this->db->get()->result_array();

            if(count($query) > 0) {
				foreach($query as $result)
				{
              $res[]=$result;
				}
            }
        }
	
//$res[]=$active_channel_id;
        return $res;
    }*/
    
    
    public function active_channel($follow_id, $follower_id)
			{
				$start_time=date("Y-m-d h:i:sa");
				//$active_channel_id = 1;
				$this->db->select('*');
				$this->db->from('follow_table');
				$this->db->where('follower_id', $follow_id);
				$this->db->where('following_id', $follower_id);
				
				$query = $this->db->get()->result_array();
			  
			   // check if channel is already exist
				if(count($query) > 0) {
					// same channel is already exist
					foreach($query as $res)
					{
					 //$active_channel_id = $query[0]['id'];
					
						if($res['live']=='1')
						{
						
							$data_to_update = array(
								'live' => '0'
							);
					
							//$update = $this->db->update('follow_table', $data_to_update);
							
								 $res['result'] = 0;
								
							
					   //$res['count'] = $count;
					}
					else{
						   $data_to_update = array(
						'live' => '1'
					);
						
					
						$res['result']=1;
					}
					
					$this->db->where('follower_id',$follow_id);
					$this->db->where('following_id',$follower_id);
				$update = $this->db->update('follow_table', $data_to_update);
						   
							$this->db->select('*');
							$this->db->from('follow_table');
							$this->db->where('live','1');
							$this->db->where('follower_id',$follow_id);					
							$row = $this->db->get()->result_array();			
							
							$res['count'] = count($row); 	
					}
		}
		 else {
					// channel is not exist, should create new
					$data_to_store = array(
						'follower_id' => $follow_id,
						'following_id' => $follower_id,
						'start_time'=>$start_time
									);
					
					$this->add_channel($data_to_store);
					$this->db->select('*');
					$this->db->from('follow_table');
					$this->db->where(array('live'=>1,'follower_id'=>$follow_id));
					$q = $this->db->get()->result_array();
					//echo "<pre>"; print_r($q);
					
					$count = count($q);
			 
					$this->db->select('*');
					$this->db->from('follow_table');
					$this->db->where('follower_id', $follow_id);
					$this->db->where('following_id', $follower_id);
					
					$query = $this->db->get()->result_array();

					if(count($query) > 0) {
						foreach($query as $res)
						{
							//$res[]=$result;
						
						  
						  $res['result'] = 'follow';
						  $res['count'] = $count;
					}
					}
						
			
				}
			   
		//$res[]=$active_channel_id;
				return $res;
			}
    
      public function aboutus()
			{
				$tb_aboutus = array();

				$this->db->select('*');
				$this->db->from('tb_aboutus');
				$query = $this->db->get();
				   
				$tb_aboutus = $query->result_array();
						
				   
				return $tb_aboutus;
			}
			   
			 public function privacy_policy()
			{
				$privacy_policy = array();

				$this->db->select('*');
				$this->db->from('tb_privacy_policy');
				$query = $this->db->get();
				   
				$privacy_policy = $query->result_array();
						
				   
				return $privacy_policy;
			}
			 public function term_condition()
			{
				$tb_aboutus = array();

				$this->db->select('*');
				$this->db->from('tb_term_condition');
				$query = $this->db->get();
				   
				$term_condition = $query->result_array();
						
				   
				return $term_condition;
			}

     public function channel_data()
    {
		
        $pundits = array();

        $this->db->select('*');
        $this->db->from('channel c');
       //$this->db->join('channel c', 'c.match_id = m.match_id', 'right');
	  //  $this->db->where('c.live','1');
	
        $query = $this->db->get();
		
           if(count($query) > 0) {
			    $users = $this->get_users();
               $channels[] = $query->result_array();
                foreach($channels as $val){
			 
		
			
				}
		
            }

        
           return $channels;
       }
	 	
	 public function match_data($sport_id,$league_id,$match_start_date)
	 {
				$sport_name = array();
				
				$match_data = array();
				
				$this->db->distinct();
				$this->db->select('m.*');
				$this->db->from('match m');
				$this->db->join('season b', 'b.id = m.season_id', 'left');
				$this->db->join('channel c', 'c.match_id = m.match_id', 'right');
				$this->db->where('b.sport_id',$sport_id);
				$this->db->where('b.league_id',$league_id);
			 
				$this->db->where('c.live','1');
				$this->db->where('m.match_start_date',$match_start_date);
				
				$this->db->order_by('m.id', 'desc');
			
				$query = $this->db->get();
				$result = $query->result_array();

				   if(count($query) > 0) {
					 
					 $teams = $this->get_teams();
					 $seasons = $this->get_season();
					 $users = $this->get_users();
					 $channel_data = $this->channel_data();
				
					  foreach($channel_data as $value){
						
							 foreach($value as $abc)
							 {
							
							 $jkl[]=$abc;
						 }
					  }
					foreach( $query->result_array() as $row ) {
						
							$match = $row;
						$match['team1_name'] = $teams[$row['team1_id']];
						$match['team2_name'] = $teams[$row['team2_id']];
						$match['season_name'] = $seasons[$row['season_id']];
					  foreach($jkl as $res){
							  if ($row['match_id']==$res['match_id']) {
								 if ($res['live'] == '1'){
								  //$match['league'] =$res['sport_id'];
								
								  $match['channel'][] = $res;
								 }
							 }
				 } 
					  
					  
			 
					 $match_data[] = $match;
				   }
			}
				return $match_data;
       
    }
    
    public function team_broadcaster_count($sport_id,$league_id){
	    $this->db->select('*');
	    $this->db->from('channel');
	    $this->db->where(array('live'=>1,'channel_type'=>team,'sport_id'=>$sport_id,'league_id'=>$league_id));
	    $query = $this->db->get()->result_array();
	    
	    $count = count($query);
	    return $count;
	}
    
     public function matchdata($sport_id,$league_id,$match_start_date)
	 {
				$sport_name = array();
				
				$match_data = array();
				
				$this->db->distinct();
				$this->db->select('m.*');
				$this->db->from('match m');
				$this->db->join('season b', 'b.id = m.season_id', 'left');
				$this->db->join('channel c', 'c.match_id = m.match_id', 'right');
				$this->db->where('b.sport_id',$sport_id);
				$this->db->where('b.league_id',$league_id);
			 
				$this->db->where('c.live','1');
				$this->db->where('m.match_start_date',$match_start_date);
				
				$this->db->order_by('m.id', 'desc');
			
				$query = $this->db->get();
				$result = $query->result_array();

				   if(count($query) > 0) {
					 
					 $teams = $this->get_teams();
					 $seasons = $this->get_season();
					 $users = $this->get_users();
					 $channel_data = $this->channel_data();
				
					  foreach($channel_data as $value){
						
							 foreach($value as $abc)
							 {
							
							 $jkl[]=$abc;
						 }
					  }
					foreach( $query->result_array() as $row ) {
						
							$match = $row;
						$match['team1_name'] = $teams[$row['team1_id']];
						$match['team2_name'] = $teams[$row['team2_id']];
						$match['season_name'] = $seasons[$row['season_id']];
					  foreach($jkl as $res){
							  if ($row['match_id']==$res['match_id']) {
								 if ($res['live'] == '1'){
								  //$match['league'] =$res['sport_id'];
								
								  $match['channel'][] = $res;
								 }
							 }
				 } 
					  
					
			 
					 $match_data[] = $match;
				
				   }
			}
				return $match_data;
       
    }
    
    
    public function sort_by_order ($a, $b)
{
    return $a['timeMin'] - $b['timeMin'];
}
    
    public function get_rseult($match_id){
		$livedata  = array();
		
		$this->db->select('*');
		$this->db->from('match');
	    $this->db->where('match_id',$match_id);
	    
	    $query = $this->db->get();
	    
	
	   if(count($query) > 0) {
	
	     $missedPen = $this->missedPenFeed($match_id);
		 $card = $this->cardFeed($match_id);
		 $goal = $this->goalFeed($match_id);
		 $substitute = $this->substituteFeed($match_id);
			 
			 $data = array_merge($missedPen,$card,$goal,$substitute);

usort($data, array($this,'sort_by_order'));

 foreach( $query->result_array() as $row ) {
	 	$final['matchinfo'] = $row;
	if($row['st_lengthMin'] == 0){
				$final['matchinfo']['gamestatus'] = 'firsthalf';
		}
		else{
			$final['matchinfo']['gamestatus'] = 'secondhalf';
		}
	
			$final['feeds'] =$data;
		    $livedata = $final;
}
}


 return $livedata;
}
    
    	public function get_news() {
				
			//$neww = array();
			 $this->db->select('*');
			 $this->db->from('news');
			 $query =$this->db->get();
			 $res = $query->result_array();
			 
			 return $res;
			}
			
			
		public function follow_check($broadcaster_id,$user_id){	
           
            //Count followers
				 $this->db->select('*');
				 $this->db->from('follow_table');
				 $this->db->where('live','1');
				 $this->db->where('follower_id',$broadcaster_id);
				 $this->db->where('following_id',$user_id);
				 $follower_count = $this->db->get();	
		 	
		$f_num = $follower_count ->num_rows(); 

		 	
		 //Count followers
         
         $this->db->select('*');
		 $this->db->from('follow_table');
		 $this->db->where('live','1');
		 $this->db->where('follower_id',$broadcaster_id);
	     $follower_count1 = $this->db->get();	
        
         $f_num1 = $follower_count1 ->num_rows(); 
		
         if($f_num > 0) {
            
             // $follow_info = $query->result_array();	
            $this->db->select('*');
			$this->db->from('user');
			$this->db->where('id',$broadcaster_id);
			//$this->db->join('hash_tag','user.id = hash_tag.user_id AND user.id="'.$broadcaster_id.'"');			
			$query = $this->db->get();
           
              foreach( $query->result_array() as $row ) {
				
					$match = $row;
             $match['follow'] = 1;			
             $match['follower_count'] = $f_num1;			
      	
		 $match_data[] = $match;
	 }		              		
         }
		
		else{
			
			$this->db->select('*');
			$this->db->from('user');
			$this->db->where('id',$broadcaster_id);
		//	$this->db->join('hash_tag','user.id = hash_tag.user_id AND user.id="'.$broadcaster_id.'"');			
			$query = $this->db->get();
			
			     foreach( $query->result_array() as $row ) {
			$match = $row;
						$match['follow'] = 0;
						$match['follower_count'] = $f_num1;
	
                       $match_data[] = $match;	
		           }	
 
      }     
        return $match_data;
    }
    
    public function broadcaster_detail($match_id){
	
		$this->db->select('*');
		$this->db->from('channel');
		$this->db->where('match_id',$match_id);
		 $this->db->where('live','1');
		$query = $this->db->get()->result_array();
		return $query;
		
		
	}
	
	//get user list with broadcasting detail
	
	public function getchannellist()
	{
	    $this->db->select('*');
	    $this->db->from('channel');
	    $this->db->where('live',1);
	   
	    $query = $this->db->get()->result_array();
	    
	    return $query;
    }
    
    	public function getuserbroadcastlist()
	{
		$result = array();
		
	    $this->db->select('*');
	    $this->db->from('user');
	    $query = $this->db->get();
	    
	    $count = $query->num_rows();
	    
	    if ($count > 0){
			$list = $this->getchannellist();
			foreach($query->result_array() as $row){
				$userlist = $row;
					$userlist['live'] = 0;
				foreach($list as $res){
			//echo $row['first_name'];
			//echo $res['broadcaster_id'];
					if($row['id'] == $res['broadcaster_id']){
					$userlist['live'] = 1;
				}
				
			
			
		
	    

}

	 
	    $result[] = $userlist;
	    	}
}
return $result;
    }
    
    //get match data
    
    public function matchdatadetail()
	 {
				$sport_name = array();
				
				$match_data = array();
				
				$this->db->distinct();
				$this->db->select('m.*');
				$this->db->from('match m');
				$this->db->order_by('m.id', 'desc');
			
				$query = $this->db->get();
				$result = $query->result_array();

				   if(count($query) > 0) {
					 
					 $teams = $this->get_teams();
					foreach($channel_data as $value){
						
						
					  }
					foreach( $query->result_array() as $row ) {
						
							$match = $row;
						$match['team1_name'] = $teams[$row['team1_id']];
						$match['team2_name'] = $teams[$row['team2_id']];
						
					
					  
					
			 
					 $match_data[] = $match;
				
				   }
			}
				return $match_data;
       
    }
    
    //with user channel detail;
    
    public function getchannellisttest()
	{
		//$userlist = array();
	    $this->db->select('*');
	    $this->db->from('channel');
	    $this->db->where('live',1);
	    //$this->db->order_by('live','desc');
	    $query = $this->db->get();
	    
	    $count = count($query);
	    	    if ($count > 0){
				$list = $this->matchdatadetail();
			foreach($query->result_array() as $row){
				$userlist = $row;
				foreach($list as $res){
				
			//echo $row['first_name'];
			//echo $res['broadcaster_id'];
					if($row['match_id'] == $res['match_id']){
					
					$userlist['match'] = $res;
					$userlist['info'] = $row;
					//	$userlist['channel'] = array('detail',$res);
				
					
				}
				
			}

	 
	    $result[] = $userlist;
	    	}
}
return $result;
    }
	    
	    
	
    
    	public function getuserbroadcastlisttest()
	{
	
		$result = array();
		$empty = array();
		 
		$this->db->distinct();
	    $this->db->select('user.*');
	    $this->db->from('user');
	    
	    $query = $this->db->get();
	  
	    
	   $count = $query->num_rows();
	    
	    if ($count > 0){
			$list = $this->getchannellisttest();
			foreach($query->result_array() as $row){
				$userlist = $row;
					$userlist['live'] = 0;
					
				foreach($list as $res){
				
			//echo $row['first_name'];
			//echo $res['broadcaster_id'];
					if($row['id'] == $res['broadcaster_id']){
					$userlist['live'] = 1;
					//	$userlist['channel'] = array('detail',$res);
				
				$userlist['channel'] = array($res);
					
				}
				
			
			
		
	    

}

	 
	    $result[] = $userlist;
	    	}
}
return $result;
    }
    
    
    
    
    
    
     public function get_channel_info($broadcaster_id){
		
		$this->db->select('channel.* ,league.mark_image	');
		$this->db->from('channel');
		$this->db->join('league', 'league.id = channel.league_id', 'left');
		$this->db->where('broadcaster_id',$broadcaster_id);
		$this->db->where('live',1);
		$data = $this->db->get()->row_array();
		$match_info = array();
		$team_info = array();
		//$result_data = array();
		
		$result_data['channel']	= $data ; 
		
		if($data['channel_type'] =='match'){
			$result_data['match_info'] = $this->get_match_info($data['match_id']);
			
		}
		if($data['channel_type'] =='team'){
			$result_data['team_info'] = $this->get_team_info($data['match_id']);
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
    
    
    public function get_users_info(){
		
		$this->db->select('*');	
		$this->db->from('user');	
		$query = $this->db->get()->result_array();	
		$result = array();
		
		if(count($query) >0 ){
			
			foreach($query as $user){
				
				
			
				$channel = $this->get_channel_info($user['id']); 
				
				 	$user['live'] = 0; 	
				if(!empty($channel['channel'])){
					//echo '<pre>'; print_r($channel);  echo '</pre>';
					$user['live'] = 1; 			
					$user['channel_info'] = array($channel); 	
					
				}
				
				$result[] = $user; 
				
			}
				
		}
		//echo '<pre>'; print_r($result);  echo '</pre>';
		return $result;
		
	}
    
	public function get_channel_info_test($broadcaster_id){
		
		$this->db->select('channel.* ,league.mark_image	');
		$this->db->from('channel');
		$this->db->join('league', 'league.id = channel.league_id', 'left');
		$this->db->where('broadcaster_id',$broadcaster_id);
		$this->db->where('live',1);
		$data = $this->db->get()->row_array();
		$match_info = array();
		$team_info = array();
		//$result_data = array();
		
		$result_data	= $data ; 
		
		if($data['channel_type'] =='match'){
			$result_data['match_info'] = $this->get_match_info($data['match_id']);
			
		}
		if($data['channel_type'] =='team'){
			$result_data['team_info'] = $this->get_team_info($data['match_id']);
		}
		$final_data[] = $result_data;
		return $final_data;
		
		
	}
    public function get_match_info_test($match_id){
		
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
    
    public function get_team_info_test($team_id){
		
		$this->db->select('*');
		$this->db->from('team');
		$this->db->where('id',$team_id);		
		$data = $this->db->get()->row_array();
	
		return 	$data;
	}
    
    
    public function get_users_info_test(){
		
		$this->db->select('*');	
		$this->db->from('user');	
		$query = $this->db->get()->result_array();	
		$result = array();
		 
		if(count($query) >0 ){
			
			foreach($query as $user){
				
				
			
				$channel = $this->get_channel_info($user['id']); 
				//echo "<pre>";
				//print_r($channel);
				 	$user['live'] = 0; 		
				if(!empty($channel['channel'])){
					//echo '<pre>'; print_r($channel);  echo '</pre>';
					$user['live'] = 1; 		
					$user['channel_info'][] = $channel; 	
					
				}
				
				$result[] = $user; 
				
			}
				
		}
		//echo '<pre>'; print_r($result);  echo '</pre>';
		return $result;
		
	}
	
	 
  
}
