<%
    if((Integer)session.getAttribute("addPatientStep") != 2 ){
        response.sendRedirect("view_family_codes.jsp");
    }
    
    int family_serial = (Integer) session.getAttribute("familySerial");

    
    //isNewFamily

%>
    <html>
    
        
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Patient Enrollment Record </title>

        <!-- Bootstrap -->
        <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <!-- NProgress -->
        <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
        <!-- iCheck -->
        <link href="vendors/iCheck/skins/flat/green.css" rel="stylesheet">
        <!-- prettyCheckbox -->
        <link href="vendors/pretty-checkbox/src/pretty.min.css" rel="stylesheet">
        <!-- bootstrap-daterangepicker -->
        <link href="vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
        <!-- bootstrap-datetimepicker -->
        <link href="vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">
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
        <!-- time Picker -->
        <link rel="stylesheet" href="vendors/timepicker/bootstrap-timepicker.min.css">

        <!-- Custom Theme Style -->
        <link href="source/css/custom.min.css" rel="stylesheet">
        
        

    </head>

    <body class="nav-md footer_fixed">

        <!-- PIN-->

        <div class="container body">
            <form action="AddPatient" method="post" data-parsley-validate>
                <!-- form for java servlet -->
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
                        <!-- <div class="row">-->
                        <div class="col-md-12 col-sm-12 col-xs-12">

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
                                <li class="breadcrumb-item"> Forms</li>
                                <li class="breadcrumb-item active">Patient Enrollment Record </li>
                            </ol>

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
                           
                            <!--                     x_panel-inverse x_panel-info text-xs-center-->
                            <div class="x_panel">
                                <div class="col-md-12">

                                    <div class="x_content">
                                        <center>
                                            <h3>
                                                <strong>PATIENT ENROLLMENT RECORD <br>
                                                </strong><br> New Patient
                                            </h3>
                                        </center>
                                    </div>
                                </div>
                            </div>

                            <div class="row">

                                <div class="col-md-12">
                                    <div class="x_panel">
                                        <div class="x_title">
                                            <h2> <strong>Personal Information</strong> </h2>
                                            <div class="clearfix"></div>
                                        </div>

                                        <div class="x_content">
                                                <div class="form-group row">
                                                    <label class="col-md-3 form-control-label" for="text-input">Name</label>
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


                                                <div class="form-group row">
                                                    <label class="col-md-3 form-control-label" for="prefix"></label>
<!--
                                                    <div class="col-md-3">
                                                        <select id="prefix" name="select" class="form-control">
                                                            <option value="0">N/A</option>
                                                            <option value="1">Mr</option>
                                                            <option value="2">Ms</option>
                                                            <option value="3">Mrs</option>
                                                            <option value="4">Attorney</option>
                                                            <option value="5">Doctor</option>
                                                            <option value="6">Engineer</option>
                                                        </select>
                                                        <span class="help-block">Prefix</span>
                                                    </div>
