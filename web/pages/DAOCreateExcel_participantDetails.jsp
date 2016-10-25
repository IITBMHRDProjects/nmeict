<%-- 
    Document   : DAOCreateExcel_participantDetails
    Created on : 1 Dec, 2014, 10:12:52 AM
    Author     : Abinaya
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%
    UtilityProcess process = new UtilityProcess();
    String[] splited = request.getParameter("data").trim().split(" ");
    String workshopid = (splited[0]);
    String categorycode = (splited[1]);
    String rcid = (splited[2]);
    String res_coid=(splited[3]);
    String context=getServletContext().getRealPath("/");
    int count = process.setQuery(workshopid, categorycode, rcid, context, res_coid);
    ArrayList return_ex = new ArrayList();
    return_ex.add(count);
    return_ex.add(rcid);
    return_ex.add(workshopid);
    Gson gson = new Gson();
    gson.toJson(return_ex);
    out.print(gson.toJson(return_ex));

%>