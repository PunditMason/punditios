<?php
error_reporting(1);
class Admin_sport extends CI_Controller {

    public function __construct()
    {
        parent::__construct();
       
		 $this->load->database();
        $this->load->helper(array('form', 'url'));
        $this->load->model('Sport_model');

        if(!$this->session->userdata('is_logged_in')){
            redirect('admin/login');
        }
    }

    public function index()
    {
        $data['sport'] = $this->Sport_model->get_all_sport();

        //load the view
        $data['main_content'] = 'admin/sport/list';
        $this->load->view('includes/template', $data);

    }//index
 public function do_upload() { 
         $config['upload_path']   = './assets/img/icons'; 
         $config['allowed_types'] = 'gif|jpg|png'; 
         $config['max_size']      = 5000; 
         $config['max_width']     = 5000; 
         $config['max_height']    = 5000;  
         $this->load->library('upload', $config);
	     $this->upload->do_upload();
	     $detail = $this->upload->data();
	     
         if ( ! $this->upload->do_upload('userfile')) {
            $error = array('error' => $this->upload->display_errors()); 
           // $this->load->view('admin/sport/add', $error); 
         }
			
         else { 
	
    $image_path=$this->upload->data();
    $file_name=$image_path['file_name'];

            $data = array(
			'avatar' => $file_name
			); 
			
			$this->Sport_model->add_sport($data);
            //$this->load->view('upload_success', $data); 
         } 
      } 
    private function uploadImageFile($file_name) {
        $upload_file_name = '';

        $config = array(
      //      'upload_path' => realpath(APPPATH . '../assets/img/icons'),
          'upload_path' =>  './assets/img/icons',
            'allowed_types' => "gif|jpg|png|jpeg|pdf",
            'overwrite' => TRUE,
            'max_size' => "2048000", // Can be set to particular file size , here it is 2 MB(2048 Kb)
            'max_height' => "7968",
            'max_width' => "5024"
        );
        $this->load->library('upload', $config);
        if($this->upload->do_upload($file_name)) {
            $upload_data = $this->upload->data(); //Returns array of containing all of the data related to the file you uploaded.
            $upload_file_name = $upload_data['file_name'];
        }

        return $upload_file_name;
    }
    
    public function iosuploadImageFile($file_name) {
		   
		   
        $upload_file_name = '';

        $config = array(
            'upload_path' => './assets/img/ios_icons',
            'allowed_types' => "gif|jpg|png|jpeg|pdf",
            'overwrite' => TRUE,
            'max_size' => "2048000", // Can be set to particular file size , here it is 2 MB(2048 Kb)
            'max_height' => "5000",
            'max_width' => "5000"
        );
        $this->load->library('upload', $config);
        $this->upload->initialize($config);
        
        if($this->upload->do_upload($file_name)) {
            $upload_data = $this->upload->data(); //Returns array of containing all of the data related to the file you uploaded.
            $upload_file_name = $upload_data['file_name'];
        }
        
      //  print_r($error); 
      //  print_r($upload_file_name); die();

        return $upload_file_name;
    }

    public function add() 
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // file upload
           
            $upload_file_name = $this->uploadImageFile('avatar');
              $upload_file_name1 = $this->uploadImageFile('cover_image');
            $upload_file_name2 = $this->iosuploadImageFile('ios_icon');
            
          
             $upload_file_name3 = $this->iosuploadImageFile('ios_cover_image');
            
            
            //form validation
            $this->form_validation->set_rules('id', 'Sport Id', 'required');
            $this->form_validation->set_rules('sport_name', 'Sport Name', 'required');
            $this->form_validation->set_rules('sport_icon', 'Sport Icon', '');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
           if ($this->form_validation->run())
           {
                $data_to_store = array(
                  'id' => $this->input->post('id'),
                      'position' => $this->input->post('position'),
                    'name' => $this->input->post('sport_name')
                );
                if(!empty($upload_file_name)) {
                    $data_to_store['avatar'] = $upload_file_name;
                }
                if(!empty($upload_file_name2)) {
                    $data_to_store['ios_icon'] = $upload_file_name2;
                }
                 if(!empty($upload_file_name1)) {
                    $data_to_store['cover_image'] = $upload_file_name1;
                }
                 if(!empty($upload_file_name3)) {
                    $data_to_store['ios_cover_image'] = $upload_file_name3;
                }
                //if the insert has returned true then we show the flash message
                if($this->Sport_model->add_sport($data_to_store)) {

                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            }
          
        }
        //load the view
        $data['main_content'] = 'admin/sport/add';
        $this->load->view('includes/template', $data);
    }

    public function update()
    {
        //product id 
        $id = $this->uri->segment(4);

        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // file upload
           $upload_file_name = $this->uploadImageFile('avatar');
            $upload_file_name1 = $this->uploadImageFile('cover_image');
            $upload_file_name2 = $this->iosuploadImageFile('ios_icon');
            
           
             $upload_file_name3 = $this->iosuploadImageFile('ios_cover_image');

            //form validation
            $this->form_validation->set_rules('id', 'Sport Id', 'required');
            $this->form_validation->set_rules('sport_name', 'Sport Name', 'required');
          //  $this->form_validation->set_rules('sport_icon', 'Sport Icon', '');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');
            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                   'id' => $this->input->post('id'),
                       'position' => $this->input->post('position'),
                    'name' => $this->input->post('sport_name')
                );
                if(!empty($upload_file_name)) {
                    $data_to_store['avatar'] = $upload_file_name;
                }
                if(!empty($upload_file_name2)) {
                    $data_to_store['ios_icon'] = $upload_file_name2;
                }
                 if(!empty($upload_file_name1)) {
                    $data_to_store['cover_image'] = $upload_file_name1;
                }
                 if(!empty($upload_file_name3)) {
                    $data_to_store['ios_cover_image'] = $upload_file_name3;
                }
            
                //if the insert has returned true then we show the flash message
                if($this->Sport_model->update_sport($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                  
                redirect('admin/sport/update/' . $id . '');

            }//validation run
        }

        //sport data
        $data['sport'] = $this->Sport_model->get_sport_by_id($id);
        //load the view
        $data['main_content'] = 'admin/sport/edit';
        $this->load->view('includes/template', $data);

    }//update

    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->Sport_model->delete_sport($id);
        redirect('admin/sport');
    }//edit

}
