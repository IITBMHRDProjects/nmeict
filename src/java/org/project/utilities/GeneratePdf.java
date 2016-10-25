/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.html.simpleparser.HTMLWorker;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.TabStop;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfImportedPage;
import com.itextpdf.text.pdf.PdfReader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.regex.Pattern;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.xhtmlrenderer.pdf.ITextRenderer;
import com.lowagie.text.DocumentException;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import org.project.process.UtilityProcess;

import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Abinaya
 */
public class GeneratePdf {

    private static String workshopid;
    private static ArrayList<WorkshopContent> workshopContent;
    private static String rcid;
    private static ArrayList<Person> participantdetails;

    /**
     * @return the workshopid
     */
    public static String getWorkshopid() {
        return workshopid;
    }

    /**
     * @param aWorkshopid the workshopid to set
     */
    public static void setWorkshopid(String aWorkshopid) {
        workshopid = aWorkshopid;
    }

    /**
     * @return the workshopContent
     */
    public static ArrayList<WorkshopContent> getWorkshopContent() {
        return workshopContent;
    }

    /**
     * @param aWorkshopContent the workshopContent to set
     */
    public static void setWorkshopContent(ArrayList<WorkshopContent> aWorkshopContent) {
        workshopContent = aWorkshopContent;
    }

    /**
     * @return the rcid
     */
    public static String getRcid() {
        return rcid;
    }

    /**
     * @param aRcid the rcid to set
     */
    public static void setRcid(String aRcid) {
        rcid = aRcid;
    }

    /**
     * @return the participantdetails
     */
    public static ArrayList<Person> getParticipantdetails() {
        return participantdetails;
    }

    /**
     * @param aParticipantdetails the participantdetails to set
     */
    public static void setParticipantdetails(ArrayList<Person> aParticipantdetails) {
        participantdetails = aParticipantdetails;
    }

    /**
     * Generate Dispatch PDF slips.
     */
    public int generatePdf(String context, WorkshopContent content, ArrayList<Person> participantDetails, String rcid) {
        try {
            // read from html file
            String fileName = "dispatch_slip.html";
            String contextPath = context;
            String filePath = contextPath + "/" + "mail-template";
            String dispatchMessage = HtmlUtility.read(filePath, fileName);
            // generate dispatch if rc is integer
            if (!rcid.equals("all")) {
                dispatchMessage = Pattern.compile("#rcid#").matcher(dispatchMessage).replaceFirst(rcid);
                dispatchMessage = Pattern.compile("#WorkshopName#").matcher(dispatchMessage).replaceFirst(content.getWorkshopname());
                Date today = new Date();
                dispatchMessage = Pattern.compile("#date#").matcher(dispatchMessage).replaceFirst(today.toString());

                for (int i = 0; i < participantDetails.size(); i++) {
                    if (participantDetails.get(i).getRemoteCenter().getRemoteCenterId() == Integer.parseInt(rcid)) {
                        dispatchMessage = Pattern.compile("#rcname#").matcher(dispatchMessage).replaceFirst(participantDetails.get(i).getRemoteCenter().getRemoteCenterName() + ", " + participantDetails.get(i).getRemoteCenter().getRc_city());
                    }
                }
                // add list of Completed Participants
                String listOfParticipants = "";
                int j = 0;
                for (int i = 0; i < participantDetails.size(); i++) {
                    if (participantDetails.get(i).getRemoteCenter().getRemoteCenterId() == Integer.parseInt(rcid)) {
                        j++;
                        listOfParticipants = listOfParticipants + " <li>" + j + ") " + participantDetails.get(i).getFirstName() + " " + participantDetails.get(i).getLastName() + "</li>";
                    }
                }
                dispatchMessage = Pattern.compile("#list#").matcher(dispatchMessage).replaceFirst(listOfParticipants);

                // new file in the DispatchSlips Folder
                OutputStream file = new FileOutputStream(new File(context + "/DispatchSlips/dispatchSlip_" + content.getWorkshopid() + "_" + rcid + ".pdf"));
                // write into the file function
                writeIntoPdf(file, dispatchMessage);

            }
        } catch (Exception e) {

            e.printStackTrace();
        }
        return 1;
    }

    public void writeIntoPdf(OutputStream file, String message) throws Exception {

        Document document = new Document();
        PdfWriter.getInstance(document, file);

        document.open();
        //convert html to string message
        HTMLWorker htmlWorker = new HTMLWorker(document);
        htmlWorker.parse(new StringReader(message));
        document.close();
        file.close();
    }

