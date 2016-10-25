<%-- 
    Document   : DAOInitiateRefund
    Created on : Sep 6, 2016, 3:42:26 PM
    Author     : abinaya
--%>


<%@page import="org.project.bean.Person"%>
<%@page import="org.project.process.UserProcess"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="org.project.utilities.EmailUtil"%>
<%@page import="org.project.utilities.HtmlUtility"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="org.project.bean.ParticipantReasons"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>

<%
    String participantid = request.getParameter("participantid").trim();
    String workshopid = request.getParameter("workshopid").trim();
    String reason = request.getParameter("reason").trim();
    String updatedBy = request.getParameter("updatedBy").trim();
    String email = request.getParameter("email").trim();
    String workshopName = request.getParameter("workshopName").trim();
    String refund_type = request.getParameter("refund_type").trim();

    int i = 0;
    // function to initiate refund and write reason
    UtilityProcess process = new UtilityProcess();
    ParticipantReasons reasons = new ParticipantReasons();
    reasons.setParticipantid(Integer.parseInt(participantid));
    reasons.setWorkshopid(Integer.parseInt(workshopid));
    if (refund_type.equals("initiate")) {
        reasons.setStatus("refund initiated");
    } else {
        reasons.setStatus("refunded");
    }
    reasons.setReason(reason);
    reasons.setUpdateby(Integer.parseInt(updatedBy));
    int action = 0; // to check if reason is already available in the database, else insert
    int check_alrdyEx = 0;

    check_alrdyEx = process.checkWorkshopIdInReasons(Integer.parseInt(workshopid), Integer.parseInt(participantid), reasons.getStatus());

    String fileName = "", subject = "";

    if (check_alrdyEx == 0) {
        action = 1;
    }
    if (refund_type.equals("initiate")) {
        i = process.initiateRefund(reasons, action, email);

        fileName = "refund_initiated_mail" + ".html";
        subject = "Refund initiated for " + workshopName;

    } else {
        i = process.refundByAccountsTeam(reasons, action, email);

        fileName = "refund_successful_mail" + ".html";
        subject = "Refund initiated for " + workshopName;
    }
    try {
        UserProcess uproc = new UserProcess();
        Person person = uproc.getPerson(email);

        String contextPath = ServletActionContext.getServletContext().getRealPath("");
        String filePath = contextPath + "/" + "mail-template";
        String emailMessage = HtmlUtility.read(filePath, fileName);
        emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(person.getFirstName() + " " + person.getLastName());
        emailMessage = Pattern.compile("#workshopName#").matcher(emailMessage).replaceFirst(workshopName);
        EmailUtil mail = new EmailUtil();
        // add cc to accounts team as well. Please check
        mail.sendEmail("senderemail", person.getEmail(), "senderemail", "", subject, emailMessage);

    } catch (Exception e) {
    }

    Gson gson = new Gson();
    gson.toJson(i);
    out.print(gson.toJson(i));

%>