<%@page import="Model.Program"%>
<%@page import="Model.User"%>
<%@page import="Model.Diagnosis"%>
<%@page import="Model.Chart"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="DAO.userDAO"%>
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

    <title> Print Program Proposal </title>

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

    <!-- Custom Theme Style -->
    <link href="source/css/custom.min.css" rel="stylesheet">
</head>

<body onload="window.print();">
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
        %>

<%
    //INITIALIZATION
    int programID = 0;
    if (session.getAttribute("selectedProgram") != null){
         programID = (Integer) session.getAttribute("selectedProgram");
    } else if (session.getAttribute("selectedApproveProgram") != null){
         programID = (Integer) session.getAttribute("selectedApproveProgram");
    }
    
    nurseDAO nDAO = new nurseDAO();
    userDAO uDAO = new userDAO(); 
    Program currentProgram = new Program();
    currentProgram = nDAO.getProgram(programID);
    
    int proposedByID = currentProgram.getProposed_by();
    User proposedBy = new User();
    proposedBy = uDAO.retrieveUser(proposedByID);
    
    Diagnosis d = new Diagnosis(); 
    d = nDAO.getDiagnosis(currentProgram.getDiagnosis());
    
    
%>        
        
        <!--START OF PAGE CONTENT-->
        <div class="wrapper" role="main">
          
           <div class="col-md-12 col-sm-12 col-xs-12">
                    
            <!--Program Proposal Card-->      
               
                <div class="x_content">
                    <center>
                        <h3>
                            <strong>PROGRAM PROPOSAL<br>
                            </strong>
                        </h3>
                    </center>
                    <!-- <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print"></i> Print</button> -->
                    <!--SPACER-->
                        <div class="col-xs-12"><br></div>
                    <!--SPACER-->
                </div>
                <!--<div class="x_title">
                    <strong>Program Proposal</strong>
                </div>-->
                <div class="x_content">
                        
                    <!--TITLE-->
                    <div class="form-group row">
                      
                      <div class="col-xs-12">
                        <label class="col-xs-2 control-label">Program Title:</label>
                        
                        <div class="col-xs-6">
                            <h3><small><%=currentProgram.getTitle()%></small></h3>
                        </div><!--/col-xs-5-->
                        
                      </div>
                        
                    <!--SPACER-->
                        <div class="col-xs-12"><br></div>
                    <!--SPACER-->
                     
                      <div class="col-xs-12">
                        <label class="col-xs-2 control-label">Implementing Period:</label>

                       <div class='col-xs-5'>
                            <div class="form-group">
                                <div class='input-group date' id='datetimepicker6'>
                                   
                                   <h3><small>From <%=currentProgram.getProposed_date_from()%> To <%=currentProgram.getProposed_date_to()%></small></h3>
                                </div>
                            </div>
                        </div>
                        
                      </div><!--/col-xs-12-->
                      
                      <!--SPACER-->
                        <div class="col-xs-12"><br></div>
                    <!--SPACER-->
                     
                     <div class="col-xs-12">
                        <label class="col-xs-2 control-label">Program Category:</label>

                       <div class='col-xs-4'>
                            <h3><small><%=currentProgram.getCategory()%></small></h3>
                        </div>
                      </div><!--/col-xs-12-->
                      
                      <!--SPACER-->
                        <div class="col-xs-12"><br></div>
                    <!--SPACER-->
                      
                      <div class="col-xs-12">
                        <label class="col-xs-2 control-label">No. of Participants:</label>
                        
                        <div class="col-xs-5">
                            <h3><small><%=currentProgram.getTarget()%></small></h3>
                        </div><!--/col-xs-5-->
                      </div>
                      
                      <!--SPACER-->
                        <div class="col-xs-12"><br></div>
                    <!--SPACER-->
                      
                      
                      <div class="col-xs-12">
                          <label class="col-xs-2 control-label">Target Disease:</label>
                          <div class="col-xs-5">
                            <h3><small><%=d.getDiagnosis()%></small></h3>

                        </div>
                     </div>
                     
                      <!--SPACER-->
                        <div class="col-xs-12"><br></div>
                    <!--SPACER-->
                     
                     
                      <div class="col-xs-12">
                        <label class="col-xs-2 control-label">Target Participants:</label>
                      </div>
                      
                      <div class="col-xs-12">
                          <div class="col-xs-2"></div>
                          <div class="col-xs-8">
                                <div class="row">
                                <div class="col-xs-2">
                                <label>
                                 <!-- <input type="checkbox" class="flat" checked="checked"> -->Age Range
                                </label>
                                </div>

                                <div class="col-xs-4">
                                <h3><small>
                            <%                              
                              if (currentProgram.getAge_groups().size() >= 1) {
                                out.print(nDAO.getAgeGroup(currentProgram.getAge_groups().get(0)));
                                }

                                for (int x = 1; x < currentProgram.getAge_groups().size(); x++){
                                out.println(", " + nDAO.getAgeGroup(currentProgram.getAge_groups().get(x)));
                                }
                            %>    
                                </small></h3>
                                </div>    
                              </div>
                              <!--/row-->
                              <div class="row">&nbsp;</div>
                              <div class="form-group row">
                                <div class="col-xs-2">
                                <label>
                                  Gender
                                </label>
                                </div>

                                <div class="col-xs-10">
                                <h3><small><%=currentProgram.getGender()%>  </small></h3>
                                </div>    

                              </div>
                              <!--/row-->
                              <div class="row">&nbsp;</div>
                              <div class="row">
                                <div class="col-xs-2">
                                <label>
                                  Barangay
                                </label>
                                </div>

                                <div class="col-xs-4">
                            <h3><small>
                            <%
                               if (currentProgram.getBrgy().size() >= 1) {
                                    out.print(currentProgram.getBrgy().get(0));
                                }

                                for (int x = 1; x < currentProgram.getBrgy().size(); x++) { 
                                     out.print(", " + currentProgram.getBrgy().get(x));
                                }
                            %>
                            </small></h3>
                            
                                </div>  

                              </div>
                            </div><!--DEMOGRAPHICS-->
                      </div>
                      
                      <!--SPACER-->
                        <div class="col-xs-12"><br></div>
                    <!--SPACER-->
                      
                      
                    </div><!--/form-group-->
                    
                    
                    <!--BRIEF DESCRIPTION-->
                    <div class="form-group row">
                       <div class="col-xs-12 col-sm-12 col-xs-12">
                            <label class="control-label">Brief Description:</label>
                        </div>
                        <div class="col-xs-12">
                            <%=currentProgram.getDescription()%>
                        </div><!--/col-xs-5-->

                    </div>
                    <!--END OF DESCRIPTION-->      
                    
                    
                    <!--RESOURCE-->
                    <div class="form-group row">
                        <div class="col-xs-12 col-sm-12 col-xs-12">
                            <label class="control-label">Resource Plan:</label>
                        </div>
                        <div class="col-xs-12">
                            <%      
                            if(currentProgram.getResource_plan() == null){
                            out.println("None");
                            }else{
                            out.println(currentProgram.getResource_plan());
                            }
                            %> 
                        </div><!--/col-xs-5-->
                    </div>
                    <!--RESOURCE-->  
                                                                      

                </div>
                <!--x_content buong form-->

            <!-- End of Program Proposal-->
                          

                 <div class="col-xs-12">&nbsp;</div>
            
            <!-- SIGNATORIES-->
            <div class="row">
                <div class="col-xs-1"></div>

                <div class="col-md-2">
                   <div class="row"> 
                        <label class="control-label">Prepared By:</label>
                    </div>
                    <br>
                    <div class="row">
                        <b><%=proposedBy.getFullname()%></b>
                    </div>
                    <div class="row">
                      <p style="font-style: italic;">
                           <% if (proposedBy.getPosition().equalsIgnoreCase("physician")){
                               out.println("Head Physician - RHU I");
                           }else{
                               out.println(proposedBy.getBarangay() + proposedBy.getPosition());
                           } %>
                      </p>
                    </div>
                </div>

                <div class="col-xs-5"></div>

                <div class="col-md-2">
                   <div class="row"> 
                        <label class="control-label"></label>
                    </div>
                    <br>
                    <div class="row">
                        <b>Tungol, Renelyn Dimao</b>
                    </div>
                    <div class="row">
                      <p style="font-style: italic;">
                           Head Physician - RHU I
                      </p>
                    </div>
                </div>
                
            </div>
            
            <br>
            
            <div class="row">
                <div class="col-xs-1"></div>

                <div class="col-md-2">
                   <div class="row"> 
                        <label class="control-label">Noted By:</label>
                    </div>
                    <br>
                    <div class="row">
                        <b>Aquino, Eloisa S., MD, MPH</b>
                    </div>
                    <div class="row">
                      <p style="font-style: italic;">
                           City Health Officer
                      </p>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <center><b>Recommending Approval:</b></center>
                <br>
            </div>
            
            <div class="row">
                <div class="col-xs-1"></div>

                <div class="col-md-2">
                    <div class="row">
                        <b>Rivera, Maria Gisel P.</b>
                    </div>
                    <div class="row">
                      <p style="font-style: italic;">
                           City Accountant 
                      </p>
                    </div>
                </div>

                <div class="col-xs-5"></div>

                <div class="col-md-2">
                    <div class="row">
                        <b>Engr. Limbitco, Fernando A.</b>
                    </div>
                    <div class="row">
                      <p style="font-style: italic;">
                           City Administrator
                      </p>
                    </div>
                </div>

            </div>
            
            <div class="row">
                <center><b>Approved:</b></center>
                <br>
                <div class="row">
                    <div class="col-xs-5"></div>
                    <div class="col-md-2">
                        <div class="row">
                            <b>Santiago, Edwin D.</b>
                        </div>
                        <div class="row">
                          <p style="font-style: italic; text-align: center">
                               City Mayor 
                          </p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- END OF SIGNATORIES-->
        </div><!--wrapper-->
            
        
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
</body>
   
   
<!--Create Program-->
<script>
function showDiv() {
   document.getElementById('programproposalcard').style.display = "";
   document.getElementById('createprogram').style.display = "none";
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