    public static void main(String args[]) throws Exception {

        UtilityProcess process = new UtilityProcess();
        //fetching the arraylist of workshopContent           
        setWorkshopContent(process.listWorkshopContent("5000020"));
        //fetching the arraylist of participant details         
        setParticipantdetails(process.listParticipants_CertificatePurpose("5000020", "all", "Completed"));
//        setParticipantdetails(process.listParticipants("5000020", "1002", "Completed"));
        //fetching arraylist of the remotecenters registered for the particular workshop

        GeneratePdf xyz = new GeneratePdf();
        String context = "/path/web";
        xyz.generateCertificate(context, workshopContent.get(0), participantdetails, "all");
//        xyz.generateCertificate(context, workshopContent.get(0), participantdetails, "1002");

    }

    public int generateCertificate(String context, WorkshopContent content, ArrayList<Person> participantDetails, String rcid) throws DocumentException, FileNotFoundException, IOException, com.itextpdf.text.DocumentException {
        // generate the certificate for the number of participants.
        //for creating folder for saving pdf for zip  
        String newfilepath = context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid;
        File files = new File(context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid);
        // if (!files.exists()) {
        if (files.mkdirs()) {
            newfilepath = context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid;
        } else {
            System.out.println("Failed to create directories!");
        }
        //  }
//        for (int i = 0; i < participantDetails.size(); i++) {
        for (int i = 0; i < participantDetails.size(); i++) {
            // read the html and change the RC coordinator Name and RC Logo
            StringBuffer HTMLContent = new StringBuffer("");
            BufferedReader br = null;
            try {
                String sCurrentLine;
                br = new BufferedReader(new FileReader(context + "/certificate_templates/certificate/certificate_" + content.getWorkshopid() + ".xhtml"));
                while ((sCurrentLine = br.readLine()) != null) {
                    //System.out.println(sCurrentLine);
                    HTMLContent.append(sCurrentLine);
                }

                String str = HTMLContent.toString();

                str = Pattern.compile("#Name#").matcher(str).replaceFirst(participantDetails.get(i).getFirstName() + " " + participantDetails.get(i).getLastName());

                if (content.getWithout_RC() == 0) {
                    str = Pattern.compile("#RCCoordinatorName#").matcher(str).replaceFirst(participantDetails.get(i).getRemoteCenter().getRc_coordinator_email());
                    str = Pattern.compile("#RemoteCenterName#").matcher(str).replaceFirst((participantDetails.get(i).getRemoteCenter().getRemoteCenterName()).replace("&", "&amp;"));
                    str = Pattern.compile("#city#").matcher(str).replaceAll(participantDetails.get(i).getRemoteCenter().getRc_city());
                    str = Pattern.compile("#rcid#").matcher(str).replaceAll(Integer.toString(participantDetails.get(i).getRemoteCenter().getRemoteCenterId()));
                }
                HTMLContent = new StringBuffer(str);

//                System.out.println(HTMLContent);
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (br != null) {
                        br.close();
                    }
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }

            // write into the pdf file 
            String outputFile = newfilepath + "/certificate_" + rcid + "_" + participantDetails.get(i).getRegistrationDetails().getParticipantid() + ".pdf";
            //  String outputFile = context + "/certificate_templates/certificates/certificate_" + participantDetails.get(i).getRegistrationDetails().getParticipantid() + ".pdf";
            OutputStream os = new FileOutputStream(outputFile);

            ITextRenderer renderer = new ITextRenderer();
            renderer.setDocumentFromString(HTMLContent.toString());
            renderer.layout();
            renderer.createPDF(os);
            // close the output stream
            os.close();

        }
        File root = new File(context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid);
        Zipper zip = new Zipper(context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid);
        String zipFile = context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid + ".zip";
        zip.generateFileList(root);
        int res = zip.zip(zipFile);
//        System.out.println(context + content.getWorkshopid() + participantDetails.size() + rcid);
        generateCertificateRC(context, content, participantDetails, rcid);

        // save the dispatch slip in database.
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        int updated_by = person.getLoginId();

        UtilityProcess process = new UtilityProcess();

        process.insert_certificate_audit(content.getWorkshopid(), Integer.parseInt(rcid), participantDetails, updated_by);

        return 1;
    }

