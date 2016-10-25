<%-- 
    Document   : DAOCreateNewSession
    Created on : 10 Jun, 2015, 10:54:23 AM
    Author     : Abinaya
--%>

<%@page import="org.project.bean.RegistrationDetails"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String date = request.getParameter("date").trim();
    String comment = request.getParameter("comment").trim();
    String workshopid = request.getParameter("workshopid").trim();
    String time_slot_from = request.getParameter("timeSlotFrom").trim();
    String time_slot_to = request.getParameter("timeSlotTo").trim();
    int isActive = Integer.parseInt(request.getParameter("isActive").trim());
    String update_till = request.getParameter("update_till").trim();
    int updated = process.insertNewSession(comment, date, workshopid, time_slot_from, time_slot_to, isActive, update_till);
    Gson gson = new Gson();
    gson.toJson(updated);
    out.print(gson.toJson(updated));

%>