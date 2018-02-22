<%@page import="Model.User"%>
<%@page import="Model.Diagnosis"%>
<%@page import="DAO.userDAO"%>
<%@page import="DAO.doctorDAO"%>
<%@page import="java.util.ArrayList"%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> View Diagnosis </title>

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

<body class="nav-md">
    <div class="container body">
        <div class="main_container">
            
        <%
           String userType = (String) session.getAttribute("position");
            int user_id = (Integer) session.getAttribute("user_id");
            
            //ACCESS CONTROL
            if (!userType.equalsIgnoreCase("physician")){
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
                   <li class="breadcrumb-item" ><a href="home.jsp">  Home </a></li>
                    <li class="breadcrumb-item">Analytics </li>
                   <li class="breadcrumb-item active"> Manage Disease/Diagnosis</li>
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
                            <h2><span class="fa fa-exclamation"></span> <%=error%></h2>
                          </div>
                         <%}%>
                         <%
                            String success=(String)request.getAttribute("success");  
                            if(success!=null){
                         %>
                           <div class="alert alert-success alert-dismissible fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">X</span>
                            </button>
                            <h2><span class="fa fa-check-circle"></span> <%=success%></h2>
                          </div>
                          <%}%>
                          <!--banner-->

                       <!-- <div class="page-title">
                            <div class="title_left">
                                <h3><i class="fa fa-users"></i> Manage Diagnosis </h3>        
                            </div>

                        </div>-->
                        <!--page-title-->
                        
                        <div class="x_panel">
                            <div class="x_title">
                                <h4><i class="fa fa-book"></i>
                                <!--get information from database!!-->
                                <strong>Manage Disease/Diagnosis </strong> 
                                <!-- Elements-->
<!--                                <button  onClick="window.location='addUser.jsp';" type="submit" class="btn btn-sm btn-primary" style="float: right"><i class="fa fa-user"></i> Add New Disease </button>-->
                                </h4>
                                
                                <div class="clearfix"></div>
                            </div>
                            
                           <!-- <form action="SetThreshold" method="post"> -->
                            <div class="x_content">
                                <div class="col-md-12">

                                        
                                    <table id="datatable-responsive" class="table table-bordered dt-responsive nowrap table-condensed" cellspacing="0" width="100%">
                                      <thead>
                                        <tr>
                                          <th>ID</th>
                                          <th width="40%">Disease/Diagnosis Name</th>
                                          <th style="text-align:center;">Threshold</th>
                                          <th width="10%">Action</th>
                                        </tr>
                                      </thead>
                                      
                                      
                                      <tbody>
                                          <%
                                              doctorDAO dDAO = new doctorDAO();
                                              ArrayList <Diagnosis> dList = new ArrayList();
                                                        dList = dDAO.getAllDiseases();
                                                    for(int x=0; x < dList.size();x++){
                                          
                                          %>
                                            <tr>
                                                <td><%=dList.get(x).getDiagnosis_id()%></td>
                                                <td><%=dList.get(x).getDiagnosis()%></td>
                                                <td style="text-align:center;"><%=dList.get(x).getThreshold()%></td>
<!--                                                <input type="number" value="1">-->
                                                <td style="text-align:center;">
                                                    <button class="btn btn-sm btn-warning" data-toggle="modal" data-target=".fammembers-modal<%=x%>" >Edit</button>
                                                </td>
<!--                                                contenteditable="false"-->
                                            </tr>
                                            <%}%>
                                      </tbody>
                                      
                                    </table>
                                        <br><br><br> 
                                    
                                    <!-- MODAL (GRP) -->
                                    <form action="SetThreshold" method="post">
                                    <%
                                               dDAO = new doctorDAO();
                                              dList = new ArrayList();
                                                        dList = dDAO.getAllDiseases();
                                                    for(int x=0; x < dList.size();x++){
                                          
                                          %>
                                    <div class="modal fade fammembers-modal<%=x%>" tabindex="-1" role="dialog" aria-hidden="true">
                                            <div class="modal-dialog modal-sm">
                                              <div class="modal-content">

                                                <div class="modal-header">
                                                  <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">X</span>
                                                  </button>
                                                  <strong class="modal-title" id="myModalLabel">Edit Threshold of Disease/Diagnosis</strong>
                                                </div>
                                                <div class="modal-body">

                                    <div class="x_panel">
                                            <div class="x_content">

                                           <!--inputsSS-->
                                            <div class="col-md-12" align="center">
                                                <h2><%=dList.get(x).getDiagnosis()%> </h2>
                                                <br>
                                            </div>
                                             
                                            <div class="col-md-1"></div>
                                            <label class="col-md-5 col-form-label" for="threshold" >Threshold:</label>
                                             <div class="col-md-5"> 
                                             <input type="number" class="form-control noMargin" onkeypress="return isNumberKey(event)"  name="threshold<%=dList.get(x).getDiagnosis_id()%>" value="<%=dList.get(x).getThreshold()%>" > 
                                            </div>

                                            </div><!--x_content-->
                                     </div><!--/x_panel-->

                                               </div>
                                                <!--modal-body-->

                                                <div class="modal-footer">
                                                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                  <button type="submit" name="setThreshold" value="<%=dList.get(x).getDiagnosis_id()%>" class="btn btn-success">Save changes</button>
                                                </div>

                                              </div>
                                            </div>
                                    </div>
                                    <%}%> 
                                    </form>
                                    
                                </div> <!--col-12-->
                            </div> <!--x_content-->
                            
                            <!--</form> -->
                        </div><!--x_panel-->
                        <!--END PATIENT TABLE-->

                    </div>
                </div>
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
<script>
    $(".btn[data-target='#myModal']").click(function() {
           var columnHeadings = $("thead th").map(function() {
                     return $(this).text();
                  }).get();
           columnHeadings.pop();
           var columnValues = $(this).parent().siblings().map(function() {
                     return $(this).text();
           }).get();
      var modalBody = $('<div id="modalContent"></div>');
      var modalForm = $('<form></form>');
      $.each(columnHeadings, function(i, columnHeader) {
           var formGroup = $('<div class="form-group"></div>');
           formGroup.append('<label for="'+columnHeader+'">'+columnHeader+'</label>');
           formGroup.append('<input class="form-control" name="'+columnHeader+i+'" id="'+columnHeader+i+'" value="'+columnValues[i]+'" />'); 
           modalForm.append(formGroup);
      });
      modalBody.append(modalForm);
      $('.modal-body').html(modalBody);
    });
    $('.modal-footer .btn-primary').click(function() {
       $('form[name="modalForm"]').submit();
    });     

</script>
<script>
function isNumberKey(evt){
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }                               
</script>
    </body>

</html>