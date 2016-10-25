<%-- 
    Document   : DAOSetParticipantStatus
    Created on : 17 Oct, 2014, 5:26:58 PM
    Author     : asl
--%>
<%@page import="org.project.utilities.EmailUtil"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="org.project.utilities.HtmlUtility"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.project.bean.Announcements"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.google.gson.Gson"%>
<%
    String status = request.getParameter("status");
    String email = request.getParameter("email");
    String workshopid = request.getParameter("id");
    String change_status = "";
    String data = "";
    UtilityProcess process = new UtilityProcess();
    int res = 0;
//    res = process.updateParticipantStatus(status, email, Integer.parseInt(workshopid));
    if (res > 0) {
       // String fileName = "";
        if (status.equals("Approved")) {
            change_status = "Request Approved";
           // fileName = "name of request approved .html";
            // mail send for Request approved participant

        } else if (status.equals("Invalid")) {
            change_status = "Registration Invalid";
            //fileName = "name of request approved .html";
            // mail send for Registration Invalid participant
        } else if (status.equals("Confirmed")) {
            change_status = "Confirmed";
           // fileName = "name of request approved .html";
            // mail send for confrimed participant
        } else if (status.equals("Canceled")) {
          //  fileName = "name of request approved .html";
            change_status = "Cancelled";
            // mail send for Canceled participant
        }
        /*if (!fileName.equals(null)) {
            try {
                String contextPath = ServletActionContext.getServletContext().getRealPath("");
                String filePath = contextPath + "/" + "mail-template";
                String emailMessage = HtmlUtility.read(filePath, fileName);
                // set the content that should be change in mail
                emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst("");
                EmailUtil mail = new EmailUtil();
                mail.sendEmail("senderemail", email, "", "", "Dear Participant : Your Permission Letter Updated Successfully", emailMessage);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }*/

        System.out.println("status for sending mail is " + change_status);
    }
    data = email + "*" + change_status;
    Gson gson = new Gson();
    gson.toJson(data);
    out.print(gson.toJson(data));

%>