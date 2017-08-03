
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
                <?php echo "Leagues List";?>
                <a  href="<?php echo site_url("admin").'/'.$this->uri->segment(2); ?>/add" class="btn btn-success">Add a new</a>
            </h2>
        </div>

        <div class="row">
            <div class="span12 columns">
                <table id="MyTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>League Position</th>
                            <th>League Name</th>
                            <th>Android/Web Icon</th>
                            <th>IOS Icon</th>
                             <th>Android/Web Cover</th>
                             <th>IOS Cover</th>
                             <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    $i = 1;
                    foreach($league as $row) {
                        $sport_icon = '';
                        if(isset($sports_icon) && isset($sports_icon[$row['sport_id']])) {
                            $sport_icon = $sports_icon[$row['sport_id']];
                        }
                        echo '<tr>';
                         echo '<td>'.$i++.'</td>';
                         echo '<td>'.$row['position'].'</td>';
                        //echo '<td>'.$row['id'].'</td>';
                        echo '<td>'.$row['name'].'</td>';
//                        echo '<td><img src="../../../assets/img/icons/' .$sport_icon . '" width="32"/></td>';
                        echo '<td><img src="../assets/img/league_mark/' .$row['mark_image'] . '" width="100"/></td>';
                         echo '<td><img src="../assets/img/ios_league_mark/' .$row['ios_mark_image'] . '" width="100"/></td>';
                        echo '<td><img src="../assets/img/league_mark/' .$row['cover_image'] . '" width="100"/></td>';
                         echo '<td><img src="../assets/img/ios_league_mark/' .$row['ios_cover_image'] . '" width="100"/></td>';
                     //   echo '<td><img src="../assets/img/icons/' .$sport_icon . '" width="32"/></td>';
                        echo '<td class="crud-actions">
                        <a href="'.site_url("admin").'/league/update/'.$row['tb_id'].'" class="btn btn-info" title="view & edit"><span class="glyphicon glyphicon-edit"></span></a>
                        <a href="'.site_url("admin").'/league/delete/'.$row['tb_id'].'" class="btn btn-danger" title="delete"onClick="return doconfirm();"><span class="glyphicon glyphicon-remove"></span></a>
                        </td>';
                        echo '</tr>';
                    }
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
</div>
</div>
</div>
