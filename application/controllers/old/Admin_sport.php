<?php

class Admin_sport extends CI_Controller {

    public function __construct()
    {
        parent::__construct();
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

    private function uploadImageFile($file_name) {
        $upload_file_name = '';

        $config = array(
            'upload_path' => realpath(APPPATH . '../assets/img/icons'),
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

    public function add()
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // file upload
            $upload_file_name = $this->uploadImageFile('sport_icon');

            //form validation
            $this->form_validation->set_rules('sport_name', 'Sport Name', 'required');
            $this->form_validation->set_rules('sport_icon', 'Sport Icon', '');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'name' => $this->input->post('sport_name')
                );
                if(!empty($upload_file_name)) {
                    $data_to_store['avatar'] = $upload_file_name;
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
            $upload_file_name = $this->uploadImageFile('sport_icon');

            //form validation
            $this->form_validation->set_rules('sport_name', 'Sport Name', 'required');
            $this->form_validation->set_rules('sport_icon', 'Sport Icon', '');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');
            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'name' => $this->input->post('sport_name')
                );
                if(!empty($upload_file_name)) {
                    $data_to_store['avatar'] = $upload_file_name;
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