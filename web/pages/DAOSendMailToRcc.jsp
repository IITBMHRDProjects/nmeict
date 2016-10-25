<%-- 
    Document   : DAOSendMailToRcc
    Created on : 20 Nov, 2014, 2:58:30 PM
    Author     : Abinaya
--%>

<%@page import="org.project.utilities.SendMailToRcc"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    SendMailToRcc sendmail= new SendMailToRcc();
    String workshopid = request.getParameter("data");
    String context=getServletContext().getRealPath("/"); 
    int mailsent=0;
    mailsent=sendmail.sendMail(workshopid, context);    
    Gson gson = new Gson();
    gson.toJson(mailsent);
    out.print(gson.toJson(mailsent));
%>
