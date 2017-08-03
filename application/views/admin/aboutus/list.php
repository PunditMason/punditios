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
            <!--<h2>
                <?php //echo ucfirst($this->uri->segment(2));?>
                <a  href="<?php //echo site_url("admin").'/'.$this->uri->segment(2); ?>/add" class="btn btn-success">Add a new</a>
            </h2>-->
        </div>

        <div class="row">
            <div class="span12 columns">
                <table id="MyTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Title</th>
                            <th>Content</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    foreach($aboutus as $row) {
                        echo '<tr>';
                        echo '<td>'.$row['id'].'</td>';
                        echo '<td>'.$row['title'].'</td>';
						echo '<td>'.$row['content'].'</td>';
                        
                        echo '<td class="crud-actions">
                        <a href="'.site_url("admin").'/aboutus/update/'.$row['id'].'" class="btn btn-info" title="view & edit"><span class="glyphicon glyphicon-edit"></span></a>
                        <!--<a href="'.site_url("admin").'/aboutus/delete/'.$row['id'].'" class="btn btn-danger" title="delete"><span class="glyphicon glyphicon-remove"></span></a>-->
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
