<%-- 
    Document   : DAOGenerateCertificates
    Created on : 22 Sep, 2015, 3:03:33 PM
    Author     : Abinaya
--%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page import="org.project.bean.Person"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.bean.WorkshopContent"%>
<%@page import="org.project.utilities.GeneratePdf"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="com.google.gson.Gson"%>
<%
    UtilityProcess process = new UtilityProcess();
    String workshopid = request.getParameter("workshopid");
    String rcid_enc = request.getParameter("rcid");
    SimpleStringCipher cipher = new SimpleStringCipher();
    String rcid = cipher.decrypt(rcid_enc);
    String context = request.getParameter("context");

    int result = 0;
    ArrayList<WorkshopContent> workshopContent = process.listWorkshopContent(workshopid);
    ArrayList<Person> participantdetails = new ArrayList<Person>();
    if (workshopContent.get(0).getWithout_RC() == 0) {
        participantdetails = process.listParticipants_CertificatePurpose(workshopid, rcid, "Completed");
    } else {
        participantdetails = process.listParticipantsForCertificateOnlyStateWise(workshopid, rcid, "Completed");
    }

    GeneratePdf xyz = new GeneratePdf();
    result = xyz.generateCertificate(context, workshopContent.get(0), participantdetails, rcid);
    Gson gson = new Gson();
    gson.toJson(result);
    out.print(gson.toJson(result));
%>