<%-- 
    Document   : confirmUpdateWorkshopRegistration
    Created on : 27 Nov, 2014, 4:12:24 PM
    Author     : Abinaya
--%>

<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
        contents = process.getPage_Content("Update_Successfull_updateRegistration");
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
<% if (!page_content.trim().equals("")) { %>
<%=part1%><s:property value="person.firstName"/> <s:property value="#session.loggedInUser.lastName"/>
<%=part2%>
<%--<s:set var="content"><%= page_content%></s:set>
<s:property escape="false" value="content"/>--%>

<% } else { %>
<h3>STTP Registration Updated Successfully</h3>
<div class="form_enclosure">
    <br/><p><b>Dear <s:property value="person.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>
    <p>You have successfully updated your details for the Short Term Training Programme (STTP).</p>
    <p>After verification of your registration, you will be receiving an approval email for attending the STTP.</p>
    <p>Note: For  emails, also check the Spam folder of your email id.</p>
    <p>For queries, contact: senderemail</p>
</div>
<% } %>