<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Welcome to CodeIgniter</title>

	<style type="text/css">

	::selection{ background-color: #E13300; color: white; }
	::moz-selection{ background-color: #E13300; color: white; }
	::webkit-selection{ background-color: #E13300; color: white; }

	body {
		background-color: #fff;
		margin: 40px;
		font: 13px/20px normal Helvetica, Arial, sans-serif;
		color: #4F5155;
	}

	a {
		color: #003399;
		background-color: transparent;
		font-weight: normal;
	}

	h1 {
		color: #444;
		background-color: transparent;
		border-bottom: 1px solid #D0D0D0;
		font-size: 19px;
		font-weight: normal;
		margin: 0 0 14px 0;
		padding: 14px 15px 10px 15px;
	}

	code {
		font-family: Consolas, Monaco, Courier New, Courier, monospace;
		font-size: 12px;
		background-color: #f9f9f9;
		border: 1px solid #D0D0D0;
		color: #002166;
		display: block;
		margin: 14px 0 14px 0;
		padding: 12px 10px 12px 10px;
	}

	#body{
		margin: 0 15px 0 15px;
	}
	
	p.footer{
		text-align: right;
		font-size: 11px;
		border-top: 1px solid #D0D0D0;
		line-height: 32px;
		padding: 0 10px 0 10px;
		margin: 20px 0 0 0;
	}
	
	#container{
		margin: 10px;
		border: 1px solid #D0D0D0;
		-webkit-box-shadow: 0 0 8px #D0D0D0;
	}
	</style>
</head>
<body>
	
	<!--<video controls preload="auto" src="http://demo.codesamplez.com/html5/video/sample" width="100%"></video>-->
<video controls preload="auto" src="rtsp://54.171.155.221:1935/live/broadcast-55-9n1lozeiz5rv8atl9hs5cjkyx-1487316372159" width="25%"></video>


<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.8&appId=1191712694216694";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>





<div id="container">
	<h1>Teams Score!</h1>

	<div id="body">
		 <table border="1">  
      <tbody>  
         <tr>  
            <td><b>Country Id</b></td>  
            <td>Rank</td> 
            <td>Last Rank</td> 
            <td>contestant Id</td> 
            <td>contestant Name</td> 
            <td>contestant Short Name</td> 
            <td>contestant Club Name</td> 
            <td>contestant Code</td> 
            <td>Points</td> 
            <td>Matches Played</td>  
            <td>Matches Won</td> 
            <td>Matches Drawn</td> 
            <td>Goals For</td> 
            <td>Goals Against</td> 
            <td>Goal Difference</td>
         </tr>  
         <?php  
         foreach ($data as $row)  
         {  
			 //echo "<pre>";
			// print_r($row);
			 
            ?>
             <tr> 
             <td><?php echo $dd = $row['id'];?></td>  
            <td><?php echo $row['rank'];?></td> 
            <td><?php echo $row['lastRank'];?></td> 
            <td><?php echo $row['contestantId'];?></td> 
            <td><?php echo $row['contestantName'];?></td> 
            <td><?php echo $row['contestantShortName'];?></td> 
            <td><?php echo $row['contestantClubName'];?></td> 
            <td><?php echo $row['contestantCode'];?></td> 
            <td><?php echo $row['points'];?></td> 
            <td><?php echo $row['matchesPlayed'];?></td> 
            <td><?php echo $row['matchesWon'];?></td> 
            <td><?php echo $row['matchesDrawn'];?></td> 
            <td><?php echo $row['goalsFor'];?></td> 
            <td><?php echo $row['goalsAgainst'];?></td> 
            <td><?php echo $row['goaldifference'];?></td> 
            <td>
				<div class="fb-share-button" data-href="http://54.194.200.74/pundit-web/api/Game/teamstat/kxpw3rqn4ukt7nqmtjj62lbn" data-layout="button_count" data-size="small" data-mobile-iframe="true"><a class="fb-xfbml-parse-ignore" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2F54.194.200.74%2Fpundit-web%2Fapi%2FGame%2Fteamstat%2F&amp;src=sdkpreparse">Share</a></div></td>
            </tr>
           <?php }  
         ?>  
      </tbody>  
   </table>  
</div>
		</div>

	<p class="footer">Page rendered in <strong>{elapsed_time}</strong> seconds</p>
</div>

</body>
</html>

<html>
<head>
  <title>Your Website Title</title>
    <!-- You can use Open Graph tags to customize link previews.
    Learn more: https://developers.facebook.com/docs/sharing/webmasters -->
  <meta property="og:url"           content="http://54.194.200.74/pundit-web/api/Game/teamstat/kxpw3rqn4ukt7nqmtjj62lbn" />
  <meta property="og:type"          content="website" />
  <meta property="og:title"         content="Your Website Title" />
  <meta property="og:description"   content="Your description" />
  <meta property="og:image"         content="http://www.your-domain.com/path/image.jpg" />
</head>
<body>

  <!-- Load Facebook SDK for JavaScript -->
  <div id="fb-root"></div>
  <script>(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));</script>

  <!-- Your share button code -->
  <div class="fb-share-button" 
    data-href="http://54.194.200.74/pundit-web/api/Game/teamstat/kxpw3rqn4ukt7nqmtjj62lbn" 
    data-layout="button_count">
  </div>

</body>
</html>
