<%-- 
    Document   : DAOCreateExcel_instituteDetails
    Created on : 3 Mar, 2015, 1:13:03 PM
    Author     : asl
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%
    UtilityProcess process = new UtilityProcess();
    String type=request.getParameter("type");
    String context=getServletContext().getRealPath("/");
    int count = process.setQuery_instituteDetails(Integer.parseInt(type),context);
    String filename="demo"; 
    if(Integer.parseInt(type) == 1){
        filename="Active_Institute";
    } else if(Integer.parseInt(type) == -1){
        filename="Not_Approved_Institute";
    } else if(Integer.parseInt(type) == 0){
        filename="In_Active_Institute";
    } 
    Gson gson = new Gson();
    if(count > 0){
       gson.toJson(filename);
       out.print(gson.toJson(filename));
     }else{
       gson.toJson(filename);
       out.print(gson.toJson("demo"));
    }
%>

