<!-- page content -->
        <div class="right_col" role="main">
    <div class="container top">
        <ul class="breadcrumb">
            <li>
                <a href="<?php echo site_url("admin"); ?>">
                    <?php echo ucfirst($this->uri->segment(1));?>
                </a>
               
            </li>

            <li>
                <a href="<?php echo site_url("admin").'/'.$this->uri->segment(2); ?>">
                    <?php echo ucfirst($this->uri->segment(2));?>
                </a>
               
            </li>

            <li class="active">
                <a href="#">Update</a>
            </li>
        </ul>

        <div class="page-header">
            <h2>Updating <?php echo ucfirst($this->uri->segment(2));?></h2>
        </div>

        <?php
        //flash messages
        if($this->session->flashdata('flash_message')){
            if($this->session->flashdata('flash_message') == 'updated') {
                echo '<div class="alert alert-success">';
                echo '<a class="close" data-dismiss="alert">×</a>';
                echo '<strong>Well done!</strong>updated with success.';
                echo '</div>';
            } else {
                echo '<div class="alert alert-error">';
                echo '<a class="close" data-dismiss="alert">x</a>';
                echo '<strong>Oh snap!</strong> change a few things up and try submitting again.';
                echo '</div>';
            }
        }
        ?>

        <?php
        //form data
        $attributes = array('class' => 'form-horizontal', 'id' => '');
        //form validation
        echo validation_errors();
        echo form_open('admin/aboutus/update/' . $this->uri->segment(4) . '', $attributes);
        ?>
        <fieldset>
            <div class="control-group">
                <label for="inputError" class="control-label">Title</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="title" value="<?php echo $aboutus[0]['title']; ?>" >
                </div>
            </div>
			
              <div class="control-group">
                <label for="inputError" class="control-label">Content</label>
                <div class="controls">
                    <textarea class="admin-input-text" id="" name="content" value="<?php echo $aboutus[0]['content']; ?>" ><?php echo $aboutus[0]['content']; ?></textarea>
                </div>
            </div>
           

            <div class="form-actions">
                <button class="btn btn-primary" type="submit">Save changes</button>
                <button class="btn" type="reset" onclick="location.href='<?php echo site_url("admin").'/'.$this->uri->segment(2); ?>';">Cancel</button>
            </div>
        </fieldset>

        <?php echo form_close(); ?>
    </div>
     
 </div>
        <!-- /page content -->
