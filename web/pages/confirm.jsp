<%-- 
    Document   : confirm
    Created on : 16 Aug, 2014, 8:04:41 PM
    Author     : mayank
--%>

<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<h3>Registration Initiated!</h3>
<div class="form_enclosure">
    <% String success_content = "";
            ArrayList<Content> contents = null;
            Content data = new Content();
            UtilityProcess process = new UtilityProcess();
            try {
                contents = new ArrayList<Content>();
                contents = process.getPage_Content("sign_up_success");
                for (int k = 0; k < contents.size(); k++) {
                    data = (org.project.bean.Content) contents.get(k);
                    success_content = (String) data.getContent();
                }
            } catch (Exception e) {
                success_content = "";
            }
        %>
        <% if (!success_content.trim().equals("")) {%>
        <s:set var="content"><%= success_content%></s:set>
        <p><b>Dear <s:property value="person.firstName"/> <s:property value="person.lastName"/>,</b></p>
        <s:property escape="false" value="content"/>
        <% } else { %>
    <p><b>Dear <s:property value="person.firstName"/> <s:property value="person.lastName"/>,</b></p>
    <p>You have initiated registration on  'Project Name' portal.</p>
    <p>Please verify your email address by clicking the <b>VERIFICATION LINK</b> mailed to you. If you don't get the verification email <a href="accessaccount.html?tmp=vlink">CLICK HERE</a>. </p>
    <p>After verification, your  'Project Name' account will be created. </p>
        <% } %>
</div>
