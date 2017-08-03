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
                echo '<strong>Well done!</strong> sport updated with success.';
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
        echo form_open_multipart('admin/sport/update/' . $this->uri->segment(4) . '', $attributes);
        $baseurl = base_url();
        ?>
        <fieldset>
			 <div class="control-group">
                <label for="inputError" class="control-label">Sport Id</label>
                <div class="controls">
                    <input type="text" id="" name="id" value="<?php echo $sport[0]['id']; ?>" >
                </div>
            </div>
            <div class="control-group">
                <label for="inputError" class="control-label">Sport Name</label>
                <div class="controls">
                    <input type="text" id="" name="sport_name" value="<?php echo $sport[0]['name']; ?>" >
                </div>
            </div>

            <div class="control-group">
                <label for="inputError" class="control-label">Android Sport Icon</label>
                <div class="controls">
                    <input type="file" id="" name="sport_icon" value="<?php echo $sport[0]['avatar']; ?>">
                <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$sport[0]['avatar']. '" width="100"/></td>'; ?>
                </div>
            </div>
             <div class="control-group">
                <label for="inputError" class="control-label">IOS Sport Icon</label>
                <div class="controls">
                    <input type="file" id="" name="ios_icon" value="<?php echo $sport[0]['ios_icon']; ?>">
                <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$sport[0]['ios_icon']. '" width="100"/></td>'; ?>
                </div>
            </div>
            <div class="control-group">
                <label for="inputError" class="control-label">Android Sport cover</label>
                <div class="controls">
                    <input type="file" id="" name="sport_cover" value="<?php echo $sport[0]['cover_image']; ?>">
                 <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$sport[0]['cover_image']. '" width="100"/></td>'; ?>
                </div>
            </div>
             <div class="control-group">
                <label for="inputError" class="control-label">IOS Sport cover</label>
                <div class="controls">
                    <input type="file" id="" name="ios_cover_image" value="<?php echo $sport[0]['ios_cover_image']; ?>">
                 <?php echo '<td><img src="'.$baseurl.'/assets/img/icons/' .$sport[0]['ios_cover_image']. '" width="100"/></td>'; ?>
                </div>
            </div>
               <div class="control-group">
                <label for="inputError" class="control-label">Sport Position</label>
                <div class="controls">
                    
                       <input type="text" class="admin-input-text" id="" name="position" value="<?php echo $sport[0]['position']; ?>" >
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
