<%-- 
    Document   : DAOFetchWSCEmail
    Created on : 1 Oct, 2015, 1:17:45 PM
    Author     : Abinaya
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String workshopid = request.getParameter("workshopid");
    String rcid = request.getParameter("rcid");
    String wsc_email = process.WSC_email(workshopid, rcid);
    String wsc_if_already_nominated = process.checkIfExistInWSCNominations(workshopid, rcid);
    ArrayList<String> data = new ArrayList<String>();
    data.add(wsc_email);
    data.add(wsc_if_already_nominated);
    Gson gson = new Gson();
    gson.toJson(data);
    out.print(gson.toJson(data));
%>