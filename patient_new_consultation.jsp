<%@page import="Model.Patient"%>
<%@page import="Model.Prenatal"%>
<%@page import="Model.Vaccine"%>
<%@page import="Model.User"%>
<%@page import="Model.Consultation"%>
<%@page import="Model.Diagnosis"%>
<%@page import="Model.Medication"%>
<%@page import="DAO.doctorDAO"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date;"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!--for the cc code-->

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title> New Consultation </title>

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
        <!-- bootstrap-datepicker -->
        <link href="vendors/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" rel="stylesheet">
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
        
        <!--NEW ADDITIONS-->
        <link rel="stylesheet" href="vendors/bootstrap-multiselect/dist/css/bootstrap-multiselect.css" type="text/css"/>

        <!-- Custom Theme Style -->
        <link href="source/css/custom.min.css" rel="stylesheet">
    </head>

    <body class="nav-md footer_fixed">
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
                <form action="AddNewConsultation" method="post">
                    <input type="hidden" name="requestSource" value="newConsultation">
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
                           
                            <li class="breadcrumb-item">Forms</li>
                            <li class="breadcrumb-item active">New Consultation</li>
                        </ol>

                        <div class="col-md-12 col-sm-12 col-xs-12">
                           
                            <div class="page-title">
                                <div class="title_left">
                                    <h3>New Consultation</h3>
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

                            <input type="hidden" name="currSex" value="<%=currentPatient.getSex()%>"> <!-- for backend  -->
                            
                <div class="row">
                               
                            <jsp:include page="/patient_information.jsp" />

                            <!--TYPE OF CONSULTATION-->
                            <div class="x_panel">

                                <div class="x_content">
                                    <div class="col-12">

                                        <div class="row">
                                            <div class="col-md-2" id="mode_of_transaction">
                                                Mode of Transaction:</div>
                                            <div class="col-md-4 btn-group" data-toggle="buttons">
                                                <label required class="btn btn-primary" id="closereferral">
                                                    <input required type="radio" name="modeoftransac" id="walkin" value="Walk in"> Walk-In
                                                </label>
                                                <label required class="btn btn-primary" id="openreferral">
                                                    <input required type="radio" name="modeoftransac" id="referral" value="Referral"> Referral
                                                </label>
                                            </div>
                                            <div class="col-md-3">
                                                Date of Consultation:</div>
                                                <div class="col-md-3 col-sm-3">
                                                    <div class="form-group">
                                                        <div class='input-group date'>
                                                            <input disabled type='text' class="form-control" id="single_cal1" name="consultationDate"/>

                                                            <span class="input-group-addon time">
                                                               <span class="fa fa-calendar-o "></span>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div><!--col-md3-->

                                        </div>
                                        <!--row-->

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                        <div class="row">
                                    <div class="col-md-6"></div>


                                    <div class="col-md-3">
                                        Consultation Time:</div>
                                    <div class="col-md-3 col-sm-3">
                                        <div class="bootstrap-timepicker form-group">

                                           <div class="input-group">
                                            <input disabled type="text" class="form-control timepicker" name="consultationtime" id="consultationtime"/>

                                            <span class="input-group-addon time">
                                              <i class="fa fa-clock-o"></i>
                                            </span>
                                          </div>

                                        </div>
                                    </div><!--col-md3-->

                                </div>
                                <!--row-->

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                        <div class="row">

                                            <div class="col-md-2 form-control-label">Purpose of Visit:</div>

                                            <div class="col-md-2 col-sm-2">
                                                <div class="row">
                                                   <div class="col-md-8 pretty circle success">
                                                        <input required type="radio" id="general" name="purposeVisit" value="General"/><label><i class="default"></i> General</label>
                                                     </div>
                                                </div>
                                                <!--<div class="row">
                                                   <div class="col-md-8 pretty circle success">
                                                        <input required type="radio" id="tuberculosis" name="purposeVisit" value="Tuberculosis"/><label><i class="default"></i> Tuberculosis</label>
                                                     </div>
                                                </div>-->
                                                
                                                <%
                                                   if (currentPatient.getSex().equalsIgnoreCase("female") && nDAO.getMenopauseStatus(patientID).equalsIgnoreCase("No") || currentPatient.getSex().equalsIgnoreCase("female") && nDAO.getMenopauseStatus(patientID).equalsIgnoreCase("") || currentPatient.getSex().equalsIgnoreCase("female") && nDAO.getMenopauseStatus(patientID) == null){
                                                %>
                                                <div class="row">
                                                    <div class="col-md-8 pretty circle success">
                                                        <input required type="radio" id="postpartum" name="purposeVisit" value="Postpartum"/><label><i class="default"></i> Postpartum</label>
                                                     </div>
                                                </div>
                                                <%}%>

                                            </div>

                                            <!--col-md-2-->
                                            <div class="col-md-3 col-sm-2">
                                                <div class="row">
                                                    <div class="col-md-8 pretty circle success">
                                                        <input required type="radio" id="adultImmunization" name="purposeVisit" value="Adult Immunization"/><label><i class="default"></i> Adult Immunization</label>
                                                     </div>
                                                </div>
                                                
                                                <%
                                                   if (currentPatient.getSex().equalsIgnoreCase("female") && nDAO.getMenopauseStatus(patientID).equalsIgnoreCase("No") || currentPatient.getSex().equalsIgnoreCase("female") && nDAO.getMenopauseStatus(patientID).equalsIgnoreCase("") || currentPatient.getSex().equalsIgnoreCase("female") && nDAO.getMenopauseStatus(patientID) == null){
                                                %>
                                                   <div class="row">
                                                      <div class="col-md-8 pretty circle success">
                                                        <input required type="radio" id="prenatal" name="purposeVisit" value="Prenatal"/><label><i class="default"></i> Prenatal</label>
                                                     </div>
                                                    </div>
                                                <%}%>
                                            </div>
                                            <!--col-md-2-->
                                            <div class="col-md-3 col-sm-2">
                                               <div class="row">
                                                    <div class="col-md-8 pretty circle success">
                                                        <input required type="radio" id="childImmunization" name="purposeVisit" value="Child Care"/><label><i class="default"></i> Child Care</label>
                                                     </div>
                                                </div> 
                                            </div>

                                            <!--col-md-2-->
                                            <div class="col-md-2 col-sm-2">
                                              <div class="row">
                                                    <div class="col-md-10 pretty circle success">
                                                        <input required type="radio" id="familyPlanning" name="purposeVisit" value="Family Planning"/><label><i class="default"></i> Family Planning</label>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <!--row-->

                                    </div>
                                    <!--col-12-->
                                </div>
                                <!--x_content-->
                            </div>
                            <!--/.x_panel-->

                            <!--For Referral-->
                            <div class="x_panel" id="referralCard" style="display: none;">
                                <div class="x_title">
                                    <strong>FOR REFERRAL TRANSACTION ONLY</strong>
                                </div>
                                <div class="x_content">
                                    <!-- <form action="" method="post" enctype="multipart/form-data" class="form-horizontal"> -->

                                    <div class="form-group row">

                                        <label class="col-md-2 col-form-label">Referred From:</label>
                                        <div class="col-md-10">
                                            <input class="form-control noMargin" name="referredFrom" type="text" value="" placeholder="e.g. Lourdes Clinic">
                                        </div>

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                        <label class="col-md-2 col-form-label">Referred To:</label>
                                        <div class="col-md-10">
                                            <input class="form-control noMargin" name="referredTo" type="text" value="" placeholder="e.g. Pampanga Medical Specialist Hospital">
                                        </div>

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                        <label class="col-md-2 col-form-label">Reason(s) for Referral:</label>
                                        <div class="col-md-10">
                                            <textarea class="form-control noresize" placeholder="Reason(s) for Referral" cols="10" rows="5" name="reasonForReferral"></textarea>
                                        </div>

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                        <label class="col-md-2 col-form-label">Referred By:</label>
                                        <div class="col-md-10">
                                            <input class="form-control noMargin" name="referredBy" type="text" value="" placeholder="Name of Person/Place">
                                        </div>

                                    </div>
                                    <!--form-group-row-->

                                    <!-- </form> -->

                                </div>

                            </div>

                            <!--Menstrual History-->
                            <%
                               if (currentPatient.getSex().equalsIgnoreCase("female") ){
                                   
                             %>
                            <input type="hidden" id="menopausestatus" value="<%=nDAO.getMenopauseStatus(patientID)%>"/>
                            <div class="x_panel" id="menstrualCard" name="menstrualCard" style="display:none;">
                                <div class="x_title">
                                    <strong>MENSTRUAL HISTORY</strong>
                                </div>
                                <div class="x_content">

                                        <div class="form-group row">

                                            <label class="col-md-2 form-control-label">Menarche:</label>
                                            <div class="col-md-4">
                                               <div class='input-group date'>
                                                    <input type='text' class="form-control" id="menstrualMenarche" name="menstrualMenarche" placeholder="e.g. 2017-09-12 (optional)"/>
                                                    <span class="input-group-addon info">
                                                       <span class="fa fa-calendar-o "></span>
                                                    </span>
                                                </div>
                                            </div><!--col-md3-->

                                            <label class="col-md-2 form-control-label">Period/Duration:</label>
                                            <div class="col-md-4">
                                               <div class='input-group date'>
                                                    <input type='text' class="form-control" id="menstrualDuration" name="menstrualDuration" placeholder="e.g. 2017-09-19 (optional)"/>
                                                    <span class="input-group-addon info">
                                                       <span class="fa fa-calendar-o "></span>
                                                    </span>
                                                </div>
                                            </div><!--col-md3-->

                                        </div><!--row-->

                                        <div class="form-group row">

                                            <label class="col-md-2 form-control-label">Interval/Cycle:</label>
                                            <div class="col-md-4">
                                                <input class="form-control noMargin" id="interval" name="prenatalTerm" type="text" value="" placeholder="e.g. 2 (optional)">
                                            </div>

                                            <label class="col-md-2 form-control-label">Birth Control Method:</label>
                                            <div class="col-md-4">
                                                <input class="form-control noMargin" id="mensturalBirthControlMethod" name="mensturalBirthControlMethod" type="text" value="" placeholder="e.g. Birth Control Pills (optional)">
                                            </div>

                                        </div>
                                        <!--row-->

                                        <div class="form-group row">

                                           <label class="col-md-2 form-control-label">Onset of Sexual Intercourse:</label>
                                            <div class="col-md-4">
                                                <div class="row">
                                                    <div class="col-md-3 pretty circle success">
                                                        <input type="radio" id="mensturalOnsetSexualIntercourse" name="mensturalOnsetSexualIntercourse" value="Yes"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Yes</label>

                                                     </div>
                                                     <div class="col-md-3 pretty circle danger">
                                                        <input type="radio" id="mensturalOnsetSexualIntercourse" name="mensturalOnsetSexualIntercourse" value="No" checked/><label><i class="fa fa-close"></i> &nbsp;&nbsp;No</label>

                                                     </div>
                                                </div>
                                            </div>
                                            
                                            <label class="col-md-2 form-control-label">Menopause:</label>
                                            <div class="col-md-4">
                                                <div class="row">
                                                    <div class="col-md-3 pretty circle success">
                                                        <input <% if(nDAO.getMenopauseStatus(patientID).equalsIgnoreCase("Yes")){ %> checked <% } %> type="radio" id="menopause" name="menopause" value="Yes" onclick="document.getElementById('interval').disabled=this.checked;document.getElementById('mensturalOnsetSexualIntercourse').disabled=this.checked;document.getElementById('menstrualDuration').disabled=this.checked;document.getElementById('menstrualMenarche').disabled=this.checked;document.getElementById('mensturalBirthControlMethod').disabled=this.checked"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Yes</label>

                                                     </div>
                                                     <div class="col-md-3 pretty circle danger">
                                                        <input type="radio" id="menopause" name="menopause" value="No" checked onclick="$('#interval').prop('disabled', false);$('#mensturalOnsetSexualIntercourse').prop('disabled', false);$('#menstrualDuration').prop('disabled', false);$('#menstrualMenarche').prop('disabled', false);$('#mensturalBirthControlMethod').prop('disabled', false)"/><label><i class="fa fa-close"></i> &nbsp;&nbsp;No</label>

                                                     </div>
                                                </div>
                                            </div>

                                        </div>
                                        <!--row-->

                                </div> <!--x_content-->

                            </div>
                             
                             <%}%>  <!-- Closing for the if female-->
                            <!-- End of Menstrual History-->

                            <!--General-->
                            <div class="x_panel">
                               <div class="x_title">
                                   <strong>GENERAL</strong>
                               </div>
                                <div class="x_content">
                                    <!--<form action="" method="post" enctype="multipart/form-data" class="form-horizontal">-->

                                    <div class="form-group row">

                                        <div class="col-md-4">
                                            <div class="row">
                                              <div class="col-md-5">
                                               <label class="control-label">Blood Pressure </label>
                                              </div>

                                               <div class="col-md-6 pretty danger" style="font-size: 8px;">
                                               <input  type="checkbox" onclick="document.getElementById('bpNot').value=1;document.getElementById('bpSystolic').disabled=this.checked;document.getElementById('bpDiastolic').disabled=this.checked;"/><label><i class="fa fa-close" ></i> <a style="font-size:10px;">Not Applicable / Child</a></label>
                                               <input type="hidden" id="bpNot" name="bpNot" value="0">
                                               </div>

                                            </div>

                                            <div class="row" id="BloodPressure">
                                                <div class="col-md-3">
                                                    <input required class="form-control" id="bpSystolic" name="bpSystolic" type="number" placeholder="0" minlength="1" maxlength="3" size="3">
                                                    <span class="help-block">Systolic</span>
                                                </div>
                                                <div class="col-md-1">
                                                    <h2>/</h2>
                                                </div>
                                                <div class="col-md-3">
                                                    <input required class="form-control" placeholder="0" id="bpDiastolic" name="bpDiastolic" type="number" minlength="1" maxlength="3" size="3">
                                                    <span class="help-block">Diastolic</span>
                                                </div>
                                            </div> <!--row-->
                                        </div> <!--col-md-4-->
                                        
                                        
                                        <div class="col-md-2">
                                           <div class="row"> 
                                                <label class="control-label">Temperature &deg;C </label>
                                            </div>
                                            <div class="row">
                                              <div class="col-md-8">
                                                <input required class="form-control" placeholder="37" name="temperature" step="0.01" type="number" size="2">
                                              </div>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-2">
                                           <div class="row">
                                            <label class="control-label">Waist Circumference <small>(cm)</small></label>
                                           </div>
                                           
                                           <div class="row">
                                            <div class="col-md-8">
                                            <input required step="0.01" class="form-control" name="waistline" type="text" placeholder="0" minlength="1" maxlength="3" size="3">
                                            </div>
                                           </div>
                                        </div>    

                                        <div class="col-md-2">
                                           <div class="row">
                                            <label class="control-label">Height <small>(cm)</small></label>
                                           </div>
                                           <div class="row">
                                             <div class="col-md-8">
                                              <input required onkeyup="calculateBMI()" oninput="calculateBMI()" class="form-control" placeholder="0" id="height" name="height" step="0.01"  type="number" minlength="1" maxlength="3" size="3">
                                             </div>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                           <div class="row">
                                            <label class="control-label">Weight <small>(kgs)</small></label>
                                           </div>
                                           <div class="row">
                                            <div class="col-md-8">
                                              <input required onkeyup="calculateBMI()" oninput="calculateBMI()" class="form-control" placeholder="0" id="weight" name="weight" step="0.01" type="number" minlength="1" maxlength="3" size="3">
                                             </div>
                                            </div>
                                        </div>                                    

                                    </div>
                                    <!--form-group-row-->

                                    <div class="form-group row">
                                        
                                        <div class="col-md-2">
                                          <label>Smoking</label>

                                           <div class="row">
                                            <div class="col-md-5 pretty circle success">
                                                <input type="radio" id="Yes" name="smoker" value="Yes"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Yes</label>
                                             </div>
                                             <div class="col-md-5 pretty circle danger">
                                                <input checked type="radio" id="No" name="smoker" value="No"/><label><i class="fa fa-close"></i> &nbsp;&nbsp;No</label>

                                             </div>
                                          </div>
                                        </div><!--col-md-2-->
                                        
                                        <div class="col-md-2">
                                          <label>Performed Laboratory Test</label>

                                           <div class="row">
                                            <div class="col-md-4 pretty circle success">
                                                <input type="radio" id="openlabtest" name="labtest" value="Yes"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Yes</label>

                                             </div>
                                             <div class="col-md-3 pretty circle danger">
                                                <input checked type="radio" id="closelabtest" name="labtest" value="No"/><label><i class="fa fa-close"></i> &nbsp;&nbsp;No</label>

                                             </div>
                                             </div>

                                        </div><!--col-md-2-->
                                        
                                    <!--KAPAG BABAE-->
                                       <% if (currentPatient.getSex().equalsIgnoreCase("Female")){ %>
                                        <div class="col-md-2">
                                          <label>Performed Breast Exam</label>

                                           <div class="row">
                                            <div class="col-md-4 pretty circle success">
                                                <input type="radio" name="breastExam" value="Yes"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Yes</label>

                                             </div>
                                             <div class="col-md-3 pretty circle danger">
                                                <input checked type="radio" name="breastExam" value="No"/><label><i class="fa fa-close"></i> &nbsp;&nbsp;No</label>

                                             </div>
                                             </div>
                                        </div><!--col-md-2-->
                                        
                                        <div class="col-md-2">
                                          <label>Performed Pap Smear</label>

                                           <div class="row">
                                            <div class="col-md-4 pretty circle success">
                                                <input type="radio" name="aceticAcid" value="Yes"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Yes</label>

                                             </div>
                                             <div class="col-md-3 pretty circle danger">
                                                <input checked type="radio" name="aceticAcid" value="No"/><label><i class="fa fa-close"></i> &nbsp;&nbsp;No</label>

                                             </div>
                                             </div>
                                        </div><!--col-md-2-->
                                        <%}%>
                                    
                                    <!--KAPAG LALAKE-->   
                                        <% if (currentPatient.getSex().equalsIgnoreCase("Male")){ %>
                                        <div class="col-md-3">
                                          <label>Performed Digital Rectal Exam</label>

                                           <div class="row">
                                            <div class="col-md-4 pretty circle success">
                                                <input type="radio" name="rectalExam" value="Yes"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Yes</label>

                                             </div>
                                             <div class="col-md-3 pretty circle danger">
                                                <input checked type="radio" name="rectalExam" value="No"/><label><i class="fa fa-close"></i> &nbsp;&nbsp;No</label>

                                             </div>
                                             </div>
                                        </div><!--col-md-2-->
                                        
                                        <div class="col-md-1">
                                        </div>
                                        <%}%>
                                        
                                        <div class="col-md-1">
                                            <label class="control-label">BMI</label>
                                            <p id="bmiResult" name="bmiResult"></p>
                                        </div>
                                        
                                        <div class="col-md-2">
                                           <div class="row">
                                              <label class="control-label">Weight Status</label>
                                            </div>
                                            <div class="row">
                                              <p id="weightstatus" name="weightstatus1">Please complete Height and Weight.</p>
                                            </div>
                                        </div>

                                    </div>
                                    <!--form-group-row-->

                                    <div class="form-group row">

                                        <div class="col-md-12">
                                            <label class="control-label">Chief Complaints:</label>
                                            <textarea class="form-control noresize" placeholder="Complaints of Patient" cols="10" rows="5" name="complaintsOfPatient"></textarea>
                                        </div>

                                    </div>
                                    <!--form-group-row-->

                                    <div class="form-group row">
                                        <div class="col-md-3">
                                            <label class="control-label">Name of Attending Provider</label>
                                            <h3><small><%=session.getAttribute("user_fullName") %></small></h3>
                                        </div>
                                    </div>
                                    <!--form-group-row-->

                                </div> <!--x_content-->

                            </div>
                            <!--End of General-->

                            <!--Laboratory Test-->
                            <div class="x_panel" style="display:none;" id="labTestCard">
                               <div class="x_title">
                                    <strong>LABORATORY TEST</strong>

                                    <!--<label class="nav navbar-right">
                                      <input type="checkbox" class="js-switch" id="openLab" /> Performed
                                    </label>-->

                                </div>
                                <div class="x_content">

                                <div class="form-group row" >

                                    <div class="col-md-5">
                                       <div class="pretty circle success" style="font-size: 8px;">
                                        <input type="checkbox" id="labtest" name="labtestinsidebox" value="yes" /><label>
                                        <i class="fa fa-check"></i>  <a style="font-size: 13px; font-weight: bold;">Performed Laboratory Test (Inside RHU):</a> 
                                        </label>
                                       </div>

                                        <select disabled multiple="multiple" class="form-control" id="labtestinside" name="labtestinside" style="width: 100%;">

                                           <optgroup label="Hema">
                                            <option value = "1">Hgb</option>
                                            <option value = "2">Hgh</option>
                                            <option value = "3">CBC</option>
                                           </optgroup>

                                           <optgroup label="Serology">
                                            <option value = "4">Blood Typing</option>
                                            <option value = "5">HBsAg</option>
                                           </optgroup>

                                            <optgroup label="Micro">
                                            <option value = "6">UA</option>
                                            <option value = "7">FA</option>
                                           </optgroup>

                                           <optgroup label="Other">
                                            <option value = "8">Blood Chem</option>
                                            <option value = "9">Dengue NS1</option>
                                            <option value = "10">HIV Screening Test</option>
                                            <option value = "11">DDSN</option>
                                            <option value = "12">Gene Expert</option>
                                            <option value = "13">PPD</option>
                                            <option value = "14">FBS Screening</option>
                                           </optgroup>

                                        </select>
                                    </div><!--class="col-md-5"-->

                                    <div class="col-md-5">
                                       <div class="pretty circle success" style="font-size: 8px;">
                                        <input type="checkbox" id="labtest2" /><label>
                                        <i class="fa fa-check"></i>  <a style="font-size: 13px; font-weight: bold;">Performed Laboratory Test (Outside RHU):</a> 
                                        </label>
                                       </div>
                                        <input disabled type="text" id="labtestoutside" name="labtestoutside" class="form-control" placeholder="e.g. MRI" style="min-height: 38;">

                                        
                                    </div><!--class="col-md-5"-->

                                </div><!--form-group-row-->

                                <!--form-group-row-->
                                <div class="form-group row">

                                        <div class="col-md-12">
                                            <label class="control-label">Laboratory Findings/Impression:</label>
                                            <textarea class="form-control noresize" placeholder="Laboratory Findings or Impression of Patient (DOCTOR)"  cols="10" rows="5"  name="labFindings"></textarea>
                                        </div>

                                </div>
                                <!--form-group-row-->    
                                </div><!--x_content-->
                            </div>
                            <!--End of Laboratory Test-->

                            <!--Adult Immunization Card-->
                            <div class="x_panel" id="adultimmunizationcard" style="display: none;">
                            
                            <div class="x_title">
                                <strong>ADULT IMMUNIZATION</strong>
                            </div>
                            <div class="x_content">

                                <!--DAPAT MALOAD SA TABLE UNG MGA PREVIOUS IMMUNIZATIONS -->

                                <!--TABLE FORM-->
                                <div class="table-responsive">
                                <table class="table table-striped table-bordered jambo_table bulk_action" id="tbAdultImmunization">
                                   <thead>
                                    <tr class="headings">
                                        <th class="column-title">Immunization</th>
                                        <th class="column-title">Date</th>
                                        <th class="column-title">Remarks</th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                            <%
                                                ArrayList<String> vNames1 = new ArrayList<String>();
                                                ArrayList<Vaccine> vList1 = nDAO.getAllImmunzationVisitsByPatient(patientID);
                                                for (int x = 0; x < vList1.size(); x++){
                                                    vNames1.add(vList1.get(x).getName());
                                            %>

                                            <tr>
                                                <td>
                                                <div class="col-md-12">
                                                    <%=vList1.get(x).getName()%>
                                                </div>
                                               </td>
                                                <td> 
                                                <div class="col-md-12">
                                                    <%=vList1.get(x).getDate()%>
                                                </div>
                                                </td>
                                                <td> 
                                                <div class="col-md-12">
                                                    <% 
                                                    if (vList1.get(x).getRemarks() == null){
                                                    out.println("None");
                                                    }else{
                                                    out.println(vList1.get(x).getRemarks());
                                                    }
                                                    %>
                                                </div>
                                                </td>
                                            </tr>
                                            
                                            <%}%>

                                        </tbody>
                                    <!--END OF LAMAN NG IMMUNIZATION-->

                                </table>
                                </div> <!--/Table-->

                                <div class="form-group row">
                                      <div class="col-md-12">
                                        <label class="control-label">Immunization(s) Given</label>
                                        
                                <div class="x_panel">

                                    <div class="form-group row">
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="adultimmunization" id="immunhpv" autocomplete="off" value="HPV"/>
                                            <div class="btn-group">
                                                <label for="immunhpv" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">HPV</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-3 col-sm-3">
                                            <input type="checkbox" class="adultimmunization" name="adultimmunization" id="immunpneunoccal" autocomplete="off" value="Pneumococcal Vaccine"/>
                                            <div class="btn-group">
                                                <label for="immunpneunoccal" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Pneumococcal Vaccine</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="adultimmunization" id="immuntetanus" autocomplete="off" value="Tetanus Toxoid"/>
                                            <div class="btn-group">
                                                <label for="immuntetanus" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Tetanus Toxoid</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="adultimmunization" id="immunflu" autocomplete="off" value="Flu Vaccine"/>
                                            <div class="btn-group">
                                                <label for="immunflu" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Flu Vaccine</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="adultimmunization" id="immunhepab" autocomplete="off" value="Hepa B"/>
                                            <div class="btn-group">
                                                <label for="immunhepab" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Hepa B</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                </div> <!--x_panel-- immunizations given-->

                                      </div><!--col-md-12-->
                                </div>
                                <!--form gorup row-->

                                <!--REMARKS-->
                                <div class="form-group row">
                                   <div class="col-md-12">
                                        <label class="control-label">Remarks:</label>
                                    </div>
                                    <div class="col-md-12">
                                        <textarea class="form-control noresize" placeholder="Remarks on Immunization (optional)"  cols="10" rows="5" name="adultimmunizationRemarks" ></textarea>
                                    </div>

                                </div>
                                <!--form-group-row-->    

                                </div> <!--x_content-->
                            </div>
                            <!-- End of Adult Immunization-->
                                  
                            <!--Child Immunization Card-->
                            <div class="x_panel" id="childimmunizationcard" style="display: none;">
                                <div class="x_title">
                                    <strong>CHILD CARE</strong>
                                </div>
                                <div class="x_content">

                                    <!--DAPAT MALOAD SA TABLE UNG MGA PREVIOUS IMMUNIZATIONS -->

                                    <!--TABLE FORM-->
                                    <table class="table table-striped table-bordered jambo_table bulk_action" id="tbChildImmunization">
                                       <thead>
                                        <tr class="tr-header">
                                            <th>Immunization</th>
                                            <th>Date</th>
                                            <th>Remarks</th>
                                        </tr>
                                        </thead>

                                        <tbody>
                                            <%
                                                ArrayList<String> vNames = new ArrayList<String>();
                                                ArrayList<Vaccine> vList = nDAO.getAllImmunzationVisitsByPatient(patientID);
                                                for (int x = 0; x < vList.size(); x++){
                                                    vNames.add(vList.get(x).getName());
                                            %>

                                            <tr>
                                                <td>
                                                <div class="col-md-12">
                                                    <%=vList.get(x).getName()%>
                                                </div>
                                               </td>
                                                <td> 
                                                <div class="col-md-12">
                                                    <%=vList.get(x).getDate()%>
                                                </div>
                                                </td>
                                                <td> 
                                                <div class="col-md-12">
                                                    <%=vList.get(x).getRemarks()%>
                                                </div>
                                                </td>
                                            </tr>
                                            
                                            <%}%>

                                        </tbody>
                                    </table>

                                    <!--IMMUNIZATION -->
                                    <div class="form-group row">

                                      <div class="col-md-12">
                                        <label class="control-label">Immunization(s) Given</label>

                                      <div class="x_panel">
                                              <div class="x_content">

                                    <!--IMMUNIZATION 1-->        
                                   <div class="form-group col-md-3">
                                   <label>Immunization 1</label><br/>
                                   <div class="x_panel">
                                       <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("Hepa B w/in 24 hrs")){%> disabled <%}%> type="checkbox" class="immunization1" name="immunization" id="frm-test-elm-110" autocomplete="off" value="Hepa B w/in 24 hrs"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-110" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">Hepa B w/in 24 hours</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("Hepa B >= 24 hrs")){%> disabled <%}%> type="checkbox" class="immunization1" name="immunization" id="frm-test-elm-111" autocomplete="off" value="Hepa B >= 24 hrs"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-111" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">Hepa B &ge; 24 hours</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("PENTA 1")){%> disabled <%}%> type="checkbox" class="immunization1" name="immunization" id="frm-test-elm-112" autocomplete="off" value="PENTA 1"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-112" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">PENTA 1</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("OPV 1")){%> disabled <%}%> type="checkbox" class="immunization1" name="immunization" id="frm-test-elm-113" autocomplete="off" value="OPV 1"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-113" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">OPV 1</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("MCV 1")){%> disabled <%}%> type="checkbox" class="immunization1" name="immunization" id="frm-test-elm-114" autocomplete="off" value="MCV 1"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-114" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">MCV 1</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("ROTA 1")){%> disabled <%}%> type="checkbox" class="immunization1" name="immunization" id="frm-test-elm-115" autocomplete="off" value="ROTA 1"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-115" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">ROTA 1</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("PCV 1")){%> disabled <%}%> type="checkbox" class="immunization1" name="immunization" id="frm-test-elm-116" autocomplete="off" value="PCV 1"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-116" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">PCV 1</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("HEPA A")){%> disabled <%}%> type="checkbox" class="immunization1" name="immunization" id="frm-test-elm-117" autocomplete="off" value="HEPA A"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-117" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">HEPA A</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("PNEUMONIA")){%> disabled <%}%> type="checkbox" class="immunization1" name="immunization" id="frm-test-elm-118" autocomplete="off" value="PNEUMONIA"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-118" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">PNEUMONIA</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("INFLUENZA")){%> disabled <%}%> type="checkbox" class="immunization1" name="immunization" id="frm-test-elm-119" autocomplete="off" value="INFLUENZA"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-119" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">INFLUENZA</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                      <div class="form-group row"> 
                                        <div class="col-md-12 col-sm-12">
                                                <input type="checkbox" class="immunization1" name="selectallimm1" id="selectallimm1" autocomplete="off" value="INFLUENZA"/>
                                                <div class="btn-group">
                                                    <label for="selectallimm1" class="btn btn-primary">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">SELECT ALL</span>
                                                    </label>
                                                </div>
                                            </div>
                                     </div>

                                    </div><!--form-group col-md-3-->

                                    <!--SPACER-->
                                    <div class="form-group col-md-1">
                                    </div>
                                    <!--SPACER-->

                                     <!--IMMUNIZATION 2-->
                                   <div class="form-group col-md-3">
                                   <label>Immunization 2</label><br/>
                                   <div class="x_panel">
                                   <div class="form-group row">
                                        <div class="col-md-12 col-sm-12">
                                            <input <%if(vNames.contains("PENTA 2")){%> disabled <%}%> type="checkbox" class="immunization2" name="immunization" id="frm-test-elm-2" autocomplete="off" value="PENTA 2"/>
                                            <div class="btn-group">
                                                <label for="frm-test-elm-2" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">PENTA 2</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("OPV 2")){%> disabled <%}%> type="checkbox" class="immunization2" name="immunization" id="frm-test-elm-3" autocomplete="off" value="OPV 2"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-3" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">OPV 2</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("MCV 2")){%> disabled <%}%> type="checkbox" class="immunization2" name="immunization" id="frm-test-elm-4" autocomplete="off" value="MCV 2"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-4" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">MCV 2 (MMR)</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("ROTA 2")){%> disabled <%}%> type="checkbox" class="immunization2" name="immunization" id="frm-test-elm-5" autocomplete="off" value="ROTA 2"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-5" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">ROTA 2</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("PCV 2")){%> disabled <%}%> type="checkbox" class="immunization2" name="immunization" id="frm-test-elm-6" autocomplete="off" value="PCV 2"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-6" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">PCV 2</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("HEPA B2")){%> disabled <%}%> type="checkbox" class="immunization2" name="immunization" id="frm-test-elm-7" autocomplete="off" value="HEPA B2"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-7" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">HEPA B2</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div> <!--x_panel-->

                                    <div class="form-group row"> 
                                        <div class="col-md-12 col-sm-12">
                                                <input type="checkbox" class="immunization2" name="selectallimm2" id="selectallimm2" autocomplete="off" value="INFLUENZA"/>
                                                <div class="btn-group">
                                                    <label for="selectallimm2" class="btn btn-primary">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">SELECT ALL</span>
                                                    </label>
                                                </div>
                                            </div>
                                     </div>

                                   </div> <!--form-group col-md-3-->

                                    <!--SPACER-->
                                    <div class="form-group col-md-1">
                                    </div>
                                    <!--SPACER-->

                                     <!--IMMUNIZATION 3-->
                                   <div class="form-group col-md-3">
                                   <label>Immunization 3</label><br/>
                                   <div class="x_panel">
                                       <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("PENTA 3")){%> disabled <%}%> type="checkbox" class="immunization3" name="immunization" id="frm-test-elm-8" autocomplete="off" value="PENTA 3"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-8" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">PENTA 3</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("OPV 3")){%> disabled <%}%> type="checkbox" class="immunization3" name="immunization" id="frm-test-elm-9" autocomplete="off" value="OPV 3"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-9" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">OPV 3</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("PCV 3")){%> disabled <%}%> type="checkbox" class="immunization3" name="immunization" id="frm-test-elm-10" autocomplete="off" value="PCV 3"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-10" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">PCV 3</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-12 col-sm-12">
                                                <input <%if(vNames.contains("HEPA B3")){%> disabled <%}%> type="checkbox" class="immunization3" name="immunization" id="frm-test-elm-11" autocomplete="off" value="HEPA B3"/>
                                                <div class="btn-group">
                                                    <label for="frm-test-elm-11" class="btn btn-link">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">HEPA B3</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>

                                   </div> <!--x_panel-->

                                   <div class="form-group row"> 
                                        <div class="col-md-12 col-sm-12">
                                                <input type="checkbox" class="immunization3" name="selectallimm3" id="selectallimm3" autocomplete="off" value="INFLUENZA"/>
                                                <div class="btn-group">
                                                    <label for="selectallimm3" class="btn btn-primary">
                                                        <span class="fa fa-check-square-o fa-lg"></span>
                                                        <span class="fa fa-square-o fa-lg"></span>
                                                        <span class="content">SELECT ALL</span>
                                                    </label>
                                                </div>
                                            </div>
                                     </div>

                                   </div> <!--formgroup col-md-3-->


                                            </div> <!--x_content child immunization-->
                                        </div><!--x_panel child immunization-->

                                      </div><!--col-md-12-->
                                    </div>
                                    <!--form gorup row-->
                                    
                                    <div class="form-group row">
                                      <div class="col-md-12">
                                        <label class="control-label">Other(s) Given</label>
                                        
                                <div class="x_panel">

                                    <div class="form-group row">
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="immunization" id="immunVitA" autocomplete="off" value="Vitamin A"/>
                                            <div class="btn-group">
                                                <label for="immunVitA" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Vitamin A</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="immunization" id="immunIron" autocomplete="off" value="Iron"/>
                                            <div class="btn-group">
                                                <label for="immunIron" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Iron</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="immunization" id="immunMicro" autocomplete="off" value="MNP"/>
                                            <div class="btn-group">
                                                <label for="immunMicro" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Micronutrient Powder (MNP)</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="immunization" id="immundeworm" autocomplete="off" value="De-Worming Tablet"/>
                                            <div class="btn-group">
                                                <label for="immundeworm" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">De-Worming Tablet</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="immunization" id="immunORS" autocomplete="off" value="ORS"/>
                                            <div class="btn-group">
                                                <label for="immunORS" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Oral Rehydration Salts (ORS)</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="immunization" id="immunORT" autocomplete="off" value="ORT"/>
                                            <div class="btn-group">
                                                <label for="immunORT" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Oral Rehydration Therapy (ORT) with Zinc</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-md-2 col-sm-2">
                                        </div>
                                        <div class="col-md-2 col-sm-2" id="noofiron" style="display:none">
                                            <label class="control-label">No. of Iron Dose(s)</label>
                                            <input required step="0.01" class="form-control" name="dose" type="text" value="0">
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                        </div>
                                    </div>
                                    

                                </div> <!--x_panel-- immunizations given-->

                                      </div><!--col-md-12-->
                                </div>
                                <!--form gorup row-->         
                                
                                    <div class="form-group row">
                                      <div class="col-md-12">
                                        <label class="control-label">Postpartum Details</label>
                                        
                                <div class="x_panel">

                                    <div class="form-group row">
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="immunization" id="breastFed" autocomplete="off" value="Breast Fed"/>
                                            <div class="btn-group">
                                                <label for="breastFed" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Exclusively breastfed for 6 months</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="immunization" id="newBornScreened" autocomplete="off" value="New Born Screened"/>
                                            <div class="btn-group">
                                                <label for="newBornScreened" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">New born screened</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-sm-2">
                                            <input type="checkbox" class="adultimmunization" name="immunization" id="infantFood" autocomplete="off" value="Given complimentary food"/>
                                            <div class="btn-group">
                                                <label for="infantFood" class="btn btn-link">
                                                    <span class="fa fa-check-square-o fa-lg"></span>
                                                    <span class="fa fa-square-o fa-lg"></span>
                                                    <span class="content">Given complimentary food</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    

                                </div> <!--x_panel-- immunizations given-->

                                      </div><!--col-md-12-->
                                </div>
                                <!--form gorup row-->

                                    <!--REMARKS-->
                                    <div class="form-group row">
                                       <div class="col-md-12">
                                            <label class="control-label">Remarks:</label>
                                        </div>
                                        <div class="col-md-12">
                                            <textarea class="form-control noresize" placeholder="Remarks on Immunization (optional)"  cols="10" rows="5" name="childimmunizationRemarks" ></textarea>
                                        </div>

                                    </div>
                                    <!--form-group-row-->


                                </div><!--x_content-->
                            </div>
                            <!-- End of Child Immunization-->
                                
                            <!--Postpartum Card-->
                            <div class="x_panel" id="postpartumcard" style="display: none;">
                                <div class="x_title edited">
                                <strong>POSTPARTUM</strong>

                                <!--<button type="submit" class="btn btn-sm btn-primary" style="float: right"><i class="fa fa-dot-circle-o"></i> Prenatal Visit History</button>-->
                                </div>
                            <div class="x_content">

                                <div class="x_panel">
                                  <div class="x_title">
                                  <strong>Child Information</strong>
                                  </div>
                                    <!--For radios, dapat same name per choice, id and value same sa 1 choice-->
                                    <div class="x_content">
                                        <div class="form-group row">
                                            <a class="col-md-3 form-control-label" for="childName">Child's Name:</a>
                                            <div class="col-md-3">
                                                <input  type="text" id="sfname" name="childFirstName" class="form-control" placeholder="e.g. Maria">
                                                <span class="help-block">First Name</span>
                                            </div>
                                            <div class="col-md-3">
                                                <input type="text" id="smname" name="childMiddleName" class="form-control" placeholder="e.g. Josefina">
                                                <span class="help-block">Middle Name</span>
                                            </div>
                                            <div class="col-md-3">
                                                <input  type="text" id="slname" name="childLastName" class="form-control" placeholder="e.g. de la Cruz">
                                                <span class="help-block">Last Name</span>
                                            </div>
                                        </div>
                                        <!--row-->

                                        <div class="form-group row">
                                            <div class="col-md-3"></div>

                                            <div class="col-md-3">
                                                <a class="control-label">Gender </a>

                                                <div class="form-group row">
                                                    <div class="col-md-4 pretty circle success">
                                                        <input type="radio" id="issmoking" name="childSex" value="Male"/><label><i class="default"></i> Male</label>
                                                     </div>

                                                    <div class="col-md-6 pretty circle success">
                                                        <input type="radio" id="issmoking" name="childSex" value="Female"/><label><i class="default"></i> Female</label>
                                                     </div>
                                                </div>
                                            </div>
                                            <!--col-md-3-->
                                            <div class="col-md-3">
                                                <a class="control-label">Birth Length </a>
                                                <input  class="form-control noMargin" name="childBirthLength" type="text" value="" placeholder="e.g. 30">
                                            </div>
                                            <div class="col-md-3">
                                                <a class="control-label">Birth Weight </a>
                                                <input  class="form-control noMargin" name="childBirthWeight" type="text" value="" placeholder="e.g. 12">
                                            </div>

                                        </div>
                                        <!--form-grouprow-->

                                    </div>
                                    <!--x_content-->
