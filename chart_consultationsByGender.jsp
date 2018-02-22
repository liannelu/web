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
<% nurseDAO nDAO = new nurseDAO();
    int tempYear = 0;
    String tempBarangay = "";
%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%
    
    /*
    String userType = (String) session.getAttribute("position");
    int user_id = (Integer) session.getAttribute("user_id");
    out.println("The user id is "+user_id);
    if (!userType.equalsIgnoreCase("root")){
        response.sendRedirect("access-denied.jsp");
        return;
    }
*/
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
    <!-- DAGDAG bootstrap datapicker-->
    <link href="vendors/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" rel="stylesheet">
	
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
        
        <%
           String userType = (String) session.getAttribute("position");
            
            //ACCESS CONTROL
            if (!userType.equalsIgnoreCase("root") && !userType.equalsIgnoreCase("physician") && !userType.equalsIgnoreCase("nurse")){
                response.sendRedirect("access-denied.jsp");
                return;
            }
            
            //SIDEBAR INCLUDE//
            if (userType.equalsIgnoreCase("root")){ %>
                <jsp:include page="/sidebar.jsp" />
        <%} else if (userType.equalsIgnoreCase("physician")){ %>
                <jsp:include page="/sidebar_doctor.jsp" />
        <%} else if (userType.equalsIgnoreCase("nurse") || userType.equalsIgnoreCase("encoder") || userType.equalsIgnoreCase("midwife")){ %>
                <jsp:include page="/sidebar_nurse.jsp" />
        <%} else if (userType.equalsIgnoreCase("admin")){ %>
                <jsp:include page="/sidebar_admin.jsp" />
        <%}%>
        <!-- page content -->
        <div class="right_col edited" role="main">
        <form action="ChartController" method="post">
            
        <!-- CONSULTATIONS BY GENDER -->  
        <div class="row">
            <div class="col-md-12 col-sm-8 col-xs-12">
                <div class="x_panel">
            
                    <div class="x_title">
                        <h2>Consultations by Gender <small>Graph</small></h2>
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
                    
                    <div class="row col-md-3">
                                <div class="form-group-row">
                                    <label for="example-date-input" class="col-2 col-form-label">Barangay</label>
                                    <!--INSERT DATA FROM DB-->
                                    <div class="col-3">
                                        <select id="select" name="selectedBarangay" class="form-control">
                                            <option value="RHU1">RHU 1</option>
                                            <option value="Dolores">Dolores </option>
                                            <option value="Juliana">Juliana</option>
                                            <option value="Lourdes">Lourdes</option>
                                            <option value="Magliman">Magliman</option>
                                            <option value="San Jose">San Jose</option>
                                            <option value="San Juan">San Juan</option>
                                            <option value="Sto. Rosario">Sto. Rosario</option>
                                            <option value="Sta. Teresita">Sta. Teresita</option>
                                            <option value="Sto. Nino">Sto. Nino</option>
                                        </select>
                                    </div>
                                </div>
                    </div>
                    
                    <!-- YEAR PICKER -->
                    <div class="col-md-2">
                        <label for="example-month-input" class="col-2 col-form-label">Year</label>
                        <div class="col-12">

                            <input name="selectedDate" id="selectedDate" value="<%
                                if(session.getAttribute("chartYear") != null){
                                    out.print((Integer) session.getAttribute("chartYear"));
                                }else{
                                    int year = Calendar.getInstance().get(Calendar.YEAR);
                                    out.print(year);
                                }

                                   %>" class="form-control " />  
                        </div>
                    </div>
                    
                    <!-- GENERATE BUTTON -->
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <label for="" class="col-2 col-form-label"></label>
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary " name="generateBtn" value="consultationsByGenderChart" style="margin-top: 4px;">Generate Report</button>
                            <a href="program_planning_without_disease.jsp" class="btn btn-primary " style="margin-top: 4px;"><i class="fa fa-file-text-o"></i> Propose Program</a>
                        </div>
                    </div>
                    
                    
                    <div class="x_panel">
                        <%if(session.getAttribute("chartBarangay") != null && session.getAttribute("chartYear") != null){%>
                                <h4><label class="control-label">Selected Barangay: </label> <%out.print(session.getAttribute("chartBarangay"));%></h4>
                                <h4><label class="control-label">Selected Year: </label> <%out.print(session.getAttribute("chartYear"));%></h4>
                        <%}%>
                        <h4 class="card-title">Male Consultations</h4>
                        <div class="x_content">     
                            <canvas id="consultationsByGenderChartM" width="400" height="150"></canvas>
                        </div><!--x_content-->
                    </div>
                    
                    <div class="x_panel">
                        <h4 class="card-title">Female Consultations </h4>
                        <div class="x_content">     
                            <canvas id="consultationsByGenderChartF" width="400" height="150"></canvas>
                        </div><!--x_content-->
                    </div>
                    
                </div><!--x_panel-->
            </div><!--col-md-4-->
        </div>
        
        </form>
          
        
        <script src="vendors/Chart.js/dist/Chart.min.js"></script>
        
    <script>

        //consultations by gender MALE
        function consultationsByGenderChartM(){
            var chart1 = new Chart(document.getElementById('consultationsByGenderChartM').getContext('2d'), {
                // The type of chart we want to create
                type: 'bar',
                data: {
                    labels: [<%
                            //chartsDAO chartsDAO = new chartsDAO();
                            ArrayList <Chart> list4  = new ArrayList();
                            if(session.getAttribute("chartYear") != null && session.getAttribute("chartBarangay") != null){
                                tempYear = (Integer) session.getAttribute("chartYear");
                                tempBarangay = (String) session.getAttribute("chartBarangay");
                            }
                            list4 = chartsDAO.consultationsByGenderMale(tempYear, tempBarangay);
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
        //drawChart4();
        
        //consultations by gender MALE
        function consultationsByGenderChartF(){
            var chart1 = new Chart(document.getElementById('consultationsByGenderChartF').getContext('2d'), {
                // The type of chart we want to create
                type: 'bar',
                data: {
                    labels: [<%
                            //chartsDAO chartsDAO = new chartsDAO();
                            ArrayList <Chart> list3  = new ArrayList();
                            if(session.getAttribute("chartYear") != null && session.getAttribute("chartBarangay") != null){
                                tempYear = (Integer) session.getAttribute("chartYear");
                                tempBarangay = (String) session.getAttribute("chartBarangay");
                           
                            }
                            list3 = chartsDAO.consultationsByGenderFemale(tempYear, tempBarangay);
                            for(int i = 0; i < list3.size(); i++){
                                out.print("\"");
                                out.print(list3.get(i).getTypeOfConsultation() + "\""+",");
                            }    
                    %>],
                    datasets: [{
                        label: "Number of Consultations",
                        data: [<%
                            for(int i = 0; i < list3.size(); i++){
                                out.print("\"");
                                out.print(list3.get(i).getNumOfConsultation() + "\""+",");
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
        //drawChart5();

    </script>
        
    <%
            if(session.getAttribute("chartYear") != null && session.getAttribute("chartBarangay") != null){%>
            <script>
                  consultationsByGenderChartM();
                  consultationsByGenderChartF();
                </script>
            <%}        
          %>
          
        
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
    
<!-- DAGDAG bootstrap datepicker -->
    <script src="vendors/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>



  </body>
  
  <!--DAGDAG YEAR ADSJFLKADJS-->
   <script type="text/javascript">
         $('#selectedDate').datepicker({
         minViewMode: 2,
         format: 'yyyy'
       });

    </script>

</html>
