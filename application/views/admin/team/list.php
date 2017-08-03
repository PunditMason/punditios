   
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
                <?php echo "Teams List";?>
                <a  href="<?php echo site_url("admin").'/'.$this->uri->segment(2); ?>/add" class="btn btn-success">Add a new</a>
            </h2>
        </div>

        <div class="row">
            <div class="span12 columns">
                <table id="MyTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
							<th>#</th>
                            <th>Team Name</th>
                             <th>Team Id</th>
                             <th>Team Mark</th>
                            <th>Country/Region</th>
                             <th>Sport Name</th>
                            <th>League Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    $i = 1;
                    foreach($team as $row) {
                        $national_flag = '';
                        $sport_icon = '';
                        if(isset($national_flags) && isset($national_flags[$row['country_id']])) {
                            $national_flag = $national_flags[$row['country_id']];
                        }
                        if(isset($sports_icon) && isset($sports_icon[$row['sport_id']])) {
                            $sport_icon = $sports_icon[$row['sport_id']];
                        }
                       echo '<tr>';
                       echo '<td>'.$i++.'</td>';
                       echo '<td>'.$row['name'].'</td>';
                       echo '<td>'.$row['id'].'</td>';
                       
                       if($row['mark_image']==""){
						    echo '<td><img src="../assets/images/sport.png" width="30"/></td>';
						   }else{
							   
							    echo '<td><img src="../assets/img/team_mark/' .$row['mark_image'] . '" width="100"/></td>';
							   }
                      
                        if($national_flag ==""){
						   echo '<td><img src="../assets/images/sport.png" width="20"/></td>';   
						   }else{
							    echo '<td><img src="../assets/img/flags/24x24/' . $national_flag . '.png" /></td>';
							   }
					   echo '<td>'.$row['sport_name'].'</td>';
                       echo '<td>'.$row['league_name'].'</td>';
                       // echo '<td><img src="../assets/img/icons/' .$sport_icon . '" width="100"/></td>';
                        echo '<td class="crud-actions">
                        <a href="'.site_url("admin").'/team/update/'.$row['id'].'" class="btn btn-info" title="view & edit"><span class="glyphicon glyphicon-edit"></span></a>
                        <a href="'.site_url("admin").'/team/delete/'.$row['id'].'" class="btn btn-danger" title="delete" onClick="return doconfirm();"><span class="glyphicon glyphicon-remove"></span></a>
                        </td>';
                        echo '</tr>';
                    }
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
</div>
