<%@page import="Model.Program"%>
<%@page import="Model.User"%>
<%@page import="Model.Diagnosis"%>
<%@page import="Model.Chart"%>
<%@page import="Model.Resource"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date;"%>
<%@page import="java.util.ArrayList"%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> View Program Proposal </title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="vendors/iCheck/skins/flat/green.css" rel="stylesheet">
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
    <!-- prettyCheckbox -->
    <link href="vendors/pretty-checkbox/src/pretty.min.css" rel="stylesheet">
    <!-- multiselect -->
    <link rel="stylesheet" href="vendors/bootstrap-multiselect/dist/css/bootstrap-multiselect.css" type="text/css"/>
    <!-- starRating -->
    <link href="vendors/bootstrap-star-rating/css/star-rating.css" rel="stylesheet">
    <!-- FileInput.js -->
    <link href="vendors/kartik-fileinput/css/fileinput.min.css" rel="stylesheet">
    

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

        
        
        
<%
    //INITIALIZATION
    int programID = 0;
    if (session.getAttribute("selectedProgram") != null){
         programID = (Integer) session.getAttribute("selectedProgram");
    } else if (session.getAttribute("selectedApproveProgram") != null){
         programID = (Integer) session.getAttribute("selectedApproveProgram");
    }
    
    nurseDAO nDAO = new nurseDAO();
    Program currentProgram = new Program();
    currentProgram = nDAO.getProgram(programID);
    Diagnosis d = new Diagnosis(); 
    d = nDAO.getDiagnosis(currentProgram.getDiagnosis());
    
    
    
