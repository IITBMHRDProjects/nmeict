<%-- 
    Document   : generateMoodleLink
    Created on : 2 Feb, 2015, 3:08:31 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

<body>
    <h3>Links Generated</h3>
    <div class="form_enclosure">  
        <br/> 
        <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>
        <p>Links are generated successfully.</p>
        <a href="MoodleLinks/moodlelink.txt" download target="_blank">Click Here for Links</a>
     <br/>  <br/>  
    </div>
</body>

