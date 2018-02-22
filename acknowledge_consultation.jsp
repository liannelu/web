<%@page import="Model.Patient"%>
<%@page import="Model.Prenatal"%>
<%@page import="Model.Post_partum"%>
<%@page import="Model.Family_planning"%>
<%@page import="Model.Immunization"%>
<%@page import="Model.Vaccine"%>
<%@page import="Model.User"%>
<%@page import="Model.Consultation"%>
<%@page import="Model.Diagnosis"%>
<%@page import="Model.Medication"%>
<%@page import="DAO.doctorDAO"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="DAO.userDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date;"%>
<%@page import="java.util.ArrayList"%>

<%
//check if add dosposition ba//

    /*
    int adddisposition = 0;
    if(session.getAttribute("disposition") != null){
         adddisposition = (Integer) session.getAttribute("disposition");
    }
    */
    
    int patientID = (Integer) session.getAttribute("id");
    nurseDAO nDAO = new nurseDAO();
    userDAO userDAO = new userDAO();
    Patient currentPatient = new Patient();
    currentPatient = nDAO.getPatient(patientID);

    int selectedID = (Integer) session.getAttribute("selected_consultation_id");
    Consultation selectedCons = new Consultation ();
    selectedCons = nDAO.getConsultation(selectedID);
    Prenatal p = new Prenatal ();
    Post_partum pp = new Post_partum ();
    Family_planning fp = new Family_planning ();
    Immunization i = new Immunization ();
    
    boolean isAcknowledged = false; 
    //CHECKER IF FOR ACKNOWLEDGE/ADDING DISPOSITION
    if(selectedCons.getAcknowledged_by() != 0){
        isAcknowledged = true;
    }

