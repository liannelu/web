<%@page import="Model.Patient"%>
<%@page import="Model.Family_Code"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="java.util.ArrayList"%>

<%
    session.setAttribute("addPatientStep", 1);
    session.setAttribute("isNewFamily", "");
%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> List of Family Number </title>

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
                   <li class="breadcrumb-item active">Family Number</li>
                </ol>   
                    <!-- <div class="row">-->
                    <div class="col-md-12 col-sm-12 col-xs-12">

                       <%
                            String error=(String)request.getAttribute("error");  
                            if(error!=null){
                         %> 
                            <div class="alert alert-danger alert-dismissible fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><i class="fa fa-close"></i>
                            </button>
                            <%=error%>
                          </div>
                         <%}%>
                         <%
                            String success=(String)request.getAttribute("success");  
                            if(success!=null){
                         %>
                           <div class="alert alert-success alert-dismissible fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><i class="fa fa-close"></i>
                            </button>
                            <%=success%>
                          </div>
                          <%}%><!--banner-->
                         
                        <div class="page-title">
                            <div class="title_left">
                                <h3><i class="fa fa-users"></i> View Family Number</h3>        
                            </div>

                        </div>
                        <!--page-title-->
                        
                       <!-- FAMILY NUMBER TABLE-->
                        <div class="x_panel">
                            <form action="AddFamilyCode" method="post">
                            <div class="x_title">
                                <i class="fa fa-book"></i>
                                <!--get information from database!!-->
                                <strong> Family Number </strong> 
                                <!-- Elements-->
                                
                               <button type="submit" class="btn btn-sm btn-primary" style="float: right" name="selectSerial" value="0"><i class="fa fa-user"></i> Register with new Family Number</button>
                               
                               <clearfix></clearfix>
                            <p/>
                            </div>
                            
                                <div class="x_content">
                                    <div class="col-md-12">
                                        <table id="datatable-responsive" class="table table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                                          <thead>
                                            <tr>
                                              <th>Family Number </th>
                                              <th>Family Name</th>
                                              <th>First Registered Family Member</th>
                                              <th>Action</th>
                                            </tr>
                                          </thead>
                                          <%
                                              nurseDAO nurseDAO = new nurseDAO();
                                              ArrayList <Family_Code> fcList  = new ArrayList();
                                              fcList = nurseDAO.retrieveAllFamilyCode();

                                              for(int i = 0; i<fcList.size(); i++) {
                                              //int selectedPatient = patients.get(i).getPatient_id();
                                          %>
                                          <tr>
                                            <td><%=fcList.get(i).getFamilyCode() %></a></td>
                                            <td><%=fcList.get(i).getFamilyName() %></td>
                                            <td><%=fcList.get(i).getFirstMember() %></td>
                                            
                                        <td style="text-align:center; width:300px;">  
                                        <div class="btn-group">
                                           
                                            <button type="button" name="selectSerial" class="btn btn-info btn-sm" data-toggle="modal" data-target=".fammembers-modal<%=i%>" value="<%=fcList.get(i).getFamilyCode() %>"><i class="fa fa-eye"></i> View Members</button>
                                            <button type="submit" name="selectSerial" class="btn btn-primary btn-sm" value="<%=fcList.get(i).getFamilyCode()%>"></i>Select Family Number</button>
                                            
                                        </div>
                                        </td>
                                          </tr>   
                                          <% } %>    
                                          <tbody>

                                          </tbody>
                                        </table>
                                    </div> <!--col-12-->
                                </div> <!--x_content-->
                            </form>
                        </div><!--x_panel-->
                        <!--END PATIENT TABLE-->
                        
            <!--FAMILY MEMBERS MODAL-->  
            <form action="PatientProfile" method="post">      
            <%
                 for(int i = 0; i<fcList.size(); i++) {
             %>
            <div class="modal fade fammembers-modal<%=i%>" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><i class="fa fa-close"></i>
                          </button>
                          <strong class="modal-title" id="myModalLabel">Family Members</strong>
                        </div>
                        <div class="modal-body">
                        
            <div class="x_panel">
                    <div class="x_content">
                  
                   <!--TABLE FAMILY MEMBERS-->
                    <div class="col-md-12">
                    <table id="datatable-responsive" class="table table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                      <thead>
                        <tr>
                         <th>Patient ID</th>
                          <th>Patient Name</th>
                          <th>Age</th>
                          <th>Gender</th>
                          <th>Barangay</th>
                          <th>BHC</th>
                          <th>Date of Registration</th>
                          <th>Status</th>
                          <th>Action</th>
                        </tr>
                      </thead>
                      <%
                          nurseDAO nDAO = new nurseDAO();
                          ArrayList <Patient> memberList  = new ArrayList();
                          memberList = nDAO.getFamilyMembers(fcList.get(i).getFamilyCode());

                          for(int j = 0; j<memberList.size(); j++) {
                      %>
                      <tr>
                       <td><%=memberList.get(j).getPatient_id()%></td>
                        <td><%=memberList.get(j).getFullname() %></a></td>
                        <td><%=memberList.get(j).getAge() %></td>
                        <td><%=memberList.get(j).getSex() %></td>
                        <td><%=memberList.get(j).getBarangay() %></td>
                        <td><%=memberList.get(j).getBHC() %></td>
                        <td><%=memberList.get(j).getDate_added() %></td>
                        <!--STATUS-->
                          <td>
                            <% if(memberList.get(j).getStatus().equalsIgnoreCase("Alive")){ %> 
                            <div><span class="label label-success" style="display: block;" >Alive</span></div>

                            <%
                            }
                            if(memberList.get(j).getStatus().equalsIgnoreCase("Dead")){ %> <div> <span class="label label-danger" style="display: block;">Dead</span> </div><p/>

                            <% }
                             if (memberList.get(j).getStatus().equalsIgnoreCase("Pregnant")){ //Pag wala pang diagnosis
                            %> <div> <span class="label label-info" style="display: block;">Pregnant</span> </div><p/>

                            <% } %>

                          </td>
                        <td style="text-align:left; width:130px;"> 
                            <div class="btn-group ">
                              <button  type="submit" name="viewbtn" value="<%=memberList.get(j).getPatient_id()%>" class="btn btn-info btn-sm"><i class="fa fa-eye"></i>View</button>
                              
                            <%
                            if(!(memberList.get(j).getStatus().equalsIgnoreCase("Dead"))){ %>
                              <button type="submit" name="editbtn" value="<%=memberList.get(j).getPatient_id()%>" id="edituser" class="btn btn-warning btn-sm"><i class="fa fa-edit"></i>Edit</button>
                            <% } %>

                            </div>
                        </td>
                      </tr>   
                      
                       
                      <% } %>    
                      <tbody>

                      </tbody>
                    </table>
                </div> <!--col-12-->

                    </div><!--x_content-->
                </div>
                            
                       </div>
                        <!--modal-body-->
                        
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>

                      </div>
                    </div>
                  </div>
                <%}%><!-- END OF FOR LOOP-->
            </form>
            <!--END OF FAMILY MEMBERS MODAL-->
           

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