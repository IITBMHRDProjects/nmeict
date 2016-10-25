<%-- 
    Document   : login
    Created on : 6 Jun, 2014, 4:11:23 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<body> 
    <!-- Message Error -->
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <!-- End Message Error -->   

    <h3>Login Here</h3>
    <div class="headmessage">Field marked with <sup><img src="images/star.png"></sup> are mandatory </div>
    <div class="form_enclosure">        
        <form id="loginForm" class="loginForm" action="dologin.html" method="post" onsubmit="return validateLoginForm();">   
            <div class="form_settings">
                <div class="form_box"> <br/>
                    <div style="width:558px;float:left;">
                        <p><span>E-mail <sup><img src="images/star.png"></sup></span><input type="text" id="username" name="person.loginName" value="" class="tipTip" title="<s:property value="getText('login.username')"/>"/></p>
                        <p id="userNameError" class="errormsgtype1"><s:property value="getText('username.required')"/></p>
                        <p class="errormsgtype3"><s:property value="fieldErrors.get('userName').get(0)"/></p> 
                        <p><span>Password <sup><img src="images/star.png"></sup></span><input type="password" id="password" name="person.password" value="" class="tipTip" title="<s:property value="getText('login.password')"/>"/></p>
                        <p id="passwordError" class="errormsgtype1"><s:property value="getText('password.required')"/></p>
                        <p class="errormsgtype3"><s:property value="fieldErrors.get('password').get(0)" /></p>
                        <div style="margin-top:5px;"><input style="margin-right: 15px;" class="submit" type="submit" name="submit" value="Submit" /><input style="margin-left: 5px;" class="submit" type="reset" name="reset" value="Reset" onclick="resetLoginForm();" />
                            <br/><br/><div style="font-size: 16px;"> <p style=""><a style="color: #5958a8;" href="accessaccount.html?tmp=vlink">Click here to get Verify Email Link for New Registration.</a></p></div>
                            
                        </div><br/>
                    </div>
                    <div class="image"><div style="margin-top: 150px; text-align:left; font-size:14px;"><a style="color: #5958a8" href="accessaccount.html"><!--Can't Access Account--> Forgot Password ?</a></div></div>
                </div>  
            </div>
        </form>
    </div>
    
</body>

