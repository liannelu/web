<%@page import="Model.Diagnosis"%>
<%@page import="Model.User"%>
<%@page import="Model.Family_Code"%>
<%@page import="DAO.nurseDAO"%>
<%@page import="DAO.m2DAO"%>
<%@page import="DAO.a2DAO"%>
<%@page import="Model.Consultation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date;"%>
<%@page import="java.util.Calendar"%>

<%  
    String tempYear = "";
    String tempBarangay= "";
    String tempBHS="";
    
    
    if(session.getAttribute("a2Year") != null){
        tempYear = (String) session.getAttribute("a2Year").toString();
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
    

%>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> A2 Report </title>

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
    <!-- DAGDAG bootstrap datapicker-->
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
            <li class="breadcrumb-item active">A2</li>
        </ol>
    
    <!--PAGE TITLE--> 
    <div class="col-md-12 col-sm-12 col-xs-12">
        
        <form action="ReportA2" post="post">
        
         <div class="x_panel">
              <div class="x_content">
                <div class="form-group">
                <h4 class="card-title">A2 Annual Form for Morbidity Report</h4>
                <h6 class="card-subtitle md-2 text-muted">Select Barangay and Year</h6>

                <p class="card-text">
                    <div class="row col-md-3">
                    <div class="form-group-row">
                   
                      <label for="example-date-input" class="col-2 col-form-label">Barangay</label>
                      <!--INSERT DATA FROM DB-->
                      <div class="col-12">
                        <select id="select" name="selectedBrgy" class="form-control">
                            <%
                                String tempBrgy = "";
                                if(session.getAttribute("selectedBarangay") != null){
                                    tempBrgy = (String) session.getAttribute("selectedBarangay");
                                }
                            %>
                            <option <%if(tempBrgy.equals("0")){%>selected="selected"<%}%> value="0">RHU 1</option>
                            <option <%if(tempBrgy.equals("Dolores North")){%>selected="selected"<%}%> value="Dolores">Dolores </option>
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

                    <!-- YEAR PICKER -->
                        <div class="col-md-2">
                            <label for="example-month-input" class="col-2 col-form-label">Year</label>
                            <div class="col-12">
                                
                                <input name="selectedDate" id="selectedDate2" value="<%
                                    if(session.getAttribute("a2Year") != null){
                                        //out.print(Integer.parseInt(session.getAttribute("a2Year")));
                                        int test = (Integer) session.getAttribute("a2Year");
                                        out.print(test);
                                    }else{
                                        int year = Calendar.getInstance().get(Calendar.YEAR);
                                        out.print(year);
                                    }
                                       
                                       %>" class="form-control " />  
                            </div>
                        </div>  
                      
                          
                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-0">
                        <label for="" class="col-form-label"></label>
                        <div class="col-12"><br>
                            <!--<button onClick="window.location='reportM2.jsp';" type="button" class="btn btn-primary ">Generate Report</button>-->
                            <button type="submit" class="btn btn-primary ">Generate Report</button>
                            <a href="program_planning_without_disease.jsp" class="btn btn-primary "><i class="fa fa-file-text-o"></i> Propose Program</a>
                            <a class="btn btn-default" href="print_reportM2.jsp"><i class="fa fa-print"></i> Print</a>
                        </div>
                    </div>
                    

                  
               
                  
             </div>
              </div> <!--x_content-->
            </div> <!--x_panel-->
        
        </form>
        
        <!-- M2 Report -->
        <div class="x_panel">
        
            
            <div class="x_title">
            <h2><i class="fa fa-bars"></i> A2 <small>Annual Morbidity Report</small></h2>
            <div class="clearfix"></div>
          </div>
           
            
           <div class="x_content">
               
            
            <table class="table table-bordered table-condensed" cellpadding="1" border="1" width="100%">
                <tr height="30">
                    <td width="5%"><img src="images/dohreportlogo.jpg" height="80" /></td>
                    <td width="" align="center">
                        <h2 style="font-size:20px; padding:5px; margin:0px;color:#1a7202;font-family:tahoma;  ">MORBIDITY DISEASES REPORT</h2>
                        <p style="font-size:10px; font-style: italic">For submission to RHU</p>
                        
                        <h5>
                        YEAR: <b><%out.print(tempYear);%></b> <br>
                        BARANGAY: <b> <%out.print(tempBarangay);%></b>   &nbsp;  BHS: <b><%out.print(tempBHS);%></b><br> 
                        CATCHMENT HEALTH CENTER: <b>RURAL HEALTH UNIT I</b>   
                        </h5>
                    </td>
                    <td width="7%"><img src="images/m2logoreport2.jpg" height="90" /></td>
                </tr>
            </table>
               
            <table class="table table-bordered table-condensed" cellpadding="1" border="1" width="100%">
               <!--HEAD-->
               <thead class="text-center">
                <tr style="background-color: #f2f2f2" align="center">
                    <td rowspan="3"><strong>Name of Disease</strong></td>
                    <td colspan="100%"><strong>BY AGE-GROUP AND BY GENDER</strong></td>
                </tr>
                <tr style="background-color: #f2f2f2;font-size: 12px" align="center">
                    <td align="center" colspan="2">Under 1</td>
                    <td align="center" colspan="2">1-4</td>
                    <td align="center" colspan="2">5-9</td>
                    <td align="center" colspan="2">10-14</td>
                    <td align="center" colspan="2">15-19</td>
                    <td align="center" colspan="2">20-24</td>
                    <td align="center" colspan="2">25-29</td>
                    <td align="center" colspan="2">30-34</td>
                    <td align="center" colspan="2">35-39</td>
                    <td align="center" colspan="2">40-44</td>
                    <td align="center" colspan="2">45-49</td>
                    <td align="center" colspan="2">50-54</td>
                    <td align="center" colspan="2">55-59</td>
                    <td align="center" colspan="2">60-64</td>
                    <td align="center" colspan="2">65 & above</td>
                    <td align="center" colspan="2"><strong>Total</strong></td>
                </tr>
                <tr style="background-color: #f2f2f2; font-size: 12px" align="center">
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                    <td align="center">M</td>
                    <td align="center">F</td>
                </tr>
                </thead>
                <%if(session.getAttribute("a2Year") != null){//dapat session din barangay
                
                %>
                <!--CONTENT-->
                <%
                    a2DAO a2DAO = new a2DAO();
                    
                    
                    ArrayList <Diagnosis> list  = new ArrayList();
                    //ARRAYLIST
                    ArrayList <Diagnosis> listUnder1F  = new ArrayList();//UNDER 1
                    ArrayList <Diagnosis> listUnder1M  = new ArrayList();
                    ArrayList <Diagnosis> list1to4F  = new ArrayList();//BETWEEN 1-4
                    ArrayList <Diagnosis> list1to4M  = new ArrayList();
                    ArrayList <Diagnosis> list5to9F  = new ArrayList();//BETWEEN 5-9
                    ArrayList <Diagnosis> list5to9M  = new ArrayList();
                    ArrayList <Diagnosis> list10to14F  = new ArrayList();
                    ArrayList <Diagnosis> list10to14M  = new ArrayList();
                    ArrayList <Diagnosis> list15to19F  = new ArrayList();//15-19
                    ArrayList <Diagnosis> list15to19M  = new ArrayList();
                    ArrayList <Diagnosis> list20to24F  = new ArrayList();//20-24
                    ArrayList <Diagnosis> list20to24M  = new ArrayList();
                    ArrayList <Diagnosis> list25to29F  = new ArrayList();//25-29
                    ArrayList <Diagnosis> list25to29M  = new ArrayList();
                    ArrayList <Diagnosis> list30to34F  = new ArrayList();//30-34
                    ArrayList <Diagnosis> list30to34M  = new ArrayList();
                    ArrayList <Diagnosis> list35to39F  = new ArrayList();//35-39
                    ArrayList <Diagnosis> list35to39M  = new ArrayList();
                    ArrayList <Diagnosis> list40to44F  = new ArrayList();//40-44
                    ArrayList <Diagnosis> list40to44M  = new ArrayList();
                    ArrayList <Diagnosis> list45to49F  = new ArrayList();//45-49
                    ArrayList <Diagnosis> list45to49M  = new ArrayList();
                    ArrayList <Diagnosis> list50to54F  = new ArrayList();//50-54
                    ArrayList <Diagnosis> list50to54M  = new ArrayList();
                    ArrayList <Diagnosis> list55to59F  = new ArrayList();//55-59
                    ArrayList <Diagnosis> list55to59M  = new ArrayList();
                    ArrayList <Diagnosis> list60to64F  = new ArrayList();//60-64
                    ArrayList <Diagnosis> list60to64M  = new ArrayList();
                    ArrayList <Diagnosis> listAbove65F  = new ArrayList();//65 Above
                    ArrayList <Diagnosis> listAbove65M  = new ArrayList();
                    ArrayList <Diagnosis> listTotalF  = new ArrayList();//Total F
                    ArrayList <Diagnosis> listTotalM  = new ArrayList();// Total M
                    
                    
                    
                    String brgy = (String) session.getAttribute("selectedBarangay");
                    if(brgy.equals("0")){
                        list = a2DAO.getDiseases((Integer) session.getAttribute("a2Year"));
                        listUnder1F = a2DAO.a2GetUnder1F((Integer) session.getAttribute("a2Year")); 
                        listUnder1M = a2DAO.a2GetUnder1M((Integer) session.getAttribute("a2Year")); 
                        list1to4F = a2DAO.a2Get1to4F((Integer) session.getAttribute("a2Year")); 
                        list1to4M = a2DAO.a2Get1to4M((Integer) session.getAttribute("a2Year")); 
                        list5to9F = a2DAO.a2Get5to9F((Integer) session.getAttribute("a2Year")); 
                        list5to9M = a2DAO.a2Get5to9M((Integer) session.getAttribute("a2Year"));
                        
                        list10to14F = a2DAO.a2Get10to14F((Integer) session.getAttribute("a2Year")); 
                        list10to14M = a2DAO.a2Get10to14M((Integer) session.getAttribute("a2Year")); 
                        list15to19F = a2DAO.a2Get15to19F((Integer) session.getAttribute("a2Year")); 
                        list15to19M = a2DAO.a2Get15to19M((Integer) session.getAttribute("a2Year")); 
                        list20to24F = a2DAO.a2Get20to24F((Integer) session.getAttribute("a2Year")); 
                        list20to24M = a2DAO.a2Get20to24M((Integer) session.getAttribute("a2Year")); 
                        
                        list25to29F = a2DAO.a2Get25to29F((Integer) session.getAttribute("a2Year")); 
                        list25to29M = a2DAO.a2Get25to29M((Integer) session.getAttribute("a2Year")); 
                        list30to34F = a2DAO.a2Get30to34F((Integer) session.getAttribute("a2Year")); 
                        list30to34M = a2DAO.a2Get30to34M((Integer) session.getAttribute("a2Year")); 
                        list35to39F = a2DAO.a2Get35to39F((Integer) session.getAttribute("a2Year")); 
                        list35to39M = a2DAO.a2Get35to39M((Integer) session.getAttribute("a2Year")); 
                        list40to44F = a2DAO.a2Get40to44F((Integer) session.getAttribute("a2Year")); 
                        list40to44M = a2DAO.a2Get40to44M((Integer) session.getAttribute("a2Year")); 
                        
                        list45to49F = a2DAO.a2Get45to49F((Integer) session.getAttribute("a2Year")); 
                        list45to49M = a2DAO.a2Get45to49M((Integer) session.getAttribute("a2Year")); 
                        list50to54F = a2DAO.a2Get50to54F((Integer) session.getAttribute("a2Year")); 
                        list50to54M = a2DAO.a2Get50to54M((Integer) session.getAttribute("a2Year")); 
                        list55to59F = a2DAO.a2Get55to59F((Integer) session.getAttribute("a2Year")); 
                        list55to59M = a2DAO.a2Get55to59M((Integer) session.getAttribute("a2Year"));
                        list60to64F = a2DAO.a2Get60to64F((Integer) session.getAttribute("a2Year")); 
                        list60to64M = a2DAO.a2Get60to64M((Integer) session.getAttribute("a2Year")); 
                        
                        
                        listAbove65F = a2DAO.a2GetAbove65F((Integer) session.getAttribute("a2Year")); 
                        listAbove65M = a2DAO.a2GetAbove65M((Integer) session.getAttribute("a2Year")); 
                        
                        listTotalF = a2DAO.a2GetTotalF((Integer) session.getAttribute("a2Year")); 
                        listTotalM = a2DAO.a2GetTotalM((Integer) session.getAttribute("a2Year"));
                    }else{
                        list = a2DAO.getDiseasesBrgy((Integer) session.getAttribute("a2Year"), brgy);
                        
                        listUnder1F = a2DAO.a2GetUnder1FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        listUnder1M = a2DAO.a2GetUnder1MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        
                        list1to4F = a2DAO.a2Get1to4FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list1to4M = a2DAO.a2Get1to4MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list5to9F = a2DAO.a2Get5to9FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list5to9M = a2DAO.a2Get5to9MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        
                        list10to14F = a2DAO.a2Get10to14FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list10to14M = a2DAO.a2Get10to14MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list15to19F = a2DAO.a2Get15to19FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list15to19M = a2DAO.a2Get15to19MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list20to24F = a2DAO.a2Get20to24FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list20to24M = a2DAO.a2Get20to24MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        
                        list25to29F = a2DAO.a2Get25to29FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list25to29M = a2DAO.a2Get25to29MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list30to34F = a2DAO.a2Get30to34FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list30to34M = a2DAO.a2Get30to34MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list35to39F = a2DAO.a2Get35to39FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list35to39M = a2DAO.a2Get35to39MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list40to44F = a2DAO.a2Get40to44FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list40to44M = a2DAO.a2Get40to44MBrgy((Integer) session.getAttribute("a2Year"), brgy);
                        
                        
                        list45to49F = a2DAO.a2Get45to49FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list45to49M = a2DAO.a2Get45to49MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list50to54F = a2DAO.a2Get50to54FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list50to54M = a2DAO.a2Get50to54MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list55to59F = a2DAO.a2Get55to59FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list55to59M = a2DAO.a2Get55to59MBrgy((Integer) session.getAttribute("a2Year"), brgy);
                        list60to64F = a2DAO.a2Get60to64FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        list60to64M = a2DAO.a2Get60to64MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        
                        listAbove65F = a2DAO.a2GetAbove65FBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        listAbove65M = a2DAO.a2GetAbove65MBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        
                        listTotalF = a2DAO.a2GetTotalFBrgy((Integer) session.getAttribute("a2Year"), brgy); 
                        listTotalM = a2DAO.a2GetTotalMBrgy((Integer) session.getAttribute("a2Year"), brgy);
                    }
                    
                    //COUNTERS
                    int countUnder1F = 0;
                    int countUnder1M = 0;
                    int count1to4F = 0;
                    int count1to4M = 0;
                    int count5to9F = 0;
                    int count5to9M = 0;
                    int count10to14F = 0;
                    int count10to14M = 0;
                    int count15to19F = 0;
                    int count15to19M = 0;
                    int count20to24F = 0;
                    int count20to24M = 0;
                    int count25to29F = 0;
                    int count25to29M = 0;
                    int count30to34F = 0;
                    int count30to34M = 0;
                    int count35to39F = 0;
                    int count35to39M = 0;
                    int count40to44F = 0;
                    int count40to44M = 0;
                    int count45to49F = 0;
                    int count45to49M = 0;
                    int count50to54F = 0;
                    int count50to54M = 0;
                    int count55to59F = 0;
                    int count55to59M = 0;
                    int count60to64F = 0;
                    int count60to64M = 0;
                    int countAbove65F = 0;
                    int countAbove65M = 0;
                    int countTotalF = 0;
                    int countTotalM = 0;
                    
                    for(int i = 0; i<list.size(); i++) {//MASTERLIST
                        Diagnosis d = new Diagnosis();
                        d=list.get(i);
                        
                        %>
                        <tr align="center">
                        <td align="left"> <%=d.getDiagnosis()%></td>
                        <%
                            
                            //UNDER 1 MALE*****************************************
                            if(countUnder1M != listUnder1M.size()){
                                Diagnosis temp = listUnder1M.get(countUnder1M);
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    countUnder1M++;
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%

                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //UNDER 1 FEMALE****************************************
                            if(countUnder1F != listUnder1F.size()){
                                Diagnosis temp = listUnder1F.get(countUnder1F);
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    countUnder1F++;
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%

                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //1-4 MALE
                            if(count1to4M != list1to4M.size()){ // count & list
                                Diagnosis temp = list1to4M.get(count1to4M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count1to4M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //1-4 FEMALE
                            if(count1to4F != list1to4F.size()){
                                Diagnosis temp = list1to4F.get(count1to4F);
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count1to4F++;
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }

                            //5-9 MALE
                            if(count5to9M != list5to9M.size()){ // count & list
                                Diagnosis temp = list5to9M.get(count5to9M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count5to9M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //5-9 FEMALE
                            if(count5to9F != list5to9F.size()){ // count & list
                                Diagnosis temp = list5to9F.get(count5to9F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count5to9F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }

                            //10-14 MALE
                            if(count10to14M != list10to14M.size()){ // count & list
                                Diagnosis temp = list10to14M.get(count10to14M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count10to14M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //10-14 FEMALE
                            if(count10to14F != list10to14F.size()){ // count & list
                                Diagnosis temp = list10to14F.get(count10to14F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count10to14F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //15-19 MALE
                            if(count15to19M != list15to19M.size()){ // count & list
                                Diagnosis temp = list15to19M.get(count15to19M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count15to19M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //15-19 FEMALE
                            if(count15to19F != list15to19F.size()){ // count & list
                                Diagnosis temp = list15to19F.get(count15to19F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count15to19F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //20-24 MALE
                            if(count20to24M != list20to24M.size()){ // count & list
                                Diagnosis temp = list20to24M.get(count20to24M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count20to24M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //20-24 FEMALE
                            if(count20to24F != list20to24F.size()){ // count & list
                                Diagnosis temp = list20to24F.get(count20to24F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count20to24F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //25-29 MALE
                            if(count25to29M != list25to29M.size()){ // count & list
                                Diagnosis temp = list25to29M.get(count25to29M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count25to29M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //25-29 FEMALE
                            if(count25to29F != list25to29F.size()){ // count & list
                                Diagnosis temp = list25to29F.get(count25to29F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count25to29F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //30-34 MALE
                            if(count30to34M != list30to34M.size()){ // count & list
                                Diagnosis temp = list30to34M.get(count30to34M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count30to34M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //30-34 FEMALE
                            if(count30to34F != list30to34F.size()){ // count & list
                                Diagnosis temp = list30to34F.get(count30to34F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count30to34F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //35-39 MALE
                            if(count35to39M != list35to39M.size()){ // count & list
                                Diagnosis temp = list35to39M.get(count35to39M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count35to39M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //35-39 FEMALE
                            if(count35to39F != list35to39F.size()){ // count & list
                                Diagnosis temp = list35to39F.get(count35to39F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count35to39F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //40-44 MALE
                            if(count40to44M != list40to44M.size()){ // count & list
                                Diagnosis temp = list40to44M.get(count40to44M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count40to44M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //40-44 FEMALE
                            if(count40to44F != list40to44F.size()){ // count & list
                                Diagnosis temp = list40to44F.get(count40to44F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count40to44F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //45-49 MALE
                            if(count45to49M != list45to49M.size()){ // count & list
                                Diagnosis temp = list45to49M.get(count45to49M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count45to49M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //45-49 FEMALE
                            if(count45to49F != list45to49F.size()){ // count & list
                                Diagnosis temp = list45to49F.get(count45to49F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count45to49F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //50-54 MALE
                            if(count50to54M != list50to54M.size()){ // count & list
                                Diagnosis temp = list50to54M.get(count50to54M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count50to54M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //50-54 FEMALE
                            if(count50to54F != list50to54F.size()){ // count & list
                                Diagnosis temp = list50to54F.get(count50to54F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count50to54F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //55-59 MALE
                            if(count55to59M != list55to59M.size()){ // count & list
                                Diagnosis temp = list55to59M.get(count55to59M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count55to59M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //55-59 FEMALE
                            if(count55to59F != list55to59F.size()){ // count & list
                                Diagnosis temp = list55to59F.get(count55to59F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count55to59F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            
                            //55-59 MALE
                            if(count60to64M != list60to64M.size()){ // count & list
                                Diagnosis temp = list60to64M.get(count60to64M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count60to64M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //60-64 FEMALE
                            if(count60to64F != list60to64F.size()){ // count & list
                                Diagnosis temp = list60to64F.get(count60to64F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    count60to64F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }

                            //65 & Above MALE
                            if(countAbove65M != listAbove65M.size()){ // count & list
                                Diagnosis temp = listAbove65M.get(countAbove65M);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    countAbove65M++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //65 & Above FEMALE
                            if(countAbove65F != listAbove65F.size()){ // count & list
                                Diagnosis temp = listAbove65F.get(countAbove65F);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    countAbove65F++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }

                            //TOTAL MALE
                            if(countTotalM != listTotalM.size()){ // count & list
                                Diagnosis temp = listTotalM.get(countTotalM);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    countTotalM++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                            //TOTAL FEMALE
                            if(countTotalF != listTotalF.size()){ // count & list
                                Diagnosis temp = listTotalF.get(countTotalF);// count & list
                                if(d.getDiagnosis_id() != temp.getDiagnosis_id()){
                                    %><td align="center">0</td><%
                                }else{
                                    countTotalF++;               //count
                                    %><td align="center"><%=temp.getNumOfCases()%></td><%
                                }
                            }else{
                                %><td align="center">0</td><%
                            }
                    %>
                
                    
                    <!--
                    <td align="center">0</td>
                    <td align="center">0</td>
                    -->
                    

                    
                    <!--<td align="center">0</td>-->
                <!--</tr>-->
                <%}%>
                </tr>
                <!--
                <tr align="center">
                   <td align="left"> Disease#1</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                    <td align="center">0</td>
                </tr>
                -->
                
            </table>
            </div><!--x_content-->
            <%}%>
            
           
            
            
        </div> <!--x_panel--> <!-- END of M2 REPORT-->
        
        
        
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
                <!-- Custom Theme Scripts -->
                <script src="source/js/custom.min.js"></script>
                <!-- DAGDAG bootstrap datepicker -->
                <script src="vendors/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    
<!-- IFRAME SIMPLE CODE  
<div>
    <a href="web/views/reports/m2/1.html" target="targetframe">Page 1</a><br>
    <a href="web/views/reports/m2/2.html" target="targetframe">Page 2</a><br />
    <a href="web/views/reports/m2/3.html" target="targetframe">Page 3</a>
</div>
-->



</body>

  <!--DAGDAG YEAR ADSJFLKADJS-->
   <script type="text/javascript">
         $('#selectedDate2').datepicker({
         minViewMode: 2,
         format: 'yyyy'
       });

    </script>
</html>