<html>
<!--LIANNE WUZ HERE bch @enzo -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Add New User </title>

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
                    <li class="breadcrumb-item">Forms</li>
                   <li class="breadcrumb-item active"> Add New User</li>
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
                            <h2><span class="fa fa-exclamation-circle"></span> <%=error%></h2>
                          </div>
                         <%}%>
                         
                        <!--banner-->
                        
                        
                        
                        
            <div class="page-title">
                <div class="title_left">
                    <h3><i class="fa fa-user-plus"></i> Add New User</h3>
                </div>

            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <strong>New User</strong> 
                        </div>



                        <div class="x_content">
                            <form action="AddUser" method="post" data-parsley-validate> 

                                <div class="form-group row">
                                    <div id="error"></div>
                                    <%
                                    String usernameErrorMsd=(String)request.getAttribute("usernametaken");  
                                    if(usernameErrorMsd!=null)
                                    out.println("<font color=red size=2px>"+usernameErrorMsd+"</font>");
                                    %>
                                    <label class="col-md-3 form-control-label" for="username">Username *</label>
                                    <div class="col-md-3">
                                        <input type="text" id="username" name="username" class="form-control" placeholder="e.g. nurse1" required="required">
                                        <span class="help-block">Username</span>
                                    </div>
                                </div>
                                <br>
                                
                                

                                <div class="item form-group row ">
                                    <label class="col-md-3 form-control-label " for="password">Password *</label>
                                    <div class="col-md-3">
                                        <input type="password" id="password" name="password" class="form-control form-control-success" placeholder="Password" required="required">
                                        <span class="help-block">Please enter a complex password</span>
                                    </div>
                                    
                                </div>
                                <div class="item form-group row">
                                    <label class="col-md-3 form-control-label" for="password2"></label>
                                    <div class="col-md-3">
                                        <input type="password" id="password2" name="password2" data-parsley-equalto="#password"  data-parsley-equalto-message="Passwords should match." class="form-control form-control-success" placeholder="Password" required="required">
                                        <span class="help-block">Please re-enter your password</span>
                                    </div>
                                </div>


                                <br>
                             
                                        <div class="form-group row">
                                            <label class="col-md-3 form-control-label">Position *</label>
                                            <div class="col-md-9">
                                                <div class="radio">
                                                    <label for="position1">
                                                    <input type="radio"class="flat" id="position1" name="position" value="Midwife"> Midwife
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label for="position2">
                                                        <input type="radio" class="flat" id="position2" name="position" value="Nurse"> Nurse
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label for="position4">
                                                        <input type="radio" class="flat" id="position4" name="position" value="Physician"> Doctor/Physician
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label for="position5">
                                                        <input type="radio" class="flat" id="position5" name="position" value="Admin"> Admin
                                                    </label>
                                                </div>
<!--
                                                <div class="radio">
                                                    <label for="position6">
                                                        <input type="radio" class="flat" id="position6" name="position" value="Encoder" required="required"> Encoder
                                                    </label>
                                                </div>
-->
                                            </div>
                                        </div>

                                <br>
                                
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="text-input">Name *</label>
                                    <div class="col-md-3">
                                        <input type="text" id="fname" name="fname" class="form-control" placeholder="e.g. Juan" required="required">
                                        <span class="help-block">First Name</span>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" id="mname" name="mname" class="form-control" placeholder="e.g. Paolo">
                                        <span class="help-block">Middle Name</span>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" id="lname" name="lname" class="form-control" placeholder="e.g. de la Cruz" required="required">
                                        <span class="help-block">Last Name</span>
                                    </div>
                                </div>
                                
                                <br>

                               <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="phone">Phone</label>
                                    <div class="col-md-9 form-group has-feedback">
                                        <input type="number" class="form-control has-feedback-left" id="phone" name="phone" placeholder="Phone/Mobile"  minlength="7" maxlength="11" onkeypress="return isNumberKey(event)" min="0">
                                        <span class="fa fa-phone form-control-feedback left" aria-hidden="true"></span>
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="email">Email Address</label>
                                    <div class="col-md-9 form-group has-feedback">
                                        <input type="email" class="form-control has-feedback-left" id="email" name="email" placeholder="Email" data-parsley-type="email">
                                        <span class="fa fa-envelope form-control-feedback left" aria-hidden="true"></span>
                                    </div>
                                </div>

                                
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="address">Address</label>
                                    <div class="col-md-9">
                                        <input type="text" id="address" name="address" class="form-control form-control has-feedback-left" placeholder="Enter address" required="required">
                                        <span class="fa fa-home form-control-feedback left" aria-hidden="true"></span>
<!--                                        <span class="help-block">Please enter your address</span>-->
                                    </div>
                                </div>
                                
                                <br>
                                
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label" for="select">RHU</label>
                                    <div class="col-md-9">
                                    <select id="rhu" name="rhu" readonly ="readonly" class="form-control">
                                        <option value="1">RHU 1</option>
                                    </select>
                                        <span class="help-block">Please select your RHU</span>
                                    </div>
                                </div>
                                
                                <br>
                                
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
                                            <input type="radio" class="flat" id="sex1" name="sex" value="male" required="required"> Male
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label for="sex2">
                                                <input type="radio" class="flat" id="sex2" name="sex" value="female"> Female
                                            </label>
                                        </div>

                                    </div>
                                </div>

                            <footer>
                                <div class="form-group" align="center">
                                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                        <button class="btn btn-default" type="button">Cancel</button>

                                        <!--              <button class="btn btn-primary" type="reset">Reset</button>-->
                                        <button type="submit" class="btn btn-success" id="submitForm">Submit</button>
                                    </div>
                                </div>
                            </footer>
                                
                            </form>
                        </div>

                    </div>

                </div>



            </div>
            <!--/.row-->
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

            



        </div>
            </div>
    </div>
</div>
    </body>
    
    <script>
    $('form').parsley().options.requiredMessage = "This field is required.";
    $('form').parsley().options.equaltoMessage = "Passwords should match.";
    function isNumberKey(evt){
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
    
    </script>
    
</html>