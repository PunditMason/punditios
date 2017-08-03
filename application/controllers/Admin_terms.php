<?php

class Admin_terms extends CI_Controller {

    
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Terms_model');

        if(!$this->session->userdata('is_logged_in')){
            redirect('admin/login');
        }
    }

   

    public function index()
    {
        $data['terms'] = $this->Terms_model->get_terms();
        
		//load the view
        $data['main_content'] = 'admin/terms/list';
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
                if($this->Policy_model->add_terms($data_to_store)) {
                    $data['flash_message'] = TRUE;
                } else {
                    $data['flash_message'] = FALSE;
                }
            }
        }
        //load the view
        $data['main_content'] = 'admin/terms/add';
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
                if($this->Terms_model->update_terms($id, $data_to_store) == TRUE){
                    $this->session->set_flashdata('flash_message', 'updated');
                }else{
                    $this->session->set_flashdata('flash_message', 'not_updated');
                }
                redirect('admin/terms/update/' . $id . '');

            }//validation run
        }

        $data['terms'] = $this->Terms_model->get_terms_by_id($id);
        $data['main_content'] = 'admin/terms/edit';

        $this->load->view('includes/template', $data);

    }//update

    public function delete()
    {
        //product id 
        $id = $this->uri->segment(4);
        $this->Terms_model->delete_terms($id);
        redirect('admin/terms');
    }//edit

}