</div>
                                <!--x_panel-->

                                    
                                <div class="x_panel">
                                  <div class="x_title">
                                  <strong>Prenatal Details</strong>
                                  </div>
                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Prenatal Delivered:</label>
                                        <div class="col-md-5">
                                            <select  name="postpartumPrenatalDelivered[]" class="form-control">
                                                <%
                                                
                                                    Prenatal prenatalDel = nDAO.getLastPrenatalVisit(patientID);
                                                %>
                                                <option value="0">N/A</option>
                                                <option value="<%=prenatalDel.getConsultation_id()%>">Prenatal ID: <%=prenatalDel.getPrenatal_id()%> Cons ID: <%=prenatalDel.getConsultation_id()%> Date: <%=prenatalDel.getDate()%></option>
                                            </select>
                                        </div>

                                        <label class="col-md-1 form-control-label">Delivery Date:</label>

                                        <div class="col-md-5">

                                         <div class="input-group date">  
                                          <input   type="text" class="form-control pull-right" id="datepicker" name="postpartumDeliveryDate" >
                                          <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                          </div>
                                          </div> 

                                        </div>

                                    </div>
                                   <!--form-group row-->

                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Place Delivered:</label>
                                        <div class="col-md-5">
                                            <select   name="postpartumPlaceDelivered[]" class="form-control">
                                              <option selected="true" disabled="disabled" value="" selected>--SELECT PLACE DELIVERED--</option>
                                                <option value="BHS">BHS</option>
                                                <option value="HOME">HOME</option>
                                                <option value="HOSPITAL">HOSPITAL</option>
                                                <option value="IN TRANSIT">IN TRANSIT</option>
                                                <option value="LYING-IN / BIRTHING CLINICS">LYING-IN / BIRTHING CLINICS</option>
                                                <option value="RHU">RHU</option>
                                                <option value="OTHERS">OTHERS</option>
                                            </select>
                                        </div>

                                        <label class="col-md-1 form-control-label">Delivery Time:</label>
                                        <div class="bootstrap-timepicker col-md-5">

                                           <div class="form-group">
                                                <div class='input-group date' >
                                                    <input  type="text" class="form-control" id="datetimepicker5" name="postpartumdeliverytime" />
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-time"></span>
                                                    </span>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <!--form-group row-->

                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Mode of Delivery:</label>
                                        <div class="col-md-5">
                                            <select  name="postpartumModeofDelivery[]" class="form-control">
                                              <option selected="true" disabled="disabled" value="" selected>--SELECT MODE OF DELIVERY--</option>
                                                <option value="Normal">NORMAL</option>
                                                <option value="Vacuum">VACUUM DELIVERY</option>
                                                <option value="Forceps">FORCEPS DELIVERY</option>
                                                <option value="Caeserian">CAESARIAN SECTION</option>
                                                <option value="With Complications">WITH COMPLICATIONS</option>
                                            </select>
                                        </div>

                                    </div>
                                    <!--form -group row-->
                                </div><!--x_panel-->

                                    <div class="x_panel">
                                       <div class="x_title">
                                      <strong>Breastfeeding</strong>
                                      </div>
                                      <div class="x_content">
                                        <div class="form-group row">

                                            <div class="col-md-4">
                                                <a class="control-label">Date Initiated Breastfeeding:</a>
                                                <div class="input-group date">  
                                                  <input type="text" class="form-control pull-right" id="datepicker4" name="dateinitiatedbreastfeeding" placeholder="(optional)">
                                                  <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                  </div>
                                                  </div>
                                            </div>

                                            <div class="col-md-4">
                                                <a class="control-label">Time Initiated Breastfeeding:</a>

                                               <div class="form-group">
                                                <div class='input-group date' >
                                                    <input type='text' class="form-control" id='datetimepicker4'name="postpartumBreastfeedTime" placeholder="(optional)"/>
                                                    <span class="input-group-addon">
                                                        <span class="glyphicon glyphicon-time"></span>
                                                    </span>
                                                </div>
                                                </div>

                                               <!--<div class="input-group">
                                                <input type="text" class="form-control timepicker" name="postpartumBreastfeedTime" id="postpartumBreastfeedTime">

                                                <div class="input-group-addon">
                                                  <i class="fa fa-clock-o"></i>
                                                </div>
                                              </div>-->

                                            </div>

                                        </div>
                                        <!--row-->
                                    </div>
                                    </div>
                                    <!--breastfeeding-->

                                    <div class="x_panel">
                                      <div class="x_title">
                                      <strong>Micronutrient Supplementation</strong>
                                      </div>
                                        
                                      <div class="x_content">
                                        <div class="form-group row">

                                            <div class="col-md-4">
                                                <a class="control-label">Date Vitamin A Given:</a>
                                                <div class="input-group date">  
                                                  <input type="text" class="form-control pull-right" id="datepicker2" name="dateVitaminAGiven" >
                                                  <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                  </div>
                                                 </div> 
                                            </div>
                                            <div class="col-md-4">
                                                <a class="control-label">Date Iron Given:</a>
                                                <div class="input-group date">  
                                                  <input type="text" class="form-control pull-right" id="datepicker7" name="dateIronGiven" placeholder="(optional)">
                                                  <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                  </div>
                                                 </div> 
                                            </div>
                                            <div class="col-md-4">
                                                <a class="control-label">No. of Iron Pills Given </a><small> (MHG):</small>
                                                <input class="form-control" type="number" value="0" name="noIron" placeholder="(optional)">
                                            </div>


                                        </div>
                                        <!--form-group-row-->
                                    </div>
                                    </div>
                                    <!--micronutrientsupplementation-->

                                    <div class="x_panel">
                                      <div class="x_title">
                                      <strong>Danger Signs</strong>
                                      </div>
                                        
                                      <div class="x_content">
                                        <div class="form-group row">

                                            <div class="col-md-4">
                                                <a class="control-label">Danger Sign(s) Mother:</a>
                                                <input type="text" id="dangersignMother" name="dangersignMother" class="form-control" placeholder="e.g. Viginal bleeding (optional)">
                                            </div>

                                            <div class="col-md-4">
                                                <a class="control-label">Danger Sign(s) Baby:</a>
                                                <input type="text" id="dangersignBaby" name="dangersignBaby" class="form-control" placeholder="e.g. Grunting (optional)">
                                            </div>

                                        </div>
                                        <!--row-->
                                    </div>
                                    </div>
                                    <!--dangersigns-->



                            </div><!--x_content-->
                            </div>
                            <!-- End of Postpartum-->
                                
                            <!--Family Planning Card-->
                            <div class="x_panel" id="familyplanningcard" style="display: none;">
                                <div class="x_title">
                                <strong>FAMILY PLANNING</strong>
                            </div>
                            <div class="x_content">
                                <div class="form-group row">

                                    <label class="col-md-2 col-form-label">Type of Client:</label>
                                    <div class="col-md-5">
                                        <select id="method_select" name="familyPlanningTypeOfClient[]" class="form-control">
                                          <option selected="true" disabled="disabled" value="" selected>--SELECT TYPE OF CLIENT--</option>
                                            <option value="Changing Clinic">Changing Clinic</option>
                                            <option value="Changing Method">Changing Method</option>
                                            <option value="Current Users">Current Users </option>
                                            <option value="New Acceptor">New Acceptor </option>
                                            <option value="Restart">Restart </option>
                                            <option value="DROP-OUT">Drop-out</option>
                                        </select>
                                    </div>

                                    <!--SPACER-->
                                    <label class="col-md-12 form-control-label"></label>
                                    <!--SPACER-->

                                    <label class="col-md-2 col-form-label">Method</label>
                                    <div class="col-md-5">
                                        <select id="methodcard" name="familyPlanningMethodType[]" class="form-control">
                                        <option selected="true" disabled="disabled" value=""> -- SELECT METHOD --</option>
                                        <option value="CONDOM">CONDOM</option>
                                        <option value="DEPO-MEDROXY PROGESTONE ACETATE(DMPA)">DEPO-MEDROXY PROGESTONE ACETATE(DMPA)</option>
                                        <option value="FEMALE STERILIZATION/BILATERAL TUBAL LIGATION">FEMALE STERILIZATION/BILATERAL TUBAL LIGATION</option><option value="famPlanMethodImplant">IMPLANT</option>
                                        <option value="INTRA-UTERINE DEVICE">INTRA-UTERINE DEVICE</option>
                                        <option value="LACTATIONAL AMENORRHEA METHOD">LACTATIONAL AMENORRHEA METHOD</option>
                                        <option value="MALE STERILIZATION/VASECTOMY">MALE STERILIZATION/VASECTOMY</option>
                                        <option value="NATURAL FAMILY PLANNING-BASAL BODY TEMPERATURE">NATURAL FAMILY PLANNING-BASAL BODY TEMPERATURE</option>
                                        <option value="NATURAL FAMILY PLANNING-CERVICAL MUCUS METHOD">NATURAL FAMILY PLANNING-CERVICAL MUCUS METHOD</option><
                                        <option value="NATURAL FAMILY PLANNING-STANDARD DAYS METHOD">NATURAL FAMILY PLANNING-STANDARD DAYS METHOD</option>
                                        <option value="NATURAL FAMILY PLANNING-SYMPOTHERMAL METHOD">NATURAL FAMILY PLANNING-SYMPOTHERMAL METHOD</option>
                                        <option value="PILLS">PILLS</option>

                                      </select>
                                    </div>

                                    <!--SPACER-->
                                    <label class="col-md-12 form-control-label"></label>
                                    <!--SPACER-->

                                   <div id="dropoutcard"  style="display: none;">
                                        <label class="col-md-2 col-form-label">If Drop-out, State Reason:</label>
                                        <div class="col-md-10">
                                            <textarea class="form-control noresize" placeholder="Reason for Drop-out" cols="10" rows="5" name="reasonForDropOut"></textarea>
                                        </div>
                                    </div>

                                    <!--SPACER-->
                                    <label class="col-md-12 form-control-label"></label>
                                    <!--SPACER-->

                                    <label class="col-md-2 col-form-label">Administered By:</label>
                                    <div class="col-md-5">
                                        <input disabled class="form-control" id="administeredby" name="administeredby" type="text" value=" <%=session.getAttribute("user_fullName") %> ">
                                    </div>

                                    <!--SPACER-->
                                    <label class="col-md-12 form-control-label"></label>
                                    <!--SPACER-->

                                </div>
                                <!--form-group-row-->

                            </div><!--x_content-->
                            </div>
                            <!--End of Family Planning-->
                            
                            <!--Prenatal Card-->
                            <div class="x_panel" id="prenatalcard" style="display: none;">
                            
                            <div class="x_title">
                                <strong>PRENATAL</strong>

                                <!--<button type="submit" class="btn btn-xs btn-primary" style="float: right"><i class="fa fa-dot-circle-o"></i> Prenatal Visit History</button>-->
                            </div>
                            <div class="x_content">

                                    <div class="form-group row">

                            <!--PRENATAL VISIT TABLE-->
                            <h2>Prenatal Visits</h2>

                            <div class="table-responsive">
                              <table class="table table-striped table-bordered jambo_table bulk_action">
                                <thead>
                                  <tr class="headings">
                                    <th class="column-title" width="15">Visit Date </th>
                                    <th class="column-title">AoG </th>
                                    <th class="column-title">Remarks </th>
                                  </tr>
                                </thead>

                                <tbody>
                                    <%
                                        ArrayList<Prenatal> prenatalList = new ArrayList();
                                        prenatalList = nDAO.getAllPrenatalVisitsByPatient(patientID);
                                        for (int x = 0; x < prenatalList.size(); x++){
                                            
                                     %>
                                  <tr class="">

                                    <td class=" "><%=prenatalList.get(x).getDate()%></td>
                                    <td class=" "><%=prenatalList.get(x).getAOG()%></td>
                                    <td class=" "><%=prenatalList.get(x).getRemarks()%></td>

                                  </tr>
                                   <%}%>
                                </tbody>
                              </table>
                            </div>
                                       
                                        <label class="col-md-2">
                                            Last Menstruation Period (LMP):</label>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <div class='input-group date' id='LMPDate'>
                                                    <% 
                                                       String lmp = nDAO.getRecentDuration(patientID);

                                                    %>
                                                    <input type='text' class="form-control" onkeyup="calculateEDC()" oninput="calculateEDC()" name="lmp" value="<%=lmp%>" id="lastMenstruationPeriod"/>
        <!--                                            single_cal1-->
                                                    <span class="input-group-addon info">
                                                       <span class="fa fa-calendar-o "></span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div><!--col-md4-->

                                        <label class="col-md-2">Expected Date of Confinement (EDC):</label>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                                <div class='input-group date' id='EDCDate'>
                                                   <input type='text' class="form-control"   name="edc" id="expectedDateConfinement"/>
                                                    <span class="input-group-addon info">
                                                       <span class="fa fa-calendar-o "></span>
                                                    </span>
                                                </div>
                                            </div>

                                        </div><!--col-md4-->

                                    </div>
                                    <!--row-->
                                    

                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Gravidity:</label>
                                        <div class="col-md-5">
                                            <input    name="gravidity" class="form-control" type="number" value="0" id="prenatalGravidity">
                                        </div>

                                        <label class="col-md-1 form-control-label">Parity:</label>
                                        <div class="col-md-5">
                                            <input   name="parity" class="form-control" type="number" value="0" id="prenatalParity">
                                        </div>

                                    </div>
                                    <!--row-->

                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Term:</label>
                                        <div class="col-md-5">
                                            <input   name="term" class="form-control" type="number" value="0" id="prenatalTerm">
                                        </div>

                                        <label class="col-md-1 form-control-label">Preterm:</label>
                                        <div class="col-md-5">
                                            <input   name="preterm" class="form-control" type="number" value="0" id="prenatalPreterm">
                                        </div>

                                    </div>
                                    <!--row-->

                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Livebirth:</label>
                                        <div class="col-md-5">
                                            <input   name="livebirth" class="form-control" type="number" value="0" id="prenataLivebirth">
                                        </div>

                                        <label class="col-md-1 form-control-label">Abortion:</label>
                                        <div class="col-md-5">
                                            <input   name="abortion" class="form-control" type="number" value="0" id="prenatalAbortion">
                                        </div>

                                    </div>
                                    <!--row-->
                                    
                                    <br><br>
                                    
                                    <div class="form-group row">

                                        <div class="col-md-4">
                                            <label class="control-label">AOG:</label>
                                            <input class="form-control noMargin" name="prenatalAOG" type="number" value="" placeholder="by weeks (optional)">
                                        </div>
                                        <div class="col-md-4">
                                            <label class="control-label">Iron:</label>
                                            <input class="form-control noMargin" name="prenatalIron" type="number" minvalue="0" value="" placeholder="No. of Iron Pills Given (optional)">
                                        </div>
                                        <div class="col-md-4">
                                            <label class="control-label">Calcium:</label>
                                            <input class="form-control noMargin" name="prenatalCalcium" type="number" value="" placeholder="No. of Calcium Given (optional)">
                                        </div>

                                    </div>
                                    <!--form-group-row-->

                                    <br>

                                    <div class="x_panel">
                                    <!--For radios, dapat same name per choice, id and value same sa 1 choice-->
                                        <div class="x_content">
                                            <div class="form-group row">
                                                <p/>
                                                <label class="col-md-2 form-control-label">Syphilis Result</label>
                                                <div class="col-md-10">
                                                    <div class="col-md-2 pretty circle danger">
                                                    <input type="radio" id="negative" name="sysphilisResult" value="Negative"/><label><i class="fa fa-close"></i>&nbsp;&nbsp;Negative</label>
                                                    </div>   

                                                    <div class="col-md-2 pretty circle success">
                                                    <input type="radio" id="positive" name="sysphilisResult" value="Positive"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Positive</label>
                                                    </div>
                                                    
                                                    <div class="col-md-2 pretty circle warning lianneedit">
                                                    <input type="radio" id="nottested" name="sysphilisResult" value="Not Tested" checked="checked"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Not Tested</label>
                                                    </div>
                                                </div> <!-- col-md-10 -->
                                            </div> <!--form-grouprow-->
                                        </div><!--x_panelblock-->
                                    </div><!--x_panel-->


                                    <div class="x_panel">
                                    <!--For radios, dapat same name per choice, id and value same sa 1 choice-->
                                        <div class="x_content">
                                            <div class="form-group row">
                                                <p/>
                                                <label class="col-md-2 form-control-label">Tetanus Toxoid (TT)</label>
                                                <div class="col-md-10">
                                                    <div class="col-md-2 pretty circle danger">
                                                        <input type="radio" id="no" name="tt" value="No" checked="checked"/><label><i class="fa fa-close"></i>&nbsp;&nbsp;No</label>
                                                    </div>   

                                                    <div class="col-md-2 pretty circle success">
                                                        <input type="radio" id="yes" name="tt" value="Yes"/><label><i class="fa fa-check"></i>&nbsp;&nbsp;Yes</label>
                                                    </div>
                                                </div> <!-- col-md-10 -->
                                            </div> <!--form-grouprow-->
                                        </div><!--x_panelblock-->
                                    </div><!--x_panel-->
                                    
                                    <div class="x_panel">
                                    <!--For radios, dapat same name per choice, id and value same sa 1 choice-->
                                        <div class="x_content">
                                            <div class="form-group row">
                                                <p/>
                                                <label class="col-md-2 form-control-label">Penicilin</label>
                                                <div class="col-md-10">
                                                    <div class="col-md-2 pretty circle danger">
                                                        <input type="radio" id="no" name="penicilin" value="No" checked="checked"/><label><i class="fa fa-close"></i>&nbsp;&nbsp;No</label>
                                                    </div>   

                                                    <div class="col-md-2 pretty circle success">
                                                        <input type="radio" id="yes" name="penicilin" value="Yes"/><label><i class="fa fa-check"></i>&nbsp;&nbsp;Yes</label>
                                                    </div>
                                                </div> <!-- col-md-10 -->
                                            </div> <!--form-grouprow-->
                                        </div><!--x_panelblock-->
                                    </div><!--x_panel-->

                                    <br>
                                    
                            <br>
 
                                   
                                    <div class="form-group row">

                                        <div class="col-md-4">
                                            <label class="control-label">Fundic Height <small>(cm)</small></label>
                                            <input class="form-control" placeholder="Fundic Height" id="prenatalFundicHeight" name="prenatalFundicHeight" type="text" minlength="1" maxlength="2" value="0">
                                        </div>
                                        <div class="col-md-4">
                                            <label class="control-label">Fetal Heart Tone</label>
                                            <input class="form-control" placeholder="Fetal Heart Tone" id="prenatalFetalHeartTone" name="prenatalFetalHeartTone" type="text" inlength="2" maxlength="3" value="0" >
                                        </div>

                                    </div>
                                    <!--form-group-row-->
                            
                            </div> <!--x_content-->
                            </div>
                            <!-- End of Prenatal-->
                           
                           <!--Tuberculosis CARD--> 
                            <div class="x_panel" id="tuberculosiscard" name="tuberculosiscard"  style="display: none;">
                            
                           <div class="x_title">
                            <strong>TUBERCULOSIS </strong> form 6A
                            <!--<button type="submit" class="btn btn-xs btn-primary" style="float: right"><i class="fa fa-dot-circle-o"></i> Tuberculosis History</button>-->
                            </div>
                            
                           <div class="x_content">
                                
                                <div class="form-group row">

                                    <label class="col-md-2 form-control-label">Date of registration:</label>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <div class='input-group date' id='date_of_registration' name="date_of_registration">
                                                <input type='text' class="form-control" />
                                                <span class="input-group-addon info">
                                                    <span class="fa fa-calendar-o "></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div><!--col-md3-->

                                    <label class="col-md-2 form-control-label">Case No.:</label>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <div class='input-group' id='case_no' name="case_no">
                                                <input type='number' class="form-control" minlength="8" maxlength="8" />
        <!--
                                                <span class="input-group-addon">
                                                    <span class="fa fa-calendar-o "></span>
                                                </span>
        -->
                                            </div>
                                        </div>
                                    </div><!--col-md3-->

                                </div><!--row-->

                                <div class="form-group row">
                                    <label class=" form-control-label col-md-2" for="source_of_patient">Source of Patient</label> 
                                    <div class="form-group col-md-4">
                                      <select class="form-control noMargin" id="source_of_patient"  >
                                        <option>Public Health Center</option>
                                        <option>Other Public Facility</option>
                                        <option>Private Facility/MD</option>
                                        <option>Community</option>
                                      </select>
                                    </div>

                                    <label class="col-md-2 form-control-label">Source Remarks:</label>
                                    <div class="col-md-4">
                                        <input class="form-control noMargin" name="source_remarks" type="text" value="" placeholder="source remark">
                                    </div>

                                </div>
                                <!--row-->

                                <br/>
                                
                                <div class="form-group row">
                                    <label class="col-md-2 form-control-label">Anatomic Site</label>
                                    <div class="col-md-4 col-sm-4">
                                        <div class="row">
                                           <div class="col-md-4 pretty circle success">
                                                <input type="radio" id="anatomic_site_p" name="anatomic_site" value="P"/><label><i class="default"></i> P</label>
                                             </div>
                                           <div class="col-md-4 pretty circle success">
                                                <input type="radio" id="anatomic_site_ep" name="anatomic_site" value="EP"/><label><i class="default"></i> EP</label>
                                             </div> 

                                        </div>
                                    </div> <!-- div anatomic site -->

                                    <label class="col-md-2 form-control-label">Baterio logical status</label>
                                    <div class="col-md-4 col-sm-4">
                                        <div class="row">
                                           <div class="col-md-4 pretty circle success">
                                                <input type="radio" id="bacterio_bc" name="bacterio_logical_status" value="BC"/><label><i class="default"></i> BC</label>
                                             </div>
                                           <div class="col-md-4 pretty circle success">
                                                <input type="radio" id="bacterio_cd" name="bacterio_logical_status" value="CD"/><label><i class="default"></i> CD</label>
                                             </div> 
                                        </div>

                                    </div> <!-- div Baterio logical status (BC/CD) -->

                                </div>  <!-- div form group row -->

                               <!--SPACER-->
                                <div class="form-group row">
                                <br/>
                                </div>
                               <!--SPACER-->

                                <div class="form-group row">
                                    <label class=" form-control-label col-md-2" for="registration_group">Registration Group</label> 
                                    <div class="form-group col-md-4">
                                      <select class="form-control noMargin" id="registration_group"  >
                                        <option>New</option>
                                        <option>Relapse</option>
                                        <option>TALF</option>
                                        <option>Treatment after Failure</option>
                                        <option>PTOU</option>
                                        <option>Other</option>
                                      </select>
                                    </div>

                                    <label class="col-md-2 form-control-label">Transfer-in (checkbox)</label>
                                    <div class="col-md-4">
                                        <input class="form-control noMargin" name="source_remarks" type="text" value="" placeholder="ASK RHU">
                                    </div>

                                </div><!-- div form group row -->

                                <div class="form-group row">
                                    <label class=" form-control-label col-md-2" for="registration_group">Treatment Regiment</label> 
                                    <div class="form-group col-md-4">
                                      <select class="form-control noMargin" id="registration_group"  >
                                        <option>CAT I</option>
                                        <option>CAT II</option>
                                      </select>
                                    </div>
                                </div><!-- div form group row -->


                                <div class="form-group row">

                                    <label class="col-md-2 form-control-label">Date Started:</label>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <div class='input-group date' id='date_started' name="date_started">
                                                <input type='text' class="form-control" />
                                                <span class="input-group-addon info">
                                                    <span class="fa fa-calendar-o "></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div><!--col-md3-->

                                </div><!-- div form group row -->

                                <div class="clearfix"></div>

                                <div class="form-group row">
                                    <label class=" form-control-label col-md-2" for="registration_group">Treatment Outcome</label> 
                                    <div class="form-group col-md-4">
                                      <select class="form-control noMargin" id="registration_group"  >
                                        <option>Cured</option>
                                        <option>Tx Completed</option>
                                        <option>Died</option>
                                        <option>Treatment Failed</option>
                                        <option>Lost to Follow-up</option>
                                        <option>Not Evaluated</option>
                                      </select>
                                    </div>

                                </div><!-- div form group row -->


                                    <!-- NO FORM GROUP TERRITORY-->

                                <label class="col-md-2 form-control-label">Result &amp; Date when PICT was done</label>
                                <div class="col-md-4">
                                    <div class="row">
                                        <div class="col-md-3 pretty circle success">
                                            <input type="radio" id="is_pict" name="is_pict" value="Yes"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Yes</label>

                                         </div>
                                         <div class="col-md-3 pretty circle danger">
                                            <input type="radio" id="is_pict" name="is_pict" value="No"/><label><i class="fa fa-close"></i> &nbsp;&nbsp;No</label>

                                         </div>
                                    </div><!--row-->
                                </div><!--col-md-4-->

                              <br>
                               
                                <div class="form-group row">
                                    <div class="col-md-12">
                                        <label class="control-label">Remarks:</label>
                                        <textarea class="form-control noresize" placeholder="Remarks" cols="10" rows="3" name="tuberculosis_remarks"></textarea>
                                    </div>
                                </div><!-- div form group row -->


                            </div> <!--x_content-->
                            </div>
                            <!-- End of Tuberculosis-->
                                
                            <!--DIAGNOSIS CARD-->
                            <div class="" id="diagnosiscard" >
                                  <div class="x_panel">
                                   <div class="x_title">
                                       <strong>DISEASE/DIAGNOSIS &amp; MEDICATION</strong> 
                                       
                                    </div>
                                    <div class="x_content">
                                        <div class="form-group row">
                                            <div class="col-md-12">
                                                <label class="control-label">Disease/Diagnosis:</label>
                                            </div>
                                            <div class="col-md-5">
                                                <select class="diagnosis-multiple" name="diagnosis" style="width: 100%;">

                                                    <%
                                                        ArrayList <Diagnosis> dList = new ArrayList();
                                                        dList = nDAO.getAllDiagnosis();
                                                    for(int x=0; x < dList.size();x++){
                                                    %>
                                                        <option value = "<%=dList.get(x).getDiagnosis_id()%>"> <%=dList.get(x).getDiagnosis()%></option>
                                                    <%}%>
                                                </select>
                                        
                                            </div>
                                        </div>
                                        <!--form-group-row-->
                                        
                                        <div class="form-group row">

                                            <div class="col-md-12">
                                                <label class="control-label">Disease/Diagnosis Remarks:</label>
                                                <textarea class="form-control noresize" placeholder="Doctor's Remarks (optional)" cols="10" rows="5" name="diagnosisRemarks" ></textarea>
                                            </div>

                                        </div>
                                        <!--form-group-row-->
                                        
                                        <div class="form-group row" id="medicationNormal" >
                                            <div class="col-md-12">
                                                <label class="control-label">Medication:</label>
                                            </div>
                                            <div class="col-md-5">
                                                <select data-placeholder="--SELECT MEDICATION (OPTIONAL)--" class="medication-multiple" multiple="multiple" name="medication" style="width: 100%;">
                                                    <%
                                                        ArrayList <Medication> medList = new ArrayList();
                                                        medList = nDAO.retrieveAllMedication();
                                                    for(int x=0; x < medList.size();x++){
                                                    %>
                                                        <option value = "<%=medList.get(x).getMedicine_id()%>"> <%=medList.get(x).getGeneric_name()%></option>
                                                    <%}%>
                                                </select>
                                        
                                            </div>
                                        </div>
                                        
                                        <div class="form-group row">
                                           <div class="col-md-12">
                                                <label class="control-label">Treatment:</label>
                                            </div>
                                            <div class="col-md-12">
                                                <textarea class="form-control noresize" placeholder="Treatment of Patient (optional)"  cols="10" rows="5" name="medOrTreat" ></textarea>
                                            </div>

                                        </div>
                                        <!--form-group-row-->
                                   
                                    </div> <!--x_content-->
                                </div><!--x_panel-->       
                            </div> <!--End of Diagnosis-->
                                  
                            <!--SCHEDULE NEXT VISIT-->                  
                            <div class="x_panel">
                                <div class="form-group row">
                                  <div class="col-md-5 pretty success">
                                      <a type="button" class="btn btn-primary" id="toggleSched" value='hide/show'><span class="glyphicon glyphicon-calendar"></span> Schedule Next Visit</a>
                                  </div>
                                </div> 
                                <!--form-group row-->

                                <div class="col-md-4" id="schedcard" style="display: none;">
                                    <label class="control-label">Date of Next Visit:</label>
                                    <div class='input-group date'>
                                        <input type='text' class="form-control" id="schedofnextvisit" name="schedofnextvisit"/>
                                        <span class="input-group-addon info">
                                           <span class="fa fa-calendar-o "></span>
                                        </span>
                                    </div>
                                </div> 
                                <!--form-group row-->
                            </div>
                                                     
                            <footer>
                                <div class="form-group" align="center">
                                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                        <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                        <button type="submit" class="btn btn-success" id="nextPage">Submit Consultation</button>
                                    </div>
                                </div>
                            </footer>

                            </div>
                            <!--row BUONG FORM-->
                        </div>
                        <!--col-md-12 BUONG FORM-->
                    </div>
                    <!--right_col-->
                </form>
            </div>
            <!--main_container-->
        </div>
        <!--container body-->

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
        <!-- bootstrap datepicker -->
        <script src="vendors/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
        <!--multipleselect-->
        <script src="vendors/bootstrap-multiselect/dist/js/bootstrap-multiselect.js"></script>

    </body>


