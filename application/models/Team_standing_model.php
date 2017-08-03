<?php
error_reporting(0);  

class Team_standing_model extends CI_Model {

     public function __construct()
    {
        $this->load->database();
    }


    
		//=================wowzawowzawowza======================================; 
  

     
      public function wowoza(){
		  
		  $username = "wowza";
       $password = "i-00a047f7eee39cc4e";
       $url ='http://54.171.155.221:8086/connectioncounts?flat';
        //setting the curl parameters.
        $ch = curl_init();
        
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($ch, CURLOPT_UNRESTRICTED_AUTH, 1);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        
        
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        // Following line is compulsary to add as it is:
        curl_setopt($ch, CURLOPT_POSTFIELDS,
                    "xmlRequest=" . $input_xml);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
        
        curl_setopt($ch, CURLOPT_USERPWD, "$username:$password");
        $data = curl_exec($ch);
        
        curl_close($ch);

        //convert the XML result into array
        $array_data = json_decode(json_encode(simplexml_load_string($data)), true);
      
        
            if(!empty($array_data)){
            $this->db->where('live',1);
            $this->db->set('live',0);
            $sql = $this->db->update('channel');
            
             }
        
        foreach($array_data["Stream"] as $value)
        {
			 
		    
			foreach($value as $liveuser)
			{
        //print_r('<pre>');
       // print_r($data);
        //print_r('</pre>');
        
           echo  $streamName = $liveuser['streamName'];
		   $applicationName = $liveuser['applicationName'];
		   
        
			$this->db->where('streamName',$streamName);
			$query = $this->db->get('channel');
			           
			if ($query->num_rows() > 0){
			   $this->db->where('streamName =',$streamName);
		       $this->db->set('live',1);
               $this->db->update('channel');
			}
			
		   }  
	      }
	    }
          
