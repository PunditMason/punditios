<?php

class Admin_team extends CI_Controller {

    private $countries;
    private $national_flags;
    private $sports;
    private $sports_icon;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Team_model');

        if(!$this->session->userdata('is_logged_in')){
            redirect('admin/login');
        }
    }

    function get_national_flags() {
        if(!$this->national_flags) {
            $this->load->model("Country_model");
            $this->national_flags = $this->Country_model->get_all_national_flags();
        }

        return $this->national_flags;
    }

    function get_countries() {
        if(!$this->countries) {
            $this->load->model("Country_model");
            $this->countries = $this->Country_model->get_all_countries();
        }

        return $this->countries;
    }

    function get_sports_icon() {
        if(!$this->sports_icon) {
            $this->load->model("Sport_model");
            $this->sports_icon = $this->Sport_model->get_all_sport_icon_indexed();
        }

        return $this->sports_icon;
    }

    function get_sports() {
        if(!$this->sports) {
            $this->load->model("Sport_model");
            $this->sports = $this->Sport_model->get_all_sport_name_indexed();
        }

        return $this->sports;
    }

    private function uploadImageFile($file_name) {
        $upload_file_name = '';

        $config = array(
        
            'upload_path' =>'./assets/img/team_mark/', 
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
        $data['team'] = $this->Team_model->get_all_team();
        $data['national_flags'] = $this->get_national_flags();
        $data['sports_icon'] = $this->get_sports_icon();

        //load the view
        $data['main_content'] = 'admin/team/list';
        $this->load->view('includes/template', $data);

    }//index

    public function add()
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // team mark file upload
            $upload_file_name = $this->uploadImageFile('team_mark');

            //form validation
            $this->form_validation->set_rules('team_id', 'Team Id', 'required');
            $this->form_validation->set_rules('team_name', 'Team Name', 'required');
            $this->form_validation->set_rules('country_id', 'Country Index', 'required');
            $this->form_validation->set_rules('team_mark', 'Team Mark', '');
           // $this->form_validation->set_rules('sport_id', 'Sport Index', 'required');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                   'id' => $this->input->post('team_id'),
                    'name' => $this->input->post('team_name'),
                    'country_id' => $this->input->post('country_id'),
                    'sport_id' => $this->input->post('sport_id')
                );
                if(!empty($upload_file_name)) {
                    $data_to_store['mark_image'] = $upload_file_name;
                }

                //if the insert has returned true then we show the flash message
                if($this->Team_model->add_team($data_to_store)) {
                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            }
        }
        //load the view
        $data['countries'] = $this->get_countries();
        $data['sports'] = $this->get_sports();
        $data['main_content'] = 'admin/team/add';
        $this->load->view('includes/template', $data);
    }

    public function update()
    {
        //product id 
        $id = $this->uri->segment(4);

        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            // team mark file upload
            $upload_file_name = $this->uploadImageFile('team_mark');

            //form validation
           
            $this->form_validation->set_rules('team_name', 'Team Name', 'required');
            $this->form_validation->set_rules('country_id', 'Country Index', 'required');
            $this->form_validation->set_rules('team_mark', 'Team Mark', '');
          //  $this->form_validation->set_rules('sport_id', 'Sport Index', 'required');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');
            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'id' => $this->input->post('team_id'),
                    'name' => $this->input->post('team_name'),
                    'country_id' => $this->input->post('country_id'),
                    'sport_id' => $this->input->post('sport_id')
                );
                if(!empty($upload_file_name)) {
                    $data_to_store['mark_image'] = $upload_file_name;
                }

                //if the insert has returned true then we show the flash message
                if($this->Team_model->update_team($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/team/update/' . $id . '');

            }//validation run
        }

        $data['team'] = $this->Team_model->get_team_by_id($id);
        $data['countries'] = $this->get_countries();
        $data['sports'] = $this->get_sports();
        $data['main_content'] = 'admin/team/edit';

        $this->load->view('includes/template', $data);

    }//update

    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->Team_model->delete_team($id);
        redirect('admin/team');
    }//edit

}
