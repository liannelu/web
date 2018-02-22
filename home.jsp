<%@page import="DAO.userDAO"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="DAO.programDAO"%>
<%@page import="Model.Diagnosis"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.util.ArrayList"%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date;"%>

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%
    String userType = (String) session.getAttribute("position");
    int user_id = (Integer) session.getAttribute("user_id");
    if (!userType.equalsIgnoreCase("root")){
        response.sendRedirect("access-denied.jsp");
        return;
    }
    
     programDAO pDAO = new programDAO();
%>


<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> PBIS </title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="vendors/iCheck/skins/flat/green.css" rel="stylesheet">
	
    <!-- bootstrap-progressbar -->
    <link href="vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
    <!-- bootstrap-daterangepicker -->
    <link href="vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="source/css/custom.min.css" rel="stylesheet">
  </head>

    
    
  <body class="nav-md">
     
      
    <div class="container body">
      <div class="main_container">
        
        <jsp:include page="/sidebar.jsp" />


          
          
          
        <!-- page content -->
        <div class="right_col" role="main">
                     

        <!-- check if may nahanap na prompts-->
        <% 
        Calendar cal = Calendar.getInstance();
        int lastDayOfMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        int month = cal.get(Calendar.MONTH);//month starts at 0
        int dayOfMonth = cal.get(Calendar.DAY_OF_MONTH);

        if(dayOfMonth >= (lastDayOfMonth-4) || dayOfMonth <= 3){
            session.setAttribute("checkThreshold", true);
        }

        if(session.getAttribute("checkThreshold") != null && (Boolean) session.getAttribute("checkThreshold") == true){

            ArrayList <Diagnosis> list = new ArrayList();
            list = pDAO.checkThreshold();

            if(!list.isEmpty()){
            %> 
            <!-- ALERTS FOR PRESCRIPTIVE -->
            <form action="SelectDisease" method="post">

<div class="panel panel-danger">
<div class="panel-heading clearfix">
    <h4 class="panel-title pull-left" style="padding-top: 7.5px;"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Warning</h4>
</div>
<div class="panel-body">
    <div class="x_content">
                    <table class="table table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>Disease</th>
                                <th>Description</th>
                                <th>Action</th>
                        </thead>

                        <tbody>
                                <%
                                    //userDAO uDAO = new userDAO();
                                    //ArrayList <User> users  = new ArrayList();
                                    //users = uDAO.retrieveAllUsers();

                                    for(int i = 0; i<list.size(); i++) {
                                    //int selectedUser = users.get(i).getUser_id();
                                %>
                              <tr>
                                  <td style="text-align:left; width:200px;"><span class="fa fa-exclamation-triangle" aria-hidden="true" style="color: orange"></span>&nbsp;&nbsp;<%=list.get(i).getDiagnosis()%></td>
                                  <td> Reached/Exceeded the threshold. You may want to create a program for this disease. </td>
                                  <td><button type="submit" name="selectedDisease" value="<%=list.get(i).getDiagnosis_id()%>" id="viewuser" class="btn btn-primary btn-sm"><i class="fa fa-eye"></i>View</button></td>
                              </tr>
                              <%}%>
                          </tbody>

                    </table>
                </div>

</div>
</div>

            <% 
                }
            } 
            %>    
            </form>
          <!--END OF ALERTS-->
                        

          <!-- top tiles -->
          <div class="row tile_count">
            <div class="col-md-4 tile_stats_count">
              <span class="count_top"><i class="fa fa-pencil-square-o"></i> Pending Consultations Today</span>
              <div class="count">24</div>
              <span class="count_bottom"><i class="green">4% </i> note</span>
            </div>
              
            <div class="col-md-4 tile_stats_count">
              <span class="count_top"><i class="fa fa-pencil-square-o"></i> Total Consultations Today</span>
              <div class="count">50</div>
              <span class="count_bottom"><i class="green">4% </i> From Yesterday</span>
            </div>
              
<!--
            <div class="col-md-3 tile_stats_count">
              <span class="count_top"><i class="fa fa-clock-o"></i> Average Time</span>
              <div class="count">123.50</div>
              <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>3% </i> From last Week</span>
            </div>