         //==========================wowzawowzawowzawowza=============================//
    
		  
		  public function Premier_League_stat(){
		
		        $url ='http://api.performfeeds.com/soccerdata/standings/12jaj4hq7ga5i15emwfyfgor9t?tmcl=2c1fh40r28amu4rgz0q66ago9&_fmt=json&_rt=b';
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
		
		         echo $tournamentCalendar =  $data['tournamentCalendar']['id'];
				 $sport_id =  $data['sport']['id'];
	   			 $rank = $ranking['rank'];
		 
				//echo "<pre>"; 
				//print_r($data);  echo "</pre>";
				
				
				foreach ($data['stage'] as $value) {
					
					  foreach($value['division'] as $division) {
					 
						foreach($division['ranking'] as $ranking){
							
						
						      $rank = $ranking['rank'];
							 $rankStatus = $ranking['rankStatus'];
							 $lastRank = $ranking['lastRank'];
							 $contestantId = $ranking['contestantId'];
							 $contestantName = $ranking['contestantName'];
							 $contestantShortName = $ranking['contestantShortName'];
							 $contestantClubName = $ranking['contestantClubName']; 
							 $contestantCode = $ranking['contestantCode']; 
							 $points = $ranking['points'];
							 $matchesPlayed = $ranking['matchesPlayed'];
							 $matchesWon = $ranking['matchesWon'];
							 $matchesLost = $ranking['matchesLost'];
							 $matchesDrawn = $ranking['matchesDrawn'];
							 $goalsFor = $ranking['goalsFor'];
							 $goalsAgainst = $ranking['goalsAgainst'];
							 $goaldifference = $ranking['goaldifference'];
							 
							 
							 $publish_date = date('Y-m-d H:i:s');
							 
							 
							 
				$insert = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantId'=>$contestantId,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );
                  
                  $update = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );


        
			   $this->db->where('contestantId',$contestantId);
			   $q = $this->db->get('standings');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('contestantId',$contestantId);
				  $this->db->update('standings',$update);
				  echo "Update Premier_League_stat";
				  echo "=================================";
			   } else {
				  $this->db->set('contestantId', $contestantId);
				  $this->db->insert('standings',$insert);
				  echo "Insert Premier_League_stat";
			   }
		      	}
					}
						}
			}
    

				
					
			public function Chinese_Super_League_stat(){
		
		       $url ='http://api.performfeeds.com/soccerdata/standings/12jaj4hq7ga5i15emwfyfgor9t?tmcl=bo69dtzfanugqk3w278gppxwp&_fmt=json&_rt=b';

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
		
		         echo $tournamentCalendar =  $data['tournamentCalendar']['id'];
				 $sport_id =  $data['sport']['id'];
	   			 $rank = $ranking['rank'];
		 
				//echo "<pre>"; 
				//print_r($data);  echo "</pre>";
				
				
				foreach ($data['stage'] as $value) {
					
					  foreach($value['division'] as $division) {
					 
						foreach($division['ranking'] as $ranking){
							
						
						     $rank = $ranking['rank'];
							 $rankStatus = $ranking['rankStatus'];
							 $lastRank = $ranking['lastRank'];
							 $contestantId = $ranking['contestantId'];
							 $contestantName = $ranking['contestantName'];
							 $contestantShortName = $ranking['contestantShortName'];
							 $contestantClubName = $ranking['contestantClubName']; 
							 $contestantCode = $ranking['contestantCode']; 
							 $points = $ranking['points'];
							 $matchesPlayed = $ranking['matchesPlayed'];
							 $matchesWon = $ranking['matchesWon'];
							 $matchesLost = $ranking['matchesLost'];
							 $matchesDrawn = $ranking['matchesDrawn'];
							 $goalsFor = $ranking['goalsFor'];
							 $goalsAgainst = $ranking['goalsAgainst'];
							 $goaldifference = $ranking['goaldifference'];
							 
							 
							 $publish_date = date('Y-m-d H:i:s');
							 
							 
			$insert = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantId'=>$contestantId,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );
                  
                  $update = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );


        
			   $this->db->where('contestantId',$contestantId);
			   $q = $this->db->get('standings');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('contestantId',$contestantId);
				  $this->db->update('standings',$update);
				    echo "Update Chinese_Super_League_stat";
			   } else {
				  $this->db->set('contestantId', $contestantId);
				  $this->db->insert('standings',$insert);
				    echo "Update Chinese_Super_League_stat";
			   }
		      	}
					}
						}
			}
				
    public function Championship_stat(){
		
		        $url ='http://api.performfeeds.com/soccerdata/standings/12jaj4hq7ga5i15emwfyfgor9t?tmcl=34t77emy3pvowf6x59hr6d2p5&_fmt=json&_rt=b';
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
		
		         echo $tournamentCalendar =  $data['tournamentCalendar']['id'];
				 $sport_id =  $data['sport']['id'];
	   			 $rank = $ranking['rank'];
		 
				
				
				
				foreach ($data['stage'] as $value) {
					
					  foreach($value['division'] as $division) {
					 
						foreach($division['ranking'] as $ranking){
							
							echo "<pre>"; 
				           print_r($ranking);  echo "</pre>";
						
						     echo $rank = $ranking['rank'];
							 echo $rankStatus = $ranking['rankStatus'];
							 $lastRank = $ranking['lastRank'];
							 $contestantId = $ranking['contestantId'];
							 $contestantName = $ranking['contestantName'];
							 $contestantShortName = $ranking['contestantShortName'];
							 $contestantClubName = $ranking['contestantClubName']; 
							 $contestantCode = $ranking['contestantCode']; 
							 $points = $ranking['points'];
							 $matchesPlayed = $ranking['matchesPlayed'];
							 $matchesWon = $ranking['matchesWon'];
							 $matchesLost = $ranking['matchesLost'];
							 $matchesDrawn = $ranking['matchesDrawn'];
							 $goalsFor = $ranking['goalsFor'];
							 $goalsAgainst = $ranking['goalsAgainst'];
							 $goaldifference = $ranking['goaldifference'];
							 
							 
							 $publish_date = date('Y-m-d H:i:s');
							 
							 
							 
				$insert = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantId'=>$contestantId,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );
                  
                  $update = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );


        
			   $this->db->where('contestantId',$contestantId);
			   $q = $this->db->get('standings');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('contestantId',$contestantId);
				  $this->db->update('standings',$update);
				  //$this->db-last->query();
				   echo "Update Championship_stat";
			   } else {
				  $this->db->set('contestantId', $contestantId);
				  $this->db->insert('standings',$insert);
				   echo "Update Championship_stat";
			   }
		      	}
					}
						}
			}
					
		
					
		public function English_National_North_stat(){
		
		        $url ='http://api.performfeeds.com/soccerdata/standings/12jaj4hq7ga5i15emwfyfgor9t?tmcl=4v2o7dakq0b36sr9j9lqf49nt&_fmt=json&_rt=b';
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
		
		         echo $tournamentCalendar =  $data['tournamentCalendar']['id'];
				 $sport_id =  $data['sport']['id'];
	   			 $rank = $ranking['rank'];
		 
				//echo "<pre>"; 
				//print_r($data);  echo "</pre>";
				
				
				foreach ($data['stage'] as $value) {
					
					  foreach($value['division'] as $division) {
					 
						foreach($division['ranking'] as $ranking){
							
						
						      $rank = $ranking['rank'];
							 $rankStatus = $ranking['rankStatus'];
							 $lastRank = $ranking['lastRank'];
							 $contestantId = $ranking['contestantId'];
							 $contestantName = $ranking['contestantName'];
							 $contestantShortName = $ranking['contestantShortName'];
							 $contestantClubName = $ranking['contestantClubName']; 
							 $contestantCode = $ranking['contestantCode']; 
							 $points = $ranking['points'];
							 $matchesPlayed = $ranking['matchesPlayed'];
							 $matchesWon = $ranking['matchesWon'];
							 $matchesLost = $ranking['matchesLost'];
							 $matchesDrawn = $ranking['matchesDrawn'];
							 $goalsFor = $ranking['goalsFor'];
							 $goalsAgainst = $ranking['goalsAgainst'];
							 $goaldifference = $ranking['goaldifference'];
							 
							 
							 $publish_date = date('Y-m-d H:i:s');
							 
							 
				$insert = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantId'=>$contestantId,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );
                  
                  $update = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );

        
			   $this->db->where('contestantId',$contestantId);
			   $q = $this->db->get('standings');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('contestantId',$contestantId);
				  $this->db->update('standings',$update);
				   echo "Update English_National_League_NS_stat";
			   } else {
				  $this->db->set('contestantId', $contestantId);
				  $this->db->insert('standings',$insert);
				   echo "Update English_National_League_NS_stat";
			   }
		      	}
					}
						}
			}
			public function English_National_South_stat(){
		
		        $url ='http://api.performfeeds.com/soccerdata/standings/12jaj4hq7ga5i15emwfyfgor9t?tmcl=4v2o7dakq0b36sr9j9lqf49nt&_fmt=json&_rt=b';
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
		
		         echo $tournamentCalendar =  $data['tournamentCalendar']['id'];
				 $sport_id =  $data['sport']['id'];
	   			 $rank = $ranking['rank'];
		 
				//echo "<pre>"; 
				//print_r($data);  echo "</pre>";
				
				
				foreach ($data['stage'] as $value) {
					
					  foreach($value['division'] as $division) {
					 
						foreach($division['ranking'] as $ranking){
							
						
						      $rank = $ranking['rank'];
							 $rankStatus = $ranking['rankStatus'];
							 $lastRank = $ranking['lastRank'];
							 $contestantId = $ranking['contestantId'];
							 $contestantName = $ranking['contestantName'];
							 $contestantShortName = $ranking['contestantShortName'];
							 $contestantClubName = $ranking['contestantClubName']; 
							 $contestantCode = $ranking['contestantCode']; 
							 $points = $ranking['points'];
							 $matchesPlayed = $ranking['matchesPlayed'];
							 $matchesWon = $ranking['matchesWon'];
							 $matchesLost = $ranking['matchesLost'];
							 $matchesDrawn = $ranking['matchesDrawn'];
							 $goalsFor = $ranking['goalsFor'];
							 $goalsAgainst = $ranking['goalsAgainst'];
							 $goaldifference = $ranking['goaldifference'];
							 
							 
							 $publish_date = date('Y-m-d H:i:s');
							 
							 
				$insert = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantId'=>$contestantId,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );
                  
                  $update = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );

        
			   $this->db->where('contestantId',$contestantId);
			   $q = $this->db->get('standings');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('contestantId',$contestantId);
				  $this->db->update('standings',$update);
				   echo "Update English_National_League_NS_stat";
			   } else {
				  $this->db->set('contestantId', $contestantId);
				  $this->db->insert('standings',$insert);
				   echo "Update English_National_League_NS_stat";
			   }
		      	}
					}
						}
			}
			
			
			public function English_National_League_stat(){
		
		        $url ='http://api.performfeeds.com/soccerdata/standings/12jaj4hq7ga5i15emwfyfgor9t?tmcl=drpfno13t2w4rtzwt6uev87vt&_fmt=json&_rt=b';
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
		
		         echo $tournamentCalendar =  $data['tournamentCalendar']['id'];
				 $sport_id =  $data['sport']['id'];
	   			 $rank = $ranking['rank'];
		 
				//echo "<pre>"; 
				//print_r($data);  echo "</pre>";
				
				
				foreach ($data['stage'] as $value) {
					
					  foreach($value['division'] as $division) {
					 
						foreach($division['ranking'] as $ranking){
							
						
						      $rank = $ranking['rank'];
							 $rankStatus = $ranking['rankStatus'];
							 $lastRank = $ranking['lastRank'];
							 $contestantId = $ranking['contestantId'];
							 $contestantName = $ranking['contestantName'];
							 $contestantShortName = $ranking['contestantShortName'];
							 $contestantClubName = $ranking['contestantClubName']; 
							 $contestantCode = $ranking['contestantCode']; 
							 $points = $ranking['points'];
							 $matchesPlayed = $ranking['matchesPlayed'];
							 $matchesWon = $ranking['matchesWon'];
							 $matchesLost = $ranking['matchesLost'];
							 $matchesDrawn = $ranking['matchesDrawn'];
							 $goalsFor = $ranking['goalsFor'];
							 $goalsAgainst = $ranking['goalsAgainst'];
							 $goaldifference = $ranking['goaldifference'];
							 
							 
							 $publish_date = date('Y-m-d H:i:s');
							 
							 
							 
				$insert = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantId'=>$contestantId,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );
                  
                  $update = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );


        
			   $this->db->where('contestantId',$contestantId);
			   $q = $this->db->get('standings');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('contestantId',$contestantId);
				  $this->db->update('standings',$update);
				   echo "Update English_National_League_stat";
			   } else {
				  $this->db->set('contestantId', $contestantId);
				  $this->db->insert('standings',$insert);
				   echo "Update English_National_League_stat";
			   }
		      	}
					}
						}
			}
			
			public function League_One_stat(){
		
		        $url ='http://api.performfeeds.com/soccerdata/standings/12jaj4hq7ga5i15emwfyfgor9t?tmcl=eqhqp1wywjdkc97ww89v7tb6x&_fmt=json&_rt=b';
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
		
		         echo $tournamentCalendar =  $data['tournamentCalendar']['id'];
				 $sport_id =  $data['sport']['id'];
	   			 $rank = $ranking['rank'];
		 
				//echo "<pre>"; 
				//print_r($data);  echo "</pre>";
				
				
				foreach ($data['stage'] as $value) {
					
					  foreach($value['division'] as $division) {
					 
						foreach($division['ranking'] as $ranking){
							
						
						       $rank = $ranking['rank'];
							 $rankStatus = $ranking['rankStatus'];
							 $lastRank = $ranking['lastRank'];
							 $contestantId = $ranking['contestantId'];
							 $contestantName = $ranking['contestantName'];
							 $contestantShortName = $ranking['contestantShortName'];
							 $contestantClubName = $ranking['contestantClubName']; 
							 $contestantCode = $ranking['contestantCode']; 
							 $points = $ranking['points'];
							 $matchesPlayed = $ranking['matchesPlayed'];
							 $matchesWon = $ranking['matchesWon'];
							 $matchesLost = $ranking['matchesLost'];
							 $matchesDrawn = $ranking['matchesDrawn'];
							 $goalsFor = $ranking['goalsFor'];
							 $goalsAgainst = $ranking['goalsAgainst'];
							 $goaldifference = $ranking['goaldifference'];
							 
							 
							 $publish_date = date('Y-m-d H:i:s');
							 
							 
							 
				$insert = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantId'=>$contestantId,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );
                  
                  $update = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );


        
			   $this->db->where('contestantId',$contestantId);
			   $q = $this->db->get('standings');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('contestantId',$contestantId);
				  $this->db->update('standings',$update);
				   echo "Update League_One_stat";
			   } else {
				  $this->db->set('contestantId', $contestantId);
				  $this->db->insert('standings',$insert);
				   echo "Update League_One_stat";
			   }
		      	}
					}
						}
			}
			
			
			public function League_Two_stat(){
		
		        $url ='http://api.performfeeds.com/soccerdata/standings/12jaj4hq7ga5i15emwfyfgor9t?tmcl=b5asig56ec3v0no2tdj0v6okp&_fmt=json&_rt=b';
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
		
		         echo $tournamentCalendar =  $data['tournamentCalendar']['id'];
				 $sport_id =  $data['sport']['id'];
	   			 $rank = $ranking['rank'];
		 
				//echo "<pre>"; 
				//print_r($data);  echo "</pre>";
				
				
				foreach ($data['stage'] as $value) {
					
					  foreach($value['division'] as $division) {
					 
						foreach($division['ranking'] as $ranking){
							
						
						     $rank = $ranking['rank'];
							 $rankStatus = $ranking['rankStatus'];
							 $lastRank = $ranking['lastRank'];
							 $contestantId = $ranking['contestantId'];
							 $contestantName = $ranking['contestantName'];
							 $contestantShortName = $ranking['contestantShortName'];
							 $contestantClubName = $ranking['contestantClubName']; 
							 $contestantCode = $ranking['contestantCode']; 
							 $points = $ranking['points'];
							 $matchesPlayed = $ranking['matchesPlayed'];
							 $matchesWon = $ranking['matchesWon'];
							 $matchesLost = $ranking['matchesLost'];
							 $matchesDrawn = $ranking['matchesDrawn'];
							 $goalsFor = $ranking['goalsFor'];
							 $goalsAgainst = $ranking['goalsAgainst'];
							 $goaldifference = $ranking['goaldifference'];
							 
							 
							 $publish_date = date('Y-m-d H:i:s');
							 
							 
				$insert = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantId'=>$contestantId,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );
                  
                  $update = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );


        
			   $this->db->where('contestantId',$contestantId);
			   $q = $this->db->get('standings');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('contestantId',$contestantId);
				  $this->db->update('standings',$update);
				  echo "Update League_Two_stat";
			   } else {
				  $this->db->set('contestantId', $contestantId);
				  $this->db->insert('standings',$insert);
				  echo "Update League_Two_stat";
			   }
		      	}
					}
						}
			}
				
				public function League_Two_stat(){
		
		        $url ='http://api.performfeeds.com/soccerdata/standings/12jaj4hq7ga5i15emwfyfgor9t?tmcl=b5asig56ec3v0no2tdj0v6okp&_fmt=json&_rt=b';
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
		
		         echo $tournamentCalendar =  $data['tournamentCalendar']['id'];
				 $sport_id =  $data['sport']['id'];
	   			 $rank = $ranking['rank'];
		 
				//echo "<pre>"; 
				//print_r($data);  echo "</pre>";
				
				
				foreach ($data['stage'] as $value) {
					
					  foreach($value['division'] as $division) {
					 
						foreach($division['ranking'] as $ranking){
							
						
						     $rank = $ranking['rank'];
							 $rankStatus = $ranking['rankStatus'];
							 $lastRank = $ranking['lastRank'];
							 $contestantId = $ranking['contestantId'];
							 $contestantName = $ranking['contestantName'];
							 $contestantShortName = $ranking['contestantShortName'];
							 $contestantClubName = $ranking['contestantClubName']; 
							 $contestantCode = $ranking['contestantCode']; 
							 $points = $ranking['points'];
							 $matchesPlayed = $ranking['matchesPlayed'];
							 $matchesWon = $ranking['matchesWon'];
							 $matchesLost = $ranking['matchesLost'];
							 $matchesDrawn = $ranking['matchesDrawn'];
							 $goalsFor = $ranking['goalsFor'];
							 $goalsAgainst = $ranking['goalsAgainst'];
							 $goaldifference = $ranking['goaldifference'];
							 
							 
							 $publish_date = date('Y-m-d H:i:s');
							 
							 
				$insert = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantId'=>$contestantId,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );
                  
                  $update = array(
                  'league_id'=>$tournamentCalendar,
				  'sport_id'=>$sport_id,
				  'rank'=>$rank,
				  'rankStatus'=>$rankStatus,
				  'lastRank'=>$lastRank,
				  'contestantName'=>$contestantName,
				  'contestantShortName'=>$contestantShortName,  
				  'contestantClubName'=>$contestantClubName, 
				  'contestantCode'=>$contestantCode,
				  'points'=>$points,
				  'matchesPlayed'=>$matchesPlayed,
				  'matchesWon'=>$matchesWon,
				  'matchesLost'=>$matchesLost,
				  'matchesDrawn'=>$matchesDrawn,
				  'goalsFor'=>$goalsFor,
				  'goalsAgainst'=>$goalsAgainst,
				  'goaldifference'=>$goaldifference,
				  'last_update'=>$publish_date
                  );


        
			   $this->db->where('contestantId',$contestantId);
			   $q = $this->db->get('standings');

			   if ( $q->num_rows() > 0 ) 
			   {
				  $this->db->where('contestantId',$contestantId);
				  $this->db->update('standings',$update);
				  echo "Update League_Two_stat";
			   } else {
				  $this->db->set('contestantId', $contestantId);
				  $this->db->insert('standings',$insert);
				  echo "Update League_Two_stat";
			   }
		      	}
					}
						}
			}	
		
	
}
