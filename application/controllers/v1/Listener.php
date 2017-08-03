<?php
error_reporting('0');
class Listener extends CI_Controller {

    public function __construct(){
								
						parent::__construct();
						 $this->load->database();
								  
									
							}
							
	public function listeners_mount($user_id,$channel_id){
		
			$this->load->model('Listeners_model');
			
			$data = array(
			'user_id' => $user_id,
			'channel_id' => $channel_id
			
			);
			
			$result = $this->Listeners_model->insert_listeners($data);
		      
		      
		      if ($result){
				  
				  echo "inserted successfully";
			  }
			  
			  else{
				  echo "please try again";
			  }
								
				}		
				
		public function listeners_unmount($id){
			
		
			$this->load->model('Listeners_model');
			$result = $this->Listeners_model->delete_listeners($id);
			
			if($result){
				$array = array('msg' => 'deleted succesfully');
				
			}
			
			else{
				$array = array('msg' => 'try again');
				
			}
			
			echo json_encode($array);
		}		
					

    public function get_listeners_channel( )
    {
		echo "listeners";
		
		$this->load->model('Listeners_model');
        echo $listener_list = $this->Listeners_model->get_listeners_count();

       
    }

  /*  public function add( $channel_id, $listener_id )
    {
        $this->load->model('Listeners_model');
        $listener_id = $this->Listeners_model->active($channel_id, $listener_id);
       
        $array = array('data' => $listener_id);
        echo json_encode($array);
    }

    public function del( $listener_id )
    {
        $this->load->model('Listeners_model');
        $this->Listeners_model->delete($listener_id);
    }*/
}
?>
