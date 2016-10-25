<%-- 
    Document   : DAOCheckIfCanBeWSC
    Created on : 28 Oct, 2015, 4:28:48 PM
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
    String email = request.getParameter("email");
    String wsc_email = process.WSC_email(workshopid, rcid);
    String if_can_be_nominated = process.checkIfCanBeNominatedAsWSC(email, workshopid, rcid);
    if (if_can_be_nominated.equals("")) {
        if_can_be_nominated = "1";
    }
    ArrayList<String> data = new ArrayList<String>();
    data.add(if_can_be_nominated);
    data.add(email);
    Gson gson = new Gson();
    gson.toJson(data);
    out.print(gson.toJson(data));
%>