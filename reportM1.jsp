<%@page import="DAO.m1DAO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>


 <%
            m1DAO m1 = new m1DAO ();
            Calendar cal = Calendar.getInstance();
            int numyear = cal.get(Calendar.YEAR);
            int nummonth = cal.get(Calendar.MONTH) +1;
            String date = numyear + "-" + nummonth;
            String brgy = "RHU 1"; //rhu yung laman kapag di pa nag seselect ng brgy
            String month= nummonth+"";
            String year = numyear + "";
            
            if(session.getAttribute("m1Date") != null){
                month = (String) session.getAttribute("m1Month");
                year = (String) session.getAttribute("m1Year").toString();
                brgy = (String) session.getAttribute("m1Barangay");
                date = (String) session.getAttribute("m1Date");
                
            }
        %>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> M1 Report </title>

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

    <!-- Custom Theme Style -->
    <link href="source/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md" style="height: 100%; width: 100%;">

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
            <li class="breadcrumb-item"><a href="home/home.jsp">  Home </a></li>
            <li class="breadcrumb-item">Reports</li>
            <li class="breadcrumb-item active">M1</li>
        </ol>
    
   
<!--PAGE TITLE--> 
<div class="col-md-12 col-sm-12 col-xs-12">
    
    <form action="ReportM1" method="post">
        
    <div class="x_panel ">
      <div class="x_content">
        <h4 class="card-title">M1 Monthly Form for Program Report</h4>
        <h6 class="card-subtitle mb-2 text-muted">Select Barangay and Month & Year</h6>

        <p class="card-text">
                    <div class="row col-md-3">
                        <div class="form-group-row">

                          <label for="example-date-input" class="col-2 col-form-label">Barangay</label>
                          <!--INSERT DATA FROM DB-->
                          <div class="col-3">
                            <select id="select" name="selectedBrgy" class="form-control">
                                <%
                                   String tempBrgy = "";
                                   if(session.getAttribute("m1Barangay") != null){
                                       tempBrgy = (String) session.getAttribute("m1Barangay");
                                   }
                               %>
                               <option <%if(tempBrgy.equals("RHU 1")){%>selected="selected"<%}%> value="RHU 1">RHU 1</option>
                               <option <%if(tempBrgy.equals("Dolores North")){%>selected="selected"<%}%> value="Dolores North">Dolores North</option>
                               <option <%if(tempBrgy.equals("Juliana")){%>selected="selected"<%}%> value="Juliana">Juliana</option>
                               <option <%if(tempBrgy.equals("Lourdes")){%>selected="selected"<%}%> value="Lourdes">Lourdes</option>
                               <option <%if(tempBrgy.equals("Magliman")){%>selected="selected"<%}%> value="Magliman">Magliman</option>
                               <option <%if(tempBrgy.equals("San Jose")){%>selected="selected"<%}%> value="San Jose">San Jose</option>
                               <option <%if(tempBrgy.equals("San Juan")){%>selected="selected"<%}%> value="San Juan">San Juan</option>
                               <option <%if(tempBrgy.equals("Sto. Rosario")){%>selected="selected"<%}%> value="Sto. Rosario">Sto. Rosario</option>
                               <option <%if(tempBrgy.equals("Sta. Teresita")){%>selected="selected"<%}%> value="Sta. Teresita">Sta. Teresita</option>
                               <option <%if(tempBrgy.equals("Sto. Nino")){%>selected="selected"<%}%> value="Sto. Nino">Sto. Nino</option><!--FIX-->
                            </select>
                                <!-- <span class="help-block">Please select your barangay</span> -->
                          </div>
                        </div>
                    </div>
                  
                
                    <!--INSERT ajax to load db data from selected month & year -->
<!--                    <div class="form-group row">-->
                    <div class="col-md-3">
                      <label for="example-month-input" class="col-2 col-form-label">Month & Year</label>
                      <div class="col-12">
                          <input required="required" class="form-control" name="selectedDate" type="month" value="<%=date%>" id="example-month-input">
                      </div>
                    </div>
                          
                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-0">
                        <label for="" class="col-form-label"></label>
                        <div class="col-12"><br>
                            <button  type="submit" class="btn btn-primary ">Generate Report</button>
                        </div>
                    </div>

      </div> <!--x_content-->
    </div> <!--x_panel-->
     
    </form>
</div> <!--col-sm-6-->