-->
            <div class="col-md-4  tile_stats_count">
              <span class="count_top"><i class="fa fa-users"></i> Total Patients Registered</span>
              <div class="count green">10</div>
              <span class="count_bottom">
                  <i class=""><i class="fa fa-calendar-o"></i> DATE </i> 
                  since Last Active Program </span>
            </div>
              

          </div>
          <!-- /top tiles -->

          <div class="row">
              <!--TABLE-->
            <div class="col-md-8 col-sm-8 col-xs-12">
               <div class="x_panel">
                
                <div class="x_title">
                <h2><i class="fa fa-pencil-square-o"></i> Pending consultations / Follow up <strong>Today</strong></h2>
                
                <div class="clearfix"></div>
                 </div>
                 
                 <div class="x_content">
                    <table id="datatable-consultations-today" class="table table-bordered dt-responsive nowrap" cellspacing="0" width="100%" style="overflow: visible;">
                          <thead>
                            <tr>
                              <th width="1%">Date of Visit</th>
                              <th>Consultation #</th>
                              <th>Purpose of Visit</th>
                              <th>Diagnosis</th>
                              <th>Added By</th>
                              <th>Acknowledged By</th>
                              <th>Status</th>
                              <th>Action</th>
                            </tr>
                          </thead>
                          <tbody></tbody>
                     </table>
                 </div><!--x_content-->
              </div><!--x_panel-->
            </div><!--/col-md-8-->

              
              
            <div class="col-md-4">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><i class="fa fa-align-left"></i> Watch List <small></small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
<!--
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>

                      </li>
-->
<!--                      <li><a class="close-link"><i class="fa fa-close"></i></a>-->
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <!-- start accordion -->
                    <div class="accordion" id="accordion1" role="tablist" aria-multiselectable="true">
                        
                        
                        
                      <div class="panel">
                        <a class="panel-heading" role="tab" id="headingOne1" data-toggle="collapse" data-parent="#accordion1" href="#collapseOne1" aria-expanded="true" aria-controls="collapseOne">
                          <h4 class="panel-title">By Higest Diagnosis Count</h4>
                        </a>
                        <div id="collapseOne1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                          <div class="panel-body">
                            <table class="table table-striped">
                              <thead>
                                <tr>
                                    <th>#</th>
                                  <th width="80%">Diagnosis</th>
                                  <th>Count</th>
                                  <th>Threshold</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                <td>1</td>
                                  <th scope="row">Dengue</th>
                                  <td>99</td>
                                  <td>99</td>

                                </tr>
                                <tr>
                                    <td>2</td>
                                  <th scope="row">Diabetes</th>
                                  <td>80</td>
                                  <td>99</td>

                                </tr>

                              </tbody>
                            </table>
                          </div>
                        </div>
                      </div>
                        
                        

                        
                        
                        
                        
                        
                      <div class="panel">
                         <a class="panel-heading collapsed" role="tab" id="headingTwo1" data-toggle="collapse" data-parent="#accordion1" href="#collapseTwo1" aria-expanded="false" aria-controls="collapseTwo">
                          <h4 class="panel-title">By Barangay Consultation</h4>
                        </a>
                        <div id="collapseOne1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                          <div class="panel-body">
                            <table class="table table-striped">
                              <thead>
                                <tr>
                                    <th>#</th>
                                  <th width="80%">Barangay</th>
                                  <th>Count</th>
                                  <th>Threshold</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                <td>1</td>
                                  <th scope="row">Sto Domingo</th>
                                  <td>99</td>
                                  <td>99</td>

                                </tr>
                                <tr>
                                    <td>2</td>
                                  <th scope="row">Sto Rosario</th>
                                  <td>80</td>
                                  <td>99</td>

                                </tr>

                              </tbody>
                            </table>
                          </div>
                        </div>
                      </div>
                    
                        
<!--
                      <div class="panel">
                        <a class="panel-heading collapsed" role="tab" id="headingTwo1" data-toggle="collapse" data-parent="#accordion1" href="#collapseTwo1" aria-expanded="false" aria-controls="collapseTwo">
                          <h4 class="panel-title">Collapsible Group Item #2</h4>
                        </a>
                        <div id="collapseTwo1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                          <div class="panel-body">
                            <p><strong>Collapsible Item 2 data</strong>
                            </p>
                            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor,
                          </div>
                        </div>
                      </div>
-->

                    </div>
                    <!-- end of accordion -->


                  </div>
                </div>        
              </div>
              
              
              
              
              
              
              
        
              
              
              
              
              
              
              
              
              
          </div>
          <br />

            
            
            
            
            
            
            
          

            <div class="row">
            <div class="x_panel">
                  <div class="x_title">
                       <h3>TOP 1 DIAGNOSIS OF RHU I PER MONTH <small> Graph title sub-title</small></h3>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
