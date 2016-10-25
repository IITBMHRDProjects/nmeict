<%-- 
    Document   : createPassword
    Created on : 5 Nov, 2014, 11:44:57 AM
    Author     : asl
--%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
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
        String tmpl = "";
        String tmpl2 = "";
        try {
            tmpl = request.getParameter("tmpl");
            tmpl2 = request.getParameter("tmpl2");
            //System.out.println(tmpl+" "+tmpl2);
          //  tmpl=SimpleStringCipher.decrypt(tmpl);
          //  tmpl2=SimpleStringCipher.decrypt(tmpl2);
        } catch (NullPointerException e) {
            tmpl = "";
            tmpl2 = "";
        }
        if(tmpl == null){
             tmpl = "";
        }
        if(tmpl2 == null)
            tmpl2="";
    %>
    <h3>Create Password</h3>       
    <div class="form_enclosure">        
        <form id="tempPasswordForm" class="tempPasswordForm" action="doCreatePassword.html" method="post" onsubmit="return validateTempPasswordForm();">   
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
                    <input id="tmpl2" type="hidden" name="tmpl2" value="<%=tmpl2%>"/>
                </div>  
            </div>
        </form>
    </div>
</body>
