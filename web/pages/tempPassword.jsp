<%-- 
    Document   : tempPassword
    Created on : 2 Sep, 2014, 3:03:26 PM
    Author     : mayank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<body> 
    <!-- Message Error -->
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <!-- End Message Error -->
    <%
        String tmpl = request.getParameter("tmpl");
    %>
    <h3>Change Password</h3>       
    <div class="form_enclosure">        
        <form id="tempPasswordForm" class="tempPasswordForm" action="doTempPassword.html" method="post" onsubmit="return validateTempPasswordForm();">   
            <div class="form_settings">
                <div class="form_box"><br/>
                    <p><span>New Password</span><input type="password" id="password" name="password" value="" maxlength="15" class="tipTip" title="<s:property value="getText('form.npassword')"/>"/>
                        <label id="passwordError" class="errormsg"><s:property value="getText('registrationPage.passworderror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('passwordError').get(0)"/></label>
                    </p><br/>
                    <p><span>Confirm new password</span><input id="cpassword" type="password" name="cpassword" value="" maxlength="15" class="tipTip" title="<s:property value="getText('form.cpassword')"/>" onblur="funPCE()"/>
                        <label id="cpasswordError" class="errormsg"><s:property value="getText('registrationPage.cpasswordError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('cpasswordError').get(0)"/></label>
                    </p><br/>
                    <div style="margin-top:5px;"><input style="margin-right: 15px;" class="submit" type="submit" name="submit" value="Submit" /><input style="margin-left: 5px;" type="reset" class="submit" name="reset" value="Reset" onclick="resetTempPassForm();" /></div>
                    <input id="tmpl" type="hidden" name="tmpl" value="<%=tmpl%>"/>
                </div>  
            </div>
        </form>
    </div>
</body>

