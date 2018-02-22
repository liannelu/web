<%@page import="Model.Patient"%>
<%@page import="Model.User"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date;"%>
<%@page import="Model.Family_Code"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!--for the cc code-->

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
    SimpleDateFormat whole = new SimpleDateFormat("yyyy-MM-dd"); //updated 2-15-2018

    Date tempbirthday = currentPatient.getBirthdate();
    String birthdate = whole.format(tempbirthday);
    //String birthdayMonth = month.format(tempbirthday);
    // String birthdayYear = year.format(tempbirthday);
    //String birthdate = birthdayMonth + ", " + birthdayYear;
    
%>
    

    <html>
     
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Edit Patient Information </title>

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
            <form action="EditPatient" method="post">
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
                                <li class="breadcrumb-item"><a href="home.jsp">  Home </a></li>
                                <li class="breadcrumb-item"> Forms</li>
                                <li class="breadcrumb-item active">Edit Patient Information </li>
                            </ol>

                            <!--                     x_panel-inverse x_panel-info text-xs-center-->
                            <div class="page-title">
                                <div class="title_left">
                                    <h3><i class="fa fa-edit"></i> Edit Patient Information</h3>
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
                                                        <input type="text" id="fname" name="fname" class="form-control" placeholder="e.g. Juan" value="<%=currentPatient.getFirstname() %>" required="required">
                                                        <span class="help-block">First Name</span>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <input type="text" id="mname" name="mname" class="form-control" placeholder="e.g. Paolo" value="<%=currentPatient.getMiddlename() %>">
                                                        <span class="help-block">Middle Name</span>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <input type="text" id="lname" name="lname" class="form-control" placeholder="e.g. de la Cruz" required="required" value="<%=currentPatient.getLastname() %>">
                                                        <span class="help-block">Last Name</span>
                                                    </div>
                                                </div>

                            <c:set var="sex" value="<%=currentPatient.getSex()%>"/> 
                                                <div class="form-group row" <c:if test="${sex=='Female'}">style="display: none;"</c:if>>
                                                    <label class="col-md-3 form-control-label" for="prefix"></label>

                            <%
                                    String suffix= currentPatient.getSuffix();
                                    
                            %>
                                                  
                                                    <label class="form-control-label" for="suffix"></label>
                                                    <div class="col-md-3">
                                                        <select id="suffix" name="suffix" class="form-control">
                                                           <% if(suffix.equals("N/A")){
                                                           %>
                                                            <option value="" selected>N/A</option> 
                                                            <% }else{ %>
                                                            <option value="">N/A</option>
                                                            <%}%>
                                                    <!------------------------------>
                                                            <% if(suffix.equals("Jr.")){
                                                           %>
                                                            <option value="Jr." selected>Jr.</option>
                                                            <% }else{ %>
                                                            <option value="Jr.">Jr.</option>
                                                            <%}%>
                                                    <!------------------------------>       
                                                            <% if(suffix.equals("Sr.")){
                                                           %>
                                                            <option value="Sr." selected>Sr.</option>
                                                            <% }else{ %>
                                                            <option value="Sr.">Sr.</option>
                                                            <%}%>
                                                    <!------------------------------>     
                                                            <% if(suffix.equals("I")){
                                                           %>
                                                           <option value="I" selected>I</option>
                                                            <% }else{ %>
                                                            <option value="I">I</option>
                                                            <%}%>
                                                    <!------------------------------>  
                                                            <% if(suffix.equals("II")){
                                                           %>
                                                            <option value="II" selected>II</option>
                                                            <% }else{ %>
                                                            <option value="II">II</option>
                                                            <%}%>
                                                   <!------------------------------>       
                                                            <% if(suffix.equals("III")){
                                                           %>
                                                            <option value="III" selected>III</option>
                                                            <% }else{ %>
                                                            <option value
                                                            ="III">III</option>
                                                            <%}%>
                                                   <!------------------------------>      
                                                            <% if(suffix.equals("IV")){
                                                           %>
                                                           <option value="IV" selected>IV</option>
                                                           <% }else{ %>
                                                           <option value="IV">IV</option>
                                                            <%}%>
                                                   <!------------------------------>       
                                                            <% if(suffix.equals("V")){
                                                           %>
                                                           <option value="V" selected>V</option>
                                                            <% }else{ %>
                                                            <option value="V">V</option>
                                                            <%}%>
                                                            
                                                        </select>
                                                        <span class="help-block">Suffix</span>
                                                    </div>

                                                </div>
                                                
                                            <!--<div class="form-group row">
                                                <label class="col-md-3 form-control-label" for="mothername">Mother's Name</label>
                                                <div class="col-md-3">
                                                    <input type="text" id="mfname" name="mothernamef" class="form-control" placeholder="e.g. Maria" required="required" value="">
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
                                            </div>-->
                                                

                                                <div class="form-group row">
                                                    <label class="col-md-3 form-control-label" for="email">Email Address</label>
                                                    <div class="col-md-3">
                                                        <input type="email" id="email" name="email" class="form-control" placeholder="juan@email.com" value="<%=currentPatient.getEmail()%>">
                                                        <span class="help-block">Please enter your email address</span>
                                                    </div>
                                                </div>

                                                <div class="form-group row">
                                                    <label class="col-md-3 form-control-label" for="birthday">Birth Date</label>

                                                    <div class='col-sm-3'>

                                                        <div class="form-group">
                                                            <div class='input-group date' id="birthdate">
                                                                <input type='text' class="form-control" name="birthday" required="required" value="<%=birthdate%>"/>
                                                                <div class="input-group-addon">
                                                                    <i class="fa fa-calendar"></i>
                                                                </div>
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
                                                        <input type="text" id="birthplace" name="birthplace" class="form-control" placeholder="Birthplace" value="<%=currentPatient.getBirthplace()%>">
                                                        <span class="help-block"></span>
                                                    </div>
                                                </div>
                                                        
                                                <br>

                                                <div class="x_panel">
                                                    <!--                <div class="x_title"> x_panel title</div>-->
                                                    <div class="x_content">
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label">SEX</label>
                                                            <div class="col-md-9">

                                                              <!--THIS IS IMPORTANT-->
                                                               <c:set var="sex" value="<%=currentPatient.getSex()%>"/>
                                                               
                                                                <div class="radio">
                                                                    <label for="male">
                                                                    
                                                                        <input type="radio" class=""  id="male" name="sex" value="Male" required="required" <c:if test="${sex=='Male'}">checked</c:if>> 
                                                                    
                                                                        Male
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="female">
                                                                       <input type="radio" class=""  id="female" name="sex" value="Female" <c:if test="${sex=='Female'}">checked</c:if>> 
                                                                        Female
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
                                                            <c:set var="bloodtype" value="<%=currentPatient.getBloodtype()%>"/> <!--THIS IS IMPORTANT -->
                                                            <div class="col-md-2">
                                                                <div class="radio">
                                                                    <label for="a+">
                                                                        <input type="radio" class=""  id="a+" name="bloodtype" value="A+" <c:if test="${bloodtype=='A+'}">checked</c:if>> A+
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="a-">
                                                                        <input type="radio" class=""  id="a-" name="bloodtype" value="A-" <c:if test="${bloodtype=='A-'}">checked</c:if>> A-
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="b+">
                                                                        <input type="radio" class=""  id="b+" name="bloodtype" value="B+" <c:if test="${bloodtype=='B+'}">checked</c:if>> B+
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="b-">
                                                                        <input type="radio" class=""  id="b-" name="bloodtype" value="B-" <c:if test="${bloodtype=='B-'}">checked</c:if>> B-
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <div class="radio">
                                                                    <label for="ab+">
                                                                        <input type="radio" class=""  id="ab+" name="bloodtype" value="AB+" <c:if test="${bloodtype=='AB+'}">checked</c:if>> AB+
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="ab-">
                                                                        <input type="radio" class=""  id="ab-" name="bloodtype" value="AB-" <c:if test="${bloodtype=='AB-'}">checked</c:if>> AB-
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="o+">
                                                                        <input type="radio" class=""  id="o+" name="bloodtype" value="O+" <c:if test="${bloodtype=='O+'}">checked</c:if>> O+
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="o-">
                                                                        <input type="radio" class=""  id="o-" name="bloodtype" value="O-" <c:if test="${bloodtype=='O-'}">checked</c:if>> O-
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
                                                            
                                                             <c:set var="civilstatus" value="<%=currentPatient.getCivil_status()%>"/> <!--THIS IS IMPORTANT -->
                                                             
                                                            <div class="col-md-3">
                                                                <div class="radio">
                                                                    <label for="single" id="label_single">
                                                                        <input type="radio" class=""  id="single" name="civilstatus" value="Single" <c:if test="${civilstatus=='Single'}">checked</c:if>> Single
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="married" id="label_married">
                                                                        <input type="radio" class=""  id="married" name="civilstatus" value="Married" <c:if test="${civilstatus=='Married'}">checked</c:if>> Married
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="cohabitation" id="label_cohabitation">
                                                                        <input type="radio" class=""  id="cohabitation" name="civilstatus" value="Cohabitation" <c:if test="${civilstatus=='Cohabitation'}">checked</c:if>> Co-habitation
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="radio">
                                                                    <label for="annulled" id="label_annulled">
                                                                        <input type="radio" class=""  id="annulled" name="civilstatus" value="Annulled" <c:if test="${civilstatus=='Annulled'}">checked</c:if>> Annulled
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="widow" id="label_widow">
                                                                        <input type="radio" class=""  id="widow" name="civilstatus" value="Widow" <c:if test="${civilstatus=='Widow'}">checked</c:if>> Widow/er
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="separated" id="label_separated">
                                                                        <input type="radio" class=""  id="separated" name="civilstatus" value="Separated" required="required" <c:if test="${civilstatus=='Separated'}">checked</c:if>> Separated
                                                                    </label>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                    <!-- ******************* GG NUMBER 2 ---------------->
                                                    <!--<div id="married_card" style="display: none;">
                                                        
                                                        <div class="form-group row">
                                                            <br>
                                                            <label class="col-md-3 form-control-label" for="spousename">Spouse's Name</label>
                                                            <div class="col-md-3">
                                                                <input type="text" id="sfname" name="spousenamef" class="form-control" placeholder="e.g. Maria">
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
-->
                                                </div>

                                                <div class="x_panel">
                                                    <!--                <div class="x_title"> x_panel title</div>-->
                                                    <div class="x_content">
                                                        <div class="form-group row">
                                                            <label class="col-md-3 form-control-label">Educational Attainment</label>
                                                            
                                                            <c:set var="educationalattainment" value="<%=currentPatient.getEducational_attainment()%>"/> <!--THIS IS IMPORTANT -->
                                                            
                                                            
                                                            <div class="col-md-3">
                                                                <div class="radio">
                                                                    <label for="noformal">
                                                                        <input type="radio" class=""  id="noformal" name="educationalattainment" value="No Formal Education" <c:if test="${educationalattainment=='No Formal Education'}">checked</c:if>> No Formal Education
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="elementary">
                                                                        <input type="radio" class=""  id="elementary" name="educationalattainment" value="Elementary" <c:if test="${educationalattainment=='Elementary'}">checked</c:if>> Elementary
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="highschool">
                                                                        <input type="radio" class=""  id="highschool" name="educationalattainment" value="High School" <c:if test="${educationalattainment=='High School'}">checked</c:if>> High School
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="radio">
                                                                    <label for="vocational">
                                                                        <input type="radio" class=""  id="vocational" name="educationalattainment" value="Vocational" <c:if test="${educationalattainment=='Vocational'}">checked</c:if>> Vocational
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="college">
                                                                        <input type="radio" class=""  id="college" name="educationalattainment" value="College" <c:if test="${educationalattainment=='College'}">checked</c:if>> College
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="postgraduate">
                                                                        <input type="radio" class=""  id="postgraduate" name="educationalattainment" value="Post Graduate" required="required" <c:if test="${educationalattainment=='Post Graduate'}">checked</c:if>> Post Graduate
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
                                                            
                                                            <c:set var="employmentstatus" value="<%=currentPatient.getEmployment_status()%>"/> <!--THIS IS IMPORTANT -->
                                                            
                                                            
                                                            <div class="col-md-9">
                                                                <div class="radio">
                                                                    <label for="student">
                                                                        <input type="radio" class=""  id="student" name="employmentstatus" value="Student" required="required"  <c:if test="${employmentstatus=='Student'}">checked</c:if>> Student
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="employed">
                                                                        <input type="radio" class=""  id="employed" name="employmentstatus" value="Employed" <c:if test="${employmentstatus=='Employed'}">checked</c:if>> Employed
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="unemployed">
                                                                        <input type="radio" class=""  id="unemployed" name="employmentstatus" value="Unemployed" <c:if test="${employmentstatus=='Unemployed'}">checked</c:if>> Unemployed
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="retired">
                                                                        <input type="radio" class=""  id="retired" name="employmentstatus" value="Retired" <c:if test="${employmentstatus=='Retired'}">checked</c:if>> Retired
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="unknown">
                                                                        <input type="radio" class=""  id="unknown" name="employmentstatus" value="Unknown" <c:if test="${employmentstatus=='Unknown'}">checked</c:if>> Unknown
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
                                                            <label class="col-md-3 form-control-label">Family Member</label>
                                                            
                                                            <c:set var="fammem" value="<%=currentPatient.getFamily_member()%>"/> <!--THIS IS IMPORTANT -->
                                                            
                                                            <div class="col-md-9">
                                                                <div class="radio">
                                                                    <label for="father">
                                                                        <input type="radio" class=""  id="father" name="familymember" value="Father" <c:if test="${fammem=='Father'}">checked</c:if>> Father
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="son">
                                                                        <input type="radio" class=""  id="son" name="familymember" value="Son" required="required" <c:if test="${fammem=='Son'}">checked</c:if>"> Son
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="mother">
                                                                        <input type="radio" class=""  id="mother" name="familymember" value="Mother" <c:if test="${fammem=='Mother'}">checked</c:if>> Mother
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="daughter">
                                                                        <input type="radio" class=""  id="daughter" name="familymember" value="Daughter" <c:if test="${fammem=='Daughter'}">checked</c:if>> Daughter
                                                                    </label>
                                                                </div>
                                                                <div class="radio">
                                                                    <label for="familyother">
                                                                        <input type="radio" class=""  id="familyother" name="familymember" value="other" <c:if test="${fammem!='Daughter' && fammem!='Mother' && fammem!='Father' && fammem!='Son'}">checked</c:if>> Other:
                                                                        
                                                                        <input type="text" id="familyother-input" name="familymembertxt" size="" <c:if test="${fammem!='Daughter' && fammem!='Mother' && fammem!='Father' && fammem!='Son'}">value='<%=currentPatient.getFamily_member()%>'</c:if>>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                        </div>
                                    </div>
                                </div>

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
                                                                <input type="number" id="purok" name="purok" class="form-control" placeholder="Purok" min="0" required="required" value="<%=currentPatient.getPurok()%>">
                                                            <span class="glyphicon glyphicon-home form-control-feedback right" aria-hidden="true"></span>
                                                                <span class="help-block">Purok</span>
                                                            </div>
                                                            
                                                            
                                                            <label class=" form-control-label" for="family_household_number"></label>
                                                            
                                                            <div class="col-md-3">
                                                                <input type="text" id="family_household_number" name="family_household_number" class="form-control" placeholder="000000000-4444-55555" value="<%=currentPatient.getFamily_household_num()%>">
                                                                <span class="fa fa-user form-control-feedback right" aria-hidden="true"></span>
                                                                <span class="help-block">Family Household Number</span>
                                                            </div>
                                                        </div>
                                                        
                                                        
                                                        
                                                        <div class="form-group row col-md-12 "></div>


                                                        <div class="form-group-row">
                                                            <label class="form-control-label col-md-3 col-sm-3 col-xs-3" for="facilityhouseholdnum">Family Number</label>
                                                            <div class="form-group-row col-md-3 col-sm-12 col-xs-12">

                                                                <input id="familyserial" name="familyserial" type="text" class="form-control" value="<%=currentPatient.getFamily_num()%>">
                                                                <!--                                                <span class="fa fa-user form-control-feedback right" aria-hidden="true"></span>-->
                                                                <span class="help-block">Family Number</span>
                                                                
                                                            </div>
                                                            <div>
                                                                <button  type="button" class="btn btn-sm btn-primary" data-toggle="modal" data-target=".family-serial-modal"><i class="fa fa-book"></i> Select Family Serial #</button>
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

                                                        <c:set var="checker" value="1"/> <!--THIS IS IMPORTANT -->
                                                         <c:set var="fourps" value="<%=currentPatient.getFourps_member()%>"/> <!--THIS IS IMPORTANT -->
                                                         <c:set var="dswd" value="<%=currentPatient.getDswd_nhts()%>"/> <!--THIS IS IMPORTANT -->
                                                         <c:set var="philhealth" value="<%=currentPatient.getPhilhealth_member()%>"/> <!--THIS IS IMPORTANT -->
                                                         
                                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                                          <div class="checkbox">
                                                            <label>
                                                              <input type="checkbox" class="" id="4ps" name="4pmember" value="1"  <c:if test="${fourps == checker}">checked</c:if>> 4Ps Member
                                                            </label>
                                                          </div>
                                                        </div>
                                                        
                                                         <div class="col-md-3 col-sm-3 col-xs-3"></div>
                                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                                          <div class="checkbox">
                                                            <label>
                                                              <input type="checkbox" class="" id="dhwdyes" name="dswd" value="1" <c:if test="${dswd == checker}">checked</c:if>> DSWD NHTS
                                                            </label>
                                                          </div>
                                                        </div>
                                                        
                                                        <label class="col-md-3 form-control-label"></label>
                                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                                          <div class="checkbox">
                                                            <label id="showphilhealthnum">
                                                              <input type="checkbox" class="" id="philhealthmem" name="philhealthmem" value="Yes" <c:if test="${philhealth=='Yes'}">checked</c:if>> PhilHealth Member
                                                            </label>
                                                          </div>
                                                        </div>
                                                        
                                                        <br/>
                                                        
                                                    </div>
                         
                                                </div>
                                                
                                            </div>

                                           
                                            <div id="philhealth_card" <c:if test="${philhealth=='No'}">style="display: none;"</c:if>>

                                                <div class="x_panel">
                                                    <div class="x_title"> <h5> <strong>PhilHealth Membership</strong></h5>
                                                    </div>
                                                <div class="clearfix"></div>
                                                <div class="form-group row">
                                                    <label class="col-md-3 form-control-label" for="philhealthno">PhilHealth No. </label>
                                                    <div class="col-md-3">
                                                        <input type="text" id="philhealthno" name="philhealthno" class="form-control" placeholder="00-000000000-1" value="<%=currentPatient.getPhilhealth_num()%>">
                                                        <span class="help-block">PhilHealth No. </span>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <label class="col-md-3 form-control-label">Philhealth Status Type</label>
                                                    
                                                     <c:set var="philhealthstat" value="<%=currentPatient.getStatus_type()%>"/> <!--THIS IS IMPORTANT -->
                                                     
                                                    <div class="col-md-9">
                                                        <div class="radio">
                                                            <label for="member">
                                                                <input type="radio" class=""  id="member" name="statustype" value="Member"  <c:if test="${philhealthstat=='Member'}">checked</c:if>> Member
                                                            </label>
                                                        </div>
                                                        <div class="radio">
                                                            <label for="dependent">
                                                                <input type="radio" class=""  id="dependent" name="statustype" value="Dependent"  <c:if test="${philhealthstat=='Dependent'}">checked</c:if>> Dependent
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <br/><br/>
                                            <div class="row">
                                                <label class="control-label col-md-3 col-sm-3 col-xs-12">FOR  PMRF (PhilHealth Membership Registration Form) </label>
                                                
                                                 <c:set var="membercategory" value="<%=currentPatient.getMember_category()%>"/> <!--THIS IS IMPORTANT -->
                                                 
                                                 
                                                <div class="col-md-9 col-sm-9 col-xs-12">
                                                    <select class="form-control" id="philhealthcat" name="philhealthcat">
                                                        <option value=""> -- SELECT PHILHEALTH CATEGORY --</option>
                                                        <option   value="1"  <c:if test="${membercategory=='1'}">selected</c:if>>FE - ENTERPRISE OWNER</option>
                                                        <option   value="2" <c:if test="${membercategory=='2'}">selected</c:if>>FE - FAMILY DRIVER</option>
                                                        <option   value="3" <c:if test="${membercategory=='3'}">selected</c:if>>FE - GOVT - CASUAL</option>
                                                        <option   value="4" <c:if test="${membercategory=='4'}">selected</c:if>>FE - GOVT - CONTRACT/PROJECT BASED</option>
                                                        <option   value="5" <c:if test="${membercategory=='5'}">selected</c:if>>FE - GOVT - PERMANENT REGULAR</option>
                                                        <option   value="6" <c:if test="${membercategory=='6'}">selected</c:if>>FE - HOUSEHOLD HELP/KASAMBAHAY</option>
                                                        <option   value="7" <c:if test="${membercategory=='7'}">selected</c:if>>FE - PRIVATE - CASUAL</option>
                                                        <option   value="8" <c:if test="${membercategory=='8'}">selected</c:if>>FE - PRIVATE - CONTRACT/PROJECT BASED</option>
                                                        <option   value="9" <c:if test="${membercategory=='9'}">selected</c:if>>FE - PRIVATE - PERMANENT REGULAR</option>
                                                        <option   value="10" <c:if test="${membercategory=='10'}">selected</c:if>>IE - CITIZEN OF OTHER COUNTRIES WORKING/RESIDING/STUDYING IN THE PHILIPPINES</option>
                                                        <option   value="11" <c:if test="${membercategory=='11'}">selected</c:if>>IE - FILIPINO WITH DUAL CITIZENSHIP</option>
                                                        <option   value="12" <c:if test="${membercategory=='12'}">selected</c:if>>IE - INFORMAL SECTOR</option>
                                                        <option   value="13" <c:if test="${membercategory=='13'}">selected</c:if>>IE - MIGRANT WORKER - LAND BASED</option>
                                                        <option   value="14" <c:if test="${membercategory=='14'}">selected</c:if>>IE - MIGRANT WORKER - SEA BASED</option>
                                                        <option   value="15" <c:if test="${membercategory=='15'}">selected</c:if>>IE - NATURALIZED FILIPINO CITIZEN</option>
                                                        <option   value="16" <c:if test="${membercategory=='16'}">selected</c:if>>IE - ORGANIZED GROUP</option>
                                                        <option   value="17" <c:if test="${membercategory=='17'}">selected</c:if>>IE - SELF EARNING INDIVIDUAL</option>
                                                        <option   value="18" <c:if test="${membercategory=='18'}">selected</c:if>>INDIGENT - NHTS-PR</option>
                                                        <option   value="19" <c:if test="${membercategory=='19'}">selected</c:if>>LIFETIME MEMBER - RETIREE/PENSIONER</option>
                                                        <option   value="20" <c:if test="${membercategory=='20'}">selected</c:if>>LIFETIME MEMBER - WITH 120 MONTHS CONTRIBUTION AND HAS REACHED RETIREMENT AGE</option>
                                                        <option   value="21" <c:if test="${membercategory=='21'}">selected</c:if>>SPONSORED - LGU</option>
                                                        <option   value="22" <c:if test="${membercategory=='22'}">selected</c:if>>SPONSORED - NGA</option>
                                                        <option   value="23" <c:if test="${membercategory=='23'}">selected</c:if>>SPONSORED - OTHERS</option>
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
                                                    <input type="number" id="contactnumber" name="contactnumber" class="form-control" placeholder="09171234567" maxlength="11" onkeypress="return isNumberKey(event)" required="required" value="<%=currentPatient.getContact_num()%>">
                                                    <span class="help-block">Contact Number</span>
                                                </div>
                                            </div>


                                            <div class="form-group row">
                                                <label class="col-md-3 form-control-label" for="address">Address</label>
                                                <div class="col-md-9">
                                                    <input type="text" id="address" name="address" class="form-control" placeholder="Enter address" required="required" value="<%=currentPatient.getAddress()%>">
                                                    <span class="help-block">Please enter your address</span>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-md-3 form-control-label" for="barangay">Barangay</label>
                                                
                                                 <c:set var="barangay" value="<%=currentPatient.getBarangay()%>"/> <!--THIS IS IMPORTANT -->
                                                 
                                                <div class="col-md-3">
                                                    <select id="barangay" name="barangay" class="form-control" onchange="configureDropDownLists(this,document.getElementById('healthcenter'))">
                                                        <!--                                    <option value="0">Please select</option>-->
                                                        <option value="Dolores"  <c:if test="${barangay=='Dolores'}">selected</c:if>>Dolores</option>
                                                        <option value="Juliana" <c:if test="${barangay=='Juliana'}">selected</c:if>>Juliana</option>
                                                        <option value="Lourdes" <c:if test="${barangay=='Lourdes'}">selected</c:if>>Lourdes</option>
                                                        <option value="Magliman" <c:if test="${barangay=='Magliman'}">selected</c:if>>Magliman</option>
                                                        <option value="San Jose" <c:if test="${barangay=='San Jose'}">selected</c:if>>San Jose</option>
                                                        <option value="San Juan" <c:if test="${barangay=='San Juan'}">selected</c:if>>San Juan</option>
                                                        <option value="Sta. Rosario" <c:if test="${barangay=='Sta. Rosario'}">selected</c:if>>Sta. Rosario</option>
                                                        <option value="Sta. Teresita" <c:if test="${barangay=='Sta. Teresita'}">selected</c:if>>Sta. Teresita</option>
                                                        <option value="Sto. Nino" <c:if test="${barangay=='Sto. Nino'}">selected</c:if>>Sto. Nino</option>
                                                    </select>
                                                    <span class="help-block">Please select your barangay</span>
                                                </div>
                                            </div>
                                            
                                            
                                            <div class="form-group row">
                                                <label class="col-md-3 form-control-label" for="healthcenter">Barangay Health Center</label>
                                                
                                                 <c:set var="bhc" value="<%=currentPatient.getBHC()%>"/> <!--THIS IS IMPORTANT -->
                                                
                                                <div class="col-md-3">
                                                    <select id="healthcenter" name="healthcenter" class="healthcenter form-control">
                                                        <option name="dolores" value="Dolores North" <c:if test="${bhc=='Dolores North'}">selected</c:if>>Dolores North</option>
                                                        <option name="dolores" value="Dolores South" <c:if test="${bhc=='Dolores South'}">selected</c:if>>Dolores South</option>      
                                                        <option value="Juliana" <c:if test="${bhc=='Juliana'}">selected</c:if>>Juliana</option>
                                                        <option value="Lourdes" <c:if test="${bhc=='Lourdes'}">selected</c:if>>Lourdes</option>
                                                        <option value="Magliman" <c:if test="${bhc=='Magliman'}">selected</c:if>>Magliman</option>
                                                        <option value="San Jose" <c:if test="${bhc=='San Jose'}">selected</c:if>>San Jose</option>
                                                        <option value="San Juan" <c:if test="${bhc=='San Juan'}">selected</c:if>>San Juan</option>
                                                        <option value="Sta. Rosario" <c:if test="${bhc=='Sto. Rosario'}">selected</c:if>>Sto. Rosario</option>
                                                        <option value="Sta. Teresita" <c:if test="${bhc=='Sta. Teresita'}">selected</c:if>>Sta. Teresita</option>
                                                        <option name="stonino" value="Sto. Nino North" <c:if test="${bhc=='Sto. Nino North'}">selected</c:if>>Sto. Nino North</option>
                                                        <option name="stonino" value="Sto. Nino South" <c:if test="${bhc=='Sto. Nino South'}">selected</c:if>>Sto. Nino South</option>
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
                                    <%
                                    String error=(String)request.getAttribute("error");  
                                    if(error!=null)
                                    out.println("<font color=red size=2px>"+error+"</font>");
                    
                                    String success=(String)request.getAttribute("success");  
                                    if(success!=null)
                                    out.println("<font color=green size=2px>"+success+"</font>");
                                    %>

                                        <div class="form-group" align="center">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                                <button onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                                <!--              <button class="btn btn-primary" type="reset">Reset</button>-->
                                                <button type="submit" class="btn btn-success">Update</button>
                                            </div>
                                        </div>
                                </footer>


                            </div>
                            <!--row-->

        <!--FAMILY SERIAL MODAL-->
            <div class="modal fade family-serial-modal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content">

                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal"><i class="fa fa-close"></i>
                      </button>
                      <strong class="modal-title" id="myModalLabel">View Family Number</strong>
                    </div>
                    <div class="modal-body">
        <div class="x_panel">
                            <form action="AddFamilyCode" method="post">
                            <div class="x_title">
                                <i class="fa fa-book"></i>
                                <!--get information from database!!-->
                                <strong> Family Number </strong> 
                                <!-- Elements-->
                                
                               <button type="" class="btn btn-sm btn-primary" style="float: right" name="selectSerial" value="0"><i class="fa fa-user"></i> Register with new Family Number</button>
                               
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
                                              <th></th>
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
                                            <td style="text-align:right; width:50px;">
                                            <button type="button" id="selectfamilynumber" name="selectfamilynumber" class="btn btn-primary btn-sm" onclick="javascript:document.getElementById('familyserial').value='<%=fcList.get(i).getFamilyCode()%>';$('.family-serial-modal').modal('hide');"><i class="fa fa-book"></i>Select Family Number</button>
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
                    </div>
                    <!--modal-body-->

                    <div class="modal-footer">
                      <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>

                  </div>
                </div>
              </div><!--Family Serial Modal-->
                            

                            



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




<script>
    $('#birthdate').datetimepicker({
        format: 'YYYY-MM-DD'
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

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

    </script>




    </html>
