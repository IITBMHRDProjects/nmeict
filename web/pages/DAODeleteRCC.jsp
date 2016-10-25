<%-- 
    Document   : DAODeleteRCC
    Created on : 19 Jan, 2015, 3:01:53 PM
    Author     : asl
--%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
<%
    String workshopid = request.getParameter("workshopid");
    String rcid = request.getParameter("rcid");
    String ava_seats = request.getParameter("ava_seats");
    String ava_accomo = request.getParameter("ava_accomo");
    String utypeid = request.getParameter("userId");
    int wid = 0, rid = 0, a_seats = 0, a_accomo = 0, uid = 0;
    SimpleStringCipher cipher = new SimpleStringCipher();
    workshopid = cipher.decrypt(workshopid);
    rcid = cipher.decrypt(rcid);
    try {
        wid = Integer.valueOf(workshopid);
        rid = Integer.valueOf(rcid);
        a_seats = Integer.valueOf(ava_seats);
        a_accomo = Integer.valueOf(ava_accomo);
        uid = Integer.valueOf(utypeid);
    } catch (Exception e) {
    }
    UtilityProcess uproc = new UtilityProcess();
    boolean deleteRes = false;
    int participantExist = 0;
    participantExist = uproc.partcipantExistInRemoteCenter(wid, rid);
    if(participantExist > 0){
        out.print("exist");
    }else if (participantExist == 0) {
        deleteRes = uproc.deleteParticularRCCapacity(wid, rid, a_seats, a_accomo, uid);
        if (deleteRes) {
            out.print("true");
        } else {
            out.print("false");
        }
    }
%>
