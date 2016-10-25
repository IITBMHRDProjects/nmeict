package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.DBConnection;
import org.project.utilities.EmailUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;

import java.util.Properties;
import java.util.Date;
import java.util.regex.Pattern;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;

import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpSession;

/**
 *
 * @author asl
 */
public class SendSurveyAction extends ActionSupport {

    private String workshopid;
    private Connection con;
    private PreparedStatement pstmt, pstmt1;
    private ResultSet res, res1;
    private Statement stmt, stmt1;
    String fileName = "";
    String subject = "";
    String type = "";

    @Override
    public String execute() throws Exception{
        HttpSession session = ServletActionContext.getRequest().getSession();
        String contextPath = ServletActionContext.getServletContext().getRealPath("");
        int mailsent = 0;
        try {
            mailsent = sendMail(workshopid, contextPath);
            if (mailsent > 0) {
                session.setAttribute("mailResult", "success");
            } else {
                session.setAttribute("mailResult", "error");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("in action class." + workshopid);
        return SUCCESS;
    }

    public int sendMail(String workshopid, String context) throws Exception {
        int success = 0;
        int userid;
        String workshopName = "", enc_workshopid = "", email = "", rcid = "";
        UtilityProcess utilproc = new UtilityProcess();
        ArrayList<WorkshopContent> content = new ArrayList<WorkshopContent>();;
        ArrayList<Person> person = new ArrayList<Person>();
        try {
            content = new ArrayList<WorkshopContent>();
        } catch (Exception e) {
            e.printStackTrace();
        }
        fileName = "survey_form.html";
        subject = "Link of Response form of Blended MOOCs from IIT Bombay";
        try {
            person = new ArrayList<Person>();
            person = getRCCList1();
            for (int j = 0; j < person.size(); j++) {
                email = person.get(j).getEmail();
                rcid = person.get(j).getRemoteCenter().getEnc_RC();
                SimpleStringCipher cipher = new SimpleStringCipher();
                try {
                    String filePath = context + "/" + "mail-template";
                    String emailMessage = HtmlUtility.read(filePath, fileName);
                    emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceAll(cipher.encrypt(email));
                    emailMessage = Pattern.compile("#rcid#").matcher(emailMessage).replaceAll(rcid);
                    
                    sendEmailWithAttachment("senderemail", email, "senderemail", "", subject, emailMessage, context);

                } catch (Exception e) {
                    e.printStackTrace();
                }
                success++;
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        return success;
    }

    public ArrayList<Person> getRCCList1() throws Exception {
        ArrayList<Person> coordinatorList = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select email,rcid from surveyemail");
                res = pstmt.executeQuery();
                Person coordinators = null;
                while (res.next()) {
                    coordinators = new Person();
                    RemoteCenter rc = new RemoteCenter();
                    //Institute institute=new Institute();
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String enc_rc = cipher.encrypt(res.getString("rcid"));
                    rc.setEnc_RC(enc_rc);
                    coordinators.setRemoteCenter(rc);
                    coordinators.setEmail(res.getString("email"));
                    coordinatorList.add(coordinators);

                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            // DBConnection.closeResultSet(res1);
            // DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return coordinatorList;
    }

    public void sendEmailWithAttachment(final String fromEmail, final String toEmail, final String ccEmail, final String bccEmail, final String subject, final String body, final String contextPath) {
        if (fromEmail != null && toEmail != null && subject != null && body != null) {
        }
        Thread mailer = new Thread() {
            private String cc = "";
            private String bcc = "";

            @Override
            public void run() {
                if (ccEmail != null) {
                    cc = ccEmail;
                }
                if (bccEmail != null) {
                    bcc = bccEmail;
                }
                try {

                    Properties props = System.getProperties();
                    // Setup mail server
                    props.put("mail.smtp.host", "smtphostemail"); //SMTP Host

                    Session session = Session.getInstance(props, null); //auth

                    // create a mime message
                    MimeMessage msg = new MimeMessage(session);

                    //add body of mail - text
                    MimeBodyPart msgbdypart = new MimeBodyPart();
                    String sHTMLBody = body;
                    msgbdypart.setContent(sHTMLBody, "text/html");

                    // create multipart for attachment
                    Multipart multipart = new MimeMultipart();
                    // add msg body to multipart
                    multipart.addBodyPart(msgbdypart);


                    String fileAttachment = contextPath + File.separator + "pdfname";
                    String fileAttachment2 = contextPath + File.separator + "pdfname";
                    String fileAttachment3 = contextPath + File.separator + "pdfname";


                    if (fileAttachment != null && !fileAttachment.equals("")) {
                        MimeBodyPart mbp2 = new MimeBodyPart();
                        FileDataSource fds = new FileDataSource(fileAttachment);
                        mbp2.setDataHandler(new DataHandler(fds));
                        mbp2.setFileName(fds.getName());
                        // add multipart data (file attachments)
                        multipart.addBodyPart(mbp2);
                    }

                    if (fileAttachment2 != null && !fileAttachment2.equals("")) {
                        MimeBodyPart mbp3 = new MimeBodyPart();
                        FileDataSource fds1 = new FileDataSource(fileAttachment2);
                        mbp3.setDataHandler(new DataHandler(fds1));
                        mbp3.setFileName(fds1.getName());
                        // add multipart data (file attachments)
                        multipart.addBodyPart(mbp3);
                    }

                    if (fileAttachment3 != null && !fileAttachment3.equals("")) {
                        MimeBodyPart mbp4 = new MimeBodyPart();
                        FileDataSource fds2 = new FileDataSource(fileAttachment3);
                        mbp4.setDataHandler(new DataHandler(fds2));
                        mbp4.setFileName(fds2.getName());
                        // add multipart data (file attachments)
                        multipart.addBodyPart(mbp4);
                    }
                    // set the message content
                    msg.setContent(multipart);

                    //set message headers
//                    msg.addHeader("Content-type", "text/html; charset=UTF-8");
//                    msg.addHeader("format", "flowed");
//                    msg.addHeader("Content-Transfer-Encoding", "8bit");
                    msg.setFrom(new InternetAddress(fromEmail));
                    msg.setReplyTo(InternetAddress.parse(fromEmail, false));
                    msg.setSubject(subject, "UTF-8");
                    // msg.setContent(body, "text/html");    
                    msg.setSentDate(new Date());
                    msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
                    msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc, false));
                    msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(bcc, false));
                    System.out.println("Sending Email TO : " + toEmail);
                    Transport.send(msg);
                    System.out.println("Mail Sent Successfully!!");
                } catch (Exception e) {
                    System.out.println("Error while sending mail -");
                    e.printStackTrace();
                }
            }
        };
        mailer.start();
    }

    /**
     * @return the workshopid
     */
    public String getWorkshopid() {
        return workshopid;
    }

    /**
     * @param workshopid the workshopid to set
     */
    public void setWorkshopid(String workshopid) {
        this.workshopid = workshopid;
    }
}
