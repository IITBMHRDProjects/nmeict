<%-- 
    Document   : accessaccountSuccess
    Created on : 3 Sep, 2014, 12:07:38 PM
    Author     : mayank
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
    String status="";
    try{
    status=(String)session.getAttribute("validateError");
    session.removeAttribute("validateError");
    }catch(Exception e){
        status="";
    }
    if(status == null){
     status="";
    }
%>
<% if(status.equals("success")) { %>
    <%
        /**
         * content part getting from database for success
         */
        try {
            contents = new ArrayList<Content>();
            contents = process.getPage_Content("forgot_password_success");
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
<h3>Forgot Password Link sent successfully </h3>
<div class="form_enclosure">
    
    <p>Link for password reset has been sent to your registered email account.<br/>
After resetting the password, use the new password when you login next time.</p>
</div>
    <% } %>
<% } else if(status.equals("notinlogin")) { %>
     <%
        /**
         * content part getting from database for failed(not in login)
         */
        try {
            contents = new ArrayList<Content>();
            contents = process.getPage_Content("forgot_password_notinlogin");
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
<h3>Please sign up for accessing the page!</h3>
<div class="form_enclosure">
    <p><font color="red">You have not Signed up with our New Website</font> ,<br>
        Please go to <a style="color: #5958a8;"  href="accessaccount.html?tmp=ARlink">Sign up for Already Registered User</a> link to register yourself with the site.</p>
   
</div>
    <% } %>
<% } else if(status.equals("notverify")) { %>
    <%
        /**
         * content part getting from database for failed(not verify yet)
         */
        try {
            contents = new ArrayList<Content>();
            contents = process.getPage_Content("forgot_password_notverify");
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
<h3>Verify email id for accessing the page!</h3>
<div class="form_enclosure">
    <p><font color="red">Please verify your email id first.</font></p>
</div>
    <% } %>
<% } %>
