<%-- 
    Document   : profileupdatedSuccessfully_admin
    Created on : 10 Dec, 2014, 3:48:42 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<h3>Profile Updated Successfully!</h3>
<div class="form_enclosure">
    <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>        
    <p>You have updated the profile of the participant successfully.</p> 
    <p> <a href="workshopsIndex.html?update=i3xJmRd10KeY8ZSDZ-PNqw">CLICK HERE</a>to navigate to the index</p>
</div>

