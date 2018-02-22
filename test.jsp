<%@page import="Model.Patient"%>
<%@page import="Model.Prenatal"%>
<%@page import="Model.Vaccine"%>
<%@page import="Model.User"%>
<%@page import="Model.Consultation"%>
<%@page import="Model.Diagnosis"%>
<%@page import="Model.Medication"%>
<%@page import="Model.Chart"%>
<%@page import="DAO.doctorDAO"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="DAO.programDAO"%>
<%@page import="DAO.chartsDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date;"%>
<%@page import="java.util.ArrayList"%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Program Proposal </title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
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
    <!-- prettyCheckbox -->
    <link href="vendors/pretty-checkbox/src/pretty.min.css" rel="stylesheet">
    <!-- multiselect -->
    <link rel="stylesheet" href="vendors/bootstrap-multiselect/dist/css/bootstrap-multiselect.css" type="text/css"/>

    <!-- Custom Theme Style -->
    <link href="source/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md footer_fixed">
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

        
        
        
<%
    //INITIALIZATION
    programDAO pDAO = new programDAO();
    nurseDAO nDAO = new nurseDAO();
    chartsDAO cDAO = new chartsDAO();
    
    int diagnosis_id = 0;
    Diagnosis d = null;
    
    if(session.getAttribute("selectedDisease") == null){
        response.sendRedirect("view_standard_reports.jsp");
    }else{
        diagnosis_id = (Integer) session.getAttribute("selectedDisease");
        d = pDAO.getDiagnosis((Integer) session.getAttribute("selectedDisease"));
    }
