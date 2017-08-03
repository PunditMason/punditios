<?php

class Channel_model extends CI_Model {

    public function __construct()
    {
        $this->load->database();
    }

    public function get_channel_by_id($id)
    {
        $this->db->select('*');
        $this->db->from('channel');
        $this->db->where('id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_channel()
    {
        $this->db->select('*');
        $this->db->from('channel');
        $query = $this->db->get();
        return $query->result_array();
    }

    public function get_all_channel_name()
    {
        $this->db->select('*');
        $this->db->from('channel');
        $query = $this->db->get();

        $channels = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $channels[] = $row['name'];
            }
        }
        return $channels;
    }

    function add_channel($data)
    {
        $insert = $this->db->insert('channel', $data);
        return $insert;
    }

    public function active_channel( $channel_name, $match_id, $broadcaster_id, $station ,$appName,$streamName,$channeltype)
    {
		
        $active_channel_id = 1;
        
        
        $publish_date = date("Y-m-d-H-i-s");
        
        //$station = $station."-".$publish_date;
        $streamName = $station;
        
        // check if channel is already exist
        $this->db->select('*');
        $this->db->from('channel');
        $this->db->where('name', $channel_name);
        $this->db->where('match_id', $match_id);
        $this->db->where('broadcaster_id', $broadcaster_id);
        $this->db->where('station', $station);
        $this->db->where('appName', $appName);
        $this->db->where('streamName', $streamName);
        $query = $this->db->get()->result_array();

        /*if(count($query) > 0) {
            // same channel is already exist
            $active_channel_id = $query[0]['id'];

            $this->db->select('*');
            $this->db->from('channel');
            $this->db->where('id', $active_channel_id);
            $data_to_update = array(
                'live' => '1'
            );
            $this->db->update('channel', $data_to_update);
        } else {*/
            // channel is not exist, should create new
            $data_to_store = array(
                'name' => $channel_name,
                'match_id' => $match_id,
                'station' => $station,
                'broadcaster_id' => $broadcaster_id,
                  'appName' => $appName,
                  'streamName' => $streamName,
                  'channel_type' => $channeltype,
                    'start_time' => $publish_date
                  
            );
            $this->add_channel($data_to_store);

            $this->db->select('*');
            $this->db->from('channel');
            $this->db->where('name', $channel_name);
            $this->db->where('match_id', $match_id);
            $this->db->where('broadcaster_id', $broadcaster_id);
            $this->db->where('station',$station);
            $this->db->where('appName',$appName);
            $this->db->where('streamName',$streamName);
			
            $query = $this->db->get()->result_array();

            if(count($query) > 0) {
                $active_channel_id = $query[0]['id'];
            }
        //}

        return $active_channel_id;
    }

    public function deactive_channel( $id )
    {
        $deactive_result = 'success';
        $data_to_update = array(
            'live' => '0'
        );

        if($this->update_channel($id, $data_to_update) == TRUE) {
            $deactive_result = 'success';
        } else {
            $deactive_result = 'fail';
        }

        return $deactive_result;
    }

    function update_channel($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('channel', $data);
        $report = array();
        $report['error'] = $this->db->_error_number();
        $report['message'] = $this->db->_error_message();
        if($report !== 0){
            return true;
        } else {
            return false;
        }
    }

    function delete_channel($id){
        $this->db->where('id', $id);
        $this->db->delete('channel');
    }

    function get_channel_from_match( $matches )
    {
        $channels = array();
        $match_count = count($matches);
        if($match_count > 0) {
            $this->db->select('id');
            $this->db->from('channel');
            $this->db->where('live', '1');

          /*  $where = '(match_id=' . $matches[0]['id'];
            for($i = 1; $i < $match_count; $i++) {
                $where .= ' or match_id=' . $matches[$i]['id'];
            }

            $where .= ')';
            $this->db->where($where); */

            $query = $this->db->get();
            if(count($query) > 0) {
                $channels = $query->result_array();
				
            }
        }

        return $channels;
    }
    
    public function get_listeners( $channel_id )
    {
        $this->db->select('*');
        $this->db->from('listeners');
        $this->db->where('channel_id', $channel_id);
        $query = $this->db->get();

        return $query->result_array();
    }
    
    
     function get_Channel_ByMatchId($match_id)
    {
        $channelslist = array();

         $this->db->select('c.id, c.name,c.match_id,c.broadcaster_id,c.station,c.live,c.appName,c.streamName,u.first_name,u.last_name', false);
         $this->db->from('channel as c');
         $this->db->join('user as u', 'c.broadcaster_id =u.id ', 'left');
         $this->db->where('match_id',$match_id);
         $this->db->where('live', '1');
        
       
         $query = $this->db->get();
           if(count($query) > 0) {
                $channelslist = $query->result_array();
				
            }

        return $channelslist;
    }
    
    
    public function get_all_team_name()
    {
        $this->db->select('*');
        $this->db->from('channel');
        $query = $this->db->get();
  
        $teams = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $teams[$row['id']] = $row['streamName'];
            }
        }
		 //print_r($teams);
        return $teams;
    }

    
}
?>	
