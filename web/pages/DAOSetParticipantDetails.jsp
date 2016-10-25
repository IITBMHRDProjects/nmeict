<%-- 
    Document   : DAOSetParticipantDetails
    Created on : 14 Aug, 2014, 7:10:06 PM
    Author     : Abinaya
--%>

<%@page import="org.project.bean.RegistrationDetails"%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.bean.Person"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    SimpleStringCipher cipher = new SimpleStringCipher();
    String[] splited = request.getParameter("rcid").trim().split(" ");
    String rcid = "";
    if (!splited[0].equals("all")) {
        rcid = cipher.decrypt(splited[0]);
    } else {
        rcid = splited[0];
    }
    String workshopid = cipher.decrypt(splited[1]);
    String status_enc = splited[2];
    String status = cipher.decrypt(status_enc);
    String id = splited[3];
    if (id.equals("0")) {
        ArrayList<Person> participantList = new ArrayList<Person>();
        participantList = process.listParticipants(workshopid, rcid, status);
        Gson gson = new Gson();
        gson.toJson(participantList);
        out.print(gson.toJson(participantList));
    }
    if (id.equals("1")) {
        ArrayList<RegistrationDetails> countOfParticipants = new ArrayList<RegistrationDetails>();
        countOfParticipants = process.getParticipantCount(workshopid, rcid);
        Gson gson = new Gson();
        gson.toJson(countOfParticipants);
        out.print(gson.toJson(countOfParticipants));
    }
%>