<%-- 
    Document   : changePass
    Created on : 22 Aug, 2014, 1:00:05 PM
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

    <h3>Change Password</h3>
    <div class="headmessage">Field marked with <sup><img src="images/star.png"></sup> are mandatory </div>
    <div class="form_enclosure">        
        <form id="changePassForm" class="changePassForm" action="doChangePass.html" method="post" onsubmit="return validateChangePassForm();">   
            <div class="form_settings">
                <div class="form_box"><br/>
                    <p><span>Existing Password <sup><img src="images/star.png"></sup></span><input type="password" id="epassword" name="epassword" value="" maxlength="15" class="tipTip" title="<s:property value="getText('form.epassword')"/>"/>
                        <label id="epasswordError" class="errormsg"><s:property value="getText('registrationPage.passworderror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('epasswordError').get(0)"/></label>
                    </p><br/>
                    <p><span>New Password <sup><img src="images/star.png"></sup></span><input type="password" id="password" name="password" value="" maxlength="15" class="tipTip" title="<s:property value="getText('form.npassword')"/>"/>
                        <label id="passwordError" class="errormsg"><s:property value="getText('registrationPage.passworderror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('passwordError').get(0)"/></label>
                    </p><br/>
                    <p><span>Confirm new password <sup><img src="images/star.png"></sup></span><input id="cpassword" type="password" name="cpassword" value="" maxlength="15" class="tipTip" title="<s:property value="getText('form.cpassword')"/>" onblur="funPCE()"/>
                        <label id="cpasswordError" class="errormsg"><s:property value="getText('registrationPage.cpasswordError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('cpasswordError').get(0)"/></label>
                    </p><br/>
                    <div style="margin-top:5px;"><input style="margin-right: 15px;" class="submit" type="submit" name="submit" value="Submit" /><input style="margin-left: 5px;" type="reset" class="submit" name="reset" value="Reset" onclick="resetChangePassForm();" /></div>
                </div>  
            </div>
        </form>
    </div>
</body>

