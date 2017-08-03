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
                echo '<strong>Well done!</strong> new league created with success.';
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
        echo form_open_multipart('admin/league/add', $attributes);
        ?>
        <fieldset>
			<div class="control-group">
                <label for="inputError" class="control-label">League ID</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="id" value="<?php echo set_value('id'); ?>" >
                </div>
            </div>
            <div class="control-group">
                <label for="inputError" class="control-label">League Name</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="league_name" value="<?php echo set_value('league_name'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Android/Web Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text league_banner" id="" name="league_mark" value="<?php echo set_value('league_mark'); ?>">
               
                </div>
            </div>
            <div class="control-group">
                <label for="inputError" class="control-label">IOS Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text league_banner" id="" name="ios_mark_image" value="<?php echo set_value('ios_mark_image'); ?>">
               
                </div>
            </div>
             <div class="control-group">
                <label for="inputError" class="control-label">Android/Web Cover</label>
                <div class="controls">
                    <input type="file" class="admin-input-text cover_banner" id="" name="cover_mark" value="<?php echo set_value('cover_mark'); ?>">
                </div>
            </div>
            
             <div class="control-group">
                <label for="inputError" class="control-label">IOS Cover</label>
                <div class="controls">
                    <input type="file" class="admin-input-text cover_banner" id="" name="ios_cover_image" value="<?php echo set_value('ios_cover_image'); ?>">
                </div>
            </div>
            
            <div class="control-group">
                <label for="inputError" class="control-label">Sport</label>
                <div class="controls">
                    <?php echo form_dropdown('sport_id', $sports, set_value('sport_id'), 'class="sports"'); ?>
                </div>
            </div>
           <div class="control-group">
                <label for="inputError" class="control-label">League Position</label>
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
