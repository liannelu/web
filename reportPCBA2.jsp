<%@page import="Model.Diagnosis"%>
<%@page import="Model.User"%>
<%@page import="Model.Family_Code"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="DAO.m2DAO"%>
<%@page import="Model.Consultation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date;"%>
<%@page import="java.util.Calendar"%>

<%  
    String tempMonth = "";
    String tempYear = "";
    String tempBarangay= "";
    String tempBHS="";
    
    String tempDate = ""; 
    Calendar cal = Calendar.getInstance();
        int numyear = cal.get(Calendar.YEAR);
        int nummonth = cal.get(Calendar.MONTH) +1;
    tempDate = String.valueOf(numyear);
    
    if(session.getAttribute("m2Date") != null){
        tempMonth = (String) session.getAttribute("m2Month");
        tempYear = (String) session.getAttribute("m2Year").toString();
        tempBarangay = (String) session.getAttribute("selectedBarangay");
        tempBHS = (String) session.getAttribute("selectedBarangay");
        
        if(tempBarangay.equals("0")){
            tempBarangay = "All Barangays";
            tempBHS = "All BHS";
        }else if(tempBarangay.equals("Dolores")){
            tempBHS = "Dolores North & South";
        }else if(tempBarangay.equals("Sto. Nino")){
            tempBHS = "Sto. Nino North & South";
        }
    }
    /*
    if((String) session.getAttribute("m2Month") != null){
        tempMonth = (String) session.getAttribute("m2Month");
    }
    if((String) session.getAttribute("m2Year") != null){
        tempYear = (String) session.getAttribute("m2Year");
    }
    */

%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> PCB A2 Report </title>

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
    <!-- bootstrap-datepicker -->
    <link href="vendors/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="source/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">

<!--TITLE-->
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
            <li class="breadcrumb-item">Reports</li>
            <li class="breadcrumb-item active">PCB A2</li>
        </ol>
    
    <!--PAGE TITLE--> 
    <div class="col-md-12 col-sm-12 col-xs-12">
        
        <form action="ReportM2" post="post">
        
         <div class="x_panel">
              <div class="x_content">
                <div class="form-group">
                <h4 class="card-title">PCB PROVIDER CLIENTELE PROFILE</h4>
                <h6 class="card-subtitle md-2 text-muted">Select Year</h6>
                    
                    <!--INSERT ajax to load db data from selected month & year -->
