<?php
error_reporting('0');
		
 class about_model extends CI_Model {

			public function __construct()
			{
				$this->load->database();
				
			}

		   

			public function get_about()
			{
				$this->db->select('*');
				$this->db->from('tb_aboutus');
				$query = $this->db->get();
				return $query->result_array();
			}
		 public function get_about_by_id($id)
			{
				$this->db->select('*');
				$this->db->from('tb_aboutus');
				$this->db->where('id', $id);
				$query = $this->db->get();
				return $query->result_array();
			}
			
			function add_about($data)
			{
				$insert = $this->db->insert('tb_aboutus', $data);
				return $insert;
			}

			public function update_about($id, $data)
			{
				//echo $id;
		$this->db->where('id', $id);
				 $update= $this->db->update('tb_aboutus', $data);
				return $update;
			/*	$report = array();
				$report['error'] = $this->db->error();
				$report['message'] = $this->db->error();
				if($report != 0){
					return true;
				}else{
					return false;
				}*/
			}

			function delete_about($id){
				$this->db->where('id', $id);
				$this->db->delete('tb_aboutus');
			}

			
		}
?>
