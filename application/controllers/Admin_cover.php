<?php

class Admin_cover extends CI_Controller {

   
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Cover_model');

        if(!$this->session->userdata('is_logged_in')){
            redirect('admin/login');
        }
    }

    
    private function uploadImageFile($file_name) {
        $upload_file_name = '';

        $config = array(
            'upload_path' => './assets/img/icons',
            'allowed_types' => "gif|jpg|png|jpeg|pdf",
            'overwrite' => TRUE, 
            
            'max_size' => "2680000", // Can be set to particular file size , here it is 2 MB(2048 Kb)
            'max_height' => "5000",
            'max_width' => "5000"
        );
        $this->load->library('upload', $config);
       
        if($this->upload->do_upload($file_name)) {
            $upload_data = $this->upload->data(); //Returns array of containing all of the data related to the file you uploaded.
            $upload_file_name = $upload_data['file_name'];
        }
        else
                {
                         $error = array('error' => $this->upload->display_errors());

                         
                }

        return $upload_file_name;
    }

    public function index()
    {
		$data['cover'] = $this->Cover_model->get_cover();
        //load the view
        $data['main_content'] = 'admin/cover/list';
        $this->load->view('includes/template', $data);

    }//index

    public function add()
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // league mark file upload
            $background = $this->uploadImageFile('cover_image');
             $background = $this->uploadImageFile('background_image');
            
           //form validation
            $this->form_validation->set_rules('name', 'Name', 'trim|required');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
           if ($this->form_validation->run())
            {
				$data_to_store = array(
                    'name' => $this->input->post('name')
                    
                );
               
                if(!empty($background)) {
                    $data_to_store['cover_image'] = $background;
                }
                 if(!empty($background)) {
                    $data_to_store['background_image'] = $background;
                }
                
            
                
              

                //if the insert has returned true then we show the flash message
                if($this->Cover_model->add_cover($data_to_store)) {
                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            }
        }
        //load the view
        $data['main_content'] = 'admin/cover/add';
        $this->load->view('includes/template', $data);
    }

    
    public function update()
    {
        //product id
        $id = $this->uri->segment(4);

        //if save button was clicked, get the data sent via post
        
            // league mark file upload
          $background = $this->uploadImageFile('cover_image');
              $background1 = $this->uploadImageFile('background_image');
            if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            //form validation
            $this->form_validation->set_rules('name', 'Channel Name', 'required');
          
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');
            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                      'name' => $this->input->post('name')
                );
          //if the form has passed through the validation
       //    if ($this->form_validation->run())
         //   {
                 if(!empty($background)) {
                    $data_to_store['cover_image'] = $background;
                }
                if(!empty($background1)) {
                    $data_to_store['background_image'] = $background1;
                }
                
                
                //if the insert has returned true then we show the flash message
                if($this->Cover_model->update_cover($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }
                else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/cover/update/'. $id .'');

           }//validation run
        }

        $data['cover'] = $this->Cover_model->get_cover_id($id);
        $data['main_content'] = 'admin/cover/edit';

        $this->load->view('includes/template', $data);

    }//update


    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->Cover_model->delete_cover($id);
        redirect('admin/cover');
    }//edit

}
