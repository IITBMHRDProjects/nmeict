<%-- 
    Document   : adminHome
    Created on : 28 Aug, 2014, 2:29:01 PM
    Author     : Abinaya
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
    SimpleStringCipher cipher = new SimpleStringCipher();
    String status = cipher.encrypt("status");
    String details = cipher.encrypt("details");
    String view = cipher.encrypt("view");
    String auto_link = cipher.encrypt("auto_link");
    String updateReg = cipher.encrypt("updateReg");
    String certificate = cipher.encrypt("certificate");
    String all = cipher.encrypt("all");
%>
<body>
    <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId != 1}'>
        <h3>Administrator Interface</h3>
        <div class="headmessage">
            *Click 'Click Here' to navigate to the respective page.
        </div>
        <div class="form_enclosure">    
            <table class="content_container1">
                <s:if test='%{#session.loggedInUser.roleId == 6}'>
                    <tr><td>Auto Confirm Registered Participants &nbsp;&nbsp;&nbsp; <a href="workshopsIndex.html?update=<%=auto_link%>" style="color: #5958a8;">Click Here</a></td></tr>
                </s:if>
                <s:if test='%{#session.loggedInUser.roleId == 5}'>
                    <tr><td>Manage  Workshops&nbsp;&nbsp;&nbsp;<a href="manageWorkshops.html" style="color: #5958a8;">Click Here</a></td></tr>
                    <tr><td>Manage Announcements&nbsp;&nbsp;&nbsp;   <a href="manageAnnouncements.html" style="color: #5958a8;">Click Here</a></td></tr>
                </s:if>
                <s:if test='%{ (#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 5) }'>
                    <tr><td>Update Status of Participants&nbsp;&nbsp;&nbsp;  <a href="workshopsIndex.html?update=<%=status%>" style="color: #5958a8;">Click Here</a></td></tr>
                </s:if>
                <s:if test='%{ (#session.loggedInUser.roleId == 4) || (#session.loggedInUser.roleId == 5) }'>
                    <tr><td>Update Registration of Participants&nbsp;&nbsp;&nbsp;  <a href="workshopsIndex.html?update=<%=updateReg%>" style="color: #5958a8;">Click Here</a></td></tr>
                </s:if>
                <s:if test='%{ (#session.loggedInUser.roleId == 4) || (#session.loggedInUser.roleId == 5) }'>
                    <%-- <tr><td>Update Details of Participants &nbsp;&nbsp;&nbsp; <a href="workshopsIndex.html?update=<%=details%>">Click Here</a></td></tr>
                    --%> </s:if>
                <s:if test='%{#session.loggedInUser.roleId == 5}'>
                    <tr><td>Manage Remote Center Capacity  &nbsp;&nbsp;&nbsp; <a href="manageRCCapacity.html" style="color: #5958a8;">Click Here</a></td></tr>
                </s:if>
                <s:if test='%{#session.loggedInUser.roleId == 5}'>
                    <tr><td>Update User Role &nbsp;&nbsp;&nbsp; <a href="userTypeUpdate.html" style="color: #5958a8;">Click Here</a></td></tr>
                    <tr><td>Manage Configuration Tables <a href="viewConfigTables.html" style="color: #5958a8;">Click Here</a></td></tr>
                    <tr><td>Manage Cities &nbsp;&nbsp;&nbsp; <a href="viewCity.html" style="color: #5958a8;">Click Here</a></td></tr>
                </s:if>
                <%--  <s:if test='%{(#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 5)}'>
                      <tr><td>Manage Remote Centers  &nbsp;&nbsp;&nbsp; <a href="viewRC.html?rcid=<%=all%>" style="color: #5958a8;">Click Here</a></td></tr>
                  </s:if> --%>
                <s:if test='%{(#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 6) || (#session.loggedInUser.roleId == 5)}'>
                    <tr><td>Manage Institute  &nbsp;&nbsp;&nbsp; <a href="viewInstitute.html?rcid=<%=all%>" style="color: #5958a8;">Click Here</a></td></tr>
                </s:if>
                <s:if test='%{(#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 6) || (#session.loggedInUser.roleId == 5)}'>
                    <tr><td>Change Page Content &nbsp;&nbsp;&nbsp; <a href="changePageContent.html" style="color: #5958a8;">Click here</a></td></tr>
                </s:if>
                <s:if test='%{(#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 6) || (#session.loggedInUser.roleId == 5)}'>
                    <tr><td>Change Mail Content &nbsp;&nbsp;&nbsp;<a href="changeMailContent.html" style="color: #5958a8;">Click here</a></td></tr>
                    <tr><td>View Certificate Details&nbsp;&nbsp;&nbsp;<a href="workshopsIndex.html?update=<%=certificate%>" style="color: #5958a8;">Click Here</a></td></tr>
                    <tr><td>View Summary &nbsp;&nbsp;&nbsp;<a href="viewSummary.html" style="color: #5958a8;">Click here</a></td></tr>
                    <tr><td>Workshop Participant Summary &nbsp;&nbsp;&nbsp;<a href="workshopSummary.html" style="color: #5958a8;">Click here</a></td></tr>
                    <%--<tr><td>view Survey Details &nbsp;&nbsp;&nbsp;<a href="viewSurveyDetails.html" style="color: #5958a8;">Click here</a></td></tr>--%>
                </s:if>     
                <tr><td>View Participant Details&nbsp;&nbsp;&nbsp;<a href="viewWorkshopsIndex.html?update=<%=view%>" style="color: #5958a8;">Click Here</a></td></tr>
            </table>
        </div>
    </s:if>
    <s:else>
    </s:else>
</body>