<!-- MAIN FRAME -->
<div id="p1" style="text-align: center">
   <div class="col-md-12 col-sm-12 col-xs-12">
       
       <div class="x_panel">
          <div class="x_title">
            <h2><i class="fa fa-bars"></i> M1 <small>Monthly Report</small></h2>
            <div class="clearfix"></div>
          </div>
        
        <div class="x_content">   
        <div class="" role="tabpanel" data-example-id="togglable-tabs">
                      <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">Page 1</a>
                        </li>
                        <li role="presentation" class=""><a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">Page 2</a>
                        </li>
                        <li role="presentation" class=""><a href="#tab_content3" role="tab" id="profile-tab2" data-toggle="tab" aria-expanded="false">Page 3</a>
                        </li>
                      </ul>
                      
                      
      
      <div id="myTabContent" class="tab-content">
       <!--PAGE 1-->
        <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">
          <table class="table table-bordered text-center table-condensed">
                    <tr height="40">
                        <td width="5%"><img src="images/dohreportlogo.jpg" height="90" /></td>
                        <td width="" align="center">
                            <h2 style="font-size:22px; padding:5px; margin:0px;color:#1a7202;font-family:tahoma;">FHSIS REPORT</h2>

                            <h5>MONTH: <b><%=month%></b> &nbsp; YEAR: <b><%=year%></b><br> BARANGAY: <b><%=brgy%></b><br> BHS: <b>CITY OF SAN FERNANDO (CAPITAL) RURAL HEALTH UNIT I</b><br> CITY/MUNICIPALITY: <b>CITY OF SAN FERNANDO (CAPITAL)</b><br> PROVINCE: <b>PAMPANGA</b></h5>
                        </td>
                        <td width="5%"><img src="images/m1logoreport.jpg" height="90" /></td>
                    </tr>
                </table>

                <!--MATERNAL CARE-->
                <table class="table table-bordered table-condensed" cellpadding="1" border="1" width="100%">
                   <!--HEAD-->
                   <thead class="text-center">
                    <tr style="line-height: 40px; background-color: #f2f2f2"> <!--c1c1c1-->
                        <th width="70%" style="text-align: center;"><strong>MATERNAL CARE</strong></th>
                        <th width="30%" style="text-align: center;"><strong>No.</strong></th>
                    </tr>
                    </thead>

                    <!--BODY-->
                    <tbody style="font-size: 13px">
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;Deliveries</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getNumberOfDeliveries(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;Pregnant women with 4 or more Prenatal visits</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getPregnantWomenWith4OrMorePrenatalVisits(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;Pregnant women given 2 doses of Tetanus Toxoid</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getPregnantWomenGiven2DosesTT(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;Pregnant women given TT2 plus</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getPregnantWomenGivenMore2DosesTT(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;Preg.women given complete iron w/folic acid supplementation</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getPregnantWomenCompleteIron(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;Postpartum women with at least 2 postpartum visits</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getPostpartumWomenWithAtLeast2Visits(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;Postpartum women given complete iron supplementation</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getPostpartumWomenCompleteIron(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;Women 10-49 years old given Iron supplementation</td>
                        <td align="center" width="50">
                            <font color='#cccccc'>0</font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;Postpartum women given Vitamin A supplementation</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getPostpartumVitA(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;PP women initiated breastfeeding w/in 1 hr.after delivery</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getPostpartumWomenBreastfeedWin1hr(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;No. of Pregnant women</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getNumberOfPregnantWomen(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;No. of Pregnant women tested for Syphilis</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getNumberOfWomenTestedForSyphilis(date,brgy)%></font> <!-- Because every first prenatal visit so same na if determined pregnat  -->
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;No. of Pregnant women positive for Syphilis</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getNumberOfWomenPositiveForSyphilis(date,brgy)%></font>
                        </td>
                    </tr>
                    <tr height="25">
                        <td>&nbsp;&nbsp;&nbsp;No. of Pregnant women given Penicillin</td>
                        <td align="center" width="50">
                            <font color='#cccccc'><%=m1.getNumberOfWomenGivenPenicillin(date,brgy)%></font>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <!--/MATERNAL CARE-->

                <!--FAMILY PLANNING-->
                
                <%
                    int CurrentUserBeginningMonth = 0;
                    int NewAcceptorPreviousMonth = 0;
                    int NewAcceptorPresentMonth = 0;
                    int OtherAcceptorPresentMonth = 0;
                    int DropoutPresentMonth = 0;
                    int CurrentUserEndOfMonth = 0;
                %>
                
                <table class="table table-bordered table-condensed" cellpadding="1" border="1" width="100%">
                   <!--HEAD-->
                   <thead>
                    <tr align="center" style="background-color: #f2f2f2;">
                        <th rowspan="3" width="25%" style="text-align: center;"><strong>FAMILY PLANNING METHOD</strong></th>
                        <th rowspan="3" style="font-size: 10px; text-align: center;"><strong>CURRENT USER <br/>(BEGINNING MONTH)</strong></th>
                        <th colspan="2" style="font-size: 10px; text-align: center;"><strong>ACCEPTORS</strong></th>
                        <th rowspan="3" style="font-size: 10px; text-align: center;"><strong>DROP OUT <br/>(PRESENT MONTH)</strong></th>
                        <th rowspan="3" style="font-size: 10px; text-align: center;"><strong>CURRENT USER <br/>(END OF MONTH)</strong></th>
                        <th rowspan="3" style="font-size: 10px; text-align: center;"><strong>NEW ACCEPTOR <br/>(PRESENT MONTH)</strong></th>
                    </tr>
                    <tr align="center" style="background-color: #f2f2f2">
                        <td style="font-size: 10px"><strong>NEW</strong></td>
                        <td style="font-size: 10px"><strong>OTHER</strong></td>
                    </tr>
                    <tr align="center" style="background-color: #f2f2f2">
                        <td style="font-size: 10px"><strong>PREVIOUS MONTH</strong></td>
                        <td style="font-size: 10px"><strong>PRESENT MONTH</strong></td>
                    </tr>
                    </thead>
                    
                    <!--BODY-->
                    <tbody style="font-size: 13px">
                     
                    <tr height="30" align="center">
                        <td align="left" width="40%">a. Female Sterilization/Bilateral Tubal Ligation</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("FEMALE STERILIZATION/BILATERAL TUBAL LIGATION",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("FEMALE STERILIZATION/BILATERAL TUBAL LIGATION",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("FEMALE STERILIZATION/BILATERAL TUBAL LIGATION",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("FEMALE STERILIZATION/BILATERAL TUBAL LIGATION",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("FEMALE STERILIZATION/BILATERAL TUBAL LIGATION",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    
                    <tr height="30" align="center">
                        <td align="left" width="40%">b. Male Sterilization/Vasectomy</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("MALE STERILIZATION/VASECTOMY",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("MALE STERILIZATION/VASECTOMY",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("MALE STERILIZATION/VASECTOMY",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("MALE STERILIZATION/VASECTOMY",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("MALE STERILIZATION/VASECTOMY",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    
                    <tr height="30" align="center">
                        <td align="left" width="40%">c. Pills</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("PILLS",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("PILLS",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("PILLS",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("PILLS",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("PILLS",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    <tr height="30" align="center">
                        <td align="left" width="40%">d. Intra-Uterine Device (IUD)</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("INTRA-UTERINE DEVICE",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("INTRA-UTERINE DEVICE",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("INTRA-UTERINE DEVICE",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("INTRA-UTERINE DEVICE",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("INTRA-UTERINE DEVICE",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    <tr height="30" align="center">
                        <td align="left" width="40%">e. Depo-Medroxy Progestone Acetate(DMPA)</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("DEPO-MEDROXY PROGESTONE ACETATE(DMPA)",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("DEPO-MEDROXY PROGESTONE ACETATE(DMPA)",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("DEPO-MEDROXY PROGESTONE ACETATE(DMPA)",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("DEPO-MEDROXY PROGESTONE ACETATE(DMPA)",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("DEPO-MEDROXY PROGESTONE ACETATE(DMPA)",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    <tr height="30" align="center">
                        <td align="left" width="40%">f. Natural Family Planning-Cervical Mucus Method (NFP-CM)</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("NATURAL FAMILY PLANNING-CERVICAL MUCUS METHOD",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("NATURAL FAMILY PLANNING-CERVICAL MUCUS METHOD",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("NATURAL FAMILY PLANNING-CERVICAL MUCUS METHOD",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("NATURAL FAMILY PLANNING-CERVICAL MUCUS METHOD",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("NATURAL FAMILY PLANNING-CERVICAL MUCUS METHOD",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    <tr height="30" align="center">
                        <td align="left" width="40%">g. Natural Family Planning-Basal Body Temperature (NFP-BBT)</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("NATURAL FAMILY PLANNING-BASAL BODY TEMPERATURE",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("NATURAL FAMILY PLANNING-BASAL BODY TEMPERATURE",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("NATURAL FAMILY PLANNING-BASAL BODY TEMPERATURE",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("NATURAL FAMILY PLANNING-BASAL BODY TEMPERATURE",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("NATURAL FAMILY PLANNING-BASAL BODY TEMPERATURE",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    <tr height="30" align="center">
                        <td align="left" width="40%">h. Natural Family Planning-Sympothermal Method (NFP-STM)</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("NATURAL FAMILY PLANNING-SYMPOTHERMAL METHOD",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("NATURAL FAMILY PLANNING-SYMPOTHERMAL METHOD",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("NATURAL FAMILY PLANNING-SYMPOTHERMAL METHOD",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("NATURAL FAMILY PLANNING-SYMPOTHERMAL METHOD",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("NATURAL FAMILY PLANNING-SYMPOTHERMAL METHOD",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    <tr height="30" align="center">
                        <td align="left" width="40%">i. Natural Family Planning-Standard Days Method</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("NATURAL FAMILY PLANNING-STANDARD DAYS METHOD",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("NATURAL FAMILY PLANNING-STANDARD DAYS METHOD",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("NATURAL FAMILY PLANNING-STANDARD DAYS METHOD",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("NATURAL FAMILY PLANNING-STANDARD DAYS METHOD",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("NATURAL FAMILY PLANNING-STANDARD DAYS METHOD",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    <tr height="30" align="center">
                        <td align="left" width="40%">j. Natural Family Planning-Lactational Amenorrhea Method (NFP-LAM)</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("NATURAL FAMILY PLANNING-LACTATIONAL AMENORRHEA METHOD (NFP-LAM)",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("NATURAL FAMILY PLANNING-LACTATIONAL AMENORRHEA METHOD (NFP-LAM)",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("NATURAL FAMILY PLANNING-LACTATIONAL AMENORRHEA METHOD (NFP-LAM)",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("NATURAL FAMILY PLANNING-LACTATIONAL AMENORRHEA METHOD (NFP-LAM)",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("NATURAL FAMILY PLANNING-LACTATIONAL AMENORRHEA METHOD (NFP-LAM)",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    
                    <tr height="30" align="center">
                        <td align="left" width="40%">k. Condom</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("CONDOM",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("CONDOM",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("CONDOM",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("CONDOM",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("CONDOM",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    
                    <tr height="30" align="center">
                        <td align="left" width="40%">l. Implant</td>
                        <%
                            CurrentUserBeginningMonth   = m1.getNumberOfCurrentUsersBeginningMonth("IMPLANT",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getNumberOfNewAcceptorsPreviousMonth("IMPLANT",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getNumberOfOtherAcceptorsPresentMonth("IMPLANT",date,brgy);
                            DropoutPresentMonth         = m1.getNumberOfDropoutsPresentMonth("IMPLANT",date,brgy);
                            NewAcceptorPresentMonth     = m1.getNumberOfNewAcceptorsPresentMonth("IMPLANT",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    
                    <tr height="30" align="center">
                        <td align="left" width="40%" style="font-size:14px;"><strong>Total</strong></td>
                        <%
                            CurrentUserBeginningMonth   = m1.getTotal("Current Users","Previous",date,brgy);
                            NewAcceptorPreviousMonth    = m1.getTotal("New Acceptor","Previous",date,brgy);
                            OtherAcceptorPresentMonth   = m1.getTotal("Changing Method","Present",date,brgy);
                            DropoutPresentMonth         = m1.getTotal("Dropout","Present",date,brgy);
                            NewAcceptorPresentMonth     = m1.getTotal("New Acceptor","Present",date,brgy);
                            CurrentUserEndOfMonth       = CurrentUserBeginningMonth + NewAcceptorPresentMonth + OtherAcceptorPresentMonth - DropoutPresentMonth;
                            if(CurrentUserEndOfMonth < 0){
                                CurrentUserEndOfMonth = 0;
                            }
                        
                        %>
                        <td><%=CurrentUserBeginningMonth%></td>
                        <td><%=NewAcceptorPreviousMonth%></td>
                        <td><%=OtherAcceptorPresentMonth%></td>
                        <td><%=DropoutPresentMonth%></td>
                        <td><%=CurrentUserEndOfMonth%></td>
                        <td><%=NewAcceptorPresentMonth%></td>
                    </tr>
                    </tbody>
                </table>
        </div><!--tabpanel-->
                        
                        
        <!--PAGE 2-->
        
        <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">
          <table class="table table-bordered table-condensed" cellpadding="1" border="1" style="height:100%; width:100%; top: 0; bottom: 0; left: 0; right: 0;">
           <!--HEAD-->
            <thead>
                <tr style="line-height: 40px; background-color: #f2f2f2" align="center">
                    <td colspan="2"><strong>CHILD CARE</strong></td>
                    <td><strong>Male</strong></td>
                    <td><strong>Female</strong></td>
                    <td><strong>Total</strong></td>
                    <td><strong>CHILD CARE</strong></td>
                    <td><strong>Male</strong></td>
                    <td><strong>Female</strong></td>
                    <td><strong>Total</strong></td>
                </tr>
              </thead>
            <!--START-->
            
            
        
        <%
            ArrayList<ArrayList<String>> immunelist = m1.getChildImmunization(date,brgy);
        %>
        
            
            
            <tbody style="font-size: 13px">
            <tr height="25">
                <td colspan="2" rowspan="2">Immunization given &lt; 1 yr<br>
                &nbsp;&#9679; BCG
                </td>
                <td align="center" rowspan="2"><%=m1.getNumberforImmunizationFromImmuneList("Male", "BCG",immunelist)%></td>
                <td align="center" rowspan="2"><%=m1.getNumberforImmunizationFromImmuneList("Female", "BCG",immunelist)%></td>
                <td rowspan="2" align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "BCG",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "BCG",immunelist)%></td>
                <td style="width:450px">Children 24-35 months old recieved Vitamin A</td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Male",24,35)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Female",24,35)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Male",24,35) + m1.getNumberOfChildrenWithVitA(date,brgy,"Female",24,35)%></td>

            </tr>
            <tr height="25">
                <td>Children 36-47 months old recieved Vitamin A</td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Male",36,47)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Female",36,47)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Male",36,47) + m1.getNumberOfChildrenWithVitA(date,brgy,"Female",36,47)%></td>
            </tr>
            <tr height="25">
                <td rowspan="2">
                    <p>&nbsp;&#9679; HEPA B1</p>
                </td>
                <td>w/in 24</td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "Hepa B w/in 24 hrs",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "Hepa B w/in 24 hrs",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "Hepa B w/in 24 hrs",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "Hepa B w/in 24 hrs",immunelist)%></td>
                <td>Children 48-59 months old recieved Vitamin A</td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Male",48,59)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Female",48,59)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Male",48,59) + m1.getNumberOfChildrenWithVitA(date,brgy,"Female",48,59)%></td>
            </tr>

            <tr height="25">


                <td>&gt; 24 hrs</td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "Hepa B >= 24 hrs",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "Hepa B >= 24 hrs",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "Hepa B >= 24 hrs",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "Hepa B >= 24 hrs",immunelist)%></td>
                <td>Infant 2-5 months old received iron</td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",2,5)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Female",2,5)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",2,5) + m1.getNumberOfChildrenWithIron(date,brgy,"Female",2,5)%></td>
            </tr>

            <tr height="25">
                <td rowspan="3">&nbsp;&#9679; PENTA</td>
                <td>1</td>

                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PENTA 1",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "PENTA 1",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PENTA 1",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "PENTA 1",immunelist)%></td>

                <td>Infant 6-11 months old received iron</td>

                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",6,11)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Female",6,11)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",6,11) + m1.getNumberOfChildrenWithIron(date,brgy,"Female",6,11)%></td>
            </tr>

            <tr height="25">
                <td>2</td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PENTA 2",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "PENTA 2",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PENTA 2",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "PENTA 2",immunelist)%></td>
                <td>Children 12-23 received iron</td>

                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",12,23)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Female",12,23)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",12,23) + m1.getNumberOfChildrenWithIron(date,brgy,"Female",12,23)%></td>
            </tr>

            <tr height="25">
                <td>3</td>

                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PENTA 3",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "PENTA 3",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PENTA 3",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "PENTA 3",immunelist)%></td>
                <td>Children 24-35 months received iron</td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",24,35)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Female",24,35)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",24,35) + m1.getNumberOfChildrenWithIron(date,brgy,"Female",24,35)%></td>
            </tr>
            <tr height="25">
                <td rowspan="3">&nbsp;&#9679; OPV</td>
                <td>1</td>

                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "OPV 1",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "OPV 1",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "OPV 1",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "OPV 1",immunelist)%></td>

                <td>Children 36-47 months received iron</td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",36,47)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Female",36,47)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",36,47) + m1.getNumberOfChildrenWithIron(date,brgy,"Female",36,47)%></td>
            </tr>
            <tr height="25">
                <td>2</td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "OPV 2",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "OPV 2",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "OPV 2",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "OPV 2",immunelist)%></td>

                <td>Children 48-59 months received iron</td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",48,59)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Female",48,59)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithIron(date,brgy,"Male",48,59) + m1.getNumberOfChildrenWithIron(date,brgy,"Female",48,59)%></td>
            </tr>


            <tr height="25">
                <td>3</td>

                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "OPV 3",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "OPV 3",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "OPV 3",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "OPV 3",immunelist)%></td>
                <td>Infant 6-11 months received MNP</td>
                <td align="center"><%=m1.getNumberOfChildrenWithMNP(date,brgy,"Male",6,11)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithMNP(date,brgy,"Female",6,11)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithMNP(date,brgy,"Male",6,11) + m1.getNumberOfChildrenWithMNP(date,brgy,"Female",6,11)%></td>

            </tr>
            <tr height="25">
                <td rowspan="2">&nbsp;&#9679; MCV</td>
                <td>MCV1 (AMV)</td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "MCV 1",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "MCV 1",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "MCV 1",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "MCV 1",immunelist)%></td>
                <td>Sick children 6-11 months seen</td>

                <td align="center"><%=m1.getNumberOfSickChildrenSeen(date,brgy,"Male",6,11)%></td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeen(date,brgy,"Female",6,11)%></td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeen(date,brgy,"Male",6,11) + m1.getNumberOfSickChildrenSeen(date,brgy,"Female",6,11)%></td>

            </tr>

            <tr height="25">
                <td>MCV2 (MMR)</td>

                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "MCV 2",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "MCV 2",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "MCV 2",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "MCV 2",immunelist)%></td>
                <td>Sick children 12-59 months seen</td>

                <td align="center"><%=m1.getNumberOfSickChildrenSeen(date,brgy,"Male",12,59)%></td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeen(date,brgy,"Female",12,59)%></td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeen(date,brgy,"Male",12,59) + m1.getNumberOfSickChildrenSeen(date,brgy,"Female",12,59)%></td>

            </tr>
            <tr height="25">
                <td rowspan="3">&nbsp;&#9679; ROTA</td>
                <td>1</td>

                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "ROTA 1",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "ROTA 1",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "ROTA 1",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "ROTA 1",immunelist)%></td>

                <td>Sick children 12-59 months received Vitamin A</td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Male",12,59)%></td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Female",12,59)%></td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Male",12,59) + m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Female",12,59)%></td>

            </tr>

            <tr height="25">
                <td>2</td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "ROTA 2",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "ROTA 2",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "ROTA 2",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "ROTA 2",immunelist)%></td>
                <td>Sick Children 6-11 months received Vitamin A</td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Male",6,11)%></td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Female",6,11)%></td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Male",6,11) + m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Female",6,11)%></td>

            
            </tr>
            
            <tr height="25">
                <td>3</td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "ROTA 3",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "ROTA 3",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "ROTA 3",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "ROTA 3",immunelist)%></td>
                <td>Sick Children 12-59 months received Vitamin A</td>

                <td align="center"><%=m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Male",12,59)%></td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Female",12,59)%></td>
                <td align="center"><%=m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Male",12,59) + m1.getNumberOfSickChildrenSeenReceivedVitaminA(date,brgy,"Female",12,59)%></td>
            </tr>

            <tr height="25">
                <td rowspan="3">&nbsp;&#9679; PCV</td>
                <td>1</td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PCV 1",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "PCV 1",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PCV 1",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "PCV 1",immunelist)%></td>

                <td>Children 12-59 months old given de-worming tablet</td>

                <td align="center"><%=m1.getNumberOfChildrenWithDewormingTablet(date,brgy,"Male",12,59)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithDewormingTablet(date,brgy,"Female",12,59)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithDewormingTablet(date,brgy,"Male",12,59) + m1.getNumberOfChildrenWithDewormingTablet(date,brgy,"Female",12,59)%></td>
            
            
            </tr>
            
            <tr height="25">
                <td>2</td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PCV 2",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "PCV 2",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PCV 2",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "PCV 2",immunelist)%></td>
                <td>Infant 2-6 months with Low Birth Weight seen</td>
                <td align="center"><%=m1.getNumberOfChildrenWithLowBirthWeight(date,brgy,"Male",2,6)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithLowBirthWeight(date,brgy,"Female",2,6)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithLowBirthWeight(date,brgy,"Male",2,6) + m1.getNumberOfChildrenWithLowBirthWeight(date,brgy,"Female",2,6)%></td>
            
                
            </tr>
            
            <tr height="25">
                <td>3</td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PCV 3",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Female", "PCV 3",immunelist)%></td>
                <td align="center"><%=m1.getNumberforImmunizationFromImmuneList("Male", "PCV 3",immunelist) + m1.getNumberforImmunizationFromImmuneList("Female", "PCV 3",immunelist)%></td>
                <td>Infant 2-6 months with Low Birth Weight received full dose of iron</td>
                <td align="center"><%=m1.getNumberOfChildrenWithLowBirthWeightReceivedIron(date,brgy,"Male",2,6)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithLowBirthWeightReceivedIron(date,brgy,"Female",2,6)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithLowBirthWeightReceivedIron(date,brgy,"Male",2,6) + m1.getNumberOfChildrenWithLowBirthWeightReceivedIron(date,brgy,"Female",2,6)%></td>
            
            </tr>

            <tr height="25">
                <td colspan="2">Fully Immunized child (0-11 mos)</td>
                <td align="center">0</td>
                <td align="center">0</td>
                <td align="center">0</td>
                <td>Anemic Children 6-11 months old seen</td>
                <td align="center"><%=m1.getNumberOfAnemicChildren(date,brgy,"Male",6,11)%></td>
                <td align="center"><%=m1.getNumberOfAnemicChildren(date,brgy,"Female",6,11)%></td>
                <td align="center"><%=m1.getNumberOfAnemicChildren(date,brgy,"Male",6,11) + m1.getNumberOfAnemicChildren(date,brgy,"Female",6,11)%></td>
            
            </tr>

            <tr height="25">
                <td colspan="2">Completely Immunized Child (12-23 mos)</td>
                <td align="center">0</td>
                <td align="center">0</td>
                <td align="center">0</td>
                <td>Anemic Children 6-11 months received full dose of iron</td>
                <td align="center"><%=m1.getNumberOfAnemicChildrenReceivedIron(date,brgy,"Male",6,11)%></td>
                <td align="center"><%=m1.getNumberOfAnemicChildrenReceivedIron(date,brgy,"Female",6,11)%></td>
                <td align="center"><%=m1.getNumberOfAnemicChildrenReceivedIron(date,brgy,"Male",6,11) + m1.getNumberOfAnemicChildrenReceivedIron(date,brgy,"Female",6,11)%></td>
            
            </tr>
            
            <tr height="25">
                <td colspan="2">Total Livebirths</td>
                <td align="center"><%=m1.getNumberOfTotalLiveBirths(date,brgy,"Male")%></td>
                <td align="center"><%=m1.getNumberOfTotalLiveBirths(date,brgy,"Female")%></td>
                <td align="center"><%=m1.getNumberOfTotalLiveBirths(date,brgy,"Male") + m1.getNumberOfTotalLiveBirths(date,brgy,"Female")%></td>

                <td>Anemic Children 12-59 months old seen</td>
                <td align="center"><%=m1.getNumberOfAnemicChildren(date,brgy,"Male",12,59)%></td>
                <td align="center"><%=m1.getNumberOfAnemicChildren(date,brgy,"Female",12,59)%></td>
                <td align="center"><%=m1.getNumberOfAnemicChildren(date,brgy,"Male",12,59) + m1.getNumberOfAnemicChildren(date,brgy,"Female",12,59)%></td>
            
            </tr>
            
            <tr height="25">
                <td colspan="2">Child Protected at Birth (CPAB)</td>
                <td align="center">0</td>
                <td align="center">0</td>
                <td align="center">0</td>
                <td>Anemic Children 12-59 months received full dose of iron</td>
                <td align="center"><%=m1.getNumberOfAnemicChildrenReceivedIron(date,brgy,"Male",12,59)%></td>
                <td align="center"><%=m1.getNumberOfAnemicChildrenReceivedIron(date,brgy,"Female",12,59)%></td>
                <td align="center"><%=m1.getNumberOfAnemicChildrenReceivedIron(date,brgy,"Male",12,59) + m1.getNumberOfAnemicChildrenReceivedIron(date,brgy,"Female",12,59)%></td>
            
            </tr>
            
            <tr height="25">
                <td colspan="2">Infant age 6 mos. seen</td>
                <td align="center"><%=m1.getNumberOfInfant6MonthSeen(date,brgy,"Male")%></td>
                <td align="center"><%=m1.getNumberOfInfant6MonthSeen(date,brgy,"Female")%></td>
                <td align="center"><%=m1.getNumberOfInfant6MonthSeen(date,brgy,"Male") + m1.getNumberOfInfant6MonthSeen(date,brgy,"Female")%></td>

                <td>Diarrhea case 0-59 months old seen</td>
                <td align="center"><%=m1.getNumberOfDiarrheaChildren(date,brgy,"Male",0,59)%></td>
                <td align="center"><%=m1.getNumberOfDiarrheaChildren(date,brgy,"Female",0,59)%></td>
                <td align="center"><%=m1.getNumberOfDiarrheaChildren(date,brgy,"Male",0,59) + m1.getNumberOfDiarrheaChildren(date,brgy,"Female",0,59)%></td>
            
                
            </tr>

            <tr height="25">
                <td colspan="2">Infant exclusively breastfed until 6th month</td>
                <td align="center"><%=m1.getNumberOfInfantExclusivelyBreastFed(date,brgy,"Male")%></td>
                <td align="center"><%=m1.getNumberOfInfantExclusivelyBreastFed(date,brgy,"Female")%></td>
                <td align="center"><%=m1.getNumberOfInfantExclusivelyBreastFed(date,brgy,"Male") + m1.getNumberOfInfantExclusivelyBreastFed(date,brgy,"Female")%></td>

                
                <td>Diarrhea case 0-59 months old received ORS</td>
                <td align="center"><%=m1.getNumberOfDiarrheaChildrenWithORS(date,brgy,"Male",0,59)%></td>
                <td align="center"><%=m1.getNumberOfDiarrheaChildrenWithORS(date,brgy,"Female",0,59)%></td>
                <td align="center"><%=m1.getNumberOfDiarrheaChildrenWithORS(date,brgy,"Male",0,59) + m1.getNumberOfDiarrheaChildrenWithORS(date,brgy,"Female",0,59)%></td>
            
            </tr>
            
            <tr height="25">
                <td colspan="2">Infant given complimentary food from 6-8months</td>
                <td align="center">0</td>
                <td align="center">0</td>
                <td align="center">0</td>
                <td>Diarrhea case 0-59 months received ORS/ORT w/ zinc</td>
                <td align="center">0</td>
                <td align="center">0</td>
                <td align="center">0</td>
            </tr>
            
            <tr height="25">
                <td colspan="2">Infant referred for newborn screening</td>
                <td align="center"><%=m1.getNumberOfInfantNewBornScreened(date,brgy,"Male")%></td>
                <td align="center"><%=m1.getNumberOfInfantNewBornScreened(date,brgy,"Female")%></td>
                <td align="center"><%=m1.getNumberOfInfantNewBornScreened(date,brgy,"Male") + m1.getNumberOfInfantNewBornScreened(date,brgy,"Female")%></td>

                <td>Pneumonia cases 0-59 months old</td>
                <td align="center"><%=m1.getNumberOfPneumoniaChildren(date,brgy,"Male",0,59)%></td>
                <td align="center"><%=m1.getNumberOfPneumoniaChildren(date,brgy,"Female",0,59)%></td>
                <td align="center"><%=m1.getNumberOfPneumoniaChildren(date,brgy,"Male",0,59) + m1.getNumberOfPneumoniaChildren(date,brgy,"Female",0,59)%></td>
            
            </tr>
            
            <tr height="25">
                <td colspan="2">Infant 6-11 months old received Vitamin A</td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Male",6,11)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Female",6,11)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Male",6,11) + m1.getNumberOfChildrenWithVitA(date,brgy,"Female",6,11)%></td>
                <td rowspan="2">Pneumonia cases 0-59 months old complete treatment</td>
                <td align="center" rowspan="2">0</td>
                <td align="center" rowspan="2">0</td>
                <td align="center" rowspan="2">0</td>
            </tr>

            <tr height="25">
                <td colspan="2">Children 12-23 months old received Vitamin A</td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Male",12,23)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Female",12,23)%></td>
                <td align="center"><%=m1.getNumberOfChildrenWithVitA(date,brgy,"Male",12,23) + m1.getNumberOfChildrenWithVitA(date,brgy,"Female",12,23)%></td>
            </tr>
            
            <!--STI SURVEILLANCE-->
            <thead>
            <tr height="25" style="background-color: #f2f2f2; line-height: 40px;">
                <td colspan="2" align="center"><strong>STI SURVEILLANCE</strong></td>
                <td align="center"><strong>Male</strong></td>
                <td align="center"><strong>Female</strong></td>
                <td align="center"><strong>Total</strong></td>
                <td></td>
                <td align="center"></td>
                <td align="center"></td>
                <td align="center"></td>
            </tr>
            </thead>
            
            <tr height="25">
                <td colspan="2">No. of pregnant women</td>
                <td align="center" style="background-color: #f2f2f2;">  </td>
                <td align="center"><%=m1.getNumberOfPregnantWomen(date,brgy)%></td>
                <td align="center"><%=m1.getNumberOfPregnantWomen(date,brgy)%></td>
                <td></td>
                <td align="center"></td>
                <td align="center"></td>
                <td align="center"></td>
            </tr>
            <tr height="25">
                <td colspan="2">No. of pregnant women positive for Syphilis</td>
                <td align="center" style="background-color: #f2f2f2;">  </td>
                <td align="center"><%=m1.getNumberOfWomenPositiveForSyphilis(date,brgy)%></td>
                <td align="center"><%=m1.getNumberOfWomenPositiveForSyphilis(date,brgy)%></td>
                <td></td>
                <td align="center"></td>
                <td align="center"></td>
                <td align="center"></td>
            </tr>
            <tr height="25">
                <td colspan="2">No. of pregnant women tested for Syphilis</td>
                <td align="center" style="background-color: #f2f2f2;">  </td>
                <td align="center"><%=m1.getNumberOfWomenTestedForSyphilis(date,brgy)%></td>
                <td align="center"><%=m1.getNumberOfWomenTestedForSyphilis(date,brgy)%></td>
                <td></td>
                <td align="center"></td>
                <td align="center"></td>
                <td align="center"></td>
            </tr>
            <tr height="25">
                <td colspan="2">No. of pregnant women given Penicilin</td>
                <td align="center" style="background-color: #f2f2f2;">  </td>
                <td align="center"><%=m1.getNumberOfWomenGivenPenicillin(date,brgy)%></td>
                <td align="center"><%=m1.getNumberOfWomenGivenPenicillin(date,brgy)%></td>
                <td></td>
                <td align="center"></td>
                <td align="center"></td>
                <td align="center"></td>
            </tr>
              </tbody>
        </table>
                        </div><!--tabpanel-->
                         
                               
                        
        <!--PAGE 3-->
        <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="profile-tab">
            <table class="table table-bordered text-center table-condensed ">
                  <thead class="text-center">
                    <tr>
                        <th width="35%" style="text-align: center; background-color:#f2f2f2">MALARIA</th>
                        <th width="5%" class="text-center" style="text-align: center; background-color:#f2f2f2">Male</th>
                        <th width="5%" class="text-center" style="text-align: center; background-color:#f2f2f2">Female</th>
                        <th width="5%" class="text-center" style="text-align: center; background-color:#f2f2f2">Total</th>
                        <th width="35%"  style="text-align: center; background-color:#f2f2f2">SCHISTOSOMIASIS</th>
                        <th width="5%" class="text-center" style="text-align: center; background-color:#f2f2f2">Male</th>
                        <th width="5%" class="text-center" style="text-align: center; background-color:#f2f2f2">Female</th>
                        <th width="5%" class="text-center" style="text-align: center; background-color:#f2f2f2">Total</th>
                    </tr>
                  </thead>


                  <tbody style="font-size: 13px">
                    <tr>
                    <td scope="row" class="text-left">Total Population</td>
                        <td>1</td>
                        <td>1</td>
                        <td>1</td>
                        <td class="text-left">No. of Symptomatic case</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>

                    </tr>
                    <tr>
                        <td scope="row" class="text-left">Population at Risk</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">No. of Cases Examined</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">Confirmed Malaria Case</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">No. of Positive Cases</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left"> &nbsp; &#9679; &lt; 5 yo </td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left"> &nbsp; &#9679; &lt; Low intensity </td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; &gt; = 5 yo</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left"> &nbsp; &#9679; &lt; Medium intensity </td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; Pregnant</td>
                        <td style="background-color:gray"></td>
                        <td style="background-color:gray"></td>
                        <td>0</td>
                        <td class="text-left"> &nbsp; &#9679; &lt; High intensity </td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">Confirmed Malaria Case</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">No. of Cases treated</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>

                    <tr>
                        <td scope="row" colspan="4" class="text-left">By Species </td>
                        <td class="text-left">No of Complicated Cases</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>

                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; P.falciparum</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">No. of Complicated Cases referred</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>


                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; P.vivax</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left"></td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>

                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; P.ovale</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left"></td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>

                    </tr>

                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; P.malariae</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
<!--                                <td class="text-center" style="background-color:#f2f2f2" ><span style="font-weight:bold">FILARIASIS</span></td>-->
                        <th class="text-center" style="background-color:#f2f2f2" >FILARIASIS</th>

                        <th style="background-color:#f2f2f2">Male</th>
                        <th style="background-color:#f2f2f2">Female</th>
                        <th style="background-color:#f2f2f2">Total</th>
                    </tr>


                    <tr>
                        <td scope="row" class="text-left">Confirmed Malaria case</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">No. Cases with hydrocele, lymphedema, Elephantiasis, Chyluria</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>


                    <tr>
                        <td scope="row" colspan="4" class="text-left">By Method:</td>
                        <td class="text-left">Clinical Rate</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>

                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; Slide</td>
                        <td style="background-color:gray"></td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">No of Case examined</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; RDT</td>
                        <td style="background-color:gray"></td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">No of Cases examined found Positive for MF</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>

                    <tr>
                        <td scope="row" class="text-left">Malaria Deaths</td>
                        <td style="background-color:gray"></td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">Eligible population given MDA (94.6% of TP)</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>

                    <tr>
                        <td scope="row" class="text-left">Populatuon given LLIN</td>
                        <td style="background-color:gray"></td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">Total population given MDA</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>





                    <tr  class="text-center black" style="background-color:#f2f2f2">
                        <th scope="row" class="text-center">TUBERCOLOSIS</th>
                        <th style="text-align: center;">Male</th>
                        <th style="text-align: center;">Female</th>
                        <th style="text-align: center;">Total</th>
                        <th style="text-align: center;">LEPROSY</th>
                        <th style="text-align: center;">Male</th>
                        <th style="text-align: center;">Female</th>
                        <th style="text-align: center;">Total</th>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">1. TB symptomatics who underwent DSSM</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">Total Population</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">2. Smear positive discovered and identified</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">Total No. of Leprosy cases (undergoing treatment</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>

                    <tr>
                        <td scope="row" class="text-left">3. New smear positive cases initiated tx and registered</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">No. of Newly detected Leprosy Cases</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>

                    <tr>
                        <td scope="row" class="text-left">5. Smear(+) retreatment cases cured</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left"> &nbsp; <!--►-->&#9679; &lt; 15 yo</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">6. Smear (+) retreatment cases initiated tx and registered</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left"> &nbsp; <!--►-->&#9679; Grade 2 disability</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>    
                        <td scope="row" class="text-left">&nbsp; &#9679; Relapse</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">No of Leprosy Cases cured</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; Treatment failure</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">-</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; Return after default</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">-</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; Other type of TB</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">-</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">7. No, of Smear (+) retreatment cured</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">-</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; Relapse</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">-</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; Treatment failure</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">-</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">&nbsp; &#9679; Return after default</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">-</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">8.Total No. of TB cases (all forms) initiated treatmen</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">-</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">9. TB All forms identified</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">-</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>
                    <tr>
                        <td scope="row" class="text-left">10. Case Detection Rate</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                        <td class="text-left">-</td>
                        <td>0</td>
                        <td>0</td>
                        <td>0</td>
                    </tr>                              


                  </tbody>
                </table>
                </div><!--tabpanel-->

                        
                      </div><!--myTabContent all tabs-->
                    </div><!--tabpanel-->
                    
                    
           </div><!--x_content-->
    </div><!--x+panel-->
</div><!--col-md-12-->
</div><!--p1-->


   
   
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
                <!-- Custom Theme Scripts -->
                <script src="source/js/custom.min.js"></script>
   
    
<!-- IFRAME SIMPLE CODE  
<div>
    <a href="web/views/reports/m1/1.html" target="targetframe">Page 1</a><br>
    <a href="web/views/reports/m1/2.html" target="targetframe">Page 2</a><br />
    <a href="web/views/reports/m1/3.html" target="targetframe">Page 3</a>
</div>
-->

</body>
</html>