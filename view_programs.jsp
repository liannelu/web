<%@page import="Model.Patient"%>
<%@page import="Model.Program"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="java.util.ArrayList"%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> View Programs </title>

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
    <!-- starRating -->
    <link href="vendors/bootstrap-star-rating/css/star-rating.css" rel="stylesheet">
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
        <%}%></li>
                    <li class="breadcrumb-item"> View </li>
                   <li class="breadcrumb-item active"> Programs</li>
                </ol>   
                    <!-- <div class="row">-->
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        
                        <!--banner-->
                         <%
                            String error=(String)request.getAttribute("error");  
                            if(error!=null){
                         %> 
                            <div class="alert alert-danger alert-dismissible fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><i class="fa fa-close"></i>
                            </button>
                            <h2><span class="fa fa-exclamation"></span> <%=error%></h2>
                          </div>
                         <%}%>
                         <%
                            String success=(String)request.getAttribute("success");  
                            if(success!=null){
                         %>
                           <div class="alert alert-success alert-dismissible fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><i class="fa fa-close"></i>
                            </button>
                            <h2><span class="fa fa-check-circle"></span> <%=success%></h2>
                          </div>
                          <%}%>
                          <!--banner-->

                        <div class="page-title">
                            <div class="title_left">
                                <h3><i class="fa fa-book"></i> View Programs</h3>        
                            </div>

                        </div>
                        <!--p   age-title-->

                       
                       <!--ALL PROGRAMS TABLE-->
                        <div class="x_panel">
                            <div class="x_title">
                                <h4><i class="fa fa-book"></i>
                                <!--get information from database!!-->
                                <strong> All Programs </strong> 
                                <!-- Elements-->
                                    <button  onClick="window.location='program_planning_without_disease.jsp';" type="submit" class="btn btn-sm btn-primary" style="float: right"><i class="fa fa-file-text-o"></i> Propose New Program </button></h4>
                                 <div class="clearfix"></div>
                            </div>
                            
                            <div class="x_content">
                                <div class="col-md-12">
                                   <form action="ViewPrograms" method="post">