-->
                                                    <label class="form-control-label" for="suffix"></label>
                                                    <div class="col-md-3">
                                                        <select id="suffix" name="suffix" class="form-control">
                                                            <option value="">N/A</option>
                                                            <option value="Jr.">Jr.</option>
                                                            <option value="Sr.">Sr.</option>
                                                            <option value="I">I</option>
                                                            <option value="II">II</option>
                                                            <option value="III">III</option>
                                                            <option value="IV">IV</option>
                                                            <option value="V">V</option>
                                                        </select>
                                                        <span class="help-block">Suffix</span>
                                                    </div>

                                                </div>
                                                
                                                
                                                
                                                
                                                

                                            <div class="form-group row">
                                                <label class="col-md-3 form-control-label" for="mothername">Mother's Name</label>
                                                <div class="col-md-3">
                                                    <input type="text" id="mfname" name="mothernamef" class="form-control" placeholder="e.g. Maria" required="required">
                                                    <span class="help-block">First Name</span>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" id="mmname" name="mothernamem" class="form-control" placeholder="e.g. Josefina" required="required">
                                                    <span class="help-block">Middle Name</span>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="text" id="mlname" name="mothernamel" class="form-control" placeholder="e.g. de la Cruz" required="required">
                                                    <span class="help-block">Maiden Name</span>
                                                </div>
                                            </div>
                                                

                                                <div class="form-group row">
                                                    <label class="col-md-3 form-control-label" for="email">Email Address</label>
                                                    <div class="col-md-3">
                                                        <input type="email" id="email" name="email" class="form-control" placeholder="juan@email.com">
                                                        <span class="help-block">Please enter your email address</span>
                                                    </div>
                                                </div>

                                                <div class="form-group row">
                                                    <label class="col-md-3 form-control-label" for="birthday">Birth Date</label>

                                                    <div class='col-sm-3'>

                                                        <div class="form-group">
                                                            <div class='input-group date' >
                                                                <input type='text' class="form-control" id="birthday" name="birthday" required="required" />
                                                                <span class="input-group-addon info">
                                                                    <span class="fa fa-calendar-o "></span>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <span for="birthday" class="help-block">Year/Month/Day</span>
                                                    </div>
                                                    <br>
                                                    <!--                                    myDatepicker2-->


                                                </div>
                                                
                                                


                                                <div class="form-group row">
                                                    <label class="col-md-3 form-control-label" for="birthplace" required="required">Birthplace</label>
                                                    <div class="col-md-9">
                                                        <input type="text" id="birthplace" name="birthplace" class="form-control" placeholder="Birthplace">
                                                        <span class="help-block"></span>
                                                    </div>
                                                </div>

                                                <br>


                                                <div class="x_panel">
                                                    <!--                <div class="x_title"> x_panel title</div>-->
                                                    <div class="x_content">
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label">Gender</label>
                                                            <div class="col-md-9">

                                                                <div class="radio">
                                                                    <label for="male">
                                                                        <input type="radio" class=""  id="male" name="sex" value="Male" required="required"> Male
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="female">
                                                                        <input type="radio" class=""  id="female" name="sex" value="Female" > Female
                                                                    </label>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="x_panel">
                                                    <!--                <div class="x_title"> x_panel title</div>-->
                                                    <div class="x_content">
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label">Blood Type</label>
                                                            <div class="col-md-2">
                                                                <div class="radio">
                                                                    <label for="a+">
                                                                        <input required type="radio" class=""  id="a+" name="bloodtype" value="A+"> A+
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="a-">
                                                                        <input type="radio" class=""  id="a-" name="bloodtype" value="A-"> A-
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="b+">
                                                                        <input type="radio" class=""  id="b+" name="bloodtype" value="B+"> B+
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="b-">
                                                                        <input type="radio" class=""  id="b-" name="bloodtype" value="B-"> B-
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <div class="radio">
                                                                    <label for="ab+">
                                                                        <input type="radio" class=""  id="ab+" name="bloodtype" value="AB+"> AB+
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="ab-">
                                                                        <input type="radio" class=""  id="ab-" name="bloodtype" value="AB-"> AB-
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="o+">
                                                                        <input type="radio" class=""  id="o+" name="bloodtype" value="O+"> O+
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="o-">
                                                                        <input type="radio" class=""  id="o-" name="bloodtype" value="O-"> O-
                                                                    </label>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="x_panel">
                                                    <!--                <div class="x_title"> x_panel title</div>-->
                                                    <div class="x_content">
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label">Civil Status</label>
                                                            <div class="col-md-3">
                                                                <div class="radio">
                                                                    <label for="single" id="label_single">
                                                                        <input type="radio" class=""  id="single" name="civilstatus" value="Single"> Single
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="married" id="label_married">
                                                                        <input type="radio" class=""  id="married" name="civilstatus" value="Married"> Married
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="cohabitation" id="label_cohabitation">
                                                                        <input type="radio" class=""  id="cohabitation" name="civilstatus" value="Cohabitation"> Co-habitation
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="radio">
                                                                    <label for="annulled" id="label_annulled">
                                                                        <input type="radio" class=""  id="annulled" name="civilstatus" value="Annulled"> Annulled
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="widow" id="label_widow">
                                                                        <input type="radio" class=""  id="widow" name="civilstatus" value="Widow"> Widow/er
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="separated" id="label_separated">
                                                                        <input type="radio" class=""  id="separated" name="civilstatus" value="Separated" required="required"> Separated
                                                                    </label>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                    <!-- ******************* DO THIS ---------------->
                                                    <div id="married_card" style="display: none;">
                                                        