    public int generateCertificateRC(String context, WorkshopContent content, ArrayList<Person> participantDetails, String rcid) throws DocumentException, FileNotFoundException, IOException, com.itextpdf.text.DocumentException {
        // generate the certificate for the number of participants.
        List<InputStream> list = new ArrayList<InputStream>();
        try {
            // Add Source pdfs
            if (content.getWithout_RC() == 0) {
                for (int i = 0; i < participantDetails.size(); i++) {
                    if (participantDetails.get(i).getRemoteCenter().getRemoteCenterId() == Integer.parseInt(rcid)) {
                        list.add(new FileInputStream(new File(context + "/certificate_templates/certificates/" + content.getWorkshopid() + "_" + rcid + "/certificate_" + rcid + "_" + participantDetails.get(i).getRegistrationDetails().getParticipantid() + ".pdf")));
                    }
                }
            } else {
                for (int i = 0; i < participantDetails.size(); i++) {
                    if (participantDetails.get(i).getInstitute().getInstituteId() == Integer.parseInt(rcid)) {
                        list.add(new FileInputStream(new File(context + "/certificate_templates/certificates/" + content.getWorkshopid() + "_" + rcid + "/certificate_" + rcid + "_" + participantDetails.get(i).getRegistrationDetails().getParticipantid() + ".pdf")));
                    }
                }
            }

            // Resulting pdf
            OutputStream out = new FileOutputStream(new File(context + "/certificate_templates/certificates/certificate_" + content.getWorkshopid() + "_" + rcid + ".pdf"));

            doMerge(list, out);

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return 1;
    }

    public static void doMerge(List<InputStream> list, OutputStream outputStream)
            throws DocumentException, IOException, com.itextpdf.text.DocumentException {
        Document document = new Document(PageSize.A4.rotate());
//        Rectangle newRec = new Rectangle(842, 595);
//        Document document= new Document(PageSize.LETTER.rotate());
        PdfWriter writer = PdfWriter.getInstance(document, outputStream);
        document.open();
        PdfContentByte cb = writer.getDirectContent();

        for (InputStream in : list) {
            PdfReader reader = new PdfReader(in);
            for (int i = 1; i <= reader.getNumberOfPages(); i++) {
                document.newPage();
                //import the page from source pdf
                PdfImportedPage page = writer.getImportedPage(reader, i);
                //add the page to the destination pdf
                cb.addTemplate(page, 0, 0);
            }
        }

        outputStream.flush();
        document.close();
        outputStream.close();
    }

    public int generateCertificateForAllRC(String context, WorkshopContent content, ArrayList<Person> participantDetails, String rcid) throws DocumentException, FileNotFoundException, IOException, com.itextpdf.text.DocumentException {
        // generate the certificate for the number of participants.
        //for creating folder for saving pdf for zip  
        String newfilepath = context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid;
        File files = new File(context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid);
        // if (!files.exists()) {
        if (files.mkdirs()) {
            newfilepath = context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid;
        } else {
            System.out.println("Failed to create directories!");
        }

        int countRes = 0;
        //  }
//        for (int i = 0; i < participantDetails.size(); i++) {
        for (int i = 0; i < participantDetails.size(); i++) {
            // check if already certificate exist
            File checkFile = new File(newfilepath + "/certificate_" + rcid + "_" + participantDetails.get(i).getRegistrationDetails().getParticipantid() + ".pdf");
            if (checkFile.exists() && !checkFile.isDirectory()) {
                // System.out.println("already exist do nothing "+participantDetails.get(i).getRegistrationDetails().getParticipantid());
            } else {

                // read the html and change the RC coordinator Name and RC Logo
                StringBuffer HTMLContent = new StringBuffer("");
                BufferedReader br = null;
                try {
                    String sCurrentLine;
                    br = new BufferedReader(new FileReader(context + "/certificate_templates/certificate/certificate_" + content.getWorkshopid() + ".xhtml"));
                    while ((sCurrentLine = br.readLine()) != null) {
                        //System.out.println(sCurrentLine);
                        HTMLContent.append(sCurrentLine);
                    }

                    String str = HTMLContent.toString();

                    str = Pattern.compile("#Name#").matcher(str).replaceFirst(participantDetails.get(i).getFirstName() + " " + participantDetails.get(i).getLastName());

                    if (content.getWithout_RC() == 0) {
                        str = Pattern.compile("#RCCoordinatorName#").matcher(str).replaceFirst(participantDetails.get(i).getRemoteCenter().getRc_coordinator_email());
                        str = Pattern.compile("#RemoteCenterName#").matcher(str).replaceFirst((participantDetails.get(i).getRemoteCenter().getRemoteCenterName()).replace("&", "&amp;"));
                        str = Pattern.compile("#city#").matcher(str).replaceAll(participantDetails.get(i).getRemoteCenter().getRc_city());
                        str = Pattern.compile("#rcid#").matcher(str).replaceAll(Integer.toString(participantDetails.get(i).getRemoteCenter().getRemoteCenterId()));
                    }
                    HTMLContent = new StringBuffer(str);

//                System.out.println(HTMLContent);
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (br != null) {
                            br.close();
                        }
                    } catch (IOException ex) {
                        ex.printStackTrace();
                    }
                }

                // write into the pdf file 
                String outputFile = newfilepath + "/certificate_" + rcid + "_" + participantDetails.get(i).getRegistrationDetails().getParticipantid() + ".pdf";
                //  String outputFile = context + "/certificate_templates/certificates/certificate_" + participantDetails.get(i).getRegistrationDetails().getParticipantid() + ".pdf";
                OutputStream os = new FileOutputStream(outputFile);

                try {
                    ITextRenderer renderer = new ITextRenderer();
                    renderer.setDocumentFromString(HTMLContent.toString());
                    renderer.layout();
                    renderer.createPDF(os);
                } catch (Exception e) {
                    System.out.println(e);
                }

                // close the output stream
                os.close();
                countRes = 1;
            }
        }
        File root = new File(context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid);
        Zipper zip = new Zipper(context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid);
        String zipFile = context + File.separator + "certificate_templates" + File.separator + "certificates" + File.separator + content.getWorkshopid() + "_" + rcid + ".zip";
        zip.generateFileList(root);
        int res = zip.zip(zipFile);
//        System.out.println(context + content.getWorkshopid() + participantDetails.size() + rcid);
        generateCertificateRC(context, content, participantDetails, rcid);

        // save the dispatch slip in database.
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        int updated_by = person.getLoginId();

        UtilityProcess process = new UtilityProcess();

        process.insert_certificate_audit(content.getWorkshopid(), Integer.parseInt(rcid), participantDetails, updated_by);

        return countRes;
    }

