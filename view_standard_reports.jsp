<%@page import="DAO.userDAO"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="DAO.programDAO"%>
<%@page import="Model.Diagnosis"%>
<%@page import="java.util.*" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date;"%>


<%
    programDAO pDAO = new programDAO();
%>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>View Reports</title>

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
                    <li class="breadcrumb-item">View </li>
                   <li class="breadcrumb-item active">View Reports</li>
                </ol>   
                    <!-- <div class="row">-->
                    <div class="col-md-12 col-sm-12 col-xs-12">

                        <div class="page-title">
                            <div class="title_left">
                                <h3><i class="fa fa-table"></i> View Reports</h3>        
                            </div>

                        </div>
                        <!--page-title-->

                <div class="clearfix"></div>
  
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        
                        <!-- Button for checkin thresholds-->
                        <!-- Don't need this anymore
                        <form action="CheckThresholds" method="post">
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <label for="" class="col-2 col-form-label"></label>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary " name="checkThresholds" style="margin-top: 4px;">Check Disease Thresholds</button>
                                </div>
                            </div>

                        </form>
                        -->
                        
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
                            list = pDAO.checkThreshold(month, dayOfMonth);

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
                                                  <td><button type="submit" name="selectedDisease" value="<%=list.get(i).getDiagnosis_id()%>" id="viewuser" class="btn btn-warning btn-sm"><i class="fa fa-eye"></i>View</button></td>
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
                        
                        
                        
                        <div class="x_panel">
                            
                            <div class="x_title">
                                <h2>Mandatory Reports <small> Reports to be submitted to DoH</small></h2>
                                <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            
                            <div class="x_content">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th width="30%">Report Name</th>
                                            <th>Description</th>
                                            <th width="20%">Action</th>
                                        </tr>
                                    </thead>
                                    
                                    <tbody>
                                        <tr>
                                            <th scope="row"> <a href=reportM1.jsp>M1 </a></th>
                                            <td>Monthly M1 Report</td>
                                            <td> <button onClick="window.location='reportM1.jsp';"type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button> </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> <a href=reportM2.jsp>M2</a></th>
                                                <td>Monthly M2 Report</td>
                                                <td>
                                                    <button onClick="window.location='reportM2.jsp';" 
                                                            type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button>
                                                </td>
                                        </tr>
                                        
                                        <tr>
                                            <th scope="row"> <a href=reportA2.jsp>A2</a></th>
                                                <td>Annual A2 Report</td>
                                                <td>
                                                    <button onClick="window.location='reportA2.jsp';" 
                                                            type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button>
                                                </td>
                                        </tr>
                                        
                                        <tr>
                                            <th scope="row"> <a href=reportPCBA2.jsp>PCB A2</a></th>
                                                <td>Annex 2 - Provider Clientele Profile</td>
                                                <td>
                                                    <button onClick="window.location='reportPCBA2.jsp';" 
                                                            type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button>
                                                </td>
                                        </tr>
                                        
                                        <tr>
                                            <th scope="row"> <a href=reportPCBA4.jsp>PCB A4</a></th>
                                                <td>Annex 4 - Quarterly Report Form </td>
                                                <td>
                                                    <button onClick="window.location='reportPCBA4.jsp';" 
                                                            type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button>
                                                </td>
                                        </tr>
                                        
                                    </tbody>
                                    
                                </table>

                            </div>
                        </div>

                <div class="x_panel">
                    <div class="x_title">
                        <h2> <b>Custom Reports</b><small> Descriptive analytics for the RHU </small></h2>
                        <ul class="nav navbar-right panel_toolbox">
                          <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                          </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    
                    <div class="x_content">
                        <table class="table table-hover">
                            <thead>
                              <tr>
                                <th width="30%">Report Name</th>
                                <th>Description</th>
                                  <th width="20%">Action</th>
                              </tr>
                            </thead>

                            <tbody>
                                <tr>
                                    <th scope="row"> <a href=chart_top10Diagnosis.jsp>Top Disease/Diagnosis in RHU 1</a></th>
                                    <td>Displays the most frequent occurring disease/diagnosis in RHU 1</td>
                                    <td>
                                    <button onClick="window.location='chart_top10Diagnosis.jsp';" type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <th scope="row"> <a href=chart_topDiagnosisBarangay.jsp>Top 1 Disease/Diagnsosis per Barangay</a></th>
                                    <td>Displays the top 1 disease/diagnosis for each diagnosis </td>
                                    <td>
                                    <button onClick="window.location='chart_topDiagnosisBarangay.jsp';" type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <th scope="row"> <a href=chart_diseasePerBarangay.jsp>Disease/Diagnsosis per Barangay</a></th>
                                    <td>Shows the count of a selected disease/diagnosis per barangay</td>
                                    <td>
                                    <button onClick="window.location='chart_diseasePerBarangay.jsp';" type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <th scope="row"> <a href=chart_disease.jsp>Disease/Diagnosis Chart</a></th>
                                    <td>Shows the visual line chart for a selected disease/diagnosis </td>
                                    <td>
                                    <button onClick="window.location='chart_disease.jsp';" type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>

                                <tr>
                                    <th scope="row"> <a href=chart_consultationsByPurposeOfVisit.jsp>Consultations by Purpose of Visit</a></th>
                                    <td>Shows total consultations by purpose of visit frequency </td>
                                    <td>
                                    <button onClick="window.location='chart_consultationsByPurposeOfVisit.jsp';" type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>

                                <tr>
                                    <th scope="row"> <a href=chart_consultationsByGender.jsp>Consultations by Gender</a></th>
                                    <td>Shows the top consultations by each gender</td>
                                    <td>
                                    <button onClick="window.location='chart_consultationsByGender.jsp';" type="button" class="btn btn-info"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>

                                
                                <!--
                                <tr>
                                    <th scope="row"> <a href=view_custom_report.jsp>Consultations by Age Group</a></th>
                                    <td>sdasdasd</td>
                                    <td>
                                    <button onClick="window.location='view_custom_report.jsp';" type="button" class="btn btn-warning"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>
                                -->
                                <!--
                                <tr>
                                    <th scope="row"> <a href=view_custom_report.jsp>Consultations Per Barangay</a></th>
                                    <td>asdadasdas</td>
                                    <td>
                                    <button onClick="window.location='view_custom_report.jsp';" type="button" class="btn btn-warning"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>

                                <tr>
                                    <th scope="row"> <a href=view_custom_report.jsp>Consultations per BMI Category</a></th>
                                    <td>remove?</td>
                                    <td>
                                    <button onClick="window.location='view_custom_report.jsp';" type="button" class="btn btn-warning"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>

                                <tr>
                                    <th scope="row"> <a href=view_custom_report.jsp>Top 10 Diagnosis per gender</a></th>
                                    <td> remove?</td>
                                    <td>
                                    <button onClick="window.location='view_custom_report.jsp';" type="button" class="btn btn-warning"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>    
                                -->
                            </tbody>
                        </table>
                    </div>
                </div>
                       
                        
                    <!--
                    <div class="x_panel">
                          <div class="x_title">
                            <h2>Enzo Reports <small> **Deep analysis ish* </small></h2>
                            <ul class="nav navbar-right panel_toolbox">
                              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                              </li>
                            </ul>
                            <div class="clearfix"></div>
                          </div>
                          <div class="x_content">
                            <table class="table table-hover">
                              <thead>
                                <tr>
                                  <th width="30%">Report Name</th>
                                  <th>Description</th>
                                    <th width="20%">Action</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                    <th scope="row"> <a href=view_top_diagnosis.jsp> Top Diagnosis per Barangay </a></th>
                                  <td>Monthly Report - top diagnosis/diseases per brgy</td>
                                    <td>                        
                                        <button onClick="window.location='view_top_diagnosis.jsp';" 
                                                type="button" class="btn btn-warning"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"> <a href=view_custom_report.jsp> Diagnosis/Disease Report </a></th>
                                  <td>Shows where each disease/diagnosis is highest per barangnay</td>
                                    <td>                        
                                        <button onClick="window.location='view_custom_report.jsp';" 
                                                type="button" class="btn btn-warning"><i class="fa fa-eye"></i>View</button>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"> <a href=reportM2.jsp>Top Consultation type per Barangay</a></th>
                                        <td>Shows #1 consultation per barangay *in CS</td>
                                        <td>
                                            <button onClick="window.location='view_custom_report.jsp';" 
                                                    type="button" class="btn btn-warning"><i class="fa fa-eye"></i>View</button>
                                        </td>
                                </tr>
                                <tr>
                                    <th scope="row">Top Age Group Affected by Diseases<a href=view_custom_report.jsp></a></th>
                                    <td> Shows the #1 disease per age group</td>
                                        <td>
                                            <button onClick="window.location='view_custom_report.jsp';" 
                                                    type="button" class="btn btn-warning"><i class="fa fa-eye"></i>View</button>
                                        </td>
                                </tr>

                                <tr>
                                    <th scope="row">Top Diagnosis for Males<a href=view_custom_report.jsp></a></th>
                                    <td></td>
                                        <td>
                                            <button onClick="window.location='view_custom_report.jsp';" 
                                                    type="button" class="btn btn-warning"><i class="fa fa-eye"></i>View</button>
                                        </td>
                                </tr>
                                <tr>
                                    <th scope="row">Top Diagnosis for Females<a href=view_custom_report.jsp></a></th>
                                    <td></td>
                                        <td>
                                            <button onClick="window.location='view_custom_report.jsp';" 
                                                    type="button" class="btn btn-warning"><i class="fa fa-eye"></i>View</button>
                                        </td>
                                </tr>

                              </tbody>
                            </table>

                          </div>
                        </div>
                        -->
                        
                        

                    </div>

                    </div>
            </div>
        </div>
    </div>


                <!--END OF CODE-->

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
                <!-- Custom Theme Scripts -->
                <script src="source/js/custom.min.js"></script>
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

</html>


