<%-- 
    Document   : DAOSetDeleteProgramSession
    Created on : 4 Jun, 2015, 9:17:35 AM
    Author     : Abinaya
--%>

<%@page import="org.project.bean.RegistrationDetails"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String sessionid = request.getParameter("sessionid").trim();
    int updated = process.deleteSession(sessionid);
    Gson gson = new Gson();
    gson.toJson(updated);
    out.print(gson.toJson(updated));

%>