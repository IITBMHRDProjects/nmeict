<%-- 
    Document   : updateInstituteSucess
    Created on : 24 Feb, 2015, 2:47:17 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% 
  String status="";
    try{
    status=(String)session.getAttribute("result");
    session.removeAttribute("result");
    }catch(Exception e){
        status="";
    }
    if(status == null){
     status="";
    }
%>
    <% if(status.equals("fail")) { %>
    <div class="form_enclosure">
        <h3>Institute Details Updated Failed.</h3>
        <p><font color="red">Institute Update Failed.</font>.</p>
        <p>To go back to the Manage Institute interface</p>
        <p>Click Here ----> <a href="viewInstitute.html?rcid=wZFlr-khrFxEMgeJzFwgvg">Manage Institute</a></p>
        <p>To go back to the home page of the administrator interface </p>
        <p>click here ---> <a href="adminHome.html">ADMIN HOME</a></p>
    </div>
  <% } else if(status.equals("success")) { %>
    <h3>Institute Details Updated Successfully</h3>
    <div class="form_enclosure">
        <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>        
        <p>You have updated the Institute Details successfully.</p> 
        <p>To go back to the Manage Institute interface</p>
        <p>Click Here ----> <a href="viewInstitute.html?rcid=wZFlr-khrFxEMgeJzFwgvg">Manage Institute</a></p>
        <p>To go back to the home page of the administrator interface </p>
        <p>click here ---> <a href="adminHome.html">ADMIN HOME</a></p>
    </div>
<% } %>