%>        
        
        <!--START OF PAGE CONTENT-->
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
                
                <li class="breadcrumb-item">Program</li>
                <li class="breadcrumb-item active">View Program Proposal</li>
          </ol>
          
           <div class="col-md-12 col-sm-12 col-xs-12">
                    
            <!--Program Proposal Card-->
            <div class="x_panel" id="programproposalcard">
               
                <div class="x_content">
                    <center>
                        <h3>
                            <strong>PROGRAM PROPOSAL<br>
                            </strong>
                        </h3>
                    </center>
                    <div class="col-md-1">
                        <a class="btn btn-default" href="print_program_proposal.jsp"><i class="fa fa-print"></i> Print</a>
                    </div>
                    <div class="col-md-2">
                        <% if(currentProgram.getStatus().equalsIgnoreCase("Completed") || currentProgram.getStatus().equalsIgnoreCase("Pending for Evaluation")){ %> 

                        <button  type="button" class="btn btn-default" data-toggle="modal" data-target=".memo-modal-lg"><i class="fa fa-sticky-note"></i> See Memo</button>    

                        <% } %>
                    </div><!--/col-md-2-->
                    <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                </div>
                <!--<div class="x_title">
                    <strong>Program Proposal</strong>
                </div>-->
                <div class="x_content">
                        
                    <!--TITLE-->
                    <div class="form-group row">
                      
                      <div class="col-md-12">
                        <label class="col-md-2 control-label">Program Title:</label>
                        
                        <div class="col-md-6">
                            <h3><small><%=currentProgram.getTitle()%></small></h3>
                        </div><!--/col-md-5-->
                        
                        <label class="col-md-1 control-label">Status:</label>
                        
                        <div class="col-md-2">
                            <% if(currentProgram.getStatus().equalsIgnoreCase("Pending for Approval")){ %> 
                            <div><span class="label label-info" style="display: block;" >Pending Approval</span></div>
                            <% }
                            if(currentProgram.getStatus().equalsIgnoreCase("Pending for Evaluation")){ %> 
                            <div> <span class="label label-info" style="display: block;">Pending Evaluation</span> </div>
                            <% } 
                             if(currentProgram.getStatus().equalsIgnoreCase("Completed")){ %>
                            <div> <span class="label label-success" style="display: block;">Completed</span> </div>    
                            <% } %>
                        </div><!--/col-md-2-->

                      </div>
                        
                    <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                     
                      <div class="col-md-12">
                        <label class="col-md-2 control-label">Implementing Period:</label>

                       <div class='col-md-6'>
                            <div class="form-group">
                                <div class='input-group date' id='datetimepicker6'>
                                   
                                   <h3><small>From <%=currentProgram.getProposed_date_from()%> To <%=currentProgram.getProposed_date_to()%></small></h3>
                                </div>
                            </div>
                        </div>
                        
                      </div><!--/col-md-12-->
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                     
                     <div class="col-md-12">
                        <label class="col-md-2 control-label">Program Category:</label>

                       <div class='col-md-4'>
                            <h3><small><%=currentProgram.getCategory()%></small></h3>
                        </div>
                      </div><!--/col-md-12-->
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                      
                      <div class="col-md-12">
                        <label class="col-md-2 control-label">No. of Participants:</label>
                        
                        <div class="col-md-5">
                            <h3><small><%=currentProgram.getTarget()%></small></h3>
                        </div><!--/col-md-5-->
                      </div>
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                      
                      
                      <div class="col-md-12">
                          <label class="col-md-2 control-label">Target Disease/Diagnosis:</label>
                          <div class="col-md-5">
                            <h3><small><%=d.getDiagnosis()%></small></h3>

                        </div>
                     </div>
                     
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                     
                     
                      <div class="col-md-12">
                        <label class="col-md-2 control-label">Target Participants:</label>
                      </div>
                      
                      <div class="col-md-12">
                          <div class="col-md-2"></div>
                          <div class="col-md-8">
                                <div class="row">
                                <div class="col-md-2">
                                <label>
                                 <!-- <input type="checkbox" class="flat" checked="checked"> -->Age Range
                                </label>
                                </div>

                                <div class="col-md-4">
                                <h3><small>
                            <%                              
                              if (currentProgram.getAge_groups().size() == 6) {
                                   out.println("All");
                              }else{
                               if (currentProgram.getAge_groups().size() >= 1) {
                                out.print(nDAO.getAgeGroup(currentProgram.getAge_groups().get(0)));
                                }

                                for (int x = 1; x < currentProgram.getAge_groups().size(); x++){
                                out.println(", " + nDAO.getAgeGroup(currentProgram.getAge_groups().get(x)));
                                }
                              }
                            %>    
                                </small></h3>
                                </div>    
                              </div>
                              <!--/row-->
                              
                              <div class="form-group row">
                                <div class="col-md-2">
                                <label>
                                  Gender
                                </label>
                                </div>

                                <div class="col-md-10">
                                <h3><small><%=currentProgram.getGender()%>  </small></h3>
                                </div>    

                              </div>
                              <!--/row-->
                              
                              <div class="row">
                                <div class="col-md-2">
                                <label>
                                  Barangay
                                </label>
                                </div>

                                <div class="col-md-4">
                            <h3><small>
                            <%
                              if (currentProgram.getAge_groups().size() == 6) {
                                   out.println("All");
                              }else{
                               if (currentProgram.getBrgy().size() >= 1) {
                                    out.print(currentProgram.getBrgy().get(0));
                                }

                                for (int x = 1; x < currentProgram.getBrgy().size(); x++) { 
                                     out.print(", " + currentProgram.getBrgy().get(x));
                                }
                              }
                            %>
                            </small></h3>
                            
                                </div>  

                              </div>
                            </div><!--DEMOGRAPHICS-->
                      </div>
                      
                      <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                      
                      
                    </div><!--/form-group-->
                    
                    
                    <!--BRIEF DESCRIPTION-->
                    <div class="form-group row">
                       <div class="col-md-12 col-sm-12 col-xs-12">
                            <label class="control-label">Brief Description:</label>
                        </div>
                        <div class="col-md-12">
                            <textarea readonly type="text" required="required" class="form-control noMargin" id="description" name="description" cols="10" rows="5" placeholder="eg. Description of project"><%=currentProgram.getDescription()%></textarea>
                        </div><!--/col-md-5-->

                    </div>
                    <!--END OF DESCRIPTION-->      
                    
                    
                    <!--RESOURCE-->
                    <div class="form-group row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <label class="control-label">Resource Plan:</label>
                        </div>
                        <div class="col-md-12">
                           
                            <!--TABLE FORM-->
                                <div class="table-responsive">
                                <table class="table table-bordered table-hover table-sortable" id="tab_logic">
                                    <thead>
                                        <tr>
                                            <th class="text-center">
                                                Item
                                            </th>
                                            <th class="text-center">
                                                Unit
                                            </th>
                                            <th class="text-center">
                                                Quantity
                                            </th>
                                            <th class="text-center">
                                                Price
                                            </th>
                                            <th class="text-center">
                                                Total
                                            </th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <%
                                            ArrayList<String> vName = new ArrayList<String>();
                                            ArrayList<Resource> vList1 = nDAO.getAllResourcesOfProgram(programID);
                                            for (int x = 0; x < vList1.size(); x++){
                                        %>

                                        <tr>
                                            <td width="50%">
                                                <%=vList1.get(x).getItem()%>
                                           </td>
                                            <td width="10%"> 
                                                <%=vList1.get(x).getUnit()%>
                                            </td>
                                            <td width="10%"> 
                                                <%=vList1.get(x).getQty()%>
                                            </td>
                                            <td width="10%"> 
                                                <%=vList1.get(x).getPrice()%>
                                            </td>
                                            <td width="10%"> 
                                                <%=vList1.get(x).getTotal()%>
                                            </td>
                                        </tr>

                                        <%}%>

                                    </tbody>

                                </table>
                                </div> <!--/Table--> 
                                
                        </div><!--/col-md-12-->
                        
                        <div class="pull-right col-xs-4">
                          <table class="table table-bordered table-hover" id="tab_logic_total">
                            <tbody id="totalbudget">
                              <tr>
                                <th class="text-center">Total Budget</th>
                                    <td class="text-center">
                                        <%=currentProgram.getTotal_price()%>
                                    </td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                    </div>
                    <!--RESOURCE-->  
                                                                      

                </div>
                <!--x_content buong form-->
                </div><!--x_panel buong form-->
            <!-- End of Program Proposal-->
            
            <!--Program Evaluation Card-->
            <% if(currentProgram.getStatus().equalsIgnoreCase("Completed")) { %>
            
            <div class="x_panel">
                <div class="x_content">
                    <center>
                        <h3>
                            <strong>PROGRAM EVALUATION<br>
                            </strong>
                        </h3>
                    </center>
                    <!--SPACER-->
                        <div class="col-md-12"><br></div>
                    <!--SPACER-->
                </div>
                <!--<div class="x_title">
                    <strong>Program Planning</strong>
                </div>-->
                
                <%
                Program p = new Program();
                
                if(session.getAttribute("selectedProgram") == null){
                    response.sendRedirect("view_programs.jsp");
                }else{
                    int selectedProgram = (Integer) session.getAttribute("selectedProgram");
                    p = nDAO.getProgram(selectedProgram);
                }
                
                %>
                <div class="x_content">
                        
                    <!--TITLE-->
                    <div class="form-group row">
                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Program Title:</label>

                                <div class="col-md-5">
                                    <h3><small><%=p.getTitle()%></small></h3>
                                </div><!--/col-md-5-->
                            </div>

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Proposed Date:</label>

                                <div class='col-md-3'>
                                    <div class="form-group">
                                        <div class='input-group date' id='datetimepicker6'>

                                            <h3><small>From <%=p.getProposed_date_from()%></small></h3>
                                            <br>
                                            <h3><small>To <%=p.getProposed_date_to()%></small></h3>

                                        </div>
                                    </div>
                                </div>

                                <label class="col-md-1"></label>

                                <label class="col-md-2 control-label">Date Implemented:</label>

                                <div class='col-md-3'>
                                    <div class="form-group">
                                        <div class='input-group date' id='datetimepicker6'>

                                            <h3><small>From <%=p.getDate_execute_start()%></small></h3>
                                            <br>
                                            <h3><small>To <%=p.getDate_execute_end()%></small></h3>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div><!--/col-md-12-->

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Target vs Actual:</label>

                                <div class="col-md-3">
                                    <h3><small><%=p.getTarget()%> / <%=p.getActual_target()%></small></h3>
                                </div><!--/col-md-5-->


                            </div>

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <!--RATING-->  
                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Rating:</label>

                                <div class="col-md-5">
                                    <input readonly id="rating-id" type="text" class="rating" name="rating" data-size="sm" data-min="0" data-max="5" data-step="1" value="<%=p.getEvaluation()%>">
                                </div><!--/col-md-5-->
                            </div>


                            <!--SPACER-->
                                <div class="col-md-12"><br></div>
                            <!--SPACER-->
                            <!--SPACER-->
                                <div class="col-md-12"><br></div>
                            <!--SPACER-->
                            <!--SPACER-->
                                <div class="col-md-12"></div>
                            <!--SPACER-->

                            <!--WHAT WENT WRONG TABLE-->
                            <div class="col-md-4">
                                    <label class="control-label">What Went Well:</label>
                                </div>
                            <div class="col-md-4">
                                    <label class="control-label">What Went Wrong:</label>
                                </div>
                            <div class="col-md-4">
                                    <label class="control-label">Recommendations:</label>
                                </div>
                            <div class="col-md-4">
                                    <textarea readonly class="form-control noresize" placeholder="What Went Well"  cols="12" rows="5" name="well" maxlength="100"><%=p.getWent_well()%></textarea>
                                </div>
                            <div class="col-md-4">
                                    <textarea readonly class="form-control noresize" placeholder="What Went Wrong"  cols="12" rows="5" name="wrong" maxlength="100"><%=p.getWent_wrong()%></textarea>
                                </div>
                            <div class="col-md-4">
                                    <textarea readonly class="form-control noresize" placeholder="Recommendations"  cols="12" rows="5" name="recommendation" maxlength="100"><%=p.getRecommendation()%></textarea>
                            </div>
                            <!--END OF WHAT WENT WRONG TABLE--> 

                            <!--SPACER-->
                                <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <!--COMMENTS-->
                            <div class="form-group row">
                               <div class="col-md-12">
                                    <label class="control-label">Comments:</label>
                                </div>
                                <div class="col-md-12">
                                    <textarea readonly class="form-control noresize" placeholder="Comments on the Project"  cols="12" rows="5" name="comments" ><%=p.getComments()%></textarea>
                            </div>
                           
                        </div>
                        <!--END OF COMMENTS--> 
                    </div><!--/form-group-->
                </div>
                <!--x_content buong form-->
                
                
               
                
                
                </div><!--x_panel buong form-->
            <!-- End of PROGRAM Evaluation-->
             <% } %>
             
             <form action="ApproveProgram" method="post" enctype="multipart/form-data"> 
                     <footer>
                        <div class="form-group" align="center">
                            
                            
                        <% if (currentProgram.getStatus().equalsIgnoreCase("Pending for Approval") && userType.equalsIgnoreCase("physician")){ %>
                           
                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                <button class="btn btn-danger" type="button" data-toggle="modal" data-target=".areyousure-modal-lg">Disapprove</button>

                                <!--              <button class="btn btn-primary" type="reset">Reset</button>-->
                                <button type="button" class="btn btn-success" data-toggle="modal" data-target=".areyousure2-modal-lg">Approve</button>
                            </div>
                            
                        <% } else { %>
                            
                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Back</button>
                            </div>
                            
                        <% } %>
                            
                        </div>
                    </footer>
                    
                <!--ARE YOU SURE MODAL DISAPPROVE-->
                <div class="modal fade areyousure-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-close"></i>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2"><i class="fa fa-times-circle" style="color: red;"></i> Are you sure you want to disapprove program? &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
                        </div>
                        <div class="modal-body">
                           <p><b>Upload Memo</b></p>
                            <input id="evidenceDisapproved" class="file" name="disapproveImg" type="file">
                            <br>
                            <!--COMMENTS-->
                            <div class="form-group row">
                               <div class="col-md-12">
                                    <label class="control-label">Comment on Decision:</label>
                                </div>
                                <div class="col-md-12">
                                    <textarea class="form-control noresize" placeholder="Comment on the Decision"  cols="12" rows="5" name="disapprovecomments" maxlength="200"></textarea>
                                </div>
                               
                            </div>
                            <!--END OF COMMENTS--> 
                        </div>
                        
                       
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                          <button type="submit" class="btn btn-success" name="disapprovebtn" value="click">Confirm</button>
                        </div>

                      </div>
                    </div>
                  </div><!--/MODAl DISAPPROVE-->
                  
                <!--ARE YOU SURE MODAL APPROVE-->
                <div class="modal fade areyousure2-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-close"></i>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2"><i class="fa fa-check-circle" style="color: green;"></i> Are you sure you want to approve program? &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
                        </div>
                        <div class="modal-body">
                           <p><b>Upload Evidence</b></p>
                            <input id="evidenceApproved" class="file" name="approveImg" type="file">
                            <br>
                            <!--COMMENTS-->
                            <div class="form-group row">
                               <div class="col-md-12">
                                    <label class="control-label">Comment on Decision:</label>
                                </div>
                                <div class="col-md-12">
                                    <textarea class="form-control noresize" placeholder="Comment on the Decision"  cols="12" rows="5" name="approvecomments" maxlength="200"></textarea>
                                </div>
                               
                            </div>
                            <!--END OF COMMENTS--> 
                        </div>
                        
                       
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                          <button type="submit" class="btn btn-success" name="approvebtn" value="click">Confirm</button>
                        </div>

                      </div>
                    </div>
                  </div><!--/MODAl APPROVE-->
                   
                <!-- MEMO MODAL -->
                <div class="modal fade memo-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-close"></i>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2"><i class="fa fa-check-circle" style="color: green;"></i> Uploaded Memo &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
                        </div>
                        <div class="modal-body">
                            <!-- input id="evidenceApproved" class="file" type="file" -->
                            <div class="form-group row">
                               
                                <% String word=""+currentProgram.getApprovalImg_output();   %>
                                     <img src="<%=word%>">  
                                
                               
                            </div>
                            <br>
                            <!--COMMENTS-->
                            <div class="form-group row">
                               <div class="col-md-12">
                                    <label class="control-label">Comment on Decision:</label>
                                </div>
                                <div class="col-md-12">
                                    <textarea class="form-control noresize" placeholder="Comment on the Decision"  cols="12" rows="5" name="comments" maxlength="200" value="<%=currentProgram.getApproval_comments()%>"></textarea><!-- grep insert value -->
                                </div>
                               
                            </div>
                            <!--END OF COMMENTS--> 
                        </div>
                        
                       

                      </div>
                    </div>
                  </div><!--/ MEMO MODAl-->
                  
          </form>  
              
               </div><!--col-md-12-->
        </div><!--right_col-->
            
        </div><!--main_container-->
    </div><!--container body-->
    

    
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
                <!-- bootstrap datepicker -->
                <script src="vendors/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
                <!--multiselect-->
                 <script src="vendors/bootstrap-multiselect/dist/js/bootstrap-multiselect.js"></script>
                <!-- Custom Theme Scripts -->
                <script src="source/js/custom.min.js"></script>
                <!-- bootstrap-datetimepicker -->    
                <script src="vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
                <!-- starRating -->
                <script src="vendors/bootstrap-star-rating/js/star-rating.js" type="text/javascript"></script>
                <!-- FileInput.js -->
                <script src="vendors/kartik-fileinput/js/fileinput.min.js" type="text/javascript"></script>
                <script src="vendors/kartik-fileinput/js/sortable.min.js" type="text/javascript"></script>
                
