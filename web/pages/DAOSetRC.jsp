<%-- 
    Document   : DAOSetRC
    Created on : 16 Oct, 2014, 5:48:14 PM
    Author     : Abinaya
--%>

<%@page import="org.project.bean.RemoteCenter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String[] splited = request.getParameter("workshopid").trim().split(" ");
    String stateID = splited[1];
    String workshopid=splited[0];
    ArrayList<RemoteCenter> rc = new ArrayList<RemoteCenter>();
    rc = process.listRemoteCenters(workshopid,stateID);
    Gson gson = new Gson();
    gson.toJson(rc);
    out.print(gson.toJson(rc));
%>