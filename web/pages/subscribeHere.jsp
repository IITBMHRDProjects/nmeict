<%-- 
    Document   : subscribeHere
    Created on : 26 Feb, 2016, 10:54:12 AM
    Author     : abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
    <script type="text/javascript" src="validation/validate.js"></script>
    <script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>    
    <script type="text/javascript">
        function validateSubscriptionForm11() {
            validateSubscriptionForm1();
        }
    </script>
</head>
<h3>Request for  subscription</h3>
<div>
    <s:if test='hasActionMessages()'>
        <s:actionmessage/>
    </s:if> 
</div>
<form id="loginForm" class="loginForm" action="dosubscribe.html" method="post" onsubmit="return validateSubscriptionForm();">   
    <div class="form_settings">
        <div class="form_box"> <br/>
            <div style="width:558px;float:left;">                
                <p><span>E-mail <sup><img src="images/star.png"></sup></span><input type="text" id="username" name="person.loginName" value="" class="tipTip" title="<s:property value="getText('login.username')"/>" onblur="validateSubscriptionForm11()"/></p>
                <p id="userNameError" class="errormsgtype1"><s:property value="getText('username.required')"/></p>
                <p class="errormsgtype3"><s:property value="fieldErrors.get('userName').get(0)"/></p> 
                <div style="margin-top:5px;"><input style="margin-right: 15px;" class="submit" type="submit" name="submit" value="Submit" />
                </div>
            </div>
        </div>
    </div> 
</form>