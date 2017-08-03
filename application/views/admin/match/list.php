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
                <?php echo "Matches Information";?>
                <!--<a  href="<?php //echo site_url("admin").'/'.$this->uri->segment(2); ?>/add" class="btn btn-success">Add a new</a>-->
            </h2>
        </div>

        <div class="row">
            <div class="span12 columns">
                <table id="MyTable" class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Team1 Name</th>
                            <th>Team2 Name</th>
                            <th>Team1 Score</th>
                            <th>Team2 Score</th>
                            <th>Match Date</th>
                            <th>Match Time</th>
                            <!--<th>Country/Region</th>-->
                            <th>Venue</th>
                            <th>Status</th>
                            <th>Leauge</th>
                            <!--<th>Actions</th>-->
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                   $i =1;
                    foreach($match as $row) {
                        $team1_name = $row['team1_id'];
                        $team2_name = $row['team2_id'];
                        $season_name = $row['season_id'];
                        if(isset($teams) && isset($teams[$row['team1_id']])) {
                            $team1_name = $teams[$row['team1_id']];
                        }
                        if(isset($teams) && isset($teams[$row['team2_id']])) {
                            $team2_name = $teams[$row['team2_id']];
                        }
                        if(isset($seasons) && isset($seasons[$row['season_id']])) {
                            $season_name = $seasons[$row['season_id']];
                        }
                        echo '<tr>';
                        echo '<td>'.$i++.'</td>';
                        //echo '<td>'.$row['id'].'</td>';
                        echo '<td>'.$team1_name.'</td>';
                        echo '<td>'.$team2_name.'</td>';
                        echo '<td>'.$row['team1_score'].'</td>';
                        echo '<td>'.$row['team2_score'].'</td>';
                        echo '<td>'.$row['match_start_date'].'</td>';
                        echo '<td>'.$row['match_start_time'].'</td>';
                        //echo '<td>'.$row['country_id'].'</td>';
                       // echo '<td><img src="../assets/img/flags/24x24/' .$national_flags[$row['country_id']] . '.png"/></td>';
                        //echo '<td>'.$season_name.'</td>';
                        echo '<td>'.$row['venue'].'</td>';
                        echo '<td>'.$row['matchStatus'].'</td>';
                        echo '<td>'.$row['tournamentCalendar'].'</td>';
                        /*echo '<td class="crud-actions">
                        <a href="'.site_url("admin").'/match/update/'.$row['id'].'" class="btn btn-info" title="view & edit"><span class="glyphicon glyphicon-edit"></span></a>
                        <a href="'.site_url("admin").'/match/delete/'.$row['id'].'" class="btn btn-danger" title="delete"><span class="glyphicon glyphicon-remove"></span></a>
                        </td>';*/
                        echo '</tr>';
                    }
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
</div>
