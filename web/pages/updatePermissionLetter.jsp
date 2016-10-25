<%-- 
    Document   : updatePermissionLetter
    Created on : 20 Oct, 2014, 2:45:25 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String status = (String) session.getAttribute("Statusforletter");
    session.removeAttribute("Statusforletter");
%>
<body>
    <% if (status.equals("Applicable")) { %>

    <div class="form_enclosure">
        <s:iterator value="workshopContent">
            <h1><s:property value="workshopname" /></h1>
            <h4 align="center"> <s:property value="sponsor"/></h4>
            <br/>
            <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>    

            <div class="form_settings"></div>

            <form action="updateLetter.html" enctype="multipart/form-data"  method="post" onsubmit="return validateWRForm1(this);">
                <s:hidden id="participantid" name="participantid" value="%{participantid}"/>
                <s:hidden id="workshopid" name="workshopid" value="%{workshopid}"/>
                <div class="form_settings">
                    <div class="form_box">
                        <h2><b>Update Permission Letter</b></h2><br/>
                        <p>Please note that the scan copy of the Permission Letter should be less than 256 KB. Only jpeg/jpg format is accepted.
                            If you have any problem in registration of your candidature please contact on 022-25764987.
                            If you have any problem in uploading of Permission Letter then please email us at senderemail with subject as "Problem in Permission Letter upload"</p>
                        <p>
                            <span>Permission Letter <sup><img src="images/star.png"></sup></span>
                            <input type="file" id="permissionLetter"  name="permissionLetter"/>
                            <label id="permissionLetterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.permissionLetterError')"/></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('permissionLetterError').get(0)"/></label>
                        </p>
                        <br>
                        <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" /><input style="position: relative; right:75px"  class="submit" type="reset" name="reset" value="Reset" onclick="resetWRForm()
                                        ;"/></p>
                    </div>
                </div>
            </form>
        </s:iterator>
    </div>
    <% } else if (status.equals("Not Applicable")) { %>
    <div>
        <p><b>Only Applicable for Request Registered or Invalid.</b></p>
    </div>
    <% }%>
</body>