<!--
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
-->
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content"><iframe class="chartjs-hidden-iframe" style="width: 100%; display: block; border: 0px; height: 0px; margin: 0px; position: absolute; left: 0px; right: 0px; top: 0px; bottom: 0px;"></iframe>
                    <canvas id="mybarChart" width="494" height="247" style="width: 494px; height: 247px;"></canvas>
                  </div>
                </div>
             
            </div>
                        
            
          
          <br />
              
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
<!--              2017 &copy; De La Salle University-->
              <i class="fa fa-stethoscope"></i> Pampanga's Best Information System: A Rural Health Unit Decision Support and Information System
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="vendors/nprogress/nprogress.js"></script>
    <!-- Chart.js -->
    <script src="vendors/Chart.js/dist/Chart.min.js"></script>
    <!-- gauge.js -->
    <script src="vendors/gauge.js/dist/gauge.min.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="vendors/iCheck/icheck.min.js"></script>
    <!-- Skycons -->
    <script src="vendors/skycons/skycons.js"></script>
    <!-- Flot -->
    <script src="vendors/Flot/jquery.flot.js"></script>
    <script src="vendors/Flot/jquery.flot.pie.js"></script>
    <script src="vendors/Flot/jquery.flot.time.js"></script>
    <script src="vendors/Flot/jquery.flot.stack.js"></script>
    <script src="vendors/Flot/jquery.flot.resize.js"></script>
    <!-- Flot plugins -->
    <script src="vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
    <script src="vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
    <script src="vendors/flot.curvedlines/curvedLines.js"></script>
    <!-- DateJS -->
    <script src="vendors/DateJS/build/date.js"></script>
    <!-- JQVMap -->
    <script src="vendors/jqvmap/dist/jquery.vmap.js"></script>
    <script src="vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
    <script src="vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="vendors/moment/min/moment.min.js"></script>
    <script src="vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!-- Datatables -->
    <script src="vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="source/js/custom.min.js"></script>
    
 
<!--<script>
var ctx = document.getElementById("myChart").getContext('2d');
    
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["hello", "yes"], //name
        datasets: [{
            label: 'Number of Diagnosis', //tile
            data: [1,2,3,4,3], //values of dianosis
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
    
</script>-->
<script>
$(document).ready(function() {    
    $('#datatable-consultations-today').DataTable( {
        "order": [[0, "desc"]],
        responsive: true,
    });
} );
</script>
 <script>
  $(function() {
  var people = [];
   $.getJSON('charts/topdiagnosis.jsp', function(data) {
     $.each(data.diagnosisdetails, function(i, f) {
       var tblRow = "<tr>" + "<td>" + f.DIAGNOSISNAME + "</td>" + "<td>" + f.NUMBEROFDIAGNOSIS + "</tr>"
       $(tblRow).appendTo("#userdata tbody");
    });
   });
  });
</script>
  
<script>
 function drawChart() { 
    
     var jsonData = $.ajax({
        url: 'charts/topdiagnosis.jsp',
        dataType: 'json',
      }).done(function (results) {

        // Split diagnosis name and the value into separate arrays
        var labels = [], number=[];
        results["diagnosisdetails"].forEach(function(packet) {
          labels.push(packet.DIAGNOSISNAME);
          number.push(parseInt(packet.NUMBEROFDIAGNOSIS));
        });


        var ctx = document.getElementById("myChart").getContext('2d');

        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels, //name
                datasets: [{
                    label: 'No. of Diagnosis', //tile
                    data: number, //values of dianosis
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero:true
                        }
                    }]
                }
            }
        }); 

     });
 }
    
drawChart();
    </script>

<!--<script>
$(document).ready(function(){
	$.ajax({
		url: "db_connection.jsp",
		type: "GET",
		success: function(data) {
			console.log(data);
			var player = [];
			var score = [];

			for(var i in data) {
				player.push("Player " + data[i].DIAGNOSISNAME);
				score.push(data[i].NUMBEROFDIAGNOSIS);
			}

			var chartdata = {
				labels: player,
				datasets : [
					{
						label: 'Disease',
						backgroundColor: 'rgba(200, 200, 200, 0.75)',
						borderColor: 'rgba(200, 200, 200, 0.75)',
						hoverBackgroundColor: 'rgba(200, 200, 200, 1)',
						hoverBorderColor: 'rgba(200, 200, 200, 1)',
						data: score
					}
				]
			};

			var ctx = $("#myChart");

			var barGraph = new Chart(ctx, {
				type: 'bar',
				data: chartdata
			});
		},
		error: function(data) {
			console.log(data);
		}
	});
});
</script>-->
	
  </body>
</html>
