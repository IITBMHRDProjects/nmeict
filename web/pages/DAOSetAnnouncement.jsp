<%-- 
    Document   : DAOAetAnnouncement
    Created on : 7 Oct, 2014, 1:27:40 PM
    Author     : dipesh
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.project.bean.Announcements"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.google.gson.Gson"%>
<%
  String announcement=request.getParameter("a_data");
  UtilityProcess process = new UtilityProcess();
  ArrayList<Announcements> details=null;
  details=process.getAnnouncementData(announcement);
  Gson gson = new Gson();
  gson.toJson(details);
  out.print(gson.toJson(details));
%>

