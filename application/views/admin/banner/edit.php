    
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

        <?php
        //form data
        $attributes = array('class' => 'form-horizontal', 'id' => '');
        //form validation
        echo validation_errors();
        echo form_open_multipart('admin/banner/update/' . $this->uri->segment(4) . '', $attributes);
   
         $baseurl = base_url();
        
        ?>
   
        <fieldset>
             <div class="control-group">
                <label for="inputError" class="control-label">Background Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="background" value="<?php echo $banner[0]['background']; ?>" > 
                    <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['background']. '" width="100"/></td>'; ?>
                </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Listeners Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text banner_validate" id="banner_listeners" name="listeners" value="<?php echo $banner[0]['listeners']; ?>" >
                <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['listeners']. '" width="100"/></td>'; ?>
                </div>
            </div>
             <div class="control-group">
                <label for="inputError" class="control-label">Broadcaster Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text banner_validate banner_validate" id="" name="broadcaster" value="<?php echo $banner[0]['broadcaster']; ?>" >
                    <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['broadcaster']. '" width="100"/></td>'; ?>
                </div>
            </div>


                <div class="control-group">
                <label for="inputError" class="control-label">Setting Cover</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="setting" value="<?php echo set_value('setting'); ?>" >
                 <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['setting']. '" width="100"/></td>'; ?>
                </div>
            </div>
            
                 <div class="control-group">
                <label for="inputError" class="control-label">About Cover</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="about" value="<?php echo set_value('about'); ?>" >
                 <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['about']. '" width="100"/></td>'; ?>
                </div>
            </div>
            
                 <div class="control-group">
                <label for="inputError" class="control-label">Profile Cover</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="profile" value="<?php echo set_value('profile'); ?>" >
                 <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['profile']. '" width="100"/></td>'; ?>
                </div>
            </div>
            
                   <div class="control-group">
                <label for="inputError" class="control-label">Login Cover</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="login" value="<?php echo set_value('login'); ?>" >
                 <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['login']. '" width="100"/></td>'; ?>
                </div>
            </div>
            
                          <div class="control-group">
                <label for="inputError" class="control-label">setting Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="settingicon" value="<?php echo set_value('settingicon'); ?>" >
                 <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['settingicon']. '" width="100"/></td>'; ?>
                </div>
            </div>
            
                 <div class="control-group">
                <label for="inputError" class="control-label">about Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="abouticon" value="<?php echo set_value('abouticon'); ?>" >
                 <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['abouticon']. '" width="100"/></td>'; ?>
                </div>
            </div>
            
                 <div class="control-group">
                <label for="inputError" class="control-label">profile Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="profileicon" value="<?php echo set_value('profileicon'); ?>" >
                 <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['profileicon']. '" width="100"/></td>'; ?>
                </div>
            </div>
            
                   <div class="control-group">
                <label for="inputError" class="control-label">login Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="loginicon" value="<?php echo set_value('loginicon'); ?>" >
                 <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$banner[0]['loginicon']. '" width="100"/></td>'; ?>
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
     
