<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@page import="DAO.userDAO"%>
<%@page import="Model.User"%>

<%
    String userType = (String) session.getAttribute("position");
    int user_id = (Integer) session.getAttribute("user_id");
    if (!userType.equalsIgnoreCase("admin") && !userType.equalsIgnoreCase("root")){
        response.sendRedirect("access-denied.jsp");
        return;
    }
    
    userDAO uDAO = new userDAO();
    int numberOfRegisteredUsers = uDAO.getRegisteredUsers();
    int numberOfActiveUsers = uDAO.getActiveUsers();
    int numberOfInactiveUsers = uDAO.getInactiveUsers();
    
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

    <!-- Custom Theme Style -->
    <link href="source/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
      
      
    <div class="container body">
      <div class="main_container">

       <jsp:include page="/sidebar_admin.jsp" />
       
        <!-- page content -->
        <div class="right_col edited" role="main">
         
            

                        
                        <!--banner-->
                        <%
                            String error=(String)request.getAttribute("error");  
                            if(error!=null){
                         %> 
                            <div class="alert alert-danger alert-dismissible fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                            </button>
                            <h2><span class="fa fa-exclamation"></span> <%=error%></h2>
                          </div>
                         <%}%>
                         <%
                            String success=(String)request.getAttribute("success");  
                            if(success!=null){
                         %>
                           <div class="alert alert-success alert-dismissible fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                            </button>
                            <h2><span class="fa fa-check-circle"></span> <%=success%></h2>
                          </div>
                          <%}%>
                        <!--banner-->
                        
            
            
         <div class="row top_tiles">
              <div class="animated flipInY col-lg-4 col-md-6 col-sm-6 col-xs-12">
                <div class="tile-stats">
                  <div class="icon"><i class="fa fa-group"></i></div>
                  <div class="count"><%=numberOfRegisteredUsers%></div>
                  <h3>No. of Registered Users</h3>
                </div>
              </div>
              <div class="animated flipInY col-lg-4 col-md-6 col-sm-6 col-xs-12">
                <div class="tile-stats">
                  <div class="icon success"><i class="fa fa-user"></i></div>
                  <div class="count"><%=numberOfActiveUsers%></div>
                  <h3>No. of Active Users</h3>
                </div>
              </div>
              <div class="animated flipInY col-lg-4 col-md-6 col-sm-6 col-xs-12">
                <div class="tile-stats">
                  <div class="icon warning"><i class="fa fa-user"></i></div>
                  <div class="count"><%=numberOfInactiveUsers%></div>
                  <h3>No. of Deactivated Users</h3>
                </div>
              </div>
            </div><!--/row top_tiles-->

          <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
              
            </div>

          </div>
          
          <br />
              
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
<!--            2017 &copy; De La Salle University-->
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

    <!-- Custom Theme Scripts -->
    <script src="source/js/custom.min.js"></script>
    
    <script>
    var ctx = document.getElementById("myChart").getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
            datasets: [{
                label: '', //name of diagnosis
                data: [12, 19, 3, 5, 2, 3], //values of dianosis
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
</script>
	
  </body>
</html>
