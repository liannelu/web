<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Create Custom Report</title>

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
    <!-- multiselect -->
    <link rel="stylesheet" href="vendors/bootstrap-multiselect/dist/css/bootstrap-multiselect.css" type="text/css"/>

    <!-- Custom Theme Style -->
    <link href="source/css/custom.min.css" rel="stylesheet">
    
    
<!--    <link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">-->
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
                   <li class="breadcrumb-item" ><a href="home.jsp">  Home </a></li>
                    <li class="breadcrumb-item"> Reports </li>
                   <li class="breadcrumb-item active">View Custom Report</li>
                </ol>   
                

                
                    <!-- <div class="row">-->
                    <div class="col-md-12 col-sm-12 col-xs-12">

                        <div class="page-title">
                            <div class="title_left">
                                <h3><i class="fa fa-users"></i> View Custom Report</h3>        
                            </div>

                        </div>
   
                        
                        
                        <!--page-title-->
                        <div class="x_panel">
                            <div class="x_title">
                                <h2> <strong><i class="fa fa-bar-chart-o"></i> Create Custom Report  </strong></h2> 
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="col-md-12  col-sm-9 col-xs-12">
                                <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-12"><h2>(Search by//Filter Patients)</h2></label>
                                    <div class="col-md-9 col-sm-9 col-xs-12">
                                      <select class="select2_single form-control" tabindex="-1">
                                        <option></option>
                                        <option value="AK">ALL PATIENTS</option>
                                        <option value="HI">DISEASE</option>
                                      </select>
                                    </div>
                                  </div>
                                    
                                    
                                    
                                </div>                               
                            </div>
                        </div>
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    <div class="x_panel">
                        <div class="x_title">
                            <h2> <strong><i class="fa fa-bar-chart-o"></i>  Filter By    </strong></h2> 
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">
                            <div class="col-md-12">
        


                                
                <div class="form-group row">
<!--https://bootsnipp.com/snippets/KrXA4-->
<!--                    VALUE IS USED FOR SEARCHING-->
                    <div class="form-group col-md-3">
                        <label>Disease</label><br/>
                        <select class="multipleselect" id="select-0" multiple="multiple" >
                            
                            <option value="Malaria" selected="selected">Malaria</option>
                            <option value="Dengue" selected="selected">Dengue</option>
                            <option value="Flu">Flu</option>
                            <option value="Diabetes">Diabetes</option>
                        </select>
                    </div>
                    
                    
                    <div class="form-group col-md-3">
                        <label>Gender</label><br/>
                        <select class="multipleselect" id="select-1" multiple="multiple" >
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>
                    </div>
                              
                               
                    <div class="form-group col-md-3">
                        <label>Barangay Location</label><br/>
                        <select class="multipleselect" id="select-2" multiple="multiple" >
                                <option value="Dolores North">Dolores North</option>
                                <option value="Juliana">Juliana</option>
                                <option value="Lourdes">Lourdes</option>
                                <option value="Magliman">Magliman</option>
                                <option value="San Jose">San Jose</option>
                                <option value="San Juan">San Juan</option>
                                <option value="Sta. Rosario">Sta. Rosario</option>
                                <option value="Sta. Teresita">Sta. Teresita</option>
                                <option value="Sto. Nino">Sto. Nino</option>
                        </select>
                    </div>

                    
                    <div class="form-group col-md-3">
                        <label>Symptoms</label><br/>
                        <select class="multipleselect" id="select-3" multiple="multiple" >
                            <option value="Rashes">Rashes</option>
                            <option value="Runny Nose">Runny Nose</option>
                            <option value="Sore Throat">Sore Throat</option>
                            <option value="Pale Skin">Pale Skin</option>
                        </select>
                    </div>
                </div>   <!-- end of row -->
                
                                
                                
                <br/>

                                
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Age Range </label>
                            <div class="input-group input-group-md col-md-12">
                                <label class="input-group-addon" for="age_min">Min</label>
                                <input type="number" class="form-control" id="age_min" minlength="1" maxlength="3" min="1" max="120" placeholder="0">
                                <label class="input-group-addon" for="age_max">Max</label>
                                <input type="number" class="form-control" id="age_max" minlength="1" maxlength="3" min="1" max="120"  placeholder="99">
                            </div>

                        </div><!-- /.form-group -->
                    </div><!-- /.col -->
                </div> <!-- row -->
                                
