<%-- 
    Document   : DAOSetUpdateComment
    Created on : 2 Jun, 2015, 3:28:40 PM
    Author     : Abinaya
--%>

<%@page import="org.project.bean.RegistrationDetails"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String time_slot_from = request.getParameter("time_slot_from").trim();
    String time_slot_to = request.getParameter("time_slot_to").trim();
    String sessionid = request.getParameter("sessionid").trim();
    String comment = request.getParameter("comment").trim();
    int isActive = Integer.parseInt(request.getParameter("isActive").trim());
    String update_till = request.getParameter("update_till").trim();
    int updated = process.updateSessionComment(comment, sessionid, time_slot_from, time_slot_to, isActive, update_till);
    Gson gson = new Gson();
    gson.toJson(updated);
    out.print(gson.toJson(updated));

%>