%>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Meta, title, CSS, favicons, etc. -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

       <%
           if(isAcknowledged == false){ %>
           <title> Acknowledge Consultation </title>
        <% } else { %>
            <title> Add Disposition </title>
       <% }  %>
      
        

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
                    <input type="hidden" name="requestSource" value="newConsultation">
                    
                    <div class="right_col edited fix" role="main">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home.jsp">  Home </a></li>
                            <li class="breadcrumb-item">Forms</li>
                            <%
                               if(isAcknowledged == false){ %>
                               <li class="breadcrumb-item active">Acknowledge Consultation</li>
                            <% } else { %>
                                <li class="breadcrumb-item active">Add Disposition</li>
                           <% }  %>
                            
                        </ol>

                        <div class="col-md-12 col-sm-12 col-xs-12">
                            
                            <div class="page-title">
                                <div class="title_left">
                                    <%
                                       if(isAcknowledged == false){ %>
                                       <h3>Acknowledge Consultation</h3>Consultation</li>
                                    <% } else { %>
                                       <h3>Add Disposition</h3>
                                   <% }  %>
                                </div>

                            </div>
                            <!--page-title-->

                            <!--I'm tired --> 
                            <%
                                /*
                                int patientID = (Integer) session.getAttribute("id");
                                nurseDAO nDAO = new nurseDAO();
                                userDAO userDAO = new userDAO();
                                Patient currentPatient = new Patient();
                                currentPatient = nDAO.getPatient(patientID);
                                
                                int selectedID = (Integer) session.getAttribute("selected_consultation_id");
                                Consultation selectedCons = new Consultation ();
                                selectedCons = nDAO.getConsultation(selectedID);
                                Prenatal p = new Prenatal ();
                                Post_partum pp = new Post_partum ();
                                Family_planning fp = new Family_planning ();
                                Immunization i = new Immunization ();
                                */
                                
                                if (selectedCons.getType_of_consultation().equalsIgnoreCase("Prenatal")){
                                    
                                    p = nDAO.getPrenatalConsultation(selectedID);
                                }else if (selectedCons.getType_of_consultation().equalsIgnoreCase("Postpartum")) {
                                    
                                    pp = nDAO.getPostpartumConsultation(selectedID);
                                }
                                else if (selectedCons.getType_of_consultation().equalsIgnoreCase("Family Planning")) {
                                    
                                    fp = nDAO.getFamilyPlanningConsultation(selectedID);
                                }
                                else if (selectedCons.getType_of_consultation().equalsIgnoreCase("Adult Immunization") || selectedCons.getType_of_consultation().equalsIgnoreCase("Child Care")) {
                                    
                                    i = nDAO.getImmunizationConsultation(selectedID);
                                }
                                
                                //CONSULTATION Added By//
                                String position ="";
                                User u = nDAO.retrieveUser(selectedCons.getAdded_by());
                                if (u.getPosition().equalsIgnoreCase("Physician")){
                                 position = "Dr.";
                                }else{
                                 position = u.getPosition();
                                }
                                String consultationaddedby = position + " " + u.getFullname();

                                //CONSULTATION Acknowledged_by
                                User u2 = new User();
                                String acknowledgedBy = "N/A";
                                if(selectedCons.getAcknowledged_by() != 0){
                                u2 = userDAO.retrieveUser(selectedCons.getAcknowledged_by());
                                acknowledgedBy = "Dr. " + u2.getFullname();
                                }
                                
                                //BIRTHDAY omg//
                                SimpleDateFormat month = new SimpleDateFormat("MMMM dd");  
                                SimpleDateFormat year = new SimpleDateFormat("yyyy"); 
                            
                                Date tempbirthday = currentPatient.getBirthdate();
                                String birthdayMonth = month.format(tempbirthday);
                                String birthdayYear = year.format(tempbirthday);
                                String birthdate = birthdayMonth + ", " + birthdayYear;
                            
                            %>

                            <input type="hidden" name="currSex" value="<%=currentPatient.getSex()%>"> <!-- for backend  -->
                            <c:set var="purpose" value="<%=selectedCons.getType_of_consultation()%>"/>
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
                                                <h3><small><%=selectedCons.getMode_of_transaction()%></small></h3>
                                            </div>
                                            <div class="col-md-3">
                                                Date of Consultation:</div>
                                            <div class="col-md-3 col-sm-3">
                                                <h3><small><%=selectedCons.getDate()%></small></h3>
                                            </div><!--col-md3-->

                                        </div>
                                        <!--row-->

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                <div class="row">
                                    
                                    <div class="col-md-2 form-control-label">Purpose of Visit:</div>
                                            
                                    <div class="col-md-3 col-sm-3">
                                        <h3><small><%=selectedCons.getType_of_consultation()%></small></h3> <!--grep, please put java code of purpose of visit-->
                                    </div>
                                    
                                    <div class="col-md-1"></div>

                                   <!--THIS IS IMPORTANT-->
                                   <c:set var="purpose" value="<%=selectedCons.getType_of_consultation()%>"/>
                                   <input type="hidden" name="purposeVisit" value="<%=selectedCons.getType_of_consultation()%>">
                                   <!--grep, please put java code of purpose of visit-->


                                    <div class="col-md-3">
                                        Consultation Time:</div>
                                    <div class="col-md-3 col-sm-3">
                                        <div class="bootstrap-timepicker form-group">

                                           <h3><small><%=selectedCons.getTime()%></small></h3>

                                        </div>
                                    </div><!--col-md3-->

                                </div>
                                <!--row-->
                                    
                                <div class="row">
                                    
                                    <div class="col-md-2 form-control-label">Nature of Visit:</div>
                                            
                                    <div class="col-md-4 col-sm-3">
                                        <h3><small>
                                        <% if(selectedCons.getNature_of_visit().equalsIgnoreCase("New Consultation")){ 
                                            out.println(selectedCons.getNature_of_visit());
                                            }else{
                                            out.println(selectedCons.getNature_of_visit() + " of"); %> <br>
                                            <% out.println(" Consultation #" + nDAO.getConsultationOfFollowup(selectedID) + " (" + nDAO.getDateofPreviousConsultationofFollowup(selectedID) +")");
                                            }
                                        %>
                                        
                                        </small></h3>
                                    </div>
                                    
                                    <div class="col-md-3 form-control-label">Added By:</div>
                                    
                                    <div class="col-md-2">
                                        <h3><small><%=consultationaddedby%></small></h3>
                                    </div>

                                </div>
                                <!--row-->
                                    
                                <div class="row">
                                    
                                    <div class="col-md-2 form-control-label">&nbsp;</div>
                                            
                                    <div class="col-md-4 col-sm-3">
                                        <h3><small>
                                        
                                        </small></h3>
                                    </div>
                                    
                                    <div class="col-md-3 form-control-label">Acknowledged By:</div>
                                    
                                    <div class="col-md-2">
                                       <% if(selectedCons.getAcknowledged_by() <= 0){ %>
                                       <h3><small>N/A</small></h3>
                                       <% } else{ %>
                                        <h3><small><%=acknowledgedBy%></small></h3>
                                       <%}%>
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
                                            <h3><small>MODE OF TRANSACTION JAVA</small></h3>
                                        </div>

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                        <label class="col-md-2 col-form-label">Referred To:</label>
                                        <div class="col-md-10">
                                            <h3><small>MODE OF TRANSACTION JAVA</small></h3>
                                        </div>

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                        <label class="col-md-2 col-form-label">Reason(s) for Referral:</label>
                                        <div class="col-md-10">
                                            <h3><small>MODE OF TRANSACTION JAVA</small></h3>
                                        </div>

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                        <label class="col-md-2 col-form-label">Referred By:</label>
                                        <div class="col-md-10">
                                            <h3><small>MODE OF TRANSACTION JAVA</small></h3>
                                        </div>

                                    </div>
                                    <!--form-group-row-->

                                    <!-- </form> -->

                                </div>

                            </div>

                            <!--Menstrual History-->
                            <%
                               if (currentPatient.getSex().equalsIgnoreCase("male") || selectedCons.getType_of_consultation().equalsIgnoreCase("Prenatal") || selectedCons.getType_of_consultation().equalsIgnoreCase("Postpartum")){
                                  
                                }else{
                                   
                             %>
                            
                            <div class="x_panel" id="menstrualCard" name="menstrualCard">
                                <div class="x_title">
                                    <strong>MENSTRUAL HISTORY</strong>
                                </div>
                                <div class="x_content">

                                         <div class="form-group row">

                                            <label class="col-md-2 form-control-label">Menarche:</label>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <div class='input-group date' id='menstrualMenarche' name="menstrualMenarche">
                                                        <h3><small><%
                                                        if(selectedCons.getMens().getMenarche()!= null){
                                                            out.println(selectedCons.getMens().getMenarche());
                                                        }else{
                                                            out.println("N/A");
                                                        }
                                                        %></small></h3>
                                                    </div>
                                                </div>
                                            </div><!--col-md3-->

                                            <label class="col-md-2 form-control-label">Period/Duration:</label>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <div class='input-group date' id='menstrualDuration' name="menstrualDuration">
                                                        <h3><small><%
                                                        if(selectedCons.getMens().getDuration()!= null){
                                                         out.println(selectedCons.getMens().getDuration());
                                                        }else{
                                                            out.println("N/A");
                                                        }
                                                        %></small></h3>
                                                    </div>
                                                </div>
                                            </div><!--col-md3-->

                                        </div><!--row-->

                                        <div class="form-group row">

                                            <label class="col-md-2 form-control-label">Onset of Sexual Intercourse:</label>
                                            <div class="col-md-4">
                                                <h3><small><%
                                                if(selectedCons.getMens().getOnset_of_sexual_intercourse()!= null){
                                                 out.println(selectedCons.getMens().getOnset_of_sexual_intercourse());
                                                }else{
                                                    out.println("N/A");
                                                }
                                                %></small></h3>
                                            </div>

                                            <label class="col-md-2 form-control-label">Birth Control Method:</label>
                                            <div class="col-md-4">
                                                <h3><small><%
                                                if(selectedCons.getMens().getBirth_control_method()!= null){
                                                 out.println(selectedCons.getMens().getBirth_control_method());
                                                }else{
                                                    out.println("N/A");
                                                }
                                                %></small></h3>
                                            </div>

                                        </div>
                                        <!--row-->

                                        <div class="form-group row">

                                            <label class="col-md-2 form-control-label">Interval/Cycle:</label>
                                            <div class="col-md-4">
                                                <h3><small><%
                                                if(selectedCons.getMens().getInterval()!= null){
                                                 out.println(selectedCons.getMens().getInterval());
                                                }else{
                                                    out.println("N/A");
                                                }
                                                %></small></h3>
                                            </div>

                                            <label class="col-md-2 form-control-label">Menopause:</label>
                                            <div class="col-md-4">
                                                <h3><small><%
                                                if(selectedCons.getMens().getMenopause()!= null){
                                                 out.println(selectedCons.getMens().getMenopause());
                                                }else{
                                                    out.println("N/A");
                                                }
                                                %></small></h3>
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

                                        <div class="col-md-5">
                                            <div class="row">
                                              <div class="col-md-6">
                                               <label class="control-label">Blood Pressure <small> (Systolic / Diastolic) </small> </label>
                                              </div>

                                               <div class="col-md-5 pretty danger" style="font-size: 10px;">
                                               <input disabled type="checkbox" id="toggleLab" onclick="document.getElementById('bpNot').value=1;document.getElementById('bpSystolic').disabled=this.checked;document.getElementById('bpDiastolic').disabled=this.checked;"/><label><i class="fa fa-close" ></i> <a style="font-size:12px;">Not Applicable / Child</a></label>
                                               <input type="hidden" id="bpNot" name="bpNot" value="0">
                                               </div>

                                            </div>

                                            <div class="row" id="BloodPressure">
                                                <div class="col-md-5">
                                                    <h3><small><%=selectedCons.getBp_s()%></small></h3>
                                                </div>
                                                <div class="col-md-1">
                                                    <h2>/</h2>
                                                </div>
                                                <div class="col-md-5">
                                                    <h3><small><%=selectedCons.getBp_d()%></small></h3>
                                                </div>
                                            </div> <!--row-->
                                        </div> <!--col-md-5-->
                                        <div class="col-md-2">
                                            <label class="control-label">Temperature &deg;C </label>
                                            <h3><small><%=selectedCons.getTemp()%></small></h3>
                                        </div>
                                        <div class="col-md-2">
                                            <label class="control-label">Height <small>(cm)</small></label>
                                            <h3><small><%=selectedCons.getHeight()%></small></h3>
                                        </div>
                                        <div class="col-md-2">
                                            <label class="control-label">Weight <small>(kgs)</small></label>
                                            <h3><small><%=selectedCons.getWeight()%></small></h3>
                                        </div>


                                    </div>
                                    <!--form-group-row-->

                                    <div class="form-group row">

                                        <div class="col-md-2">
                                          <label>Smoking</label>

                                           <h3><small><%=selectedCons.getSmoker()%></small></h3>

                                        </div><!--col-md-2-->
                                            
                                    <!--KAPAG BABAE-->   
                                    <% if (currentPatient.getSex().equalsIgnoreCase("Female")){ %>
                                        <div class="col-md-2">
                                         <label>Performed Breast Exam</label>
                                            <h3><small><%=selectedCons.getBreast_exam()%></small></h3>

                                        </div><!--col-md-2-->
                                        
                                        <div class="col-md-2">
                                          <label>Performed Pap Smear</label>
                                            <h3><small><%=selectedCons.getAcetic_acid()%></small></h3>
                                        </div><!--col-md-2-->
                                    <%}%>
                                <!--KAPAG LALAKE-->   
                                    <% if (currentPatient.getSex().equalsIgnoreCase("Male")){ %>
                                        <div class="col-md-2">
                                          <label>Performed Digital Rectal Exam</label>
                                            <h3><small><%=selectedCons.getRectal_exam()%></small></h3>
                                        </div><!--col-md-2-->
                                        
                                        <div class="col-md-1">
                                        </div>
                                    <%}%>

                                        <div class="col-md-2">
                                            <label class="control-label">Waist Circumference <small>(cm)</small></label>
                                            <h3><small><%=selectedCons.getWaistline()%></small></h3>
                                        </div>
                                        <div class="col-md-2">
                                            <label class="control-label">BMI</label>
                                            <p id="bmiResult" name="bmiResult"><h3><small><%=selectedCons.getBmi()%></small></h3></p>
                                        </div>
                                        <div class="col-md-2 weightStat">
                                            <label class="control-label">Weight Status</label>
                                            <p class="control-label" name="weightstatus1">
                                                <% if(Integer.parseInt(selectedCons.getBmi()) < 18.5){  %>
                                                    <h3><small>Underweight</small></h3>
                                                <% }else if (Integer.parseInt(selectedCons.getBmi()) > 18.5 && Integer.parseInt(selectedCons.getBmi()) < 25){ %>
                                                    <h3><small>Normal</small></h3>
                                                <% }else if (Integer.parseInt(selectedCons.getBmi()) > 25 && Integer.parseInt(selectedCons.getBmi()) < 30){ %>
                                                    <h3><small>Obese</small></h3>
                                                <% }else if (Integer.parseInt(selectedCons.getBmi()) > 30){ %>
                                                    <h3><small>Overweight</small></h3>
                                                <% } %>
                                                
                                            </p>
                                        </div>

                                    </div>
                                    <!--form-group-row-->

                                    <div class="form-group row">

                                        <div class="col-md-12">
                                            <label class="control-label">Chief Complaints:</label>
                                            <textarea class="form-control noresize" cols="10" rows="5" name="complaintsOfPatient" disabled><%=selectedCons.getChief_complaints()%></textarea></textarea>
                                        </div>

                                    </div>
                                    <!--form-group-row-->

                                    <div class="form-group row">
                                        <div class="col-md-3">
                                            <label class="control-label">Name of Attending Provider</label>
                                           <h3><small><%=nDAO.retrieveUser(selectedCons.getAdded_by()).getFullname()%></small></h3>
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
                                        <input type="checkbox" id="labtest" /><label>
                                        <i class="fa fa-check"></i>  <a style="font-size: 13px; font-weight: bold;">Performed Laboratory Test (Inside RHU):</a> 
                                        </label>
                                       </div>

                                        <select disabled multiple="multiple" class="form-control" id="labtestinside" name="labtestinside" style="width: 100%;">

                                           <optgroup label="Hema">
                                            <option value = "1">Hgb</option>
                                            <option value = "2">HCT</option>
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
                                        <input disabled type="text" id="labtestoutside" name="labtestoutside" class="form-control" placeholder="eg. MRI" style="min-height: 38;">

                                        
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

                           <% if(selectedCons.getType_of_consultation().equalsIgnoreCase("Adult Immunization")){ %>
                            <!--Adult Immunization Card-->
                            <div class="x_panel" id="adultimmunizationcard">
                            
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
                                            ArrayList<String> vName = new ArrayList<String>();
                                            ArrayList<Vaccine> vList1 = nDAO.getVaccineConsultation(selectedID);
                                            for (int x = 0; x < vList1.size(); x++){
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
                                                }%>
                                            </div>
                                            </td>
                                        </tr>

                                        <%}%>

                                    </tbody>

                                </table>
                                </div> <!--/Table-->

                                </div> <!--x_content-->
                            </div>
                            <%}%>
                            <!-- End of Adult Immunization-->
                                
                            <% if(selectedCons.getType_of_consultation().equalsIgnoreCase("Child Care")){ %>  
                            <!--Child Immunization Card-->
                            <div class="x_panel" id="childimmunizationcard">
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
                                                ArrayList<Vaccine> vList = nDAO.getVaccineConsultation(patientID);
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
                                                    <% 
                                                    if (vList.get(x).getRemarks() == null){
                                                    out.println("None");
                                                    }else{
                                                    out.println(vList.get(x).getRemarks());
                                                    }%>
                                                </div>
                                                </td>
                                            </tr>
                                            
                                            <%}%>

                                        </tbody>
                                    </table>


                                </div><!--x_content-->
                            </div>
                            <%}%>
                            <!-- End of Child Immunization-->
                                
                            <% if(selectedCons.getType_of_consultation().equalsIgnoreCase("Postpartum")){ %>
                            <!--Postpartum Card-->
                            <div class="x_panel" id="postpartumcard">
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
                                                    <h3><small><%=pp.getPp_firstname()%></small></h3>
                                                    <span class="help-block">First Name</span>
                                                </div>
                                                <div class="col-md-3">
                                                    <h3><small><%=pp.getPp_middlename()%></small></h3>
                                                    <span class="help-block">Middle Name</span>
                                                </div>
                                                <div class="col-md-3">
                                                    <h3><small><%=pp.getPp_lastname()%></small></h3>
                                                    <span class="help-block">Last Name</span>
                                                </div>
                                            </div>
                                            <!--row-->

                                            <div class="form-group row">
                                                <div class="col-md-3"></div>

                                                <div class="col-md-3">
                                                    <h3><small><%=pp.getPp_sex()%></small></h3> 
                                                    <span class="help-block">Sex</span>
                                                </div>
                                                <!--col-md-3-->
                                                <div class="col-md-3">
                                                    <h3><small><%=pp.getBirthlength()%></small></h3> 
                                                    <span class="help-block">Birth Length</span>
                                                </div>
                                                <div class="col-md-3">
                                                    <h3><small><%=pp.getBirthweight()%></small></h3> 
                                                    <span class="help-block">Birth Weight</span>
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

                                  <div class="x_content">
                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Prenatal Delivered:</label>
                                        <div class="col-md-5">
                                            <h3><small><%=pp.getPrenatal_delivered()%></small></h3>
                                        </div>

                                        <label class="col-md-1 form-control-label">Delivery Date:</label>

                                        <div class="col-md-5">

                                         <h3><small><%=pp.getDelivery_date()%></small></h3> 

                                        </div>

                                    </div>
                                   <!--form-group row-->

                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Place Delivered:</label>
                                        <div class="col-md-5">
                                            <h3><small><%=pp.getPlace_delivered()%></small></h3> 
                                        </div>

                                        <label class="col-md-1 form-control-label">Delivery Time:</label>
                                        <div class="bootstrap-timepicker col-md-5">

                                           <div class="form-group">
                                                <h3><small><%=pp.getDelivery_time()%></small></h3> 
                                            </div>

                                        </div>

                                    </div>
                                    <!--form-group row-->

                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Mode of Delivery:</label>
                                        <div class="col-md-5">
                                            <h3><small><%=pp.getMode_of_delivery()%></small></h3> 
                                        </div>

                                    </div>
                                    <!--form -group row-->
                                    </div><!--x_content-->
                                </div><!--x_panel-->

                                    <div class="x_panel">
                                      <div class="x_title">
                                      <strong>Breastfeeding</strong>
                                      </div>
                                      <div class="x_content">
                                        <div class="form-group row">

                                           <div class="col-md-4">
                                                <label class="control-label">Date Initiated Breastfeeding:</label>
                                                <h3><small>
                                                <% if (pp.getDate_initiated_breastfeeding() == null){ %>
                                                    None
                                                <% }else{
                                                out.println(pp.getDate_initiated_breastfeeding()); }%>
                                                </small></h3>
                                            </div>

                                           <div class="col-md-4">
                                                <label class="control-label">Time Initiated Breastfeeding:</label>
                                                <h3><small>
                                                <% if (pp.getTime_initiated_breastfeeding() == null){ %>
                                                    None
                                                <% }else{
                                                out.println(pp.getTime_initiated_breastfeeding()); }%>
                                                </small></h3>
                                            </div>

                                        </div>
                                        <!-- form-group-row-->
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
                                                <label class="control-label">Date Vitamin A Given:</label>
                                                <h3><small>
                                                <% if (pp.getDate_vitA() == null){ %>
                                                    None
                                                <% }else{
                                                out.println(pp.getDate_vitA()); }%>
                                                </small></h3>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="control-label">Date Iron Given:</label>
                                                <h3><small>
                                                <% if (pp.getDate_iron() == null){ %>
                                                    None
                                                <% }else{
                                                out.println(pp.getDate_iron()); }%>
                                                </small></h3>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="control-label">No. of Iron Pills Given </label><small> (MHG):</small>
                                                <h3><small>
                                                <%
                                                out.println(pp.getNum_of_iron());%>
                                                </small></h3>
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
                                                <label class="control-label">Danger Sign(s) Mother:</label>
                                                <h3><small>
                                                <% if (pp.getDanger_signs_mom().equalsIgnoreCase("") || pp.getDanger_signs_mom() == null){ %>
                                                    None
                                                <% }else{
                                                out.println(pp.getDanger_signs_mom()); }%>
                                                </small></h3>
                                            </div>

                                            <div class="col-md-4">
                                                <label class="control-label">Danger Sign(s) Baby:</label>
                                                <h3><small>
                                                <% if (pp.getDanger_signs_baby().equalsIgnoreCase("") || pp.getDanger_signs_baby() == null){ %>
                                                    None
                                                <% }else{
                                                out.println(pp.getDanger_signs_baby()); }%>
                                                </small></h3>
                                            </div>

                                        </div>
                                        <!--row-->
                                    </div>
                                    </div>
                                    <!--dangersigns-->



                            </div><!--x_content-->
                            </div><!--x_panel-->
                            <%}%>
                            <!-- End of Postpartum-->
                            
                            <% if(selectedCons.getType_of_consultation().equalsIgnoreCase("Family Planning")){ %>
                            <!--Family Planning Card-->
                            <div class="x_panel" id="familyplanningcard" >
                                <div class="x_title">
                                <strong>FAMILY PLANNING</strong>
                            </div>
                            <div class="x_content">
                              <!--  <form action="" method="post" enctype="multipart/form-data" class="form-horizontal"> -->

                                    <div class="form-group row">

                                        <label class="col-md-2 col-form-label">Type of Client:</label>
                                        <div class="col-md-5">
                                            <%=fp.getType_of_client()%>
                                        </div>

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                        <label class="col-md-2 col-form-label">Method</label>
                                        <div class="col-md-5">
                                            <%=fp.getMethod()%>
                                        </div>

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                       <div id="dropoutcard"  <% if(fp.getDrop_out_reason() !="Drop-out"){%> style="display: none;" <%}%> >
                                            <label class="col-md-2 col-form-label">If Drop-out, State Reason:</label>
                                            <div class="col-md-10">
                                                <textarea class="form-control noresize" placeholder="Reason for Drop-out" cols="10" rows="5" name="reasonForDropOut"><%=fp.getDrop_out_reason()%></textarea>
                                            </div>
                                        </div>

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                        <label class="col-md-2 col-form-label">Administered By:</label>
                                        <div class="col-md-5">
                                         <h3><small><%=nDAO.retrieveUser(selectedCons.getAdded_by()).getFullname()%></small></h3> 
                                        </div>

                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->

                                    </div>
                                    <!--form-group-row-->

                            </div><!--x_content-->
                            </div>
                            <%}%>
                            <!--End of Family Planning-->
                            
                            <% if(selectedCons.getType_of_consultation().equalsIgnoreCase("Prenatal")){ %>
                            <!--Prenatal Card-->
                            <div class="x_panel" id="prenatalcard">
                            
                            <div class="x_title">
                                <strong>PRENATAL</strong>

                                <!--<button type="submit" class="btn btn-xs btn-primary" style="float: right"><i class="fa fa-dot-circle-o"></i> Prenatal Visit History</button>-->
                            </div>
                            <div class="x_content">

                                    <div class="form-group row">
                                           
                                     <!-- PRENATAL TABLE -->
                            <h2>Prenatal Visits <small></small></h2>

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
                                               <h3><small>
                                                <%
                                                if(p.getLMP()!= null){
                                                 out.println(p.getLMP());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                                </small></h3>  
                                            </div>
                                        </div><!--col-md4-->

                                        <label class="col-md-2">Expected Date of Confinement (EDC):</label>
                                        <div class="col-md-4 col-sm-4">
                                            <div class="form-group">
                                               <h3><small>
                                                <% if(p.getEDC()!= null){
                                                 out.println(p.getEDC());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                                </small></h3>  
                                            </div>

                                        </div><!--col-md4-->

                                    </div>
                                    <!--row-->
                                    
                                    <%
                                        Prenatal prenatal = new Prenatal ();
                                        prenatal = nDAO.getFirstPrenatalVisit(patientID);
                                        boolean dispPrenatal = false;
                                        if (prenatal.getGravidity() != null) {
                                            dispPrenatal = true;
                                        }
                                    %>

                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Gravidity:</label>
                                        <div class="col-md-5">
                                          <h3><small>
                                           <%
                                                if(p.getGravidity()!= null){
                                                 out.println(p.getGravidity());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                           </small></h3>     
                                        </div>

                                        <label class="col-md-1 form-control-label">Parity:</label>
                                        <div class="col-md-5">
                                          <h3><small>
                                           <%
                                                if(p.getParity()!= null){
                                                 out.println(p.getParity());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                            </small></h3>    
                                        </div>

                                    </div>
                                    <!--row-->

                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Term:</label>
                                        <div class="col-md-5">
                                          <h3><small>
                                           <%
                                                if(p.getTerm()!= null){
                                                 out.println(p.getTerm());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                               </small></h3>
                                        </div>

                                        <label class="col-md-1 form-control-label">Preterm:</label>
                                        <div class="col-md-5">
                                          <h3><small>
                                           <%
                                                if(p.getPreterm()!= null){
                                                 out.println(p.getPreterm());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                               </small></h3>
                                        </div>

                                    </div>
                                    <!--row-->

                                    <div class="form-group row">

                                        <label class="col-md-1 form-control-label">Livebirth:</label>
                                        <div class="col-md-5">
                                          <h3><small>
                                           <%
                                                if(p.getLivebirth()!= null){
                                                 out.println(p.getLivebirth());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                            </small></h3>
                                        </div>

                                        <label class="col-md-1 form-control-label">Abortion:</label>
                                        <div class="col-md-5">
                                          <h3><small>
                                           <%
                                                if(p.getAbortion()!= null){
                                                 out.println(p.getAbortion());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                             </small></h3>   
                                        </div>

                                    </div>
                                    <!--row-->
                                    
                                    <br><br>
                                    <div class="form-group row">

                                        <div class="col-md-4">
                                            <label class="control-label">AOG:</label>
                                            <h3><small>
                                            <%
                                                if(p.getAOG()!= null){
                                                 out.println(p.getAOG());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                             </small></h3>   
                                        </div>
                                        <div class="col-md-4">
                                            <label class="control-label">Iron:</label>
                                            <h3><small>
                                            <%
                                                if(p.getIron()!= null){
                                                 out.println(p.getIron());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                             </small></h3>   
                                        </div>
                                        <div class="col-md-4">
                                            <label class="control-label">Calcium:</label>
                                            <h3><small>
                                            <%
                                                if(p.getCalcium()!= null){
                                                 out.println(p.getCalcium());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                              </small></h3>  
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
                                                    <input disabled <%if (p.getSyphilis_res().equalsIgnoreCase("Negative")){ %> checked <% } %> type="radio" id="negative" name="sysphilisResult" value="Negative"/><label><i class="fa fa-close"></i>&nbsp;&nbsp;Negative</label>
                                                    </div>   

                                                    <div class="col-md-2 pretty circle success">
                                                    <input disabled <%if (p.getSyphilis_res().equalsIgnoreCase("Positive")){ %> checked <% } %> type="radio" id="positive" name="sysphilisResult" value="Positive"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Positive</label>
                                                    </div>
                                                        
                                                    <div class="col-md-2 pretty circle warning lianneedit">
                                                    <input disabled <%if (p.getSyphilis_res().equalsIgnoreCase("Positive")){ %> checked <% } %> type="radio" id="nottested" name="sysphilisResult" value="Not Tested"/><label><i class="fa fa-check"></i> &nbsp;&nbsp;Not Tested</label>
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
                                                        <input disabled <%if (p.getTT().equalsIgnoreCase("No")){ %> checked <% } %> type="radio" id="no" name="tt" value="No"/><label><i class="fa fa-close"></i>&nbsp;&nbsp;No</label>
                                                    </div>   

                                                    <div class="col-md-2 pretty circle success">
                                                        <input disabled <%if (p.getTT().equalsIgnoreCase("Yes")){ %> checked <% } %> type="radio" id="no" name="tt" value="Yes"/><label><i class="fa fa-plus"></i>&nbsp;&nbsp;Yes</label>
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
                                                        <input disabled <%if (p.getPenicillin().equalsIgnoreCase("No")){ %> checked <% } %> type="radio" id="no" name="penicilin" value="No"/><label><i class="fa fa-close"></i>&nbsp;&nbsp;No</label>
                                                    </div>   

                                                    <div class="col-md-2 pretty circle success">
                                                        <input disabled <%if (p.getPenicillin().equalsIgnoreCase("Yes")){ %> checked <% } %> type="radio" id="yes" name="penicilin" value="Yes"/><label><i class="fa fa-check"></i>&nbsp;&nbsp;Yes</label>
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
                                            <h3><small>
                                                <%=p.getFundic_height()%>
                                                </small></h3>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="control-label">Fetal Heart Tone</label>
                                            <h3><small>
                                                <% if(p.getFetal_heart_tone()!= null){
                                                 out.println(p.getFetal_heart_tone());
                                                }else{
                                                    out.println("N/A");
                                                }%>
                                                </small></h3>
                                        </div>

                                    </div>
                                    <!--form-group-row-->
                            
                            </div> <!--x_content-->
                            </div>
                            <%}%>
                            <!-- End of Prenatal-->
                           
                           <% if(selectedCons.getType_of_consultation().equalsIgnoreCase("Tuberculosis")){ %>
                           <!--Tuberculosis CARD--> 
                            <div class="x_panel" id="tuberculosiscard" name="tuberculosiscard" >
                            
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
                            <%}%>
                            <!-- End of Tuberculosis-->
                                
                            <!--DIAGNOSIS CARD-->
                            <form action="AcknowledgeConsultation" id="AcknowledgeConsultation" method="post">
                            <div class="" id="diagnosiscard" <% if(selectedCons.getType_of_consultation().equalsIgnoreCase("Adult Immunization")){ %> style="display: none;" <%}%> >
                                  <div class="x_panel">
                                   <div class="x_title">
                                       <strong>DIAGNOSIS &amp; MEDICATION</strong> 
                                    </div>
                                    <div class="x_content">
                                        <div class="form-group row">
                                            <div class="col-md-12">
                                                <label class="control-label">Diagnosis:</label>
                                            </div>
                                            <div class="col-md-5">
                                <%
                                    if(isAcknowledged == true){ %>
                                        <h3><small><%=nDAO.getDiagnosis(selectedCons.getDiagnosis()).getDiagnosis()%></small></h3>
                                <% } else { %>
                                       <select class="diagnosis-multiple" name="diagnosis" style="width: 100%;">
                                            <option value = "<%=selectedCons.getDiagnosis()%>"> <%=nDAO.getDiagnosis(selectedCons.getDiagnosis()).getDiagnosis()%></option>
                                            <%
                                                ArrayList <Diagnosis> dList = new ArrayList();
                                                dList = nDAO.getAllDiagnosis();
                                            for(int x=0; x < dList.size();x++){
                                            %>
                                                <option value = "<%=dList.get(x).getDiagnosis_id()%>"> <%=dList.get(x).getDiagnosis()%></option>
                                            <%}%>
                                        </select>
                                <% } %>
                                            </div>
                                        </div>
                                        <!--form-group-row-->
                                        
                                        <div class="form-group row">

                                            <div class="col-md-12">
                                                <label class="control-label">Diagnosis Remarks:</label>
                            <%
                                if(isAcknowledged == true){ %>
                                 <textarea readonly class="form-control noresize" cols="10" rows="5" name="diagnosisRemarks"><%=selectedCons.getRemarks()%></textarea>                            
                            <% } else { %>
                                <textarea class="form-control noresize" cols="10" rows="5" name="diagnosisRemarks"><%=selectedCons.getRemarks()%></textarea>           
                            <% } %>
                                            </div>

                                        </div>
                                        <!--form-group-row-->
                                        
                                        <div class="form-group row" id="medicationNormal" >
                                            <div class="col-md-12">
                                                <label class="control-label">Medication:</label>
                                            </div>
                                            <div class="col-md-5">
                                               <h3><small>
                                                <%
                                            
                                                 for (int x = 0; x < selectedCons.getMedications().size(); x++){       //the Lab services performed
                                                %>
                                                    <% if(selectedCons.getMedications().get(x).getGeneric_name() == ""){
                                                        out.println("N/A");
                                                    }else{
                                                     out.println(selectedCons.getMedications().get(x).getGeneric_name()+", ");
                                                    }
                                                    %>
                                            <%}%> 
                                            </small></h3>
                                            </div>
                                        </div>
                                        
                                        
                                        <div class="form-group row">
                                           <div class="col-md-12">
                                                <label class="control-label">Treatment:</label>
                                            </div>
                                            <div class="col-md-12">
                                                <textarea class="form-control noresize" cols="10" rows="5" name="medOrTreat" disabled><%=selectedCons.getTreatment()%></textarea>
                                            </div>

                                        </div>
                                        <!--form-group-row-->
                                   
                                    </div> <!--x_content-->
                                </div><!--x_panel-->       
                            </div>
                            <!--End of Diagnosis-->
                             </form> 
                                  
                            <!--SCHEDULE NEXT VISIT-->                  
                            <div class="x_panel">
                                <div class="x_title">
                                    <label>SCHEDULE OF NEXT VISIT</label>
                                </div>
                                <!--form-group row-->

                               <div class="col-md-4" id="schedcard">
                                    <label class="control-label">Date of Next Visit:</label>
                                    <% if(selectedCons.getSchcedule_of_next_visit() == null){ %>
                                       
                                       <h3><small>
                                        <% out.println("None"); %>
                                       </small></h3>
                                       
                                    <% }else{ %>
                                    
                                    <h3><small><%=selectedCons.getSchcedule_of_next_visit()%></small></h3>
                                    
                                    <%}%>
                                </div> 
                                <!--form-group row-->
                            </div><!--End of Sched next Visit-->
                            
                                     
                            
                            <form action="AddDisposition" id="AddDisposition" method="post"> 
                            <!--DISPOSITION-->    
                            <%
                               if(isAcknowledged == true){ %>
                                <div class="x_panel">
                                <div class="x_title">
                                    <label>DISPOSITION</label>
                                </div>

                               <div class="form-group row">

                                    <label class="col-md-2 ">Condition</label>
                                    <div class="col-md-8 btn-group" data-toggle="buttons">
                                        <label class="btn btn-success">
                                            <input type="radio" name="condition" value="Recovered"> Recovered
                                        </label>
                                        <label required class="btn btn-info" >
                                            <input type="radio" name="condition" value="Improved"> Improved
                                        </label>
                                        <label class="btn btn-primary">
                                            <input type="radio" name="condition" value="No Improvement"> No Improvement
                                        </label>
                                        <label class="btn btn-warning">
                                            <input type="radio" name="condition" value="Worsened"> Worsened
                                        </label>
                                        <label class="btn btn-danger">
                                            <input type="radio" name="condition" value="Died"> Died
                                        </label>
                                    </div>

                                    <!--SPACER-->
                                    <label class="col-md-12 form-control-label"><br></label>
                                    <!--SPACER-->

                                    <label class="col-md-2 col-form-label">Date and Time:</label>
                                    <div class="col-md-4">
                                       
                                        <div class="form-group">
                                            <div class='input-group date'>
                                                <input type='text' class="form-control pull-right" id="dispositiondate" name="dispositiondate" >

                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                            </div>
                                        </div>
                                        
                                   </div>
                                        
                                    <div class="col-md-3">
                                        <div class="bootstrap-timepicker form-group">
                                           <div class="input-group">
                                            <input type="text" class="form-control" name="dispositiontime" id="datetimepicker4"/>

                                            <span class="input-group-addon">
                                              <i class="fa fa-clock-o"></i>
                                            </span>
                                          </div>
                                        </div>
                                        
                                    </div>
                                   
                                    <!--SPACER-->
                                    <label class="col-md-12 form-control-label"></label>
                                    <!--SPACER-->

                                    <label class="col-md-2 col-form-label">Notes:</label>
                                    <div class="col-md-10">
                                            <textarea class="form-control noresize" placeholder="Disposition Notes" cols="10" rows="5" name="dispositionnotes"></textarea>
                                        </div>

                                    <!--SPACER-->
                                    <label class="col-md-12 form-control-label"></label>
                                    <!--SPACER-->

                                </div>
                                <!--form-group-row-->    
                            </div>
                            <% } %> <!--End of Disposition-->
                            </form>
                                    
                                                     
                            <footer>
                                <div class="form-group" align="center">
                                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                        <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>

                                       <%
                                         if(isAcknowledged == false){ %>
                                        <a class="btn btn-success" onclick="document.getElementById('AcknowledgeConsultation').submit()" id="nextPage">Acknowledge</a>
                                       <% } else { %>
                                        <a class="btn btn-success" onclick="document.getElementById('AddDisposition').submit()" id="nextPage2">Add Disposition</a>
                                       <% } %> 
                                    </div>
                                </div>
                            </footer>
        
                            </div>
                            <!--row BUONG FORM-->
                        </div>
                        <!--col-md-12 BUONG FORM-->
                    </div>
                    <!--right_col-->
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
<!--DISPOSITION-->
<script>
$('#dispositiondate').datetimepicker({
    format: 'YYYY-MM-DD'
});
</script>
<script type="text/javascript">
    $(function () {
        $('#dispositiontime').datetimepicker({
            format: 'HH:mm'
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
        } else {
            $('#adultimmunizationcard').hide();
        } 
        
        if($('#childImmunization').is(":checked")){
            $('#childimmunizationcard').show();
            $('#medicationChildren').show();
            $('#diagnosiscard').show();
            $('#medicationNormal').hide();
        } else {
            $('#childimmunizationcard').hide();
            $('#medicationChildren').hide();
            $('#medicationNormal').show();
        } 
        
        if($('#tuberculosis').is(":checked")){
            $('#tuberculosiscard').show();
            $('#diagnosiscard').show();
        } else {
            $('#tuberculosiscard').hide();
        } 
        
        if($('#postpartum').is(":checked")){
            $('#postpartumcard').show();
            $('#diagnosiscard').show();
        } else {
            $('#postpartumcard').hide();
        } 
        
        if($('#prenatal').is(":checked")){
            $('#prenatalcard').show();
            $('#diagnosiscard').show();
        } else {
            $('#prenatalcard').hide();
        } 
        
        if($('#familyPlanning').is(":checked")){
            $('#familyplanningcard').show();
            $('#diagnosiscard').show();
        } else {
            $('#familyplanningcard').hide();
        } 
        
        if($('#general').is(":checked")){
            $('#diagnosiscard').show();
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
    $(".immunization1").prop('checked', $(this).prop('checked'));
});
$("#selectallimm2").click(function () {
    $(".immunization2").prop('checked', $(this).prop('checked'));
});  
$("#selectallimm3").click(function () {
    $(".immunization3").prop('checked', $(this).prop('checked'));
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
});

$('#scheduleNextVisitDate').datetimepicker({
    format: 'YYYY-MM-DD'
});
</script>   

<style>
    
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