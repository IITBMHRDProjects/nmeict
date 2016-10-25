<%-- 
    Document   : DAOGenerateAttendanceSheet
    Created on : 6 Jul, 2015, 4:48:35 PM
    Author     : Abinaya
--%>

<%@page import="org.project.bean.RegistrationDetails"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String workshopid = request.getParameter("workshopid").trim();    
    int updated = process.createAttendanceSheet(workshopid);
    Gson gson = new Gson();
    gson.toJson(updated);
    out.print(gson.toJson(updated));
%>