<%@page import="Model.Patient"%>
<%@page import="Model.Diagnosis"%>
<%@page import="Model.User"%>
<%@page import="Model.Family_Code"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="DAO.userDAO"%>
<%@page import="Model.Consultation"%>
<%@page import="java.util.ArrayList"%>


<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> View Consultations (Today)</title>

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
                    <li class="breadcrumb-item">View </li>
                   <li class="breadcrumb-item active">Consultations (Today)</li>
                </ol>   
                    <!-- <div class="row">-->
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        
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

                        <div class="page-title">
                            <div class="title_left">
                                <h3><i class="fa fa-users"></i> View Consultations <strong>(Today)</strong></h3>        
                            </div>

                        </div>
                        <!--page-title-->

                        <div class="x_panel">
                            <div class="x_title">
                                <i class="fa fa-book"></i>
                                <!--get information from database!!-->
                                <strong> Consultations </strong> 
                                <!-- Elements-->
                            </div>
                            
                            <form action="SelectConsultation" id="SelectConsultation" method="post">
                                <div class="x_content" style="overflow: visible;">
                                    <div class="col-md-12">
                                        <table id="datatable-responsive" class="table table-bordered dt-responsive table-condensed" cellspacing="0" width="100%" style="overflow: visible;">
                                          <thead>
                                            <tr>
                                              <th width="1%"><span class="text-nowrap">Visit Date</span></th>
                                              <th width="1%">Con#</th>
                                              <th width="">Patient Name</th>
                                              <th width="1%">Purpose</th>
                                              <th width="1%">Disease/Diagnosis</th>
                                               <th width=1%><span class="text-nowrap">Disposition</span></th>
<!-- class="hidden-xs hidden-sm hidden-md-->
                                      <!--
                                              <th class="hidden-xs hidden-sm hidden-md hidden-lg">Added By</th>
                                              <th class="hidden-xs hidden-sm hidden-md hidden-lg">Acknowledged By</th>
