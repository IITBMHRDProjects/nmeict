<%-- 
    Document   : DAOCreateExcel_RCWiseReport
    Created on : 28 May, 2015, 11:30:58 PM
    Author     : asl
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%
    UtilityProcess process = new UtilityProcess();
    String type = request.getParameter("type");
    String context = getServletContext().getRealPath("/");
    int count = process.setQuery_RCWiseDetails(type,context);
    String filename = "demo";
    if (type.equals("gender")) {
        filename = "RCGenderWiseReport";
    } else if (type.equals("experience")) {
        filename = "RCExperienceWiseReport";
    }else if (type.equals("qualification")) {
        filename = "RCQualificationWiseReport";
    }else if (type.equals("geographical")) {
        filename = "RCGeographicalWiseReport";
    }else if (type.equals("all")) {
        filename = "RCAllReport";
    }
    if (count > 0) {
        Gson gson = new Gson();
        gson.toJson(filename);
        out.print(gson.toJson(filename));
    }else{
        Gson gson = new Gson();
        gson.toJson(filename);
        out.print(gson.toJson("demo"));
    }

%>
