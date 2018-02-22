<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="Model.Patient"%>
<%@page import="Model.Diagnosis"%>
<%@page import="Model.Chart"%>
<%@page import="Model.Medication"%>
<%@page import="Model.User"%>
<%@page import="Model.Family_Code"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="DAO.userDAO"%>
<%@page import="DAO.chartsDAO"%>
<%@page import="Model.Consultation"%>
<%@page import="java.util.ArrayList"%>
<% chartsDAO chartsDAO = new chartsDAO();%>
<% nurseDAO nDAO = new nurseDAO();%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

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

    <!-- Custom Theme Style -->
    <link href="source/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
      
      
    <div class="container body">
      <div class="main_container">
        
        <jsp:include page="/sidebar.jsp" />

        <!-- page content -->
        <div class="right_col edited" role="main">
        <form action="ChartController" method="post">
            
        <!-- CONSULTATIONS BY GENDER -->  
        <div class="row">
            <div class="col-md-12 col-sm-8 col-xs-12">
                <div class="x_panel">
            
                    <div class="x_title">
                        <h2>Consultations by Age Groups <small>Graph</small></h2>
                        <ul class="nav navbar-right panel_toolbox">
                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                            <ul class="dropdown-menu" role="menu">
                            <li><a href="#">Settings 1</a>
                            </li>
                            <li><a href="#">Settings 2</a>
                            </li>
                            </ul>
                        </li>
                        <li><a class="close-link"><i class="fa fa-close"></i></a>
                        </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    
                    <h4 class="card-title">Consultations</h4>
                    
                    <div class="x_content">     
                        <canvas id="consultationsByAgeGroup" width="400" height="150"></canvas>
                    </div><!--x_content-->
                    
                    
                </div><!--x_panel-->
            </div><!--col-md-4-->
        </div>
        
        </form>
          
        <script src="vendors/Chart.js/dist/Chart.min.js"></script>
        
    <script>

        function consultationsByAgeGroup(){
            var chart1 = new Chart(document.getElementById('consultationsByAgeGroup').getContext('2d'), {
                // The type of chart we want to create
                type: 'bar',
                data: {
                    labels: [<%
                            //chartsDAO chartsDAO = new chartsDAO();
                            ArrayList <Chart> list4  = new ArrayList();
                            list4 = chartsDAO.consultationsByBarangay();
                            for(int i = 0; i < list4.size(); i++){
                                out.print("\"");
                                out.print(list4.get(i).getTypeOfConsultation() + "\""+",");
                            }    
                    %>],
                    datasets: [{
                        label: "Number of Consultations",
                        data: [<%
                            for(int i = 0; i < list4.size(); i++){
                                out.print("\"");
                                out.print(list4.get(i).getNumOfConsultation() + "\""+",");
                            }    
                    %>],
                                                                
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)',
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            ],
                        borderColor: [
                            'rgba(255,99,132,1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)',
                            'rgba(255,99,132,1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            ],
                        borderWidth: 1,
                            
                    }]
                },

                // Configuration options go here
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                                userCallback: function(label, index, labels) {
                                    // when the floored value is the same as the value we have a whole number
                                    if (Math.floor(label) === label) {
                                        return label;
                                    }
                                },
                            }
                        }]
                    }
                }
            });
        }
        drawChart4();


    </script>

          
        
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
            Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
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

    <!-- Custom Theme Scripts -->
    <script src="source/js/custom.min.js"></script>

  </body>
</html>
