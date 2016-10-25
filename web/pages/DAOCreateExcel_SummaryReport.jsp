<%-- 
    Document   : DAOCreateExcel_SummaryReport
    Created on : 22 Apr, 2015, 10:58:05 AM
    Author     : asl
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String type = request.getParameter("type");
    String context = getServletContext().getRealPath("/");
    int count = process.setQuery_SummaryDetails(type, context);
    String filename = "demo";
    if (type.equals("status")) {
        filename = "StatusWiseReport";
    } else if (type.equals("summary")) {
        filename = "SummaryWiseReport";
    }
    Gson gson = new Gson();
    if (count > 0) {
        gson.toJson(filename);
        out.print(gson.toJson(filename));
    } else {
        gson.toJson(filename);
        out.print(gson.toJson("demo"));
    }
%>