<!--                    <div class="form-group row">-->
                    <div class="col-md-3">
                      <label for="example-month-input" class="col-2 col-form-label">Year</label>
                      <div class="col-12">
                            <%   
                            if(session.getAttribute("m2Date") != null){
                                tempDate = (String) session.getAttribute("m2Date");
                            }%>
                        <input class="form-control" name="selectedDate" type="text" value="<%=tempDate%>" id="example-month-input">
                      </div>
                    </div>
                          
                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-0">
                        <label for="" class="col-form-label"></label>
                        <div class="col-12"><br>
                            <button type="submit" class="btn btn-primary ">Generate Report</button>
                            <a href="program_planning_without_disease.jsp" class="btn btn-primary "><i class="fa fa-file-text-o"></i> Propose Program</a>
                            <a class="btn btn-default" href="print_reportM2.jsp"><i class="fa fa-print"></i> Print</a>
                        </div>
                    </div>
                    

                  
               
                  
             </div>
              </div> <!--x_content-->
            </div> <!--x_panel-->
        
        </form>
        
        <!-- PCB A2 Report -->
        <div class="x_panel">
        
            <div class="x_title">
            <h2><i class="fa fa-bars"></i> PCB <small>A2 PROVIDER CLIENTELE PROFILE</small></h2>
            <div class="clearfix"></div>
          </div>
           
            
           <div class="x_content">  
            
            <table style="border-collapse: collapse;text-align: left; font-family: tahoma; width: 1140px; height: 3px; font-size: 13px; " border="0" cellpadding="0" cellspacing="0">
                <tbody>
                <tr>
                    <td style="vertical-align: middle; width: 320px;">
                        <img src="images/philhealth-pcb-icon-2.png" height="85"  /><img src="images/doh.jpg" height="85"  />	</td>
                    <td style="vertical-align: middle; width: 500px;">
                        <div style="text-align: center; font-weight: bold;  color: rgb(0, 153, 0);">PHILIPPINE
                        HEALTH INSURANCE CORPORATION<br>
                        </div>
                        <div style="text-align: center; font-weight: bold;  color: rgb(0, 153, 0);">PCB PROVIDER CLIENTELE PROFILE
                        </div><br>
                        <div style="text-align: center; font-weight: bold;  color: rgb(0, 153, 0);"><u>CITY OF SAN FERNANDO (CAPITAL) RURAL HEALTH UNIT I</u><br>
                        </div>
                        <div style="text-align: center; font-weight: bold; width: 500px;  color: rgb(0, 153, 0);">NAME
                        OF HEALTH CARE FACILITY<br>
                    </div>
                    </td>
                    
                <td style="vertical-align: middle; width: 100px;"></td>
                <td style="vertical-align: middle; width: 220px;">
                <img src="images/philhealth-logo.jpg" height="85" /></td>
                </tr>
                </tbody>
            </table>
            
            <br>
            
            <table style="border-collapse:collapse;text-align: left; width: 1150px; height: 346px; font-family: tahoma;"
            border="0" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
            <td style="vertical-align: middle;">&nbsp;&nbsp;</td>

            <!-- I. PCB PROVIDER DATA -->
            <td style="vertical-align: middle; width: 350px; height: 360px;">
                <table style="border-collapse:collapse;text-align: left; height: 353px; width: 350; font-size: 12px; font-family:tahoma; text-indent: 5px;"
                            border="1" cellpadding="0" cellspacing="0">
                    <tbody>
                        <tr>
                        <td colspan="5" style="vertical-align: middle; width: 300px; "><span style="font-weight: bold; ">I. PCB Provider Data</span></td>
                        </tr>
                        <tr>
                        <td colspan="2">Region:</td>
                        <td colspan="3">Region 3</td>
                        </tr>
                        <tr>
                        <td colspan="2">Province:</td>
                        <td colspan="3">PAMPANGA</td>
                        </tr>
                        <tr>
                        <td colspan="2">City/Municipality:</td>
                        <td colspan="3">CITY OF SAN FERNANDO (Capital)</td>
                        </tr>
                        <tr>
                        <td rowspan="2" style="vertical-align: middle; width: 66px; text-align: center; font-weight: bold;">Members</td>
                        <td rowspan="2" style="vertical-align: middle; width: 66px; text-align: center; font-weight: bold;">No. of Assigned Families</td>
                        <td rowspan="2" style="vertical-align: middle; width: 66px; text-align: center; font-weight: bold;">No. of Enlisted Families</td>
                        <td colspan="2" style="vertical-align: middle; width: 66px; text-align: center; font-weight: bold;">No. of Profiled Individuals</td>
                        </tr>
                        <tr>
                        <td style="vertical-align: middle; width: 66px; text-align: center; font-weight: bold;">Members</td>
                        <td style="vertical-align: middle; width: 66px; text-align: center; font-weight: bold;">Dependent</td>
                        </tr>
                        <tr>
                        <td colspan="5" style="vertical-align: middle; width: 243px;  background-color: rgb(123, 124, 124);"><span style="font-weight: bold; ">Sponsored:</span></td>
                        </tr>
                        <tr style="text-align: center;">
                        <td>NHTS</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        </tr>
                        <tr style="text-align: center;">
                        <td>LGU</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        </tr>
                        <tr style="text-align: center;">
                        <td>NGA</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        </tr>
                        <tr style="text-align: center;">
                        <td>Private</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        </tr>
                        <tr>
                        <td colspan="5" style="vertical-align: middle; width: 243px; background-color: rgb(123, 124, 124);"><span style="font-weight: bold; ">IPP:</span></td>
                        </tr>
                        <tr style="text-align: center;">
                        <td>OFW</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        </tr>
                        <tr>
                        <td colspan="5" style="vertical-align: middle; width: 243px; background-color: rgb(123, 124, 124);"><span style="font-weight: bold; ">Employed:</span></td>
                        </tr>
                        <tr style="text-align: center;">
                        <td>DepEd</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        </tr>
                        <tr style="text-align: center;">
                        <td>Non PHIC</td>
                        <td colspan = '4'>0</td>
                        </tr>


                    </tbody>
                </table>
            </td>
            <!-- END OF I. PCB PROVIDER DATA -->

            <td >&nbsp;&nbsp;&nbsp;&nbsp;</td>

            <td style="vertical-align: middle; width: 356px; height: 360px;">
                <table style="border-collapse:collapse;text-align: left; width: 346px; height: 33px; font-size: 14px; font-family:tahoma; " border="0" cellpadding="2" cellspacing="2">
                    <tbody>
                        <tr>
                        <td style="vertical-align: middle;"><br></td>
                        <td style="vertical-align: middle;"><br></td>
                        </tr>
                    </tbody>
                </table>
                
            <br>

            <!--II. Age-Sex Distribution -->
            <table style="border-collapse:collapse;text-align: left; height: 250px; width: 319px; font-size: 12px; font-family:tahoma; text-indent: 5px;"border="1" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr style="font-weight: bold;">
                    <td colspan="7" rowspan="1" style="vertical-align: middle; ">II. Age-Sex Distribution<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 300px; text-align: center; font-weight: bold;">Age Group<br></td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 66px; text-align: center; font-weight: bold;">Members<br></td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 66px; text-align: center; font-weight: bold;">Dependent<br></td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 66px; text-align: center; font-weight: bold;">Total<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 135px; font-weight: bold;"><br></td>
                        <td style="vertical-align: middle; width: 55px; text-align: center; font-weight: bold;">M<br></td>
                        <td style="vertical-align: middle; width: 55px; text-align: center; font-weight: bold;">F<br></td>
                        <td style="vertical-align: middle; width: 55px; text-align: center; font-weight: bold;">M<br></td>
                        <td style="vertical-align: middle; width: 55px; text-align: center; font-weight: bold;">F<br></td>
                        <td style="vertical-align: middle; width: 55px; text-align: center; font-weight: bold;">M<br></td>
                        <td style="vertical-align: middle; width: 55px; text-align: center; font-weight: bold;">F<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 175px; ">0 -1 Years<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 175px;">2 - 5 Years<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 175px;">6 - 15 Years<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 175px;">16 - 24 Years<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 175px;">25 - 59 years<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 175px;">60 years and above<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                    </tr>
                    </tr>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 175px; text-align: center; ">Total<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 61px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 175px; text-align: center; "><b>Grand Total</b><br></td>
                        <td colspan="2"  style="vertical-align: middle; text-align: center; width: 61px;"><b>0</b><br></td>
                        <td colspan="2"  style="vertical-align: middle; text-align: center; width: 61px;"><b>0</b><br></td>
                        <td colspan="2"  style="vertical-align: middle; text-align: center; width: 61px;"><b>0</b><br></td>
                    </tr>
                </tbody>
            </table>
            <!-- END OF II. Age-Sex Distribution -->
            <br>
            </td><!-- style="vertical-align: middle; width: 356px; height: 360px;" -->
            
            <td style="vertical-align: middle; height: 360px; width: 11px;"><br></td>
            
            <td style="vertical-align: middle; width: 461px; height: 360px;">
                <table style="border-collapse:collapse;text-align: left; width: 418px; height: 32px; font-size: 11px; font-family:tahoma;" border="0" cellpadding="2" cellspacing="2">
                    <tbody>
                        <tr>
                            <td style="vertical-align: middle;"><br></td>
                            <td style="vertical-align: middle;"><br></td>
                            <td style="vertical-align: middle;"><br></td>
                        </tr>
                    </tbody>
                </table>
                    <br>
                <table style="text-align: left;border-collapse:collapse; width: 400px; height: 115px; font-size: 12px; font-family:tahoma; text-indent: 5px;" border="1" cellpadding="0" cellspacing="0">
                    <tbody>
                            <tr>
                                <td style="vertical-align: middle; width: 227px; font-weight: bold;">III. Primary Preventive Services<br></td>
                                <td colspan="2" rowspan="1" style="vertical-align: middle; width: 95px; text-align: center;"># of female screened<br></td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle; width: 227px; background-color: rgb(123, 124, 124);"><br></td>
                                <td style="vertical-align: middle; width: 95px; text-align: center;">Member<br></td>
                                <td style="vertical-align: middle; width: 107px; text-align: center;">Dependent<br></td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle; width: 227px;">Breast Cancer Screening<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Female, 25 years old and above<br></td>
                                <td style="vertical-align: middle; width: 95px; text-align: center;">0<br></td>
                                <td style="vertical-align: middle; width: 107px; text-align: center;">0<br></td>
                            </tr>
                            <tr>
                                <td style="vertical-align: middle;">Cervical Cancer, Screening<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Female, 25 to 55 years old with <br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        intact uterus<br>
                                </td>
                                <td style="vertical-align: middle; text-align: center;">0<br></td>
                                <td style="vertical-align: middle; text-align: center;">0</td>
                            </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        </tbody>
        </table>
        
        <table style="border-collapse:collapse;text-align: left; width: 1147px; height: 294px; font-size: 11px; font-family:tahoma;" border="0" cellpadding="0" cellspacing="0">
        <tbody>
        <tr>

        <!--III. Diabetes Mellitus-->
        <td style="vertical-align: middle; width: 529px; height: 200px;">
        <table style="border-collapse:collapse;text-align: left; margin-left: 7px; width: 501px; height: 200px; font-size: 12px; font-family:tahoma; text-indent: 5px;" border="1" cellpadding="0" cellspacing="0">
            <tbody>
                    <tr>
                        <td style="vertical-align: middle; width: 245px; font-weight: bold;">III. Diabetes Mellitus<br></td>
                        <td colspan="6" rowspan="1" style="vertical-align: middle; width: 41px; text-align: center; font-weight: bold;"># of Members and Dependets<br></td>
                    </tr>
                    <tr>
                        <td colspan="1" rowspan="2" style="vertical-align: middle; width: 245px; text-align: center; font-weight: bold;">Cases</td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 41px; text-align: center; font-weight: bold;">Members<br></td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 42px; text-align: center; font-weight: bold;">Dependent<br></td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 46px; text-align: center; font-weight: bold;">Total</td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 41px; text-align: center; font-weight: bold;">M<br></td>
                        <td style="vertical-align: middle; width: 41px; text-align: center; font-weight: bold;">F<br></td>
                        <td style="vertical-align: middle; width: 42px; text-align: center; font-weight: bold;">M<br></td>
                        <td style="vertical-align: middle; width: 40px; text-align: center; font-weight: bold;">F<br></td>
                        <td style="vertical-align: middle; width: 31px; text-align: center; font-weight: bold;">M<br></td>
                        <td style="vertical-align: middle; width: 46px; text-align: center; font-weight: bold;">F<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 245px;">with symptoms/signs of polyuria, &nbsp;polydipsia, weight loss<br></td>
                        <td style="vertical-align: middle; text-align: center;  width: 41px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 41px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width:42px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width:40px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 31px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center;  width:46px;">0<br></td>
                    </tr>
                    <tr>
                        <td colspan="1" rowspan="3" style="vertical-align: middle; width: 245px;">Waist Circumference<br>&nbsp;&nbsp;&nbsp;&nbsp; <span style="text-decoration: underline;">&gt;</span>
                                80 cm (female)<br>
                                &nbsp;&nbsp;&nbsp;&nbsp; <span style="text-decoration: underline;">&gt;</span>
                                90 cm (male)<br>
                        </td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 41px; background-color: rgb(123, 124, 124);">&nbsp;<br></td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 42px; background-color: rgb(123, 124, 124);"><br></td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 46px; background-color: rgb(123, 124, 124);"><br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 31px; background-color: rgb(123, 124, 124);"><br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 31px;">0<br></td>
                        <td style="vertical-align: middle; width: 31px; background-color: rgb(123, 124, 124);"><br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 40px;">0<br></td>
                        <td style="vertical-align: middle; width: 31px; background-color: rgb(123, 124, 124);"><br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 46px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle;  text-align: center; width: 41px;">0<br></td>
                        <td style="vertical-align: middle; width: 31px; background-color: rgb(123, 124, 124);"><br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 41px;">0<br></td>
                        <td style="vertical-align: middle; width: 31px; background-color: rgb(123, 124, 124);"><br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 31px;">0<br></td>
                        <td style="vertical-align: middle; width: 31px; background-color: rgb(123, 124, 124);"><br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 245px;">History of diagnosis of diabetes<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 41px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 41px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 42px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 40px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 31px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 46px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 245px;">Intake of oral hypoglycemic agents<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 41px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center;width: 41px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 42px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 40px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 31px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 46px;">0<br></td>
                    </tr>
            </tbody>
        </table>
        <br>
        </td>
        <td style="vertical-align: middle; width: 598px;">
            <table style="border-collapse:collapse;text-align: left; height: 262px; width: 593px; font-size: 12px; font-family:tahoma; text-indent: 5px;" border="1" cellpadding="0" cellspacing="0">
            <tbody>
                    <tr>
                        <td style="vertical-align: middle; width: 202px; font-weight: bold;">IV. Hypertension<br></td>
                        <td colspan="7" rowspan="1" style="vertical-align: middle; width: 61px; text-align: center; font-weight: bold;"># of Members and Dependents<br></td>
                    </tr>
                    <tr>
                        <td colspan="1" rowspan="3" style="vertical-align: middle; width: 202px; text-align: center; font-weight: bold;"><br>Cases<br></td>
                        <td colspan="3" rowspan="1" style="vertical-align: middle; width: 61px; text-align: center; font-weight: bold;">Members<br></td>
                        <td colspan="3" rowspan="1" style="vertical-align: middle; width: 49px; text-align: center; font-weight: bold;">Dependents<br></td>
                        <td colspan="1" rowspan="3" style="vertical-align: middle; width: 52px; text-align: center;"><span style="font-weight: bold;"><br>Total</span><br></td>
                    </tr>
                    <tr>
                        <td colspan="1" rowspan="2"style="vertical-align: middle; width: 42px; text-align: center; font-weight: bold;">Male<br></td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 61px; text-align: center; font-weight: bold;">Female</td>
                        <td colspan="1" rowspan="2" style="vertical-align: middle; width: 35px; text-align: center; font-weight: bold;">Male<br></td>
                        <td colspan="2" rowspan="1" style="vertical-align: middle; width: 49px; text-align: center; font-weight: bold;">Female</td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 53px; text-align: center; font-weight: bold;">Non<br>Pregnant<br></td>
                        <td style="vertical-align: middle; width: 61px; text-align: center; font-weight: bold;">Pregnant<br></td>
                        <td style="vertical-align: middle; width: 58px; text-align: center; font-weight: bold;">Non<br>Pregnant</td>
                        <td style="vertical-align: middle; width: 49px; text-align: center; font-weight: bold;">Pregnant</td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 202px; text-align: center;">Adult with <span style="font-weight: bold;">BP &lt; 140/ 90</span><br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 42px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 53px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 35px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 49px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 52px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 202px; text-align: center;">Adult with <span style="font-weight: bold;">BP &gt;/ = 140/90</span> but less than <span style="font-weight: bold;">180/120mmHg</span><br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 42px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 53px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 35px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 49px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 52px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 202px; text-align: center;">Adult with <span style="font-weight: bold;">BP &gt; 180/120</span><br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 42px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 53px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 35px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 49px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 52px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 202px; text-align: center;">History of diagnosis of hypertension<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 42px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 53px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 35px;">0<br></td>
                        <td style="vertical-align: middle; text-align: center; width: 58px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 49px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 52px;">0<br></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: middle; width: 202px; text-align: center;">Intake of hypertension medicine<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 42px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 53px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 61px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 35px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center; width: 49px;">0<br></td>
                        <td style="vertical-align: middle;  text-align: center;width: 52px;">0<br></td>
                    </tr>
            </tbody>
        </table>
        <br>
        </td>
        </tr>
        </tbody>
        </table>

            </div><!--x_content-->
        </div> <!--x_panel--> <!-- END of PCB REPORT-->
        
        
        
   </div> <!--col-sm-6-->
   
    <!-- MAIN FRAME 
    <div id="p1" style="text-align: center">
       <div class="col-md-12">
            <iframe src="m2/p1.html" name="targetframe" allowTransparency="true" scrolling="no"  style="overflow: hidden; position: relative; width: 909px; height: 1286px;">
            </iframe>
        </div>
    </div>-->
   
   
        </div> <!--right_col-->
    </div> <!--main_container-->
</div> <!--cotainer body -->
    
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
                <!-- boostrap-datepicker -->
                 <script src="vendors/bootstrap-datepicker/dist/js/bootstrap-datepicker.js"></script>
                
                <!-- Custom Theme Scripts -->
                <script src="source/js/custom.min.js"></script>
   
</body>
<script type="text/javascript">
  $('#example-month-input').datepicker({
     minViewMode: 2,
     format: 'yyyy'
   });
</script>
</html>