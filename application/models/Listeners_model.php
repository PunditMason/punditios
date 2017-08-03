<?php
class Listeners_model extends CI_Model {

    public function __construct()
    {
        $this->load->database();
    }

    public function get_listeners($channel_id)
    {
        $this->db->select('*');
        $this->db->from('listeners');
        $this->db->where('channel_id', $channel_id);
        $query = $this->db->get();

        return $query->result_array();
    }

    public function active( $channel_id, $listener_id )
    {
        $active_listener_id = '1';

        // check if listener is already exist on channel
        $this->db->select('*');
        $this->db->from('listeners');
        $this->db->where('channel_id', $channel_id);
        $this->db->where('user_id', $listener_id);
        $query = $this->db->get();
		$data_to_store = array(
                'channel_id' => $channel_id,
                'user_id' => $listener_id
            );
            $this->add($data_to_store);

        if(count($query) > 0) {
            // listener is already exist
            foreach( $query->result_array() as $row ) {
                $active_listener_id = $row['id'];
            }
        } else {
            // channel is not exist, should create new
            $data_to_store = array(
                'channel_id' => $channel_id,
                'user_id' => $listener_id
            );
            $this->add($data_to_store);
            $this->db->select('*');
            $this->db->from('listeners');
            $this->db->where('channel_id', $channel_id);
            $this->db->where('user_id', $listener_id);
            $query = $this->db->get();

            if(count($query) > 0) {
                // listener is already exist
                foreach( $query->result_array() as $row ) {
                    $active_listener_id = $row['id'];
                }
            }
        }

        return $active_listener_id;
    }

    function add($data)
    {
        $insert = $this->db->insert('listeners', $data);

        $listener_id =  array(
            'data_id' => $insert
        );

        return $listener_id;
    }

    function update($id, $data)
    {
        $this->db->where('channel_id', $id);
        $this->db->update('listeners', $data);
        $report = array();
        $report['error'] = $this->db->_error_number();
        $report['message'] = $this->db->_error_message();
        if($report !== 0){
            return true;
        } else {
            return false;
        }
    }

    function delete($id)
    {
        $this->db->where('channel_id', $id);
        $this->db->delete('listeners');
    }

    function count()
    {
        //
    }
}