<!--SCRIPTS-->
<script>
    $(document).ready(function () {
        $('#openlabtest').on('click', function (event) {
            $('#labTestCard').show();
        });
        $('#closelabtest').on('click', function (event) {
            $('#labTestCard').hide();
        });
    });
</script>
<script>
    $(document).ready(function () {
        $('#openreferral').on('click', function (event) {
            $('#referralCard').show();
        });
        $('#closereferral').on('click', function (event) {
            $('#referralCard').hide();
        });
    });
</script>
<!--patientSex-->
<script>
if($('.patientSex').text() == 'M') {
   $('#menstrualCard').hide(0);
}else if($('.patientSex').text() == 'male'){
    $('#menstrualCard').hide(0);
}else if($('.patientSex').text() == 'Male'){
    $('#menstrualCard').hide(0);
}
</script>
<script>
    $('#menstrualMenarche').datetimepicker({
        format: 'YYYY-MM-DD'
    });
    $('#menstrualDuration').datetimepicker({
        format: 'YYYY-MM-DD'
    });
    $('#consultationDate').datetimepicker({
        format: 'YYYY-MM-DD'
    });
    $('#schedofnextvisit').datetimepicker({
        format: 'YYYY-MM-DD'
    });
    //Timepicker
        $('.timepicker').timepicker({
          showInputs: false
        }); 
