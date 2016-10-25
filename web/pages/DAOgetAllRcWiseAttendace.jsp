<%-- 
    Document   : DAOgetAllRcWiseAttendace
    Created on : 26 Aug, 2015, 3:15:31 PM
    Author     : dipesh
--%>
<%@page import="org.project.bean.AttendanceSchedule"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<% 
    UtilityProcess process = new UtilityProcess();
    String workshopid = request.getParameter("workshopid");
    String rcid = request.getParameter("rcid");
    String date = request.getParameter("date");
    ArrayList<AttendanceSchedule> all_details = new ArrayList<AttendanceSchedule>();
    all_details=process.getProgramSchedule_ConsolidatedAttendace(workshopid, rcid, date);
    Gson gson = new Gson();
    gson.toJson(all_details);
    out.print(gson.toJson(all_details));
%>

