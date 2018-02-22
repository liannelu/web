<%@page import="Model.Patient"%>
<%@page import="Model.Prenatal"%>
<%@page import="Model.Vaccine"%>
<%@page import="Model.Program"%>
<%@page import="Model.User"%>
<%@page import="Model.Resource"%>
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
    <!-- bootstrap-datetimepicker -->
    <link href="vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <!-- bootstrap-daterangepicker -->
    <link href="vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- prettyCheckbox -->
    <link href="vendors/pretty-checkbox/src/pretty.min.css" rel="stylesheet">
    <!-- multiselect -->
    <link rel="stylesheet" href="vendors/bootstrap-multiselect/dist/css/bootstrap-multiselect.css" type="text/css"/>
<!-- starRating -->
    <link href="vendors/bootstrap-star-rating/css/star-rating.css" rel="stylesheet">
     <!-- PNotify -->
    <link href="../vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="../vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="../vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="source/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md footer_fixed" onload="myFunction()">
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

<%

     ArrayList <Chart> list  = new ArrayList();
    list = pDAO.genderChart(diagnosis_id);

    int totalDisease = 0;

    for (int x = 0; x<list.size(); x++){

           totalDisease += list.get(x).getNumOfCases();

    }

    ArrayList <Chart> list2  = new ArrayList();
    list2 = pDAO.barangayChart(diagnosis_id);

    ArrayList <Chart> list3  = new ArrayList();
    list3 = pDAO.ageGroupChart(diagnosis_id);

    String suggestAge = "";
    String suggestGender = "";
    String suggestBrgy = "";

    suggestGender = pDAO.seeSuggested(list, "gender");
    suggestBrgy = pDAO.seeSuggested(list2, "brgy");
    suggestAge = pDAO.seeSuggested(list3, "age");

