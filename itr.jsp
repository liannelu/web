<%@page import="Model.Patient"%>
<%@page import="Model.Consultation"%>
<%@page import="Model.Diagnosis"%>
<%@page import="Model.User"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="DAO.userDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date;"%>


<%
session.removeAttribute("disposition");
%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Individual Treatment Record </title>

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
           
            <form action="ITR" id="ITR" method="post">
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
                    <li class="breadcrumb-item">Forms</li>
                   <li class="breadcrumb-item active"> Individual Treatment Record</li>
                </ol>   
                    <!-- <div class="row">-->
                    <div class="col-md-12 col-sm-12 col-xs-12">

                       <!--banner-->
                         <%
                            String error=(String)request.getAttribute("error");  
                            if(error!=null){
                         %> 
                            <div class="alert alert-danger alert-dismissible fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><i class="fa fa-close"></i>
                            </button>
                            <h2><span class="fa fa-exclamation"></span> <%=error%></h2>
                          </div>
                         <%}%>
                         <%
                            String success=(String)request.getAttribute("success");  
                            if(success!=null){
                         %>
                           <div class="alert alert-success alert-dismissible fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><i class="fa fa-close"></i>
                            </button>
                            <h2><span class="fa fa-check-circle"></span> <%=success%></h2>
                          </div>
                          <%}%>
                          <!--banner-->
                          
                        <div class="page-title">
                            <div class="title_left">
                                <h3>INDIVIDUAL TREATMENT RECORD</h3>
                                <h5>Patient Record </h5>
                            </div>

                        </div>
                        <!--page-title-->
                        
                        <!--I'm tired --> 
                        <%
                            int patientID = (Integer) session.getAttribute("id");
                            nurseDAO nDAO = new nurseDAO();
                            Patient currentPatient = new Patient();
                            currentPatient = nDAO.getPatient(patientID);
                            
                            User addedby = nDAO.retrieveUser(currentPatient.getAdded_by()); //gets the user who added the patient
                            String name_addedby = addedby.getPosition()+" "+addedby.getFirstname()+" "+addedby.getMiddlename()+" "+addedby.getLastname();
                            
                            //BIRTHDAY omg//
                            SimpleDateFormat month = new SimpleDateFormat("MMMM dd");  
                            SimpleDateFormat year = new SimpleDateFormat("yyyy"); 
                            
                            Date tempbirthday = currentPatient.getBirthdate();
                            String birthdayMonth = month.format(tempbirthday);
                            String birthdayYear = year.format(tempbirthday);
                            String birthdate = birthdayMonth + ", " + birthdayYear;

                        %>
                        
                        <!--PATIENT INFORMATION-->
                            <jsp:include page="/patient_information.jsp" />
                            
                        <!--TYPE OF CONSULTATION-->
                        <div class="x_panel">
                            <div class="x_title">
                               <form action="AddNewConsultation" method="post">
                                <i class="fa fa-align-justify"></i>
                                <!--get information from database -->
                                <strong> CONSULTATION HISTORY</strong> 
                                
                             <%
                               if(!(currentPatient.getStatus().equalsIgnoreCase("Dead"))){ %>
                                <button  type="submit" class="btn btn-sm btn-primary" style="float: right"><i class="fa fa-plus"></i> Create New Consultation</button>
                            <%}%>
                                
                                <input type="hidden" name="go_to_new_consultation" value="<%=patientID%>">
                                </form>
                                
                            </div>

                            <div class="x_content">
                               
                               <!--CONSULTATION HISTORY TABLE--> 
                                <div class="col-md-12">
                                    <table id="datatable-dateofvisit" class="table table-bordered dt-responsive table-condensed" cellspacing="0" width="100%">
                                      <thead>
                                        <tr>
                                          <th width="1%"><span class="text-nowrap">Visit Date</span></th>
                                          <th width="1%">Con#</th>
                                          <th width="">Purpose</th>
                                          <th width="">Diagnosis</th>
                                          <th><span class="text-nowrap">Disposition</span></th>
                                          <th><span class="text-nowrap">Status</span></th>
                                          <th><span class="text-nowrap">Action</span></th>
                                        </tr>
                                      </thead>
                                      
                                      <%
                                          nurseDAO nurse = new nurseDAO();
                                          userDAO userDAO = new nurseDAO();
                                          ArrayList <Consultation> consultations  = new ArrayList();
                                          consultations = nurse.retrieveAllConsultationByPatient(patientID);
                                          int row_count = consultations.size();

                                          for(int i = 0; i < row_count; i++) {
                                          Consultation cons = consultations.get(i);
                                          Diagnosis d = nurse.getDiagnosis(cons.getDiagnosis());
                                          String typeOfConsultation = cons.getType_of_consultation();
                                          
                                          //Patient Status//
                                            String patientStatus = nurse.getPatientStatus(consultations.get(i).getPatient_id());
                                          
                                          //Added By//
                                          User u = nurse.retrieveUser(cons.getAdded_by());
                                          
                                          //Acknowledged_by
                                        User u2 = new User();
                                        String acknowledgedBy = "N/A";
                                        if(cons.getAcknowledged_by() != 0){
                                            u2 = userDAO.retrieveUser(cons.getAcknowledged_by());
                                            acknowledgedBy = "Dr. " + u.getFullname();
                                        }
                                      %>
                                      
                         <!-- TABLE LAMAN 1-->     
                              <input type="hidden" name="row_count" value="<%=row_count%>">
                              <tr>
                                  <td><span class="text-nowrap"><%=cons.getDate()%></span></td>
                                <td><%=cons.getConsultation_id() %></td>
                                <td><%=cons.getType_of_consultation()%></td>
                                  <td><span class="text-nowrap"><%=d.getDiagnosis()%></span></td>
                                <!--DISPOSITION-->
                                <td><span class="text-nowrap"> 
                                    <% if(consultations.get(i).getDis_condition() == null) { %>
                                    <div><span class="label label-default" style="display: block;" >N/A</span></div> 
                                    <% }else if(consultations.get(i).getDis_condition().equalsIgnoreCase("Recovered")){ %>
                                    <div><span class="label label-success" style="display: block;" >Recovered</span></div>
                                    <% }else if(consultations.get(i).getDis_condition().equalsIgnoreCase("Improved")){ %>
                                    <div><span class="label label-info" style="display: block;" >Improved</span></div>
                                    <% }else if(consultations.get(i).getDis_condition().equalsIgnoreCase("No Improvement")){ %>
                                    <div><span class="label label-primary" style="display: block;" >No Improvement</span></div>
                                    <% }else if(consultations.get(i).getDis_condition().equalsIgnoreCase("Worsened")){ %>
                                    <div><span class="label label-warning" style="display: block;" >Worsened</span></div>
                                    <% }else if(consultations.get(i).getDis_condition().equalsIgnoreCase("Died")){ %>
                                    <div><span class="label label-danger" style="display: block;" >Died</span></div>
                                    <% } %>
                                    </span>
                                </td>
                               
                                <!--STATUS-->
                                <td width="">
                                    <span class="text-nowrap"> 
                                    <% if(cons.getAcknowledged_by() != 0 ){  //If GENERAL and HAS Acknowledged_by
                                    %> <div><span class="label label-success" style="display: block;">Completed</span></div><%
                                    }
                                    if(!(cons.getAcknowledged_by() != 0)){ //Pag wala pang diagnosis
                                       %> <div> <span class="label label-warning" style="display: block;">Pending ACK</span> </div><p/>

                                    <% } %>
                                    </span>
                                </td>
                                 <!--ACTION-->
                                <td style="width:240px;"> 
                                  <div class="btn-group alignleft" >

                                   <div class="btn-group">
                                      <button data-toggle="dropdown" class="btn btn-primary btn-sm dropdown-toggle" type="button"> Action <span class="caret"></span> </button>
                                      <ul class="dropdown-menu">
                                      
                                <% if (currentPatient.getStatus().equalsIgnoreCase("Dead")){ %>
                                    <li>
                                           Patient already declared dead. No actions available.
                                    </li>
                                <% } else{ 
                                
                                if(userType.equalsIgnoreCase("physician") && consultations.get(i).getAcknowledged_by() == 0 ){ //Pag hindi pa acknowledged
                                %> 
                                    <li>
                                       <button type="submit" class="buttonlink" name="acknowledgeConsultation" value="<%=cons.getConsultation_id()%>">Acknowledge </button>
                                    </li>
                                <% } %>
                                <%
                                    if( userType.equalsIgnoreCase("physician") && consultations.get(i).getDis_condition() == null && consultations.get(i).getAcknowledged_by() > 0 || userType.equalsIgnoreCase("nurse") && consultations.get(i).getDis_condition() == null && consultations.get(i).getAcknowledged_by() > 0 ){ //Pag wala pang disposition
                                %>    
                                    <li>
                                        <button type="submit" class="buttonlink" name="addDisposition" value="<%=cons.getConsultation_id()%>">Add Disposition</a>
                                    </li>
                                <% } %>
                                          
                              <!--Pag acknowledged na and added disposition -->
                               <% if(consultations.get(i).getAcknowledged_by() > 0 && consultations.get(i).getDis_condition() != null) { 
                                %> 
                                    <li>
                                           No actions available.
                                    </li>
                                <% } 
                                } %>
                                      </ul>
                                    </div>
                                     
                                      <button type="submit" name="viewConsultation" value="<%=cons.getConsultation_id()%>" class="btn btn-info btn-sm"><i class="fa fa-eye"></i> View</button>


                                    <% if (cons.getFollow_up_cons_id() > 0 || currentPatient.getStatus().equalsIgnoreCase("Dead")){
                                        //dont put any button kasi may laman
                                    }else{ 
                                        //mag lagay ka
                                        if (cons.getSchcedule_of_next_visit() != null){
                                      %>

                                    <button type="submit" name="addfollowupbtn" value="<%=cons.getConsultation_id()%>" class="btn btn-success btn-sm"><i class="fa fa-plus"></i> Follow-Up</button>
                                    <input type="hidden" name="row_id<%=i%>" value="<%=cons.getConsultation_id()%>">
                                    <%}}%>

                                  </div>
                                </td><!--/ACTION-->
                              </tr>
                              <%}%>
                                      <tbody>
                                      
                                      </tbody>
                                    </table>
                                </div> <!--col-12-->
                            </div> <!--x_content-->
                        </div> <!--/.x_panel-->

                        
                        <% if (!(currentPatient.getStatus().equalsIgnoreCase("Dead"))){ %>
                        <div class="x_panel">
                            <div class="x_title edited">
                                <i class="fa fa-align-justify"></i>
                                <!--get information from database -->
                                <strong> PENDING FOLLOW-UP VISITS</strong> 
                            </div>
                            
                            <div class="x_content">
                               <!--PENDING VISITS TABLE-->
                                <div class="col-md-12">
                                    <table id="datatable-pending" class="table table-bordered dt-responsive table-condensed" cellspacing="0" width="100%">
                                      <thead>                                      
                                        <tr>
                                          <th width="1%">Next Visit Date</th>
                                          <th width="1%"><span class="text-nowrap">Visit Date</span></th>
                                          <th width="">Con#</th>
                                          <th width="">Purpose</th>
                                          <th width="">Diagnosis</th>
                                          <th><span class="text-nowrap">Disposition</span></th>
                                          <th width="1%"><span class="text-nowrap">Status of Follow-Up</span></th>
                                          <th><span class="text-nowrap">Action</span></th>
                                        </tr>
                                      </thead>
                                      
                                      <%
                                          nurse = new nurseDAO();
                                          userDAO = new nurseDAO();
                                          consultations  = new ArrayList();
                                          consultations = nurse.retrieveAllPendingConsultationByPatient(patientID);
                                          int row_count1 = consultations.size();
                                          
                                          for(int i = 0; i < row_count1; i++) {
                                          Consultation cons = consultations.get(i);
                                          Diagnosis d = nurse.getDiagnosis(cons.getDiagnosis());
                                          String typeOfConsultation = cons.getType_of_consultation();
                                          
                                          //ADEDD BY//
                                          User u = nurse.retrieveUser(cons.getAdded_by());
                                          
                                          //Acknowledged_by
                                        User u2 = new User();
                                        String acknowledgedBy = "N/A";
                                        if(cons.getAcknowledged_by() != 0){
                                            u2 = userDAO.retrieveUser(cons.getAcknowledged_by());
                                            acknowledgedBy = "Dr. " + u.getFullname();
                                        }
                                      %>
                                      
                        <!-- TABLE LAMAN 2-->
                              <input type="hidden" name="row_count1" value="<%=row_count1%>">
                              <tr>
                               <td><span class="text-nowrap"><%=cons.getSchcedule_of_next_visit()%></span></td>
                                <td><span class="text-nowrap">
                                    <%=cons.getDate()%>
                                    </span>
                                </td> 
                                <td><%=cons.getConsultation_id() %>
                                    
                                </td>
                                <td><%=cons.getType_of_consultation()%></td>
                                <td><%=d.getDiagnosis()%></td>
                                <!--DISPOSITION-->
                                <td> <span class="text-nowrap">
                                    <% if(consultations.get(i).getDis_condition() == null) { %>
                                    <div><span class="label label-default" style="display: block;" >N/A</span></div> 
                                    <% }else if(consultations.get(i).getDis_condition().equalsIgnoreCase("Recovered")){ %>
                                    <div><span class="label label-success" style="display: block;" >Recovered</span></div>
                                    <% }else if(consultations.get(i).getDis_condition().equalsIgnoreCase("Improved")){ %>
                                    <div><span class="label label-info" style="display: block;" >Improved</span></div>
                                    <% }else if(consultations.get(i).getDis_condition().equalsIgnoreCase("No Improvement")){ %>
                                    <div><span class="label label-primary" style="display: block;" >No Improvement</span></div>
                                    <% }else if(consultations.get(i).getDis_condition().equalsIgnoreCase("Worsened")){ %>
                                    <div><span class="label label-warning" style="display: block;" >Worsened</span></div>
                                    <% }else if(consultations.get(i).getDis_condition().equalsIgnoreCase("Died")){ %>
                                    <div><span class="label label-danger" style="display: block;" >Died</span></div>
                                    <% } %>
                                    </span>
                                </td>
                                <!--STATUS-->
                                <td width="" >
                                    <span class="text-nowrap">
                                        
                                        <%

                                        //Date tempDate = cons.getSchcedule_of_next_visit();

                                        if(nurse.compareDate(cons.getSchcedule_of_next_visit())){
                                            %> <div><span class="label label-danger" style="display: block;" >Missed</span></div><%
                                        }else{
                                            %> <div> <span class="label label-warning" style="display: block;">Pending </span> </div><p/> <%
                                        }


                                        %>

                                    </span>
                                </td>
                                <!--ACTION-->
                                <td style="width:240px;"> 
                                    <div class="btn-group alignleft" >

                                    <div class="btn-group">
                                    <button data-toggle="dropdown" class="btn btn-primary btn-sm dropdown-toggle" type="button"> Action <span class="caret"></span> </button>
                                    <ul class="dropdown-menu">
                                 
                                    <%
                                    if(userType.equalsIgnoreCase("physician") && consultations.get(i).getAcknowledged_by() == 0 ){ //Pag hindi pa acknowledged
                                    %>  
                                      <li>
                                       <button type="submit" class="buttonlink" name="acknowledgeConsultation" value="<%=cons.getConsultation_id()%>">Acknowledge </button>
                                      </li>
                                    <% } %>
                                    <%
                                    if( userType.equalsIgnoreCase("physician") && consultations.get(i).getDis_condition() == null && consultations.get(i).getAcknowledged_by() > 0 || userType.equalsIgnoreCase("nurse") && consultations.get(i).getDis_condition() == null && consultations.get(i).getAcknowledged_by() > 0 ){ //Pag wala pang disposition
                                    %> 
                                    <li>
                                       <button type="submit" class="buttonlink" name="addDisposition" value="<%=cons.getConsultation_id()%>">Add Disposition</a>
                                    </li>
                                    <% } %>
                                    <!--Pag acknowledged na and added disposition -->
                                    <% if(consultations.get(i).getAcknowledged_by() > 0 && consultations.get(i).getDis_condition() != null) { 
                                    %> 
                                    <li>
                                       No more actions available
                                    </li>
                                <% } %>
                                     
                                      </ul>
                                    </div>

                                      <button type="submit" name="viewConsultation" value="<%=cons.getConsultation_id()%>" class="btn btn-info btn-sm"><i class="fa fa-eye"></i> View</button>


                                    <% if (cons.getFollow_up_cons_id() > 0){
                                        //dont put any button kasi may laman
                                    }else{ 
                                        //mag lagay ka
                                        if (cons.getSchcedule_of_next_visit() != null){
                                      %>

                                    <button type="submit" name="addfollowupbtn" value="<%=cons.getConsultation_id()%>" class="btn btn-success btn-sm"><i class="fa fa-plus"></i> Follow-Up</button>
                                    <input type="hidden" name="row_id<%=i%>" value="<%=cons.getConsultation_id()%>">
                                    <%}}%>

                                  </div>
                                </td>
                              </tr>
                              <%}%>
                                      <tbody>
                                      
                                      </tbody>
                                    </table>
                                </div> <!--col-12-->
                            </div> <!--x_content-->
                        </div> <!--/.x_panel-->
                        
                        <% } %>
                        
                        
                    </div>
                </div>
        
            </form>                
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
 <script>
    $('.collapse').on('shown.bs.collapse', function(){
    $(this).parent().find(".glyphicon-plus").removeClass("glyphicon-plus").addClass("glyphicon-minus");
    }).on('hidden.bs.collapse', function(){
    $(this).parent().find(".glyphicon-minus").removeClass("glyphicon-minus").addClass("glyphicon-plus");
    });
</script>   

<script>
$(document).ready(function() {    
    $('#datatable-dateofvisit').DataTable( {
        "order": [[0, "desc"]],
        responsive: true,
    });
    $('#datatable-pending').DataTable( {
        "order": [[0, "desc"]]
    }); 
} );
</script>
<style>
     .buttonlink {
     background:none!important;
     color:inherit;
     border:none; 
     padding:0!important;
     font: inherit;
     cursor: pointer;
}                        
</style>


</html>