<!--
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label" for="maiden_name">Maiden Name</label>
                                                            <div class="col-md-3">
                                                                <input type="text" id="maiden_name" name="maiden_name" class="form-control" placeholder="*FOR MARRIED WOMEN ONLY">
                                                                <span class="help-block">Maiden Name</span>
                                                            </div>

                                                        </div>
-->

                                                        <div class="form-group row">
                                                            <br>
                                                            <label class="col-md-3 form-control-label" for="spousename">Spouse's Name</label>
                                                            <div class="col-md-3">
                                                                <input type="text" id="sfname" name="spousenamef" class="form-control" placeholder=". Maria">
                                                                <span class="help-block">First Name</span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <input type="text" id="smname" name="spousenamem" class="form-control" placeholder="e.g. Josefina">
                                                                <span class="help-block">Middle Name</span>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <input type="text" id="slname" name="spousenamel" class="form-control" placeholder="e.g. de la Cruz">
                                                                <span class="help-block">Last Name</span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="x_panel">
                                                    <!--                <div class="x_title"> x_panel title</div>-->
                                                    <div class="x_content">
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label">Educational Attainment</label>
                                                            <div class="col-md-3">
                                                                <div class="radio">
                                                                    <label for="noformal">
                                                                        <input type="radio" class=""  id="noformal" name="educationalattainment" value="No Formal Education"> No Formal Education
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="elementary">
                                                                        <input type="radio" class=""  id="elementary" name="educationalattainment" value="Elementary"> Elementary
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="highschool">
                                                                        <input type="radio" class=""  id="highschool" name="educationalattainment" value="High School"> High School
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="radio">
                                                                    <label for="vocational">
                                                                        <input type="radio" class=""  id="vocational" name="educationalattainment" value="Vocational"> Vocational
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="college">
                                                                        <input type="radio" class=""  id="college" name="educationalattainment" value="College"> College
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="postgraduate">
                                                                        <input type="radio" class=""  id="postgraduate" name="educationalattainment" value="Post Graduate" required="required"> Post Graduate
                                                                    </label>
                                                                </div>

                                                            </div>




                                                        </div>
                                                    </div>
                                                </div>




                                                <div class="x_panel">
                                                    <!--                <div class="x_title"> x_panel title</div>-->
                                                    <div class="x_content">
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label">Employment Status</label>
                                                            <div class="col-md-9">
                                                                <div class="radio">
                                                                    <label for="student">
                                                                        <input type="radio" class=""  id="student" name="employmentstatus" value="Student" required="required"> Student
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="employed">
                                                                        <input type="radio" class=""  id="employed" name="employmentstatus" value="Employed"> Employed
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="employed">
                                                                        <input type="radio" class=""  id="employed" name="employmentstatus" value="Unemployed"> Unemployed
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="retired">
                                                                        <input type="radio" class=""  id="retired" name="employmentstatus" value="Retired"> Retired
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="unknown">
                                                                        <input type="radio" class=""  id="unknownemploy" name="employmentstatus" value="Unknown"> Unknown
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="x_panel">
                                                    <div class="x_content">
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label">Family Member</label>
                                                            <div class="col-md-9">
                                                                <div class="radio">
                                                                    <label for="father">
                                                                        <input type="radio" class=""  id="father" name="familymember" value="Father"> Father
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="son">
                                                                        <input type="radio" class=""  id="son" name="familymember" value="Son" required="required"> Son
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="mother">
                                                                        <input type="radio" class=""  id="mother" name="familymember" value="Mother"> Mother
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="daughter">
                                                                        <input type="radio" class=""  id="daughter" name="familymember" value="Daughter"> Daughter
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="familyother">
                                                                        <input type="radio" class=""  id="familyother" name="familymember" value="other"> Other:
                                                                        <input type="text" id="familyother-input" name="familymembertxt" size="">
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> <!--x_panel-->
                                                
                                                <div class="x_panel">
                                                    <div class="x_content">
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label">Family Medical History</label>
                                                            <div class="col-md-9">
                                                                <!--<div class="col-md-9 col-sm-9 col-xs-12">
                                                                  <div class="checkbox">
                                                                    <label>
                                                                      <input type="checkbox" class="" id="4ps" name="4pmember" value="1"> Asthma
                                                                    </label>
                                                                  </div>
                                                                </div>
                                                                <div class="col-md-9 col-sm-9 col-xs-12">
                                                                  <div class="checkbox">
                                                                    <label>
                                                                      <input type="checkbox" class="" id="4ps" name="4pmember" value="1"> Cancer
                                                                    </label>
                                                                  </div>
                                                                </div>-->
                                                                <div class="col-md-9 col-sm-9 col-xs-12">
                                                                  <div class="checkbox">
                                                                    <label>
                                                                      <input type="checkbox" class="" id="4ps" name="diabetes_history" value="Yes"> Diabetes
                                                                    </label>
                                                                  </div>
                                                                </div>
                                                                <div class="col-md-9 col-sm-9 col-xs-12">
                                                                  <div class="checkbox">
                                                                    <label>
                                                                      <input type="checkbox" class="" id="4ps" name="hypertension_history" value="Yes"> Hypertension
                                                                    </label>
                                                                  </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> <!--x_panel-->

                                        </div> <!--x_content-->
                                    </div>
                                </div> <!--col-md-12-->

                                <div class="col-sm-12 form-control-label">
                                    <div class="x_panel">
                                        <div class="x_title">
                                            <h2><strong>Membership </strong></h2>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="x_content">


                                            <div class="x_panel">
                                                <!--                <div class="x_title"> x_panel title</div>-->
                                                <div class="x_content">
                                                    <div class="form-group row">


                                                        <label class="col-md-3 form-control-label">Family Household Number</label>
                                                        <div class="form-group row">
                                                            
                                                            <label class=" form-control-label" for="purok"></label>
                                                            <div class="col-md-2">
                                                                <input type="number" id="purok" name="purok" class="form-control" placeholder="Purok" min="0" required="required">
                                                            <span class="glyphicon glyphicon-home form-control-feedback right" aria-hidden="true"></span>
                                                                <span class="help-block">Purok</span>
                                                            </div>
                                                            
                                                            
                                                            <label class=" form-control-label" for="family_household_number"></label>
                                                            
                                                            <div class="col-md-3 form-group has-feedback">
                                                                <input type="number" id="family_household_number" name="family_household_number" class="form-control has-feedback" placeholder="000000000-4444-55555" onkeypress="return isNumberKey(event)" min="0" >
                                                                <span class="fa fa-user form-control-feedback right" aria-hidden="true"></span>
                                                                <span class="help-block">Household Number</span>
                                                            </div>
                                                        </div>
                                                                                                                
                                                        


                                                        <!--                                            <label class="control-label col-md-3 col-sm-3 col-xs-3">Custom Mask</label>-->
                                                        <!-- ******* facility number with mask 
                                                        <div class="form-group-row">
                                                            <label class="form-control-label col-md-3 col-sm-3 col-xs-3" for="facilityhouseholdnum">Facility Household Number</label>
                                                            <div class="form-group-row col-md-3 col-sm-12 col-xs-12">
                                                                <input id="facilityhouseholdnum" name="facilityhouseholdnum"
                                                                       type="text" class="form-control"
                                                                       placeholder="000000000-4444-55555"
                                                                       data-inputmask="'mask': '999999999-9999-99999'" required="required">
                                                                                                                <span class="fa fa-user form-control-feedback right" aria-hidden="true"></span>
                                                                <span class="help-block">Facility Household Number</span>
                                                            </div>
                                                        </div>
                                                        -->
                                                        <div class="form-group row col-md-12 "></div>


                                                        <div class="form-group-row">
                                                            <label class="form-control-label col-md-3 col-sm-3 col-xs-3" for="facilityhouseholdnum">Family Number</label>
                                                            <div class="form-group-row col-md-3 col-sm-12 col-xs-12">
