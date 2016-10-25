<%-- 
    Document   : DAOUpdateFacultyStatus
    Created on : 18 Jan, 2016, 12:38:36 PM
    Author     : dipesh
--%>

<%@page import="org.project.utilities.ParticipantStatusUtility"%>
<%@page import="com.sun.org.apache.bcel.internal.generic.AALOAD"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    //UtilityProcess process = new UtilityProcess();
    ParticipantStatusUtility putil = new ParticipantStatusUtility();
    String pid = request.getParameter("pid");
    String isEligible_Certificate = request.getParameter("certificate_status");
    String email = request.getParameter("email");
    String iitcount = request.getParameter("iitcount");
    int updated = putil.updateFacultyStatus(pid, isEligible_Certificate);
    String updateRes="";
    if (updated > 0) {
        try {
            String context="";
           // putil.sendEmailForCerticiateType(context, email, isEligible_Certificate);
        } catch (Exception e) {
            e.printStackTrace();
        }
        updateRes=updated+"#"+iitcount;
    }
    Gson gson = new Gson();
    gson.toJson(updateRes);
    out.print(gson.toJson(updateRes));
%>
