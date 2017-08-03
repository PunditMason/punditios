<?php

class Fbshare_model extends CI_Model
{
  function __construct()
  {
 
  parent::__construct();    
  }




         function fbshare($contestantId){
       
        $league_stat = array();
        
        $this->db->select('*');
        $this->db->from('league_ranking');
       
        $query = $this->db->get();
           if(count($query) > 0) {
                $league_stat = $query->result_array();
				
            }

        return $league_stat;

          
          }
}

?>
