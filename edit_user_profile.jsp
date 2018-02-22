<%@page import="Model.User"%>
<%@page import="DAO.userDAO"%>

<%
    int userID = (Integer) session.getAttribute("uid");
    userDAO uDAO = new userDAO();
    User currentUser = new User();
    currentUser = uDAO.retrieveUser(userID);
    
    int rhu = (Integer) currentUser.getRhu();
    String sex = (String) currentUser.getSex();
    
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

        <%
           String userType = (String) session.getAttribute("position");
            
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
                            <strong>Edit User</strong> <small>&nbsp;&nbsp;&nbsp;User information or Password</small>
                        </div>
                        
                        <div class="x_content">
                         <div class="" role="tabpanel" data-example-id="togglable-tabs">
                              <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                                <li role="presentation" class="active"><a href="#tab_content1" id="userinformation-tab" role="tab" data-toggle="tab" aria-expanded="true">User Information</a>
                                </li>
                                <li role="presentation" class=""><a href="#tab_content2" role="tab" id="password-tab" data-toggle="tab" aria-expanded="false">Password</a>
                                </li>
                              </ul>
                              <div id="myTabContent" class="tab-content">
                                <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="userinformation-tab">
                                 <form action="EditUser" method="post" data-parsley-validate> 

                                <div class="form-group row">
                                    
                                    <label class="col-md-3 form-control-label" for="username">Username *</label>
                                    <div class="col-md-3">
                                        <input type="text" id="username" name="username" class="form-control" placeholder="e.g. nurse1" required="required" value="<%= currentUser.getUsername() %>" disabled>
                                        <span class="help-block">Username</span>
                                    </div>
                                </div>
                                <br>
                                
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label">Position *</label>
                                    <%
                                            String userposition= currentUser.getPosition();
                                            String midwife = "Midwife";
                                            String encoder = "Encoder";
                                            String nurse = "Nurse";
                                            String physician = "Physician";
                                            String admin = "Admin";
                                    %>
                                    <div class="col-md-9">
                                        <div class="radio">
                                            <label for="position1">
                                        <% if(userposition.equalsIgnoreCase(midwife)){%>
                                            <input type="radio"class="flat" id="position1" name="position" value="Midwife" checked>
                                        <%}else{ %> 
                                            <input type="radio"class="flat" id="position1" name="position" value="Midwife">
                                        <% }%>
                                            Midwife
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="position2">
                                        <% if(userposition.equalsIgnoreCase(nurse)){%>
                                            <input type="radio" class="flat" id="position2" name="position" value="Nurse" checked> 
                                        <%}else{ %>
                                            <input type="radio" class="flat" id="position2" name="position" value="Nurse">  
                                        <% }%>
                                                Nurse
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="position4">
                                        <% if(userposition.equalsIgnoreCase(physician)){%>
                                            <input type="radio" class="flat" id="position4" name="position" value="Physician" checked>
                                        <%}else{ %> 
                                            <input type="radio" class="flat" id="position4" name="position" value="Physician">   
                                        <% }%>
                                                Doctor/Physician
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="position5">
                                        <% if(userposition.equalsIgnoreCase(admin)){%>
                                            <input type="radio" class="flat" id="position5" name="position" value="Admin" checked>
                                        <%}else{ %> 
                                            <input type="radio" class="flat" id="position5" name="position" value="Admin">   
                                        <% }%>
                                         Admin
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="position6">
                                        <% if(userposition.equalsIgnoreCase(encoder)){%>
                                            <input type="radio" class="flat" id="position6" name="position" value="Encoder" checked> 
                                        <%}else{ %> 
                                            <input type="radio" class="flat" id="position6" name="position" value="Encoder">  
                                        <% }%>
                                            Encoder
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <br>
                                
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="text-input">Name *</label>
                                    <div class="col-md-3">
                                        <input type="text" id="fname" name="fname" class="form-control" placeholder="e.g. Juan" required="required" value="<%= currentUser.getFirstname() %>">
                                        <span class="help-block">First Name</span>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" id="mname" name="mname" class="form-control" placeholder="e.g. Paolo" value="<%= currentUser.getMiddlename() %>">
                                        <span class="help-block">Middle Name</span>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" id="lname" name="lname" class="form-control" placeholder="e.g. de la Cruz" required="required" value="<%= currentUser.getLastname() %>">
                                        <span class="help-block">Last Name</span>
                                    </div>
                                </div>
                                <br>

                               <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="phone">Phone</label>
                                    <div class="col-md-9 form-group has-feedback">
                                        <input type="number" class="form-control has-feedback-left" id="phone" name="phone" placeholder="Phone" maxlength="11" value="<%= currentUser.getContactNum() %>" onkeypress="return isNumberKey(event)">
                                        <span class="fa fa-phone form-control-feedback left" aria-hidden="true"></span>
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="email">Email Address</label>
                                    <div class="col-md-9 form-group has-feedback">
                                        <input type="text" class="form-control has-feedback-left" id="email" name="email" placeholder="Email" value="<%= currentUser.getEmailAddress() %>">
                                        <span class="fa fa-envelope form-control-feedback left" aria-hidden="true"></span>
                                    </div>
                                </div>

                                
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="address">Address</label>
                                    <div class="col-md-9">
                                        <input type="text" id="address" name="address" class="form-control form-control has-feedback-left" placeholder="Enter address" required="required" value="<%= currentUser.getAddress() %>">
                                        <span class="fa fa-home form-control-feedback left" aria-hidden="true"></span>
