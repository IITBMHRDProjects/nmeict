<%-- 
    Document   : updateLetterSuccess
    Created on : 20 Oct, 2014, 5:01:38 PM
    Author     : asl
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String letterStatus = null;
    try {
        letterStatus = (String) session.getAttribute("letter");
        session.removeAttribute("letter");       
    } catch (Exception e) {
        e.printStackTrace();
    }
    
%>
<% if (letterStatus.equals("Not Updated")) { %>
<h3>Update Failed!</h3>
<div class="form_enclosure">
    <p>Your Permission Letter is not Updated.</p>
    <p>Please try again.</p>
    <p>Click Here to Go ...<a href="home.html">Home</a></p>
</div>
<% } else {%>
<h3>Update Successful!</h3>
<div class="form_enclosure">
    <p>You have successfully Update the Permission Letter.</p>
    <p>Click Here to Go ...<a href="home.html">Home</a></p>
</div>
<% }%>