<!--                                   dt-responsive-->
                                       
                                    <table id="datatable-allprog" class="table table-bordered dt-responsive table-responsive     table-condensed " cellspacing="0" width="100%">
                                      <thead>
                                        <tr>
                                          <th width="1%">Date Created</th>
                                          <th width="">Program Title</th>
                                          <th width="1%">Disease/Diagnosis</th>
                                          <th style="">Category</th>
                                            
                                          <th class="1%">Status</th>
                                          <th class="" style="width:180px;">Action</th>
                                          <th><div style="width:900px;">Proposed By</div></th>
                                          <th><div style="width:900px;">Gender</div></th>
                                          <th><div style="width:900px;">Age Group</div></th>
                                          <th><div style="width:900px;">Barangay</div></th>
                                            <th><div style="width:900px;">Rating</div></th>
                                          
                                        </tr>
                                      </thead>
                                        
                                      <%
                                          nurseDAO nurse = new nurseDAO();
                                          ArrayList <Program> programs  = new ArrayList();
                                          programs = nurse.retrieveAllPrograms();
                                          

                                          for(int i = 0; i<programs.size(); i++) {
                                          Program selectedProgram = programs.get(i);
                                      %>
                                      <tr>

                        <!-- Date Created -->
                                          <td><span class="text-nowrap"><%=selectedProgram.getDate_created()%></span></td>

                        <!--Program name-->
                                          <td><%=selectedProgram.getTitle()%></td>
                                              
                        <!-- Disease/Diagnosis-->
                                          <td>
                                            <div>
                                                <span class="label label-danger" style="display: block;" ><%=nurse.getDiagnosis(selectedProgram.getDiagnosis()).getDiagnosis()%>
                                                </span>
                                            </div>
                                          </td>
                                              
                         <!--CATEGORY-->
                                          <td><%=selectedProgram.getCategory()%></td>
<!--                                          <td style="word-wrap: break-word;min-width: ;max-width: 100px;"><%=selectedProgram.getCategory()%></td>-->
                                              
                                        <!--STATUS-->
                                        <td width="">
                                            
                                            <% if(selectedProgram.getStatus().equalsIgnoreCase("Pending for Approval")){ %> 
                                            <div><span class="label label-warning" style="display: block;" >Pending Approval</span></div>
                                            <% }
                                            if(selectedProgram.getStatus().equalsIgnoreCase("Pending for Evaluation")){ %> 
                                            <div> <span class="label label-warning" style="display: block;">Pending Evaluation</span> </div>
                                            <% } 
                                             if(selectedProgram.getStatus().equalsIgnoreCase("Completed")){ %>
                                            <div> <span class="label label-success" style="display: block;">Completed</span> </div>    
                                            <% } %>
                                                
                                            <% if(selectedProgram.getStatus().equalsIgnoreCase("Disapproved")){ %> 
                                            <div><span class="label label-danger" style="display: block;" >Disapproved</span></div>
                                            <% } %>
                                        </td>  
                                                
                                        <!--ACTION-->
                                          <td style="text-align:left; ">
                                            <span class="text-nowrap">
                                            <div class="btn-group ">
                                              <button  type="submit" name="viewbtn" value="<%=selectedProgram.getProgram_id()%>" class="btn btn-info btn-sm"><i class="fa fa-eye"></i>View</button>
                                              
                                            <% if(selectedProgram.getStatus().equalsIgnoreCase("Pending for Approval") || selectedProgram.getStatus().equalsIgnoreCase("Disapproved")) {%>
                                              <button type="submit" name="editbtn" value="<%=selectedProgram.getProgram_id()%>" id="edituser" class="btn btn-warning btn-sm"><i class="fa fa-edit"></i>Edit</button>
                                            <% }%>
                                            </div>
                                            </span>
                                          </td>
                                              
 
                                        <!--PROPOSED BY-->
                                        <td class="">
                                            <div style="width:500px;">
                                            <%=nurse.retrieveUser(selectedProgram.getProposed_by()).getFullname() %>
                                            </div>
                                        </td>
                                              
                                        <!--GENDER-->
                                          <td class="">
                                              <div style="width:500px;">
                                              <span class="text-nowrap" >
                                              <%=selectedProgram.getGender()%>
                                              </span>
                                              </div>
                                          </td>
                                              
                                              
                                          <!--AGE GROUP-->
                                          <td class="" >
                                            <div style="width:500px;">
                                            <span class="text-nowrap" >
                                            
                                              <%
                                               if (selectedProgram.getAge_groups().size() >= 1) {
                                                    out.print(nurse.getAgeGroup(selectedProgram.getAge_groups().get(0)));
                                                }
                                                for (int x = 1; x < selectedProgram.getAge_groups().size(); x++){
                                                   out.println(", " + nurse.getAgeGroup(selectedProgram.getAge_groups().get(x)));
                                                }
                                              %>
                                            </span>
                                            </div>
                                            </td>
                                        <!--BARANGAY-->
                                          <td class="">
                                              <div style="width:500px;">
                                              <span class="text-nowrap">
                                                <%
                                                   if (selectedProgram.getBrgy().size() >= 1) {
                                                        out.print(selectedProgram.getBrgy().get(0));
                                                    }

                                                    for (int x = 1; x < selectedProgram.getBrgy().size(); x++) { 
                                                         out.print(", " + selectedProgram.getBrgy().get(x));
                                                    }
                                                %>
                                                </span>
                                            </div>
                                          </td>
                                        <!--RATING-->
                                          <td class="" >
                                            <div style="width:500px;">
                                            <span class="text-nowrap" >
                                                <input readonly id="rating-id" type="text" class="rating" name="rating" data-size="xs" data-min="0" data-max="5" data-step="1" value="<%=selectedProgram.getEvaluation()%>">
                                            </span>
                                            </div>
                                            </td>
                                        
                                                
                                      </tr>    
                                      <% } %>    
                                      <tbody>
                                      
                                      </tbody>
                                    </table>
                                    
                                    </form> 
                                </div> <!--col-12-->
                            </div> <!--x_content-->

                        </div><!--x_panel-->
                        <!-- END OF PENDING PROGRAMS TABLE-->
                        

                        
                        <% if (userType.equalsIgnoreCase("physician")) { %>
                        <!--PENDING PROGRAMS TABLE-->
                        <form action="ViewPrograms" method="post">
                        <div class="x_panel">
                            <div class="x_title">
                                <h4><i class="fa fa-book"></i>
                                <!--get information from database!!-->
                                <strong> <i class="fa fa-check-square"></i> Programs Pending for Approval </strong> 
                                <!-- Elements-->
                                    </h4>
                                 <div class="clearfix"></div>
                            </div>
                            
                            <div class="x_content">
                                <div class="col-md-12">
                                    <table id="datatable-pendingapproval" class="table table-bordered dt-responsive table-responsive     table-condensed " cellspacing="0" width="100%">
                                      <thead>
                                        <tr>
                                          <th width="1%">Date Created</th>
                                          <th width="">Program Title</th>
                                          <th width="1%">Disease/Diagnosis</th>
                                          <th style="">Category</th>
                                          <th class="1%">Status</th>
                                          <th class="" style="width:180px;">Action</th>
                                          <th><div style="width:900px;">Proposed By</div></th>
                                          <th><div style="width:900px;">Gender</div></th>
                                          <th><div style="width:900px;">Age Group</div></th>
                                          <th><div style="width:900px;">Barangay</div></th>
                                        </tr>
                                      </thead>
                                        
                                        
                                      <%
                                          programs  = new ArrayList();
                                          programs = nurse.retrieveAllPendingApprovalPrograms();
                                          

                                          for(int i = 0; i<programs.size(); i++) {
                                          Program selectedProgram = programs.get(i);
                                      %>
                                        
                                      <tr>
                                <!-- Date Created -->
                                          <td><span class="text-nowrap"><%=selectedProgram.getDate_created()%></span></td>

                                <!--Program name-->
                                          <td><%=selectedProgram.getTitle()%></td>
                                              
                                <!-- Disease/Diagnosis-->
                                          <td>
                                            <div>
                                                <span class="label label-danger" style="display: block;" ><%=nurse.getDiagnosis(selectedProgram.getDiagnosis()).getDiagnosis()%>
                                                </span>
                                            </div>
                                          </td>
                                <!--CATEGORY-->
                                          <td><%=selectedProgram.getCategory()%></td>
                                        <!--STATUS-->
                                        <td width="">
                                            <% if(selectedProgram.getStatus().equalsIgnoreCase("Pending for Approval")){ %> 
                                            <div><span class="label label-warning" style="display: block;" >Pending Approval</span></div>
                                            <% }
                                            if(selectedProgram.getStatus().equalsIgnoreCase("Pending for Evaluation")){ %> 
                                            <div> <span class="label label-warning" style="display: block;">Pending Evaluation</span> </div>
                                            <% } 
                                             if(selectedProgram.getStatus().equalsIgnoreCase("Completed")){ %>
                                            <div> <span class="label label-success" style="display: block;">Completed</span> </div>    
                                            <% } %>
                                                
                                            <% if(selectedProgram.getStatus().equalsIgnoreCase("Disapproved")){ %> 
                                            <div><span class="label label-danger" style="display: block;" >Disapproved</span></div>
                                            <% } %>
                                        </td>  
                                                
                                        <!--ACTION-->
                                          
                                          <td style="text-align:left;  width:210px;"> 
                                            <div class="btn-group ">
                                              <button  type="submit" name="viewbtn" value="<%=selectedProgram.getProgram_id()%>" class="btn btn-info btn-sm"><i class="fa fa-eye"></i>View</button>
                                              
                                              <button type="submit" name="editbtn" value="<%=selectedProgram.getProgram_id()%>" id="edituser" class="btn btn-warning btn-sm"><i class="fa fa-edit"></i>Edit</button>
                                              
                                            </div>
                                          </td>
                                              
                                                                                        <!--PROPOSED BY-->
                                        <td class="">
                                            <div style="width:500px;">
                                            <%=nurse.retrieveUser(selectedProgram.getProposed_by()).getFullname() %>
                                            </div>
                                        </td>
                                              
                                        <!--GENDER-->
                                          <td class="">
                                              <div style="width:500px;">
                                              <span class="text-nowrap" >
                                              <%=selectedProgram.getGender()%>
                                              </span>
                                              </div>
                                          </td>
                                              
                                              
                                          <!--AGE GROUP-->
                                          <td class="" >
                                            <div style="width:500px;">
                                            <span class="text-nowrap" >
                                            
                                              <%
                                               if (selectedProgram.getAge_groups().size() >= 1) {
                                                    out.print(nurse.getAgeGroup(selectedProgram.getAge_groups().get(0)));
                                                }
                                                for (int x = 1; x < selectedProgram.getAge_groups().size(); x++){
                                                   out.println(", " + nurse.getAgeGroup(selectedProgram.getAge_groups().get(x)));
                                                }
                                              %>
                                            </span>
                                            </div>
                                            </td>
                                        <!--BARANGAY-->
                                          <td class="">
                                              <div style="width:500px;">
                                              <span class="text-nowrap">
                                                <%
                                                   if (selectedProgram.getBrgy().size() >= 1) {
                                                        out.print(selectedProgram.getBrgy().get(0));
                                                    }

                                                    for (int x = 1; x < selectedProgram.getBrgy().size(); x++) { 
                                                         out.print(", " + selectedProgram.getBrgy().get(x));
                                                    }
                                                %>
                                                </span>
                                            </div>
                                          </td>
                                        
                                            
                                      </tr>    
                                      <% } %>    
                                      <tbody>
                                      </tbody>
                                    </table>
                                    
                                    
                                </div> <!--col-12-->
                            </div> <!--x_content-->

                        </div><!--x_panel-->
                        </form> 
                        <!-- END OF PENDING PROGRAMS TABLE-->
                                              
                                              
                                              
                               
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                        <% } %>
                        
                        <% if (userType.equalsIgnoreCase("physician")) { %>
                        <!--PENDING EVALUATION PROGRAMS TABLE-->
                        <div class="x_panel">
                            <div class="x_title">
                                <h4><i class="fa fa-book"></i>
                                <!--get information from database!!-->
                                <strong> <i class="fa fa-edit"></i> Programs Pending for Evaluation</strong> 
                                <!-- Elements-->
                                </h4>
                                 <div class="clearfix"></div>
                            </div>
                            
                            <div class="x_content">
                                <div class="col-md-12">
                                   <form action="ViewPrograms" method="post">
                                       
                                    <table id="datatable-pendingeval" class="table table-bordered dt-responsive table-responsive     table-condensed " cellspacing="0" width="100%">
                                      <thead>
                                        <tr>
                                          <th width="1%">Date Created</th>
                                          <th width="">Program Title</th>
                                          <th width="1%">Disease/Diagnosis</th>
                                          <th style="">Category</th>
                                          <th class="1%">Status</th>
                                          <th class="" style="width:180px;">Action</th>
                                          <th><div style="width:900px;">Proposed By</div></th>
                                          <th><div style="width:900px;">Gender</div></th>
                                          <th><div style="width:900px;">Age Group</div></th>
                                          <th><div style="width:900px;">Barangay</div></th>
                                        </tr>
                                      </thead>
                                      <%
                                          programs  = new ArrayList();
                                          programs = nurse.retrieveAllPendingEvaluationPrograms();
                                          

                                          for(int i = 0; i<programs.size(); i++) {
                                          Program selectedProgram = programs.get(i);
                                      %>
                                        
                                        
                                        
                                        
                                      <tr>

                                          
                                          
                                          
                                            
                                            
                                <!-- Date Created -->
                                          <td><span class="text-nowrap"><%=selectedProgram.getDate_created()%></span></td>

                                <!--Program name-->
                                          <td><%=selectedProgram.getTitle()%></td>
                                              
                                <!-- Disease/Diagnosis-->
                                          <td>
                                            <div>
                                                <span class="label label-danger" style="display: block;" ><%=nurse.getDiagnosis(selectedProgram.getDiagnosis()).getDiagnosis()%>
                                                </span>
                                            </div>
                                          </td>
                                <!--CATEGORY-->
                                          <td><%=selectedProgram.getCategory()%></td>
                                        <!--STATUS-->
                                        <td width="">
                                            <% if(selectedProgram.getStatus().equalsIgnoreCase("Pending for Approval")){ %> 
                                            <div><span class="label label-warning" style="display: block;" >Pending Approval</span></div>
                                            <% }
                                            if(selectedProgram.getStatus().equalsIgnoreCase("Pending for Evaluation")){ %> 
                                            <div> <span class="label label-warning" style="display: block;">Pending Evaluation</span> </div>
                                            <% } 
                                             if(selectedProgram.getStatus().equalsIgnoreCase("Completed")){ %>
                                            <div> <span class="label label-success" style="display: block;">Completed</span> </div>    
                                            <% } %>
                                                
                                            <% if(selectedProgram.getStatus().equalsIgnoreCase("Disapproved")){ %> 
                                            <div><span class="label label-danger" style="display: block;" >Disapproved</span></div>
                                            <% } %>
                                        </td>  
                                                
                                            
                                         <!--ACTION-->
                                          <td style="text-align:left; width:210px;"> 
                                            <div class="btn-group ">
                                              <button  type="submit" name="viewbtn" value="<%=selectedProgram.getProgram_id()%>" class="btn btn-info btn-sm"><i class="fa fa-eye"></i>View</button>
                                                <button type="submit" name="evaluatebtn" value="<%=selectedProgram.getProgram_id()%>" id="approveprogram" class="btn btn-primary btn-sm"><i class="fa fa-check-circle-o"></i> Evaluate</button>                                                  
                                            </div>
                                          </td>
                                                
                           <!--PROPOSED BY-->
                                        <td class="">
                                            <div style="width:500px;">
                                            <%=nurse.retrieveUser(selectedProgram.getProposed_by()).getFullname() %>
                                            </div>
                                        </td>
                                              
                                        <!--GENDER-->
                                          <td class="">
                                              <div style="width:500px;">
                                              <span class="text-nowrap" >
                                              <%=selectedProgram.getGender()%>
                                              </span>
                                              </div>
                                          </td>
                                              
                                              
                                          <!--AGE GROUP-->
                                          <td class="" >
                                            <div style="width:500px;">
                                            <span class="text-nowrap" >
                                            
                                              <%
                                               if (selectedProgram.getAge_groups().size() >= 1) {
                                                    out.print(nurse.getAgeGroup(selectedProgram.getAge_groups().get(0)));
                                                }
                                                for (int x = 1; x < selectedProgram.getAge_groups().size(); x++){
                                                   out.println(", " + nurse.getAgeGroup(selectedProgram.getAge_groups().get(x)));
                                                }
                                              %>
                                            </span>
                                            </div>
                                            </td>
                                        <!--BARANGAY-->
                                          <td class="">
                                              <div style="width:500px;">
                                              <span class="text-nowrap">
                                                <%
                                                   if (selectedProgram.getBrgy().size() >= 1) {
                                                        out.print(selectedProgram.getBrgy().get(0));
                                                    }

                                                    for (int x = 1; x < selectedProgram.getBrgy().size(); x++) { 
                                                         out.print(", " + selectedProgram.getBrgy().get(x));
                                                    }
                                                %>
                                                </span>
                                            </div>
                                          </td>
                                        
                                            
                                            
                                            
                                            
                                            

                                      </tr>  
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                      <% } %>    
                                      <tbody>
                                      </tbody>
                                    </table>
                                    
                                    </form> 
                                </div> <!--col-12-->
                            </div> <!--x_content-->

                        </div><!--x_panel-->
                        <!--END PENDING EVALUATION TABLE-->
                        <% } %>
                        

                    </div><!--col-md-12-->
                </div> <!--right_col edited-->
       
                                     
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
                <!-- starRating -->
                <script src="vendors/bootstrap-star-rating/js/star-rating.js" type="text/javascript"></script>
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

  <script>
$(document).ready(function() {    
    $('#datatable-allprog').DataTable( {
        responsive: true
    });
    $('#datatable-pendingapproval').DataTable( {
        responsive: true
    }); 
    $('#datatable-pendingeval').DataTable( {
        responsive: true
    }); 
} );
</script>

</html>