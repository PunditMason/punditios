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
                echo '<strong>Well done!</strong> league updated with success.';
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
        $attributes = array('class' => 'form-horizontal', 'tb_id' => '');
        //form validation
        echo validation_errors();
        echo form_open_multipart('admin/league/update/' . $this->uri->segment(4) . '', $attributes);
       $baseurl = base_url();
        ?>
        
        <fieldset>
			 <div class="control-group">
                <label for="inputError" class="control-label">League id</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="id" value="<?php echo $league[0]['id']; ?>" >
                </div>
            </div>
            <div class="control-group">
                <label for="inputError" class="control-label">League Name</label>
                <div class="controls">
                    <input type="text" class="admin-input-text" id="" name="league_name" value="<?php echo $league[0]['name']; ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Android/Web Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text league_banner" id="" name="mark_image" value="<?php echo $league[0]['mark_image']; ?>">
                <?php echo '<td><img src="'.$baseurl.'/assets/img/league_mark/' .$league[0]['mark_image']. '" width="100"/></td>'; ?>
                </div>
            </div>
            
             <div class="control-group">
                <label for="inputError" class="control-label">IOS Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text league_banner" id="" name="ios_mark_image" value="<?php echo $league[0]['ios_mark_image']; ?>">
                <?php echo '<td><img src="'.$baseurl.'/assets/img/league_mark/' .$league[0]['ios_mark_image']. '" width="100"/></td>'; ?>
                </div>
            </div>
            
             <div class="control-group">
                <label for="inputError" class="control-label">Android/Web Icon</label>
                <div class="controls">
                    <input type="file" class="admin-input-text cover_banner" id="" name="cover_image" value="<?php echo $league[0]['cover_image']; ?>">
                <?php echo '<td><img src="'.$baseurl.'/assets/img/league_mark/' .$league[0]['cover_image']. '" width="100"/></td>'; ?>
                </div>
            </div>
            
            <div class="control-group">
                <label for="inputError" class="control-label">IOS Cover</label>
                <div class="controls">
                    <input type="file" class="admin-input-text cover_banner" id="" name="ios_cover_image" value="<?php echo $league[0]['ios_cover_image']; ?>">
                <?php echo '<td><img src="'.$baseurl.'/assets/img/league_mark/' .$league[0]['ios_cover_image']. '" width="100"/></td>'; ?>
                </div>
            </div>
            

            <div class="control-group">
                <label for="inputError" class="control-label">Sport</label>
                <div class="controls">
                    <?php echo form_dropdown('sport_id', $sports, $league[0]['sport_id'], 'class="sports"'); ?>
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
