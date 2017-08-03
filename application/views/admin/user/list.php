    <script>
function doconfirm()
{
    job=confirm("Are you sure to delete permanently?");
    if(job!=true)
    {
        return false;
    }
}
</script>

     <!-- page content -->
        <div class="right_col" role="main">
    <div class="container top">
        <ul class="breadcrumb">
            <li>
                <a href="<?php echo site_url("admin"); ?>">
                    <?php echo ucfirst($this->uri->segment(1));?>
                </a>
               </li>
            <li class="active">
                <?php echo ucfirst($this->uri->segment(2));?>
            </li>
        </ul>

        <div class="page-header users-header">
            <h2>
                <?php //echo ucfirst($this->uri->segment(2));?>
                <?php echo "Users List";?>
                <a  href="<?php echo site_url("admin").'/'.$this->uri->segment(2); ?>/add" class="btn btn-success">Add a new</a>
            </h2>
        </div>

        <div class="row">
            <div class="span12 columns">
                <table id="MyTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>User Id</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Fb Id </th>
                             <th>E-Mail Id</th>
                            <th>Avatar</th>
                            <th>Cover Photo</th>
                            <th>user Bio</th>
                            <th>Country</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    $i=1;
                    foreach($users as $row) {
						
						 echo '<tr>';
                        echo '<td>'.$i++.'</td>';
                        // echo '<td>'.$row['id'].'</td>';
                        echo '<td>'.$row['first_name'].'</td>';
                        echo '<td>'.$row['last_name'].'</td>';
                         echo '<td>'.$row['fb_id'].'</td>';
                        echo '<td>'.$row['email'].'</td>';
                      //  echo '<td>'.$row['password'].'</td>';
                      if($row['avatar']==""){
						  echo '<td><img src="../profileusrimg/profile.png" width="30"/></td>';
						  }else{
							  echo '<td><img src="../profileusrimg/' .$row['avatar'] . '" width="30"/></td>';
							  
							  }
                     if($row['cover_photo']==""){
						  echo '<td><img src="../profileusrimg/profile.png" width="30"/></td>';
						  }else{
							  echo '<td><img src="../profileusrimg/' .$row['cover_photo'] . '" width="30"/></td>';
                     		  
						 }
						  echo '<td>'.$row['country_id'].'</td>';
                         //  echo '<td><img src="../assets/img/flags/24x24/' .$national_flags[$row['country_id']] . '.png"/></td>';
                      echo '<td>'.$row['user_bio'].'</td>';
                        echo '<td class="crud-actions">
                        <a href="'.site_url("admin").'/user/update/'.$row['id'].'" class="btn btn-info" title="view & edit"><span class="glyphicon glyphicon-edit"></span></a>
                        <a href="'.site_url("admin").'/user/delete/'.$row['id'].'" class="btn btn-danger" title="delete" onClick="return doconfirm();"><span class="glyphicon glyphicon-remove"></span></a>
                        </td>';
                        echo '</tr>';
                    }
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
          </div>
        <!-- /page content -->
