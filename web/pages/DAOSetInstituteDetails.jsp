<%-- 
    Document   : DAOSetInstituteDetails
    Created on : 26 Nov, 2014, 4:29:18 PM
    Author     : asl
--%>

<%@page import="org.project.bean.Institute"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.bean.City"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String instituteId = request.getParameter("id");
    ArrayList<Institute> institutes = new ArrayList<Institute>();
    institutes = process.listParticipantInstitute(Integer.parseInt(instituteId));
    Gson gson = new Gson();
    gson.toJson(institutes);
    out.print(gson.toJson(institutes));
%>