</script>
<script>
    $("#consultationDate").datepicker().datepicker("setDate", new Date());
});
</script>

<!--PATIENT INFORMATION-->
<script>
    $('.collapse').on('shown.bs.collapse', function () {
        $(this).parent().find(".glyphicon-plus").removeClass("glyphicon-plus").addClass("glyphicon-minus");
    }).on('hidden.bs.collapse', function () {
        $(this).parent().find(".glyphicon-minus").removeClass("glyphicon-minus").addClass("glyphicon-plus");
    });
</script>

<script>
$('#labtest').change(function(){
   $("#labtestinside").prop("disabled", !$(this).is(':checked'));
});
    
$('#labtest2').change(function(){
   $("#labtestoutside").prop("disabled", !$(this).is(':checked'));
});
</script>

<!--SCHED CARD-->
<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery('#toggleSched').on('click', function(event) {
            jQuery('#schedcard').toggle('show');
        });
    });
</script>

<!--LAB TEST-->
<script>
    
    $(document).ready(function() {
        $('#labtestinside').select2();
    });

    $(document).ready(function() {
        $("#labtestinside").select2({
        tags: true
        });
    });

</script>

<!--LMP DATE-->
<script>
    function calculateEDC(){
        var  a = document.getElementById('lastMenstruationPeriod').value;
        var n =  new Date(a);
        n.setDate(n.getDate() + 280);
        var y = n.getFullYear();
        var m = n.getMonth() + 1;
        var d = n.getDate();
        var date = y+"-"+m+"-"+d;

    document.getElementById('expectedDateConfinement').value = date;
    }
    
