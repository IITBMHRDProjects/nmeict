/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import org.project.bean.AttendanceSchedule;
import org.project.bean.RemoteCenter;
import org.project.bean.WorkshopContent;
import org.project.bean.Person;
import org.project.bean.AttendanceSheet;
import com.itextpdf.text.Document;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.html.simpleparser.HTMLWorker;
import com.itextpdf.text.pdf.FdfReader;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.RandomAccessFileOrArray;
import java.awt.Point;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.StringReader;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.process.UtilityProcess;

/**
 *
 * @author Abinaya
 */
public class CreateAttendanceSheetWSC {

    private ArrayList<WorkshopContent> wc;
    private RemoteCenter rc;
    private ArrayList<AttendanceSchedule> schedule1;

    public static void main(String args[]) throws IOException, Exception {
        CreateAttendanceSheetWSC obj = new CreateAttendanceSheetWSC();
        obj.callfn("2015-07-22", "1008", "5000020", "/path/build/web/");

    }

    public int callfn(String date, String rcid, String workshopid, String path) throws IOException, Exception {
        String outputFile = path + "pdfs/attendanceSheetWSC/attendance_" + date + "_" + workshopid + "_" + rcid + ".pdf";
        OutputStream os = new FileOutputStream(outputFile);
        StringBuffer content = new StringBuffer("");
        BufferedReader br = null;
        try {

            // title of the page
            String title = "<p><span align='center'><b>Attendance Sheet for Date : " + date + "</b></span></p>";
            content.append(title);
            content.append("\n");
            UtilityProcess process = new UtilityProcess();
            // workshop details 
            wc = process.listWorkshopContent(workshopid);
            String workshopname = "<p align='center'><b>" + wc.get(0).getWorkshopname() + "</b></p>";
            content.append(workshopname);
            content.append("\n");
            String date_workshop = "<p align='center'>" + wc.get(0).getStartdate() + " to " + wc.get(0).getEnddate() + "</p>";
            content.append(date_workshop);
            content.append("\n");
            content.append("<p align='center'>Under the National Mission on Education through ICT, MHRD, New Delhi</p>");
            content.append("\n");
            // rc details
            setRc(process.rc_details(rcid));
            String rcname = "<p align='center'><b>" + rcid + " - " + getRc().getRemoteCenterName() + ", " + getRc().getCity1() + "</b></p>";
            content.append(rcname);
            content.append("\n");
            content.append("<br/>");

            String date_1 = "all";
            // get the schedule, sessions and participants
            setSchedule1(process.getProgramSchedule2(workshopid, rcid, date_1));
            for (int j = 0; j <= schedule1.size(); j++) {
                if (schedule1.get(j).getDateOfSession().equals(date)) {
                    content.append("<table border='1' width='100%'><thead>");

                    content.append("<tr>"
                            + "<td colspan='9' style='text-align: center;'><b>Participant</b></td>");
                    String no_of_sessions = schedule1.get(j).getNumberOfSessions();
                    content.append("<td style='text-align: center;' colspan='" + (Integer.parseInt(no_of_sessions) * 3) + "'><b>Signature</b></td> "
                            + "</tr>"
                            + "<tr>"
                            + "<td align='center' colspan='1' >S No</td>"
                            + "<td align='center' colspan='3'>Participant ID</td>"
                            + "<td align='center' colspan='5'>Name</td>");

                    for (int i = 1; i <= Integer.parseInt(no_of_sessions); i++) {
                        content.append("<td style='text-align: center;' colspan='3'> Session " + i + "</td>");
                    }

                    content.append("</tr></thead>");       // end of header     

                    // insert body of table
                    content.append("<tbody>");
                    ArrayList<AttendanceSheet> as = schedule1.get(j).getAs();
                    for (int k = 0; k < as.size(); k++) {
                        content.append("<tr>");
                        content.append("<td colspan='1'>" + (k + 1) + "</td>");
                        content.append("<td colspan='3' align='center'>" + as.get(k).getParticipantid() + "</td>");
                        content.append("<td colspan='5' style='text-wrap:pre-wrap;'>" + as.get(k).getParticipantDetail().getFirstName() + " " + as.get(k).getParticipantDetail().getLastName() + "</td>");
                        //content.append("<td>"+as.get(k).getParticipantDetail().getEmail() +"</td>");
                        for (int i = 1; i <= Integer.parseInt(no_of_sessions); i++) {
                            content.append("<td colspan='3' style='text-align: center;color:white;'>Signature</td>");
                        }
                        content.append("</tr>");
                    }
                    content.append("</tbody>");
                    content.append("</table>");
                }
            }
        } catch (Exception e) {
        } finally {
        }
        writeIntoPdf(os, content.toString(),date,workshopid,rcid);
        return 1;
    }

    public void writeIntoPdf(OutputStream file, String message,String date,String workshopid,String rcid) throws Exception {

        Document document = new Document();
       // PdfWriter.getInstance(document, file);
        PdfWriter writer = PdfWriter.getInstance(document, file);
        Rectangle rect = new Rectangle(30, 30, 550, 800);
        writer.setBoxSize("art", rect);
        HeaderFooterPageEvent1 event = new HeaderFooterPageEvent1();
        RandomKey rkey=new RandomKey();
        event.setRandomkey(rkey.generateRandomString());
        event.setHeading1(date);
        try{
           UtilityProcess process = new UtilityProcess();
           HttpSession session = ServletActionContext.getRequest().getSession();
           Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
           int loginid=0;
           if (person != null) {
             loginid=person.getLoginId();
             process.insertPDFGenerateCode(workshopid,rcid,event.getRandomkey(),date,loginid);
           }
         }catch(Exception e){System.out.println("error in storing pdf code");}
        writer.setPageEvent(event);
        document.open();
        //convert html to string message
        HTMLWorker htmlWorker = new HTMLWorker(document);
        htmlWorker.parse(new StringReader(message));
        document.close();
        file.close();
    }

    /**
     * @return the wc
     */
    public ArrayList<WorkshopContent> getWc() {
        return wc;
    }

    /**
     * @param wc the wc to set
     */
    public void setWc(ArrayList<WorkshopContent> wc) {
        this.wc = wc;
    }

    /**
     * @return the rc
     */
    public RemoteCenter getRc() {
        return rc;
    }

    /**
     * @param rc the rc to set
     */
    public void setRc(RemoteCenter rc) {
        this.rc = rc;
    }

    /**
     * @return the schedule1
     */
    public ArrayList<AttendanceSchedule> getSchedule1() {
        return schedule1;
    }

    /**
     * @param schedule1 the schedule1 to set
     */
    public void setSchedule1(ArrayList<AttendanceSchedule> schedule1) {
        this.schedule1 = schedule1;
    }
}
