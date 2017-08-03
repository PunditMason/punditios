    <div class="container top">
        <ul class="breadcrumb">
            <li>
                <a href="<?php echo site_url("admin"); ?>">
                    <?php echo ucfirst($this->uri->segment(1));?>
                </a>
                <span class="divider">/</span>
            </li>
            <li>
                <a href="<?php echo site_url("admin").'/'.$this->uri->segment(2); ?>">
                    <?php echo ucfirst($this->uri->segment(2));?>
                </a>
                <span class="divider">/</span>
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
                echo '<strong>Well done!</strong> new user created with success.';
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
        $attributes = array('class' => 'form-horizontal', 'id' => '');
        //form validation
        echo validation_errors();
        echo form_open_multipart('admin/banner/add', $attributes);
        ?>
        <fieldset>
			
           <div class="control-group">
                <label for="inputError" class="control-label">Background Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="background" value="<?php echo set_value('background'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Listeners Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text banner_validate" id="" name="listeners" value="<?php echo set_value('listeners'); ?>" >
                </div>
            </div>
            <div class="control-group">
                <label for="inputError" class="control-label">Broadcaster Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text banner_validate" id="" name="broadcaster" value="<?php echo set_value('broadcaster'); ?>" >
                </div>
            </div>
            
                 <div class="control-group">
                <label for="inputError" class="control-label">setting Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="setting" value="<?php echo set_value('setting'); ?>" >
                </div>
            </div>
            
                 <div class="control-group">
                <label for="inputError" class="control-label">about Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="about" value="<?php echo set_value('about'); ?>" >
                </div>
            </div>
            
                 <div class="control-group">
                <label for="inputError" class="control-label">profile Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="profile" value="<?php echo set_value('profile'); ?>" >
                </div>
            </div>

            <div class="form-actions">
                <button class="btn btn-primary" type="submit">Save changes</button>
                <button class="btn" type="reset" onclick="location.href='<?php echo site_url("admin").'/'.$this->uri->segment(2); ?>';">Cancel</button>
            </div>
            
        </fieldset>
        <?php echo form_close(); ?>
    </div>
     
