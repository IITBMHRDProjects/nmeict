<%-- 
    Document   : DAOSetInstituteHeadDetails
    Created on : 3 Dec, 2014, 2:42:44 PM
    Author     : asl
--%>

<%@page import="org.project.bean.HeadDetails"%>
<%@page import="org.project.bean.Institute"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.bean.City"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String instituteId = request.getParameter("id");
    String streamid=request.getParameter("stream");
    ArrayList<HeadDetails> headdetails = new ArrayList<HeadDetails>();
     headdetails=process.listParticipantHeadInstitute(Integer.parseInt(instituteId), Integer.parseInt(streamid));
      Gson gson = new Gson();
    gson.toJson(headdetails);
    out.print(gson.toJson(headdetails));
%>