%>        
        
        <!--START OF PAGE CONTENT-->
        <div class="right_col edited fix" role="main">
          <ol class="breadcrumb">
        <%
               if (userType.equalsIgnoreCase("root")){ %>
                <li class="breadcrumb-item"><a href="home.jsp">  Home </a></li>
        <%} else if (userType.equalsIgnoreCase("physician")){ %>
                <li class="breadcrumb-item"><a href="home_doctor.jsp">  Home </a></li>
        <%} else if (userType.equalsIgnoreCase("nurse") || userType.equalsIgnoreCase("encoder") || userType.equalsIgnoreCase("midwife")){ %>
                <li class="breadcrumb-item"><a href="home_nurse.jsp">  Home </a></li>
        <%} else if (userType.equalsIgnoreCase("admin")){ %>
                <li class="breadcrumb-item"><a href="home_admin.jsp">  Home </a></li>
        <%}%>
                
                <li class="breadcrumb-item">Program</li>
                <li class="breadcrumb-item active">Program Proposal</li>
                
          </ol>
          
           <div class="col-md-12 col-sm-12 col-xs-12">
          
           
            <!-- DETAILS OF SELECTED DISEASE -->
            <div class="x_panel">
                
                <!-- HEADER -->
                <div class="x_content">
                    <center>
                        <h3>
                            <strong>DETAILS OF DISEASE<br>
                            </strong>
                        </h3>
                    </center>
                        <div class="col-md-12"><br></div>
                </div>
                
                <!-- CONTENT DETAILS OF THE DISEASE -->
                <div class="x_content">
                    <div class="form-group row">
                        <label class="col-md-2 control-label">Disease:</label> <%if(session.getAttribute("selectedDisease") != null){out.print(d.getDiagnosis());}%>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-2 control-label">Threshold: </label> <%if(session.getAttribute("selectedDisease") != null){out.print(d.getThreshold());}%>
                    </div>
                </div>
                
                
                    
                <!-- *************************   Charts   **************************-->
                
                
                <!-- GENDER -->
                <div class="col-md-4 col-sm-8 col-xs-12" >
                    <div class="x_panel">
                        
                        <div class="x_title">
                            <h2>GENDER<small> <!-- can put text here--></small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                            <li><a class="close-link"><i class="fa fa-close"></i></a>
                            </li>
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        
                        
                        <div class="x_panel">
                            <div class="x_content">
                                <canvas id="genderChart" width="100" height="120"></canvas>
                            </div><!--x_content-->
                        </div>
                         
                    </div>
                    
                </div>
                
                <!-- BY BARANGAY-->
                <div class="col-md-4 col-sm-8 col-xs-12">
                    <div class="x_panel">
                        
                        <div class="x_title">
                            <h2>BARANGAY<small> <!-- can put text here--></small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                            <li><a class="close-link"><i class="fa fa-close"></i></a>
                            </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        
                        
                        <div class="x_panel">
                            <div class="x_content">
                                <canvas id="barangayChart" width="100" height="120"></canvas>
                            </div><!--x_content-->
                        </div>
                         
                    </div>
                    
                </div>
                
                <div class="col-md-4 col-sm-8 col-xs-12">
                    <div class="x_panel">
                        
                        <div class="x_title">
                            <h2>AGE GROUPS<small> <!-- can put text here--></small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                            <li>
                            </li>
                            <li><a class="close-link"><i class="fa fa-close"></i></a>
                            </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        
                        
                        <div class="x_panel">
                            <div class="x_content">
                                <canvas id="ageGroupChart" width="100" height="120"></canvas>
                            </div><!--x_content-->
                        </div>
                         
                    </div>
                    
                </div>
                
                
                <!-- DISEASE CHART-->
                <div class="col-md-2"></div>
                <div class="col-md-6 col-sm-8 col-xs-12" >
                    <div class="x_panel">
                        
                        <div class="x_title">
                            <h2><%if(session.getAttribute("selectedDisease") != null){out.print(d.getDiagnosis());}%><small> <!-- can put text here--></small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-down"></i></a>
                            </li>
                            <li><a class="close-link"><i class="fa fa-close"></i></a>
                            </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        
                        
                        <div class="x_panel" id="diseasecontent">
                            <div class="x_content">
                                <canvas id="diseaseChart" width="100" height="120"></canvas>
                            </div><!--x_content-->
                        </div>
                         
                    </div>
                    
                </div>
                
            </div>
            
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
                    
            <script>
            //Create ng onload function
            //var ctx = document.getElementById('myChart').getContext('2d');
            function genderChart(){
                var chart1 = new Chart(document.getElementById('genderChart').getContext('2d'), {
                    // The type of chart we want to create
                    type: 'pie',
                    data: {
                        labels: [<%
                                
                                ArrayList <Chart> list  = new ArrayList();
                                /*if(session.getAttribute("selectedDisease") != null){
                                    tempYear = (Integer) session.getAttribute("chartYear");
                                }*/
                                list = pDAO.genderChart(diagnosis_id);
                                for(int i = 0; i < list.size(); i++){
                                    out.print("\"");
                                    out.print(list.get(i).getSex() + "\""+",");
                                } 
                                
                                %>],
                        datasets: [{
                            label: "Number of Cases",
                            data: [<%
                                //chartsDAO chartsDAO = new chartsDAO();
                                //ArrayList <Diagnosis> list  = new ArrayList();
                                //list = chartsDAO.topDiagnosisRHU();
                                for(int i = 0; i < list.size(); i++){
                                    out.print("\"");
                                    out.print(list.get(i).getNumOfCases() + "\""+",");

                                }    
                                %>],
                            backgroundColor: [
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 99, 132, 0.2)',
                                ],
                            borderColor: [
                                'rgba(54, 162, 235, 1)',
                                'rgba(255,99,132,1)',
                                ],
                            borderWidth: 1
                                }]
                        },

                    // Configuration options go here
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                        }
                    }
                });
            }
            genderChart();
            
            function barangayChart(){
                var chart1 = new Chart(document.getElementById('barangayChart').getContext('2d'), {
                    // The type of chart we want to create
                    type: 'bar',
                    data: {
                        labels: [<%
                                
                                ArrayList <Chart> list2  = new ArrayList();
                                /*if(session.getAttribute("selectedDisease") != null){
                                    tempYear = (Integer) session.getAttribute("chartYear");
                                }*/
                                list2 = pDAO.barangayChart(diagnosis_id);
                                for(int i = 0; i < list2.size(); i++){
                                    out.print("\"");
                                    out.print(list2.get(i).getBarangay() + "\""+",");
                                } 
                                
                                %>],
                        datasets: [{
                            label: "Number of Cases",
                            data: [<%
                                //chartsDAO chartsDAO = new chartsDAO();
                                //ArrayList <Diagnosis> list  = new ArrayList();
                                //list = chartsDAO.topDiagnosisRHU();
                                for(int i = 0; i < list2.size(); i++){
                                    out.print("\"");
                                    out.print(list2.get(i).getNumOfCases() + "\""+",");
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
                            borderWidth: 1
                                }]
                        },

                    // Configuration options go here
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                        }
                    }
                });
            }
            barangayChart();
            
            function ageGroupChart(){
                var chart1 = new Chart(document.getElementById('ageGroupChart').getContext('2d'), {
                    // The type of chart we want to create
                    type: 'bar',
                    data: {
                        labels: [<%
                                
                                ArrayList <Chart> list3  = new ArrayList();
                                /*if(session.getAttribute("selectedDisease") != null){
                                    tempYear = (Integer) session.getAttribute("chartYear");
                                }*/
                                list3 = pDAO.ageGroupChart(diagnosis_id);
                                for(int i = 0; i < list3.size(); i++){
                                    out.print("\"");
                                    out.print(list3.get(i).getAgeGroup() + "\""+",");
                                } 
                                
                                %>],
                        datasets: [{
                            label: "Number of Cases",
                            data: [<%
                                //chartsDAO chartsDAO = new chartsDAO();
                                //ArrayList <Diagnosis> list  = new ArrayList();
                                //list = chartsDAO.topDiagnosisRHU();
                                for(int i = 0; i < list3.size(); i++){
                                    out.print("\"");
                                    out.print(list3.get(i).getNumOfCases() + "\""+",");
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
                            borderWidth: 1
                                }]
                        },

                    // Configuration options go here
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                        }
                    }
                });
            }
            ageGroupChart();
            
        </script>   

        <script>
            //Create ng onload function
            //var ctx = document.getElementById('myChart').getContext('2d');
           
        var MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

        var ctx = document.getElementById("diseaseChart").getContext('2d');
        
        function diseaseChart(){
            var myChart = new Chart(ctx, {
                // The type of chart we want to create
                type: 'line',
                data: {
                    labels: MONTHS,
                    datasets: [{
                        label: "Number of Cases",
                        data: [<%
                            
                            ArrayList <Chart> list4  = new ArrayList();
                            
                            list4 = pDAO.diseaseChart(diagnosis_id);
                            /*for(int i = 0; i < list2.size(); i++){
                                out.print("\"");
                                out.print(list2.get(i).getMonth() + "\""+",");
                            }*/
                            
                            int countList = 0;
                            int total = 0;
                            for(int i = 1; i <= 12; i++){ //start on 1 for months  //1-12
                                if(countList != list4.size()){
                                    int y = pDAO.getMonthInt(list4.get(countList).getMonth());
                                    if(i == y){
                                        out.print("\"");
                                        total = total + list4.get(countList).getNumOfCases();
                                        out.print(total + "\""+",");
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
                            
                            /*for(int i = 0; i < list2.size(); i++){
                                
                                out.print("\"");
                                out.print(list2.get(i).getNumOfCases() + "\""+",");
                                
                            }*/
                    %>],
                        borderColor: "#3e95cd",                                    
                        borderWidth: 1.5,                                    
                    
                    }]
                },
                // Configuration options go here
                options: {
                    lineAt: <%out.print(d.getThreshold());%>,
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
        diseaseChart();
        
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
                    
        <!--SUGGESTION CARD-->
        
        <div class="col-md-12 col-sm-6 col-xs-12">
            <div class="x_panel" id="programcategorycard" >
               
                <div class="x_content">
                    <center>
                        <h3>
                            <strong>SUGGESTED PROGRAMS<br>
                            </strong>
                        </h3>
                    </center>
                    <!-- <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print"></i> Print</button> -->
                    <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                </div>
                <!--<div class="x_title">
                    <strong>Program Proposal</strong>
                </div>-->
                <div class="x_content">
                        
                    <!--TITLE-->
                    <div class="col-md-12">
                            <table id="datatable-suggested" class="table table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                              <thead>
                                <tr>
                                  <th rowspan="2">Program Title </th>
                                  <th rowspan="2">Category</th>
                                  <th colspan="3" style="text-align: center; font-size: 14px">Target</th>
                                  <th colspan="2" style="text-align: center; font-size: 14px">Date Implemented</th>
                                  <th rowspan="2">Brief Description</th>
                                  <th rowspan="2">Rating</th>
                                </tr>
                                <tr align="center">
                                    <td style="font-size: 12px"><strong>DISEASE</strong></td>
                                    <td style="font-size: 12px"><strong>AGE GROUP</strong></td>
                                    <td style="font-size: 12px"><strong>BARANGAY</strong></td>
                                    <td style="font-size: 12px"><strong>START DATE</strong></td>
                                    <td style="font-size: 12px"><strong>END DATE</strong></td>
                                </tr>
                              </thead>
                              <tr>
                                <!-- LAMAN -->
                              </tr>     

                              <tbody>

                              </tbody>
                            </table>
                        </div> <!--col-12-->
                             
                     <footer style="display:none">
                        <div class="form-group" align="center">
                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                <button type="submit" class="btn btn-success" id="nextPage">Submit</button>
                            </div>
                        </div>
                    </footer>
                              

                </div>
                <!--x_content buong form-->
                </div><!--x_panel buong form-->
            <!-- End of PROGRAM CATEGORY-->
        </div>
        
        <!--PROGRAM CATEGORY Card-->
        <form action="SeeSuggestedPrograms" method="post">    
            <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel" id="programcategorycard" >

                    <div class="x_content">
                        <center>
                            <h3>
                                <strong>PROGRAM CATEGORY<br>
                                </strong>
                            </h3>
                        </center>
                        <!-- <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print"></i> Print</button> -->
                        <!--SPACER-->
                            <div class="col-md-12"><br></div>
                        <!--SPACER-->
                    </div>
                    <!--<div class="x_title">
                        <strong>Program Proposal</strong>
                    </div>-->
                    <div class="x_content">

                        <!--TITLE-->
                        <div class="form-group row">

                         <div class="col-md-12">
                            <label class="col-md-4 control-label">Program Category:</label>

                           <div class='col-md-8'>
                                <select id="category" name="category" class="form-control">
                                   <option selected="true" disabled="disabled" value="" selected>    --SELECT PROJECT CATEGORY--</option>
                                    <option value="Expanded Program on Immunization">Expanded Program on Immunization</option>
                                    <option value="Disease Surveillance">Disease Surveillance</option>
                                    <option value="Control of Acute Respiratory Infections">Control of Acute Respiratory Infections</option>
                                    <option value="Control of Diarrheal Diseases">Control of Diarrheal Diseases</option>
                                    <option value="Micronutrients Supplementation/Nutrition">Micronutrients Supplementation/Nutrition</option>
                                    <option value="Family Planning Program">Family Planning Program</option>
                                    <option value="Tuberculosis Control Program">Tuberculosis Control Program</option>
                                    <option value="STD/AIDS Prevention and Control Program">STD/AIDS Prevention and Control Program</option>
                                    <option value="Environmental Sanitation Program">Environmental Sanitation Program</option>
                                    <option value="Cancer Control Program">Cancer Control Program</option>
                                    <option value="Maternal Care">Maternal Care</option>
                                </select>
                            </div>
                          </div><!--/col-md-12-->

                          <!--SPACER-->
                            <div class="col-md-12"><br></div>
                        <!--SPACER-->


                        <% if(session.getAttribute("selectedDisease") == null){ %>
                          <div class="col-md-6">
                              <label class="col-md-2 control-label">Target Disease:</label>
                              <div class="col-md-5">
                                <select class="diagnosis-multiple" name="diagnosis" style="width: 100%;">

                                    <%
                                        ArrayList <Diagnosis> dList = new ArrayList();
                                        dList = nDAO.getAllDiagnosis();
                                    for(int x=0; x < dList.size();x++){
                                    %>
                                        <option value = "<%=dList.get(x).getDiagnosis_id()%>"> <%=dList.get(x).getDiagnosis()%></option>
                                    <%}%>
                                </select>

                            </div>
                         </div>
                        <%}%>  
                          <!--SPACER-->
                            <div class="col-md-12"><br></div>
                        <!--SPACER-->


                          <div class="col-md-12">
                            <label class="col-md-2 control-label">Target Participants:</label>
                          </div>

                          <div class="col-md-12">
                              <div class="col-md-2"></div>
                              <div class="col-md-8">
                                    <div class="row">
                                    <div class="col-md-4">
                                    <label>
                                     Age Range:
                                    </label>
                                    </div>

                                    <div class="col-md-4">
                                    <select id="tag1" name="age" class="multipleselect" multiple="multiple">
                                        <option value="1">Below 18</option>
                                        <option value="2">18-24</option>

                                        <option value="3">25-34</option>

                                        <option value="4">35-44</option>
                                        <option value="5">45-54</option>
                                        <option value="6">Above 55</option>

                                    </select>
                                    </div>    
                                  </div>
                                  <!--/row-->
                                  <div class="row">&nbsp;</div>
                                  <div class="form-group row">
                                    <div class="col-md-4">
                                    <label>
                                      Gender:
                                    </label>
                                    </div>

                                    <div class="col-md-4">
                                    <select class="multipleselect" name="gender" id="tag2" multiple="multiple" >
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                    </div>    

                                  </div>
                                  <!--/row-->
                                  <div class="row">&nbsp;</div>
                                  <div class="row">
                                    <div class="col-md-4">
                                    <label>
                                      Barangay:
                                    </label>
                                    </div>

                                    <div class="col-md-4">
                                    <select id="tag3" name="barangay" class="multipleselect" multiple="multiple">
                                        <option value="Dolores">Dolores</option>
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

                                      <div class="col-md-4"></div>


                                  </div> <!--/row-->

                                  <div class="row" align="center">
                                     <div class="row">&nbsp;</div>
                                     <div class="row">&nbsp;</div>
                                      <div class="col-md-12" >
                                         <button  type="button" class="btn btn-sm btn-primary" id="createprogram" style="float: right" onclick="showDiv()"><i class="fa fa-plus"></i> Create Program</button>
                                         <button style="display: none;" type="submit" id="suggestedbutton" name="selectfamilynumber" class="btn btn-primary btn-sm"> <!--data-toggle="modal" data-target=".program-modal" -->   <i class="fa fa-book"></i> See Suggested Programs</button>
                                      </div>  
                                  </div><!--/row-->

                                </div><!--DEMOGRAPHICS-->
                          </div>                      

                        </div><!--/form-group-->




                         <footer style="display:none">
                            <div class="form-group" align="center">
                                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                    <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                    <button type="submit" class="btn btn-success" id="nextPage">Submit</button>
                                </div>
                            </div>
                        </footer>


                    </div>
                    <!--x_content buong form-->
                    </div><!--x_panel buong form-->

            </div>
        </form>
              <!-- End of PROGRAM CATEGORY-->        
                      
        <!--PROGRAM DETAIL CARD-->
        <form action="AddProgramProposal" method="post">
            <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="x_panel" id="programproposalcard" style="display: none;">

                    <div class="x_content">
                        <center>
                            <h3>
                                <strong>PROGRAM DETAILS<br>
                                </strong>
                            </h3>
                        </center>
                        <!-- <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print"></i> Print</button> -->
                        <!--SPACER-->
                            <div class="col-md-12"><br></div>
                        <!--SPACER-->
                    </div>
                    <!--<div class="x_title">
                        <strong>Program Proposal</strong>
                    </div>-->
                    <div class="x_content">

                        <!--TITLE-->
                        <div class="form-group row">

                         <div class="col-md-12">
                            <label class="col-md-2 control-label">Program Title:</label>

                            <div class="col-md-5">
                            <input type="text" required="required" class="form-control noMargin" id="title" name="title" placeholder="eg. Feeding Program">
                            </div><!--/col-md-5-->
                            </div>

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <div class="col-md-12">
                            <label class="col-md-2 control-label">Implementing Period:</label>

                            <div class='col-md-10'>
                            <div class="form-group">
                            <div class='input-group date' id='datetimepicker6'>

                            <label class="input-group-addon" for="age_min" style="font-size:10px;">From</label>
                            <input type="text" class="form-control" id="datepicker1" name="fromdate" >
                            <label class="input-group-addon" for="age_min" style="font-size:10px;">To&nbsp;&nbsp;</label>
                            <input type="text" class="form-control" id="datepicker2" name="todate">
                            <span class="input-group-addon" style="">
                            <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                            </div>
                            </div>
                            </div>

                            </div><!--/col-md-12-->

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <div class="col-md-12">
                            <label class="col-md-2 control-label">No. of Participants:</label>

                            <div class="col-md-5">
                            <input type="number" required="required" class="form-control noMargin" id="title" name="noofparticipants" placeholder="eg. 1,000" value="0">
                            </div><!--/col-md-5-->
                            </div>

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <!--BRIEF DESCRIPTION-->
                            <div class="form-group row">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                            <label class="control-label">Brief Description:</label>
                            </div>
                            <div class="col-md-12">
                            <textarea type="text" required="required" class="form-control noMargin" id="description" name="description" cols="10" rows="5" placeholder="eg. Description of project"></textarea>
                            </div><!--/col-md-5-->

                            </div>
                            <!--END OF DESCRIPTION-->             

                        </div><!--/form-group-->




                         <footer>
                            <div class="form-group" align="center">
                                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                    <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                    <button type="submit" class="btn btn-success" id="nextPage">Submit</button>
                                </div>
                            </div>
                        </footer>


                    </div>
                    <!--x_content buong form-->
                    </div><!--x_panel buong form-->
                <!-- End of Program Proposal-->
            </div>
        </form>
            
                      
          
               </div><!--col-md-12-->
        </div><!--right_col-->
            
        </div><!--main_container-->
    </div><!--container body-->
    

    
    <!-- jQuery -->
                <script src="vendors/jquery/dist/jquery.min.js"></script>
                <!-- Bootstrap -->
                <script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
                <!-- FastClick -->
                <script src="vendors/fastclick/lib/fastclick.js"></script>
                <!-- NProgress -->
                <script src="vendors/nprogress/nprogress.js"></script>
                <!-- bootstrap-progressbar -->
                <script src="vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
                <!-- iCheck -->
                <script src="vendors/iCheck/icheck.min.js"></script>
                <!-- bootstrap-daterangepicker -->
                <script src="vendors/moment/min/moment.min.js"></script>
                <script src="vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
                <!-- bootstrap-wysiwyg -->
                <script src="vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>
                <script src="vendors/jquery.hotkeys/jquery.hotkeys.js"></script>
                <script src="vendors/google-code-prettify/src/prettify.js"></script>
                <!-- jQuery Tags Input -->
                <script src="vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
                <!-- Switchery -->
                <script src="vendors/switchery/dist/switchery.min.js"></script>
                <!-- Select2 -->
                <script src="vendors/select2/dist/js/select2.full.min.js"></script>
                <!-- Parsley -->
                <script src="vendors/parsleyjs/dist/parsley.min.js"></script>
                <!-- Autosize -->
                <script src="vendors/autosize/dist/autosize.min.js"></script>
                <!-- jQuery autocomplete -->
                <script src="vendors/devbridge-autocomplete/dist/jquery.autocomplete.min.js"></script>
                <!-- starrr -->
                <script src="vendors/starrr/dist/starrr.js"></script>
                <!-- bootstrap datepicker -->
                <script src="vendors/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
                <!--multiselect-->
                 <script src="vendors/bootstrap-multiselect/dist/js/bootstrap-multiselect.js"></script>
                <!-- Custom Theme Scripts -->
                <script src="source/js/custom.min.js"></script>
                <!-- bootstrap-datetimepicker -->    
                <script src="vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
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
                <script src="vendors/jszip/dist/jszip.min.js"></script>
                <script src="vendors/pdfmake/build/pdfmake.min.js"></script>
                <script src="vendors/pdfmake/build/vfs_fonts.js"></script>
</body>
   
   
<!--Create Program-->
<script>
function showDiv() {
   document.getElementById('programproposalcard').style.display = "";
   document.getElementById('createprogram').style.display = "none";
}    
</script>
<!--multiselect-->
<script type="text/javascript">
    $(document).ready(function() {
        $('.multipleselect').multiselect({
            enableCaseInsensitiveFiltering: true,
            filterBehavior: 'value',
            includeSelectAllOption: true
        });
    });
</script>

<script>
function updateFormEnabled() {
    if (verifySettings()) {
        document.getElementById('suggestedbutton').style.display = "block";
    } else {
        document.getElementById('suggestedbutton').style.display = "none";
    }
}

function verifySettings() {
    if ($('#tag1').val() != null || $('#tag2').val() != null || $('#tag3').val() != null || $('#category').val() != null) {
        return true;
    } else {
        return false
    }
}

$('#tag1').change(updateFormEnabled);
$('#tag2').change(updateFormEnabled);
$('#tag3').change(updateFormEnabled);
$('#category').change(updateFormEnabled);
    
    
</script>

<script>
$(document).ready(function() {    
    $('#datatable-suggested').DataTable( {
        "order": [[5, "desc"]],
        responsive: true,
    });
} );
</script>
<script>
     $('#datepicker1').datetimepicker({
      format: 'YYYY-MM-DD'
    });
    $('#datepicker2').datetimepicker({
      format: 'YYYY-MM-DD'
    });
    $(document).ready(function() {
        $('.medication-multiple').select2();
    });

    $(document).ready(function() {
        $(".medication-multiple").select2({
        tags: true
        });
    });

</script>

<script>
    $(document).ready(function() {
        $('.medication-multiple').select2();
    });

    $(document).ready(function() {
        $(".medication-multiple").select2({
        tags: true
        });
    });
</script>

<script>
$("#selectallimm").click(function () {
$(".adultimmunization").prop('checked', $(this).prop('checked'));
});
</script>

<!-- Diagnosis Select2 -->                                  
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
<!--TABLE RESOURCE REQUIREMENTS-->
<script type="text/javascript">
    $(function () {
        //Build an array containing wellwrong records.
        var wellwrong = new Array();
        //Add the data rows.
        for (var i = 0; i < wellwrong.length; i++) {
            AddRow(wellwrong[i][0], wellwrong[i][1]);
        }
    });
    function Add() {
        AddRow($("#resource").val(), $("#quantity").val(), $("#unitprice").val(), $("#total").val());
        $("#resource").val("");
        $("#quantity").val("");
        $("#unitprice").val("");
        $("#total").val("");
    };
    function AddRow(resource, quantity, unitprice, total) {
        //Get the reference of the Table's TBODY element.
        var tBody = $("#tblWellWrong > TBODY")[0];
        //Add Row.
        row = tBody.insertRow(-1);
        
        //Add resource cell.
        var cell = $(row.insertCell(-1));
        cell.html(resource);
        
        //Add quantity cell.
        cell = $(row.insertCell(-1));
        cell.html(quantity);
        
        //Add unitprice cell.
        cell = $(row.insertCell(-1));
        cell.html(unitprice);
        
        //Add total cell.
        cell = $(row.insertCell(-1));
        cell.html(total);
        
        //Add Button cell.
        cell = $(row.insertCell(-1));
        var btnRemove = $("<input />");
        btnRemove.attr("type", "button");
        btnRemove.attr("onclick", "Remove(this);");
        btnRemove.val("Remove");
        cell.append(btnRemove);
    };
    function Remove(button) {
        //Determine the reference of the Row using the Button.
        var row = $(button).closest("TR");
        var name = $("TD", row).eq(0).html();
        if (confirm("Do you want to delete: " + name)) {
            //Get the reference of the Table.
            var table = $("#tblWellWrong")[0];
            //Delete the Table row using it's Index.
            table.deleteRow(row[0].rowIndex);
        }
    };
</script>
<script>
    function calculateTotal(){
        
        var unitprice=Number(document.getElementById("unitprice").value);
        var quantity=Number(document.getElementById("quantity").value);
        
        //Perform calculation
        var total = unitprice * quantity;

        //Display result of calculation
        document.getElementById("total").innerText=total;
        
    }                              
</script>
<script>
$(function(){
    // New code
    $("#diseasecontent").hide();
    $('a.collapseeed').click(function(){
        $('#diseasecontent').stop().slideToggle(60);
        $(".content.fa").addClass('fa-chevron-up').removeClass('fa-chevron-down');
        return false;
    });
});                    
</script>
</html>
