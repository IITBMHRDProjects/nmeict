<%-- 
    Document   : DAOCreateExcel_PaymentDetailsOfParticipants
    Created on : 19 Jan, 2016, 12:09:32 PM
    Author     : dipesh
--%>


<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String type = request.getParameter("type");
    String context = getServletContext().getRealPath("/");
    int count=0;
    count = process.setQuery_PaymentDetailsOfParticipants(type, context);
    String filename = "paymentdetailsSummary";
    Gson gson = new Gson();
     if (count > 0) {
        gson.toJson(filename);
        out.print(gson.toJson(filename));
    } else {
        gson.toJson(filename);
        out.print(gson.toJson("demo"));
    }
%>
