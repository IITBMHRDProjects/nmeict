<%-- 
    Document   : rc_alreadyRegisteredForWorkshop
    Created on : 19 Nov, 2014, 12:53:28 PM
    Author     : Abinaya
--%>

<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<%
    /**
     * content part getting from database for success
     */
    String page_content = "";
    ArrayList<Content> contents = null;
    Content data = new Content();
    UtilityProcess process = new UtilityProcess();
    try {
        contents = new ArrayList<Content>();
        contents = process.getPage_Content("remote_center_already_register");
        for (int k = 0; k < contents.size(); k++) {
            data = (org.project.bean.Content) contents.get(k);
            page_content = (String) data.getContent();
        }
    } catch (Exception e) {
        page_content = "";
    }
    String part1 = "", part2 = "";  /*use in split function*/

    try {
        String string = page_content; /* storing content to variable string*/

        String[] parts = string.split("@name");
        part1 = parts[0]; // splited first string before contain @name
        part2 = parts[1]; // splited second string after contain @name
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<% if (!page_content.trim().equals("")) {%>
<%=part1%><s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>
<%=part2%>
<%--<s:set var="content"><%= page_content%></s:set>
<s:property escape="false" value="content"/>--%>

<% } else { %>
<h3>Remote Center Already Registered!</h3>
<div class="form_enclosure">
    <br/>
    <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>
    <p style="color: green">Your Remote Center is already registered for this coordinator workshop in this site.</p>
    <p><b>Regards,<br/>The  Team</b></p>
</div>
<% } %>
