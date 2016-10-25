<%-- 
    Document   : DAOCreateExcel_RCStateWiseReport
    Created on : 3 Jun, 2015, 5:53:45 PM
    Author     : asl
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%
    UtilityProcess process = new UtilityProcess();
    String type = request.getParameter("type");
    String context = getServletContext().getRealPath("/");
    int count = process.setQuery_RCStateWiseDetails(type,context);
    String filename = "demo";
    if (type.equals("gender")) {
        filename = "RCStateGenderWiseReport";
    } else if (type.equals("experience")) {
        filename = "RCStateExperienceWiseReport";
    }else if (type.equals("qualification")) {
        filename = "RCStateQualificationWiseReport";
    }else if (type.equals("geographical")) {
        filename = "RCStateGeographicalWiseReport";
    }else if (type.equals("all")) {
        filename = "RCStateAllReport";
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

