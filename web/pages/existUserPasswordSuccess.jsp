<%-- 
    Document   : existUserMailSuccess
    Created on : 7 Nov, 2014, 11:59:28 AM
    Author     : asl
--%>

<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    /**
     * java code for getting content from database
     */
    String page_content = "";
    ArrayList<Content> contents = null;
    Content data = new Content();
    UtilityProcess process = new UtilityProcess();
%>
<% String result = (String) session.getAttribute("result");
    session.removeAttribute("result");
    if (result == null) {
        result = "";
    }
%>
<% if (result != null) {%>
<% if (result.equals("true")) {%>
        <%
            /**
             * content part getting from database for success
             */
            try {
                contents = new ArrayList<Content>();
                contents = process.getPage_Content("sign_up_existing_user_part1");
                for (int k = 0; k < contents.size(); k++) {
                    data = (org.project.bean.Content) contents.get(k);
                    page_content = (String) data.getContent();
                }
            } catch (Exception e) {
                page_content = "";
            }
        %>
        <% if (!page_content.trim().equals("")) {%>
        <s:set var="content"><%= page_content%></s:set>
        <s:property escape="false" value="content"/>
        <% } else { %>
<h3>Account and Password Creation email sent successfully </h3>
<div class="form_enclosure">
    <p> Password creation email is sent successfully to your email id. <br>Please click the link given in your email to proceed further.</p>
    <p>After you create the password, please update your profile immediately.</p>    

</div>
        <% } %>
<% } else if (result.equals("false")) {%>
        <%
            /**
             * content part getting from database for failed
             */
            try {
                contents = new ArrayList<Content>();
                contents = process.getPage_Content("sign_up_existing_user_part2");
                for (int k = 0; k < contents.size(); k++) {
                    data = (org.project.bean.Content) contents.get(k);
                    page_content = (String) data.getContent();
                }
            } catch (Exception e) {
                page_content = "";
            }
        %>
        <% if (!page_content.trim().equals("")) {%>
        <s:set var="content"><%= page_content%></s:set>
        <s:property escape="false" value="content"/>
        <% } else { %>
<h3>You are already a registered User</h3>
<div class="form_enclosure">
    <p>You are already a registered user.</p>
</div>
        <% } %>
<% } else if (result.equals("newUser")) {%>
        <%
            /**
             * content part getting from database for New User(not sign up yet)
             */
            try {
                contents = new ArrayList<Content>();
                contents = process.getPage_Content("sign_up_existing_user_part3");
                for (int k = 0; k < contents.size(); k++) {
                    data = (org.project.bean.Content) contents.get(k);
                    page_content = (String) data.getContent();
                }
            } catch (Exception e) {
                page_content = "";
            }
        %>
        <% if (!page_content.trim().equals("")) {%>
        <s:set var="content"><%= page_content%></s:set>
        <s:property escape="false" value="content"/>
        <% } else { %>
<h3>New User</h3>
<div class="form_enclosure">
    <p>If you are a new user, then go to <a href="signup.html">Sign up</a> page for registration</p>
</div>
        <% } %>
<% }%>

<% }%>