</script>

<script>
    function calculateBMI(){
        
        var height=Number(document.getElementById("height").value);
        var weight=Number(document.getElementById("weight").value);
        
        height = height / 100;
        
        //Perform calculation
         var BMI = weight / Math.pow(height, 2);
        BMI = Math.round(BMI * 100) / 100;


        //Display result of calculation
         document.getElementById("bmiResult").innerText=BMI
        
          var output = BMI
            if (output < 18.5)
                document.getElementById("weightstatus").innerText = "Underweight";
            else if (output >= 18.5 && output < 25)
                document.getElementById("weightstatus").innerText = "Normal";
            else if (output >= 25 && output < 30)
                document.getElementById("weightstatus").innerText = "Obese";
            else if (output > 30)
                document.getElementById("weightstatus").innerText = "Overweight";
            else document.getElementById("weightstatus").innerText = "Please complete Height and Weight.";
    }                              
</script>

<!-- Diagnosis Select2 -->                                  
<script>
    
    $(document).ready(function() {
        $('.diagnosis-multiple').select2();
    });

    $(document).ready(function() {
        $(".diagnosis-multiple").select2({
        tags: true
        });
    });

    $(document).ready(function() {
        $('.medication-multiple').select2();
    });

    $(document).ready(function() {
        $(".medication-multiple").select2({
        tags: true
        });
    });

