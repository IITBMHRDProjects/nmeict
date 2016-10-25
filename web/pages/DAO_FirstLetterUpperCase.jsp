<%-- 
    Document   : DAO_FirstLetterUpperCase
    Created on : 30 Sep, 2015, 4:40:02 PM
    Author     : dipesh
--%>
<%@page import="org.project.misc.CapitalizeName_PersonTable"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%
    CapitalizeName_PersonTable convertVal = new CapitalizeName_PersonTable();
    String value = request.getParameter("val").trim();
    String id= request.getParameter("id").trim();
    value = convertVal.capitalizeString(value);
    Gson gson = new Gson();
    gson.toJson(value+"$"+id);
    out.print(gson.toJson(value+"$"+id));
%>
