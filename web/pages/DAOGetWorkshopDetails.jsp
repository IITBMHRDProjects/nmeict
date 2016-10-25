<%-- 
    Document   : DAOGetWorkshopDetails
    Created on : 11 Oct, 2014, 3:17:35 PM
    Author     : Abinaya
--%>

<%@page import="org.project.bean.WorkshopContent"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String workshopid = request.getParameter("workshopid");
    ArrayList<WorkshopContent> details = null;
    details = process.listWorkshopContent(workshopid);
    Gson gson = new Gson();
    gson.toJson(details);
    out.print(gson.toJson(details));
%>