</script>

<!--PURPOSE OF VISIT-->
<script>
$(document).ready(function(){
    $('input[type="radio"]').click(function(){
        if($('#adultImmunization').is(":checked")){
            $('#adultimmunizationcard').show();
            $('#diagnosiscard').hide();
            var val = $("#menopausestatus").val();
            if(val == 'Yes'){
                $("#menstrualCard").css("display", "none");
            }else{
                $('#menstrualCard').show();
            }
        } else {
            $('#adultimmunizationcard').hide();
        } 
        
        if($('#childImmunization').is(":checked")){
            $('#childimmunizationcard').show();
            $('#medicationChildren').show();
            $('#diagnosiscard').show();
            $('#medicationNormal').hide();
             var val = $("#menopausestatus").val();
            if(val == 'Yes'){
                $("#menstrualCard").css("display", "none");
            }else{
                $('#menstrualCard').show();
            }
        } else {
            $('#childimmunizationcard').hide();
            $('#medicationChildren').hide();
        } 
        
        if($('#tuberculosis').is(":checked")){
            $('#tuberculosiscard').show();
            $('#diagnosiscard').show();
            $('#medicationNormal').show();
            var val = $("#menopausestatus").val();
            if(val == 'Yes'){
                $("#menstrualCard").css("display", "none");
            }else{
                $('#menstrualCard').show();
            }
        } else {
            $('#tuberculosiscard').hide();
        } 
        
        if($('#postpartum').is(":checked")){
            $('#postpartumcard').show();
            $('#diagnosiscard').show();
            $('#menstrualCard').hide();
            $('#medicationNormal').show();
        } else {
            $('#postpartumcard').hide();
            
        } 
        
        if($('#prenatal').is(":checked")){
            $('#prenatalcard').show();
            $('#diagnosiscard').show();
            $('#menstrualCard').hide();
            $('#medicationNormal').show();
        } else {
            $('#prenatalcard').hide();
        } 
        
        if($('#familyPlanning').is(":checked")){
            $('#familyplanningcard').show();
            $('#diagnosiscard').show();
            $('#menstrualCard').hide();
            $('#medicationNormal').show();
            var val = $("#menopausestatus").val();
            if(val == 'Yes'){
                $("#menstrualCard").css("display", "none");
            }else{
                $('#menstrualCard').show();
            }
        } else {
            $('#familyplanningcard').hide();
        } 
        
        if($('#general').is(":checked")){
            $('#diagnosiscard').show();
            $('#medicationNormal').show();
             var val = $("#menopausestatus").val();
            if(val == 'Yes'){
                $("#menstrualCard").css("display", "none");
            }else{
                $('#menstrualCard').show();
            }
        } 
    });
});
</script>

