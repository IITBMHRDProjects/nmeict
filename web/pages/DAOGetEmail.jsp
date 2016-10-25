<%-- 
    Document   : DAOGetEmail
    Created on : 16 Feb, 2015, 2:36:33 PM
    Author     : Abinaya
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%  int pid = 0;
    UtilityProcess process = new UtilityProcess();
    String email = request.getParameter("email").trim();
    pid = process.getUserIdOfParticipant(email);
    Gson gson = new Gson();
    gson.toJson(pid);
    out.print(gson.toJson(pid));
%>