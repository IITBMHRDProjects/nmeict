<%-- 
    Document   : DAOGetInvalidReasons
    Created on : 10 Dec, 2014, 11:33:42 AM
    Author     : asl
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.bean.Lookups"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
   UtilityProcess process = new UtilityProcess();
   ArrayList<Lookups> lookupDetails = new ArrayList<Lookups>(); 
   lookupDetails=process.listLookups("INVALID_RC", 1);
   Gson gson = new Gson();
   gson.toJson(lookupDetails);
   out.print(gson.toJson(lookupDetails));
%>

