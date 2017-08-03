  
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
        echo form_open_multipart('admin/user/add', $attributes);
        ?>
        <fieldset>
            <div class="control-group">
                <label for="inputError" class="control-label">First Name</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="first_name" value="<?php echo set_value('first_name'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Last Name</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="last_name" value="<?php echo set_value('last_name'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Email</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="email_address" value="<?php echo set_value('email_address'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Password</label>
                <div class="controls">
                    <input type="password" class="admin-input-password" id="" name="password" value="<?php echo set_value('password'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Password Confirmation</label>
                <div class="controls">
                    <input type="password" class="admin-input-password" id="" name="password2" value="<?php echo set_value('password'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Avatar</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="avatar" value="<?php echo set_value('avatar'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Cover Photo</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="cover_photo" value="<?php echo set_value('cover_photo'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Country/Region</label>
                <div class="controls">
                    <?php echo form_dropdown('country', $countries, set_value('country_id'), 'class="country_selector"'); ?>
                </div>
            </div>

 <div class="control-group">
                <label for="inputError" class="control-label">User Bio</label>
                <div class="controls">
					<textarea class="admin-input-text" id="" name="user_bio"><?php echo $users[0]['user_bio']; ?></textarea>
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
