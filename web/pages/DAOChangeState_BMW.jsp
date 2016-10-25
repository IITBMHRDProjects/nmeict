<%-- 
    Document   : DAOChangeState_BMW
    Created on : 28 Sep, 2015, 12:02:36 PM
    Author     : Abinaya
--%>
<%@page import="com.sun.org.apache.bcel.internal.generic.AALOAD"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="com.google.gson.Gson"%>
<%
    String userInterfaceId = request.getParameter("userInterfaceId");
    String val = request.getParameter("val");
    UtilityProcess process = new UtilityProcess();
    int updated = process.changeState_BMW(Integer.parseInt(userInterfaceId), val);
    Gson gson = new Gson();
    gson.toJson(updated);
    out.print(gson.toJson(updated));
%>