<!--
                                                                <input id="familyserial" name="tempfamilyserial" type="text" class="form-control" placeholder="DOH7234-0000000000" data-inputmask="'mask': 'DOH9999-9999999999'" maxlength="18" value="DOH7234-<%=session.getAttribute(" familySerial ") %>" disabled>
                                                                
                                                                <input type="hidden" id="familyserial" name="familyserial" value="=session.getAttribute("familySerial")" maxlength="18">
-->

                                                                <input id="familyserial" name="familyserial" type="text" class="form-control" value="<%=family_serial%>" disabled="disabled">
                                                                <!--                                                <span class="fa fa-user form-control-feedback right" aria-hidden="true"></span>-->
                                                                <span class="help-block">Family Number</span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row col-md-12 "></div>
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                <label class="col-md-3 form-control-label" for="text-input">Facility Code</label>
                                                    <div class="col-md-3">
                                                        <input id="facilitycode" name="facilitycode" 
                                                               type="text" 
                                                               class="form-control" placeholder="DOH7234-0000000000" required="required"   
                                                                 value="DOH7234"
                                                               disabled="disabled"
                                                               >
                                                                                          
                                                        <span class="help-block"><font color="gray">Facility Code</font></span>
                                                    </div>
 
                                                    </div>
                                                </div>

                                            </div>


                                            <div class="x_panel">
                                                <!--                <div class="x_title"> x_panel title</div>-->
                                                <div class="x_content">
                                                    <div class="form-group row">
                                                        <label class="col-md-12 col-sm-12 col-xs-12 control-label">Memberships
                                                          <br>
                                                          <small class="text-navy"></small>
                                                        </label>
                                                        <div class="col-md-3 col-sm-3 col-xs-3"></div>

                                                        
                                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                                          <div class="checkbox">
                                                            <label>
                                                              <input type="checkbox" class="" id="4ps" name="4pmember" value="1"> 4Ps Member
                                                            </label>
                                                          </div>
                                                        </div>
                                                        
                                                         <div class="col-md-3 col-sm-3 col-xs-3"></div>
                                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                                          <div class="checkbox">
                                                            <label>
                                                              <input type="checkbox" class="" id="dhwdyes" name="dswd" value="1"> DSWD NHTS
                                                            </label>
                                                          </div>
                                                        </div>
                                                        
                                                        <label class="col-md-3 form-control-label"></label>
                                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                                          <div class="checkbox">
                                                            <label id="showphilhealthnum">
                                                              <input type="checkbox" class="" id="philhealthmem" name="philhealthmem" value="Yes"> PhilHealth Member
                                                            </label>
                                                          </div>
                                                        </div>
                                                        
                                                        <br/>
                                                        
                                                    </div>
                         
                                                </div>
                                                
                                            </div>


                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                                    <div id="philhealth_card" style="display: none;">

                                                        <div class="x_panel">
                                                            <div class="x_title"> <h5> <strong>PhilHealth Membership</strong></h5>
                                                            </div>
                                                        <div class="clearfix"></div>
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label" for="philhealthno">PhilHealth No. </label>
                                                            <div class="col-md-3">
                                                                <input type="text" id="philhealthno" name="philhealthno" class="form-control" placeholder="00-000000000-1">
                                                                <span class="help-block">PhilHealth No. </span>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <label class="col-md-3 form-control-label">Philhealth Status Type</label>
                                                            <div class="col-md-9">
                                                                <div class="radio">
                                                                    <label for="member">
                                                                        <input type="radio" class=""  id="member" name="statustype" value="Member"> Member
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="dependent">
                                                                        <input type="radio" class=""  id="dependent" name="statustype" value="Dependent"> Dependent
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        <br/><br/>
                                                    <div class="row">
                                                        <label class="control-label col-md-3 col-sm-3 col-xs-12">FOR  PMRF (PhilHealth Membership Registration Form) </label>
                                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                                            <select class="form-control" id="philhealthcat" name="philhealthcat">
                                                                <option   value="FE - ENTERPRISE OWNER">FE - ENTERPRISE OWNER</option>
                                                                <option   value="FE - FAMILY DRIVER">FE - FAMILY DRIVER</option>
                                                                <option   value="FE - GOVT - CASUAL">FE - GOVT - CASUAL</option>
                                                                <option   value="FE - GOVT - CONTRACT/PROJECT BASED">FE - GOVT - CONTRACT/PROJECT BASED</option>
                                                                <option   value="FE - GOVT - PERMANENT REGULAR">FE - GOVT - PERMANENT REGULAR</option>
                                                                <option   value="FE - HOUSEHOLD HELP/KASAMBAHAY">FE - HOUSEHOLD HELP/KASAMBAHAY</option>
                                                                <option   value="FE - PRIVATE - CASUAL">FE - PRIVATE - CASUAL</option>
                                                                <option   value="FE - PRIVATE - CONTRACT/PROJECT BASED">FE - PRIVATE - CONTRACT/PROJECT BASED</option>
                                                                <option   value="FE - PRIVATE - PERMANENT REGULAR">FE - PRIVATE - PERMANENT REGULAR</option>
                                                                <option   value="IE - CITIZEN OF OTHER COUNTRIES WORKING/RESIDING/STUDYING IN THE PHILIPPINES">IE - CITIZEN OF OTHER COUNTRIES WORKING/RESIDING/STUDYING IN THE PHILIPPINES</option>
                                                                <option   value="IE - FILIPINO WITH DUAL CITIZENSHIP">IE - FILIPINO WITH DUAL CITIZENSHIP</option>
                                                                <option   value="IE - INFORMAL SECTOR">IE - INFORMAL SECTOR</option>
                                                                <option   value="IE - MIGRANT WORKER - LAND BASED">IE - MIGRANT WORKER - LAND BASED</option>
                                                                <option   value="IE - MIGRANT WORKER - SEA BASED">IE - MIGRANT WORKER - SEA BASED</option>
                                                                <option   value="IE - NATURALIZED FILIPINO CITIZEN">IE - NATURALIZED FILIPINO CITIZEN</option>
                                                                <option   value="IE - ORGANIZED GROUP">IE - ORGANIZED GROUP</option>
                                                                <option   value="IE - SELF EARNING INDIVIDUAL">IE - SELF EARNING INDIVIDUAL</option>
                                                                <option   value="INDIGENT - NHTS-PR">INDIGENT - NHTS-PR</option>
                                                                <option   value="LIFETIME MEMBER - RETIREE/PENSIONER">LIFETIME MEMBER - RETIREE/PENSIONER</option>
                                                                <option   value="LIFETIME MEMBER - WITH 120 MONTHS CONTRIBUTION AND HAS REACHED RETIREMENT AGE">LIFETIME MEMBER - WITH 120 MONTHS CONTRIBUTION AND HAS REACHED RETIREMENT AGE</option>
                                                                <option   value="SPONSORED - LGU">SPONSORED - LGU</option>
                                                                <option   value="SPONSORED - NGA">SPONSORED - NGA</option>
                                                                <option   value="SPONSORED - OTHERS">SPONSORED - OTHERS</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                        
                                                        
                                                        
                                                    </div>
                                                </div>
                                            
                                            
                                            
                                            
                                        </div>
                                    </div>
                                </div>
                                <!--MEMBERSHIP-->



                                <div class="col-sm-12 form-control-label">
                                    <div class="x_panel">
                                        <div class="x_title">
                                            <h2><strong>Address & Contact Information</strong></h2>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="x_content">



                                            <div class="form-group row">
                                                <label class="col-md-3 form-control-label" for="contactnumber"> Contact Number</label>
                                                <div class="col-md-3">
                                                    <input type="number" id="contactnumber" name="contactnumber" class="form-control" placeholder="09171234567" maxlength="11" onkeypress="return isNumberKey(event)" required="required">
                                                    <span class="help-block">Contact Number</span>
                                                </div>
                                            </div>


                                            <div class="form-group row">
                                                <label class="col-md-3 form-control-label" for="address">Address</label>
                                                <div class="col-md-9">
                                                    <input type="text" id="address" name="address" class="form-control" placeholder="Enter address" required="required">
                                                    <span class="help-block">Please enter your address</span>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-md-3 form-control-label" for="barangay">Barangay</label>
                                                <div class="col-md-3">
                                                    <select id="barangay" name="barangay" class="barangay form-control" onchange="configureDropDownLists(this,document.getElementById('healthcenter'))">
                                                        <!--                                    <option value="0">Please select</option>-->
                                                        <option value="Dolores">Dolores</option>
                                                        <option value="Juliana">Juliana</option>
                                                        <option value="Lourdes">Lourdes</option>
                                                        <option value="Magliman">Magliman</option>
                                                        <option value="San Jose">San Jose</option>
                                                        <option value="San Juan">San Juan</option>
                                                        <option value="Sto. Rosario">Sto. Rosario</option>
                                                        <option value="Sta. Teresita">Sta. Teresita</option>
                                                        <option name="stonino" value="Sto. Nino">Sto. Nino</option>
                                                    </select>
                                                    <span class="help-block">Please select your barangay</span>
                                                </div>
                                            </div>
                                            
                                            
                                            <div class="form-group row">
                                                <label class="col-md-3 form-control-label" for="healthcenter">Barangay Health Center</label>
                                                <div class="col-md-3">
                                                    <select id="healthcenter" name="healthcenter" class="healthcenter form-control">
                                                        <option name="dolores" value="Dolores North">Dolores North</option>
                                                        <option name="dolores" value="Dolores South">Dolores South</option>      
                                                        <option value="Juliana">Juliana</option>
                                                        <option value="Lourdes">Lourdes</option>
                                                        <option value="Magliman">Magliman</option>
                                                        <option value="San Jose">San Jose</option>
                                                        <option value="San Juan">San Juan</option>
                                                        <option value="Sta. Rosario">Sta. Rosario</option>
                                                        <option value="Sta. Teresita">Sta. Teresita</option>
                                                        <option name="stonino" value="Sto. Nino North">Sto. Nino North</option>
                                                        <option name="stonino" value="Sto. Nino South">Sto. Nino South</option>
                                                    </select>
                                                    <span class="help-block">Please select your BHC</span>
                                                </div>
                                            </div>






                                        </div>

                                    </div>


                                   
                                </div>
                                 <br><br><br><br><br>    <br><br><br><br><br> <br><br><br><br><br>   <br><br>
                                <!--ADDRESS AND CONTACT-->


                                <footer>

                                    <div id="error"></div>
                                        <div class="form-group" align="center">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                                <button onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                                <!--              <button class="btn btn-primary" type="reset">Reset</button>-->
                                                <button type="submit" class="btn btn-success">Submit</button>
                                            </div>
                                        </div>
                                </footer>


                            </div>
                            <!--row-->



                            <!-- jQuery -->



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
        <!-- bootstrap-datetimepicker -->    
        <script src="vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
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
        <!-- timepicker-->
        <script type="text/javascript" src="vendors/timepicker/bootstrap-timepicker.min.js"></script>
        <!-- doctemplate-->
        <script type="text/javascript" src="vendors/docxtemplater/es6/docxtemplater.js"></script>
                            
                            

                        </div>
                        <!--col-md-12 for all -->


                    </div>
                    <!--right_col -->






                </div>
                <!--main_container-->


            </form>
        </div>
        <!--container-body-->



    </body>


