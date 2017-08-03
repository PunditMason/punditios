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
                <a href="#">New</a>
            </li>
        </ul>

        <div class="page-header">
            <h2>Adding <?php echo ucfirst($this->uri->segment(2));?></h2>
        </div>

        <?php
        //flash messages
        if(isset($flash_message)) {
            if($flash_message == TRUE) {
                echo '<div class="alert alert-success">';
                echo '<a class="close" data-dismiss="alert">×</a>';
                echo '<strong>Well done!</strong> new sport created with success.';
                echo '</div>';
            } else {
                echo '<div class="alert alert-error">';
                echo '<a class="close" data-dismiss="alert">×</a>';
                echo '<strong>Oh snap!</strong> change a few things up and try submitting again.';
                echo '</div>';
            }
        }
        ?>
        <?php
        //form data
        $attributes = array('class' => 'form-horizontal', 'tb_id' => '');
        //form validation
        echo validation_errors();
        echo form_open_multipart('admin/sport/add', $attributes);
        ?>
        <fieldset>
			<div class="control-group">
                <label for="inputError" class="control-label">Sport Id</label>
                <div class="controls">
                    <input type="text" id="" name="id" value="<?php echo set_value('id'); ?>" >
                </div>
            </div>
            <div class="control-group">
                <label for="inputError" class="control-label">Sport Name</label>
                <div class="controls">
                    <input type="text" id="" name="sport_name" value="<?php echo set_value('sport_name'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Android Sport Icon</label>
                <div class="controls">
                    <input type="file" id="avatar" name="avatar" value="<?php echo set_value('avatar'); ?>">
                </div>
            </div>
             <div class="control-group">
                <label for="inputError" class="control-label">IOS Sport Icon</label>
                <div class="controls">  
                    <input type="file" id="avatar" name="ios_icon" value="<?php echo set_value('ios_icon'); ?>">
                </div>
            </div>

          <div class="control-group">
                <label for="inputError" class="control-label">Android Cover Icon</label>
                <div class="controls">
                    <input type="file" id="" name="cover_image" value="<?php echo set_value('cover_image'); ?>">
                </div>
            </div>
            
            <div class="control-group">
                <label for="inputError" class="control-label">IOS Cover Icon</label>
                <div class="controls">
                    <input type="file" id="" name="ios_cover_image" value="<?php echo set_value('ios_cover_image'); ?>">
                </div>
            </div>
            
              <div class="control-group">
                <label for="inputError" class="control-label">Sport Position</label>
                <div class="controls">
                    
                       <input type="text" class="admin-input-text" id="" name="position" value="<?php echo $league[0]['position']; ?>" >
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
       
          
