<%-- 
    Document   : DAOCreateExcel_AttendanceDetailsWithAllDates
    Created on : 16 Sep, 2015, 12:00:33 PM
    Author     : dipesh
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.bean.AttendanceSchedule"%>
<%@page import="org.project.utilities.ExportAttendanceDetails"%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page import="org.project.bean.AttendanceSheet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<% 
    String workshopid = request.getParameter("workshopid");
    String rcid = request.getParameter("rcid");
    UtilityProcess upro=new UtilityProcess();
    ArrayList<AttendanceSheet> details = new ArrayList<AttendanceSheet>();
    ArrayList<AttendanceSchedule> schedule = new ArrayList<AttendanceSchedule>();
    SimpleStringCipher cipher = new SimpleStringCipher();
    workshopid=cipher.decrypt(workshopid);
    rcid=cipher.decrypt(rcid);
    String filename="Attendance_"+rcid+".xls";
    String context = getServletContext().getRealPath("/");
    boolean count=false;
    try{
        details=upro.getAttendanceSheetConsolidated(workshopid, rcid);
        schedule=upro.getProgramSchedule1(workshopid, rcid);
        ExportAttendanceDetails exportObj=new ExportAttendanceDetails();
        count=exportObj.createExcel(details, filename, context,schedule);
    }catch(Exception e){e.printStackTrace();}
     if (count) {
        Gson gson = new Gson();
        gson.toJson(filename);
        out.print(gson.toJson(filename));
    }
%>