<!--                                        <span class="help-block">Please enter your address</span>-->
                                    </div>
                                </div>
                                
                                <br>
                                <!-- ********************************WOOOO CHECK THIS AFTER EDITING ****************-->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="select">RHU</label>
                                    <div class="col-md-9">
                                    <select id="rhu" name="rhu" class="form-control">
                                        <%if(rhu==1){    
                                        %><option value="1" selected="selected">RHU 1</option> <%
                                        }else{
                                        %>
                                        <option value="1">RHU 1</option>
                                        <%}%>
                                        
                                        <%if(rhu==2){
                                    
                                        %><option value="2" selected="selected">RHU 2</option> <%
                                        }else{
                                        %>
                                        <option value="2">RHU 2</option>
                                        <%}%>
                                        
                                        <%if(rhu==3){   
                                        
                                        %><option value="3" selected="selected">RHU 3</option> <%
                                        }else{
                                        %>
                                        <option value="3">RHU 3</option>
                                        <%}%>
                                        
                                        <%if(rhu==4){    
                                        %><option value="4" selected="selected">RHU 4</option> <%
                                        }else{
                                        %>
                                        <option value="4">RHU 4</option>
                                        <%}%>
                                        
                                        <%if(rhu==5){
                                        %><option value="5" selected="selected">RHU 5</option> <%
                                        }else{
                                        %>
                                        <option value="5">RHU 5</option>
                                        <%}%>
                                        
                                    </select>
                                        <span class="help-block">Please select your RHU</span>
                                    </div>
                                </div>
                                
                                <br>
                                
<!-- ********************************WOOOO CHECK THIS AFTER EDITING ****************-->
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="select">Barangay</label>
                                    <div class="col-md-9">
                                    <select id="barangay" name="barangay" class="form-control">
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
                                        <span class="help-block">Please select your barangay</span>
                                    </div>
                                </div>

                                <br>

                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label">Sex</label>
                                    <div class="col-md-9">
                                        <div class="radio">
                                            <label for="sex1">
                                        <% if(sex.equalsIgnoreCase("male") || sex.equalsIgnoreCase("M")){%>
                                            <input type="radio" class="flat" id="sex1" name="sex" value="Male" checked> 
                                        <%}else{ %> 
                                            <input type="radio" class="flat" id="sex1" name="sex" value="Male">
                                        <% }%>
                                            Male
                                            </label>
                                        </div>
                                        
                                        <div class="radio">
                                            <label for="sex2">
                                        <% if(sex.equalsIgnoreCase("female") || sex.equalsIgnoreCase("F")){%>
                                            <input type="radio" class="flat" id="sex2" name="sex" value="Female" checked> 
                                        <%}else{ %> 
                                            <input type="radio" class="flat" id="sex2" name="sex" value="Female"> 
                                        <% }%>
                                            Female
                                            </label>
                                        </div>

                                    </div>
                                </div>

                            <footer>
                                <div class="form-group" align="center">
                                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                        <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                        <!--              <button class="btn btn-primary" type="reset">Reset</button>-->
                                        <button type="submit" class="btn btn-primary" id="submitForm">Update Profile</button>
                                    </div>
                                </div>
                            </footer>
                                
                            </form> <!--edit user form-->
                            </div><!--userinformation-tab-->
                        <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="password-tab">
                           <form action="EditUserPassword" method="post" data-parsley-validate> 
                            
                            <div class="item form-group row ">
                                    <label class="col-md-3 form-control-label " for="password">Current Password *</label>
                                    <div class="col-md-3">
                                        <input type="password" id="currentpassword" name="currentpassword" class="form-control form-control-success" placeholder="Current Password" required="required">
                                            <div id="error"></div>
                                                <%
                                                String password_error=(String)request.getAttribute("error");  
                                                if(password_error!=null)
                                                out.print("<font color=red size=2px>"+password_error+"</font>");
                                                %>
                                        <span class="help-block">Please enter current password</span>
                                    </div>
                                    
                                </div>
                                <div class="item form-group row ">
                                    <label class="col-md-3 form-control-label " for="password">New Password *</label>
                                    <div class="col-md-3">
                                        <input type="password" id="newpassword" name="newpassword" class="form-control form-control-success" placeholder="Password" required="required">
                                        <span class="help-block">Please enter a complex password</span>
                                    </div>
                                    
                                </div>
                                <div class="item form-group row has-success">
                                    <label class="col-md-3 form-control-label" for="newpassword2"></label>
                                    <div class="col-md-3">
                                        <input type="password" id="newpassword2" name="newpassword2" data-parsley-equalto="#newpassword" class="form-control form-control-success" placeholder="Password" required="required">
                                        <span class="help-block">Please re-enter password</span>
                                    </div>
                                </div>
                                <footer>
                                    <div class="form-group" align="center">
                                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                            <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                            <!--              <button class="btn btn-primary" type="reset">Reset</button>-->
                                            <button type="submit" class="btn btn-primary" id="submitForm">Update Password</button>
                                        </div>
                                    </div>
                                </footer>
                            </form> <!--edit password form-->
                            </div><!--password-tab-->
                                
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