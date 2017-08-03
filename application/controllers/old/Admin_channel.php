<?php

class Admin_channel extends CI_Controller {

    private $matches;
    private $users;

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Channel_model');

        if(!$this->session->userdata('is_logged_in')){
            redirect('admin/login');
        }
    }

    function get_matches() {
        if(!$this->matches) {
            $this->load->model("Match_model");
            $this->matches = $this->Match_model->get_all_match_name_indexed();
        }

        return $this->matches;
    }

    function get_users() {
        if(!$this->users) {
            $this->load->model("Users_model");
            $this->users = $this->Users_model->get_all_user_name_indexed();
        }

        return $this->users;
    }

    public function index()
    {
        $data['channel'] = $this->Channel_model->get_all_channel();
        $data['matches'] = $this->get_matches();
        $data['user'] = $this->get_users();

        //load the view
        $data['main_content'] = 'admin/channel/list';
        $this->load->view('includes/template', $data);

    }//index

    public function add()
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {

            //form validation
            $this->form_validation->set_rules('channel_name', 'Channel Name', 'required');
            $this->form_validation->set_rules('match_name', 'Match Name', '');
            $this->form_validation->set_rules('broadcaster_name', 'Broadcaster Name', '');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'name' => $this->input->post('channel_name'),
                    'match_id' => $this->input->post('match_name'),
                    'broadcaster_id' => $this->input->post('broadcaster_name')
                );
                //if the insert has returned true then we show the flash message
                if($this->Channel_model->add_channel($data_to_store)) {
                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            }
        }
        //load the view
        $data['main_content'] = 'admin/channel/add';
        $data['matches'] = $this->get_matches();
        $data['user'] = $this->get_users();
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
            $this->form_validation->set_rules('channel_name', 'Channel Name', 'required');
            $this->form_validation->set_rules('match_name', 'Match Name', '');
            $this->form_validation->set_rules('broadcaster_name', 'Broadcaster Name', '');
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');
            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'name' => $this->input->post('channel_name'),
                    'match_id' => $this->input->post('match_name'),
                    'broadcaster_id' => $this->input->post('broadcaster_name')
                );
                //if the insert has returned true then we show the flash message
                if($this->Channel_model->update_channel($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/channel/update/' . $id . '');

            }//validation run
        }

        $data['channel'] = $this->Channel_model->get_channel_by_id($id);
        $data['matches'] = $this->get_matches();
        $data['user'] = $this->get_users();
        $data['main_content'] = 'admin/channel/edit';

        $this->load->view('includes/template', $data);

    }//update

    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->Channel_model->delete_channel($id);
        redirect('admin/channel');
    }//edit

}