<%-- 
    Document   : DAOSetConfigDetails
    Created on : 18 Feb, 2015, 11:25:33 AM
    Author     : Abinaya
--%>


<%@page import="org.project.bean.Lookups"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%@page import="com.google.gson.Gson"%>
<%
    UtilityProcess process = new UtilityProcess();
    String category = request.getParameter("category").trim();
    ArrayList<Lookups> lookups = new ArrayList<Lookups>();
    lookups = process.listConfigTableDetails(category);
    Gson gson = new Gson();
    gson.toJson(lookups);
    out.print(gson.toJson(lookups));
%>