</body>
   
   
<script>
$(document).on('ready', function() {
    $("#input-20").fileinput({
        browseClass: "btn btn-primary btn-block",
        showCaption: false,
        showRemove: false,
        showUpload: false
    });
});
</script>
                        
<!--Create Program-->
<script>
function showDiv() {
   document.getElementById('programproposalcard').style.display = "";
   //document.getElementById('createprogram').style.display = "none";
}    
</script>
<!--multiselect-->
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
function updateFormEnabled() {
    if (verifySettings()) {
        document.getElementById('suggestedbutton').style.display = "block";
    } else {
        document.getElementById('suggestedbutton').style.display = "none";
    }
}

function verifySettings() {
    if ($('#tag1').val() != null || $('#tag2').val() != null || $('#tag3').val() != null || $('#category').val() != null) {
        return true;
    } else {
        return false
    }
}

$('#tag1').change(updateFormEnabled);
$('#tag2').change(updateFormEnabled);
$('#tag3').change(updateFormEnabled);
$('#category').change(updateFormEnabled);
    
    
</script>
<script>
     $('#datepicker1').datetimepicker({
      format: 'YYYY-MM-DD'
    });
    $('#datepicker2').datetimepicker({
      format: 'YYYY-MM-DD'
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

<script>
    $(document).ready(function() {
        $('.medication-multiple').select2();
    });

    $(document).ready(function() {
        $(".medication-multiple").select2({
        tags: true
        });
    });
</script>

<script>
$("#selectallimm").click(function () {
$(".adultimmunization").prop('checked', $(this).prop('checked'));
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
</script>
<!--TABLE RESOURCE REQUIREMENTS-->
<script type="text/javascript">
    $(function () {
        //Build an array containing wellwrong records.
        var wellwrong = new Array();
        //Add the data rows.
        for (var i = 0; i < wellwrong.length; i++) {
            AddRow(wellwrong[i][0], wellwrong[i][1]);
        }
    });
    function Add() {
        AddRow($("#resource").val(), $("#quantity").val(), $("#unitprice").val(), $("#total").val());
        $("#resource").val("");
        $("#quantity").val("");
        $("#unitprice").val("");
        $("#total").val("");
    };
    function AddRow(resource, quantity, unitprice, total) {
        //Get the reference of the Table's TBODY element.
        var tBody = $("#tblWellWrong > TBODY")[0];
        //Add Row.
        row = tBody.insertRow(-1);
        
        //Add resource cell.
        var cell = $(row.insertCell(-1));
        cell.html(resource);
        
        //Add quantity cell.
        cell = $(row.insertCell(-1));
        cell.html(quantity);
        
        //Add unitprice cell.
        cell = $(row.insertCell(-1));
        cell.html(unitprice);
        
        //Add total cell.
        cell = $(row.insertCell(-1));
        cell.html(total);
        
        //Add Button cell.
        cell = $(row.insertCell(-1));
        var btnRemove = $("<input />");
        btnRemove.attr("type", "button");
        btnRemove.attr("onclick", "Remove(this);");
        btnRemove.val("Remove");
        cell.append(btnRemove);
    };
    function Remove(button) {
        //Determine the reference of the Row using the Button.
        var row = $(button).closest("TR");
        var name = $("TD", row).eq(0).html();
        if (confirm("Do you want to delete: " + name)) {
            //Get the reference of the Table.
            var table = $("#tblWellWrong")[0];
            //Delete the Table row using it's Index.
            table.deleteRow(row[0].rowIndex);
        }
    };
</script>
<script>
    function calculateTotal(){
        
        var unitprice=Number(document.getElementById("unitprice").value);
        var quantity=Number(document.getElementById("quantity").value);
        
        //Perform calculation
        var total = unitprice * quantity;

        //Display result of calculation
        document.getElementById("total").innerText=total;
        
    }                              
</script>

</html>
