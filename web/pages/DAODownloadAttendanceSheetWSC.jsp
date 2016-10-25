<%-- 
    Document   : DAODownloadAttendanceSheetWSC
    Created on : 10 Aug, 2015, 10:56:51 AM
    Author     : Abinaya
--%>

<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.project.utilities.CreateAttendanceSheetWSC"%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    String workshopid = request.getParameter("workshopid");
    String rcid = request.getParameter("rcid");
    String date = request.getParameter("date");
    String path = getServletContext().getRealPath("/");
    SimpleStringCipher cipher = new SimpleStringCipher();
    //rcid = cipher.decrypt(rcid);
    int created = 0;
    CreateAttendanceSheetWSC process = new CreateAttendanceSheetWSC();
    created = process.callfn(date, rcid, workshopid, path);
    String[] output = new String[2];
    Gson gson = new Gson();
    String pdfpath = "pdfs/attendanceSheetWSC/attendance_" + date + "_" + workshopid + "_" + rcid + ".pdf";
    String filepath = path + pdfpath;
    File f = new File(filepath);
    if (f.exists()) {
        //set the content type(can be pdf/excel/word/powerpoint etc..)
        response.setContentType("application/pdf");
        //set the header and also the Name by which user will be prompted to save
        response.setHeader("Content-Disposition", "attachment;filename=\"" + "attendance_" + date + "_" + workshopid + "_" + rcid + ".pdf" + "\"");
        //servlet output stream to the client m/c
        InputStream in = new FileInputStream(f);
        ServletOutputStream outs = response.getOutputStream();
        int bit = 256;
        int i = 0;
        try {
            while ((bit) >= 0) {
                bit = in.read();
                outs.write(bit);
            }
        } catch (IOException ioe) {
            ioe.printStackTrace(System.out);
        }
        outs.flush();
        outs.close();
        in.close();
    } else {
        //set error here
    }
   // gson.toJson(created + "*" + pdfpath);
   // out.print(gson.toJson(created + "*" + pdfpath));
%>
