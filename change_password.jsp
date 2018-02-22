<%-- 
    Document   : change_password
    Created on : Sep 8, 2017, 4:19:47 PM
    Author     : Aaron Estinar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    
    
                                    <div class="item form-group row ">
                                    <label class="col-md-3 form-control-label " for="password">Current Password *</label>
                                    <div class="col-md-3">
                                        <input type="password" id="currentPassword" name="currentPassword" class="form-control form-control-success" placeholder="Current Password" required="required">
                                        <span class="help-block">Please enter current password</span>
                                    </div>
                                    
                                </div>
                                <div class="item form-group row ">
                                    <label class="col-md-3 form-control-label " for="password">New Password *</label>
                                    <div class="col-md-3">
                                        <input type="password" id="password" name="password" class="form-control form-control-success" placeholder="Password" required="required">
                                        <span class="help-block">Please enter a complex password</span>
                                    </div>
                                    
                                </div>
                                <div class="item form-group row has-success">
                                    <label class="col-md-3 form-control-label" for="password2"></label>
                                    <div class="col-md-3">
                                        <input type="password" id="password2" name="password2" data-parsley-equalto="#password" class="form-control form-control-success" placeholder="Password" required="required">
                                        <span class="help-block">Please re-enter password</span>
                                    </div>
                                </div>
    
    
    
    
</html>
