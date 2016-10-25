<%-- 
    Document   : DAOUpdateNominatedWSC
    Created on : 5 Oct, 2015, 10:25:47 AM
    Author     : Abinaya
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String id = request.getParameter("id");
    String active_till = request.getParameter("active_till");
    int updated = process.updatedNominatedWSC(id, active_till);
    Gson gson = new Gson();
    gson.toJson(updated);
    out.print(gson.toJson(updated));
%>