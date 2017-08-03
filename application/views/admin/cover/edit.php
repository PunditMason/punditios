    
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
                echo '<strong>Well done!</strong>Banner updated with success.';
                echo '</div>';
            } else {
                echo '<div class="alert alert-error">';
                echo '<a class="close" data-dismiss="alert">x</a>';
                echo '<strong>Oh snap!</strong> change a few things up and try submitting again.';
                echo '</div>';
            }
        }
        ?>
<?php echo $error;?>
        <?php
        //form data
        $attributes = array('class' => 'form-horizontal', 'id' => '');
        //form validation
        echo validation_errors();
        echo form_open_multipart('admin/cover/update/' . $this->uri->segment(4) . '', $attributes);
     
       $baseurl = base_url();
     
        ?>
   
        <fieldset>
			 <div class="control-group">
                <label for="inputError" class="control-label">Name</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="name" value="<?php echo $cover[0]['name']; ?>" >
                </div>
            </div>
             <div class="control-group">
                <label for="inputError" class="control-label">Cover Image</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="cover_image" value="<?php echo $cover[0]['cover_image']; ?>" > 
                    <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$cover[0]['cover_image']. '" width="100"/></td>'; ?>
                </div>
                <div class="control-group">
                <label for="inputError" class="control-label">Background Image</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="background_image" value="<?php echo $cover[0]['background_image']; ?>" > 
                    <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$cover[0]['background_image']. '" width="100"/></td>'; ?>
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
     
