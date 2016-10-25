<%-- 
    Document   : DAOChangeInvalidStatus
    Created on : 10 Dec, 2014, 3:55:28 PM
    Author     : asl
--%>

<%@page import="org.project.utilities.Utility"%>
<%@page import="org.project.bean.Person"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="org.project.bean.ParticipantReasons"%>
<%@page import="org.project.utilities.StatusMails"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="com.google.gson.Gson"%>
<%
    UtilityProcess process = new UtilityProcess();
    String i = request.getParameter("tem1");
    String participantid = request.getParameter("tem2");
    String email = request.getParameter("tem3");
    String context = request.getParameter("tem4");
    String status = null;
    status = request.getParameter("tem5");
    String code = request.getParameter("tem6");
    String message = "<ul>";
    String[] splited = code.split("\\$");
    for (int j = 0; j < splited.length; j++) {
        message = message + "<li>" + splited[j] + "</li>";
    }
    message = message + "</ul>";
    //System.out.println(message);
    String ifupdated = process.updateParticipantStatus(participantid, status);
    //new code for store reasons in table--june 2015
    ParticipantReasons p_reason = new ParticipantReasons();
    session = ServletActionContext.getRequest().getSession();
    Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
    if (person != null) {
        p_reason.setUpdateby(person.getLoginId());
    }
    int workshopid = 0, check_alrdyEx = 0, store_reasons = 0, action = 2;
    workshopid = process.getparticipantWorkshopId(Integer.parseInt(participantid));
    if (workshopid != 0) {
        check_alrdyEx = process.checkWorkshopIdInReasons(workshopid, Integer.parseInt(participantid), "Registration Invalid");
        p_reason.setParticipantid(Integer.parseInt(participantid));
        p_reason.setWorkshopid(workshopid);
        p_reason.setStatus(status);
        p_reason.setReason(code);
        if (check_alrdyEx == 0) {
            action = 1;
            store_reasons = process.storeParticipantReasons(action, p_reason);
        } else if (check_alrdyEx == 1) {
            action = 0;
            store_reasons = process.storeParticipantReasons(action, p_reason);
        }
    }
    //new code end.
    StatusMails send_mail = new StatusMails();
    int mailsent = send_mail.sendMailToInvalidPartcipant(participantid, status, email, context, message);
    ArrayList<String> data1 = new ArrayList<String>();
    data1.add(i);
    data1.add(ifupdated);
    Gson gson = new Gson();
    gson.toJson(data1);
    out.print(gson.toJson(data1));
%>
