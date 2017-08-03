    
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
    
    <div class="container top">
        <ul class="breadcrumb">
            <li>
                <a href="<?php echo site_url("admin"); ?>">
                    <?php echo ucfirst($this->uri->segment(1));?>
                </a>
                <span class="divider">/</span>
            </li>
            <li class="active">
                <?php echo ucfirst($this->uri->segment(2));?>
            </li>
        </ul>

        <div class="page-header users-header">
            <h2>
                <?php echo ucfirst($this->uri->segment(2));?>
                <a  href="<?php echo site_url("admin").'/'.$this->uri->segment(2); ?>/add" class="btn btn-success">Add a new</a>
            </h2>
        </div>

        <div class="row">
            <div class="span12 columns">
                <table id="MyTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Season Name</th>
                            <th>Sport</th>
                            <th>League Name</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                     foreach($season as $row) {
                        $sport_icon = $sports_icon[$row['sport_id']];
                        echo '<tr>';
                        echo '<td>'.$row['id'].'</td>';
                        echo '<td>'.$row['name'].'</td>';
                        echo '<td>'.$row['sport_id'].'</td>';
                        echo '<td>'.$leagues[$row['league_id']].'</td>';
                        echo '<td>'.$row['start_date'].'</td>';
                        echo '<td>'.$row['end_date'].'</td>';
                        echo '<td class="crud-actions">
                        <a href="'.site_url("admin").'/season/update/'.$row['id'].'" class="btn btn-info" title="view & edit"><span class="glyphicon glyphicon-edit"></span></a>
                        <a href="'.site_url("admin").'/season/delete/'.$row['id'].'" class="btn btn-danger" title="delete"onClick="return doconfirm();"><span class="glyphicon glyphicon-remove"></span></a>
                        </td>';
                        echo '</tr>';
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
