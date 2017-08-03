    
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
                <?php echo "Banners List";?>
                <!--<a  href="<?php //echo site_url("admin").'/'.$this->uri->segment(2); ?>/add" class="btn btn-success">Add a new</a>-->
            </h2>
        </div>

        <div class="row">
            <div class="span12 columns">
                <table id="MyTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Cover Image</th>
                             <th>Background Image</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    foreach($cover as $row) {
                        echo '<tr>';
                        echo '<td>'.$row['id'].'</td>';
                        echo '<td>'.$row['name'].'</td>';
                        echo '<td><img src="../assets/img/icons/' .$row['cover_image'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/icons/' .$row['background_image'] . '" width="100"/></td>';
                        echo '<td class="crud-actions">
                        <a href="'.site_url("admin").'/cover/update/'.$row['id'].'" class="btn btn-info" title="view & edit"><span class="glyphicon glyphicon-edit"></span></a>
                        <!--<a href="'.site_url("admin").'/cover/delete/'.$row['id'].'" class="btn btn-danger" title="delete"onClick="return doconfirm();"><span class="glyphicon glyphicon-remove"></span></a>-->
                        </td>';
                        echo '</tr>';
                    }
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
</div>
