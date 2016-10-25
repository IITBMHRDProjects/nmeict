<%-- 
    Document   : DAOGenerateCertificateForAll
    Created on : 10 Feb, 2016, 4:47:00 PM
    Author     : dipesh
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
//    ArrayList<Person> participantdetails = process.listParticipants_CertificatePurpose(workshopid, rcid, "Completed");
    
    ArrayList<Person> participantdetails = new ArrayList<Person>();
    if (workshopContent.get(0).getWithout_RC() == 0) {
        participantdetails = process.listParticipants_CertificatePurpose(workshopid, rcid, "Completed");
    } else {
        participantdetails = process.listParticipantsForCertificateOnlyStateWise(workshopid, rcid, "Completed");
    }
    
    GeneratePdf xyz = new GeneratePdf();
    if (participantdetails.size() > 0) {
        result = xyz.generateCertificateForAllRC(context, workshopContent.get(0), participantdetails, rcid);
    }
    Gson gson = new Gson();
    gson.toJson(result);
    out.print(gson.toJson(result));
%>

