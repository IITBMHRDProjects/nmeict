<%-- 
    Document   : DAOSetRCMain
    Created on : 16 Oct, 2014, 6:07:53 PM
    Author     : asl
--%>

<%@page import="org.project.bean.RemoteCenterCapacity"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();    
    String[] splited = request.getParameter("workshopid").trim().split(" ");
    String stateID = splited[1];
    String workshopid=splited[0];
    ArrayList<RemoteCenterCapacity> rcc = new ArrayList<RemoteCenterCapacity>();
    rcc = process.rccDetails(Integer.parseInt(stateID),Integer.parseInt(workshopid));
    Gson gson = new Gson();   
    gson.toJson(rcc);
    out.print(gson.toJson(rcc));
%>