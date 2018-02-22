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
<%  nurseDAO nDAO = new nurseDAO();
    int tempYear = 0;
    int tempDiagnosis = 0;
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
        <!-- prettyCheckbox -->
        <link href="vendors/pretty-checkbox/src/pretty.min.css" rel="stylesheet">
        <!-- bootstrap-daterangepicker -->
        <link href="vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
        <!-- bootstrap-datetimepicker -->
        <link href="vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
        <!-- bootstrap-wysiwyg -->
        <link href="vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet">
        <!-- Select2 -->
        <link href="vendors/select2/dist/css/select2.min.css" rel="stylesheet">
        <!-- Switchery -->
        <link href="vendors/switchery/dist/switchery.min.css" rel="stylesheet">
        <!-- starrr -->
        <link href="vendors/starrr/dist/starrr.css" rel="stylesheet">
        <!-- bootstrap-daterangepicker -->
        <link href="vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
        <!-- time Picker -->
        <link rel="stylesheet" href="vendors/timepicker/bootstrap-timepicker.min.css">
        
        <!--NEW ADDITIONS-->
        <link rel="stylesheet" href="vendors/bootstrap-multiselect/dist/css/bootstrap-multiselect.css" type="text/css"/>

        <!-- Custom Theme Style -->
        <link href="source/css/custom.min.css" rel="stylesheet">
  </head>
  
  
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
    <!--MULTI SELECT-->
    <link rel="stylesheet" href="vendors/bootstrap-multiselect/dist/css/bootstrap-multiselect.css" type="text/css"/>
    
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

        <!-- SAMPLE LINE CHART-->
        <div class="row">
            <div class="col-md-12 col-sm-8 col-xs-12">
                <div class="x_panel ">
                    
                    <div class="x_title">
                        <h2>Disease/Diagnosis Chart <small>Graph</small></h2>
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
                    
                    <div class="x_content">
                        <h6 class="card-subtitle mb-2 text-muted">Select Barangay and Month & Year</h6>
                        <p class="card-text">
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
                            
                            <!-- DIAGNOSIS PICKER -->
                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label class="control-label">Disease/Diagnosis:</label>
                                </div>
                                <div class="col-md-5">
                                    <select class="diagnosis-multiple" name="diagnosis1" style="width: 100%;">
                                        <%
                                            ArrayList <Diagnosis> dList = new ArrayList();
                                            dList = nDAO.getAllDiseases();
                                        for(int x=0; x < dList.size();x++){
                                        %>
                                            <option value = "<%=dList.get(x).getDiagnosis_id()%>"> <%=dList.get(x).getDiagnosis()%></option>
                                        <%}%>
                                    </select>

                                </div>
                            </div>

                            <!-- GENERATE BUTTON -->
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <label for="" class="col-2 col-form-label"></label>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary " name="generateBtn" value="diseaseChart1" style="margin-top: 4px;">Generate Report</button>
                                    <a href="program_planning_without_disease.jsp" class="btn btn-primary " style="margin-top: 4px;"><i class="fa fa-file-text-o"></i> Propose Program</a>
                                </div>
                            </div>
                                        
                    </div> <!--x_content-->
                    
                    <div class="x_panel">
                        <div class="x_content">   
                                <!-- LABEL FOR SELECTED DIAGNOSIS: -->
                                <%if(session.getAttribute("diseaseChartDiagnosis1") != null && session.getAttribute("chartBarangay") != null && session.getAttribute("chartYear") != null){
                                    Diagnosis d1 = nDAO.getDiagnosis((Integer) session.getAttribute("diseaseChartDiagnosis1"));
                                %>
                                <h4><label class="control-label">Selected Disease/Diagnosis: </label> <%out.print(d1.getDiagnosis());%></h4>
                                <h4><label class="control-label">Selected Barangay: </label> <%out.print(session.getAttribute("chartBarangay"));%></h4>
                                <h4><label class="control-label">Selected Year: </label> <%out.print(session.getAttribute("chartYear"));%></h4>
                                <%}%>
                            <canvas id="diseaseChart1" width="400" height="150"></canvas>
                        </div><!--x_content-->
                    </div><!--x_panel-->
                    
                </div> <!--x_panel-->
                     
            </div><!--col-md-4-->
            
        </div><!--row-->
          
        </form>
        
        <script src="vendors/Chart.js/dist/Chart.min.js"></script>
        
        <script>
            //Create ng onload function
            //var ctx = document.getElementById('myChart').getContext('2d');
           
        var MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

        function diseaseChart1(){
            
            var ctx = document.getElementById("diseaseChart1").getContext('2d');
            //var myChart = new Chart(ctx, {
            
            var myChart = new Chart(ctx, {
                // The type of chart we want to create
                type: 'line',
                data: {
                    labels: MONTHS,
                    datasets: [{
                        label: "Number of Cases",
                        data: [<%
                            
                            ArrayList <Chart> list2  = new ArrayList();
                            int a = 0;                          
                            int b = 0;                                
                            String c = "";                      
                            int threshold = 0; //threshold
                            
                            
                            if(session.getAttribute("diseaseChartDiagnosis1") != null && session.getAttribute("chartYear") != null && session.getAttribute("chartBarangay") != null){
                                tempDiagnosis = (Integer) session.getAttribute("diseaseChartDiagnosis1");
                                Diagnosis d = nDAO.getDiagnosis(tempDiagnosis);
                                //threshold = d.getThreshold();
                                threshold = 20;
                                session.setAttribute("diseaseThreshold", 30);
                                
                                tempYear = (Integer) session.getAttribute("chartYear");
                                tempBarangay = (String) session.getAttribute("chartBarangay");
                                
                            }
                            list2 = chartsDAO.diseaseChart1(tempDiagnosis,tempYear,tempBarangay);
                            /*for(int i = 0; i < list2.size(); i++){
                                out.print("\"");
                                out.print(list2.get(i).getMonth() + "\""+",");
                            }*/
                            
                            int countList = 0;
                            for(int i = 1; i <= 12; i++){ //start on 1 for months  //1-12
                                if(countList != list2.size()){
                                    int y = chartsDAO.getMonthInt(list2.get(countList).getMonth());
                                    if(i == y){
                                        out.print("\"");
                                        out.print(list2.get(countList).getNumOfCases() + "\""+",");
                                        countList ++;
                                    }else{
                                        out.print("\"");
                                        out.print(0 + "\""+",");
                                    }
                                }/*else{
                                    out.print("\"");
                                    out.print(0 + "\""+",");
                                }*/
                            }
                            
                    %>],
                        borderColor: "#3e95cd",                                    
                        borderWidth: 1.5,                                    
                    
                    }]
                },
                // Configuration options go here
                options: {
                    lineAt: <%out.print(threshold);%>,
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
        
 Chart.pluginService.register({
    afterDraw: function(chart) {
        if (typeof chart.config.options.lineAt != 'undefined') {
        	var lineAt = chart.config.options.lineAt;
            var ctxPlugin = chart.chart.ctx;
            var xAxe = chart.scales[chart.config.options.scales.xAxes[0].id];
            var yAxe = chart.scales[chart.config.options.scales.yAxes[0].id];
           	
            // I'm not good at maths
            // So I couldn't find a way to make it work ...
            // ... without having the `min` property set to 0
            if(yAxe.min != 0) return;
            
            ctxPlugin.strokeStyle = "red";
        	ctxPlugin.beginPath();
            lineAt = (lineAt - yAxe.min) * (100 / yAxe.max);
            lineAt = (100 - lineAt) / 100 * (yAxe.height) + yAxe.top;
            ctxPlugin.moveTo(xAxe.left, lineAt);
            ctxPlugin.lineTo(xAxe.right, lineAt);
            ctxPlugin.stroke();
        }
    }
});
          </script>
          
          
          
        <!-- IF MAY NAPILI NA DATE -->  
          <%
            if(session.getAttribute("diseaseChartDiagnosis1") != null){%>
            <script>
                  diseaseChart1();
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
    <!-- Select2 -->
    <script src="vendors/select2/dist/js/select2.full.min.js"></script>
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
    <script>
    
    $(document).ready(function() {
        $('.diagnosis-multiple').select2();
    });

    $(document).ready(function() {
        $(".diagnosis-multiple").select2({
        tags: true
        });
    });

    </script>
</html>