<br/>
                                
                                
                                
                <div class="form-group">
                    <label>Date Range </label>
                    <div class="input-group date col-md-3" id="myDatepicker2" >
                         
                        <label class="input-group-addon" for="age_min">From</label>
                        <input type="date" class="form-control" id="date_from">
<!--
                        <span class="input-group-addon" style="">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
--><!--
                    </div>
                    <div class="input-group date col-md-3" id="myDatepicker2" >
-->
                        <label class="input-group-addon" for="age_min">To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input type="date" class="form-control" id="date_to">
                        <span class="input-group-addon" style="">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
                                
                <br/>                                
                                
                <div class="row">
                    <div class="col-md-12">
                <button  onClick="window.location='view_custom_report.jsp';" type="submit" class="btn btn-block btn-md btn-primary" style="" width="100%"><i class="fa fa-user"></i> Generate Report </button>
                    </div><!-- /.col -->

                </div> <!-- row -->
                                
                                
                                
                                
                                

                
                        </div>
                    </div>
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
<!--page-title-->
<!--
                        <div class="x_panel">
                            <div class="x_title">
                                <h2> <strong><i class="fa fa-bar-chart-o"></i> Date  </strong></h2> 
                                search by date
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                                                
                                    <div class="well" style="overflow: auto">
                                        <div class="col-md-4">
                                            <div id="reportrange_right" class="pull-left" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                                                <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                                                <span>December 30, 2014 - January 28, 2015</span> <b class="caret"></b>
                                            </div>
                                        </div>

                                    </div>                                
                                  </div>
                                </div>                               
                            </div>
                        </div>
-->
                        
                        
                        <!--END PATIENT TABLE-->

                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    </div>
                        
                        
                        <div class="x_panel">
                            <div class="x_title">
                                <!--get information from database!!-->
                                <h2> <strong><i class="fa fa-list-alt"></i> Custom Report Table Name </strong></h2> 
                                
                                <!-- Elements-->
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="col-md-12  col-sm-12 col-xs-12">


                                </div>
                            </div> <!--x_content-->
                        </div><!--x_panel-->
                        <!--END PATIENT TABLE-->
                        
                        <div class="x_panel">
                            <div class="x_title">
                                <!--get information from database!!-->
                                <h2> <strong><i class="fa fa-bar-chart-o"></i> Custom Report Graph Name </strong></h2> 
                                
                                <!-- Elements-->
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <div class="col-md-12  col-sm-12 col-xs-12">


                                </div>
                            </div> <!--x_content-->
                        </div><!--x_panel-->
                        
                </div>
        </div>
    </div>


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
                <!--END OF CODE-->
<!--    J QUERY CODE // SCRIPT LINKS-->
                
                
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
            <!--multiselect-->
            <script src="vendors/bootstrap-multiselect/dist/js/bootstrap-multiselect.js"></script>
            
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
    
    
<!--  dropdown-->
<script>
var options = [];
$( '.dropdown-menu a' ).on( 'click', function( event ) {

   var $target = $( event.currentTarget ),
       val = $target.attr( 'data-value' ),
       $inp = $target.find( 'input' ),
       idx;

   if ( ( idx = options.indexOf( val ) ) > -1 ) {
      options.splice( idx, 1 );
      setTimeout( function() { $inp.prop( 'checked', false ) }, 0);
   } else {
      options.push( val );
      setTimeout( function() { $inp.prop( 'checked', true ) }, 0);
   }

   $( event.target ).blur();
      
   console.log( options );
   return false;
});
    
</script>
    
    
    
