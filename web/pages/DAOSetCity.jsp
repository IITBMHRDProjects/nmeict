<%-- 
    Document   : DAOSetCity
    Created on : 11 Aug, 2014, 3:17:35 PM
    Author     : mayank
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.bean.City"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String stateId = request.getParameter("state");
    String cityDisplay=null;
    int userID=0;
    try{
     cityDisplay=request.getParameter("call");
     userID=Integer.parseInt(request.getParameter("id"));
    }
    catch(Exception e){
     cityDisplay="";
    }
    ArrayList<City> cities = new ArrayList<City>();
    if(cityDisplay == null){
    cities = process.listCity(Integer.parseInt(stateId));
    }else if(cityDisplay.equals("editP")){
     cities = process.listPerCity(Integer.parseInt(stateId), userID);
    }
    else{
     cities = process.listCity(Integer.parseInt(stateId));
    }
    Gson gson = new Gson();
    gson.toJson(cities);
    out.print(gson.toJson(cities));
%>
