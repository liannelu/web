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
    String tempQuarter= ""; //added by Lianne 
    
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

    <title> PCB A4 Report </title>

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
            <li class="breadcrumb-item active">PCB A4</li>
        </ol>
    
    <!--PAGE TITLE--> 
    <div class="col-md-12 col-sm-12 col-xs-12">
        
        <form action="ReportM2" post="post">
        
         <div class="x_panel">
              <div class="x_content">
                <div class="form-group">
                <h4 class="card-title">PCB Quarterly Report Form for Program Report</h4>
                <h6 class="card-subtitle md-2 text-muted">Select Year and Quarter</h6>

                <p class="card-text">
                  <div class="row col-md-3">
                    <div class="form-group-row">
                   
                    <!--INSERT ajax to load db data from selected month & year -->
                      <label for="example-month-input" class="col-2 col-form-label">Year</label>
                      <div class="col-12">
                            <%   
                            if(session.getAttribute("m2Date") != null){
                                tempDate = (String) session.getAttribute("m2Date");
                            }%>
                        <input class="form-control" name="selectedDate" type="text" value="<%=tempDate%>" id="example-month-input">
                      </div>
                      
                      </div> <!-- form-grou-row-->
                  </div> <!-- row col-md-3-->
                      
                    <div class="col-md-3">
                      <label for="example-date-input" class="col-2 col-form-label">Quarter</label>
                      <!--INSERT DATA FROM DB-->
                      <div class="col-12">
                        <select id="select" name="selectedQuarter" class="form-control">
                            <option <%if(tempQuarter.equals("1")){%>selected="selected"<%}%> value="1">First</option>
                            <option <%if(tempQuarter.equals("2")){%>selected="selected"<%}%> value="2">Second </option>
                            <option <%if(tempQuarter.equals("3")){%>selected="selected"<%}%> value="3">Third</option>
                            <option <%if(tempQuarter.equals("4")){%>selected="selected"<%}%> value="4">Fourth</option>
                        </select>
                            <!-- <span class="help-block">Please select your barangay</span> -->
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
        
        <!-- PCB A4 Report -->
        <div class="x_panel">
        
            
            <div class="x_title">
            <h2><i class="fa fa-bars"></i> PCB <small>Quarterly Report Form</small></h2>
            <div class="clearfix"></div>
          </div>
           
            
           <div class="x_content">
                
    <center>
        <table style="text-align: left; width: 1140px; height: 9px; font-family:tahoma;  font-size: 13px;"
        border="0" cellpadding="0" cellspacing="0">
        <tbody>
            <tr>
            <td style="vertical-align: middle; width: 320px;">
                <img src="images/philhealth-pcb-icon-2.png" height="75"  /><img src="images/doh.jpg" height="75"  />
            </td>
            
            <td style="vertical-align: middle; width: 500px;">
                <div style="text-align: center; font-weight: bold;  color: rgb(0, 153, 0);">PHILIPPINE
                HEALTH INSURANCE CORPORATION<br>
                </div>
                <div style="text-align: center; font-weight: bold;  color: rgb(0, 153, 0);">QUARTERLY
                REPORT FORM
                </div>
                <div style="text-align: center; font-weight: bold;  color: rgb(0, 153, 0);"><u></u><br>
                </div>
                <div style="text-align: center; font-weight: bold; width: 500px;  color: rgb(0, 153, 0);">NAME
                OF PCB PROVIDER<br>
                </div>
                <div style="text-align: center; font-weight: bold;  color: rgb(0, 153, 0);">HEALTH
                FACILITY DATA<br>
                </div>
                <div style="text-align: center;  color: rgb(0, 153, 0);"><span style="font-weight: bold;">SUMMARY
                OF BENEFITS AVAILMENT (Members and Dependents)</span><br>
                </div>
            </td>
            <td style="vertical-align: middle; width: 100px;"></td>
            <td style="vertical-align: middle; width: 220px;">
                <img src="images/philhealth-logo.jpg" height="75"  />
            </td>
            </tr>
        </tbody>
        </table>
    </center>
    