    /**
     * Generate Dispatch PDF slips.
     */
    public int generatePdfStateWise(String context, WorkshopContent content, ArrayList<Person> participantDetails, String institute_id) {
        try {
            // read from html file
            String fileName = "dispatch_slip_stateWise.html";
            String contextPath = context;
            String filePath = contextPath + "/" + "mail-template";
            String dispatchMessage = HtmlUtility.read(filePath, fileName);
            // generate dispatch if rc is integer
            if (!institute_id.equals("all")) {
//                dispatchMessage = Pattern.compile("#rcid#").matcher(dispatchMessage).replaceFirst(rcid);
                dispatchMessage = Pattern.compile("#WorkshopName#").matcher(dispatchMessage).replaceFirst(content.getWorkshopname());
                Date today = new Date();
                dispatchMessage = Pattern.compile("#date#").matcher(dispatchMessage).replaceFirst(today.toString());

                for (int i = 0; i < participantDetails.size(); i++) {
                    if (participantDetails.get(i).getInstitute().getInstituteId() == Integer.parseInt(institute_id)) {
                        dispatchMessage = Pattern.compile("#state#").matcher(dispatchMessage).replaceFirst(participantDetails.get(i).getInstitute().getInstituteName());
                    }
                }
                // add list of Completed Participants
                String listOfParticipants = "";
                int j = 0;
                for (int i = 0; i < participantDetails.size(); i++) {
                    if (participantDetails.get(i).getInstitute().getInstituteId() == Integer.parseInt(institute_id)) {
                        j++;
                        listOfParticipants = listOfParticipants + " <li>" + j + ") " + participantDetails.get(i).getFirstName() + " " + participantDetails.get(i).getLastName() + "</li>";
                    }
                }
                dispatchMessage = Pattern.compile("#list#").matcher(dispatchMessage).replaceFirst(listOfParticipants);

                // new file in the DispatchSlips Folder
                OutputStream file = new FileOutputStream(new File(context + "/DispatchSlips/dispatchSlip_" + content.getWorkshopid() + "_" + institute_id + ".pdf"));
                // write into the file function
                writeIntoPdf(file, dispatchMessage);

            }
        } catch (Exception e) {

            e.printStackTrace();
        }
        return 1;
    }

}
