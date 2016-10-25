<%-- 
    Document   : DAOSetRemoteCenterStateWise
    Created on : 23 Apr, 2015, 2:10:22 PM
    Author     : asl
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.bean.RemoteCenter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%
    UtilityProcess process = new UtilityProcess();
   // String[] splited = request.getParameter("workshopid").trim().split(" ");
    String stateid=request.getParameter("stateid").trim();
    ArrayList<RemoteCenter> rc = new ArrayList<RemoteCenter>();
   // rc = process.listRemoteCentersStatewise(Integer.parseInt(stateid));
    Gson gson = new Gson();
    gson.toJson(rc);
    out.print(gson.toJson(rc));
%>