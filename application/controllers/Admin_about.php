<?php

class Admin_about extends CI_Controller {

    
    public function __construct()
    {
        parent::__construct();
        $this->load->model('About_model');

        if(!$this->session->userdata('is_logged_in')){
            redirect('admin/login');
        }
    }

   

    public function index()
    {
        $data['aboutus'] = $this->About_model->get_about();
        
		//load the view
        $data['main_content'] = 'admin/aboutus/list';
        $this->load->view('includes/template', $data);

    }//index

    public function add()
    {
        //if save button was clicked, get the data sent via post
        if ($this->input->server('REQUEST_METHOD') === 'POST')
        {

            //form validation
            $this->form_validation->set_rules('title', 'Title', 'required');
            $this->form_validation->set_rules('content', 'Content', 'required');
            
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');

            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'title' => $this->input->post('title'),
                    'content' => $this->input->post('content')
                    
                );
                //if the insert has returned true then we show the flash message
                if($this->About_model->add_about($data_to_store)) {
                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            }
        }
        //load the view
        $data['main_content'] = 'admin/aboutus/add';
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
            $this->form_validation->set_rules('title', 'Title', 'required');
            $this->form_validation->set_rules('content', 'Content', 'required');
            
            $this->form_validation->set_error_delimiters('<div class="alert alert-error"><a class="close" data-dismiss="alert">x</a><strong>', '</strong></div>');
            //if the form has passed through the validation
            if ($this->form_validation->run())
            {
                $data_to_store = array(
                    'title' => $this->input->post('title'),
                    'content' => $this->input->post('content')
                    
                );
                //if the insert has returned true then we show the flash message
                if($this->About_model->update_about($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/aboutus/update/' . $id . '');

            }//validation run
        }

        $data['aboutus'] = $this->About_model->get_about_by_id($id);
        $data['main_content'] = 'admin/aboutus/edit';

        $this->load->view('includes/template', $data);

    }//update

    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->About_model->delete_about($id);
        redirect('admin/aboutus');
    }//edit

}

