<?php

class Admin_banner extends CI_Controller {

   
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Banner_model');

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
            'max_size' => "2048000", // Can be set to particular file size , here it is 2 MB(2048 Kb)
            'max_height' => "5000",
            'max_width' => "5000"
        );
        $this->load->library('upload', $config);
        if($this->upload->do_upload($file_name)) {
            $upload_data = $this->upload->data(); //Returns array of containing all of the data related to the file you uploaded.
            $upload_file_name = $upload_data['file_name'];
        }

        return $upload_file_name;
    }
    

    public function index()
    {
		$data['banner'] = $this->Banner_model->get_banner();
        //load the view
        $data['main_content'] = 'admin/banner/list';
        $this->load->view('includes/template', $data);

    }//index

    public function add()
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // league mark file upload
            $background = $this->uploadImageFile('background');
            $listeners = $this->uploadImageFile('listeners');
            $broadcaster = $this->uploadImageFile('broadcaster');
            $setting = $this->uploadImageFile('setting');
            $about = $this->uploadImageFile('about');
            $profile = $this->uploadImageFile('profile');
            //$this->form_validation->set_rules('id', 'Sport Name', 'required');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
         //   if ($this->form_validation->run())
          //  {
				
               
                if(!empty($background)) {
                    $data_to_store['background'] = $background;
                }
                if(!empty($listeners)) {
                    $data_to_store['listeners'] = $listeners;
                }
                
                 if(!empty($broadcaster)) {
                    $data_to_store['broadcaster'] = $broadcaster;
                }
                
                if(!empty($setting)) {
                    $data_to_store['setting'] = $setting;
                }
                if(!empty($about)) {
                    $data_to_store['about'] = $about;
                }
                
                if(!empty($profile)) {
                    $data_to_store['profile'] = $profile;
                }
            
                
              

                //if the insert has returned true then we show the flash message
                if($this->Banner_model->add_banner($data_to_store)) {
                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            //}
        }
        //load the view
        $data['main_content'] = 'admin/banner/add';
        $this->load->view('includes/template', $data);
    }

    public function update()
    {
        //product id
        $id = $this->uri->segment(4);

        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // league mark file upload
            $background = $this->uploadImageFile('background');
            $listeners = $this->uploadImageFile('listeners');
            $broadcaster = $this->uploadImageFile('broadcaster');
            $setting = $this->uploadImageFile('setting');
            $about = $this->uploadImageFile('about');
            $profile = $this->uploadImageFile('profile');
             $login = $this->uploadImageFile('login');
            $settingicon = $this->uploadImageFile('settingicon');
            $abouticon = $this->uploadImageFile('abouticon');
            $profileicon = $this->uploadImageFile('profileicon');
             $loginicon = $this->uploadImageFile('loginicon');
          //if the form has passed through the validation
       //    if ($this->form_validation->run())
         //   {
         
                 if(!empty($background)) {
                    $data_to_store['background'] = $background;
                }
                if(!empty($listeners)) {
                    $data_to_store['listeners'] = $listeners;
                }
                
                 if(!empty($broadcaster)) {
                    $data_to_store['broadcaster'] = $broadcaster;
                }

                if(!empty($setting)) {
                    $data_to_store['setting'] = $setting;
                }
                if(!empty($about)) {
                    $data_to_store['about'] = $about;
                }
                
                if(!empty($profile)) {
                    $data_to_store['profile'] = $profile;
                }
                
                 if(!empty($login)) {
                    $data_to_store['login'] = $login;
                }
                
                     if(!empty($settingicon)) {
                    $data_to_store['settingicon'] = $settingicon;
                }
                if(!empty($abouticon)) {
                    $data_to_store['abouticon'] = $abouticon;
                }
                
                if(!empty($profileicon)) {
                    $data_to_store['profileicon'] = $profileicon;
                }
                
                 if(!empty($loginicon)) {
                    $data_to_store['loginicon'] = $loginicon;
                }
                //if the insert has returned true then we show the flash message
                if($this->Banner_model->update_banner($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }
                else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/banner/update/'. $id .'');

          // }//validation run
        }

        $data['banner'] = $this->Banner_model->get_banner_id($id);
        $data['main_content'] = 'admin/banner/edit';

        $this->load->view('includes/template', $data);

    }//update
    
     public function updateiosimage()
    {
        //product id
        $id = $this->uri->segment(4);

        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // league mark file upload
            $background = $this->uploadImageFile('background');
            $listeners = $this->uploadImageFile('listeners');
            $broadcaster = $this->uploadImageFile('broadcaster');
            $setting = $this->uploadImageFile('setting');
            $about = $this->uploadImageFile('about');
            $profile = $this->uploadImageFile('profile');
             $login = $this->uploadImageFile('login');
            $settingicon = $this->uploadImageFile('settingicon');
            $abouticon = $this->uploadImageFile('abouticon');
            $profileicon = $this->uploadImageFile('profileicon');
             $loginicon = $this->uploadImageFile('loginicon');
          //if the form has passed through the validation
       //    if ($this->form_validation->run())
         //   {
         
                 if(!empty($background)) {
                    $data_to_store['background'] = $background;
                }
                if(!empty($listeners)) {
                    $data_to_store['listeners'] = $listeners;
                }
                
                 if(!empty($broadcaster)) {
                    $data_to_store['broadcaster'] = $broadcaster;
                }

                if(!empty($setting)) {
                    $data_to_store['setting'] = $setting;
                }
                if(!empty($about)) {
                    $data_to_store['about'] = $about;
                }
                
                if(!empty($profile)) {
                    $data_to_store['profile'] = $profile;
                }
                
                 if(!empty($login)) {
                    $data_to_store['login'] = $login;
                }
                
                     if(!empty($settingicon)) {
                    $data_to_store['settingicon'] = $settingicon;
                }
                if(!empty($abouticon)) {
                    $data_to_store['abouticon'] = $abouticon;
                }
                
                if(!empty($profileicon)) {
                    $data_to_store['profileicon'] = $profileicon;
                }
                
                 if(!empty($loginicon)) {
                    $data_to_store['loginicon'] = $loginicon;
                }
                //if the insert has returned true then we show the flash message
                if($this->Banner_model->update_banner($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }
                else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/banner/update/'. $id .'');

          // }//validation run
        }

        $data['banner'] = $this->Banner_model->get_banner_id($id);
        $data['main_content'] = 'admin/banner/edit';

        $this->load->view('includes/template', $data);

    }//update

    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->Banner_model->delete_banner($id);
        redirect('admin/banner');
    }//edit

}
