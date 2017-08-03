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
                            <th>Name</th>
                            <th>Icon</th>
                            <th>cover_image</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                     foreach($sport as $row) {
                        echo '<tr>';
                        echo '<td>'.$row['id'].'</td>';
                       echo '<td>'.$row['name'].'</td>';
                     //   echo '<td>'.$row['image'].'</td>';
                        echo '<td><img src="../assets/img/icons/' . $row['avatar'] . '" /></td>';
                         echo '<td><img src="../assets/img/icons/' . $row['cover_image'] . '" /></td>';
                        echo '<td class="crud-actions">
                        <a href="'.site_url("admin").'/sport/update/'.$row['id'].'" class="btn btn-info" title="view & edit"><span class="glyphicon glyphicon-edit"></span></a>
                        <a href="'.site_url("admin").'/sport/delete/'.$row['id'].'" class="btn btn-danger" title="delete"><span class="glyphicon glyphicon-remove"></span></a>
                        </td>';
                        echo '</tr>';
                    }
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
