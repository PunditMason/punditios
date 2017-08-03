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
                echo '<strong>Well done!</strong> new match created with success.';
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
        echo form_open('admin/match/add', $attributes);
        ?>
        <fieldset>

            <div class="control-group">
                <label for="inputError" class="control-label">Team1 Name</label>
                <div class="controls">
                    <?php echo form_dropdown('team1_name', $teams, set_value('team1_name'), 'class="team_selector"'); ?>
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Team2 Name</label>
                <div class="controls">
                    <?php echo form_dropdown('team2_name', $teams, set_value('team1_name'), 'class="team_selector"'); ?>
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Team1 Score</label>
                <div class="controls">
                    <input type="number" class="admin-input-number" id="" name="team1_score" value="<?php echo set_value('team1_score'); ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Team2 Score</label>
                <div class="controls">
                    <input type="number" id="" class="admin-input-number" name="team2_score" value="<?php echo set_value('team2_score'); ?>">
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Match Time</label>
                <div class="controls">
                    <input type="text" class="date-picker admin-input-text" id="" name="match_time" value="<?php echo set_value('match_time'); ?>">
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Country/Region</label>
                <div class="controls">
                    <?php echo form_dropdown('match_country', $countries, set_value('match_country'), 'class="country_selector"'); ?>
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Season</label>
                <div class="controls">
                    <?php echo form_dropdown('season_id', $seasons, set_value('season_id'), 'class="season_selector"'); ?>
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
