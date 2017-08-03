<?php

class Admin_season extends CI_Controller {

    private $leagues;
    private $sports;
    private $sports_icon;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Season_model');

        if(!$this->session->userdata('is_logged_in')){
            redirect('admin/login');
        }
    }

    function get_leagues() {
        if(!$this->leagues) {
            $this->load->model("League_model");
            $this->leagues = $this->League_model->get_all_league_name();
        }

        return $this->leagues;
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

    function get_league_indexed() {
        $this->load->model("League_model");
        $leagues = $this->League_model->get_leagues_indexed();

        return $leagues;
    }

    public function index()
    {
        $data['season'] = $this->Season_model->get_all_season();
      //  $data['leagues'] = $this->get_league_indexed();
     //   $data['sports_icon'] = $this->get_sports_icon();

        //load the view
        $data['main_content'] = 'admin/season/list';
        $this->load->view('includes/template', $data);

    }//index

    public function add()
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {

            //form validation
            $this->form_validation->set_rules('season_name', 'Season Name', 'required');
            $this->form_validation->set_rules('sport_name', 'Sport Name', '');
            $this->form_validation->set_rules('league_name', 'League Name', '');
            $this->form_validation->set_rules('start_date', 'Start Date', 'required');
            $this->form_validation->set_rules('end_date', 'End Date', 'required');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'name' => $this->input->post('season_name'),
                    'sport_id' => $this->input->post('sport_name'),
                    'league_id' => $this->input->post('league_name'),
                    'start_date' => $this->input->post('start_date'),
                    'end_date' => $this->input->post('end_date')
                );
                //if the insert has returned true then we show the flash message
                if($this->Season_model->add_season($data_to_store)) {
                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            }
        }
        //load the view
        $data['main_content'] = 'admin/season/add';
        $data['leagues'] = $this->get_league_indexed();
        $data['sports'] = $this->get_sports();
        $this->load->view('includes/template', $data);
    }

    public function update()
    {
        //product id
        $id = $this->uri->segment(4);

        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {
            //form validation
            $this->form_validation->set_rules('season_name', 'Season Name', 'required');
            $this->form_validation->set_rules('sport_name', 'Sport Name', '');
            $this->form_validation->set_rules('league_name', 'League Name', '');
            $this->form_validation->set_rules('start_date', 'Start Date', 'required');
            $this->form_validation->set_rules('end_date', 'End Date', 'required');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');
            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'name' => $this->input->post('season_name'),
                    'sport_id' => $this->input->post('sport_name'),
                    'league_id' => $this->input->post('league_name'),
                    'start_date' => $this->input->post('start_date'),
                    'end_date' => $this->input->post('end_date')
                );
                //if the insert has returned true then we show the flash message
                if($this->Season_model->update_season($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/season/update/' . $id . '');

            }//validation run
        }

        $data['season'] = $this->Season_model->get_season_by_id($id);
        $data['leagues'] = $this->get_league_indexed();
        $data['sports'] = $this->get_sports();
        $data['main_content'] = 'admin/season/edit';

        $this->load->view('includes/template', $data);

    }//update

    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->Season_model->delete_season($id);
        redirect('admin/season');
    }//edit

}
?>
