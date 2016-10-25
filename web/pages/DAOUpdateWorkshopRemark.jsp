<%-- 
    Document   : DAOUpdateWorkshopRemark
    Created on : 1 Feb, 2016, 6:09:23 PM
    Author     : dipesh
--%>

<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UtilityProcess process = new UtilityProcess();
    String id = request.getParameter("id");
    String remark = request.getParameter("remark");
    try{
        remark = StringEscapeUtils.escapeHtml(remark);
        remark=StringEscapeUtils.escapeJavaScript(remark);
    }catch(Exception e){e.printStackTrace();}
    int updated = process.update_workshopRemark(id, remark);
    Gson gson = new Gson();
    gson.toJson(updated);
    out.print(gson.toJson(updated));
%>
