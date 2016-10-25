<%-- 
    Document   : DAOgetSummaryData
    Created on : 16 Apr, 2015, 11:22:41 AM
    Author     : asl
--%>
<%@page import="org.project.bean.Summary"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<% 
 UtilityProcess process=new UtilityProcess();
 ArrayList<Summary> summary=new ArrayList<Summary>();
 summary=process.getSummaryReport();
 Gson gson = new Gson();
 gson.toJson(summary);
 out.print(gson.toJson(summary));
%>
