<%-- 
    Document   : DAOChangeStatus
    Created on : 11 Nov, 2014, 4:23:38 PM
    Author     : Abinaya
--%>
<%@page import="com.sun.org.apache.bcel.internal.generic.AALOAD"%>
<%@page import="org.project.utilities.ParticipantStatusUtility"%>
<%@page import="org.project.utilities.StatusMails"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="com.google.gson.Gson"%>
<%
    UtilityProcess process = new UtilityProcess();
    String[] splited = request.getParameter("data").trim().split(" ");
    String i = splited[0];
    String participantid = splited[1];
    String email = splited[2];
    String context = splited[3];
    String cc = splited[4];
    int length_splited = splited.length;
    String status = null;
    String isfaculty=null;
    if (length_splited == 6) {
        status = splited[5];
     } else if (length_splited == 7) {
        status = splited[5];
        isfaculty=splited[6];
    }
    else if (length_splited == 8) {
        status = splited[5] + " " + splited[6];
        isfaculty = splited[7];
     }
    
    String ifupdated = "";
    if (!cc.equals("7")) {
        ifupdated = process.updateParticipantStatus(participantid, status);
    } else {
//        if (status.equals("Accepted")) {
//            ifupdated = status;
//        } else {
        ifupdated = process.updateParticipantStatus(participantid, status);
//        }
    }
    StatusMails send_mail = new StatusMails();
    int mailsent = send_mail.sendMail(participantid, status, email, context);
    ArrayList<String> data1 = new ArrayList<String>();
    // code added for faculty update on Approved status
    try {
        if (cc.equals("8")) {
            if (status.equals("Request Approved")) {
                ParticipantStatusUtility putil = new ParticipantStatusUtility();
                putil.updateFacultyStatusOfParticipant(participantid, status, isfaculty, email);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    data1.add(i);
    data1.add(ifupdated);
    data1.add(cc);
    Gson gson = new Gson();
    gson.toJson(data1);
    out.print(gson.toJson(data1));
%>