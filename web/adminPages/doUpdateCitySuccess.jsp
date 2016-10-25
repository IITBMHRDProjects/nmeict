<%-- 
    Document   : doUpdateCitySuccess
    Created on : 24 Feb, 2015, 3:05:03 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<!DOCTYPE html>
<body>


    <div class="form_enclosure">
        <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>        
        <s:if test="hasActionErrors()" >
            <div class="errorDiv">
                <s:actionerror/>
            </div>
        </s:if>
        <s:else>
            <p style="font-weight: bold;color: green">The Data is successfully inserted/updated.</p>
        </s:else>
        <p>To go back to the Manage City interface</p>
        <p>Click Here ----> <a href="viewCity.html">View City Table</a></p>
        <p>To go back to the home page of the administrator interface </p>
        <p>click here ---> <a href="home.html">HOME</a></p>
    </div>
</body>
