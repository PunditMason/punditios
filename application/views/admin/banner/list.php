    
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
                <?php echo "Application Banner Images";?>
                <!--<a  href="<?php //echo site_url("admin").'/'.$this->uri->segment(2); ?>/add" class="btn btn-success">Add a new</a>-->
            </h2>
        </div>

        <div class="row">
            <div class="span12 columns">
                <table id="MyTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th> Banner Id</th>
                            <th> Device Type</th>
                            <th>Background Icon</th>
                            <th>Listeners Icon</th>
                            <th>Broadcaster Icon</th>
                            <th>Pundit Cover</th>
                            <th>About Cover</th>
                            <th>Profile Cover</th>
                            <th>Login Cover</th>
                            <th>Pundit Icon</th>
                            <th>About Icon</th>
                            <th>Profile Icon</th>
                            <th>Login Icon</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                  //  foreach($banner as $row) {
                       
                        echo '<tr>';
                        echo '<td>'.$banner[0]['id'].'</td>';
                        echo '<td>'.$banner[0]['device_type'].'</td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['background'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['listeners'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['broadcaster'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['setting'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['about'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['profile'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['login'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['settingicon'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['abouticon'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['profileicon'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$banner[0]['loginicon'] . '" width="100"/></td>';
                        echo '<td class="crud-actions">
                        <a href="'.site_url("admin").'/banner/update/'.$banner[0]['id'].'" class="btn btn-info" title="view & edit"><span class="glyphicon glyphicon-edit"></span></a>
                        <!--<a href="'.site_url("admin").'/banner/delete/'.$banner[0]['id'].'" class="btn btn-danger" title="delete"onClick="return doconfirm();"><span class="glyphicon glyphicon-remove"></span></a>-->
                        </td>';
                        echo '</tr>';
                        
                        echo '<tr>';
                        echo '<td>'.$banner[1]['id'].'</td>';
                        echo '<td>'.$banner[1]['device_type'].'</td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['background'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['listeners'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['broadcaster'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['setting'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['about'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['profile'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['login'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['settingicon'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['abouticon'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['profileicon'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/ios_icons/' .$banner[1]['loginicon'] . '" width="100"/></td>';
                        echo '<td class="crud-actions">
                        <a href="'.site_url("admin").'/banner/update/'.$banner[1]['id'].'" class="btn btn-info" title="view & edit"><span class="glyphicon glyphicon-edit"></span></a>
                        <!--<a href="'.site_url("admin").'/banner/delete/'.$banner[1]['id'].'" class="btn btn-danger" title="delete"onClick="return doconfirm();"><span class="glyphicon glyphicon-remove"></span></a>-->
                        </td>';
                        echo '</tr>';
                //    }
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
</div>