<!--ADULT IMMUNIZATION-->
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

<script>
$("#selectallimm").click(function () {
$(".adultimmunization").prop('checked', $(this).prop('checked'));
});
</script>

<!--CHILD IMMUNIZATION-->
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
<script>
$(document).ready(function(){
    $('#immunIron').change(function(){
        if(this.checked)
            $('#noofiron').show();
        else
            $('#noofiron').hide();

    });
});                                                
</script>
<script type="text/javascript">
    $(document).ready(function() {
        $('.multipleselect').multiselect({
            enableCaseInsensitiveFiltering: true,
            filterBehavior: 'value',
            includeSelectAllOption: true
        });
    });
</script> 
<script>
$("#selectallimm1").click(function () {
    $('.immunization1:not(:disabled)').prop('checked', $(this).prop('checked'));
});
$("#selectallimm2").click(function () {
    $('.immunization2:not(:disabled)').prop('checked', $(this).prop('checked'));
});  
$("#selectallimm3").click(function () {
    $('.immunization3:not(:disabled)').prop('checked', $(this).prop('checked'));
});  
</script>


<!--FAMILY PLANNING--> 
<script>
$(function () {
  $("#method_select").change(function() {
    var val = $(this).val();
    if(val === "DROP-OUT") {
        $("#dropoutcard").show();
        $('#methodcard').attr('disabled', 'disabled').val('');
    }
    else {
        $("#dropoutcard").hide();
        $('#methodcard').removeAttr('disabled');
    }
  });
});                                            
</script>

