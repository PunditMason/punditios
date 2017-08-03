<?php
error_reporting(1);  

class Opta_model extends CI_Model {

   

			public function __construct()
			{
				$this->load->database();
			}

			 
		 
	 public function Premier_League(){
		 
			 $url = 'http://api.performfeeds.com/soccerdata/match/12jaj4hq7ga5i15emwfyfgor9t?tmcl=2c1fh40r28amu4rgz0q66ago9&_pgSz=400&_fmt=json&live=yes';//Live matches data
			 
	         $proxy = '54.194.200.74';
			 $proxyauth = '12jaj4hq7ga5i15emwfyfgor9t';

		     $ch = curl_init();
			 curl_setopt($ch, CURLOPT_URL, $url);
			 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			 curl_setopt($ch, CURLOPT_PROXYUSERPWD, $proxyauth);   // Use if proxy have username and password
			 $response = curl_exec($ch);
			 //var_export($response);
			 //print_r($response);
			  
			 $data = json_decode($response,true);
			 
			
			
			foreach ($data['match'] as $value) {
         
       $date = date('Y-m-d H:i:s');
             //echo "<br>".$i++."================================"."</br>";
		     //echo "<pre>";
            // print_r($value);
            
      //TournamentCalendar Details//
     
      $tournamentCalendar_id        = $value['matchInfo']['tournamentCalendar']['id'];
      $tournamentCalendar_startDate = $value['matchInfo']['tournamentCalendar']['startDate'];
      $tournamentCalendar_endDate   = $value['matchInfo']['tournamentCalendar']['endDate'];
      //$tournamentCalendar_name      = $value['matchInfo']['tournamentCalendar']['name'];
      
      $tournamentCalendar_name      = "Premier League 2016/2017";
      	 
		  //matchInfo Details//
       $matchInfo         = $value['matchInfo']['description'];
       $sport_id          = $value['matchInfo']['sport']['id'];
       $sport_name        = $value['matchInfo']['sport']['name'];
       $match_id          = $value['matchInfo']['id'];
       $match_start_date  = $value['matchInfo']['date'];
       $match_start_time  = $value['matchInfo']['time'];
       $match_week        = $value['matchInfo']['week'];
       $match_lastUpdated = $value['matchInfo']['lastUpdated'];
      
       //Ruleset Details//
      
       $ruleset_id = $value['matchInfo']['ruleset']['id'];
       $ruleset_name = $value['matchInfo']['ruleset']['name'];
       
      //competition Information//
     
      $competition_id   = $value['matchInfo']['competition']['id'];
      $competition_name = $value['matchInfo']['competition']['name'];
      $country_id       = $value['matchInfo']['competition']['country']['id'];
      $country_name     = $value['matchInfo']['competition']['country']['name'];
      
       
      
       //stage Details//
      $stage_id        = $value['matchInfo']['stage']['id'];
      $stage_startDate = $value['matchInfo']['stage']['startDate'];
      $stage_endDate   = $value['matchInfo']['stage']['endDate'];
      $stage_name      = $value['matchInfo']['stage']['name'];
      
       //contestant Details//
      
      $contestant_Team1_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team2_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][1]['id'];
      
      
      
      //team Details//
      $contestant_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_name = $value['matchInfo']['contestant'][0]['name'];
      $contestant_name = $value['matchInfo']['contestant'][1]['name'];
      $contestant_countryid = $value['matchInfo']['contestant'][0]['country']['id'];
      $contestant_countryid = $value['matchInfo']['contestant'][1]['country']['id'];
      $league_name =  $value['matchInfo']['tournamentCalendar']['name'];
     
      
       //match Details//
       
        $venue_id       = $value['matchInfo']['venue']['id'];
        $venue_name     = $value['matchInfo']['venue']['shortName'];
        $venue_longName = $value['matchInfo']['venue']['longName'];
        
         //liveData Details//
        $livedata_periodId   = $value['liveData']['matchDetails']['periodId'];
        $livedata_periodId   = $value['liveData']['matchDetails']['matchStatus'];
        $matchStatus         = $value['liveData']['matchDetails']['matchStatus'];
         
        //['matchInfo']['contestant'] loop start//
        
        
        
        
		
		//['liveData']['matchDetails']['period'] loop start//
           
         foreach($value['liveData']['matchDetails']['period'] as $period){
         
         //print_r($period);
             
        $matchDetails_id1        = $period['id'];
        $matchDetails_start      = $period['start'];
        $matchDetails_end        = $period['end'];
        $matchDetails_lengthMin  = $period['lengthMin'];
        $matchDetails_lengthSec  = $period['lengthSec'];
       }
         

       //liveData Details//
      
		  //"=============================================="//
		  $score_team1    = $value['liveData']['matchDetails']['scores']['total']['home'];
		  $score_team2    = $value['liveData']['matchDetails']['scores']['total']['away'];
		
		  $ht_home       =  $value['liveData']['matchDetails']['scores']['ht']['home'];
		  $ht_away      =   $value['liveData']['matchDetails']['scores']['ht']['away'];
		  $ft_home       =  $value['liveData']['matchDetails']['scores']['ft']['home'];
		  $ft_away       =  $value['liveData']['matchDetails']['scores']['ft']['away'];
		  $total_home    =  $value['liveData']['matchDetails']['scores']['total']['home'];
		  $total_away   =   $value['liveData']['matchDetails']['scores']['total']['away'];
		  $periodId       = $value['liveData']['matchDetails']['periodId'];
		  $matchStatus    = $value['liveData']['matchDetails']['matchStatus'];
		  $winner         = $value['liveData']['matchDetails']['winner'];
		  $matchLengthMin = $value['liveData']['matchDetails']['matchLengthMin'];
		  $matchLengthSec = $value['liveData']['matchDetails']['matchLengthSec'];
		  
		  
		  //=============================================matchupdate==============================================//
		 foreach($value['liveData']['goal'] as $goaldetails){
		  
		  echo "<pre>";
				  print_r($goaldetails);
				  
		 $nowupdate = date('Y-m-d H:i:s');
				 
		 $goal_contestantId      = $goaldetails['contestantId'];
		 $goal_periodId          = $goaldetails['periodId'];
		 $goal_timeMin           = $goaldetails['timeMin'];
		 $goal_lastUpdated       = $goaldetails['lastUpdated'];
		 $goal_type              = $goaldetails['type'];
		 $goal_playerId          = $goaldetails['scorerId'];
		 $goal_scorerName        = $goaldetails['scorerName'];
		 $goal_assistPlayerId    = $goaldetails['assistPlayerId'];
         $goalt_assistPlayerName = $goaldetails['assistPlayerName'];
         $goal_optaEventId       = $goaldetails['optaEventId'];
		
		
		//Goal Table
		
		
		 $data = array(
        'league_id'=>$tournamentCalendar_id,
        'match_id'=>$match_id,
        'match_start_date'=>$match_start_date,
        'team_id'=>$contestant_Team_id,
        'name'=>$contestant_team_name,
        'contestantId'=>$goal_contestantId,
        'periodId'=>$goal_periodId,
        'timeMin'=>$goal_timeMin,
		'lastUpdated'=>$goal_lastUpdated,
		'type'=>$goal_type,
		'scorerId'=>$goal_playerId,
		'scorerName'=>$goal_scorerName,
		'assistPlayerId'=>$goal_assistPlayerId,
		'assistPlayerName'=>$goalt_assistPlayerName,
		'optaEventId'=>$goal_optaEventId,
		'now_update'=>$nowupdate
         );
         
         $data1 = array(
             'league_id'=>$tournamentCalendar_id,
			 'match_id'=>$match_id,
			 'match_start_date'=>$match_start_date,
		     'team_id'=>$contestant_Team_id,
			 'name'=>$contestant_team_name,
		     'contestantId'=>$goal_contestantId,  
			 'periodId'=>$goal_periodId,
			 'timeMin'=>$goal_timeMin,
			 'lastUpdated'=>$goal_lastUpdated,
			 'type'=>$goal_type,
		     'scorerId'=>$goal_playerId,
		     'scorerName'=>$goal_scorerName,
			 'assistPlayerId'=>$goal_assistPlayerId,
			 'assistPlayerName'=>$goalt_assistPlayerName,
			 'optaEventId'=>$goal_optaEventId,
			 'now_update'=>$nowupdate
           );
		
		//Goal table
              
              
                $this->db->where('optaEventId',$goal_optaEventId);
			   $score = $this->db->get('goal');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$goal_optaEventId);
				 $this->db->update('goal',$data1);
				  echo "Updated Goal";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('goal',$data1);
				  echo "inserted Goal";
			   }
		
		}
         //liveData Card Details//
		  
		  foreach($value['liveData']['card'] as $carddetails){
		  
		
			  
			  print_r($carddetails);
			 $card_contestantId = $carddetails['contestantId'];
			 $card_periodId     = $carddetails['periodId'];
			 $card_timeMin      = $carddetails['timeMin'];
		     $card_lastUpdated  = $carddetails['lastUpdated'];
	         $card_type         = $carddetails['type'];
			 $card_playerId     = $carddetails['playerId'];
		     $card_playerName   = $carddetails['playerName'];
		     $card_optaEventId  = $carddetails['optaEventId'];
		     
		     
		     
		      $data = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
         );
         
         $data1 = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
           );

		     //Card table
              
              
                $this->db->where('optaEventId',$card_optaEventId);
			   $score = $this->db->get('card');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$card_optaEventId);
				 $this->db->update('card',$data1);
				  echo "Updated card";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('card',$data1);
				  echo "inserted card";
			   }
		    
		     
		     
		     
			}
			
			 //liveData substitute Details//
					
					foreach($value['liveData']['substitute'] as $substitutedetail){
						
						print_r($substitutedetail);
					//	echo "subst"."<pre>";
					$substitute_contestantId     = $substitutedetail['contestantId'];
					$substitute_periodId         = $substitutedetail['periodId'];
					$substitute_timeMin          = $substitutedetail['timeMin'];
					$substitute_lastUpdated      = $substitutedetail['lastUpdated'];
					$substitute_playerOnId       = $substitutedetail['playerOnId'];
					$substitute_playerOnName     = $substitutedetail['playerOnName'];
					$substitute_playerOffId      = $substitutedetail['playerOffId'];
				    $substitute_playerOffName    = $substitutedetail['playerOffName'];
						 
						$data = array(
					 'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					    );
					$data1 = array(
					  'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					   
					  );
					  
					  //substitute table
              
              
                $this->db->where('playerOnId',$substitute_playerOnId);
			   $score = $this->db->get('substitute');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('playerOnId',$substitute_playerOnId);
				 $this->db->update('substitute',$data);
				  echo "Updated substitute";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('substitute',$data);
				  echo "inserted substitute";
			   }
					 
						
					}
			
 
  	//=============================================substitute end==============================================//
		
            //match table
		 
		 $data = array(
        'match_id'=>$match_id,
        'league_id'=>$tournamentCalendar_id,
         'stage_id'=>$stage_id,
        'sport_id'=>$sport_id,
        'matchStatus'=>$matchStatus,
        'venue'=>$venue_longName,
        'match_start_date'=>$match_start_date,
		'match_start_time'=>$match_start_time,
		'periodId'=>$periodId, 
		'winner'=>$winner, 
		'matchLengthMin'=>$matchLengthMin,
		'matchLengthSec'=>$matchLengthSec,
		'team1_id'=>$contestant_Team1_id,  
		'team2_id'=>$contestant_Team2_id,
	    'team1_score'=>$score_team1,
		'team2_score'=>$score_team2,
		'time_now'=>$match_lastUpdated,
		'country_id'=>$country_id,
		'season_id'=>$tournamentCalendar_id,
	    'match_week'=>$match_week,
		'startDate'=>$tournamentCalendar_startDate,
		'endDate'=>$tournamentCalendar_endDate,
		'tournamentCalendar'=>$tournamentCalendar_name,
		'ruleset_id'=>$ruleset_id,
		'ruleset_name'=>$ruleset_name,
		'last_update'=>$date,
		'match_date'=>$match_start_date
         );
         
         
         
          //score table
         $data1 = array(
         'match_start_date' => $match_start_date,
         'team_id' => $contestant_Team_id,
         'ht_home' => $ht_home,
         'ht_away' => $ht_away,
         'ft_home' => $ft_home,
         'ft_away' => $ft_away,
         'total_home' => $total_home,
         'total_away' => $total_away
         );


            
      
             
              
              
                $this->db->where('match_id',$match_id);
			   $score = $this->db->get('scores');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				 $this->db->update('scores',$data1);
				  echo "UpdateD scores";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('scores',$data1);
				  echo "inserted scores";
			   }
			   
        
            //match table
		 	   $this->db->where('match_id',$match_id);
			   $q = $this->db->get('match');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				  $this->db->update('match',$data);
				  echo "UpdateD matchES";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('match',$data);
				  echo "UpdateD matchES";
			   }
	}
		 
	}
	
	
	 public function Chinese_Super_league(){
		 
			$url = 'https://api.performfeeds.com/soccerdata/match/12jaj4hq7ga5i15emwfyfgor9t?tmcl=bo69dtzfanugqk3w278gppxwp&_pgSz=400&live=yes&_fmt=json';//Live matches data
           $proxy = '54.194.200.74';
           $proxyauth = '12jaj4hq7ga5i15emwfyfgor9t';

		     $ch = curl_init();
			 curl_setopt($ch, CURLOPT_URL, $url);
			 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			 curl_setopt($ch, CURLOPT_PROXYUSERPWD, $proxyauth);   // Use if proxy have username and password
			 $response = curl_exec($ch);
			 //var_export($response);
			 //print_r($response);
			  
			 $data = json_decode($response,true);
			 
			
			
			foreach ($data['match'] as $value) {
         
       $date = date('Y-m-d H:i:s');
             //echo "<br>".$i++."================================"."</br>";
		     //echo "<pre>";
            // print_r($value);
            
     //TournamentCalendar Details//
     
      $tournamentCalendar_id        = $value['matchInfo']['tournamentCalendar']['id'];
      $tournamentCalendar_startDate = $value['matchInfo']['tournamentCalendar']['startDate'];
      $tournamentCalendar_endDate   = $value['matchInfo']['tournamentCalendar']['endDate'];
      //$tournamentCalendar_name      = $value['matchInfo']['tournamentCalendar']['name'];
      
       $tournamentCalendar_name      = "Chinese Super League 2016/2017";
        	 
		  //matchInfo Details//
       $matchInfo         = $value['matchInfo']['description'];
       $sport_id          = $value['matchInfo']['sport']['id'];
       $sport_name        = $value['matchInfo']['sport']['name'];
       $match_id          = $value['matchInfo']['id'];
       $match_start_date  = $value['matchInfo']['date'];
       $match_start_time  = $value['matchInfo']['time'];
       $match_week        = $value['matchInfo']['week'];
       $match_lastUpdated = $value['matchInfo']['lastUpdated'];
      
       //Ruleset Details//
      
       $ruleset_id = $value['matchInfo']['ruleset']['id'];
       $ruleset_name = $value['matchInfo']['ruleset']['name'];
       
      //competition Information//
     
      $competition_id   = $value['matchInfo']['competition']['id'];
      $competition_name = $value['matchInfo']['competition']['name'];
      $country_id       = $value['matchInfo']['competition']['country']['id'];
      $country_name     = $value['matchInfo']['competition']['country']['name'];
      
       
      
       //stage Details//
      $stage_id        = $value['matchInfo']['stage']['id'];
      $stage_startDate = $value['matchInfo']['stage']['startDate'];
      $stage_endDate   = $value['matchInfo']['stage']['endDate'];
      $stage_name      = $value['matchInfo']['stage']['name'];
      
       //contestant Details//
      
      $contestant_Team1_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team2_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][1]['id'];
      
      
      
      //team Details//
      $contestant_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_name = $value['matchInfo']['contestant'][0]['name'];
      $contestant_name = $value['matchInfo']['contestant'][1]['name'];
      $contestant_countryid = $value['matchInfo']['contestant'][0]['country']['id'];
      $contestant_countryid = $value['matchInfo']['contestant'][1]['country']['id'];
      $league_name =  $value['matchInfo']['tournamentCalendar']['name'];
     
      
       //match Details//
       
        $venue_id       = $value['matchInfo']['venue']['id'];
        $venue_name     = $value['matchInfo']['venue']['shortName'];
        $venue_longName = $value['matchInfo']['venue']['longName'];
        
         //liveData Details//
        $livedata_periodId   = $value['liveData']['matchDetails']['periodId'];
        $livedata_periodId   = $value['liveData']['matchDetails']['matchStatus'];
        $matchStatus         = $value['liveData']['matchDetails']['matchStatus'];
         
        //['matchInfo']['contestant'] loop start//
        
        
        
        
		
		//['liveData']['matchDetails']['period'] loop start//
           
         foreach($value['liveData']['matchDetails']['period'] as $period){
         
         //print_r($period);
             
        $matchDetails_id1        = $period['id'];
        $matchDetails_start      = $period['start'];
        $matchDetails_end        = $period['end'];
        $matchDetails_lengthMin  = $period['lengthMin'];
        $matchDetails_lengthSec  = $period['lengthSec'];
       }
         

       //liveData Details//
      
		  //"=============================================="//
		  $score_team1    = $value['liveData']['matchDetails']['scores']['total']['home'];
		  $score_team2    = $value['liveData']['matchDetails']['scores']['total']['away'];
		
		  $ht_home       =  $value['liveData']['matchDetails']['scores']['ht']['home'];
		  $ht_away      =   $value['liveData']['matchDetails']['scores']['ht']['away'];
		  $ft_home       =  $value['liveData']['matchDetails']['scores']['ft']['home'];
		  $ft_away       =  $value['liveData']['matchDetails']['scores']['ft']['away'];
		  $total_home    =  $value['liveData']['matchDetails']['scores']['total']['home'];
		  $total_away   =   $value['liveData']['matchDetails']['scores']['total']['away'];
		  $periodId       = $value['liveData']['matchDetails']['periodId'];
		  $matchStatus    = $value['liveData']['matchDetails']['matchStatus'];
		  $winner         = $value['liveData']['matchDetails']['winner'];
		  $matchLengthMin = $value['liveData']['matchDetails']['matchLengthMin'];
		  $matchLengthSec = $value['liveData']['matchDetails']['matchLengthSec'];
		  
		  
		  //=============================================matchupdate==============================================//
		 foreach($value['liveData']['goal'] as $goaldetails){
		  
		  echo "<pre>";
				  print_r($goaldetails);
				  
		 $nowupdate = date('Y-m-d H:i:s');
				 
		 $goal_contestantId      = $goaldetails['contestantId'];
		 $goal_periodId          = $goaldetails['periodId'];
		 $goal_timeMin           = $goaldetails['timeMin'];
		 $goal_lastUpdated       = $goaldetails['lastUpdated'];
		 $goal_type              = $goaldetails['type'];
		 $goal_playerId          = $goaldetails['scorerId'];
		 $goal_scorerName        = $goaldetails['scorerName'];
		 $goal_assistPlayerId    = $goaldetails['assistPlayerId'];
         $goalt_assistPlayerName = $goaldetails['assistPlayerName'];
         $goal_optaEventId       = $goaldetails['optaEventId'];
		
		
		//Goal Table
		
		
		 $data = array(
        'league_id'=>$tournamentCalendar_id,
        'match_id'=>$match_id,
        'match_start_date'=>$match_start_date,
        'team_id'=>$contestant_Team_id,
        'name'=>$contestant_team_name,
        'contestantId'=>$goal_contestantId,
        'periodId'=>$goal_periodId,
        'timeMin'=>$goal_timeMin,
		'lastUpdated'=>$goal_lastUpdated,
		'type'=>$goal_type,
		'scorerId'=>$goal_playerId,
		'scorerName'=>$goal_scorerName,
		'assistPlayerId'=>$goal_assistPlayerId,
		'assistPlayerName'=>$goalt_assistPlayerName,
		'optaEventId'=>$goal_optaEventId,
		'now_update'=>$nowupdate
         );
         
         $data1 = array(
             'league_id'=>$tournamentCalendar_id,
			 'match_id'=>$match_id,
			 'match_start_date'=>$match_start_date,
		     'team_id'=>$contestant_Team_id,
			 'name'=>$contestant_team_name,
		     'contestantId'=>$goal_contestantId,  
			 'periodId'=>$goal_periodId,
			 'timeMin'=>$goal_timeMin,
			 'lastUpdated'=>$goal_lastUpdated,
			 'type'=>$goal_type,
		     'scorerId'=>$goal_playerId,
		     'scorerName'=>$goal_scorerName,
			 'assistPlayerId'=>$goal_assistPlayerId,
			 'assistPlayerName'=>$goalt_assistPlayerName,
			 'optaEventId'=>$goal_optaEventId,
			 'now_update'=>$nowupdate
           );
		
		//Goal table
              
              
                $this->db->where('optaEventId',$goal_optaEventId);
			   $score = $this->db->get('goal');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$goal_optaEventId);
				 $this->db->update('goal',$data1);
				  echo "Updated Goal";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('goal',$data1);
				  echo "inserted Goal";
			   }
		
		}
         //liveData Card Details//
		  
		  foreach($value['liveData']['card'] as $carddetails){
		  
		
			  
			  print_r($carddetails);
			 $card_contestantId = $carddetails['contestantId'];
			 $card_periodId     = $carddetails['periodId'];
			 $card_timeMin      = $carddetails['timeMin'];
		     $card_lastUpdated  = $carddetails['lastUpdated'];
	         $card_type         = $carddetails['type'];
			 $card_playerId     = $carddetails['playerId'];
		     $card_playerName   = $carddetails['playerName'];
		     $card_optaEventId  = $carddetails['optaEventId'];
		     
		     
		     
		      $data = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId
         );
         
         $data1 = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId
           );

		     //Goal table
              
              /*
                $this->db->where('optaEventId',$goal_optaEventId);
			   $score = $this->db->get('card');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$goal_optaEventId);
				 $this->db->update('card',$data1);
				  echo "Updated card";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('card',$data1);
				  echo "inserted card";
			   }
		    */
		     
		     
		     
			}
			
			 //liveData substitute Details//
					
					foreach($value['liveData']['substitute'] as $substitutedetail){
						
						print_r($substitutedetail);
					//	echo "subst"."<pre>";
					$substitute_contestantId     = $substitutedetail['contestantId'];
					$substitute_periodId         = $substitutedetail['periodId'];
					$substitute_timeMin          = $substitutedetail['timeMin'];
					$substitute_lastUpdated      = $substitutedetail['lastUpdated'];
					$substitute_playerOnId       = $substitutedetail['playerOnId'];
					$substitute_playerOnName     = $substitutedetail['playerOnName'];
					$substitute_playerOffId      = $substitutedetail['playerOffId'];
				    $substitute_playerOffName    = $substitutedetail['playerOffName'];
						 
						$data = array(
					 'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					    );
					$data1 = array(
					  'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					   
					  );
					  
					  //substitute table
              
              
                 $this->db->where('playerOnId',$substitute_playerOnId);
			   $score = $this->db->get('substitute');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('playerOnId',$substitute_playerOnId);
				 $this->db->update('substitute',$data);
				  echo "Updated substitute";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('substitute',$data);
				  echo "inserted substitute";
			   }
					 
						
					}
			
 
  	//=============================================substitute end==============================================//
		
            //match table
		 
		 $data = array(
        'match_id'=>$match_id,
        'league_id'=>$tournamentCalendar_id,
         'stage_id'=>$stage_id,
        'sport_id'=>$sport_id,
        'matchStatus'=>$matchStatus,
        'venue'=>$venue_longName,
        'match_start_date'=>$match_start_date,
		'match_start_time'=>$match_start_time,
		'periodId'=>$periodId, 
		'winner'=>$winner, 
		'matchLengthMin'=>$matchLengthMin,
		'matchLengthSec'=>$matchLengthSec,
		'team1_id'=>$contestant_Team1_id,  
		'team2_id'=>$contestant_Team2_id,
	    'team1_score'=>$score_team1,
		'team2_score'=>$score_team2,
		'time_now'=>$match_lastUpdated,
		'country_id'=>$country_id,
		'season_id'=>$tournamentCalendar_id,
	    'match_week'=>$match_week,
		'startDate'=>$tournamentCalendar_startDate,
		'endDate'=>$tournamentCalendar_endDate,
		'tournamentCalendar'=>$tournamentCalendar_name,
		'ruleset_id'=>$ruleset_id,
		'ruleset_name'=>$ruleset_name,
		'last_update'=>$date,
		'match_date'=>$match_start_date

         );
         
         
         
          //score table
         $data1 = array(
         'match_start_date' => $match_start_date,
         'team_id' => $contestant_Team_id,
         'ht_home' => $ht_home,
         'ht_away' => $ht_away,
         'ft_home' => $ft_home,
         'ft_away' => $ft_away,
         'total_home' => $total_home,
         'total_away' => $total_away
      
         );


            
      
             
              
              
                $this->db->where('match_id',$match_id);
			   $score = $this->db->get('scores');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				 $this->db->update('scores',$data1);
				  echo "UpdateD scores";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('scores',$data1);
				  echo "inserted scores";
			   }
			   
        
            //match table
		 	   $this->db->where('match_id',$match_id);
			   $q = $this->db->get('match');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				  $this->db->update('match',$data);
				  echo "UpdateD matchES";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('match',$data);
				  echo "UpdateD matchES";
			   }
	}
		 
	}
	 public function Championship(){
		 
			$url = 'https://api.performfeeds.com/soccerdata/match/12jaj4hq7ga5i15emwfyfgor9t?tmcl=34t77emy3pvowf6x59hr6d2p5&_pgSz=400&live=yes&_fmt=json';//Live matches data
           $proxy = '54.194.200.74';
           $proxyauth = '12jaj4hq7ga5i15emwfyfgor9t';


		     $ch = curl_init();
			 curl_setopt($ch, CURLOPT_URL, $url);
			 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			 curl_setopt($ch, CURLOPT_PROXYUSERPWD, $proxyauth);   // Use if proxy have username and password
			 $response = curl_exec($ch);
			 //var_export($response);
			 //print_r($response);
			  
			 $data = json_decode($response,true);
			 
			
			
			foreach ($data['match'] as $value) {
         
       $date = date('Y-m-d H:i:s');
             //echo "<br>".$i++."================================"."</br>";
		     //echo "<pre>";
            // print_r($value);
            
     //TournamentCalendar Details//
     
      $tournamentCalendar_id        = $value['matchInfo']['tournamentCalendar']['id'];
      $tournamentCalendar_startDate = $value['matchInfo']['tournamentCalendar']['startDate'];
      $tournamentCalendar_endDate   = $value['matchInfo']['tournamentCalendar']['endDate'];
      //$tournamentCalendar_name      = $value['matchInfo']['tournamentCalendar']['name'];
      
       $tournamentCalendar_name      = "Championship 2016/2017";
        	 
		  //matchInfo Details//
       $matchInfo         = $value['matchInfo']['description'];
       $sport_id          = $value['matchInfo']['sport']['id'];
       $sport_name        = $value['matchInfo']['sport']['name'];
       $match_id          = $value['matchInfo']['id'];
       $match_start_date  = $value['matchInfo']['date'];
       $match_start_time  = $value['matchInfo']['time'];
       $match_week        = $value['matchInfo']['week'];
       $match_lastUpdated = $value['matchInfo']['lastUpdated'];
      
       //Ruleset Details//
      
       $ruleset_id = $value['matchInfo']['ruleset']['id'];
       $ruleset_name = $value['matchInfo']['ruleset']['name'];
       
      //competition Information//
     
      $competition_id   = $value['matchInfo']['competition']['id'];
      $competition_name = $value['matchInfo']['competition']['name'];
      $country_id       = $value['matchInfo']['competition']['country']['id'];
      $country_name     = $value['matchInfo']['competition']['country']['name'];
      
       
      
       //stage Details//
      $stage_id        = $value['matchInfo']['stage']['id'];
      $stage_startDate = $value['matchInfo']['stage']['startDate'];
      $stage_endDate   = $value['matchInfo']['stage']['endDate'];
      $stage_name      = $value['matchInfo']['stage']['name'];
      
       //contestant Details//
      
      $contestant_Team1_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team2_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][1]['id'];
      
      
      
      //team Details//
      $contestant_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_name = $value['matchInfo']['contestant'][0]['name'];
      $contestant_name = $value['matchInfo']['contestant'][1]['name'];
      $contestant_countryid = $value['matchInfo']['contestant'][0]['country']['id'];
      $contestant_countryid = $value['matchInfo']['contestant'][1]['country']['id'];
      $league_name =  $value['matchInfo']['tournamentCalendar']['name'];
     
      
       //match Details//
       
        $venue_id       = $value['matchInfo']['venue']['id'];
        $venue_name     = $value['matchInfo']['venue']['shortName'];
        $venue_longName = $value['matchInfo']['venue']['longName'];
        
         //liveData Details//
        $livedata_periodId   = $value['liveData']['matchDetails']['periodId'];
        $livedata_periodId   = $value['liveData']['matchDetails']['matchStatus'];
        $matchStatus         = $value['liveData']['matchDetails']['matchStatus'];
         
        //['matchInfo']['contestant'] loop start//
        
        
        
        
		
		//['liveData']['matchDetails']['period'] loop start//
           
         foreach($value['liveData']['matchDetails']['period'] as $period){
         
         //print_r($period);
             
        $matchDetails_id1        = $period['id'];
        $matchDetails_start      = $period['start'];
        $matchDetails_end        = $period['end'];
        $matchDetails_lengthMin  = $period['lengthMin'];
        $matchDetails_lengthSec  = $period['lengthSec'];
       }
         

       //liveData Details//
      
		  //"=============================================="//
		  $score_team1    = $value['liveData']['matchDetails']['scores']['total']['home'];
		  $score_team2    = $value['liveData']['matchDetails']['scores']['total']['away'];
		
		  $ht_home       =  $value['liveData']['matchDetails']['scores']['ht']['home'];
		  $ht_away      =   $value['liveData']['matchDetails']['scores']['ht']['away'];
		  $ft_home       =  $value['liveData']['matchDetails']['scores']['ft']['home'];
		  $ft_away       =  $value['liveData']['matchDetails']['scores']['ft']['away'];
		  $total_home    =  $value['liveData']['matchDetails']['scores']['total']['home'];
		  $total_away   =   $value['liveData']['matchDetails']['scores']['total']['away'];
		  $periodId       = $value['liveData']['matchDetails']['periodId'];
		  $matchStatus    = $value['liveData']['matchDetails']['matchStatus'];
		  $winner         = $value['liveData']['matchDetails']['winner'];
		  $matchLengthMin = $value['liveData']['matchDetails']['matchLengthMin'];
		  $matchLengthSec = $value['liveData']['matchDetails']['matchLengthSec'];
		  
		  
		  //=============================================matchupdate==============================================//
		 foreach($value['liveData']['goal'] as $goaldetails){
		  
		  echo "<pre>";
				  print_r($goaldetails);
				  
		 $nowupdate = date('Y-m-d H:i:s');
				 
		 $goal_contestantId      = $goaldetails['contestantId'];
		 $goal_periodId          = $goaldetails['periodId'];
		 $goal_timeMin           = $goaldetails['timeMin'];
		 $goal_lastUpdated       = $goaldetails['lastUpdated'];
		 $goal_type              = $goaldetails['type'];
		 $goal_playerId          = $goaldetails['scorerId'];
		 $goal_scorerName        = $goaldetails['scorerName'];
		 $goal_assistPlayerId    = $goaldetails['assistPlayerId'];
         $goalt_assistPlayerName = $goaldetails['assistPlayerName'];
         $goal_optaEventId       = $goaldetails['optaEventId'];
		
		
		//Goal Table
		
		
		 $data = array(
        'league_id'=>$tournamentCalendar_id,
        'match_id'=>$match_id,
        'match_start_date'=>$match_start_date,
        'team_id'=>$contestant_Team_id,
        'name'=>$contestant_team_name,
        'contestantId'=>$goal_contestantId,
        'periodId'=>$goal_periodId,
        'timeMin'=>$goal_timeMin,
		'lastUpdated'=>$goal_lastUpdated,
		'type'=>$goal_type,
		'scorerId'=>$goal_playerId,
		'scorerName'=>$goal_scorerName,
		'assistPlayerId'=>$goal_assistPlayerId,
		'assistPlayerName'=>$goalt_assistPlayerName,
		'optaEventId'=>$goal_optaEventId,
		'now_update'=>$nowupdate
         );
         
         $data1 = array(
             'league_id'=>$tournamentCalendar_id,
			 'match_id'=>$match_id,
			 'match_start_date'=>$match_start_date,
		     'team_id'=>$contestant_Team_id,
			 'name'=>$contestant_team_name,
		     'contestantId'=>$goal_contestantId,  
			 'periodId'=>$goal_periodId,
			 'timeMin'=>$goal_timeMin,
			 'lastUpdated'=>$goal_lastUpdated,
			 'type'=>$goal_type,
		     'scorerId'=>$goal_playerId,
		     'scorerName'=>$goal_scorerName,
			 'assistPlayerId'=>$goal_assistPlayerId,
			 'assistPlayerName'=>$goalt_assistPlayerName,
			 'optaEventId'=>$goal_optaEventId,
			 'now_update'=>$nowupdate
           );
		
		//Goal table
              
              
                $this->db->where('optaEventId',$goal_optaEventId);
			   $score = $this->db->get('goal');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$goal_optaEventId);
				 $this->db->update('goal',$data1);
				  echo "Updated Goal";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('goal',$data1);
				  echo "inserted Goal";
			   }
		
		}
         //liveData Card Details//
		  
		  foreach($value['liveData']['card'] as $carddetails){
		  
		
			  
			  print_r($carddetails);
			 $card_contestantId = $carddetails['contestantId'];
			 $card_periodId     = $carddetails['periodId'];
			 $card_timeMin      = $carddetails['timeMin'];
		     $card_lastUpdated  = $carddetails['lastUpdated'];
	         $card_type         = $carddetails['type'];
			 $card_playerId     = $carddetails['playerId'];
		     $card_playerName   = $carddetails['playerName'];
		     $card_optaEventId  = $carddetails['optaEventId'];
		     
		     
		     
		      $data = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId
         );
         
         $data1 = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId
           );

		     //Goal table
              
              
                $this->db->where('optaEventId',$card_optaEventId);
			   $score = $this->db->get('card');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$card_optaEventId);
				 $this->db->update('card',$data1);
				  echo "Updated card";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('card',$data1);
				  echo "inserted card";
			   }
		    
		     
		     
		     
			}
			
			 //liveData substitute Details//
					
					foreach($value['liveData']['substitute'] as $substitutedetail){
						
						print_r($substitutedetail);
					//	echo "subst"."<pre>";
					$substitute_contestantId     = $substitutedetail['contestantId'];
					$substitute_periodId         = $substitutedetail['periodId'];
					$substitute_timeMin          = $substitutedetail['timeMin'];
					$substitute_lastUpdated      = $substitutedetail['lastUpdated'];
					$substitute_playerOnId       = $substitutedetail['playerOnId'];
					$substitute_playerOnName     = $substitutedetail['playerOnName'];
					$substitute_playerOffId      = $substitutedetail['playerOffId'];
				    $substitute_playerOffName    = $substitutedetail['playerOffName'];
						 
						$data = array(
					 'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					    );
					$data1 = array(
					  'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					   
					  );
					  
					  //substitute table
              
              
                 $this->db->where('playerOnId',$substitute_playerOnId);
			   $score = $this->db->get('substitute');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('playerOnId',$substitute_playerOnId);
				 $this->db->update('substitute',$data);
				  echo "Updated substitute";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('substitute',$data);
				  echo "inserted substitute";
			   }
					 
						
					}
			
 
  	//=============================================substitute end==============================================//
		
            //match table
		 
		 $data = array(
        'match_id'=>$match_id,
        'league_id'=>$tournamentCalendar_id,
         'stage_id'=>$stage_id,
        'sport_id'=>$sport_id,
        'matchStatus'=>$matchStatus,
        'venue'=>$venue_longName,
        'match_start_date'=>$match_start_date,
		'match_start_time'=>$match_start_time,
		'periodId'=>$periodId, 
		'winner'=>$winner, 
		'matchLengthMin'=>$matchLengthMin,
		'matchLengthSec'=>$matchLengthSec,
		'team1_id'=>$contestant_Team1_id,  
		'team2_id'=>$contestant_Team2_id,
	    'team1_score'=>$score_team1,
		'team2_score'=>$score_team2,
		'time_now'=>$match_lastUpdated,
		'country_id'=>$country_id,
		'season_id'=>$tournamentCalendar_id,
	    'match_week'=>$match_week,
		'startDate'=>$tournamentCalendar_startDate,
		'endDate'=>$tournamentCalendar_endDate,
		'tournamentCalendar'=>$tournamentCalendar_name,
		'ruleset_id'=>$ruleset_id,
		'ruleset_name'=>$ruleset_name,
		'last_update'=>$date,
		'match_date'=>$match_start_date
         );
         
         
         
          //score table
         $data1 = array(
         'match_start_date' => $match_start_date,
         'team_id' => $contestant_Team_id,
         'ht_home' => $ht_home,
         'ht_away' => $ht_away,
         'ft_home' => $ft_home,
         'ft_away' => $ft_away,
         'total_home' => $total_home,
         'total_away' => $total_away,
         );


            
      
             
              
              
                $this->db->where('match_id',$match_id);
			   $score = $this->db->get('scores');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				 $this->db->update('scores',$data1);
				  echo "UpdateD scores";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('scores',$data1);
				  echo "inserted scores";
			   }
			   
        
            //match table
		 	   $this->db->where('match_id',$match_id);
			   $q = $this->db->get('match');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				  $this->db->update('match',$data);
				  echo "UpdateD matchES";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('match',$data);
				  echo "UpdateD matchES";
			   }
	}
		 
	}
	public function English_National_League(){
		 
			$url = 'https://api.performfeeds.com/soccerdata/match/12jaj4hq7ga5i15emwfyfgor9t?tmcl=drpfno13t2w4rtzwt6uev87vt&_pgSz=400&live=yes&_fmt=json';//Live matches data
 $proxy = '54.194.200.74';
 $proxyauth = '12jaj4hq7ga5i15emwfyfgor9t';


		     $ch = curl_init();
			 curl_setopt($ch, CURLOPT_URL, $url);
			 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			 curl_setopt($ch, CURLOPT_PROXYUSERPWD, $proxyauth);   // Use if proxy have username and password
			 $response = curl_exec($ch);
			 //var_export($response);
			 //print_r($response);
			  
			 $data = json_decode($response,true);
			 
			
			
			foreach ($data['match'] as $value) {
         
       $date = date('Y-m-d H:i:s');
             //echo "<br>".$i++."================================"."</br>";
		     //echo "<pre>";
            // print_r($value);
            
      //TournamentCalendar Details//
     
      $tournamentCalendar_id        = $value['matchInfo']['tournamentCalendar']['id'];
      $tournamentCalendar_startDate = $value['matchInfo']['tournamentCalendar']['startDate'];
      $tournamentCalendar_endDate   = $value['matchInfo']['tournamentCalendar']['endDate'];
      //$tournamentCalendar_name      = $value['matchInfo']['tournamentCalendar']['name'];
      
       $tournamentCalendar_name      = "National League 2016/2017";
         	 
		  //matchInfo Details//
       $matchInfo         = $value['matchInfo']['description'];
       $sport_id          = $value['matchInfo']['sport']['id'];
       $sport_name        = $value['matchInfo']['sport']['name'];
       $match_id          = $value['matchInfo']['id'];
       $match_start_date  = $value['matchInfo']['date'];
       $match_start_time  = $value['matchInfo']['time'];
       $match_week        = $value['matchInfo']['week'];
       $match_lastUpdated = $value['matchInfo']['lastUpdated'];
      
       //Ruleset Details//
      
       $ruleset_id = $value['matchInfo']['ruleset']['id'];
       $ruleset_name = $value['matchInfo']['ruleset']['name'];
       
      //competition Information//
     
      $competition_id   = $value['matchInfo']['competition']['id'];
      $competition_name = $value['matchInfo']['competition']['name'];
      $country_id       = $value['matchInfo']['competition']['country']['id'];
      $country_name     = $value['matchInfo']['competition']['country']['name'];
      
       
      
       //stage Details//
      $stage_id        = $value['matchInfo']['stage']['id'];
      $stage_startDate = $value['matchInfo']['stage']['startDate'];
      $stage_endDate   = $value['matchInfo']['stage']['endDate'];
      $stage_name      = $value['matchInfo']['stage']['name'];
      
       //contestant Details//
      
      $contestant_Team1_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team2_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][1]['id'];
      
      
      
      //team Details//
      $contestant_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_name = $value['matchInfo']['contestant'][0]['name'];
      $contestant_name = $value['matchInfo']['contestant'][1]['name'];
      $contestant_countryid = $value['matchInfo']['contestant'][0]['country']['id'];
      $contestant_countryid = $value['matchInfo']['contestant'][1]['country']['id'];
      $league_name =  $value['matchInfo']['tournamentCalendar']['name'];
     
      
       //match Details//
       
        $venue_id       = $value['matchInfo']['venue']['id'];
        $venue_name     = $value['matchInfo']['venue']['shortName'];
        $venue_longName = $value['matchInfo']['venue']['longName'];
        
         //liveData Details//
        $livedata_periodId   = $value['liveData']['matchDetails']['periodId'];
        $livedata_periodId   = $value['liveData']['matchDetails']['matchStatus'];
        $matchStatus         = $value['liveData']['matchDetails']['matchStatus'];
         
        //['matchInfo']['contestant'] loop start//
        
        
        
        
		
		//['liveData']['matchDetails']['period'] loop start//
           
         foreach($value['liveData']['matchDetails']['period'] as $period){
         
         //print_r($period);
             
        $matchDetails_id1        = $period['id'];
        $matchDetails_start      = $period['start'];
        $matchDetails_end        = $period['end'];
        $matchDetails_lengthMin  = $period['lengthMin'];
        $matchDetails_lengthSec  = $period['lengthSec'];
       }
         

       //liveData Details//
      
		  //"=============================================="//
		  $score_team1    = $value['liveData']['matchDetails']['scores']['total']['home'];
		  $score_team2    = $value['liveData']['matchDetails']['scores']['total']['away'];
		
		  $ht_home       =  $value['liveData']['matchDetails']['scores']['ht']['home'];
		  $ht_away      =   $value['liveData']['matchDetails']['scores']['ht']['away'];
		  $ft_home       =  $value['liveData']['matchDetails']['scores']['ft']['home'];
		  $ft_away       =  $value['liveData']['matchDetails']['scores']['ft']['away'];
		  $total_home    =  $value['liveData']['matchDetails']['scores']['total']['home'];
		  $total_away   =   $value['liveData']['matchDetails']['scores']['total']['away'];
		  $periodId       = $value['liveData']['matchDetails']['periodId'];
		  $matchStatus    = $value['liveData']['matchDetails']['matchStatus'];
		  $winner         = $value['liveData']['matchDetails']['winner'];
		  $matchLengthMin = $value['liveData']['matchDetails']['matchLengthMin'];
		  $matchLengthSec = $value['liveData']['matchDetails']['matchLengthSec'];
		  
		  
		  //=============================================matchupdate==============================================//
		 foreach($value['liveData']['goal'] as $goaldetails){
		  
		  echo "<pre>";
				  print_r($goaldetails);
				  
		 $nowupdate = date('Y-m-d H:i:s');
				 
		 $goal_contestantId      = $goaldetails['contestantId'];
		 $goal_periodId          = $goaldetails['periodId'];
		 $goal_timeMin           = $goaldetails['timeMin'];
		 $goal_lastUpdated       = $goaldetails['lastUpdated'];
		 $goal_type              = $goaldetails['type'];
		 $goal_playerId          = $goaldetails['scorerId'];
		 $goal_scorerName        = $goaldetails['scorerName'];
		 $goal_assistPlayerId    = $goaldetails['assistPlayerId'];
         $goalt_assistPlayerName = $goaldetails['assistPlayerName'];
         $goal_optaEventId       = $goaldetails['optaEventId'];
		
		
		//Goal Table
		
		
		 $data = array(
        'league_id'=>$tournamentCalendar_id,
        'match_id'=>$match_id,
        'match_start_date'=>$match_start_date,
        'team_id'=>$contestant_Team_id,
        'name'=>$contestant_team_name,
        'contestantId'=>$goal_contestantId,
        'periodId'=>$goal_periodId,
        'timeMin'=>$goal_timeMin,
		'lastUpdated'=>$goal_lastUpdated,
		'type'=>$goal_type,
		'scorerId'=>$goal_playerId,
		'scorerName'=>$goal_scorerName,
		'assistPlayerId'=>$goal_assistPlayerId,
		'assistPlayerName'=>$goalt_assistPlayerName,
		'optaEventId'=>$goal_optaEventId,
		'now_update'=>$nowupdate
         );
         
         $data1 = array(
             'league_id'=>$tournamentCalendar_id,
			 'match_id'=>$match_id,
			 'match_start_date'=>$match_start_date,
		     'team_id'=>$contestant_Team_id,
			 'name'=>$contestant_team_name,
		     'contestantId'=>$goal_contestantId,  
			 'periodId'=>$goal_periodId,
			 'timeMin'=>$goal_timeMin,
			 'lastUpdated'=>$goal_lastUpdated,
			 'type'=>$goal_type,
		     'scorerId'=>$goal_playerId,
		     'scorerName'=>$goal_scorerName,
			 'assistPlayerId'=>$goal_assistPlayerId,
			 'assistPlayerName'=>$goalt_assistPlayerName,
			 'optaEventId'=>$goal_optaEventId,
			 'now_update'=>$nowupdate
           );
		
		//Goal table
              
              
                $this->db->where('optaEventId',$goal_optaEventId);
			   $score = $this->db->get('goal');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$goal_optaEventId);
				 $this->db->update('goal',$data1);
				  echo "Updated Goal";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('goal',$data1);
				  echo "inserted Goal";
			   }
		
		}
         //liveData Card Details//
		  
		  foreach($value['liveData']['card'] as $carddetails){
		  
		
			  
			  print_r($carddetails);
			 $card_contestantId = $carddetails['contestantId'];
			 $card_periodId     = $carddetails['periodId'];
			 $card_timeMin      = $carddetails['timeMin'];
		     $card_lastUpdated  = $carddetails['lastUpdated'];
	         $card_type         = $carddetails['type'];
			 $card_playerId     = $carddetails['playerId'];
		     $card_playerName   = $carddetails['playerName'];
		     $card_optaEventId  = $carddetails['optaEventId'];
		     
		     
		     
		      $data = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
         );
         
         $data1 = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
           );

		     //Goal table
              
              
                $this->db->where('optaEventId',$card_optaEventId);
			   $score = $this->db->get('card');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$card_optaEventId);
				 $this->db->update('card',$data1);
				  echo "Updated card";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('card',$data1);
				  echo "inserted card";
			   }
		    
		     
		     
		     
			}
			
			 //liveData substitute Details//
					
					foreach($value['liveData']['substitute'] as $substitutedetail){
						
						print_r($substitutedetail);
					//	echo "subst"."<pre>";
					$substitute_contestantId     = $substitutedetail['contestantId'];
					$substitute_periodId         = $substitutedetail['periodId'];
					$substitute_timeMin          = $substitutedetail['timeMin'];
					$substitute_lastUpdated      = $substitutedetail['lastUpdated'];
					$substitute_playerOnId       = $substitutedetail['playerOnId'];
					$substitute_playerOnName     = $substitutedetail['playerOnName'];
					$substitute_playerOffId      = $substitutedetail['playerOffId'];
				    $substitute_playerOffName    = $substitutedetail['playerOffName'];
						 
						$data = array(
					 'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					    );
					$data1 = array(
					  'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					   
					  );
					  
					  //substitute table
              
              
                 $this->db->where('playerOnId',$substitute_playerOnId);
			   $score = $this->db->get('substitute');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('playerOnId',$substitute_playerOnId);
				 $this->db->update('substitute',$data);
				  echo "Updated substitute";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('substitute',$data);
				  echo "inserted substitute";
			   }
					 
						
					}
			
 
  	//=============================================substitute end==============================================//
		
            //match table
		 
		 $data = array(
        'match_id'=>$match_id,
        'league_id'=>$tournamentCalendar_id,
         'stage_id'=>$stage_id,
        'sport_id'=>$sport_id,
        'matchStatus'=>$matchStatus,
        'venue'=>$venue_longName,
        'match_start_date'=>$match_start_date,
		'match_start_time'=>$match_start_time,
		'periodId'=>$periodId, 
		'winner'=>$winner, 
		'matchLengthMin'=>$matchLengthMin,
		'matchLengthSec'=>$matchLengthSec,
		'team1_id'=>$contestant_Team1_id,  
		'team2_id'=>$contestant_Team2_id,
	    'team1_score'=>$score_team1,
		'team2_score'=>$score_team2,
		'time_now'=>$match_lastUpdated,
		'country_id'=>$country_id,
		'season_id'=>$tournamentCalendar_id,
	    'match_week'=>$match_week,
		'startDate'=>$tournamentCalendar_startDate,
		'endDate'=>$tournamentCalendar_endDate,
		'tournamentCalendar'=>$tournamentCalendar_name,
		'ruleset_id'=>$ruleset_id,
		'ruleset_name'=>$ruleset_name,
		'last_update'=>$date,
		'match_date'=>$match_start_date
         );
         
         
         
          //score table
         $data1 = array(
         'match_start_date' => $match_start_date,
         'team_id' => $contestant_Team_id,
         'ht_home' => $ht_home,
         'ht_away' => $ht_away,
         'ft_home' => $ft_home,
         'ft_away' => $ft_away,
         'total_home' => $total_home,
         'total_away' => $total_away
         );


            
      
             
              
              
                $this->db->where('match_id',$match_id);
			   $score = $this->db->get('scores');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				 $this->db->update('scores',$data1);
				  echo "UpdateD scores";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('scores',$data1);
				  echo "inserted scores";
			   }
			   
        
            //match table
		 	   $this->db->where('match_id',$match_id);
			   $q = $this->db->get('match');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				  $this->db->update('match',$data);
				  echo "UpdateD matchES";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('match',$data);
				  echo "UpdateD matchES";
			   }
	}
		 
	}
	
	public function League_One(){
		 
			$url = 'https://api.performfeeds.com/soccerdata/match/12jaj4hq7ga5i15emwfyfgor9t?tmcl=eqhqp1wywjdkc97ww89v7tb6x&_pgSz=400&live=yes&_fmt=json';//Live matches data
 $proxy = '54.194.200.74';
 $proxyauth = '12jaj4hq7ga5i15emwfyfgor9t';



		     $ch = curl_init();
			 curl_setopt($ch, CURLOPT_URL, $url);
			 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			 curl_setopt($ch, CURLOPT_PROXYUSERPWD, $proxyauth);   // Use if proxy have username and password
			 $response = curl_exec($ch);
			 //var_export($response);
			 //print_r($response);
			  
			 $data = json_decode($response,true);
			 
			
			
			foreach ($data['match'] as $value) {
         
       $date = date('Y-m-d H:i:s');
             //echo "<br>".$i++."================================"."</br>";
		     //echo "<pre>";
            // print_r($value);
            
      
       //TournamentCalendar Details//
     
      $tournamentCalendar_id        = $value['matchInfo']['tournamentCalendar']['id'];
      $tournamentCalendar_startDate = $value['matchInfo']['tournamentCalendar']['startDate'];
      $tournamentCalendar_endDate   = $value['matchInfo']['tournamentCalendar']['endDate'];
      $tournamentCalendar_name      = $value['matchInfo']['tournamentCalendar']['name'];
        	 
		  //matchInfo Details//
       $matchInfo         = $value['matchInfo']['description'];
       $sport_id          = $value['matchInfo']['sport']['id'];
       $sport_name        = $value['matchInfo']['sport']['name'];
       $match_id          = $value['matchInfo']['id'];
       $match_start_date  = $value['matchInfo']['date'];
       $match_start_time  = $value['matchInfo']['time'];
       $match_week        = $value['matchInfo']['week'];
       $match_lastUpdated = $value['matchInfo']['lastUpdated'];
      
       //Ruleset Details//
      
       $ruleset_id = $value['matchInfo']['ruleset']['id'];
       $ruleset_name = $value['matchInfo']['ruleset']['name'];
       
      //competition Information//
     
      $competition_id   = $value['matchInfo']['competition']['id'];
      $competition_name = $value['matchInfo']['competition']['name'];
      $country_id       = $value['matchInfo']['competition']['country']['id'];
      $country_name     = $value['matchInfo']['competition']['country']['name'];
      
       
      
       //stage Details//
      $stage_id        = $value['matchInfo']['stage']['id'];
      $stage_startDate = $value['matchInfo']['stage']['startDate'];
      $stage_endDate   = $value['matchInfo']['stage']['endDate'];
      $stage_name      = $value['matchInfo']['stage']['name'];
      
       //contestant Details//
      
      $contestant_Team1_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team2_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][1]['id'];
      
      
      
      //team Details//
      $contestant_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_name = $value['matchInfo']['contestant'][0]['name'];
      $contestant_name = $value['matchInfo']['contestant'][1]['name'];
      $contestant_countryid = $value['matchInfo']['contestant'][0]['country']['id'];
      $contestant_countryid = $value['matchInfo']['contestant'][1]['country']['id'];
      $league_name =  $value['matchInfo']['tournamentCalendar']['name'];
     
      
       //match Details//
       
        $venue_id       = $value['matchInfo']['venue']['id'];
        $venue_name     = $value['matchInfo']['venue']['shortName'];
        $venue_longName = $value['matchInfo']['venue']['longName'];
        
         //liveData Details//
        $livedata_periodId   = $value['liveData']['matchDetails']['periodId'];
        $livedata_periodId   = $value['liveData']['matchDetails']['matchStatus'];
        $matchStatus         = $value['liveData']['matchDetails']['matchStatus'];
         
        //['matchInfo']['contestant'] loop start//
        
        
        
        
		
		//['liveData']['matchDetails']['period'] loop start//
           
         foreach($value['liveData']['matchDetails']['period'] as $period){
         
         //print_r($period);
             
        $matchDetails_id1        = $period['id'];
        $matchDetails_start      = $period['start'];
        $matchDetails_end        = $period['end'];
        $matchDetails_lengthMin  = $period['lengthMin'];
        $matchDetails_lengthSec  = $period['lengthSec'];
       }
         

       //liveData Details//
      
		  //"=============================================="//
		  $score_team1    = $value['liveData']['matchDetails']['scores']['total']['home'];
		  $score_team2    = $value['liveData']['matchDetails']['scores']['total']['away'];
		
		  $ht_home       =  $value['liveData']['matchDetails']['scores']['ht']['home'];
		  $ht_away      =   $value['liveData']['matchDetails']['scores']['ht']['away'];
		  $ft_home       =  $value['liveData']['matchDetails']['scores']['ft']['home'];
		  $ft_away       =  $value['liveData']['matchDetails']['scores']['ft']['away'];
		  $total_home    =  $value['liveData']['matchDetails']['scores']['total']['home'];
		  $total_away   =   $value['liveData']['matchDetails']['scores']['total']['away'];
		  $periodId       = $value['liveData']['matchDetails']['periodId'];
		  $matchStatus    = $value['liveData']['matchDetails']['matchStatus'];
		  $winner         = $value['liveData']['matchDetails']['winner'];
		  $matchLengthMin = $value['liveData']['matchDetails']['matchLengthMin'];
		  $matchLengthSec = $value['liveData']['matchDetails']['matchLengthSec'];
		  
		  
		  //=============================================matchupdate==============================================//
		 foreach($value['liveData']['goal'] as $goaldetails){
		  
		  echo "<pre>";
				  print_r($goaldetails);
				  
		 $nowupdate = date('Y-m-d H:i:s');
				 
		 $goal_contestantId      = $goaldetails['contestantId'];
		 $goal_periodId          = $goaldetails['periodId'];
		 $goal_timeMin           = $goaldetails['timeMin'];
		 $goal_lastUpdated       = $goaldetails['lastUpdated'];
		 $goal_type              = $goaldetails['type'];
		 $goal_playerId          = $goaldetails['scorerId'];
		 $goal_scorerName        = $goaldetails['scorerName'];
		 $goal_assistPlayerId    = $goaldetails['assistPlayerId'];
         $goalt_assistPlayerName = $goaldetails['assistPlayerName'];
         $goal_optaEventId       = $goaldetails['optaEventId'];
		
		
		//Goal Table
		
		
		 $data = array(
        'league_id'=>$tournamentCalendar_id,
        'match_id'=>$match_id,
        'match_start_date'=>$match_start_date,
        'team_id'=>$contestant_Team_id,
        'name'=>$contestant_team_name,
        'contestantId'=>$goal_contestantId,
        'periodId'=>$goal_periodId,
        'timeMin'=>$goal_timeMin,
		'lastUpdated'=>$goal_lastUpdated,
		'type'=>$goal_type,
		'scorerId'=>$goal_playerId,
		'scorerName'=>$goal_scorerName,
		'assistPlayerId'=>$goal_assistPlayerId,
		'assistPlayerName'=>$goalt_assistPlayerName,
		'optaEventId'=>$goal_optaEventId,
		'now_update'=>$nowupdate
         );
         
         $data1 = array(
             'league_id'=>$tournamentCalendar_id,
			 'match_id'=>$match_id,
			 'match_start_date'=>$match_start_date,
		     'team_id'=>$contestant_Team_id,
			 'name'=>$contestant_team_name,
		     'contestantId'=>$goal_contestantId,  
			 'periodId'=>$goal_periodId,
			 'timeMin'=>$goal_timeMin,
			 'lastUpdated'=>$goal_lastUpdated,
			 'type'=>$goal_type,
		     'scorerId'=>$goal_playerId,
		     'scorerName'=>$goal_scorerName,
			 'assistPlayerId'=>$goal_assistPlayerId,
			 'assistPlayerName'=>$goalt_assistPlayerName,
			 'optaEventId'=>$goal_optaEventId,
			 'now_update'=>$nowupdate
           );
		
		//Goal table
              
              
                $this->db->where('optaEventId',$goal_optaEventId);
			   $score = $this->db->get('goal');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$goal_optaEventId);
				 $this->db->update('goal',$data1);
				  echo "Updated Goal";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('goal',$data1);
				  echo "inserted Goal";
			   }
		
		}
         //liveData Card Details//
		  
		  foreach($value['liveData']['card'] as $carddetails){
		  
		
			  
			  print_r($carddetails);
			 $card_contestantId = $carddetails['contestantId'];
			 $card_periodId     = $carddetails['periodId'];
			 $card_timeMin      = $carddetails['timeMin'];
		     $card_lastUpdated  = $carddetails['lastUpdated'];
	         $card_type         = $carddetails['type'];
			 $card_playerId     = $carddetails['playerId'];
		     $card_playerName   = $carddetails['playerName'];
		     $card_optaEventId  = $carddetails['optaEventId'];
		     
		     
		     
		      $data = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
         );
         
         $data1 = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
           );

		     //Goal table
              
              
                $this->db->where('optaEventId',$card_optaEventId);
			   $score = $this->db->get('card');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$card_optaEventId);
				 $this->db->update('card',$data1);
				  echo "Updated card";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('card',$data1);
				  echo "inserted card";
			   }
		    
		     
		     
		     
			}
			
			 //liveData substitute Details//
					
					foreach($value['liveData']['substitute'] as $substitutedetail){
						
						print_r($substitutedetail);
					//	echo "subst"."<pre>";
					$substitute_contestantId     = $substitutedetail['contestantId'];
					$substitute_periodId         = $substitutedetail['periodId'];
					$substitute_timeMin          = $substitutedetail['timeMin'];
					$substitute_lastUpdated      = $substitutedetail['lastUpdated'];
					$substitute_playerOnId       = $substitutedetail['playerOnId'];
					$substitute_playerOnName     = $substitutedetail['playerOnName'];
					$substitute_playerOffId      = $substitutedetail['playerOffId'];
				    $substitute_playerOffName    = $substitutedetail['playerOffName'];
						 
						$data = array(
					 'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					    );
					$data1 = array(
					  'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					   
					  );
					  
					  //substitute table
              
              
                 $this->db->where('playerOnId',$substitute_playerOnId);
			   $score = $this->db->get('substitute');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('playerOnId',$substitute_playerOnId);
				 $this->db->update('substitute',$data);
				  echo "Updated substitute";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('substitute',$data);
				  echo "inserted substitute";
			   }
					 
						
					}
			
 
  	//=============================================substitute end==============================================//
		
            //match table
		 
		 $data = array(
        'match_id'=>$match_id,
        'league_id'=>$tournamentCalendar_id,
         'stage_id'=>$stage_id,
        'sport_id'=>$sport_id,
        'matchStatus'=>$matchStatus,
        'venue'=>$venue_longName,
        'match_start_date'=>$match_start_date,
		'match_start_time'=>$match_start_time,
		'periodId'=>$periodId, 
		'winner'=>$winner, 
		'matchLengthMin'=>$matchLengthMin,
		'matchLengthSec'=>$matchLengthSec,
		'team1_id'=>$contestant_Team1_id,  
		'team2_id'=>$contestant_Team2_id,
	    'team1_score'=>$score_team1,
		'team2_score'=>$score_team2,
		'time_now'=>$match_lastUpdated,
		'country_id'=>$country_id,
		'season_id'=>$tournamentCalendar_id,
	    'match_week'=>$match_week,
		'startDate'=>$tournamentCalendar_startDate,
		'endDate'=>$tournamentCalendar_endDate,
		'tournamentCalendar'=>$tournamentCalendar_name,
		'ruleset_id'=>$ruleset_id,
		'ruleset_name'=>$ruleset_name,
		'last_update'=>$date,
		'match_date'=>$match_start_date
         );
         
         
         
          //score table
         $data1 = array(
         'match_start_date' => $match_start_date,
         'team_id' => $contestant_Team_id,
         'ht_home' => $ht_home,
         'ht_away' => $ht_away,
         'ft_home' => $ft_home,
         'ft_away' => $ft_away,
         'total_home' => $total_home,
         'total_away' => $total_away
         );


            
      
             
              
              
                $this->db->where('match_id',$match_id);
			   $score = $this->db->get('scores');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				 $this->db->update('scores',$data1);
				  echo "UpdateD scores";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('scores',$data1);
				  echo "inserted scores";
			   }
			   
        
            //match table
		 	   $this->db->where('match_id',$match_id);
			   $q = $this->db->get('match');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				  $this->db->update('match',$data);
				  echo "UpdateD matchES";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('match',$data);
				  echo "UpdateD matchES";
			   }
	}
		 
	}
	
	public function League_Two(){
		 
			$url = 'https://api.performfeeds.com/soccerdata/match/12jaj4hq7ga5i15emwfyfgor9t?tmcl=b5asig56ec3v0no2tdj0v6okp&_pgSz=400&live=yes&_fmt=json';//Live matches data
 $proxy = '54.194.200.74';
 $proxyauth = '12jaj4hq7ga5i15emwfyfgor9t';


		     $ch = curl_init();
			 curl_setopt($ch, CURLOPT_URL, $url);
			 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			 curl_setopt($ch, CURLOPT_PROXYUSERPWD, $proxyauth);   // Use if proxy have username and password
			 $response = curl_exec($ch);
			 //var_export($response);
			 //print_r($response);
			  
			 $data = json_decode($response,true);
			 
			
			
			foreach ($data['match'] as $value) {
         
       $date = date('Y-m-d H:i:s');
             //echo "<br>".$i++."================================"."</br>";
		     //echo "<pre>";
            // print_r($value);
            
      
       //TournamentCalendar Details//
     
      $tournamentCalendar_id        = $value['matchInfo']['tournamentCalendar']['id'];
      $tournamentCalendar_startDate = $value['matchInfo']['tournamentCalendar']['startDate'];
      $tournamentCalendar_endDate   = $value['matchInfo']['tournamentCalendar']['endDate'];
      $tournamentCalendar_name      = $value['matchInfo']['tournamentCalendar']['name'];
        	 
		  //matchInfo Details//
       $matchInfo         = $value['matchInfo']['description'];
       $sport_id          = $value['matchInfo']['sport']['id'];
       $sport_name        = $value['matchInfo']['sport']['name'];
       $match_id          = $value['matchInfo']['id'];
       $match_start_date  = $value['matchInfo']['date'];
       $match_start_time  = $value['matchInfo']['time'];
       $match_week        = $value['matchInfo']['week'];
       $match_lastUpdated = $value['matchInfo']['lastUpdated'];
      
       //Ruleset Details//
      
       $ruleset_id = $value['matchInfo']['ruleset']['id'];
       $ruleset_name = $value['matchInfo']['ruleset']['name'];
       
      //competition Information//
     
      $competition_id   = $value['matchInfo']['competition']['id'];
      $competition_name = $value['matchInfo']['competition']['name'];
      $country_id       = $value['matchInfo']['competition']['country']['id'];
      $country_name     = $value['matchInfo']['competition']['country']['name'];
      
       
      
       //stage Details//
      $stage_id        = $value['matchInfo']['stage']['id'];
      $stage_startDate = $value['matchInfo']['stage']['startDate'];
      $stage_endDate   = $value['matchInfo']['stage']['endDate'];
      $stage_name      = $value['matchInfo']['stage']['name'];
      
       //contestant Details//
      
      $contestant_Team1_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team2_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][1]['id'];
      
      
      
      //team Details//
      $contestant_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_name = $value['matchInfo']['contestant'][0]['name'];
      $contestant_name = $value['matchInfo']['contestant'][1]['name'];
      $contestant_countryid = $value['matchInfo']['contestant'][0]['country']['id'];
      $contestant_countryid = $value['matchInfo']['contestant'][1]['country']['id'];
      $league_name =  $value['matchInfo']['tournamentCalendar']['name'];
     
      
       //match Details//
       
        $venue_id       = $value['matchInfo']['venue']['id'];
        $venue_name     = $value['matchInfo']['venue']['shortName'];
        $venue_longName = $value['matchInfo']['venue']['longName'];
        
         //liveData Details//
        $livedata_periodId   = $value['liveData']['matchDetails']['periodId'];
        $livedata_periodId   = $value['liveData']['matchDetails']['matchStatus'];
        $matchStatus         = $value['liveData']['matchDetails']['matchStatus'];
         
        //['matchInfo']['contestant'] loop start//
        
        
        
        
		
		//['liveData']['matchDetails']['period'] loop start//
           
         foreach($value['liveData']['matchDetails']['period'] as $period){
         
         //print_r($period);
             
        $matchDetails_id1        = $period['id'];
        $matchDetails_start      = $period['start'];
        $matchDetails_end        = $period['end'];
        $matchDetails_lengthMin  = $period['lengthMin'];
        $matchDetails_lengthSec  = $period['lengthSec'];
       }
         

       //liveData Details//
      
		  //"=============================================="//
		  $score_team1    = $value['liveData']['matchDetails']['scores']['total']['home'];
		  $score_team2    = $value['liveData']['matchDetails']['scores']['total']['away'];
		
		  $ht_home       =  $value['liveData']['matchDetails']['scores']['ht']['home'];
		  $ht_away      =   $value['liveData']['matchDetails']['scores']['ht']['away'];
		  $ft_home       =  $value['liveData']['matchDetails']['scores']['ft']['home'];
		  $ft_away       =  $value['liveData']['matchDetails']['scores']['ft']['away'];
		  $total_home    =  $value['liveData']['matchDetails']['scores']['total']['home'];
		  $total_away   =   $value['liveData']['matchDetails']['scores']['total']['away'];
		  $periodId       = $value['liveData']['matchDetails']['periodId'];
		  $matchStatus    = $value['liveData']['matchDetails']['matchStatus'];
		  $winner         = $value['liveData']['matchDetails']['winner'];
		  $matchLengthMin = $value['liveData']['matchDetails']['matchLengthMin'];
		  $matchLengthSec = $value['liveData']['matchDetails']['matchLengthSec'];
		  
		  
		  //=============================================matchupdate==============================================//
		 foreach($value['liveData']['goal'] as $goaldetails){
		  
		  echo "<pre>";
				  print_r($goaldetails);
				  
		 $nowupdate = date('Y-m-d H:i:s');
				 
		 $goal_contestantId      = $goaldetails['contestantId'];
		 $goal_periodId          = $goaldetails['periodId'];
		 $goal_timeMin           = $goaldetails['timeMin'];
		 $goal_lastUpdated       = $goaldetails['lastUpdated'];
		 $goal_type              = $goaldetails['type'];
		 $goal_playerId          = $goaldetails['scorerId'];
		 $goal_scorerName        = $goaldetails['scorerName'];
		 $goal_assistPlayerId    = $goaldetails['assistPlayerId'];
         $goalt_assistPlayerName = $goaldetails['assistPlayerName'];
         $goal_optaEventId       = $goaldetails['optaEventId'];
		
		
		//Goal Table
		
		
		 $data = array(
        'league_id'=>$tournamentCalendar_id,
        'match_id'=>$match_id,
        'match_start_date'=>$match_start_date,
        'team_id'=>$contestant_Team_id,
        'name'=>$contestant_team_name,
        'contestantId'=>$goal_contestantId,
        'periodId'=>$goal_periodId,
        'timeMin'=>$goal_timeMin,
		'lastUpdated'=>$goal_lastUpdated,
		'type'=>$goal_type,
		'scorerId'=>$goal_playerId,
		'scorerName'=>$goal_scorerName,
		'assistPlayerId'=>$goal_assistPlayerId,
		'assistPlayerName'=>$goalt_assistPlayerName,
		'optaEventId'=>$goal_optaEventId,
		'now_update'=>$nowupdate
         );
         
         $data1 = array(
             'league_id'=>$tournamentCalendar_id,
			 'match_id'=>$match_id,
			 'match_start_date'=>$match_start_date,
		     'team_id'=>$contestant_Team_id,
			 'name'=>$contestant_team_name,
		     'contestantId'=>$goal_contestantId,  
			 'periodId'=>$goal_periodId,
			 'timeMin'=>$goal_timeMin,
			 'lastUpdated'=>$goal_lastUpdated,
			 'type'=>$goal_type,
		     'scorerId'=>$goal_playerId,
		     'scorerName'=>$goal_scorerName,
			 'assistPlayerId'=>$goal_assistPlayerId,
			 'assistPlayerName'=>$goalt_assistPlayerName,
			 'optaEventId'=>$goal_optaEventId,
			 'now_update'=>$nowupdate
           );
		
		//Goal table
              
              
                $this->db->where('optaEventId',$goal_optaEventId);
			   $score = $this->db->get('goal');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$goal_optaEventId);
				 $this->db->update('goal',$data1);
				  echo "Updated Goal";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('goal',$data1);
				  echo "inserted Goal";
			   }
		
		}
         //liveData Card Details//
		  
		  foreach($value['liveData']['card'] as $carddetails){
		  
		
			  
			  print_r($carddetails);
			 $card_contestantId = $carddetails['contestantId'];
			 $card_periodId     = $carddetails['periodId'];
			 $card_timeMin      = $carddetails['timeMin'];
		     $card_lastUpdated  = $carddetails['lastUpdated'];
	         $card_type         = $carddetails['type'];
			 $card_playerId     = $carddetails['playerId'];
		     $card_playerName   = $carddetails['playerName'];
		     $card_optaEventId  = $carddetails['optaEventId'];
		     
		     
		     
		      $data = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
         );
         
         $data1 = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
           );

		     //Goal table
              
              
                $this->db->where('optaEventId',$card_optaEventId);
			   $score = $this->db->get('card');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$card_optaEventId);
				 $this->db->update('card',$data1);
				  echo "Updated card";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('card',$data1);
				  echo "inserted card";
			   }
		    
		     
		     
		     
			}
			
			 //liveData substitute Details//
					
					foreach($value['liveData']['substitute'] as $substitutedetail){
						
						print_r($substitutedetail);
					//	echo "subst"."<pre>";
					$substitute_contestantId     = $substitutedetail['contestantId'];
					$substitute_periodId         = $substitutedetail['periodId'];
					$substitute_timeMin          = $substitutedetail['timeMin'];
					$substitute_lastUpdated      = $substitutedetail['lastUpdated'];
					$substitute_playerOnId       = $substitutedetail['playerOnId'];
					$substitute_playerOnName     = $substitutedetail['playerOnName'];
					$substitute_playerOffId      = $substitutedetail['playerOffId'];
				    $substitute_playerOffName    = $substitutedetail['playerOffName'];
						 
						$data = array(
					 'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					    );
					$data1 = array(
					  'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					   
					  );
					  
					  //substitute table
              
              
                 $this->db->where('playerOnId',$substitute_playerOnId);
			   $score = $this->db->get('substitute');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('playerOnId',$substitute_playerOnId);
				 $this->db->update('substitute',$data);
				  echo "Updated substitute";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('substitute',$data);
				  echo "inserted substitute";
			   }
					 
						
					}
			
 
  	//=============================================substitute end==============================================//
		
            //match table
		 
		 $data = array(
        'match_id'=>$match_id,
        'league_id'=>$tournamentCalendar_id,
         'stage_id'=>$stage_id,
        'sport_id'=>$sport_id,
        'matchStatus'=>$matchStatus,
        'venue'=>$venue_longName,
        'match_start_date'=>$match_start_date,
		'match_start_time'=>$match_start_time,
		'periodId'=>$periodId, 
		'winner'=>$winner, 
		'matchLengthMin'=>$matchLengthMin,
		'matchLengthSec'=>$matchLengthSec,
		'team1_id'=>$contestant_Team1_id,  
		'team2_id'=>$contestant_Team2_id,
	    'team1_score'=>$score_team1,
		'team2_score'=>$score_team2,
		'time_now'=>$match_lastUpdated,
		'country_id'=>$country_id,
		'season_id'=>$tournamentCalendar_id,
	    'match_week'=>$match_week,
		'startDate'=>$tournamentCalendar_startDate,
		'endDate'=>$tournamentCalendar_endDate,
		'tournamentCalendar'=>$tournamentCalendar_name,
		'ruleset_id'=>$ruleset_id,
		'ruleset_name'=>$ruleset_name,
		'last_update'=>$date,
		'match_date'=>$match_start_date
         );
         
         
         
          //score table
         $data1 = array(
         'match_start_date' => $match_start_date,
         'team_id' => $contestant_Team_id,
         'ht_home' => $ht_home,
         'ht_away' => $ht_away,
         'ft_home' => $ft_home,
         'ft_away' => $ft_away,
         'total_home' => $total_home,
         'total_away' => $total_away
         );


            
      
             
              
              
                $this->db->where('match_id',$match_id);
			   $score = $this->db->get('scores');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				 $this->db->update('scores',$data1);
				  echo "UpdateD scores";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('scores',$data1);
				  echo "inserted scores";
			   }
			   
        
            //match table
		 	   $this->db->where('match_id',$match_id);
			   $q = $this->db->get('match');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				  $this->db->update('match',$data);
				  echo "UpdateD matchES";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('match',$data);
				  echo "UpdateD matchES";
			   }
	}
		 
	}
	
	public function English_National_north(){
		 
			$url ='http://api.performfeeds.com/soccerdata/match/12jaj4hq7ga5i15emwfyfgor9t?tmcl=4v2o7dakq0b36sr9j9lqf49nt&stg=2bkektmxztq9q4jpv3w8oxdn3&stg&live=yes&&_fmt=json';

 $proxyauth = '12jaj4hq7ga5i15emwfyfgor9t';
  $proxy = '54.194.200.74';


		     $ch = curl_init();
			 curl_setopt($ch, CURLOPT_URL, $url);
			 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			 curl_setopt($ch, CURLOPT_PROXYUSERPWD, $proxyauth);   // Use if proxy have username and password
			 $response = curl_exec($ch);
			 //var_export($response);
			 //print_r($response);
			  
			 $data = json_decode($response,true);
			 
			
			
			foreach ($data['match'] as $value) {
         
       $date = date('Y-m-d H:i:s');
             //echo "<br>".$i++."================================"."</br>";
		     //echo "<pre>";
            // print_r($value);
            
        //TournamentCalendar Details//
       
       $north="north";
      echo $tournamentCalendar_id  = $north.$value['matchInfo']['tournamentCalendar']['id'];
      $tournamentCalendar_startDate = $value['matchInfo']['tournamentCalendar']['startDate'];
      $tournamentCalendar_endDate   = $value['matchInfo']['tournamentCalendar']['endDate'];
      $tournamentCalendar_name      = $value['matchInfo']['tournamentCalendar']['name'];
       
         $tournamentCalendar_name      = "National League North 2016/2017";
        	 
		  //matchInfo Details//
       $matchInfo         = $value['matchInfo']['description'];
       $sport_id          = $value['matchInfo']['sport']['id'];
       $sport_name        = $value['matchInfo']['sport']['name'];
       $match_id          = $value['matchInfo']['id'];
       $match_start_date  = $value['matchInfo']['date'];
       $match_start_time  = $value['matchInfo']['time'];
       $match_week        = $value['matchInfo']['week'];
       $match_lastUpdated = $value['matchInfo']['lastUpdated'];
      
       //Ruleset Details//
      
       $ruleset_id = $value['matchInfo']['ruleset']['id'];
       $ruleset_name = $value['matchInfo']['ruleset']['name'];
       
      //competition Information//
     
      $competition_id   = $value['matchInfo']['competition']['id'];
      $competition_name = $value['matchInfo']['competition']['name'];
      $country_id       = $value['matchInfo']['competition']['country']['id'];
      $country_name     = $value['matchInfo']['competition']['country']['name'];
      
       
      
       //stage Details//
      $stage_id        = $value['matchInfo']['stage']['id'];
      $stage_startDate = $value['matchInfo']['stage']['startDate'];
      $stage_endDate   = $value['matchInfo']['stage']['endDate'];
      $stage_name      = $value['matchInfo']['stage']['name'];
      
       //contestant Details//
      
      $contestant_Team1_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team2_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][1]['id'];
      
      
      
      //team Details//
      $contestant_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_name = $value['matchInfo']['contestant'][0]['name'];
      $contestant_name = $value['matchInfo']['contestant'][1]['name'];
      $contestant_countryid = $value['matchInfo']['contestant'][0]['country']['id'];
      $contestant_countryid = $value['matchInfo']['contestant'][1]['country']['id'];
      $league_name =  $value['matchInfo']['tournamentCalendar']['name'];
     
      
       //match Details//
       
        $venue_id       = $value['matchInfo']['venue']['id'];
        $venue_name     = $value['matchInfo']['venue']['shortName'];
        $venue_longName = $value['matchInfo']['venue']['longName'];
        
         //liveData Details//
        $livedata_periodId   = $value['liveData']['matchDetails']['periodId'];
        $livedata_periodId   = $value['liveData']['matchDetails']['matchStatus'];
        $matchStatus         = $value['liveData']['matchDetails']['matchStatus'];
         
        //['matchInfo']['contestant'] loop start//
        
        
        
        
		
		//['liveData']['matchDetails']['period'] loop start//
           
         foreach($value['liveData']['matchDetails']['period'] as $period){
         
         //print_r($period);
             
        $matchDetails_id1        = $period['id'];
        $matchDetails_start      = $period['start'];
        $matchDetails_end        = $period['end'];
        $matchDetails_lengthMin  = $period['lengthMin'];
        $matchDetails_lengthSec  = $period['lengthSec'];
       }
         

       //liveData Details//
      
		  //"=============================================="//
		  $score_team1    = $value['liveData']['matchDetails']['scores']['total']['home'];
		  $score_team2    = $value['liveData']['matchDetails']['scores']['total']['away'];
		
		  $ht_home       =  $value['liveData']['matchDetails']['scores']['ht']['home'];
		  $ht_away      =   $value['liveData']['matchDetails']['scores']['ht']['away'];
		  $ft_home       =  $value['liveData']['matchDetails']['scores']['ft']['home'];
		  $ft_away       =  $value['liveData']['matchDetails']['scores']['ft']['away'];
		  $total_home    =  $value['liveData']['matchDetails']['scores']['total']['home'];
		  $total_away   =   $value['liveData']['matchDetails']['scores']['total']['away'];
		  $periodId       = $value['liveData']['matchDetails']['periodId'];
		  $matchStatus    = $value['liveData']['matchDetails']['matchStatus'];
		  $winner         = $value['liveData']['matchDetails']['winner'];
		  $matchLengthMin = $value['liveData']['matchDetails']['matchLengthMin'];
		  $matchLengthSec = $value['liveData']['matchDetails']['matchLengthSec'];
		  
		  
		  //=============================================matchupdate==============================================//
		 foreach($value['liveData']['goal'] as $goaldetails){
		  
		  echo "<pre>";
				  print_r($goaldetails);
				  
		 $nowupdate = date('Y-m-d H:i:s');
				 
		 $goal_contestantId      = $goaldetails['contestantId'];
		 $goal_periodId          = $goaldetails['periodId'];
		 $goal_timeMin           = $goaldetails['timeMin'];
		 $goal_lastUpdated       = $goaldetails['lastUpdated'];
		 $goal_type              = $goaldetails['type'];
		 $goal_playerId          = $goaldetails['scorerId'];
		 $goal_scorerName        = $goaldetails['scorerName'];
		 $goal_assistPlayerId    = $goaldetails['assistPlayerId'];
         $goalt_assistPlayerName = $goaldetails['assistPlayerName'];
         $goal_optaEventId       = $goaldetails['optaEventId'];
		
		
		//Goal Table
		
		
		 $data = array(
        'league_id'=>$tournamentCalendar_id,
        'match_id'=>$match_id,
        'match_start_date'=>$match_start_date,
        'team_id'=>$contestant_Team_id,
        'name'=>$contestant_team_name,
        'contestantId'=>$goal_contestantId,
        'periodId'=>$goal_periodId,
        'timeMin'=>$goal_timeMin,
		'lastUpdated'=>$goal_lastUpdated,
		'type'=>$goal_type,
		'scorerId'=>$goal_playerId,
		'scorerName'=>$goal_scorerName,
		'assistPlayerId'=>$goal_assistPlayerId,
		'assistPlayerName'=>$goalt_assistPlayerName,
		'optaEventId'=>$goal_optaEventId,
		'now_update'=>$nowupdate
         );
         
         $data1 = array(
             'league_id'=>$tournamentCalendar_id,
			 'match_id'=>$match_id,
			 'match_start_date'=>$match_start_date,
		     'team_id'=>$contestant_Team_id,
			 'name'=>$contestant_team_name,
		     'contestantId'=>$goal_contestantId,  
			 'periodId'=>$goal_periodId,
			 'timeMin'=>$goal_timeMin,
			 'lastUpdated'=>$goal_lastUpdated,
			 'type'=>$goal_type,
		     'scorerId'=>$goal_playerId,
		     'scorerName'=>$goal_scorerName,
			 'assistPlayerId'=>$goal_assistPlayerId,
			 'assistPlayerName'=>$goalt_assistPlayerName,
			 'optaEventId'=>$goal_optaEventId,
			 'now_update'=>$nowupdate
           );
		
		//Goal table
              
              
                $this->db->where('optaEventId',$goal_optaEventId);
			   $score = $this->db->get('goal');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$goal_optaEventId);
				 $this->db->update('goal',$data1);
				  echo "Updated Goal";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('goal',$data1);
				  echo "inserted Goal";
			   }
		
		}
         //liveData Card Details//
		  
		  foreach($value['liveData']['card'] as $carddetails){
		  
		
			  
			  print_r($carddetails);
			 $card_contestantId = $carddetails['contestantId'];
			 $card_periodId     = $carddetails['periodId'];
			 $card_timeMin      = $carddetails['timeMin'];
		     $card_lastUpdated  = $carddetails['lastUpdated'];
	         $card_type         = $carddetails['type'];
			 $card_playerId     = $carddetails['playerId'];
		     $card_playerName   = $carddetails['playerName'];
		     $card_optaEventId  = $carddetails['optaEventId'];
		     
		     
		     
		      $data = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
         );
         
         $data1 = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
           );

		     //Goal table
              
              
                $this->db->where('optaEventId',$card_optaEventId);
			   $score = $this->db->get('card');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$card_optaEventId);
				 $this->db->update('card',$data1);
				  echo "Updated card";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('card',$data1);
				  echo "inserted card";
			   }
		    
		     
		     
		     
			}
			
			 //liveData substitute Details//
					
					foreach($value['liveData']['substitute'] as $substitutedetail){
						
						print_r($substitutedetail);
					//	echo "subst"."<pre>";
					$substitute_contestantId     = $substitutedetail['contestantId'];
					$substitute_periodId         = $substitutedetail['periodId'];
					$substitute_timeMin          = $substitutedetail['timeMin'];
					$substitute_lastUpdated      = $substitutedetail['lastUpdated'];
					$substitute_playerOnId       = $substitutedetail['playerOnId'];
					$substitute_playerOnName     = $substitutedetail['playerOnName'];
					$substitute_playerOffId      = $substitutedetail['playerOffId'];
				    $substitute_playerOffName    = $substitutedetail['playerOffName'];
						 
						$data = array(
					 'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					    );
					$data1 = array(
					  'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					   
					  );
					  
					  //substitute table
              
              
                 $this->db->where('playerOnId',$substitute_playerOnId);
			   $score = $this->db->get('substitute');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('playerOnId',$substitute_playerOnId);
				 $this->db->update('substitute',$data);
				  echo "Updated substitute";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('substitute',$data);
				  echo "inserted substitute";
			   }
					 
						
					}
			
 
  	//=============================================substitute end==============================================//
		
            //match table
		 
		 $data = array(
        'match_id'=>$match_id,
        'league_id'=>$tournamentCalendar_id,
         'stage_id'=>$stage_id,
        'sport_id'=>$sport_id,
        'matchStatus'=>$matchStatus,
        'venue'=>$venue_longName,
        'match_start_date'=>$match_start_date,
		'match_start_time'=>$match_start_time,
		'periodId'=>$periodId, 
		'winner'=>$winner, 
		'matchLengthMin'=>$matchLengthMin,
		'matchLengthSec'=>$matchLengthSec,
		'team1_id'=>$contestant_Team1_id,  
		'team2_id'=>$contestant_Team2_id,
	    'team1_score'=>$score_team1,
		'team2_score'=>$score_team2,
		'time_now'=>$match_lastUpdated,
		'country_id'=>$country_id,
		'season_id'=>$tournamentCalendar_id,
	    'match_week'=>$match_week,
		'startDate'=>$tournamentCalendar_startDate,
		'endDate'=>$tournamentCalendar_endDate,
		'tournamentCalendar'=>$tournamentCalendar_name,
		'ruleset_id'=>$ruleset_id,
		'ruleset_name'=>$ruleset_name,
		'last_update'=>$date,
		'match_date'=>$match_start_date
         );
         
         
         
          //score table
         $data1 = array(
         'match_start_date' => $match_start_date,
         'team_id' => $contestant_Team_id,
         'ht_home' => $ht_home,
         'ht_away' => $ht_away,
         'ft_home' => $ft_home,
         'ft_away' => $ft_away,
         'total_home' => $total_home,
         'total_away' => $total_away
         );


            
      
             
              
              
                $this->db->where('match_id',$match_id);
			   $score = $this->db->get('scores');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				 $this->db->update('scores',$data1);
				  echo "UpdateD scores";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('scores',$data1);
				  echo "inserted scores";
			   }
			   
        
            //match table
		 	   $this->db->where('match_id',$match_id);
			   $q = $this->db->get('match');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				  $this->db->update('match',$data);
				  echo "UpdateD matchES";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('match',$data);
				  echo "UpdateD matchES";
			   }
	}
		 
	}
	public function English_National_south(){
		 
			
  $url = 'http://api.performfeeds.com/soccerdata/match/12jaj4hq7ga5i15emwfyfgor9t?tmcl=4v2o7dakq0b36sr9j9lqf49nt&stg=dhpk8hgcah3dn1fgphy0maqvg&live=yes&&_fmt=json';

 $proxyauth = '12jaj4hq7ga5i15emwfyfgor9t';
 
  $proxy = '54.194.200.74';

		     $ch = curl_init();
			 curl_setopt($ch, CURLOPT_URL, $url);
			 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			 curl_setopt($ch, CURLOPT_PROXYUSERPWD, $proxyauth);   // Use if proxy have username and password
			 $response = curl_exec($ch);
			 //var_export($response);
			 //print_r($response);
			  
			 $data = json_decode($response,true);
			 
			
			
			foreach ($data['match'] as $value) {
         
       $date = date('Y-m-d H:i:s');
             //echo "<br>".$i++."================================"."</br>";
		     //echo "<pre>";
            // print_r($value);
            
        //TournamentCalendar Details//
       
     //TournamentCalendar Details//
     
      $south="south";
      echo $tournamentCalendar_id  = $south.$value['matchInfo']['tournamentCalendar']['id'];
      $tournamentCalendar_startDate = $value['matchInfo']['tournamentCalendar']['startDate'];
      $tournamentCalendar_endDate   = $value['matchInfo']['tournamentCalendar']['endDate'];
      //$tournamentCalendar_name      = $value['matchInfo']['tournamentCalendar']['name'];
      
       $tournamentCalendar_name      = "National League South 2016/2017";
       
         //matchInfo Details//
       $matchInfo         = $value['matchInfo']['description'];
       $sport_id          = $value['matchInfo']['sport']['id'];
       $sport_name        = $value['matchInfo']['sport']['name'];
       $match_id          = $value['matchInfo']['id'];
       $match_start_date  = $value['matchInfo']['date'];
       $match_start_time  = $value['matchInfo']['time'];
       $match_week        = $value['matchInfo']['week'];
       $match_lastUpdated = $value['matchInfo']['lastUpdated'];
      
       //Ruleset Details//
      
       $ruleset_id = $value['matchInfo']['ruleset']['id'];
       $ruleset_name = $value['matchInfo']['ruleset']['name'];
       
      //competition Information//
     
      $competition_id   = $value['matchInfo']['competition']['id'];
      $competition_name = $value['matchInfo']['competition']['name'];
      $country_id       = $value['matchInfo']['competition']['country']['id'];
      $country_name     = $value['matchInfo']['competition']['country']['name'];
      
       
      
       //stage Details//
      $stage_id        = $value['matchInfo']['stage']['id'];
      $stage_startDate = $value['matchInfo']['stage']['startDate'];
      $stage_endDate   = $value['matchInfo']['stage']['endDate'];
      $stage_name      = $value['matchInfo']['stage']['name'];
      
       //contestant Details//
      
      $contestant_Team1_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team2_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][1]['id'];
      
      
      
      //team Details//
      $contestant_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_name = $value['matchInfo']['contestant'][0]['name'];
      $contestant_name = $value['matchInfo']['contestant'][1]['name'];
      $contestant_countryid = $value['matchInfo']['contestant'][0]['country']['id'];
      $contestant_countryid = $value['matchInfo']['contestant'][1]['country']['id'];
      $league_name =  $value['matchInfo']['tournamentCalendar']['name'];
     
      
       //match Details//
       
        $venue_id       = $value['matchInfo']['venue']['id'];
        $venue_name     = $value['matchInfo']['venue']['shortName'];
        $venue_longName = $value['matchInfo']['venue']['longName'];
        
         //liveData Details//
        $livedata_periodId   = $value['liveData']['matchDetails']['periodId'];
        $livedata_periodId   = $value['liveData']['matchDetails']['matchStatus'];
        $matchStatus         = $value['liveData']['matchDetails']['matchStatus'];
         
        //['matchInfo']['contestant'] loop start//
        
        
        
        
		
		//['liveData']['matchDetails']['period'] loop start//
           
         foreach($value['liveData']['matchDetails']['period'] as $period){
         
         //print_r($period);
             
        $matchDetails_id1        = $period['id'];
        $matchDetails_start      = $period['start'];
        $matchDetails_end        = $period['end'];
        $matchDetails_lengthMin  = $period['lengthMin'];
        $matchDetails_lengthSec  = $period['lengthSec'];
       }
         

       //liveData Details//
      
		  //"=============================================="//
		  $score_team1    = $value['liveData']['matchDetails']['scores']['total']['home'];
		  $score_team2    = $value['liveData']['matchDetails']['scores']['total']['away'];
		
		  $ht_home       =  $value['liveData']['matchDetails']['scores']['ht']['home'];
		  $ht_away      =   $value['liveData']['matchDetails']['scores']['ht']['away'];
		  $ft_home       =  $value['liveData']['matchDetails']['scores']['ft']['home'];
		  $ft_away       =  $value['liveData']['matchDetails']['scores']['ft']['away'];
		  $total_home    =  $value['liveData']['matchDetails']['scores']['total']['home'];
		  $total_away   =   $value['liveData']['matchDetails']['scores']['total']['away'];
		  $periodId       = $value['liveData']['matchDetails']['periodId'];
		  $matchStatus    = $value['liveData']['matchDetails']['matchStatus'];
		  $winner         = $value['liveData']['matchDetails']['winner'];
		  $matchLengthMin = $value['liveData']['matchDetails']['matchLengthMin'];
		  $matchLengthSec = $value['liveData']['matchDetails']['matchLengthSec'];
		  
		  
		  //=============================================matchupdate==============================================//
		 foreach($value['liveData']['goal'] as $goaldetails){
		  
		  echo "<pre>";
				  print_r($goaldetails);
				  
		 $nowupdate = date('Y-m-d H:i:s');
				 
		 $goal_contestantId      = $goaldetails['contestantId'];
		 $goal_periodId          = $goaldetails['periodId'];
		 $goal_timeMin           = $goaldetails['timeMin'];
		 $goal_lastUpdated       = $goaldetails['lastUpdated'];
		 $goal_type              = $goaldetails['type'];
		 $goal_playerId          = $goaldetails['scorerId'];
		 $goal_scorerName        = $goaldetails['scorerName'];
		 $goal_assistPlayerId    = $goaldetails['assistPlayerId'];
         $goalt_assistPlayerName = $goaldetails['assistPlayerName'];
         $goal_optaEventId       = $goaldetails['optaEventId'];
		
		
		//Goal Table
		
		
		 $data = array(
        'league_id'=>$tournamentCalendar_id,
        'match_id'=>$match_id,
        'match_start_date'=>$match_start_date,
        'team_id'=>$contestant_Team_id,
        'name'=>$contestant_team_name,
        'contestantId'=>$goal_contestantId,
        'periodId'=>$goal_periodId,
        'timeMin'=>$goal_timeMin,
		'lastUpdated'=>$goal_lastUpdated,
		'type'=>$goal_type,
		'scorerId'=>$goal_playerId,
		'scorerName'=>$goal_scorerName,
		'assistPlayerId'=>$goal_assistPlayerId,
		'assistPlayerName'=>$goalt_assistPlayerName,
		'optaEventId'=>$goal_optaEventId,
		'now_update'=>$nowupdate
         );
         
         $data1 = array(
             'league_id'=>$tournamentCalendar_id,
			 'match_id'=>$match_id,
			 'match_start_date'=>$match_start_date,
		     'team_id'=>$contestant_Team_id,
			 'name'=>$contestant_team_name,
		     'contestantId'=>$goal_contestantId,  
			 'periodId'=>$goal_periodId,
			 'timeMin'=>$goal_timeMin,
			 'lastUpdated'=>$goal_lastUpdated,
			 'type'=>$goal_type,
		     'scorerId'=>$goal_playerId,
		     'scorerName'=>$goal_scorerName,
			 'assistPlayerId'=>$goal_assistPlayerId,
			 'assistPlayerName'=>$goalt_assistPlayerName,
			 'optaEventId'=>$goal_optaEventId,
			 'now_update'=>$nowupdate
           );
		
		//Goal table
              
              
                $this->db->where('optaEventId',$goal_optaEventId);
			   $score = $this->db->get('goal');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$goal_optaEventId);
				 $this->db->update('goal',$data1);
				  echo "Updated Goal";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('goal',$data1);
				  echo "inserted Goal";
			   }
		
		}
         //liveData Card Details//
		  
		  foreach($value['liveData']['card'] as $carddetails){
		  
		
			  
			  print_r($carddetails);
			 $card_contestantId = $carddetails['contestantId'];
			 $card_periodId     = $carddetails['periodId'];
			 $card_timeMin      = $carddetails['timeMin'];
		     $card_lastUpdated  = $carddetails['lastUpdated'];
	         $card_type         = $carddetails['type'];
			 $card_playerId     = $carddetails['playerId'];
		     $card_playerName   = $carddetails['playerName'];
		     $card_optaEventId  = $carddetails['optaEventId'];
		     
		     
		     
		      $data = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
         );
         
         $data1 = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
           );

		     //Goal table
              
              
                $this->db->where('optaEventId',$card_optaEventId);
			   $score = $this->db->get('card');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$card_optaEventId);
				 $this->db->update('card',$data1);
				  echo "Updated card";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('card',$data1);
				  echo "inserted card";
			   }
		    
		     
		     
		     
			}
			
			 //liveData substitute Details//
					
					foreach($value['liveData']['substitute'] as $substitutedetail){
						
						print_r($substitutedetail);
					//	echo "subst"."<pre>";
					$substitute_contestantId     = $substitutedetail['contestantId'];
					$substitute_periodId         = $substitutedetail['periodId'];
					$substitute_timeMin          = $substitutedetail['timeMin'];
					$substitute_lastUpdated      = $substitutedetail['lastUpdated'];
					$substitute_playerOnId       = $substitutedetail['playerOnId'];
					$substitute_playerOnName     = $substitutedetail['playerOnName'];
					$substitute_playerOffId      = $substitutedetail['playerOffId'];
				    $substitute_playerOffName    = $substitutedetail['playerOffName'];
						 
						$data = array(
					 'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					    );
					$data1 = array(
					  'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					   
					  );
					  
					  //substitute table
              
              
                 $this->db->where('playerOnId',$substitute_playerOnId);
			   $score = $this->db->get('substitute');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('playerOnId',$substitute_playerOnId);
				 $this->db->update('substitute',$data);
				  echo "Updated substitute";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('substitute',$data);
				  echo "inserted substitute";
			   }
					 
						
					}
			
 
  	//=============================================substitute end==============================================//
		
            //match table
		 
		 $data = array(
        'match_id'=>$match_id,
        'league_id'=>$tournamentCalendar_id,
         'stage_id'=>$stage_id,
        'sport_id'=>$sport_id,
        'matchStatus'=>$matchStatus,
        'venue'=>$venue_longName,
        'match_start_date'=>$match_start_date,
		'match_start_time'=>$match_start_time,
		'periodId'=>$periodId, 
		'winner'=>$winner, 
		'matchLengthMin'=>$matchLengthMin,
		'matchLengthSec'=>$matchLengthSec,
		'team1_id'=>$contestant_Team1_id,  
		'team2_id'=>$contestant_Team2_id,
	    'team1_score'=>$score_team1,
		'team2_score'=>$score_team2,
		'time_now'=>$match_lastUpdated,
		'country_id'=>$country_id,
		'season_id'=>$tournamentCalendar_id,
	    'match_week'=>$match_week,
		'startDate'=>$tournamentCalendar_startDate,
		'endDate'=>$tournamentCalendar_endDate,
		'tournamentCalendar'=>$tournamentCalendar_name,
		'ruleset_id'=>$ruleset_id,
		'ruleset_name'=>$ruleset_name,
		'last_update'=>$date,
		'match_date'=>$match_start_date
         );
         
         
         
          //score table
         $data1 = array(
         'match_start_date' => $match_start_date,
         'team_id' => $contestant_Team_id,
         'ht_home' => $ht_home,
         'ht_away' => $ht_away,
         'ft_home' => $ft_home,
         'ft_away' => $ft_away,
         'total_home' => $total_home,
         'total_away' => $total_away
         );


            
      
             
              
              
                $this->db->where('match_id',$match_id);
			   $score = $this->db->get('scores');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				 $this->db->update('scores',$data1);
				  echo "UpdateD scores";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('scores',$data1);
				  echo "inserted scores";
			   }
			   
        
            //match table
		 	   $this->db->where('match_id',$match_id);
			   $q = $this->db->get('match');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				  $this->db->update('match',$data);
				  echo "UpdateD matchES";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('match',$data);
				  echo "UpdateD matchES";
			   }
	}
		 
	}
	
	public function Ryman_Premier(){
		 
			
  $url = 'http://api.performfeeds.com/soccerdata/match/12jaj4hq7ga5i15emwfyfgor9t?tmcl=4v2o7dakq0b36sr9j9lqf49nt&stg=dhpk8hgcah3dn1fgphy0maqvg&live=yes&&_fmt=json';

 $proxyauth = '12jaj4hq7ga5i15emwfyfgor9t';
 
  $proxy = '54.194.200.74';

		     $ch = curl_init();
			 curl_setopt($ch, CURLOPT_URL, $url);
			 curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			 curl_setopt($ch, CURLOPT_PROXYUSERPWD, $proxyauth);   // Use if proxy have username and password
			 $response = curl_exec($ch);
			 //var_export($response);
			 //print_r($response);
			  
			 $data = json_decode($response,true);
			 
			
			
			foreach ($data['match'] as $value) {
         
       $date = date('Y-m-d H:i:s');
             //echo "<br>".$i++."================================"."</br>";
		     //echo "<pre>";
            // print_r($value);
            
        //TournamentCalendar Details//
       
     //TournamentCalendar Details//
     
      $south="south";
      echo $tournamentCalendar_id  = $south.$value['matchInfo']['tournamentCalendar']['id'];
      $tournamentCalendar_startDate = $value['matchInfo']['tournamentCalendar']['startDate'];
      $tournamentCalendar_endDate   = $value['matchInfo']['tournamentCalendar']['endDate'];
      //$tournamentCalendar_name      = $value['matchInfo']['tournamentCalendar']['name'];
      
       $tournamentCalendar_name      = "National League South 2016/2017";
       
         //matchInfo Details//
       $matchInfo         = $value['matchInfo']['description'];
       $sport_id          = $value['matchInfo']['sport']['id'];
       $sport_name        = $value['matchInfo']['sport']['name'];
       $match_id          = $value['matchInfo']['id'];
       $match_start_date  = $value['matchInfo']['date'];
       $match_start_time  = $value['matchInfo']['time'];
       $match_week        = $value['matchInfo']['week'];
       $match_lastUpdated = $value['matchInfo']['lastUpdated'];
      
       //Ruleset Details//
      
       $ruleset_id = $value['matchInfo']['ruleset']['id'];
       $ruleset_name = $value['matchInfo']['ruleset']['name'];
       
      //competition Information//
     
      $competition_id   = $value['matchInfo']['competition']['id'];
      $competition_name = $value['matchInfo']['competition']['name'];
      $country_id       = $value['matchInfo']['competition']['country']['id'];
      $country_name     = $value['matchInfo']['competition']['country']['name'];
      
       
      
       //stage Details//
      $stage_id        = $value['matchInfo']['stage']['id'];
      $stage_startDate = $value['matchInfo']['stage']['startDate'];
      $stage_endDate   = $value['matchInfo']['stage']['endDate'];
      $stage_name      = $value['matchInfo']['stage']['name'];
      
       //contestant Details//
      
      $contestant_Team1_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team2_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_Team_id = $value['matchInfo']['contestant'][1]['id'];
      
      
      
      //team Details//
      $contestant_id = $value['matchInfo']['contestant'][0]['id'];
      $contestant_id = $value['matchInfo']['contestant'][1]['id'];
      $contestant_name = $value['matchInfo']['contestant'][0]['name'];
      $contestant_name = $value['matchInfo']['contestant'][1]['name'];
      $contestant_countryid = $value['matchInfo']['contestant'][0]['country']['id'];
      $contestant_countryid = $value['matchInfo']['contestant'][1]['country']['id'];
      $league_name =  $value['matchInfo']['tournamentCalendar']['name'];
     
      
       //match Details//
       
        $venue_id       = $value['matchInfo']['venue']['id'];
        $venue_name     = $value['matchInfo']['venue']['shortName'];
        $venue_longName = $value['matchInfo']['venue']['longName'];
        
         //liveData Details//
        $livedata_periodId   = $value['liveData']['matchDetails']['periodId'];
        $livedata_periodId   = $value['liveData']['matchDetails']['matchStatus'];
        $matchStatus         = $value['liveData']['matchDetails']['matchStatus'];
         
        //['matchInfo']['contestant'] loop start//
        
        
        
        
		
		//['liveData']['matchDetails']['period'] loop start//
           
         foreach($value['liveData']['matchDetails']['period'] as $period){
         
         //print_r($period);
             
        $matchDetails_id1        = $period['id'];
        $matchDetails_start      = $period['start'];
        $matchDetails_end        = $period['end'];
        $matchDetails_lengthMin  = $period['lengthMin'];
        $matchDetails_lengthSec  = $period['lengthSec'];
       }
         

       //liveData Details//
      
		  //"=============================================="//
		  $score_team1    = $value['liveData']['matchDetails']['scores']['total']['home'];
		  $score_team2    = $value['liveData']['matchDetails']['scores']['total']['away'];
		
		  $ht_home       =  $value['liveData']['matchDetails']['scores']['ht']['home'];
		  $ht_away      =   $value['liveData']['matchDetails']['scores']['ht']['away'];
		  $ft_home       =  $value['liveData']['matchDetails']['scores']['ft']['home'];
		  $ft_away       =  $value['liveData']['matchDetails']['scores']['ft']['away'];
		  $total_home    =  $value['liveData']['matchDetails']['scores']['total']['home'];
		  $total_away   =   $value['liveData']['matchDetails']['scores']['total']['away'];
		  $periodId       = $value['liveData']['matchDetails']['periodId'];
		  $matchStatus    = $value['liveData']['matchDetails']['matchStatus'];
		  $winner         = $value['liveData']['matchDetails']['winner'];
		  $matchLengthMin = $value['liveData']['matchDetails']['matchLengthMin'];
		  $matchLengthSec = $value['liveData']['matchDetails']['matchLengthSec'];
		  
		  
		  //=============================================matchupdate==============================================//
		 foreach($value['liveData']['goal'] as $goaldetails){
		  
		  echo "<pre>";
				  print_r($goaldetails);
				  
		 $nowupdate = date('Y-m-d H:i:s');
				 
		 $goal_contestantId      = $goaldetails['contestantId'];
		 $goal_periodId          = $goaldetails['periodId'];
		 $goal_timeMin           = $goaldetails['timeMin'];
		 $goal_lastUpdated       = $goaldetails['lastUpdated'];
		 $goal_type              = $goaldetails['type'];
		 $goal_playerId          = $goaldetails['scorerId'];
		 $goal_scorerName        = $goaldetails['scorerName'];
		 $goal_assistPlayerId    = $goaldetails['assistPlayerId'];
         $goalt_assistPlayerName = $goaldetails['assistPlayerName'];
         $goal_optaEventId       = $goaldetails['optaEventId'];
		
		
		//Goal Table
		
		
		 $data = array(
        'league_id'=>$tournamentCalendar_id,
        'match_id'=>$match_id,
        'match_start_date'=>$match_start_date,
        'team_id'=>$contestant_Team_id,
        'name'=>$contestant_team_name,
        'contestantId'=>$goal_contestantId,
        'periodId'=>$goal_periodId,
        'timeMin'=>$goal_timeMin,
		'lastUpdated'=>$goal_lastUpdated,
		'type'=>$goal_type,
		'scorerId'=>$goal_playerId,
		'scorerName'=>$goal_scorerName,
		'assistPlayerId'=>$goal_assistPlayerId,
		'assistPlayerName'=>$goalt_assistPlayerName,
		'optaEventId'=>$goal_optaEventId,
		'now_update'=>$nowupdate
         );
         
         $data1 = array(
             'league_id'=>$tournamentCalendar_id,
			 'match_id'=>$match_id,
			 'match_start_date'=>$match_start_date,
		     'team_id'=>$contestant_Team_id,
			 'name'=>$contestant_team_name,
		     'contestantId'=>$goal_contestantId,  
			 'periodId'=>$goal_periodId,
			 'timeMin'=>$goal_timeMin,
			 'lastUpdated'=>$goal_lastUpdated,
			 'type'=>$goal_type,
		     'scorerId'=>$goal_playerId,
		     'scorerName'=>$goal_scorerName,
			 'assistPlayerId'=>$goal_assistPlayerId,
			 'assistPlayerName'=>$goalt_assistPlayerName,
			 'optaEventId'=>$goal_optaEventId,
			 'now_update'=>$nowupdate
           );
		
		//Goal table
              
              
                $this->db->where('optaEventId',$goal_optaEventId);
			   $score = $this->db->get('goal');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$goal_optaEventId);
				 $this->db->update('goal',$data1);
				  echo "Updated Goal";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('goal',$data1);
				  echo "inserted Goal";
			   }
		
		}
         //liveData Card Details//
		  
		  foreach($value['liveData']['card'] as $carddetails){
		  
		
			  
			  print_r($carddetails);
			 $card_contestantId = $carddetails['contestantId'];
			 $card_periodId     = $carddetails['periodId'];
			 $card_timeMin      = $carddetails['timeMin'];
		     $card_lastUpdated  = $carddetails['lastUpdated'];
	         $card_type         = $carddetails['type'];
			 $card_playerId     = $carddetails['playerId'];
		     $card_playerName   = $carddetails['playerName'];
		     $card_optaEventId  = $carddetails['optaEventId'];
		     
		     
		     
		      $data = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
         );
         
         $data1 = array(
                     'league_id'=>$tournamentCalendar_id,
					 'match_id'=>$match_id,
					 'match_start_date'=>$match_start_date,
					 'team_id'=>$contestant_Team_id,
					 'name'=>$contestant_team_name,  
					 'contestantId'=>$card_contestantId,
					 'periodId'=>$card_periodId,
					 'timeMin'=>$card_timeMin,
					 'lastUpdated'=>$card_lastUpdated,
					 'type'=>$card_type,
					 'playerId'=>$card_playerId,
					 'playerName'=>$card_playerName,
					 'optaEventId'=>$card_optaEventId,
					  'now_update'=>$nowupdate
           );

		     //Goal table
              
              
                $this->db->where('optaEventId',$card_optaEventId);
			   $score = $this->db->get('card');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('optaEventId',$card_optaEventId);
				 $this->db->update('card',$data1);
				  echo "Updated card";
			   
			   } else {
				  //$this->db->set('optaEventId',$goal_optaEventId);
				  $this->db->insert('card',$data1);
				  echo "inserted card";
			   }
		    
		     
		     
		     
			}
			
			 //liveData substitute Details//
					
					foreach($value['liveData']['substitute'] as $substitutedetail){
						
						print_r($substitutedetail);
					//	echo "subst"."<pre>";
					$substitute_contestantId     = $substitutedetail['contestantId'];
					$substitute_periodId         = $substitutedetail['periodId'];
					$substitute_timeMin          = $substitutedetail['timeMin'];
					$substitute_lastUpdated      = $substitutedetail['lastUpdated'];
					$substitute_playerOnId       = $substitutedetail['playerOnId'];
					$substitute_playerOnName     = $substitutedetail['playerOnName'];
					$substitute_playerOffId      = $substitutedetail['playerOffId'];
				    $substitute_playerOffName    = $substitutedetail['playerOffName'];
						 
						$data = array(
					 'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					    );
					$data1 = array(
					  'league_id'=>$tournamentCalendar_id,
					  'match_id'=>$match_id,
					  'match_start_date'=>$match_start_date,
					  'team_id'=>$substitute_contestantId,
					  'name'=>$contestant_team_name,
					  'contestantId'=>$substitute_contestantId,  
					  'periodId'=>$substitute_periodId,
					  'timeMin'=>$substitute_timeMin,
					  'lastUpdated'=>$substitute_lastUpdated,
					  'playerOnId'=>$substitute_playerOnId,
					  'playerOnName'=>$substitute_playerOnName,
					  'playerOffId'=>$substitute_playerOffId,
					  'playerOffName'=>$substitute_playerOffName,
					   'now_update'=>$nowupdate
					   
					  );
					  
					  //substitute table
              
              
                 $this->db->where('playerOnId',$substitute_playerOnId);
			   $score = $this->db->get('substitute');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				 
				 $this->db->where('playerOnId',$substitute_playerOnId);
				 $this->db->update('substitute',$data);
				  echo "Updated substitute";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('substitute',$data);
				  echo "inserted substitute";
			   }
					 
						
					}
			
 
  	//=============================================substitute end==============================================//
		
            //match table
		 
		 $data = array(
        'match_id'=>$match_id,
        'league_id'=>$tournamentCalendar_id,
         'stage_id'=>$stage_id,
        'sport_id'=>$sport_id,
        'matchStatus'=>$matchStatus,
        'venue'=>$venue_longName,
        'match_start_date'=>$match_start_date,
		'match_start_time'=>$match_start_time,
		'periodId'=>$periodId, 
		'winner'=>$winner, 
		'matchLengthMin'=>$matchLengthMin,
		'matchLengthSec'=>$matchLengthSec,
		'team1_id'=>$contestant_Team1_id,  
		'team2_id'=>$contestant_Team2_id,
	    'team1_score'=>$score_team1,
		'team2_score'=>$score_team2,
		'time_now'=>$match_lastUpdated,
		'country_id'=>$country_id,
		'season_id'=>$tournamentCalendar_id,
	    'match_week'=>$match_week,
		'startDate'=>$tournamentCalendar_startDate,
		'endDate'=>$tournamentCalendar_endDate,
		'tournamentCalendar'=>$tournamentCalendar_name,
		'ruleset_id'=>$ruleset_id,
		'ruleset_name'=>$ruleset_name,
		'last_update'=>$date,
		'match_date'=>$match_start_date
         );
         
         
         
          //score table
         $data1 = array(
         'match_start_date' => $match_start_date,
         'team_id' => $contestant_Team_id,
         'ht_home' => $ht_home,
         'ht_away' => $ht_away,
         'ft_home' => $ft_home,
         'ft_away' => $ft_away,
         'total_home' => $total_home,
         'total_away' => $total_away
         );


            
      
             
              
              
                $this->db->where('match_id',$match_id);
			   $score = $this->db->get('scores');
			   
			    if ($score->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				 $this->db->update('scores',$data1);
				  echo "UpdateD scores";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('scores',$data1);
				  echo "inserted scores";
			   }
			   
        
            //match table
		 	   $this->db->where('match_id',$match_id);
			   $q = $this->db->get('match');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('match_id',$match_id);
				  $this->db->update('match',$data);
				  echo "UpdateD matchES";
			   
			   } else {
				  $this->db->set('match_id', $match_id);
				  $this->db->insert('match',$data);
				  echo "UpdateD matchES";
			   }
	}
		 
	}
		

     }
?> 