-->
                                                <th><span class="text-nowrap">Status</span></th>
                                                <th width="" style=""><span class="text-nowrap">Action</span></th>
                                            </tr>
                                          </thead>
                                          
                                          <%
                                              nurseDAO nurseDAO = new nurseDAO();
                                              userDAO userDAO = new nurseDAO();
                                              ArrayList <Consultation> cList  = new ArrayList();
                                              cList = nurseDAO.retrieveConsultationToday();
                                              
                                              for(int i = 0; i<cList.size(); i++) {
                                                Patient p = new Patient();
                                                p = nurseDAO.getPatient(cList.get(i).getPatient_id());
                                                
                                                
                                                //diagnosis
                                                //No Findings, N/A
                                                Diagnosis d = new Diagnosis();
                                                String diagnosis = "";
                                                d = nurseDAO.getDiagnosis(cList.get(i).getDiagnosis());
                                                diagnosis = d.getDiagnosis();
                                                   
                                                
                                                //Purpose of Visit
                                                String typeOfConsultation = cList.get(i).getType_of_consultation();
                                                        
                                                //Acknowledged_by
                                                User u = new User();
                                                String diagnosedBy = "N/A";
                                                if(cList.get(i).getAcknowledged_by() != 0){
                                                    u = userDAO.retrieveUser(cList.get(i).getAcknowledged_by());
                                                    diagnosedBy = "Dr. " + u.getFullname();
                                                }
                                                
                                                //added_by
                                                User u2 = new User();
                                                String addedBy = "";
                                                u2 = userDAO.retrieveUser(cList.get(i).getAdded_by());
                                                addedBy = u2.getFullname();
                                                
                                                
                                          %>
                                          
                          <!--TABLE LAMAN 1-->
                          <tr>
                           <td><%=cList.get(i).getDate() %></td>
                            <td><%=cList.get(i).getConsultation_id() %></td>
                                  
                                  
                              <td><%=p.getFullname() %></%></td>
                            <td><%=typeOfConsultation%></td>
                            <td><%=diagnosis%></td>
                            <!--DISPOSITION-->
                            <td> 
                                <% if(cList.get(i).getDis_condition() == null) {  %>
                                <div><span class="label label-default" style="display: block;" >N/A</span></div> 
                                <% }else if(cList.get(i).getDis_condition().equalsIgnoreCase("Recovered")){ %>
                                <div><span class="label label-success" style="display: block;" >Recovered</span></div>
                                <% }else if(cList.get(i).getDis_condition().equalsIgnoreCase("Improved")){ %>
                                <div><span class="label label-info" style="display: block;" >Improved</span></div>
                                <% }else if(cList.get(i).getDis_condition().equalsIgnoreCase("No Improvement")){ %>
                                <div><span class="label label-primary" style="display: block;" >No Improvement</span></div>
                                <% }else if(cList.get(i).getDis_condition().equalsIgnoreCase("Worsened")){ %>
                                <div><span class="label label-warning" style="display: block;" >Worsened</span></div>
                                <% }else if(cList.get(i).getDis_condition().equalsIgnoreCase("Died")){ %>
                                <div><span class="label label-danger" style="display: block;" >Died</span></div>
                                <% } %>
                            
                            </td>
                            <!--ADDED BY-->
<!--                            <td class="hidden-xs hidden-sm hidden-md hidden-lg"><%=addedBy %></td>-->
                            <!--ACKNOWLEDGED BY-->
<!--                            <td class="hidden-xs hidden-sm hidden-md hidden-lg"><%=diagnosedBy%></td>-->
                             <!--STATUS-->
                            <td><span class="text-nowrap">
                                <% if(cList.get(i).getAcknowledged_by() != 0 ){  //If GENERAL and HAS Acknowledged_by
                                %> <div><span class="label label-success" style="display: block;">Completed</span></div>
                                <%
                                }
                                if(!(cList.get(i).getAcknowledged_by() != 0)){ //Pag wala pang diagnosis
                                   %> <div> <span class="label label-warning" style="display: block;">Pending ACK</span> </div><p/>

                                <% } %>
                                    </span>
                            </td>
                            <td style="text-align:center;">
                                <span class="text-nowrap">
                                <div class="btn-group alignleft">
                                    <div class="btn-group" style="white-space: nowrap;">
                                      
                                      <button type="button" class="btn btn-primary btn-sm dropdown-toggle " data-toggle="dropdown" aria-expanded="true"> Action <span class="caret"></span></button>
                                      
                                      <ul class="dropdown-menu" role="menu">
                                       
                                    <%  
                                        if(userType.equalsIgnoreCase("physician") && cList.get(i).getAcknowledged_by() == 0 ){ //Pag hindi pa acknowledged
                                    %> 
                                        <li>
                                           <button type="submit" class="buttonlink" name="acknowledgeConsultation" value="<%=cList.get(i).getConsultation_id()%>">Acknowledge Consultation</button>
                                        </li>
                                    <% } %>
                                    <%
                                        String tempDis_condition = cList.get(i).getDis_condition();
                                        if(userType.equalsIgnoreCase("physician") && tempDis_condition == null && cList.get(i).getAcknowledged_by() > 0 || userType.equalsIgnoreCase("nurse") && tempDis_condition == null && cList.get(i).getAcknowledged_by() > 0){//Pag wala pang disposition
                                    %>
                                        <li>
                                            <button type="submit" class="buttonlink" name="addDisposition" value="<%=cList.get(i).getConsultation_id()%>">Add disposition</a>
                                        </li>
                                    <%}%>
                                    <!--Pag acknowledged na and added disposition -->
                                   <% if(cList.get(i).getAcknowledged_by() > 0 && cList.get(i).getDis_condition() != null) { 
                                    %> 
                                        <li>
                                               No actions available
                                        </li>
                                    <% } %>
                                      </ul>
                                    </div>
                                    <%//if(tempDis_condition == null && tempDis_condition.isEmpty()){%>
                                    <button type="submit" name="viewConsultation" class="btn btn-info btn-sm" value="<%=cList.get(i).getConsultation_id()%>"></i>View</button>
                                    
                                        
                                     <% if (cList.get(i).getFollow_up_cons_id() > 0){
                                        //dont put any button kasi may laman
                                    }else{ 
                                        //mag lagay ka
                                        if (cList.get(i).getSchcedule_of_next_visit() != null){
                                      %>

                                    <button type="submit" name="addfollowupbtn" value="<%=cList.get(i).getConsultation_id()%>" class="btn btn-success btn-sm"><i class="fa fa-plus"></i> Follow-Up</button>
                                    <input type="hidden" name="row_id<%=i%>" value="<%=cList.get(i).getConsultation_id()%>">
                                    <%}}%>
                                        
                                  </div>         

                                  </div>   
                                </span>
                            </td>


                          </tr>    
                          <% } %>    
                                          

                                        </table>
                                    </div> <!--col-12-->
                                </div> <!--x_content-->
                            </form>
                        </div><!--x_panel-->
                        
                        
                        
                        <!--END PATIENT TABLE-->

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

<script>
$(document).ready(function() {
    $('#datatable-responsive').DataTable();    
    
    $('#datatable-pending').DataTable(); 
} );
</script>
<script>
(function () {
  $('.table table-bordered dt-responsive nowrap').on('shown.bs.dropdown', function (e) {
    var $table = $(this),
        $menu = $(e.target).find('.dropdown-menu'),
        tableOffsetHeight = $table.offset().top + $table.height(),
        menuOffsetHeight = $menu.offset().top + $menu.outerHeight(true);

    if (menuOffsetHeight > tableOffsetHeight)
      $table.css("padding-bottom", menuOffsetHeight - tableOffsetHeight);
  });

  $('.table table-bordered dt-responsive nowrap').on('hide.bs.dropdown', function () {
    $(this).css("padding-bottom", 0);
  })
})();              
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
   
    @media (max-width: 767px) {
    .dropdown-menu {
        position: relative; !important 
    }
}

</style>

</html>