<br>

    <center>
        <table style="border-collapse: collapse; text-align: left; width: 1159px; height: 68px; font-family:tahoma;font-size: 13px;"
        border="0" cellpadding="0" cellspacing="0">
        <tbody>
            <tr>
                <td style="vertical-align: middle; width: 275px;">
                <table
                style="text-align: left; width: 260px; height: 200px; font-weight: bold; font-size: 13px; "
                border="1" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                    <td style="vertical-align: middle; margin-left: 8px; text-indent: 5px;" >I. Covered Period<br>
                    <table
                        style="text-align: left; width: 226px; margin-left: auto; margin-right: auto; height: 46px; font-size: 13px;"
                        border="1" cellpadding="0" cellspacing="0">
                        <tbody>
                        <tr>
                        <td
                        style="vertical-align: middle; width: 41px; text-align: left; text-indent: 5px;">From<br>
                        </td>
                        <td style="vertical-align: middle; width: 179px; text-indent: 5px;">January 2017 <!-- sample start date --><br>
                        </td>
                        </tr>
                        <tr>
                        <td
                        style="vertical-align: middle; width: 41px; text-align: left; text-indent: 5px;">To<br>
                        </td>
                        <td style="vertical-align: middle; width: 179px; text-indent: 5px;">March 2017 <!-- sample end date --><br>
                        </td>
                        </tr>
                        </tbody>
                    </table>
                        
                    <br>
                    
                    &nbsp;II. PCB Participation No.<br>
                    <table
                    style="text-align: left; height: 4px; margin-left: auto; margin-right: auto; width: 226px; font-size: 13px; text-indent: 5px;"
                    border="1" cellpadding="0" cellspacing="0">
                        <tbody>
                        <tr>
                        <td style="vertical-align: middle; width: 220px;"><br>
                        </td>
                        </tr>
                        </tbody>
                    </table>
                        
                    <br>
                    
                    &nbsp;III. Municipality/City/Province<br>
                    <table
                    style="text-align: left; width: 228px; height: 46px; margin-left: auto; margin-right: auto; font-size: 13px; text-indent: 5px;"
                    border="1" cellpadding="0" cellspacing="0">
                        <tbody>
                        <tr>
                        <td style="vertical-align: middle;"><br>
                        </td>
                        </tr>
                        <tr>
                        <td style="vertical-align: middle;"><br>
                        </td>
                        </tr>
                        </tbody>
                    </table>
                    
                    <br>
                    
                    </td>
                    </tr>
                </tbody>
                </table>
                </td>
                
            <td style="vertical-align: middle; width: 878px;">
                <table style="text-align: left; width: 864px; height: 2px; font-size: 13px; text-indent: 5px;"
                border="1" cellpadding="0" cellspacing="0">
                <tbody>
                <tr>
                <td style="vertical-align: middle;">
                <span
                style="font-weight: bold; ">IV. Obligated Services</span><br>
                    <table
                    style="text-align: left; height: 120px; margin-left: auto; margin-right: auto; width: 819px; font-size: 13px;"
                    border="1" cellpadding="0" cellspacing="0">
                    <tbody>
                    <tr>
                        <td style="vertical-align: middle; width: 208px;"
                        rowspan="1" colspan="3"><br>
                        </td>
                    </tr>
                    
                    <tr>
                        <td
                        style="vertical-align: middle; width: 389px; text-align: center; font-weight: bold; font-size: 13px;" >OBLIGATED
                        SERVICES<br>
                        </td>
                        <td
                        style="vertical-align: middle; width: 215px; font-weight: bold; font-size: 13px;">
                        <div style="text-align: center;">TARGET<br>
                        </div>
                        <div style="text-align: center;">(for the quarter)<br>
                        </div>
                        </td>
                        <td
                        style="vertical-align: middle; width: 208px; font-weight: bold; font-size: 13px;">
                        <div style="text-align: center;">ACCOMPLISHMENT<br>
                        </div>
                        <div style="text-align: center;">(number)<br>
                        </div>
                        </td>
                    </tr>
                    
                    <tr>
                        <td
                        style="vertical-align: middle; width: 389px; font-weight: bold; font-size: 13px; text-indent: 5px;">Primary
                        Preventive Services<br>
                        </td>
                        <td style="vertical-align: middle; width: 215px;"><br>
                        </td>
                        <td style="vertical-align: middle; width: 208px;"><br>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="vertical-align: middle; width: 389px; font-size: 13px;">&nbsp;&nbsp;
                        1. BP Measurement<br>
                        </td>
                        <td style="vertical-align: middle; text-align: center; width: 215px;"><input style="border:none; background-color: transparent; text-align: center;  width: 49%; font-size:13px; font-family: tahoma;" size="15" align="middle" value="0" >
                        </td>
                        <td style="vertical-align: middle; text-align: center; width: 208px;">0<br>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="vertical-align: middle; width: 389px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span style="font-style: italic;">Hypertensive</span><br>
                        </td>
                        <td style="vertical-align: middle; text-align: center; width: 215px;"><input style="border:none; background-color: transparent; text-align: center;  width: 49%; font-size:13px; font-family: tahoma;" size="15" align="middle" value="0" >
                        </td>
                        <td style="vertical-align: middle; text-align: center; width: 208px;">0<br>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="vertical-align: middle; width: 389px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span style="font-style: italic;">Nonhypertensive</span><br>
                        </td>
                        <td style="vertical-align: middle; text-align: center; width: 215px;"><input style="border:none; background-color: transparent; text-align: center;  width: 49%; font-size:13px; font-family: tahoma;" size="15" align="middle" value="0" >
                        </td>
                        <td style="vertical-align: middle; text-align: center; width: 208px;">0<br>
                        </td>
                    </tr>
                    
                    <tr>
                    <td style="vertical-align: middle; width: 389px;">&nbsp;&nbsp;
                        2. Periodic Clinical Breast Examination<br>
                        </td>
                        <td style="vertical-align: middle; text-align: center; width: 215px;"><input style="border:none; background-color: transparent; text-align: center;  width: 49%; font-size:13px; font-family: tahoma;" size="15" align="middle" value="0" >
                        </td>
                        <td style="vertical-align: middle;  text-align: center; width: 208px;">0<br>
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="vertical-align: middle; width: 389px;">&nbsp;&nbsp;
                        3. Visual Inspection with Acetic Acid<br>
                        </td>
                        <td style="vertical-align: middle; text-align: center; width: 215px;"><input style="border:none; background-color: transparent; text-align: center;  width: 49%; font-size:13px; font-family: tahoma;" size="15" align="middle" value="0" >
                        </td>
                        <td style="vertical-align: middle; text-align: center; width: 208px;">0<br>
                        </td>
                    </tr>
                    
                    
                    </tbody>
                    </table>
                    
                <br>
                
                </td>
                </tr>
                </tbody>
                </table>
                
            <br>
            
            </td>
            </tr>
        </tbody>
        </table>
    </center>
    
    <center>
        <table style="border-collapse: collapse; text-align: left; width: 1133px; height: 9px; font-size: 13px;"
        border="0" cellpadding="0" cellspacing="0">
        <tbody>
        <tr>
            <td colspan="1" rowspan="1"
            style="vertical-align: middle; width: 274px;">
            <table style="text-align: left; width: 258px; height: 113px; font-size: 13px; font-family:tahoma;"
            border="1" cellpadding="0" cellspacing="0">
            <tbody>
            <tr>
                <td colspan="4" rowspan="1"
                style="vertical-align: middle; width: 56px; text-indent: 5px;"><span
                style="font-weight: bold; font-size: 13px; "> V. Members and Dependents Served</span><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 90px;"><br>
                </td>
                <td
                style="vertical-align: middle; width: 52px; font-weight: bold; text-align: center;">Male<br>
                </td>
                <td
                style="vertical-align: middle; width: 50px; font-weight: bold; text-align: center;">Female<br>
                </td>
                <td
                style="vertical-align: middle; width: 56px; font-weight: bold; text-align: center;">TOTAL<br>
                </td>
            </tr>
            
            <tr>
                <td
                style="vertical-align: middle; width: 90px; text-align: left; text-indent: 5px;">Members:<br>
                </td>
                <td style="vertical-align: middle; text-align: center; width: 52px;">0<br>
                </td>
                <td style="vertical-align: middle; text-align: center; width: 50px;">0<br>
                </td>
                <td style="vertical-align: middle; text-align: center; width: 56px;">0<br>
                </td>
            </tr>
            
            <tr>
                <td
                style="vertical-align: middle; width: 90px; text-align: left; text-indent: 5px;">Dependents:<br>
                </td>
                <td style="vertical-align: middle; text-align: center; width: 52px;">0<br>
                </td>
                <td style="vertical-align: middle; text-align: center; width: 50px;">0<br>
                </td>
                <td style="vertical-align: middle; text-align: center; width: 56px;">0<br>
                </td>
            </tr>
            
            <tr>
                <td
                style="vertical-align: middle; width: 90px; text-align: center;"><span
                style="font-weight: bold;">TOTAL</span><br>
                </td>
                <td style="vertical-align: middle; text-align: center; width: 52px;">0<br>
                </td>
                <td style="vertical-align: middle; text-align: center; width: 50px;">0<br>
                </td>
                <td style="vertical-align: middle; text-align: center; width: 56px;">0<br>
                </td>
            </tr>
            </tbody>
             
            <br>
            </table>
            <br>
            
            
            <table style="text-align: left; width: 256px;  font-size: 13px; font-family:tahoma;"
            border="1" cellpadding="0" cellspacing="0">
            <tbody>
            <tr>
                <td
                style="vertical-align: middle; width: 157px; height: 244px;text-align: center; font-weight: bold;">VIII.
                10 Common<br>
                Illnesses (Morbidity)<br>
                </td>
                <td
                style="vertical-align: middle; width: 93px; text-align: center; font-weight: bold;">Number
                of<br>
                Cases<br>
                </td>
            </tr>
            
            <tr><!--INSERT TOP 10 DISEASES HERE-->
                <td
                style="vertical-align: middle; width: 252px;">&nbsp;&nbsp;&nbsp;1. MEASLES<br> <!--sample data-->
                </td>
                <td
                style="vertical-align: middle; width: 55px; text-align: center;">2<br>
                </td>
            </tr>
            
            </tbody>
            </table>
            
            <br>
            </td>
            
            <td colspan="1" rowspan="1"
            style="vertical-align: middle; width: 508px;">
            <table style="text-align: left; width: 489px; height: 417px; font-size: 13px; font-family:tahoma; text-indent: 5px;"
            border="1" cellpadding="0" cellspacing="0">
            <tbody>
            <tr>
                <td colspan="1" rowspan="2"
                style="vertical-align: middle; width: 425px; font-weight: bold; text-align: center;">VI.
                BENEFITS/SERVICES PROVIDED<br>
                </td>
                <td colspan="4" rowspan="1"
                style="vertical-align: middle; width: 58px; text-align: center; font-weight: bold;">No.
                of Members/Dependents<br>
                </td>
            </tr>
            
            <tr>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 58px; text-align: center; font-weight: bold;">Given<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 53px; text-align: center; font-weight: bold;">Referred<br>
                </td>
            </tr>
            
            <tr>  
                <td
                style="vertical-align: middle; width: 425px; font-weight: bold;">Primary
                Preventive Services<br>
                </td>
                <td
                style="vertical-align: middle; width: 58px; text-align: center; font-weight: bold;">M<br>
                </td>
                <td
                style="vertical-align: middle; width: 62px; text-align: center; font-weight: bold;">D<br>
                </td>
                <td
                style="vertical-align: middle; width: 57px; text-align: center; font-weight: bold;">M<br>
                </td>
                <td
                style="vertical-align: middle; width: 57px; text-align: center; font-weight: bold;">D<br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                1. Consultation<br>
                </span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td>
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                2. Visual inspection with acetic acid<br>
                </span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td>
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                3. Regular BP measurements<br>
                </span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td>
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                4. Breastfeeding program education<br>
                </span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td>
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                5. Periodic clinical breast examination<br>
                </span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td>
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                6. Counselling for lifestyle modification<br>
                </span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td>
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;
                &nbsp; 7. Counceling for smoking cessation<br>
                </span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td>
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                8. Body Measurements<br>
                </span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td>
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                9. Digital rectal examination <br>
                </span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td>
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td colspan="5" rowspan="1"
                style="vertical-align: middle; width: 425px; font-weight: bold;">Diagnostics
                Examinations<br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                1. Complete blood count (CBC)</span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td> <!--Given M-->
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td> <!--Given D-->
                
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                2. Urinalysis</span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td> <!--Given M-->
                <td style="vertical-align: middle; text-align: center; width: 62px;">0<br>
                </td><!--Given D-->
                
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                3. Fecalysis</span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td><!--Given M-->
                <td style="vertical-align: middle;   text-align: center; width: 62px;">0<br>
                </td><!--Given D-->
                
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                4. Sputum Microscopy</span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td><!--Given M-->
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td><!--Given D-->
                
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                5. Fasting blood sugar (FBS)</span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td><!--Given M-->
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td><!--Given D-->
                
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                6. Lipid profile</span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td><!--Given M-->
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td><!--Given D-->
                
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            <tr>
                <td style="vertical-align: middle; width: 425px;"><span
                style="font-family: tahoma; font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; display: inline ! important; float: none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                7. Chest x-ray</span></td>
                <td style="vertical-align: middle;  text-align: center; width: 58px;">0<br>
                </td><!--Given M-->
                <td style="vertical-align: middle;  text-align: center; width: 62px;">0<br>
                </td><!--Given D-->
                
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 49px; background-color: rgb(123, 124, 124);"><br>
                </td>
            </tr>
            
            </tbody>
            </table>
            </td>
            
            <td colspan="1" rowspan="1" style="vertical-align: middle;">
            <table style="text-align: left; width: 345px; height: 356px; font-size: 13px; font-family:tahoma; text-indent: 5px;"
            border="1" cellpadding="0" cellspacing="0">
            <tbody>
            <tr>
                <td
                style="vertical-align: middle; width: 252px; text-align: center; font-weight: bold;">VII.
                Medicines Given<br>
                (Generic Name)<br>
                </td>
                <td colspan="2" rowspan="1"
                style="vertical-align: middle; width: 60px; text-align: center; font-weight: bold;">No.
                of Members<br>
                Dependents<br>
                </td>
            </tr>
            
            <tr>
                <td
                style="vertical-align: middle; width: 252px; font-weight: bold;">I. Asthma<br>
                </td>
                <td
                style="vertical-align: middle; width: 55px; text-align: center; font-weight: bold;">M<br>
                </td>
                <td
                style="vertical-align: middle; width: 60px; text-align: center; font-weight: bold;">D<br>
                </td>
            </tr>
                
            <tr>
                <td></td><td></td><td></td>
            </tr>
            
            <tr>
                <td></td><td></td><td></td>
            </tr>
            
            <tr>
                <td colspan="3" rowspan="1"
                style="vertical-align: middle; width: 60px;"><span
                style="font-weight: bold;">II. AGE with no or mild dehydartion</span><br>
                </td>
            </tr>
            
            <tr>
                <td></td><td></td><td></td>
            </tr>
            
            <tr>
                <td></td><td></td><td></td>
            </tr>
            
            <tr style="font-weight: bold;">
            <td colspan="3" rowspan="1"
            style="vertical-align: middle; width: 60px;">III. URTI/Pneumonia (minimal
            &amp; low risk)<br>
            </td>
            </tr>
            
            <tr>
                <td></td><td></td><td></td>
            </tr>
            
            <tr>
                <td></td><td></td><td></td>
            </tr>
            
            <tr>
                <td colspan="3" rowspan="1"
                style="vertical-align: middle; width: 60px;"><span
                style="font-weight: bold;">IV. UTI</span><br>
                </td>
            </tr>
            
            <tr>
                <td></td><td></td><td></td>
            </tr>
            
            <tr>
                <td></td><td></td><td></td>
            </tr>
            
            <tr style="font-weight: bold;">
                <td colspan="3" rowspan="1"
                style="vertical-align: middle; width: 60px;">V. Nebulisation Services<br>
                </td>
            </tr>
            
            <tr>
                <td></td><td></td><td></td>
            </tr>
            
            <tr>
                <td></td><td></td><td></td>
            </tr>
            
            </tbody>
            </table>
            <br>
            </td>
        </tr>
        <tr>
        </tr>
        </tbody>
        </table>
    </center>


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