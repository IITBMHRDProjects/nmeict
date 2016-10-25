<%-- 
    Document   : DAOGetUploadAttendanceByRC
    Created on : 20 Aug, 2015, 12:39:56 PM
    Author     : dipesh
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="org.project.bean.AttendanceSheet"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String rcid = request.getParameter("rcid").trim();
    String wid = request.getParameter("workshopid").trim();
    ArrayList<AttendanceSheet> details = new ArrayList<AttendanceSheet>();
    details = process.getUploadAttendaceByRC(wid, rcid);
    Gson gson = new Gson();
    gson.toJson(details);
    out.print(gson.toJson(details));
%>
