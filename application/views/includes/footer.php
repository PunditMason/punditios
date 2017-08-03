 <!-- footer content -->
        <footer>
          <div class="pull-right">
            <p class="right"><a href="#">Back to top</a></p>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="<?php echo base_url(); ?>assets/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="<?php echo base_url(); ?>assets/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="<?php echo base_url(); ?>assets/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="<?php echo base_url(); ?>assets/vendors/nprogress/nprogress.js"></script>
    <!-- Chart.js -->
    <script src="<?php echo base_url(); ?>assets/vendors/Chart.js/dist/Chart.min.js"></script>
    <!-- gauge.js -->
    <script src="<?php echo base_url(); ?>assets/vendors/gauge.js/dist/gauge.min.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="<?php echo base_url(); ?>assets/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="<?php echo base_url(); ?>assets/vendors/iCheck/icheck.min.js"></script>
    <!-- Skycons -->
    <script src="<?php echo base_url(); ?>assets/vendors/skycons/skycons.js"></script>
    <!-- Flot -->
    <script src="<?php echo base_url(); ?>assets/vendors/Flot/jquery.flot.js"></script>
    <script src="<?php echo base_url(); ?>assets/vendors/Flot/jquery.flot.pie.js"></script>
    <script src="<?php echo base_url(); ?>assets/vendors/Flot/jquery.flot.time.js"></script>
    <script src="<?php echo base_url(); ?>assets/vendors/Flot/jquery.flot.stack.js"></script>
    <script src="<?php echo base_url(); ?>assets/vendors/Flot/jquery.flot.resize.js"></script>
    <!-- Flot plugins -->
    <script src="<?php echo base_url(); ?>assets/vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
    <script src="<?php echo base_url(); ?>assets/vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
    <script src="<?php echo base_url(); ?>assets/vendors/flot.curvedlines/curvedLines.js"></script>
    <!-- DateJS -->
    <script src="<?php echo base_url(); ?>assets/vendors/DateJS/build/date.js"></script>
    <!-- JQVMap -->
    <script src="<?php echo base_url(); ?>assets/vendors/jqvmap/dist/jquery.vmap.js"></script>
    <script src="<?php echo base_url(); ?>assets/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
    <script src="<?php echo base_url(); ?>assets/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="<?php echo base_url(); ?>assets/vendors/moment/min/moment.min.js"></script>
    <script src="<?php echo base_url(); ?>assets/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="<?php echo base_url(); ?>assets/build/js/custom.min.js"></script>
    <script src="<?php echo base_url(); ?>assets/js/jquery.min.js"></script>
	<script src="<?php echo base_url(); ?>assets/js/bootstrap-datepicker.js"></script>
	<script src="<?php echo base_url(); ?>assets/js/bootstrap.min.js"></script>
	<script src="<?php echo base_url(); ?>assets/js/admin.min.js"></script>

	<script src="<?php echo base_url(); ?>assets/js/jquery.dataTables.min.js"></script>
	<script src="<?php echo base_url(); ?>assets/js/dataTables.bootstrap.min.js"></script>

<script>
	$(document).ready(function() {
		$('#MyTable').DataTable();

		$('.date-picker').datepicker({
            format: 'yyyy-mm-dd hh:ii:ss'
        });
	
	/*if($(".league_banner").length >0){	
		//Validate Image side
		var _URL = window.URL || window.webkitURL;
		$(".league_banner").change(function (e) {
			var file, img;
			if ((file = this.files[0])) {
				img = new Image();
				img.onload = function () {
					var width  = this.width ; 
					var height  = this.height ; 
					
					if(width < 300 || height < 300 ){
						
						$('.league_banner').val('');
						alert('Please select image Minimum Size 300*300');
						return false;
						
					}
					
					
				};
				img.src = _URL.createObjectURL(file);
			}
		});
	}	
	
		if($(".cover_banner").length >0){	
		//Validate Image side
		var _URL = window.URL || window.webkitURL;
		$(".cover_banner").change(function (e) {
			var file, img;
			if ((file = this.files[0])) {
				img = new Image();
				img.onload = function () {
					var width  = this.width ; 
					var height  = this.height ; 
					
					if(width < 640 || height < 480 ){
						
						$('.cover_banner').val('');
						alert('Please select image Minimum Size 640*480');
						return false;
						
					}
					
					
				};
				img.src = _URL.createObjectURL(file);
			}
		});
	}	
	
		if($(".banner_validate").length >0){
			var _URL = window.URL || window.webkitURL;
			$(".banner_validate").change(function (e) {
				var file, img;
				if ((file = this.files[0])) {
					img = new Image();
					img.onload = function () {
						var width  = this.width ; 
						var height  = this.height ; 
						
						if(width < 500 || height < 400 ){
							
							$('.banner_validate').val('');
							alert('Please select image Minimum Size 500*400');
							return false;
							
						}
						
						
					};
					img.src = _URL.createObjectURL(file);
				}
			});
		
		}*/
	
	});
	
	
</script>
	
  </body>
</html>	
	
	
	
	