<!--POSTPARTUM-->
<!--<script type="text/javascript">
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
</script>-->

<script>
$('#datepicker').datetimepicker({
    format: 'YYYY-MM-DD'
});

$('#datepicker2').datetimepicker({
    format: 'YYYY-MM-DD'
});

$('#datepicker3').datetimepicker({
    format: 'YYYY-MM-DD'
});

$('#datepicker4').datetimepicker({
    format: 'YYYY-MM-DD'
});

$('#datepicker6').datetimepicker({
    format: 'YYYY-MM-DD'
});

$('#datepicker7').datetimepicker({
    format: 'YYYY-MM-DD'
});
</script>
<script>
     //Timepicker
    $('.timepicker').timepicker({
      showInputs: true
    }); 
    
</script>
<script type="text/javascript">
    $(function () {
        $('#datetimepicker4').datetimepicker({
            format: 'HH:mm'
        });
        $('#datetimepicker5').datetimepicker({
            format: 'HH:mm'
        });
    });
</script>
   
<!--PRENATAL-->
<script>
    document.getElementById("#expectedDateConfinement").innerHTML = 5 + 6;
</script>
<script>
    document.getElementById("#edc2").innerHTML = 5 + 6;
</script>                                
                                                                
<script>
    var tD = new Date();
    tD.setDate(tD.getDate() + 4);
    var datestr = tD.getDate() 
</script>
                                            
<script>
    var edc = new Date();
    $("#expectedDateConfinement").datetimepicker().datetimepicker("setDate", 01/01/2017 + 40);
        format: 'YYYY-MM-DD'
    });
    $("#EDCDate").datetimepicker().datetimepicker("setDate", 01/01/2017);
        format: 'YYYY-MM-DD'
    });

</script>    

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

$('#LMPDate').datetimepicker({
    format: 'YYYY-MM-DD'
}).on('dp.change', function (ev) {
    calculateEDC() ;//your function call
});
    
$('#EDCDate').datetimepicker({
    format: 'YYYY-MM-DD'
});

$('#scheduleNextVisitDate').datetimepicker({
    format: 'YYYY-MM-DD'
});
</script>   

<style>
    
.pretty.warning input:checked + label i:before {
    color: #f0ad4e;
    background-color: #f0ad4e;
}
    /*Time Icon*/
.input-group-addon.time{
  padding: 6px 12px;
  font-size: 14px;
  font-weight: normal;
  line-height: 1;
  color: #555;
  text-align: center;
  background-color: white;
  border: 1px solid #ccc;
  border-radius: 4px;
}
        /* Checkbox and Radio buttons */
.form-group input[class="immunization2"], 
.form-group input[class="immunization3"],
.form-group input[class="immunization1"] {
	display: none;
    width: 100%;
}

.form-group input[class="immunization1"] + .btn-group > label.btn-link, 
.form-group input[class="immunization3"] + .btn-group > label.btn-link,
.form-group input[class="immunization2"] + .btn-group > label.btn-link {
	font-weight: normal;
	color: #428bca;
	border-radius: 0;
}
    
.form-group input[class="immunization1"][disabled] + .btn-group > label.btn-link, 
.form-group input[class="immunization3"][disabled] + .btn-group > label.btn-link,
.form-group input[class="immunization2"][disabled] + .btn-group > label.btn-link {
	font-weight: normal;
	color: #afa5a5;
	border-radius: 0;
}

.form-group input[class="immunization3"] + .btn-group > label span:first-child, 
.form-group input[class="immunization2"] + .btn-group > label span:first-child,
.form-group input[class="immunization1"] + .btn-group > label span:first-child{
	display: none;
}

.form-group input[class="immunization3"] + .btn-group > label span:first-child + span, 
.form-group input[class="immunization2"] + .btn-group > label span:first-child + span,
.form-group input[class="immunization1"] + .btn-group > label span:first-child + span{
	display: inline-block;
}

.form-group input[class="immunization1"]:checked + .btn-group > label span:first-child, 
.form-group input[class="immunization2"]:checked + .btn-group > label span:first-child,
.form-group input[class="immunization3"]:checked + .btn-group > label span:first-child{
	display: inline-block;
}

.form-group input[class="immunization1"]:checked + .btn-group > label span:first-child + span, 
.form-group input[class="immunization2"]:checked + .btn-group > label span:first-child + span,
.form-group input[class="immunization3"]:checked + .btn-group > label span:first-child + span{
	display: none;  
}
    
.form-group input[class="immunization3"] + .btn-group > label span[class*="fa-"], 
.form-group input[class="immunization1"] + .btn-group > label span[class*="fa-"],
.form-group input[class="immunization2"] + .btn-group > label span[class*="fa-"]{
	width: 15px;
	float: left;
	margin: 4px 0 2px -2px;
}

.form-group input[class="immunization3"] + .btn-group > label span.content, 
.form-group input[class="immunization1"] + .btn-group > label span.content,
.form-group input[class="immunization2"] + .btn-group > label span.content{
	margin-left: 10px;
}

.form-group input[class="adultimmunization"]{
	display: none;
    width: 100%;
}

.form-group input[class="adultimmunization"] + .btn-group > label{
	white-space: normal;
}

.form-group input[class="adultimmunization"] + .btn-group > label.btn-default{
	color: #333;
	background-color: #fff;
	border-color: #ccc;
}

.form-group input[class="adultimmunization"] + .btn-group > label.btn-primary{
	color: #fff;
	background-color: #428bca;
	border-color: #357ebd;
}

.form-group input[class="adultimmunization"] + .btn-group > label.btn-link {
	font-weight: normal;
	color: #428bca;
	border-radius: 0;
}

.form-group input[class="adultimmunization"][disabled] + .btn-group > label.btn-link {
	font-weight: normal;
	color: #afa5a5;
	border-radius: 0;
}

.form-group input[class="adultimmunization"] + .btn-group > label span:first-child{
	display: none;
}

.form-group input[class="adultimmunization"] + .btn-group > label span:first-child + span{
	display: inline-block;
}

.form-group input[class="adultimmunization"]:checked + .btn-group > label span:first-child{
	display: inline-block;
}
 
.form-group input[class="adultimmunization"]:checked + .btn-group > label span:first-child + span{
	display: none;  
}

.form-group input[class="adultimmunization"] + .btn-group > label span[class*="fa-"]{
	width: 15px;
	float: left;
	margin: 4px 0 2px -2px;
}

.form-group input[class="adultimmunization"] + .btn-group > label span.content{
	margin-left: 10px;
}
/* End::Checkbox and Radio buttons */
</style>

</html>