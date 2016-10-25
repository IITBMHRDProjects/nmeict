<%-- 
    Document   : DAOGetWorkshopid
    Created on : 10 Oct, 2014, 6:51:42 PM
    Author     : Abinaya
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String categorycode = request.getParameter("categorycode");
    int worksopid = 0;
    worksopid = process.getLatestWorkshopid(Integer.parseInt(categorycode));
    Gson gson = new Gson();
    gson.toJson(worksopid);
    out.print(gson.toJson(worksopid));
%>

