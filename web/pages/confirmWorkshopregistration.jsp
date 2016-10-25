<%-- 
    Document   : confirmWorkshopregistration
    Created on : 16 Oct, 2014, 8:05:38 PM
    Author     : Abinaya
--%>

<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%//    session = ServletActionContext.getRequest().getSession();
//    String message = "";
//    try {
//        message = (String) session.getAttribute("message");
//    } catch (NullPointerException ex) {
//        ex.printStackTrace();
//    }
//    session.removeAttribute("message");
%>
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
        contents = process.getPage_Content("workshop_successful_register");
        for (int k = 0; k < contents.size(); k++) {
            data = (org.project.bean.Content) contents.get(k);
            page_content = (String) data.getContent();
        }
    } catch (Exception e) {
        page_content = "";
    }
    String part1 = "", part2 = "";  /*
     * use in split function
     */

    try {
        String string = page_content; /*
         * storing content to variable string
         */

        String[] parts = string.split("@name");
        part1 = parts[0]; // splited first string before contain @name
        part2 = parts[1]; // splited second string after contain @name
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<% if (!page_content.trim().equals("")) {%>
<%=part1%><s:property value="person.firstName"/> <s:property value="person.lastName"/>
<%=part2%>
<%--<s:set var="content"><%= page_content%></s:set>
<s:property escape="false" value="content"/>--%>
<s:if test="workshopContent.getCategorycode() == 8">
    <div class="form_enclosure" style="padding: 10px;">
        <br>
        <p>The charges for the workshop is Rs.<s:property value="hiddenfee"/> (non refundable). Unless this amount is paid, your registration is not complete.</p>
        <% String appid="10113"; %>
        <div style="text-align: center;">
        <p style="font-size: 16px;"><b>Make Payment </b> <a style="text-decoration: none;" href="processPayment?appid=<%= appid %>&pid=<s:property value="participant.participantid"/>&amt=<s:property value="hiddenfee"/>&name=<s:property value="person.firstName"/> <s:property value="person.lastName"/>&workshopid=<s:property value="workshopContent.workshopid"/>&msg=Payment for <s:property value="workshopContent.workshopname"/>"><input style="background: #1c9212; color: white; width: 100px; height: 30px; border-radius: 10px; font-size: 16px;" type="button" value="Pay Now"></a></p>
        <%--For Payment Click Here <a href="test.com?sMsg=sAppId=10002%26sUserId=<s:property value="participant.participantid"/>%26sUserName=<s:property value="person.firstName"/> <s:property value="person.lastName"/>%26sAmountDue=<s:property value="hiddenfee"/>%26sPurpose=Payment for <s:property value="workshopContent.workshopname"/>%26sReqId=<s:property value="uniqueid"/>"><input type="button" id="payfees" value="Submit" onclick="payFees('<s:property value="person.firstName"/> <s:property value="person.lastName"/>','<s:property value="participant.participantid"/>','<s:property value="uniqueid"/>','Payment for <s:property value="workshopContent.workshopname"/>','<s:property value="hiddenfee"/>','<s:property value="workshopContent.workshopid"/>')"></a>--%>
        </div>
        <br>
    </div>
</s:if>
<% } else {%>
<h3>Registration Successful</h3>
<div class="form_enclosure">
    <br/><p><b>Dear <s:property value="person.firstName"/> <s:property value="person.lastName"/>,</b></p>    
    <p>You have successfully registered for the Short Term Training Programme(STTP).</p>   
    <p>Please check your email for a successful registration.</p>
    <p>After verification of your registration, you will be receiving an approval email for attending the STTP.</p>
    <p>Note: For  emails, also check the Spam folder of your email id.</p>
    <p>For queries, contact: senderemail</p>
    <!--<p><b>Regards,<br/>The  Team</b></p>-->
</div>
<% }%> 
