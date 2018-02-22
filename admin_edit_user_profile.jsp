<%@page import="Model.User"%>
<%@page import="DAO.userDAO"%>
<%
    userDAO myDAO = new userDAO();
    
    String userType = (String) session.getAttribute("position");
    if (!userType.equals("admin")){
        response.sendRedirect("access-denied.jsp");
        return;
    }
    
    int tempID = Integer.parseInt(request.getParameter("selectedUser"));
    int userID = tempID;
    userDAO uDAO = new userDAO();
    User currentUser = new User();
    currentUser = uDAO.retrieveUser(userID);
%>

<html>
<!--LIANNE WUZ HERE bch @enzo -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Edit User Profile </title>

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

<body class="nav-md footer_fixed">
<div class="container body">
    <div class="main_container">

        <jsp:include page="/sidebar.jsp" />
        
        <!--START OF PAGE CONTENT-->
            <div class="right_col edited" role="main">
                <ol class="breadcrumb">
                   <li class="breadcrumb-item" ><a href="home.jsp">  Home </a></li>
                    <li class="breadcrumb-item">Forms</li>
                   <li class="breadcrumb-item active"> Edit User</li>
                </ol>   
                    <!-- <div class="row">-->
        <div class="col-md-12 col-sm-12 col-xs-12">

            <div class="page-title">
                <div class="title_left">
                    <h3><i class="fa fa-edit"></i> Edit User</h3>
                </div>

            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <strong>Edit User</strong> <small>&nbsp;&nbsp;&nbsp; Edit User Position</small>
                        </div>
                        
                        <div class="x_content">
                            <h3>
                                <%out.println(currentUser.getFullname());
                                        %>
                            </h3>
                         <div class="" role="tabpanel" data-example-id="togglable-tabs">
                              <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                                <li role="presentation" class="active"><a href="#tab_content1" id="userinformation-tab" role="tab" data-toggle="tab" aria-expanded="true">User Information</a>
                                </li>
                              </ul>
                              <div id="myTabContent" class="tab-content">
                                <!--<div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="userinformation-tab">-->
                                 <form action="EditUserPosition" method="post" data-parsley-validate> 

                                <div class="form-group row">
                                    
                                    <label class="col-md-3 form-control-label" for="username">Username *</label>
                                    <div class="col-md-3">
                                        <input type="text" id="username" name="username" class="form-control" placeholder="eg. nurse1" required="required" value="<%=currentUser.getUsername()%>" disabled>
                                        <span class="help-block">Username</span>
                                    </div>
                                </div>
                                <br>
                                
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label">Position *</label>
                                    <%
                                            String userposition= currentUser.getPosition();
                                            String midwife = "midwife";
                                            String encoder = "encoder";
                                            String nurse = "nurse";
                                            String physician = "physician";
                                            String admin = "admin";
                                    %>
                                    <input type="hidden" name="tempUsername" value="<%=currentUser.getUsername()%>">
                                    <div class="col-md-9">
                                        <div class="radio">
                                            <label for="position1">
                                        <% if(userposition.equals(midwife)){%>
                                            <input type="radio"class="flat" id="position1" name="position" value="midwife" checked>
                                        <%}else{ %> 
                                            <input type="radio"class="flat" id="position1" name="position" value="midwife">
                                        <% }%>
                                            Midwife
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="position2">
                                        <% if(userposition.equals(nurse)){%>
                                            <input type="radio" class="flat" id="position2" name="position" value="nurse" checked> 
                                        <%}else{ %>
                                            <input type="radio" class="flat" id="position2" name="position" value="nurse">  
                                        <% }%>
                                                Nurse
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="position4">
                                        <% if(userposition.equals(physician)){%>
                                            <input type="radio" class="flat" id="position4" name="position" value="physician" checked>
                                        <%}else{ %> 
                                            <input type="radio" class="flat" id="position4" name="position" value="physician">   
                                        <% }%>
                                                Doctor/Physician
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="position5">
                                        <% if(userposition.equals(admin)){%>
                                            <input type="radio" class="flat" id="position5" name="position" value="admin" checked>
                                        <%}else{ %> 
                                            <input type="radio" class="flat" id="position5" name="position" value="admin">   
                                        <% }%>
                                         Admin
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="position6">
                                        <% if(userposition.equals(encoder)){%>
                                            <input type="radio" class="flat" id="position6" name="position" value="encoder" checked> 
                                        <%}else{ %> 
                                            <input type="radio" class="flat" id="position6" name="position" value="encoder">  
                                        <% }%>
                                            Encoder
                                            </label>
                                        </div>
                                    </div>
                                </div>
                               
                            <footer>
                                <div class="form-group" align="center">
                                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                        <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                        <!--              <button class="btn btn-primary" type="reset">Reset</button>-->
                                        <button type="submit" class="btn btn-primary" id="submitForm">Update</button>
                                    </div>
                                </div>
                            </footer>
                                
                            </form> <!--edit user form-->
                            <!--</div>-->      <!--userinformation-tab-->
                        <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="password-tab">
                        
                                
                          </div> <!--myTabContent-->
                        </div><!--tabpanel-->

                    </div><!--x_content-->
                </div><!--/x_panel-->

                </div><!--col-md-12-->



            </div><!--/.row-->
            
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

            



        </div><!--<div class="col-md-12 col-sm-12 col-xs-12">-->
            </div><!--right_col edited-->
    </div><!--main_container-->
</div> <!--container body-->
    </body>
    
    <script>
    $('form').parsley().options.requiredMessage = "This field is required.";
    $('form').parsley().options.equaltoMessage = "Passwords should match.";
    </script>
    <script>
        function isNumberKey(evt){
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
    </script>
    
  
</html>