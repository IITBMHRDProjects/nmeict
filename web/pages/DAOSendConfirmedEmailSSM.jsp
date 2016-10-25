<%-- 
    Document   : DAOSendConfirmedEmailSSM
    Created on : 3 Sep, 2015, 3:20:18 PM
    Author     : Abinaya
--%>
<%@page import="org.project.bean.Person"%>
<%@page import="org.project.utilities.StatusMails"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="com.google.gson.Gson"%>
<%
    UtilityProcess process = new UtilityProcess();
    String workshopid = request.getParameter("workshopid");
    String context = request.getParameter("context");
    ArrayList<Person> participants = new ArrayList<Person>();
    participants = process.listParticipants(workshopid, "all", "Accepted");
    StatusMails send_mail = new StatusMails();
    int mailsent = 0;
    for (int i = 0; i < participants.size(); i++) {
        String participantid = participants.get(i).getRegistrationDetails().getParticipantid();
        String status = participants.get(i).getRegistrationDetails().getStatus();
        String email = participants.get(i).getEmail();
        mailsent = mailsent + send_mail.sendMailToAcceptedSSM(participantid, status, email, context);
    }
    Gson gson = new Gson();
    gson.toJson(mailsent);
    out.print(gson.toJson(mailsent));
%>