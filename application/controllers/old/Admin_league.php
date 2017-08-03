<?php

class Admin_League extends CI_Controller {

    private $sports;
    private $sports_icon;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('League_model');

        if(!$this->session->userdata('is_logged_in')){
            redirect('admin/login');
        }
    }

    function get_sports() {
        if(!$this->sports) {
            $this->load->model("Sport_model");
            $this->sports = $this->Sport_model->get_all_sport_name_indexed();
        }

        return $this->sports;
    }

    function get_sports_icon() {
        if(!$this->sports_icon) {
            $this->load->model("Sport_model");
            $this->sports_icon = $this->Sport_model->get_all_sport_icon_indexed();
        }

        return $this->sports_icon;
    }

    private function uploadImageFile($file_name) {
        $upload_file_name = '';

        $config = array(
            'upload_path' => realpath(APPPATH . '../assets/img/league_mark'),
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
        $data['league'] = $this->League_model->get_all_league();
        $data['sports_icon'] = $this->get_sports_icon();

        //load the view
        $data['main_content'] = 'admin/league/list';
        $this->load->view('includes/template', $data);

    }//index

    public function add()
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // league mark file upload
            $upload_file_name = $this->uploadImageFile('league_mark');

            //form validation
            $this->form_validation->set_rules('league_name', 'League Name', 'required');
            $this->form_validation->set_rules('league_mark', 'League Mark', '');
            $this->form_validation->set_rules('sport_id', 'Sport Index', 'required');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'name' => $this->input->post('league_name'),
                    'sport_id' => $this->input->post('sport_id')
                );
                if(!empty($upload_file_name)) {
                    $data_to_store['mark_image'] = $upload_file_name;
                }

                //if the insert has returned true then we show the flash message
                if($this->League_model->add_league($data_to_store)) {
                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            }
        }
        //load the view
        $data['sports'] = $this->get_sports();
        $data['main_content'] = 'admin/league/add';
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
            $upload_file_name = $this->uploadImageFile('league_mark');

            //form validation
            $this->form_validation->set_rules('league_name', 'League Name', 'required');
            $this->form_validation->set_rules('league_mark', 'League Mark', '');
            $this->form_validation->set_rules('sport_id', 'Sport Index', 'required');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');
            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'name' => $this->input->post('league_name'),
                    'sport_id' => $this->input->post('sport_id')
                );
                if(!empty($upload_file_name)) {
                    $data_to_store['mark_image'] = $upload_file_name;
                }

                //if the insert has returned true then we show the flash message
                if($this->League_model->update_league($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/league/update/' . $id . '');

            }//validation run
        }

        $data['league'] = $this->League_model->get_league_by_id($id);
        $data['sports'] = $this->get_sports();
        $data['main_content'] = 'admin/league/edit';

        $this->load->view('includes/template', $data);

    }//update

    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->League_model->delete_league($id);
        redirect('admin/league');
    }//edit

}