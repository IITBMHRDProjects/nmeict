<%-- 
    Document   : DAOCreateExcel_ParticipantSummaryReport
    Created on : 27 Apr, 2015, 11:27:34 PM
    Author     : asl
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<% 
 UtilityProcess process = new UtilityProcess();
    String type = request.getParameter("type");
    String context = getServletContext().getRealPath("/");
  //  int count = process.setQuery_SummaryDetails(type, context);
    int count = process.setQuery_ParticipantSummaryDetails(type, context);
    String filename = "demo";
    if (type.equals("gender")) {
        filename = "GenderWiseReport";
    } else if (type.equals("experience")) {
        filename = "ExperienceWiseReport";
    }else if (type.equals("qualification")) {
        filename = "QualificationWiseReport";
    }else if (type.equals("state_city")) {
        filename = "State_CityWiseReport";
    }else if (type.equals("geographical")) {
        filename = "GeographicalWiseReport";
    }else if (type.equals("all")) {
        filename = "AllReport";
    }
    
    Gson gson = new Gson();
    if (count > 0) {
        gson.toJson(filename);
        out.print(gson.toJson(filename));
    } else {
        gson.toJson(filename);
        out.print(gson.toJson("demo"));
    }
%>
