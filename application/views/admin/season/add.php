  <!-- page content -->
        <div class="right_col" role="main">
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
                echo '<strong>Well done!</strong> new season created with success.';
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
        echo form_open('admin/season/add', $attributes);
        ?>
        <fieldset>
            <div class="control-group">
                <label for="inputError" class="control-label">Season Name</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="season_name" value="<?php echo set_value('season_name'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Sport Name</label>
                <div class="controls">
                    <?php echo form_dropdown('sport_name', $sports, set_value('sport_name'), 'class="sport_selector"'); ?>
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">League Name</label>
                <div class="controls">
                    <?php echo form_dropdown('league_name', $leagues, set_value('league_name'), 'class="league_selector"'); ?>
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Start Date</label>
                <div class="controls">
                    <input type="text" id="" class="date-picker admin-input-text" name="start_date" value="<?php echo set_value('start_date'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">End Date</label>
                <div class="controls">
                    <input type="text" id="" class="date-picker admin-input-text" name="end_date" value="<?php echo set_value('end_date'); ?>" >
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
