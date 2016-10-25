<%-- 
    Document   : verifyLinkSuccess
    Created on : 11 Nov, 2014, 2:09:55 PM
    Author     : asl
--%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<%
    String result_status = "";
    try {
        result_status = (String) session.getAttribute("result");
        session.removeAttribute("result");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<% if (result_status.equals("Status Error")) { %>
    <%
            /**
             * content part getting from database for success
             */
            try {
                contents = new ArrayList<Content>();
                contents = process.getPage_Content("verify_email_notinlogin");
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
<h3>Account not created</h3>
<div class="form_enclosure">
    <p>It seems you have not created your 'website name' account.<br/> 
        To create an account with us, visit our home page and complete the account creation process on <a href="accessaccount.html?tmp=ARlink"><b>Sign up for Already Registered User.</b></a></p>
</div>
    <% } %>
<% }%>
<% if (result_status.equals("Status Already One")) { %>
    <%
            /**
             * content part getting from database for success
             */
            try {
                contents = new ArrayList<Content>();
                contents = process.getPage_Content("verify_email_already_verifyed");
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
<h3>Email id already verified </h3>
<div class="form_enclosure">
    <p>Your email id is already verified. To login <a href="login.html">Click Here</a></p>
</div>
    <% } %>
<% }%>
<% if (result_status.equals("Success")) { %>
    <%
            /**
             * content part getting from database for success
             */
            try {
                contents = new ArrayList<Content>();
                contents = process.getPage_Content("verify_email_success");
                for (int k = 0; k < contents.size(); k++) {
                    data = (org.project.bean.Content) contents.get(k);
                    page_content = (String) data.getContent();
                }
            } catch (Exception e) {
                page_content = "";
            }
           
    %>   <% if (!page_content.trim().equals("")) {%>
            <s:set var="content"><%= page_content%></s:set>
            <s:property escape="false" value="content"/>
    <% } else { %>
<h3>Verification link  email sent successfully</h3>
<div class="form_enclosure">
    <p>Email is sent successfully to your email id.</p>
    <p>Please click the link given in your email to proceed further.</p>
</div>
    <% } %>
<% }%>    