%>

        
        <!--START OF PAGE CONTENT-->
        <div class="right_col edited" role="main">
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
                            <strong>DETAILS OF DISEASE/DIAGNOSIS<br>
                            </strong>
                        </h3>
                    </center>
                        <div class="col-md-12"><br></div>
                </div>
                
                <!-- CONTENT DETAILS OF THE DISEASE -->
                <div class="x_content">
                    <div class="form-group row">
                        <label class="col-md-2 control-label">Disease/Diagnosis:</label> <%if(session.getAttribute("selectedDisease") != null){out.print(d.getDiagnosis());}%>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-2 control-label">Threshold: </label> <%if(session.getAttribute("selectedDisease") != null){out.print(d.getThreshold());}%>
                    </div>
                </div>     
                <!--START OF PRESCRIPTIVE BANNER-->    
                <div class="x_content">

                    <div class="alert alert-info alert-dismissible fade in" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><i class="fa fa-close"></i>
                        </button>
                        <h2><span class="fa fa-info-circle"></span> Below are some suggestions for your program proposal. </h2>
                        
                    </div>
                    
                <!-- END OF BANNER --> 
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
                
                <!-- AGE GROUPS-->
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
                <div class="col-md-12 col-sm-8 col-xs-12" >
                    <div class="x_panel">
                        
                        <div class="x_title">
                            <h2><%if(session.getAttribute("selectedDisease") != null){out.print(d.getDiagnosis());}%><small> <!-- can put text here--></small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                            <li><a class="close-link"><i class="fa fa-close"></i></a>
                            </li>
                            </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        
                        
                        <div class="x_panel" id="diseasecontent">
                            <div class="x_content">
                                <canvas id="diseaseChart" width="100" height="40"></canvas>
                            </div><!--x_content-->
                        </div>
                         
                    </div>
                    
                </div>
            
            
            </div><!--x_content of DEATILS OF SECLETED DISEASE-->
            
            <script src="vendors/Chart.js/dist/Chart.min.js"></script>
                    
            <script>
            //Create ng onload function
            //var ctx = document.getElementById('myChart').getContext('2d');
            function genderChart(){
                var chart1 = new Chart(document.getElementById('genderChart').getContext('2d'), {
                    // The type of chart we want to create
                    type: 'pie',
                    data: {
                        labels: [<%
                                
                                /*ArrayList <Chart> list  = new ArrayList();
                                if(session.getAttribute("selectedDisease") != null){
                                    tempYear = (Integer) session.getAttribute("chartYear");
                                }
                                list = pDAO.genderChart(diagnosis_id);*/
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
                                
                               /* ArrayList <Chart> list2  = new ArrayList();
                                if(session.getAttribute("selectedDisease") != null){
                                    tempYear = (Integer) session.getAttribute("chartYear");
                                }
                                list2 = pDAO.barangayChart(diagnosis_id);*/
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
                                
                               /* ArrayList <Chart> list3  = new ArrayList();
                                if(session.getAttribute("selectedDisease") != null){
                                    tempYear = (Integer) session.getAttribute("chartYear");
                                }
                                list3 = pDAO.ageGroupChart(diagnosis_id);*/
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
        
        </div><!--col-md-12-->
        
        <div class="alert alert-info alert-dismissible fade in" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><i class="fa fa-close"></i>
            </button>
            <h2><span class="fa fa-info-circle"></span> Based on the charts, it is recommended that you focus on the following parameters: </h2>
            <h4>
                Disease/Diagnosis: <strong><%=""+d.getDiagnosis()%> : [ <%=totalDisease %> ] </strong> <br>
                Gender: <strong><%=suggestGender%> : [ <%
                                
                                if (suggestGender.equalsIgnoreCase("Both")){
                                    out.print(""+totalDisease);
                                }
                                else{
                                    for (int x = 0; x<list.size(); x++){

                                        if (list.get(x).getSex().equalsIgnoreCase(suggestGender)){
                                            out.print(""+list.get(x).getNumOfCases());
                                        }
                                    }
                                }
                
                %> ] </strong><br>
                Age: <strong><%=suggestAge%></strong> <br>
                Barangay: <strong><%=suggestBrgy%></strong> <br>
            </h4>
        </div>

        <!--SUGGESTION CARD-->
        <%
            if (session.getAttribute("programCategory") != null) {
        %>
        
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
                
                
                <div class="x_content">
                      
                    <!--TITLE-->
                    <div class="col-md-12">
                            <table id="datatable-suggested" class="table table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                              <thead>
                                <tr>
                                  <th>Program Title </th>
                                  <th>Category</th>
                                  <th width="1%"><strong>DISEASE</strong></th>
                                  <th width="1%">Rating</th>
                                  <th>Action</th>
                                   
                                   
                                    <th><div style="width:900px;"><strong>AGE GROUP</strong></div></th>
                                    <th><div style="width:900px;"><strong>BARANGAY</strong></div></th>
                                   <!-- <th style="font-size: 12px"><strong>START DATE</strong></th>
                                    <th style="font-size: 12px"><strong>END DATE</strong></th>-->
                                  <!--<th colspan="3" style="text-align: center; font-size:14px">Target</th>
                                  <th colspan="2" style="text-align: center; font-size: 14px">Date Implemented</th>-->
                                    <th><div style="width:900px;">Brief Description</div></th>
                                  
                                  

                                </tr>
                                <!--<tr align="center">
                                    
                                </tr>-->
                              </thead>
                              
                              <%
                        String category = (String) session.getAttribute("programCategory");
                        int disease = (Integer) session.getAttribute("selectedDisease");
                        
                        ArrayList<Program> suggestList = pDAO.seeSuggestedPrograms(category, disease);
                    
                        for (int x = 0; x < suggestList.size(); x++){
                            Program selectedProgram = suggestList.get(x);
                    %>  
                    
                              <tr>
                                <!-- LAMAN -->
                                <td><%=selectedProgram.getTitle()%></td>
                                <td><%=selectedProgram.getCategory()%></td>
                                <td><%=pDAO.getDiagnosis(selectedProgram.getDiagnosis()).getDiagnosis()%></td>
                                
                                <td width="1%"><span class="text-nowrap" ><%=selectedProgram.getEvaluation()%> <i class="fa fa-star"></i>
                                    </span>
                                </td>
                                <td width="1%"><button id="viewuser" class="btn btn-info btn-sm" data-toggle="modal" data-target=".fammembers-modal<%=x%>"><i class="fa fa-eye"></i>View</button></td>            
                                              
                                              
                                              
                                  <td><div style="width:500px;">
                                      <span class="text-nowrap" >
                                              <% 
                                               if (selectedProgram.getAge_groups().size() >= 1) {
                                                    out.print(pDAO.getAgeGroup(selectedProgram.getAge_groups().get(0)));
                                                }
                                                
                                                for (int i = 1; i < selectedProgram.getAge_groups().size(); i++){
                                                   out.println(", " + pDAO.getAgeGroup(selectedProgram.getAge_groups().get(i)));
                                                }
                                              %>
                                      </span>
                                      </div>
                                </td>
                                

                                
                                
                                <td><div style="width:500px;">
                                   <span class="text-nowrap" >
                                    <%
                                               if (selectedProgram.getBrgy().size() >= 1) {
                                                    out.print(selectedProgram.getBrgy().get(0));
                                                }
                                                
                                                for (int i = 1; i < selectedProgram.getBrgy().size(); i++) { 
                                                     out.print(", " + selectedProgram.getBrgy().get(i));
                                                }
                                    %>
                                    <span>
                                    </div>
                                </td>
                                <!--<td><%=selectedProgram.getDate_execute_start()%></td>
                                <td><%=selectedProgram.getDate_execute_end()%></td>-->
                                
                                
                                <td>
                                <div style="width:500px;">
                                <span class="text-nowrap" >
                                <%=selectedProgram.getDescription()%>
                                    </span>
                                </div>
                                </td>

                                
                              </tr>  
                    <%}
                    %>
                              <tbody>

                              </tbody>
                            </table>
                        </div> <!--col-12-->
            <!-- MODAL FOR VIEWING SUGGESTED PROGRAM DETAILS -->
            <%
                for (int x = 0; x < suggestList.size(); x++){
                            Program currentProgram = suggestList.get(x);
            %>
            
            <div class="modal fade fammembers-modal<%=x%>" width="60%" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">

                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">X</span>
                              </button>
                              <strong class="modal-title" id="myModalLabel">View Suggested Program Details</strong>
                            </div>
                        
                        <div class="modal-body">
            <!--start of grep-->
                                                    
            <!--Program Proposal Card-->
            <div class="x_panel" >
               
                <div class="x_content">
                    <center>
                        <h3>
                            <strong>PROGRAM PROPOSAL<br>
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
                        
                        <div class="col-md-6">
                            <h3><small><%=currentProgram.getTitle()%></small></h3>
                        </div><!--/col-md-5-->
                        
                        <label class="col-md-1 control-label">Status:</label>
                        
                        <div class="col-md-2">
                            <% if(currentProgram.getStatus().equalsIgnoreCase("Pending for Approval")){ %> 
                            <div><span class="label label-info" style="display: block;" >Pending Approval</span></div>
                            <% }
                            if(currentProgram.getStatus().equalsIgnoreCase("Pending for Evaluation")){ %> 
                            <div> <span class="label label-info" style="display: block;">Pending Evaluation</span> </div>
                            <% } 
                             if(currentProgram.getStatus().equalsIgnoreCase("Completed")){ %>
                            <div> <span class="label label-success" style="display: block;">Completed</span> </div>    
                            <% } %>
                        </div><!--/col-md-2-->
                      </div>
                        
                    <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                     
                      <div class="col-md-12">
                        <label class="col-md-2 control-label">Implementing Period:</label>

                       <div class='col-md-5'>
                            <div class="form-group">
                                <div class='input-group date' id='datetimepicker6'>
                                   
                                   <h3><small>From <%=currentProgram.getProposed_date_from()%> To <%=currentProgram.getProposed_date_to()%></small></h3>
                                </div>
                            </div>
                        </div>
                        
                      </div><!--/col-md-12-->
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                     
                     <div class="col-md-12">
                        <label class="col-md-2 control-label">Program Category:</label>

                       <div class='col-md-4'>
                            <h3><small><%=currentProgram.getCategory()%></small></h3>
                        </div>
                      </div><!--/col-md-12-->
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                      
                      <div class="col-md-12">
                        <label class="col-md-2 control-label">No. of Participants:</label>
                        
                        <div class="col-md-5">
                            <h3><small><%=currentProgram.getTarget()%></small></h3>
                        </div><!--/col-md-5-->
                      </div>
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                      
                      
                      <div class="col-md-12">
                          <label class="col-md-2 control-label">Target Disease:</label>
                          <div class="col-md-5">
                            <h3><small><%=pDAO.getDiagnosis(currentProgram.getDiagnosis()).getDiagnosis()%></small></h3>

                        </div>
                     </div>
                     
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
                                <div class="col-md-2">
                                <label>
                                 <!-- <input type="checkbox" class="flat" checked="checked"> -->Age Range
                                </label>
                                </div>

                                <div class="col-md-4">
                                <h3><small>
                            <%                              
                              if (currentProgram.getAge_groups().size() >= 1) {
                                out.print(nDAO.getAgeGroup(currentProgram.getAge_groups().get(0)));
                                }

                                for (int i = 1; i < currentProgram.getAge_groups().size(); i++){
                                out.println(", " + nDAO.getAgeGroup(currentProgram.getAge_groups().get(i)));
                                }
                            %>    
                                </small></h3>
                                </div>    
                              </div>
                              <!--/row-->
                              <div class="row">&nbsp;</div>
                              <div class="form-group row">
                                <div class="col-md-2">
                                <label>
                                  Gender
                                </label>
                                </div>

                                <div class="col-md-10">
                                <h3><small><%=currentProgram.getGender()%>  </small></h3>
                                </div>    

                              </div>
                              <!--/row-->
                              <div class="row">&nbsp;</div>
                              <div class="row">
                                <div class="col-md-2">
                                <label>
                                  Barangay
                                </label>
                                </div>

                                <div class="col-md-4">
                            <h3><small>
                            <%
                               if (currentProgram.getBrgy().size() >= 1) {
                                    out.print(currentProgram.getBrgy().get(0));
                                }

                                for (int i = 1; i < currentProgram.getBrgy().size(); i++) { 
                                     out.print(", " + currentProgram.getBrgy().get(i));
                                }
                            %>
                            </small></h3>
                            
                                </div>  

                              </div>
                            </div><!--DEMOGRAPHICS-->
                      </div>
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                      
                      
                    </div><!--/form-group-->
                    
                    
                    <!--BRIEF DESCRIPTION-->
                    <div class="form-group row">
                       <div class="col-md-12 col-sm-12 col-xs-12">
                            <label class="control-label">Brief Description:</label>
                        </div>
                        <div class="col-md-12">
                            <textarea readonly type="text" required="required" class="form-control noMargin" id="description" name="description" cols="10" rows="5" placeholder="eg. Description of project"><%=currentProgram.getDescription()%></textarea>
                        </div><!--/col-md-5-->

                    </div>
                    <!--END OF DESCRIPTION-->    
                    
                    <!--RESOURCE-->
                    <div class="form-group row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <label class="control-label">Resource Plan:</label>
                        </div>
                        
                        <div class="col-md-12">
                           
                            <!--TABLE FORM-->
                                <div class="table-responsive">
                                <table class="table table-bordered table-hover table-sortable" id="tab_logic">
                                    <thead>
                                        <tr>
                                            <th class="text-center">
                                                Item
                                            </th>
                                            <th class="text-center">
                                                Unit
                                            </th>
                                            <th class="text-center">
                                                Quantity
                                            </th>
                                            <th class="text-center">
                                                Price
                                            </th>
                                            <th class="text-center">
                                                Total
                                            </th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <%
                                           int currentProgramID = currentProgram.getProgram_id();
                                            ArrayList<String> vName = new ArrayList<String>();
                                            ArrayList<Resource> vList1 = nDAO.getAllResourcesOfProgram(currentProgramID);
                                            for (int y = 0; y < vList1.size(); y++){
                                        %>

                                        <tr>
                                            <td width="50%">
                                                <%=vList1.get(y).getItem()%>
                                           </td>
                                            <td width="10%"> 
                                                <%=vList1.get(y).getUnit()%>
                                            </td>
                                            <td width="10%"> 
                                                <%=vList1.get(y).getQty()%>
                                            </td>
                                            <td width="10%"> 
                                                <%=vList1.get(y).getPrice()%>
                                            </td>
                                            <td width="10%"> 
                                                <%=vList1.get(y).getTotal()%>
                                            </td>
                                        </tr>

                                        <%}%>

                                    </tbody>

                                </table>
                                </div> <!--/Table--> 
                                
                        </div><!--/col-md-12-->
                        
                        <div class="pull-right col-xs-4">
                          <table class="table table-bordered table-hover" id="tab_logic_total">
                            <tbody id="totalbudget">
                              <tr>
                                <th class="text-center">Total Budget</th>
                                    <td class="text-center">
                                        <%=currentProgram.getTotal_price()%>
                                    </td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                        
                    </div>
                    <!--RESOURCE-->   
                                 

                </div>
                <!--x_content buong form-->
            </div><!--x_panel buong form-->
            <!-- End of Program Proposal-->
                                                    
            <div class="x_panel">
                <div class="x_content">
                    <center>
                        <h3>
                            <strong>PROGRAM EVALUATION<br>
                            </strong>
                        </h3>
                    </center>
                    <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                </div>
                <!--<div class="x_title">
                    <strong>Program Planning</strong>
                </div>-->
                
                <%
                Program p = currentProgram;
                
                %>
                <div class="x_content">
                        
                    <!--TITLE-->
                    <div class="form-group row">
                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Program Title:</label>

                                <div class="col-md-5">
                                    <h3><small><%=p.getTitle()%></small></h3>
                                </div><!--/col-md-5-->
                            </div>

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Proposed Date:</label>

                                <div class='col-md-3'>
                                    <div class="form-group">
                                        <div class='input-group date' id='datetimepicker6'>

                                            <h3><small>From <%=p.getProposed_date_from()%></small></h3>
                                            <br>
                                            <h3><small>To <%=p.getProposed_date_to()%></small></h3>

                                        </div>
                                    </div>
                                </div>

                                <label class="col-md-1"></label>

                                <label class="col-md-2 control-label">Date Implemented:</label>

                                <div class='col-md-3'>
                                    <div class="form-group">
                                        <div class='input-group date' id='datetimepicker6'>

                                            <h3><small>From <%=p.getDate_execute_start()%></small></h3>
                                            <br>
                                            <h3><small>To <%=p.getDate_execute_end()%></small></h3>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div><!--/col-md-12-->

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Target vs Actual:</label>

                                <div class="col-md-3">
                                    <h3><small><%=p.getTarget()%> / <%=p.getActual_target()%></small></h3>
                                </div><!--/col-md-5-->


                            </div>

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <!--RATING-->  
                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Rating:</label>

                                <div class="col-md-5">
                                    <input readonly id="rating-id" type="text" class="rating" name="rating" data-size="sm" data-min="0" data-max="5" data-step="1" value="<%=p.getEvaluation()%>">
                                </div><!--/col-md-5-->
                            </div>


                            <!--SPACER-->
                                <div class="col-md-12"><br></div>
                            <!--SPACER-->
                            <!--SPACER-->
                                <div class="col-md-12"><br></div>
                            <!--SPACER-->
                            <!--SPACER-->
                                <div class="col-md-12"></div>
                            <!--SPACER-->

                            <!--WHAT WENT WRONG TABLE-->
                            <div class="col-md-4">
                                    <label class="control-label">What Went Well:</label>
                                </div>
                            <div class="col-md-4">
                                    <label class="control-label">What Went Wrong:</label>
                                </div>
                            <div class="col-md-4">
                                    <label class="control-label">Recommendations:</label>
                                </div>
                            <div class="col-md-4">
                                    <textarea readonly class="form-control noresize" placeholder="What Went Well"  cols="12" rows="5" name="well" maxlength="100"><%=p.getWent_well()%></textarea>
                                </div>
                            <div class="col-md-4">
                                    <textarea readonly class="form-control noresize" placeholder="What Went Wrong"  cols="12" rows="5" name="wrong" maxlength="100"><%=p.getWent_wrong()%></textarea>
                                </div>
                            <div class="col-md-4">
                                    <textarea readonly class="form-control noresize" placeholder="Recommendations"  cols="12" rows="5" name="recommendation" maxlength="100"><%=p.getRecommendation()%></textarea>
                            </div>
                            <!--END OF WHAT WENT WRONG TABLE--> 

                            <!--SPACER-->
                                <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <!--COMMENTS-->
                            <div class="form-group row">
                               <div class="col-md-12">
                                    <label class="control-label">Comments:</label>
                                </div>
                                <div class="col-md-12">
                                    <textarea readonly class="form-control noresize" placeholder="Comments on the Project"  cols="12" rows="5" name="comments" ><%=p.getComments()%></textarea>
                            </div>
                           
                        </div>
                        <!--END OF COMMENTS--> 
                    </div><!--/form-group-->
                </div>
                <!--x_content buong form-->
                
                
               
                
                
                            </div><!--x_panel buong form-->
            
                                                    <!--end of grep-->
                        </div><!--modal-body-->

                                                <div class="modal-footer">
                                                    
                                                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                
                                                </div>

                    </div><!-- END OF MODAL CONTENT-->
                    
                </div><!-- END OF MODAL LG-->
                            
            </div><!-- END OF MODAL  -->
                    
             <%}%>       
            <!-- END OF MODAL  -->                  

                </div>
                <!--x_content buong form-->
            </div><!--x_panel buong form-->
            
        
        
        <%
            }
        %>
        <!-- End of SUGGESTION CARD-->
        
        <!--SUGGESTION CARD with NO Evaluation     dito yung mga wala pang mga evaluation-->
        <%
            if (session.getAttribute("programCategory") != null) {
        %>
        <div class="col-md-12 col-sm-6 col-xs-12">
            <div class="x_panel" id="programcategorycard" >
               
                <div class="x_content">
                    <center>
                        <h3>
                            <strong>SUGGESTED PENDING PROGRAMS<br>
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
                            <table id="datatable-suggested-3" class="table table-bordered dt-responsive nowrap table-condensed" cellspacing="0" width="100%">
                              <thead>
                                <tr>
                                  <th>Program Title </th>
                                  <th>Category</th>
                                  <th width="1%"><strong>DISEASE</strong></th>
                                  <th>Action</th>
                                   
                                   
                                    <th><div style="width:900px;"><strong>AGE GROUP</strong></div></th>
                                    <th><div style="width:900px;"><strong>BARANGAY</strong></div></th>
                                   <!-- <th style="font-size: 12px"><strong>START DATE</strong></th>
                                    <th style="font-size: 12px"><strong>END DATE</strong></th>-->
                                  <!--<th colspan="3" style="text-align: center; font-size:14px">Target</th>
                                  <th colspan="2" style="text-align: center; font-size: 14px">Date Implemented</th>-->
                                    <th><div style="width:900px;">Brief Description</div></th>
                                  
                                  

                                </tr>
                                <!--<tr align="center">
                                    
                                </tr>-->
                              </thead>
                              
                              <%
                        String category = (String) session.getAttribute("programCategory");
                        int disease = (Integer) session.getAttribute("selectedDisease");
                        //int disease = 1;
                        ArrayList<Program> suggestList = pDAO.seeSuggestedProgramsWithNoEval(category, disease);
                    
                        
                        for (int x = 0; x < suggestList.size(); x++){
                            Program selectedProgram = suggestList.get(x);
                    %>  
                    
                              <tr>
                                <!-- LAMAN -->
                                <td><%=selectedProgram.getTitle()%></td>
                                <td><%=selectedProgram.getCategory()%></td>
                                <td><%=pDAO.getDiagnosis(selectedProgram.getDiagnosis()).getDiagnosis()%></td>
                                
                                
                                <td width="1%"><button id="viewuser" class="btn btn-info btn-sm" data-toggle="modal" data-target=".fammembers-modal2<%=x%>"><i class="fa fa-eye"></i>View</button></td>            
                                              
                                              
                                              
                                  <td><div style="width:500px;">
                                      <span class="text-nowrap" >
                                              <% 
                                               if (selectedProgram.getAge_groups().size() >= 1) {
                                                    out.print(pDAO.getAgeGroup(selectedProgram.getAge_groups().get(0)));
                                                }
                                                
                                                for (int i = 1; i < selectedProgram.getAge_groups().size(); i++){
                                                   out.println(", " + pDAO.getAgeGroup(selectedProgram.getAge_groups().get(i)));
                                                }
                                              %>
                                      </span>
                                      </div>
                                </td>
                                

                                
                                
                                <td><div style="width:500px;">
                                   <span class="text-nowrap" >
                                    <%
                                               if (selectedProgram.getBrgy().size() >= 1) {
                                                    out.print(selectedProgram.getBrgy().get(0));
                                                }
                                                
                                                for (int i = 1; i < selectedProgram.getBrgy().size(); i++) { 
                                                     out.print(", " + selectedProgram.getBrgy().get(i));
                                                }
                                    %>
                                    <span>
                                    </div>
                                </td>
                                <!--<td><%=selectedProgram.getDate_execute_start()%></td>
                                <td><%=selectedProgram.getDate_execute_end()%></td>-->
                                
                                
                                <td>
                                <div style="width:500px;">
                                <span class="text-nowrap" >
                                <%=selectedProgram.getDescription()%>
                                    </span>
                                </div>
                                </td>

                                
                              </tr>     
                    <%}
                    %>
                              <tbody>

                              </tbody>
                            </table>
                        </div> <!--col-12-->
            <!-- MODAL FOR VIEWING SUGGESTED PROGRAM DETAILS -->
            <%
                for (int x = 0; x < suggestList.size(); x++){
                            Program currentProgram = suggestList.get(x);
            %>
            
            <div class="modal fade fammembers-modal2<%=x%>" width="60%" tabindex="-1" role="dialog" aria-hidden="true">
                                            <div class="modal-dialog modal-lg">
                                              <div class="modal-content">

                                                <div class="modal-header">
                                                  <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">X</span>
                                                  </button>
                                                  <strong class="modal-title" id="myModalLabel">View Suggested Program Details</strong>
                                                </div>
                                                <div class="modal-body">
                                                    <!--start of grep-->
                                                    
            <!--Program Proposal MODAL -->
            <div class="x_panel" >
               
                <div class="x_content">
                    <center>
                        <h3>
                            <strong>PROGRAM PROPOSAL<br>
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
                        
                        <div class="col-md-6">
                            <h3><small><%=currentProgram.getTitle()%></small></h3>
                        </div><!--/col-md-5-->
                        
                        <label class="col-md-1 control-label">Status:</label>
                        
                        <div class="col-md-2">
                            <% if(currentProgram.getStatus().equalsIgnoreCase("Pending for Approval")){ %> 
                            <div><span class="label label-info" style="display: block;" >Pending Approval</span></div>
                            <% }
                            if(currentProgram.getStatus().equalsIgnoreCase("Pending for Evaluation")){ %> 
                            <div> <span class="label label-info" style="display: block;">Pending Evaluation</span> </div>
                            <% } 
                             if(currentProgram.getStatus().equalsIgnoreCase("Completed")){ %>
                            <div> <span class="label label-success" style="display: block;">Completed</span> </div>    
                            <% } %>
                        </div><!--/col-md-2-->
                      </div>
                        
                    <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                     
                      <div class="col-md-12">
                        <label class="col-md-2 control-label">Implementing Period:</label>

                       <div class='col-md-5'>
                            <div class="form-group">
                                <div class='input-group date' >
                                   
                                   <h3><small>From <%=currentProgram.getProposed_date_from()%> To <%=currentProgram.getProposed_date_to()%></small></h3>
                                </div>
                            </div>
                        </div>
                        
                      </div><!--/col-md-12-->
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                     
                     <div class="col-md-12">
                        <label class="col-md-2 control-label">Program Category:</label>

                       <div class='col-md-4'>
                            <h3><small><%=currentProgram.getCategory()%></small></h3>
                        </div>
                      </div><!--/col-md-12-->
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                      
                      <div class="col-md-12">
                        <label class="col-md-2 control-label">No. of Participants:</label>
                        
                        <div class="col-md-5">
                            <h3><small><%=currentProgram.getTarget()%></small></h3>
                        </div><!--/col-md-5-->
                      </div>
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                      
                      
                      <div class="col-md-12">
                          <label class="col-md-2 control-label">Target Disease:</label>
                          <div class="col-md-5">
                            <h3><small><%=pDAO.getDiagnosis(currentProgram.getDiagnosis()).getDiagnosis()%></small></h3>

                        </div>
                     </div>
                     
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
                                <div class="col-md-2">
                                <label>
                                 <!-- <input type="checkbox" class="flat" checked="checked"> -->Age Group
                                </label>
                                </div>

                                <div class="col-md-4">
                                <h3><small>
                            <%                              
                              if (currentProgram.getAge_groups().size() >= 1) {
                                out.print(nDAO.getAgeGroup(currentProgram.getAge_groups().get(0)));
                                }

                                for (int i = 1; i < currentProgram.getAge_groups().size(); i++){
                                out.println(", " + nDAO.getAgeGroup(currentProgram.getAge_groups().get(i)));
                                }
                            %>    
                                </small></h3>
                                </div>    
                              </div>
                              <!--/row-->
                              <div class="row">&nbsp;</div>
                              <div class="form-group row">
                                <div class="col-md-2">
                                <label>
                                  Gender
                                </label>
                                </div>

                                <div class="col-md-10">
                                <h3><small><%=currentProgram.getGender()%>  </small></h3>
                                </div>    

                              </div>
                              <!--/row-->
                              <div class="row">&nbsp;</div>
                              <div class="row">
                                <div class="col-md-2">
                                <label>
                                  Barangay
                                </label>
                                </div>

                                <div class="col-md-4">
                            <h3><small>
                            <%
                               if (currentProgram.getBrgy().size() >= 1) {
                                    out.print(currentProgram.getBrgy().get(0));
                                }

                                for (int i = 1; i < currentProgram.getBrgy().size(); i++) { 
                                     out.print(", " + currentProgram.getBrgy().get(i));
                                }
                            %>
                            </small></h3>
                            
                                </div>  

                              </div>
                            </div><!--DEMOGRAPHICS-->
                      </div>
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                      
                      
                    </div><!--/form-group-->
                    
                    
                    <!--BRIEF DESCRIPTION-->
                    <div class="form-group row">
                       <div class="col-md-12 col-sm-12 col-xs-12">
                            <label class="control-label">Brief Description:</label>
                        </div>
                        <div class="col-md-12">
                            <textarea readonly type="text" required="required" class="form-control noMargin" id="description" name="description" cols="10" rows="5" placeholder="eg. Description of project"><%=currentProgram.getDescription()%></textarea>
                        </div><!--/col-md-5-->

                    </div>
                    <!--END OF DESCRIPTION-->   
                    
                    <!--RESOURCE-->
                    <div class="form-group row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <label class="control-label">Resource Plan:</label>
                        </div>
                        
                        <div class="col-md-12">
                           
                            <!--TABLE FORM-->
                                <div class="table-responsive">
                                <table class="table table-bordered table-hover table-sortable" id="tab_logic">
                                    <thead>
                                        <tr>
                                            <th class="text-center">
                                                Item
                                            </th>
                                            <th class="text-center">
                                                Unit
                                            </th>
                                            <th class="text-center">
                                                Quantity
                                            </th>
                                            <th class="text-center">
                                                Price
                                            </th>
                                            <th class="text-center">
                                                Total
                                            </th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <%
                                           int currentProgramID = currentProgram.getProgram_id();
                                            ArrayList<String> vName = new ArrayList<String>();
                                            ArrayList<Resource> vList1 = nDAO.getAllResourcesOfProgram(currentProgramID);
                                            for (int b = 0; b < vList1.size(); b++){
                                        %>

                                        <tr>
                                            <td width="50%">
                                                <%=vList1.get(b).getItem()%>
                                           </td>
                                            <td width="10%"> 
                                                <%=vList1.get(b).getUnit()%>
                                            </td>
                                            <td width="10%"> 
                                                <%=vList1.get(b).getQty()%>
                                            </td>
                                            <td width="10%"> 
                                                <%=vList1.get(b).getPrice()%>
                                            </td>
                                            <td width="10%"> 
                                                <%=vList1.get(b).getTotal()%>
                                            </td>
                                        </tr>

                                        <%}%>

                                    </tbody>

                                </table>
                                </div> <!--/Table--> 
                                
                        </div><!--/col-md-12-->
                        
                        <div class="pull-right col-xs-4">
                          <table class="table table-bordered table-hover" id="tab_logic_total">
                            <tbody id="totalbudget">
                              <tr>
                                <th class="text-center">Total Budget</th>
                                    <td class="text-center">
                                        <%=currentProgram.getTotal_price()%>
                                    </td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                        
                    </div>
                    <!--RESOURCE-->                               

                </div>
                <!--x_content buong form-->
                </div><!--x_panel buong form-->
            <!-- End of Program Proposal-->
                                                    
             <!--x_panel buong form-->
            
                                                    <!--end of grep-->
                                               </div>
                                                <!--modal-body-->

                                                <div class="modal-footer">
                                                    
                                                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                
                                                </div>

                                              </div>
                                            </div>
            </div>
                    
             <%}%>           
                        
            <!-- END OF MODAL  -->                  

                </div>
                <!--x_content buong form-->
                </div><!--x_panel buong form-->
            
        </div>
        
        <%
            }
        %>
        <!-- End of SUGGESTION CARD with no evaluation-->
        
        
        
    <!--ADD PROPOSAL -->    
        
        
        <form action="AddProgramProposal" method="post" >
        <input type="hidden" name="source" value="AddNew">
        <!--PROGRAM CATEGORY Card--> 
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
                        
                        <%
                            Program currentProgram = new Program ();
                            
                            if (session.getAttribute("programCategory") != null) {
                                String category = (String) session.getAttribute("programCategory");
                                
                                String[] agelist = (String[]) session.getAttribute("programAge");
                                ArrayList<Integer> age_groups = new ArrayList<Integer> ();
                                for (int x=0; x < agelist.length; x++){
                                    System.out.println("alist " +agelist[x]);
                                    age_groups.add(Integer.parseInt(agelist[x]));
                                }
                                
                                String[] brgylist = (String[]) session.getAttribute("programBarangay");
                                ArrayList<String> brgy = new ArrayList<String> ();
                                for (int x=0; x < brgylist.length; x++){
                                    System.out.println("brgylist " +brgylist[x]);
                                    brgy.add(brgylist[x]);
                                }
                                
                                String gender = (String) session.getAttribute("programGender");
                                
                                currentProgram.setAge_groups(age_groups);
                                currentProgram.setBrgy(brgy);
                                currentProgram.setGender(gender);
                                currentProgram.setCategory(category);
                                
                            }
                        %>

                        <!--TITLE-->
                        <div class="form-group row">

                         <div class="col-md-12">
                            <label class="col-md-4 control-label">Program Category:</label>

                           <div class='col-md-8'>
                               <select required="required" id="category" name="category" class="form-control">
                                   <option selected="true" disabled="disabled" value="" selected>    --SELECT PROJECT CATEGORY--</option>
                                        <option <% if(currentProgram.getCategory().equalsIgnoreCase("Expanded Program on Immunization")){ %> selected <% } %> value="Expanded Program on Immunization">Expanded Program on Immunization</option>
                                
                                <option <% if(currentProgram.getCategory().equalsIgnoreCase("Disease Surveillance")){ %> selected <% } %> value="Disease Surveillance">Disease Surveillance</option>
                                
                                <option <% if(currentProgram.getCategory().equalsIgnoreCase("Control of Acute Respiratory Infections")){ %> selected <% } %> value="Control of Acute Respiratory Infections">Control of Acute Respiratory Infections</option>
                                
                                <option <% if(currentProgram.getCategory().equalsIgnoreCase("Control of Diarrheal Diseases")){ %> selected <% } %> value="Control of Diarrheal Diseases">Control of Diarrheal Diseases</option>
                                
                                <option <% if(currentProgram.getCategory().equalsIgnoreCase("Micronutrients Supplementation/Nutrition")){ %> selected <% } %> value="Micronutrients Supplementation/Nutrition">Micronutrients Supplementation/Nutrition</option>
                                
                                <option <% if(currentProgram.getCategory().equalsIgnoreCase("Family Planning Program")){ %> selected <% } %> value="Family Planning Program">Family Planning Program</option>
                                
                                <option <% if(currentProgram.getCategory().equalsIgnoreCase("Tuberculosis Control Program")){ %> selected <% } %> value="Tuberculosis Control Program">Tuberculosis Control Program</option>
                                
                                <option <% if(currentProgram.getCategory().equalsIgnoreCase("STD/AIDS Prevention and Control Program")){ %> selected <% } %> value="STD/AIDS Prevention and Control Program">STD/AIDS Prevention and Control Program</option>
                                
                                <option <% if(currentProgram.getCategory().equalsIgnoreCase("Environmental Sanitation Program")){ %> selected <% } %> value="Environmental Sanitation Program">Environmental Sanitation Program</option>
                                
                                <option <% if(currentProgram.getCategory().equalsIgnoreCase("Cancer Control Program")){ %> selected <% } %> value="Cancer Control Program">Cancer Control Program</option>
                                
                                <option <% if(currentProgram.getCategory().equalsIgnoreCase("Maternal Care")){ %> selected <% } %> value="Maternal Care">Maternal Care</option>
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
                                    <select required="required" id="tag1" name="age" class="multipleselect" multiple="multiple">
                                        
                                        <option value="1"   <%if (currentProgram.getAge_groups().contains(1)){%>selected<%}%>   >Below 18</option>
                                        <option value="2"   <%if (currentProgram.getAge_groups().contains(2)){%>selected<%}%>   >18-24</option>
                                        <option value="3"   <%if (currentProgram.getAge_groups().contains(3)){%>selected<%}%>   >25-34</option>
                                        <option value="4"   <%if (currentProgram.getAge_groups().contains(4)){%>selected<%}%>   >35-44</option>
                                        <option value="5"   <%if (currentProgram.getAge_groups().contains(5)){%>selected<%}%>   >45-54</option>
                                        <option value="6"   <%if (currentProgram.getAge_groups().contains(6)){%>selected<%}%>   >Above 55</option>

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
                                    <select required="required" class="multipleselect" name="gender" id="tag2" multiple="multiple" >
                                        <option value="Male"    <%if (currentProgram.getGender().equalsIgnoreCase("All") || currentProgram.getGender().equalsIgnoreCase("Male")){%>selected<%}%>   >Male</option>
                                    <option value="Female"  <%if (currentProgram.getGender().equalsIgnoreCase("All") || currentProgram.getGender().equalsIgnoreCase("Female")){%>selected<%}%>   >Female</option>
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
                                    <select required="required" id="tag3" name="barangay" class="multipleselect" multiple="multiple">
                                        <option value="Dolores" <%if(currentProgram.getBrgy().contains("Dolores")){%>selected<%}%> >Dolores</option>
                                    <option value="Juliana" <%if(currentProgram.getBrgy().contains("Juliana")){%>selected<%}%>>Juliana</option>
                                    <option value="Lourdes" <%if(currentProgram.getBrgy().contains("Lourdes")){%>selected<%}%>>Lourdes</option>
                                    <option value="Magliman"    <%if(currentProgram.getBrgy().contains("Magliman")){%>selected<%}%>>Magliman</option>
                                    <option value="San Jose"    <%if(currentProgram.getBrgy().contains("San Jose")){%>selected<%}%>>San Jose</option>
                                    <option value="San Juan"    <%if(currentProgram.getBrgy().contains("San Juan")){%>selected<%}%>>San Juan</option>
                                    <option value="Sto. Rosario"    <%if(currentProgram.getBrgy().contains("Sto. Rosario")){%>selected<%}%>>Sto. Rosario</option>
                                    <option value="Sta. Teresita"   <%if(currentProgram.getBrgy().contains("Sta. Teresita")){%>selected<%}%>>Sta. Teresita</option>
                                    <option value="Sto. Nino"   <%if(currentProgram.getBrgy().contains("Sto. Nino")){%>selected<%}%>>Sto. Nino</option>
                                </select>
                                    </div>  

                                      <div class="col-md-4"></div>


                                  </div> <!--/row-->

                                  <div class="row" align="center">
                                     <div class="row">&nbsp;</div>
                                     <div class="row">&nbsp;</div>
                                      <div class="col-md-8" >
                                          <button type="submit" id="suggestedbutton" name="selectfamilynumber" value="1" class="btn btn-info btn-sm"><i class="fa fa-book"></i> See Previous Related Programs</button>
                                      </div>
                                     <div class="col-md-4" >
                                          <button  type="button" class="btn btn-sm btn-primary" id="createprogram" onclick="showDiv()"><i class="fa fa-plus"></i> Create Program</button>                           
                                     </div>
                                     
                                  </div><!--/row-->

                                </div><!--DEMOGRAPHICS-->
                          </div>                      

                        </div><!--/form-group-->


                    </div>
                    <!--x_content buong form-->
                    </div><!--x_panel buong form-->

            </div>
        
              <!-- End of PROGRAM CATEGORY-->        
                      
        <!--PROGRAM DETAIL CARD-->
        <div class="col-md-6 col-sm-6 col-xs-12">
            
                
                <div class="x_panel" id="programproposalcard" style="display: none;">

                    <div class="x_content">
                        
                        <button  type="button" class="btn btn-sm btn-default" id="suggestulit" onclick="showDivSuggest()"><i class="fa fa-minus"></i> Hide </button>                           
                        </div>
                        <center>
                            <h3>
                                <strong>PROGRAM DETAILS<br>
                                </strong>
                            </h3>
                        </center>
                        <div class="col-md-1">
                        
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
                            <input type="text"  class="form-control noMargin" id="title" name="title" placeholder="eg. Feeding Program">
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
                            <input type="number" " class="form-control noMargin" id="numofpart" name="noofparticipants" placeholder="eg. 1,000" value="0">
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
                            <textarea type="text" class="form-control noMargin" id="description" name="description" cols="10" rows="5" placeholder="eg. Description of project"></textarea>
                            </div><!--/col-md-5-->

                            </div>
                            <!--END OF DESCRIPTION-->    
                            
                            <!--RESOURCE-->
                            <div class="form-group row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <label class="control-label">Resource Plan:
                                    </label>
                                    
                                <div class="container">
                              
                            <div class="row clearfix">    
                                <div class="col-md-12 table-responsive">
                                    <table class="table table-bordered table-hover table-sortable" id="tab_logic">
                                        <thead>
                                            <tr>
                                                <th class="text-center">
                                                    Item
                                                </th>
                                                <th class="text-center">
                                                    Unit
                                                </th>
                                                <th class="text-center">
                                                    Quantity
                                                </th>
                                                <th class="text-center">
                                                    Price
                                                </th>
                                                <th class="text-center">
                                                    Total
                                                </th>
                                                <th class="text-center">
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id=resourceplan>
                                          <tr>
                                            <td>
                                                <input type="text" name="name"  placeholder="Item" class="form-control required" />
                                            </td>
                                            <td>
                                                 <input  type="text" name="unit" placeholder="e.g. pc" class="form-control" />
                                            </td>
                                            <td>
                                                <input type="number" id="quantity" name='quantity' placeholder="e.g. 1" class="form-control"/>
                                            </td>
                                            <td>
                                                 <input type="number" id="price" name='price' placeholder="e.g 100" class="form-control" />
                                            </td>
                                            <td>
                                                <input type="text" name="total" id="total" placeholder="0.00" class="form-control total" readonly/>
                                            </td>
                                            <td>
                                                <button onclick="updateTotal()" name="del" class='btn btn-danger glyphicon glyphicon-remove row-remove'></button>
                                            </td>
                                          </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                                
                                <div class="row clearfix">
                                    <div class="col-md-12">
                                      <a id="add_row" class="btn btn-default pull-right">Add Row</a>
                                    </div>
                                </div>
                                                                                  
                                <div class="row clearfix" style="margin-top:20px">
                                    <div class="pull-right col-xs-4">
                                      <table class="table table-bordered table-hover" id="tab_logic_total">
                                        <tbody id="totalbudget">
                                          <tr>
                                            <th class="text-center">Total Budget</th>
                                            <td class="text-center"><input type="number" id="total_budget" name="total_budget" placeholder='0.00' class="form-control" readonly/></td>
                                          </tr>
                                        </tbody>
                                      </table>
                                    </div>
                                </div> 
                                
                              </div> <!--row clearfix-->
                            </div> <!--container-->
                                
                            </div><!col-md-12 col-sm-12 col-xs-12-->
                            <!--RESOURCE-->                      

                            </div><!--/form-group-->




                         <footer>
                            <div class="form-group" align="center">
                                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                    <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                    <button type="submit" name="addProgram" value="1" class="btn btn-success" id="nextPage">Submit</button>
                                </div>
                            </div>
                        </footer>


                    </div>
                    <!--x_content buong form-->
                    </div><!--x_panel buong form-->
                <!-- End of Program Proposal-->
            
                
        </div>
        
        </form>    
   
    <!-- END ADD PROPOSAL -->
          
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
                <!-- starRating -->
                <script src="vendors/bootstrap-star-rating/js/star-rating.js" type="text/javascript"></script>
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
                <!-- PNotify -->
                <script src="../vendors/pnotify/dist/pnotify.js"></script>
                <script src="../vendors/pnotify/dist/pnotify.buttons.js"></script>
                <script src="../vendors/pnotify/dist/pnotify.nonblock.js"></script>
</body>
   
   
<!-- ADD ROW RESOURCE--> 
<script>        
$("#add_row").click(function () {
     $("#resourceplan").each(function () {
         var tds = '<tr>';
         jQuery.each($('tr:last td', this), function () {
             tds += '<td>' + $(this).html() + '</td>';
         });
         tds += '</tr>';
         if ($('tbody', this).length > 0) {
             $('tbody', this).append(tds);
         } else {
             $(this).append(tds);
         }
          updateTotal();
     });
    
    
});                     
</script>

<!-- Delete ROW RESOURCE--> 
<script>        
$(document).ready(function(){
 $("#tab_logic").on('click','.row-remove',function(){
       $(this).closest('tr').remove();
       updateTotal();

     });
    
});                  
</script>


<!-- CALCULATE PRICE -->
<script>
$("table").on("change", "input", function () {  //use event delegation
  var tableRow = $(this).closest("tr");  //from input find row
  var qty = Number(tableRow.find("#quantity").val());  //get quantity textbox
  var price = Number(tableRow.find("#price").val());  //get price textbox
  var total = (qty * price).toFixed(2);  //calculate total
  tableRow.find("#total").val(total);  //set value
  updateTotal();
});
</script>
    
<!-- CALCULATE TOTAL PRICE -->
<script>
function updateTotal(){
    var sum=0;
    $('.total').each(function(i, obj){

     if($.isNumeric(this.value)) {
                sum += parseFloat(this.value);
            }
         $('#total_budget').val(sum);
     })
   
    
}                        
</script>  

<script>
$(document).ready(function() {
    $('#datatable-suggested').DataTable();    
} );
</script>
<script>
$(document).ready(function() {
    $('#datatable-suggested-3').DataTable();    
} );
</script>
<!--Create Program-->
<script>
function showDiv() {
   document.getElementById('programproposalcard').style.display = "";
   document.getElementById('createprogram').style.display = "none";
   document.getElementById('suggestedbutton').style.display = "none";
   document.getElementById('title').required = "required";
   document.getElementById('datepicker1').required = "required";
   document.getElementById('datepicker2').required = "required";
   document.getElementById('numofpart').required = "required";
   document.getElementById('description').required = "required";
}    
</script>


<script>
function showDivSuggest() {
   document.getElementById('programproposalcard').style.display = "none";
   document.getElementById('createprogram').style.display = "";
   document.getElementById('suggestedbutton').style.display = "";
   document.getElementById('title').required = "";
   document.getElementById('datepicker1').required = "";
   document.getElementById('datepicker2').required = "";
   document.getElementById('numofpart').required = "";
   document.getElementById('description').required = "";
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

<!-- COLLAPSE DISEASE CHART
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
</script>-->

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

</html>
