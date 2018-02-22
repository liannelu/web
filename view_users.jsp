<%@page import="Model.User"%>
<%@page import="DAO.userDAO"%>
<%@page import="java.util.ArrayList"%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> View Users </title>

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
            int user_id = (Integer) session.getAttribute("user_id");
            
            //ACCESS CONTROL
            if (!userType.equalsIgnoreCase("root") && !userType.equalsIgnoreCase("admin")){
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
                   <li class="breadcrumb-item active">View Users</li>
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
                                <h3><i class="fa fa-users"></i> View Users</h3>        
                            </div>

                        </div>
                        <!--page-title-->
                        
                        <div class="x_panel">
                            <div class="x_title">
                                <h4><i class="fa fa-book"></i>
                                <!--get information from database!!-->
                                <strong> User Records </strong> 
                                <!-- Elements-->
                                <button  onClick="window.location='addUser.jsp';" type="submit" class="btn btn-sm btn-primary" style="float: right"><i class="fa fa-user"></i> Add New User </button>
                                </h4>
                                
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="col-md-12">
                                    <form action="UserProfile" method="post">
                                        
                                    <table id="datatable-responsive" class="table table-bordered table-condensed dt-responsive" cellspacing="0" width="100%">
                                      <thead>
                                        <tr>
                                          <th width="">Name of User</th>
                                          <th width="1%">Position</th>
                                          <th width="">Address </th>
                                          <th width="1%">Barangay</th>
                                          <th width="1%">RHU</th>
                                          <th width="1%">Sex</th>
                                            <th width="1%"><span class="text-nowrap">Status</span></th>
                                          <th width="">Action</th>
                                        </tr>
                                      </thead>
                                      
                                            <%
                                                userDAO uDAO = new userDAO();
                                                ArrayList <User> users  = new ArrayList();
                                                users = uDAO.retrieveAllUsers();

                                                for(int i = 0; i<users.size(); i++) {
                                                int selectedUser = users.get(i).getUser_id();
                                            %>
                                          <tr>
                                              <td><%=users.get(i).getFullname()%></td>
                                              <td><%=users.get(i).getPosition()%></td>
                                              <td><%=users.get(i).getAddress()%></td>
                                              <td><%=users.get(i).getBarangay()%></td>
                                              <td><%=users.get(i).getRhu()%></td>
                                              <td><%=users.get(i).getSex()%></td>
                                              <td><%
                                                  if(users.get(i).getActive() == 1){%>
                                                      <span class="label label-success" style="display: block;"> Active </span> 
                                                  <%}else{%>
                                                       <span class="label label-danger" style="display: block;"> Inactive </span> 
                                                   <% }%>
                                                  
                                                    </td>
                                                    
                                               <td style="text-align:center; width:;"> 
                                                    <div class="btn-group ">
                                                    
                                                     <button type="submit" name="viewbtn1" value="viewbtn1<%=i%>" id="viewuser" class="btn btn-info btn-sm"><i class="fa fa-eye"></i>View</button>

                                                      <button type="submit" name="editbtn1" value="editbtn1<%=i%>" id="edituser" class="btn btn-warning btn-sm"><i class="fa fa-edit"></i>Edit</button>
                                                      
                                                      <input type="hidden" name="row_id1<%=i%>" value="<%=users.get(i).getUser_id()%>">

                                                      <%
                                                      if(users.get(i).getActive() == 1){%>
                                                          <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target=".areyousure-modal-sm<%=i%>" ><i class="fa fa-remove"></i> Deactivate</button> 
                                                      <%}else{%>
                                                           <button type="submit" class="btn btn-success btn-sm" name="activateDeactivateButton" value="<%=users.get(i).getUser_id()%>"><i class="fa fa-plus"></i> Activate</button> 
                                                       <% }%>
                                                    </div>
                                                    
                <!--ARE YOU SURE MODAL-->
                <div class="modal fade areyousure-modal-sm<%=i%> in" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-close"></i>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2"><i class="fa fa-times-circle" style="color: red;"></i> Deactivate? &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
                        </div>
                        <div class="modal-body">
                          <p>Are you sure you want to deactivate &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                          <p> user?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                          <button type="submit" class="btn btn-success" name="activateDeactivateButton" value="<%=users.get(i).getUser_id()%>">Confirm</button>
                        </div>

                      </div>
                    </div>
                  </div><!--/MODAl-->
                                            </td>
                                          </tr>
                                          <%}%>
                                      <tbody>
                                      </tbody>
                                      
                                    </table>
                                    </form>
                                </div> <!--col-12-->
                            </div> <!--x_content-->

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

</html>