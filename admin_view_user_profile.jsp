<%@page import="Model.User"%>
<%@page import="DAO.userDAO"%>
<%
    userDAO myDAO = new userDAO();
    
    String userType = (String) session.getAttribute("position");
    if (!userType.equals("admin")){
        response.sendRedirect("access-denied.jsp");
        return;
    }
%>        
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>View User Profile </title>

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
            
            <jsp:include page="/sidebar.jsp" />

            <!--START OF PAGE CONTENT-->
            <div class="right_col edited" role="main">

                <ol class="breadcrumb">
                   <li class="breadcrumb-item" ><a href="home.jsp">Home</a></li>
                    <li class="breadcrumb-item">Forms</li>
                   <li class="breadcrumb-item active">View User Profile</li>
                </ol>   
                    <!-- <div class="row">-->
                    <div class="col-md-12 col-sm-12 col-xs-12">

                        <div class="page-title">
                            <div class="title_left">
                                <h3>View User Profile</h3>
                            </div>

                        </div>
                        <!--page-title-->
                        
                        <% 
                        int tempID = Integer.parseInt(request.getParameter("selectedUser"));
                            int userID = tempID;
                            userDAO uDAO = new userDAO();
                            User currentUser = new User();
                            currentUser = uDAO.retrieveUser(userID);
                        %>

                        <div class="x_panel">
                            <div class="x_title">
                                <!--get information from database!!-->
                                <strong>User Profile</strong> 
                                <!-- Elements-->
                                <button  onClick="window.location='admin_edit_user_profile.jsp?selectedUser=<%= userID%>';" type="button" class="btn btn-xs btn-primary" style="float: right"><i class="fa fa-edit"></i> Edit User Profile</button>
                            </div>
                            <div class="x_content">
                                <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">

                                    <h3> 
                                        <%
                                        out.println(currentUser.getFullname());
                                        %>
                                        
                                        <h5>(<%=currentUser.getUsername()%>)</h5>
                                    </h3>
                                        
                                        <div class="col-md-12 form-control-label">
                                            <h6> Last Login Date: *DATABASE* February 7, 2017
                                            </h6>
                                        </div>
                                        
                                        <label class="col-md-2 col-form-label">Address:</label>
                                        <div class="col-md-10">
                                            <p class="form-control-static"><%= currentUser.getAddress()%></p>
                                        </div>

                                        <label class="col-md-2 col-form-label">Position:</label>
                                        <div class="col-md-4">
                                            <p class="form-control-static"> <%= currentUser.getPosition()%>
                                            </p>
                                        </div>

                                        <label class="col-md-2 col-form-label">Sex:</label>
                                        <div class="col-md-4">
                                            <p class="form-control-static">
                                            <% String sex = currentUser.getSex();
                                            String M = "M";
                                            String sex1;
                                            if (sex.equals(M) || sex.equals("male")){
                                            sex1 = "Male";}
                                            else{
                                            sex1= "Female";} 
                                            
                                            out.println(sex1); %></p>
                                        </div>

                                        <label class="col-md-2 col-form-label">Phone:</label>
                                        <div class="col-md-4">
                                            <p class="form-control-static"><%= currentUser.getContactNum()%></p>
                                        </div>

                                        <label class="col-md-2 col-form-label">Barangay:</label>
                                        <div class="col-md-4">
                                            <p class="form-control-static"><%= currentUser.getBarangay()%></p>
                                        </div>

                                        <label class="col-md-2 col-form-label">E-mail:</label>
                                        <div class="col-md-4">
                                            <p class="form-control-static"><%= currentUser.getEmailAddress()%></p>
                                        </div>
                                        
                                        <label class="col-md-2 col-form-label">RHU:</label>
                                        <div class="col-md-4">
                                            <p class="form-control-static"><%= currentUser.getRhu()%></p>
                                        </div>


                                </form>

                            </div> <!--x_content-->

                        </div> <!--x_panel-->
                        
                        <div class="x_panel">
                            <div class="x_title">
                                <!--get information from database -->
                                <strong>AUDIT TRAIL</strong> 
                                <!--<button  onClick="window.location='patient_new_consultation.jsp?sex=<%= request.getParameter("sex")%>';" type="button" class="btn btn-xs btn-success" style="float: right"><i class="fa fa-plus"></i> Create New Consultation</button>-->
                            </div>

                            <div class="x_content">
                                <div class="col-md-12">
                                    <table id="datatable-responsive" class="table table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                                      <thead>
                                        <tr>
                                          <th>Login Time</th>
                                          <th>Logout Time</th>
                                        </tr>
                                      </thead>
                                          <td>BLAHBLAH</td>
                                          <td>Dr. Luisa</td>

                                      <tbody>
                                      
                                      </tbody>
                                    </table>
                                </div> <!--col-12-->
                            </div> <!--x_content-->
                        </div> <!--/.x_panel-->

                    </div>
                </div>
        </div>
    </div>


                <!--IMMUNIZATION ADD REMOVE TABLE SCRIPT-->
                <script>
                    $(function() {
                        $('#addTrimester').on('click', function() {
                            var data = $("#tbTrimester tr:eq(1)").clone(true).appendTo("#tbTrimester");
                            data.find("input").val('');
                        });
                        $(document).on('click', '.removeTrimester', function() {
                            var trIndex = $(this).closest("tr").index();
                            if (trIndex > 1) {
                                $(this).closest("tr").remove();
                            } else {
                                alert("Sorry!! Can't remove first row!");
                            }
                        });
                    });
                </script>
                <script>
                    $(function() {
                        $('#addAdultImmunization').on('click', function() {
                            var data = $("#tbAdultImmunization tr:eq(1)").clone(true).appendTo("#tbAdultImmunization");
                            data.find("input").val('');
                        });
                        $(document).on('click', '.removeAdultImmun', function() {
                            var trIndex = $(this).closest("tr").index();
                            if (trIndex > 1) {
                                $(this).closest("tr").remove();
                            } else {
                                alert("Sorry!! Can't remove first row!");
                            }
                        });
                    });
                </script>
                <script type="text/javascript">
                    $(function() {
                        $('#addChildImmunization').on('click', function() {
                            var data = $("#tbChildImmunization tr:eq(1)").clone(true).appendTo("#tbChildImmunization");
                            data.find("input").val('');
                        });
                        $(document).on('click', '.removeChildImmun', function() {
                            var trIndex = $(this).closest("tr").index();
                            if (trIndex > 1) {
                                $(this).closest("tr").remove();
                            } else {
                                alert("Sorry!! Can't remove first row!");
                            }
                        });
                    });
                </script>
                <script type="text/javascript">
                    jQuery(document).ready(function() {
                        jQuery('#openDangerMother').on('click', function(event) {
                            jQuery('#dangerMother').toggle('show');
                        });
                    });
                </script>
                <script type="text/javascript">
                    jQuery(document).ready(function() {
                        jQuery('#openDangerBaby').on('click', function(event) {
                            jQuery('#dangerBaby').toggle('show');
                        });
                    });
                </script>
                <script>
                    jQuery(document).ready(function() {
                        jQuery('#openreferral').on('click', function(event) {
                            jQuery('#referralCard').show();
                        });
                        jQuery('#closereferral').on('click', function(event) {
                            jQuery('#referralCard').hide();
                        });
                        jQuery('#closereferral2').on('click', function(event) {
                            jQuery('#referralCard').hide();
                        });
                    });
                </script>

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