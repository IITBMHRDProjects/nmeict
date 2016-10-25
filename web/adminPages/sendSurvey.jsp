<%-- 
    Document   : sendSurvey
    Created on : 11 May, 2015, 6:35:21 AM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

    <body>
        <h3>Send Survey Form</h3>
        <form action="dosendSurvey.html"  method="post" onsubmit="return validateSendSurveyForm()">
            <div class="form_settings">
                <div class="form_box">
                    <br>
                    <p><span>Type the Workshop Id : <sup><img src="images/star.png"></sup></span>
                        <input type="text" id="workshopid" name="workshopid" value="" onkeypress="return onlyNumbers1(event)" maxlength="15" class="tipTip" title=""/>
                        <label id="widError" class="errormsg"><s:property value="getText('survey.widerror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('widError').get(0)"/></label>
                    </p><br/>
                    <p>
                        <input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" />
                        <input style="position: relative; right:75px"  class="submit" type="reset" name="reset" value="Reset" onclick=""/>
                    </p>
                </div>
            </div>
        </form>
    </body>

