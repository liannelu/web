<%@page import="Model.User"%>
<%@page import="DAO.userDAO"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<%
    String userType = (String) session.getAttribute("position");
    int user_id = (Integer) session.getAttribute("user_id");
    userDAO uDAO = new userDAO();
    User currentUser = new User();
    currentUser = uDAO.retrieveUser(user_id);
%>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> PBIS </title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
	
    <!-- bootstrap-progressbar -->
    <link href="../vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="../vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
    <!-- bootstrap-daterangepicker -->
    <link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../source/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
       
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="home_nurse.jsp" class="site_title"><i class="fa fa-stethoscope"></i> <span>PBIS</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="images/nurse.png" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
               <!-- sidebar nurse-->
                <span>Welcome,</span>
                  <h2><%=currentUser.getFullname() %></h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>Nurse</h3>
                <ul class="nav side-menu">
                  <li><a href=home_nurse.jsp><i class="fa fa-home"></i> Home </a>
                  </li>
                  
                  <li><a><i class="fa fa-calendar"></i> Today View <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="view_consultations_today.jsp">View Consultations Today</a></li>
                      <li><a href="view_follow-ups_today.jsp">View Follow-ups Today</a></li>
                    </ul>
                  </li>
                  
                  <li><a><i class="fa fa-pencil-square-o"></i> Records <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="view_patients.jsp">View Patients</a></li>
                      <li><a href="view_family_codes.jsp">View Family Numbers</a></li>
                        <li><a href="view_all_consultations.jsp">View All Consultations</a></li>
                    </ul>
                  </li>
                  
                  <li><a><i class="fa fa-file-text-o"></i>Reports &amp; Analytics<span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="view_standard_reports.jsp">Reports</a></li>
                      <li><a>Programs<span class="fa fa-chevron-down"></span></a>
                          <ul class="nav child_menu">
                            <li class="sub_menu">
                              <li><a href="program_planning_without_disease.jsp">Program Proposal</a></li>
                              <li><a href="view_programs.jsp">View Programs</a></li>
                          </ul>
                        </li>
                    </ul>
                  </li>  
                   
                    </ul>
                  </li>
                </ul>
              </div>

            </div>
            <!-- /sidebar menu -->

          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu edited">
          
           <form action="UserProfile" id="UserProfile" method="post">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>      

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="images/nurse.png" alt=""><%=currentUser.getUsername() %>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                      
                      
                    
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                   
                    <li><a href="#" onclick="document.getElementById('UserProfile').submit()"> Profile</a></li>
                    
                    <input type="hidden" name="top_id" value="<%=user_id%>">
                    
                    <li><a href="Logout"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                    
                </li>
                    
                <li class=""> 
                <script type="text/javascript">
                            function GetClock(){
                                var d=new Date();
                                var nmonth=d.getMonth(),ndate=d.getDate(),nyear=d.getYear();
                                if(nyear<1000) nyear+=1900;
                                var nhour=d.getHours(),nmin=d.getMinutes();
                                if(nmin<=9) nmin="0"+nmin
                                document.getElementById('clockbox').innerHTML="<i class='fa fa-calendar-o'></i>   "+(nmonth+1)+"/"+ndate+"/"+nyear+"&nbsp&nbsp&nbsp&nbsp<i class='fa fa-clock-o'></i>   "+nhour+":"+nmin+"";
                            }
                            window.onload=function(){
                                GetClock();
                                setInterval(GetClock,1000);
                            }
                </script>
                <a id="clockbox"></a>
              </li>


                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
<!--
                <li role="presentation" class="dropdown">
                  <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope-o"></i>
                    <span class="badge bg-green">6</span>
                  </a>
                  <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <div class="text-center">
                        <a>
                          <strong>See All Alerts</strong>
                          <i class="fa fa-angle-right"></i>
                        </a>
                      </div>
                    </li>
                  </ul>
                </li>
-->
                  
                  
                  
                  
                  
                  
                  
                  
              </ul>
            </nav>
           </form>
          </div>
        </div>
        <!-- /top navigation -->

       <!-- /menu footer buttons -->
        <!--<div class="sidebar-footer hidden-small">
          <a data-toggle="tooltip" data-placement="top" title="">
            <span class="glyphicon" aria-hidden="true"></span>
          </a>
          <a data-toggle="tooltip" data-placement="top" title="">
            <span class="glyphicon" aria-hidden="true"></span>
          </a>
          <a data-toggle="tooltip" data-placement="top" title="">
            <span class="glyphicon" aria-hidden="true"></span>
          </a>
          <a data-toggle="tooltip" data-placement="top" title="Logout" href="Logout">
            <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
          </a>
        </div>-->
        <!-- /menu footer buttons -->
        
        <!-- footer content 
        <footer>
          <div class="pull-right">
            Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>
    <!-- Chart.js -->
    <script src="../vendors/Chart.js/dist/Chart.min.js"></script>
    <!-- gauge.js -->
    <script src="../vendors/gauge.js/dist/gauge.min.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="../vendors/iCheck/icheck.min.js"></script>
    <!-- Skycons -->
    <script src="../vendors/skycons/skycons.js"></script>
    <!-- Flot -->
    <script src="../vendors/Flot/jquery.flot.js"></script>
    <script src="../vendors/Flot/jquery.flot.pie.js"></script>
    <script src="../vendors/Flot/jquery.flot.time.js"></script>
    <script src="../vendors/Flot/jquery.flot.stack.js"></script>
    <script src="../vendors/Flot/jquery.flot.resize.js"></script>
    <!-- Flot plugins -->
    <script src="../vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
    <script src="../vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
    <script src="../vendors/flot.curvedlines/curvedLines.js"></script>
    <!-- DateJS -->
    <script src="../vendors/DateJS/build/date.js"></script>
    <!-- JQVMap -->
    <script src="../vendors/jqvmap/dist/jquery.vmap.js"></script>
    <script src="../vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
    <script src="../vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="../vendors/moment/min/moment.min.js"></script>
    <script src="../vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="../source/js/custom.min.js"></script>
	
  </body>
</html>




