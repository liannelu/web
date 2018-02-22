<%@page import="Model.Patient"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="Model.User"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date;"%>


<body class="nav-md footer_fixed">
    <div class="container body">
        <div class="main_container">

        <!--START OF PAGE CONTENT-->

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
            
            <!--PATIENT DETAILS-->
            <div class="x_panel" role="patientinformation">
                <div class="x_title">
                   <form action="PatientProfile" method="post">
                    <h4><i class="fa fa-info-circle"></i>
                    <!--get information from database!!-->
                    <strong> PATIENT INFORMATION</strong>
                    <!-- Elements-->
                    
                    <ul class="nav navbar-right panel_toolbox">
                    
                     <%
                    if(!(currentPatient.getStatus().equalsIgnoreCase("Dead"))){ %>
                     <li><button type="submit" name="edit_patient" value="<%=patientID%>" class="btn btn-sm btn-warning">
                     <i class="fa fa-edit"></i> Edit Patient Profile</button></li>
                     <%}%>
                     
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                    </ul>
                    
                    <input type="hidden" name="edit_patient_profile" value="<%=patientID%>">
                    </form>
                </div>

                <div class="x_content">

                    <div class="col-md-6 col-sm-6 col-xs-12 left">
                        <h3>
                            <a href="itr.jsp" ><%= currentPatient.getFullname() %></a
                            &nbsp; <small> (Family #<%=currentPatient.getFamily_num() %>)</small>
                            
                        </h3>
                        <% if (currentPatient.getStatus().equalsIgnoreCase("Alive")){ %>
                                <div class="col-md-2"> <span class="label label-success" style="display: block;"> Alive </span> </div>
                            <%}
                            else if (currentPatient.getStatus().equalsIgnoreCase("Dead")){ %>
                                <div class="col-md-2"> <span class="label label-danger" style="display: block;"> Dead </span> </div>
                            <%}
                            else if (currentPatient.getStatus().equalsIgnoreCase("Pregnant")){ %>
                                <div class="col-md-2"> <span class="label label-info" style="display: block;"> Pregnant </span> </div>
                            <%}
                            else { %>
                                <div class="col-md-2"> <span class="label label-danger" style="display: block;"> WALA PA STATUS </span> </div>
                            <%}%>
                        <h6> 
                            <strong> <label class="patientSex" id="patientSex"><%= currentPatient.getSex() %></label> | <label class="patientAge"><%= currentPatient.getAge() %></label> years old | <label class="patientBirthday"><%= birthdate%></label></strong>
                        </h6>
                    </div>

                    <div class="col-md-6 col-sm-6 col-xs-12 right"  style="margin-top: 3em;">
                        <h6 style="float: right">
                            <label>Last Consultation:</label> 
                            <% if (nDAO.getLastConsultationDateOfPatient(patientID) == null){ out.println("None");} else{
                            
                             out.println(nDAO.getLastConsultationDateOfPatient(patientID)); }%> <br>
                            <label>Patient Added By:</label> <%=name_addedby%> (<%=currentPatient.getDate_added()%>) <br>
                            <label>Patient ID: </label><%= currentPatient.getPatient_id() %>

                        </h6>
                    </div>

                    <!--SPACER-->
                    <label class="col-md-12 form-control-label"></label>
                    <!--SPACER-->

                    <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">
                        <!--BACKGROUND-->
                        <div class="col-md-6 col-sm-6 col-xs-12 profile_left">
                            <div class="panel">
                                <a class="panel-heading" role="tab" id="headingOne" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    <h6 class="panel-title"><span class="glyphicon glyphicon-minus" style="font-size: 10px;"></span>&nbsp;<i class="fa fa-book"></i>
                                        <strong>Background</strong> 
                                    </h6>
                                </a>
                                <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                    <div class="panel-body">

                                        <label class="col-md-3 col-form-label">Family Member:</label>
                                        <div class="col-md-9">
                                            <p class="form-control-static"><%= currentPatient.getFamily_member() %></p>
                                        </div>

                                        <label class="col-md-3 col-form-label">Birthplace:</label>
                                        <div class="col-md-9">
                                            <p class="form-control-static"><%= currentPatient.getBirthplace() %></p>
                                        </div>

                                        <label class="col-md-3 col-form-label">Civil Status:</label>
                                        <div class="col-md-9">
                                            <p class="form-control-static"><%= currentPatient.getCivil_status() %></p>
                                        </div>

                                        <label class="col-md-3 col-form-label">Educational Attainment:</label>
                                        <div class="col-md-9">
                                            <p class="form-control-static"><%= currentPatient.getEducational_attainment() %></p>
                                        </div>

                                        <label class="col-md-3 col-form-label">Employment Status:</label>
                                        <div class="col-md-9">
                                            <p class="form-control-static"><%= currentPatient.getEmployment_status() %></p>
                                        </div>
                                    </div><!--panel-body-->
                                </div><!--collapseOne-->
                            </div><!--panel-->
                        </div><!--col-md-6 profile_left BACKGROUND-->
                        
                        <!--Health Information-->
                        <div class="col-md-6 col-sm-6 col-xs-12 profile_right">
                            <div class="panel">
                                <a class="panel-heading" role="tab" id="headingFour" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="true" aria-controls="collapseFour">
                                    <h6 class="panel-title"><span class="glyphicon glyphicon-minus" style="font-size: 10px;"></span>&nbsp;<i class="fa fa-heartbeat"></i>
                                        <strong>Health Information &amp; Medical History</strong> 
                                    </h6>
                                </a>
                                <div id="collapseFour" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingFour">
                                    <div class="panel-body">
                                        <label class="col-md-3 col-form-label">Blood Type:</label>
                                        <div class="col-md-9">
                                            <p class="form-control-static"><%= currentPatient.getBloodtype() %></p>
                                        </div>
                                        
                                    <% if(currentPatient.getSex().equalsIgnoreCase("Female") && nDAO.getMenopauseStatus(patientID).equalsIgnoreCase("Yes") ){ %>
                                        <label class="col-md-3 col-form-label">Menopause:</label>
                                        <div class="col-md-9">
                                            <p class="form-control-static">Yes</p>
                                        </div>
                                    <% } %>
                                        
                                    <% if(currentPatient.getDiabetes_history() != null && currentPatient.getDiabetes_history().equalsIgnoreCase("Yes")){ %>
                                        <label class="col-md-3 col-form-label">Diabetes:</label>
                                        <div class="col-md-9">
                                            <p class="form-control-static">Yes</p>
                                        </div>
                                    <% } %>
                                        
                                    <% if(currentPatient.getHypertension_history() != null && currentPatient.getHypertension_history().equalsIgnoreCase("Yes")){ %>
                                        <label class="col-md-3 col-form-label">Hypertension:</label>
                                        <div class="col-md-9">
                                            <p class="form-control-static">Yes</p>
                                        </div>
                                    <% } %>

                                    </div><!--panel-body-->
                                </div><!--collapseFour-->
                            </div><!--panel-->
                        </div><!--col-md-6 profile_left BACKGROUND-->
                                
                        <br>
                                
                        <!--ADDRESS & CONTACT -->
                        <div class="col-md-6 col-sm-6 col-xs-12 profile_left">
                            <div class="panel">
                                <a class="panel-heading collapsed" role="tab" id="headingTwo" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    <h6 class="panel-title">
                                        <span class="glyphicon glyphicon-plus" style="font-size: 10px;"></span>&nbsp;<i class="fa fa-phone-square"></i>
                                        <strong>Address &amp; Contact Information</strong> 
                                    </h6>
                                </a>
                                <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                    <div class="panel-body">
                                        <label class="col-md-2 col-form-label">Address:</label>
                                        <div class="col-md-10">
                                            <p class="form-control-static"><%= currentPatient.getAddress() %></p>
                                        </div>

                                        <label class="col-md-2 col-form-label">Barangay:</label>
                                        <div class="col-md-10">
                                            <p class="form-control-static"><%= currentPatient.getBarangay() %></p>
                                        </div>

                                        <label class="col-md-2 col-form-label">Contact No:</label>
                                        <div class="col-md-10">
                                            <p class="form-control-static"><%= currentPatient.getContact_num() %></p>
                                        </div>
                                        <!--SPACER-->
                                        <label class="col-md-12 form-control-label"></label>
                                        <!--SPACER-->
                                        <label class="col-md-2 col-form-label">Email:</label>
                                        <div class="col-md-10">
                                            <p class="form-control-static"><%= currentPatient.getEmail() %></p>
                                        </div>
                                        <label class="col-md-2 col-form-label">Household Number:</label>
                                        <div class="col-md-10">
                                            <p class="form-control-static"><%= currentPatient.getFamily_household_num() %></p>
                                        </div>
                                        
                                    </div><!--panel-body-->
                                </div><!--collapseTwo-->
                            </div><!--panel-->
                        </div><!--col-md- profile_left-->

                        <!--MEMBERSHIP-->
                        <div class="col-md-6 col-sm-6 col-xs-12 profile_right">
                            <div class="panel">
                                <a class="panel-heading collapsed" role="tab" id="headingThree" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                    <h5 class="panel-title">
                                        <span class="glyphicon glyphicon-plus" style="font-size: 10px;"></span>&nbsp;
                                        <i class="fa fa-user"></i> <strong>Membership</strong> 
                                    </h5>
                                </a>
                                <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                        <label class="col-md-4 col-form-label">DHWD NHTS:</label>
                                        <div class="col-md-8">
                                            <p class="form-control-static"><%= currentPatient.getDswd_nhts() %></p>
                                        </div>

                                        <label class="col-md-4 col-form-label">4Ps Member:</label>
                                        <div class="col-md-8">
                                            <p class="form-control-static"><%= currentPatient.getFourps_member() %></p>
                                        </div>

                                        <label class="col-md-4 col-form-label">Philhealth No:</label>
                                        <div class="col-md-8">
                                            <%
                   if (currentPatient.getPhilhealth_member().equalsIgnoreCase("yes")){%>
                                            <p class="form-control-static"><%= currentPatient.getStatus_type() %> - <%= currentPatient.getPhilhealth_num() %></p>
                                            <p class="form-control-static"><%= currentPatient.getMember_category() %></p>
                                            <%}else{%>
                                            <p class="form-control-static">Non-member</p>
                                            <%}%>
                                        </div>

                                    </div><!--panel-body-->
                                </div><!--collapseThree-->
                            </div>
                        </div><!--col-md-6 profile_left-->
                    </div> <!--accordion-->

                    


                </div><!--x_content all-->

            </div>
          
            
        </div><!--main_container-->
    </div><!--container body-->
    

</body>
  
<script>
    jQuery('document').ready(function() {
    jQuery('#accordion').on('show hide', function() {
        jQuery(this).css('height', 'auto');
    });
    jQuery('#accordion').collapse({ parent: true, toggle: true }); 
});                            
</script>
   

