<%-- 
    Document   : DAOGetStatusReasons
    Created on : 21 Jul, 2015, 3:35:53 PM
    Author     : asl
--%>

<%@page import="org.project.bean.RegistrationDetails"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String participantid = request.getParameter("participantid").trim();
    String status = request.getParameter("status").trim();
    String reason = process.getStatusReason(participantid, status);
    Gson gson = new Gson();
    gson.toJson(reason);
    out.print(gson.toJson(reason));
%>