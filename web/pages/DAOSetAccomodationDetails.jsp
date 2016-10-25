<%-- 
    Document   : DAOSetAccomodationDetails
    Created on : 2 Dec, 2014, 3:00:03 PM
    Author     : Abinaya
--%>

<%@page import="org.project.bean.RemoteCenterCapacity"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess proc = new UtilityProcess();
    ArrayList<RemoteCenterCapacity> rcc = new ArrayList<RemoteCenterCapacity>();
    String[] splited = request.getParameter("data").trim().split(" ");
    int rcid = Integer.parseInt(splited[0]);
    int workshopid = Integer.parseInt(splited[1]);
    int acco_remaining=-1;
    rcc = proc.rccDetails1(workshopid, rcid);
    acco_remaining=rcc.get(0).getAccomo_remaining();
    Gson gson = new Gson();
    gson.toJson(acco_remaining);
    out.print(acco_remaining);
%>
