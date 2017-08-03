<?php

class Admin_match extends CI_Controller {

    private $teams;
    private $national_flags;
    private $countries;
    private $season;
    private $sports;
    private $sports_icon;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Match_model');

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

    function get_season() {
        if(!$this->season) {
            $this->load->model("Season_model");
            $this->season = $this->Season_model->get_all_season_name_indexed();
        }

        return $this->season;
    }

    function get_teams() {
        if(!$this->teams) {
            $this->load->model("Team_model");
            $this->teams = $this->Team_model->get_all_team_name_indexed();
        }

        return $this->teams;
    }

    function get_sports() {
        if(!$this->sports) {
            $this->load->model("Sport_model");
            $this->sports = $this->Sport_model->get_all_sport_name();
        }

        return $this->sports;
    }

    function get_sports_icon() {
        if(!$this->sports_icon) {
            $this->load->model("Sport_model");
            $this->sports_icon = $this->Sport_model->get_all_sport_icon();
        }

        return $this->sports_icon;
    }

    public function index()
    {
        $data['match'] = $this->Match_model->get_all_match();
        $data['teams'] = $this->get_teams();
        $data['national_flags'] = $this->get_national_flags();
        $data['seasons'] = $this->get_season();

        //load the view
        $data['main_content'] = 'admin/match/list';
        $this->load->view('includes/template', $data);

    }//index

    public function add()
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {

            //form validation
            $this->form_validation->set_rules('team1_name', 'Team1 Name', 'required');
            $this->form_validation->set_rules('team2_name', 'Team2 Name', 'required');
            $this->form_validation->set_rules('team1_score', 'Team1 Score', 'required');
            $this->form_validation->set_rules('team2_score', 'Team2 Score', 'required');
            $this->form_validation->set_rules('match_time', 'Match Time', 'required');
            $this->form_validation->set_rules('match_country', 'Match Country', '');
            $this->form_validation->set_rules('season_id', 'Season', '');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'team1_id' => $this->input->post('team1_name'),
                    'team2_id' => $this->input->post('team2_name'),
                    'team1_score' => $this->input->post('team1_score'),
                    'team2_score' => $this->input->post('team2_score'),
                    'time' => $this->input->post('match_time'),
                    'country_id' => $this->input->post('match_country'),
                    'season_id' => $this->input->post('season_id')
                );
                //if the insert has returned true then we show the flash message
                if($this->Match_model->add_match($data_to_store)) {
                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            }
        }
        //load the view
        $data['main_content'] = 'admin/match/add';
        $data['teams'] = $this->get_teams();
        $data['countries'] = $this->get_countries();
        $data['seasons'] = $this->get_season();
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
            $this->form_validation->set_rules('team1_name', 'Team1 Name', 'required');
            $this->form_validation->set_rules('team2_name', 'Team2 Name', 'required');
            $this->form_validation->set_rules('team1_score', 'Team1 Score', 'required');
            $this->form_validation->set_rules('team2_score', 'Team2 Score', 'required');
            $this->form_validation->set_rules('match_time', 'Match Time', 'required');
            $this->form_validation->set_rules('match_country', 'Match Country', '');
            $this->form_validation->set_rules('season_id', 'Season', '');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');
            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'team1_id' => $this->input->post('team1_name'),
                    'team2_id' => $this->input->post('team2_name'),
                    'team1_score' => $this->input->post('team1_score'),
                    'team2_score' => $this->input->post('team2_score'),
                    'time' => $this->input->post('match_time'),
                    'country_id' => $this->input->post('match_country'),
                    'season_id' => $this->input->post('season_id')
                );
                //if the insert has returned true then we show the flash message
                if($this->Match_model->update_match($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/match/update/' . $id . '');

            }//validation run
        }

        $data['match'] = $this->Match_model->get_match_by_id($id);
        $data['teams'] = $this->get_teams();
        $data['countries'] = $this->get_countries();
        $data['seasons'] = $this->get_season();
        $data['main_content'] = 'admin/match/edit';

        $this->load->view('includes/template', $data);

    }//update

    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->Match_model->delete_match($id);
        redirect('admin/match');
    }//edit

}