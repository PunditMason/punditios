<?php

class Users_model extends CI_Model {

    /**
    * Validate the login's data with the database
    * @param string $email
    * @param string $password
    * @return user name
    */
	function validate($email, $password)
	{
		$this->db->where('email', $email);
		$this->db->where('password', $password);
		$query = $this->db->get('user');
		
		if($query->num_rows == 1)
		{
			$val = $query->result_array();
			$user_full_name = $val[0]['first_name'] . ' ' .$val[0]['last_name'];
			return $user_full_name;
		}
	}

	function get_all_user()
	{
        $this->db->select('*');
        $this->db->from('user');
        $query = $this->db->get();
        return $query->result_array();
	}

	function get_all_user_name()
	{
        $this->db->select('*');
        $this->db->from('user');
        $query = $this->db->get();

        $user_full_name = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $user_full_name[] = $row['first_name'] . ' ' . $row['last_name'];
            }
        }
        return $user_full_name;
	}

    function get_all_user_name_indexed()
    {
        $this->db->select('*');
        $this->db->from('user');
        $query = $this->db->get();

        $user_full_name = array();
        if(count($query) > 0) {
            foreach( $query->result_array() as $row ) {
                $user_full_name[$row['id']] = $row['first_name'] . ' ' . $row['last_name'];
            }
        }
        return $user_full_name;
    }

    /**
    * Serialize the session data stored in the database, 
    * store it in a new array and return it to the controller 
    * @return array
    */
	function get_db_session_data()
	{
		$query = $this->db->select('user_data')->get('ci_sessions');
		$user = array(); /* array to store the user data we fetch */
		foreach ($query->result() as $row)
		{
		    $udata = unserialize($row->user_data);
		    /* put data in array using username as key */
		    $user['first_name'] = $udata['first_name'];
			$user['is_logged_in'] = $udata['is_logged_in'];
		}
		return $user;
	}
	
    /**
    * Store the new user's data into the database
    * @return boolean - check the insert
    */	
	function create_user()
	{

		$this->db->where('email', $this->input->post('email_address'));
		$query = $this->db->get('user');

        if($query->num_rows > 0){
        	echo '<div class="alert alert-error"><a class="close" data-dismiss="alert">×</a><strong>';
			echo "Email already taken";
			echo '</strong></div>';
		} else {

			$new_member_insert_data = array(
				'first_name' => $this->input->post('first_name'),
				'last_name' => $this->input->post('last_name'),
				'email' => $this->input->post('email_address'),
				'password' => md5($this->input->post('password')),
				'country_id' => $this->input->post('country')
			);
			$insert = $this->db->insert('user', $new_member_insert_data);
		    return $insert;
		}
	      
	}//create_user

    public function get_user_by_id($id)
    {
        $this->db->select('*');
        $this->db->from('user');
        $this->db->where('id', $id);
        $query = $this->db->get();
        return $query->result_array();
    }

    function add_user($data)
    {
        $insert = $this->db->insert('user', $data);
        return $insert;
    }

    function update_user($id, $data)
    {
        $this->db->where('id', $id);
        $update = $this->db->update('user', $data);
        return $update;
       /* $report = array();
        $report['error'] = $this->db->_error_number();
        $report['message'] = $this->db->_error_message();
        if($report !== 0){
            return true;
        }else{
            return false;
        }*/
    }

    function delete_user($id){
        $this->db->where('id', $id);
        $this->db->delete('user');
    }

    //--> Mobile API
	public function add( $name = '', $email = '' ,$cover_photo, $facebook,$twitter,$youtube )
	{
        $names = explode(" ", $name);
        $first_name = '';
        $last_name = '';

        $first_name = $names[0];
        if(count($names) > 1) {
            $last_name = $names[1];
        }
		$data = array(
			'first_name' => $first_name,
            'last_name' => $last_name,
			'email' => $email,
			'cover_photo' => $cover_photo,
			'facebook' => $facebook,
			'twitter' => $twitter,
			'youtube' => $youtube
		);

		$this->db->insert('user', $data);
	}
	public function update( $name = '', $email = '' ,$cover_photo, $facebook,$twitter,$youtube ) {
        $names = explode(" ", $name);
        $first_name = '';
        $last_name = '';

        $first_name = $names[0];
        if(count($names) > 1) {
            $last_name = $names[1];
        }
		
	
				
		$data = array(
			'first_name' => $first_name,
            'last_name' => $last_name,
			'email' => $email,
			'cover_photo' => $cover_photo,
			'facebook' => $facebook,
			'twitter' => $twitter,
			'youtube' => $youtube
		); 

        $this->db->where('email', $email);
       if( $this->db->update('user', $data)){
		 
		 return 'Success';  
		   
		}   
				
		else return 'failed';		
   
}

	public function login( $name = '', $email = '', $cover_photo, $facebook = '', $twitter ='',$youtube ='' )
	{
		$user = array();
		$this->db->select('*');
		$this->db->from('user');
//		$this->db->where('name', $name);
		$this->db->where('email', $email);
		$query = $this->db->get()->result_array();

	

		if(count($query) > 0) {
					$this->update($name, $email,$cover_photo,$facebook,$twitter,$youtube);
					$this->db->select('*');
			$this->db->from('user');

			$this->db->where('email', $email);
			$query = $this->db->get()->result_array();

			if(count($query) > 0) {
               // $user = $query[0]['id'];
			   	foreach($query as $res)
            {
				$user[]=$res;
			}
				}
				
				
            
			
		} else {
			//Add new user
			$this->add($name, $email,$cover_photo,$facebook,$twitter,$youtube);

			//Query again
			$this->db->select('*');
			$this->db->from('user');
//			$this->db->where('name', $name);
			$this->db->where('email', $email);
			$query = $this->db->get()->result_array();

			foreach($query as $result){
				$user[] = $result;
			}
		}

		return $user;
	}


     public function activation()
{

        $this->db->select('*');
        $this->db->from('active_users');
        // $this->db->where('email', $email);
        $query = $this->db->get()->result_array();
        return $query;


}

    function create_activation($new_member_insert_data)
    {
      
        $this->db->where('matchID', $this->input->post('matchID'));
        $query = $this->db->get('active_users');

        if($query->num_rows > 0){
            echo '<div class="alert alert-error"><a class="close" data-dismiss="alert">×</a><strong>';
            echo "MatchID already taken";
            echo '</strong></div>';
        } else {

            // $new_member_insert_data = array(
            //     'userName' => $this->input->post('userName'),
            //     'appName' => $this->input->post('appName'),
            //     'streamName' => $this->input->post('streamName'),
            //     'matchID' => $this->input->post('matchID'),
            //     'matchBetween' => $this->input->post('matchBetween'),
            //     'startDate' => $this->input->post('startDate'),
            //     'Activation' => $this->input->post('Activation')
            // );

            
            $insert = $this->db->insert('active_users', $new_member_insert_data);
            return $insert;
        }

}

}

