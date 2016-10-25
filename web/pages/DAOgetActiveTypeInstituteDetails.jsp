<%-- 
    Document   : DAOgetActiveTypeInstituteDetails
    Created on : 11 Feb, 2015, 5:15:38 PM
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
    String activeType = request.getParameter("active");
    ArrayList<Institute> institutes = new ArrayList<Institute>();
    institutes=process.list_InstituteDetails(Integer.parseInt(activeType));
    Gson gson = new Gson();
    gson.toJson(institutes);
    out.print(gson.toJson(institutes));
%>