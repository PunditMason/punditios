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
                echo '<strong>Well done!</strong> team updated with success.';
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
        echo form_open_multipart('admin/team/update/' . $this->uri->segment(4) . '', $attributes);
        ?>
        <fieldset>
			   <div class="control-group">
                <label for="inputError" class="control-label">Team Id</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="team_id" value="<?php echo $team[0]['id']; ?>" >
                </div>
            </div>
            <div class="control-group">
                <label for="inputError" class="control-label">Team Name</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="team_name" value="<?php echo $team[0]['name']; ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Country/Region</label>
                <div class="controls">
                    <?php echo form_dropdown('country_id', $countries, $team[0]['country_id'], 'class="countries"'); ?>
<!--                    <input type="text" id="" name="country_id" value="--><?php //echo $team[0]['country_id']; ?><!--">-->
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Team Mark</label>
                <div class="controls">
                    <input type="file" class="admin-input-text" id="" name="team_mark" value="<?php echo $team[0]['mark_image']; ?>">
               <?php echo '<td><img src="http://punditsports.com:81/pundit-web/assets/img/team_mark/' .$team[0]['mark_image']. '" width="100"/></td>'; ?>
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
