<%@page import="Model.Patient"%>
<%@page import="Model.Program"%>
<%@page import="Model.Patient"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date;"%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Program Evaluation </title>

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
    <!-- starRating -->
    <link href="vendors/bootstrap-star-rating/css/star-rating.css" rel="stylesheet">
    <!-- bootstrap-datetimepicker -->
    <link href="vendors/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.css" rel="stylesheet">

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
        <div class="right_col edited" role="main">
            
          <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="home.jsp">  Home </a></li>
                <li class="breadcrumb-item">Program</li>
                <li class="breadcrumb-item active">Program Evaluation</li>
          </ol>
          
           <div class="col-md-12 col-sm-12 col-xs-12">
          
           <!--PROGRAM PLANNING Card-->
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
                    
                nurseDAO nDAO = new nurseDAO();
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
                        
                        <form action="EvaluateProgram" method="post">  
                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Program Title:</label>

                                <div class="col-md-5">
                                    <input type="text" required="required" class="form-control noMargin" id="title" name="title" value="<%=p.getTitle()%>" readonly placeholder="e.g. Feeding Program">
                                </div><!--/col-md-5-->
                            </div>

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Proposed Date:</label>

                                <div class='col-md-4'>
                                    <div class="form-group">
                                        <div class='input-group date' id='datetimepicker6'>

                                            <label class="input-group-addon" for="age_min" style="font-size:10px;">From</label>
                                            <input type="text" class="form-control" id="datepicker1" value="<%=p.getProposed_date_from()%>" disabled="diasbled" name="fromdate" >
                                            <label class="input-group-addon" for="age_min" style="font-size:10px;">To&nbsp;&nbsp;</label>
                                            <input type="text" class="form-control" id="datepicker2" value="<%=p.getProposed_date_to()%>" disabled="diasbled"  name="todate">
                                            <span class="input-group-addon" style="">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>

                                        </div>
                                    </div>
                                </div>

                                

                                

                                <div class='col-md-6'>
                                   <label class="col-md-3 control-label">Date Implemented:</label>
                                    <div class="form-group">
                                        <div class='input-group date' id='datetimepicker6'>

                                            <label class="input-group-addon" for="age_min" style="font-size:10px;">From</label>
                                            <input type="text" class="form-control" id="datepicker3" required="required" name="fromdate2" >
                                            <label class="input-group-addon" for="age_min" style="font-size:10px;">To&nbsp;&nbsp;</label>
                                            <input type="text" class="form-control" id="datepicker4" required="required" name="todate2">
                                            <span class="input-group-addon" style="">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div><!--/col-md-12-->

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Target vs Actual:</label>

                                <div class="col-md-2">
                                    <input type="text" required="required" class="form-control noMargin" value="<%=p.getTarget()%>" readonly id="title" name="target" placeholder="e.g. 1,000 children">
                                </div><!--/col-md-5-->

                                <div class="col-md-1" style="text-align:center">
                                    <h2>/</h2>
                                </div><!--/col-md-5-->

                                <div class="col-md-2">
                                    <input type="number" required="required" class="form-control noMargin" id="title" name="actualTarget" onkeypress="return isNumberKey(event)" placeholder="e.g. 1,000 children">
                                </div><!--/col-md-5-->

                            </div>

                            <!--SPACER-->
                            <div class="col-md-12"><br></div>
                            <!--SPACER-->

                            <!--RATING-->  
                            <div class="col-md-12">
                                <label class="col-md-2 control-label">Rating:</label>

                                <div class="col-md-5">
                                    <input id="rating-id" required="required" type="text" class="rating" name="rating" data-size="sm" data-min="0" data-max="5" data-step="1">
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
                                    <textarea class="form-control noresize" placeholder="What Went Well"  cols="12" rows="5" name="well" maxlength="100"></textarea>
                                </div>
                            <div class="col-md-4">
                                    <textarea class="form-control noresize" placeholder="What Went Wrong"  cols="12" rows="5" name="wrong" maxlength="100"></textarea>
                                </div>
                            <div class="col-md-4">
                                    <textarea class="form-control noresize" placeholder="Recommendations"  cols="12" rows="5" name="recommendation" maxlength="100"></textarea>
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
                                    <textarea class="form-control noresize" placeholder="Comments on the Project"  cols="12" rows="5" name="comments" maxlength="200"></textarea>
                                </div>

                            </div>
                            <!--END OF COMMENTS--> 
                        
                        <footer>
                            <div class="form-group" align="center">
                                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-2">
                                    <button  onclick="window.history.go(-1);" class="btn btn-default" type="button">Cancel</button>
                                    <button type="submit" class="btn btn-success" id="submitForm">Submit Evaluation</button>
                                </div>
                            </div>
                        </footer>
                        
                        </form>
                    </div><!--/form-group-->
                </div>
                <!--x_content buong form-->
                
                
               
                
                
                </div><!--x_panel buong form-->
            <!-- End of PROGRAM PLANNING-->
            
          
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
                <!-- bootstrap-datetimepicker -->    
                <script src="vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
                <script src="vendors/starrr/dist/starrr.js"></script>
                <!-- bootstrap datepicker -->
                <script src="vendors/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
                <!-- starRating -->
                <script src="vendors/bootstrap-star-rating/js/star-rating.js" type="text/javascript"></script>
                
                <!-- Custom Theme Scripts -->
                <script src="source/js/custom.min.js"></script>
</body>
   
<!--LIANNE SCRIPT-->
<script>
     $('#datepicker1').datetimepicker({
      format:'YYYY-MM-DD'
    });
    $('#datepicker2').datetimepicker({
        format:'YYYY-MM-DD'
    });
    $('#datepicker3').datetimepicker({
        format:'YYYY-MM-DD'
    });
    $('#datepicker4').datetimepicker({
        format:'YYYY-MM-DD'
    });
</script>
<script>
$("#rating-id").rating();

// with plugin options (do not attach the CSS class "rating" to your input if using this approach)
$("#rating-id").rating({'size':'sm'});    
</script>

<script>
$("#selectallimm").click(function () {
$(".adultimmunization").prop('checked', $(this).prop('checked'));
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
<!--TABLE WHAT WENT WRONG-->
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
        AddRow($("#txtWell").val(), $("#txtWrong").val(), $("#txtRecommendation").val());
        $("#txtWell").val("");
        $("#txtWrong").val("");
        $("#txtRecommendation").val("");
    };

    function AddRow(well, wrong, recommendation) {
        //Get the reference of the Table's TBODY element.
        var tBody = $("#tblWellWrong > TBODY")[0];

        //Add Row.
        row = tBody.insertRow(-1);

        //Add Name cell.
        var cell = $(row.insertCell(-1));
        cell.html(well);

        //Add Country cell.
        cell = $(row.insertCell(-1));
        cell.html(wrong);
        
        //Add Recommendations cell.
        cell = $(row.insertCell(-1));
        cell.html(recommendation);

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


</html>
