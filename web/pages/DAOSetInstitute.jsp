<%-- 
    Document   : DAOSetInstitute
    Created on : 12 Aug, 2014, 11:36:15 AM
    Author     : mayank
--%>
<%@page import="org.project.bean.Institute"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.bean.City"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String cityId = request.getParameter("city");
    ArrayList<Institute> institutes = new ArrayList<Institute>();
    institutes = process.listInstitute(Integer.parseInt(cityId));
    Gson gson = new Gson();
    gson.toJson(institutes);
    out.print(gson.toJson(institutes));
%>