<!--<script>
$(function(){
    $('select.barangay').change(function(){ 
        var userSelect = $(this).find(":selected").val();
        $('select.healthcenter').val(userSelect);

    });
})    
</script>-->
            
<!--selected options-->
<script type="text/javascript">
    function configureDropDownLists(barangay,healthcenter) {
    var dolores = ['Dolores North', 'Dolores South'];
    var juliana = ['Juliana'];
    var lourdes = ['Lourdes'];
    var magliman = ['Magliman'];
    var sanjose = ['San Jose'];
    var sanjuan = ['San Juan'];
    var storosario = ['Sta. Rosario'];
    var stateres = ['Sta. Teresita'];
    var stonino = ['Sto. Nino North', 'Sto. Nino South'];

    switch (barangay.value) {
        case 'Dolores':
            healthcenter.options.length = 0;
            for (i = 0; i < dolores.length; i++) {
                createOption(healthcenter, dolores[i], dolores[i]);
            }
            break;
        case 'Juliana':
            healthcenter.options.length = 0; 
        for (i = 0; i < juliana.length; i++) {
            createOption(healthcenter, juliana[i], juliana[i]);
            }
            break;
        case 'Lourdes':
            healthcenter.options.length = 0;
            for (i = 0; i < lourdes.length; i++) {
                createOption(healthcenter, lourdes[i], lourdes[i]);
            }
            break;
        case 'Magliman':
            healthcenter.options.length = 0;
            for (i = 0; i < magliman.length; i++) {
                createOption(healthcenter, magliman[i], magliman[i]);
            }
            break;
        case 'San Jose':
            healthcenter.options.length = 0;
            for (i = 0; i < sanjose.length; i++) {
                createOption(healthcenter, sanjose[i], sanjose[i]);
            }
            break;
        case 'San Juan':
            healthcenter.options.length = 0;
            for (i = 0; i < sanjuan.length; i++) {
                createOption(healthcenter, sanjuan[i], sanjuan[i]);
            }
            break;
        case 'Sta. Rosario':
            healthcenter.options.length = 0;
            for (i = 0; i < storosario.length; i++) {
                createOption(healthcenter, storosario[i], storosario[i]);
            }
            break;
        case 'Sta. Teresita':
            healthcenter.options.length = 0;
            for (i = 0; i < stateres.length; i++) {
                createOption(healthcenter, stateres[i], stateres[i]);
            }
            break;
        case 'Sto. Nino':
            healthcenter.options.length = 0;
            for (i = 0; i < stonino.length; i++) {
                createOption(healthcenter, stonino[i], stonino[i]);
            }
            break;
            
            default:
                healthcenter.options.length = 0;
            break;
    }

}

    function createOption(ddl, text, value) {
        var opt = document.createElement('option');
        opt.value = value;
        opt.text = text;
        ddl.options.add(opt);
    }
</script>


<script>
    $('#birthday').datetimepicker({
        format: 'YYYY-MM-DD',
        maxDate: moment()
        
    });   
</script>


<script>
$(document).ready(function(){
    $('input[type="checkbox"]').click(function(){
        if($('#philhealthmem').is(":checked")){
            $('#philhealth_card').show();
        } else {
            $('#philhealth_card').hide();
        } 

    });
});
</script>
        

<script>   
    $(document).ready(function() {
        //CIVIL STATUS

        $('#label_married').on('click', function(event) {
            $('#married_card').show();
        });

        $('#label_single').on('click', function(event) {
            $('#married_card').hide();

        });
        $('#label_cohabitation').on('click', function(event) {
            $('#married_card').hide();

        });
        $('#label_annulled').on('click', function(event) {
            $('#married_card').hide();

        });
        $('#label_widow').on('click', function(event) {
            $('#married_card').hide();

        });
        $('#label_separated').on('click', function(event) {
            $('#married_card').hide();

        });
    });

</script>

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
