<%-- 
    Document   : confirmWInsertion
    Created on : 12 Oct, 2014, 4:08:06 PM
    Author     : Abinaya
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<h3>Successfully Inserted!</h3>
<s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId != 1}'>
    <div class="form_enclosure">
        <br/>
        <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>
        <p>You have inserted the workshop details successfully in the database.</p>
        <p>To go back to the home page of the administrator interface </p>
        <p>click here ---> <a href="adminHome.html">ADMIN HOME</a></p>
    </div>
</s:if>