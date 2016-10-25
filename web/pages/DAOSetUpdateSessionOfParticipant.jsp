<%-- 
    Document   : DAOSetUpdateSessionOfParticipant
    Created on : 20 Jul, 2015, 4:09:54 PM
    Author     : Abinaya
--%>


<%@page import="org.project.bean.RegistrationDetails"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String workshopid = request.getParameter("workshopid").trim();
    String participantid = request.getParameter("participantid").trim();
    String date_of_session = request.getParameter("date").trim();
    String session_values = request.getParameter("session_update");
    int updated = process.updateSessionCommentOfParticipant(workshopid, participantid, date_of_session, session_values);
    Gson gson = new Gson();
    gson.toJson(updated);
    out.print(gson.toJson(updated));
%>