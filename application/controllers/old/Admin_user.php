<?php

class Admin_user extends CI_Controller {

    private $countries;
    private $national_flags;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Users_model');

        if(!$this->session->userdata('is_logged_in')){
            redirect('admin/login');
        }
    }

    function get_countries() {
        if(!$this->countries) {
            $this->load->model("Country_model");
            $this->countries = $this->Country_model->get_all_countries();
        }

        return $this->countries;
    }

    function get_national_flags() {
        if(!$this->national_flags) {
            $this->load->model("Country_model");
            $this->national_flags = $this->Country_model->get_all_national_flags();
        }

        return $this->national_flags;
    }

    private function uploadImageFile($file_name, $target_dir) {
        $upload_file_name = '';

        $config = array(
            'upload_path' => realpath(APPPATH . '../assets/img/' . $target_dir),
            'allowed_types' => "gif|jpg|png|jpeg|pdf",
            'overwrite' => TRUE,
            'max_size' => "2048000", // Can be set to particular file size , here it is 2 MB(2048 Kb)
            'max_height' => "768",
            'max_width' => "1024"
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
        $data['users'] = $this->Users_model->get_all_user();
        $data['national_flags'] = $this->get_national_flags();

        //load the view
        $data['main_content'] = 'admin/user/list';
        $this->load->view('includes/template', $data);

    }//index

    public function add()
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // league mark file upload
            $upload_avatar = $this->uploadImageFile('avatar', 'avatar');
            $upload_cover_photo = $this->uploadImageFile('cover_photo', 'cover_photo');

            //form validation
            $this->form_validation->set_rules('first_name', 'First Name', 'trim|required');
            $this->form_validation->set_rules('last_name', 'Last Name', 'trim|required');
            $this->form_validation->set_rules('email_address', 'Email Address', 'trim|required|valid_email');
            $this->form_validation->set_rules('password', 'Password', 'trim|required|min_length[4]|max_length[32]');
            $this->form_validation->set_rules('password2', 'Password Confirmation', 'trim|required|matches[password]');
            $this->form_validation->set_rules('avatar', 'Avatar', '');
            $this->form_validation->set_rules('cover_photo', 'Cover Photo', '');
            $this->form_validation->set_rules('country', 'Country/Region', 'required');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'first_name' => $this->input->post('first_name'),
                    'last_name' => $this->input->post('last_name'),
                    'email' => $this->input->post('email_address'),
                    'password' => md5($this->input->post('password')),
                    'country_id' => $this->input->post('country')
                );
                if(!empty($upload_avatar)) {
                    $data_to_store['avatar'] = $upload_avatar;
                }
                if(!empty($upload_cover_photo)) {
                    $data_to_store['cover_photo'] = $upload_cover_photo;
                }

                //if the insert has returned true then we show the flash message
                if($this->Users_model->add_user($data_to_store)) {
                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            }
        }
        //load the view
        $data['main_content'] = 'admin/user/add';
        $data['countries'] = $this->get_countries();
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
            $upload_avatar = $this->uploadImageFile('avatar', 'avatar');
            $upload_cover_photo = $this->uploadImageFile('cover_photo', 'cover_photo');

            //form validation
            $this->form_validation->set_rules('first_name', 'First Name', 'trim|required');
            $this->form_validation->set_rules('last_name', 'Last Name', 'trim|required');
            $this->form_validation->set_rules('email_address', 'Email Address', 'trim|required|valid_email');
            $this->form_validation->set_rules('password', 'Password', 'trim|required|min_length[4]|max_length[32]');
            $this->form_validation->set_rules('password2', 'Password Confirmation', 'trim|required|matches[password]');
            $this->form_validation->set_rules('avatar', 'Avatar', '');
            $this->form_validation->set_rules('cover_photo', 'Cover Photo', '');
            $this->form_validation->set_rules('country', 'Country/Region', 'required');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');
            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'first_name' => $this->input->post('first_name'),
                    'last_name' => $this->input->post('last_name'),
                    'email' => $this->input->post('email_address'),
                    'password' => md5($this->input->post('password')),
                    'country_id' => $this->input->post('country')
                );
                if(!empty($upload_avatar)) {
                    $data_to_store['avatar'] = $upload_avatar;
                }
                if(!empty($upload_cover_photo)) {
                    $data_to_store['cover_photo'] = $upload_cover_photo;
                }

                //if the insert has returned true then we show the flash message
                if($this->Users_model->update_user($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/user/update/' . $id . '');

            }//validation run
        }

        $data['users'] = $this->Users_model->get_user_by_id($id);
        $data['countries'] = $this->get_countries();
        $data['main_content'] = 'admin/user/edit';

        $this->load->view('includes/template', $data);

    }//update

    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->Users_model->delete_user($id);
        redirect('admin/user');
    }//edit

}