/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import com.opensymphony.xwork2.ActionSupport;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Pattern;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Institute;
import org.project.process.UserProcess;
import org.project.bean.Person;
import org.project.bean.Qualification;
import org.project.bean.Stream;
import org.project.bean.WorkshopContent;

/**
 *
 * @author Abinaya
 */
public class StatusMails extends ActionSupport {

    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet res;
    private Statement stmt;
    String fileName = "";
    String subject = "";
    String type = "";
    String message = "";
    private final String email1 = "test email";

    public int sendMail(String participantid, String status, String email, String context) {
        int success = 0;
        int userid;
        Person per = getName(email);
        WorkshopContent content = getWorkshopDetails(participantid);
        if (content.getCategorycode() == 4) {
            type = "coordinator";
        }
        if (content.getCategorycode() == 5 || content.getCategorycode() == 8) {
            type = "main";
        }
        if (status.equals("Confirmed") || status.equals("Accepted")) {
        } else {

            if (status.equals("Cancelled")) {
                fileName = "cancelled.html";
                subject = "Registration Cancelled for " + content.getWorkshopname();
            }
            if (status.equals("Registration Invalid")) {
                fileName = "registration_invalid.html";
                subject = "Registration Invalid for " + content.getWorkshopname();
            }
            if (status.equals("Request Approved")) {
                // self sustained model - send mail for approval and payment details                    
                if (content.getCategorycode() == 7) {
                    fileName = "Verified_Mail_SelfSustained.html";
                    subject = "Registration Verified for " + content.getWorkshopname();
                    
                }else if(content.getCategorycode() == 8 && content.getPayment_at_rc() == 1){
                    fileName = "Verified_Mail_SelfSustained.html";
                    subject = "Registration Verified for " + content.getWorkshopname();
                }else {
                    fileName = "request_approved.html";
                    subject = "Registration Confirmed for " + content.getWorkshopname();
                }
            }

            try {

//                String contextPath = ServletActionContext.getServletContext().getRealPath("");
                String filePath = context + "/" + "mail-template";
                String emailMessage = HtmlUtility.read(filePath, fileName);
//                        String emailforlink = SimpleStringCipher.encrypt(email);

                emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(per.getFirstName()+" "+per.getLastName());
                emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceAll(email);
                emailMessage = Pattern.compile("#id#").matcher(emailMessage).replaceAll(participantid);
                emailMessage = Pattern.compile("#ide#").matcher(emailMessage).replaceAll(email);
                emailMessage = Pattern.compile("#type#").matcher(emailMessage).replaceAll(type);
                emailMessage = Pattern.compile("#participantid#").matcher(emailMessage).replaceAll(participantid);
                emailMessage = Pattern.compile("#workshopid#").matcher(emailMessage).replaceAll(Integer.toString(content.getWorkshopid()));
                emailMessage = Pattern.compile("#workshopname#").matcher(emailMessage).replaceAll(content.getWorkshopname());
                EmailUtil mail = new EmailUtil();
                if (status.equals("Registration Invalid")) {
                    mail.sendEmail("senderemail", email, "senderemail", "", subject, emailMessage);
                } else {
                    mail.sendEmail("senderemail", email, "", "", subject, emailMessage);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return success;
    }

    public int sendMailToInvalidPartcipant(String participantid, String status, String email, String context, String description) {
        int success = 0;
        int userid;
        Person per = getName(email);
        WorkshopContent content = getWorkshopDetails(participantid);
        if (content.getCategorycode() == 4) {
            type = "coordinator";
        }
        if (content.getCategorycode() == 5 || content.getCategorycode() == 8) {
            type = "main";
        }
        if (status.equals("Confirmed")) {
            // do nothing
        } else {
            if (status.equals("Registration Invalid")) {
                fileName = "registration_invalid.html";
                subject = "Registration Invalid for " + content.getWorkshopname();
                message = description;
            }

            try {

//                String contextPath = ServletActionContext.getServletContext().getRealPath("");
                String filePath = context + "/" + "mail-template";
                String emailMessage = HtmlUtility.read(filePath, fileName);
//                        String emailforlink = SimpleStringCipher.encrypt(email);
                String ency_workshopid = SimpleStringCipher.encrypt(Integer.toString(content.getWorkshopid()));
                emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(per.getFirstName() + " "+per.getLastName());
                emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceAll(email);
                emailMessage = Pattern.compile("#id#").matcher(emailMessage).replaceAll(participantid);
                emailMessage = Pattern.compile("#ide#").matcher(emailMessage).replaceAll(email);
                emailMessage = Pattern.compile("#type#").matcher(emailMessage).replaceAll(type);
                emailMessage = Pattern.compile("#participantid#").matcher(emailMessage).replaceAll(participantid);
                //  emailMessage = Pattern.compile("#workshopid#").matcher(emailMessage).replaceAll(Integer.toString(content.getWorkshopid()));
                emailMessage = Pattern.compile("#workshopid#").matcher(emailMessage).replaceAll(ency_workshopid);
                emailMessage = Pattern.compile("#workshopname#").matcher(emailMessage).replaceAll(content.getWorkshopname());
                emailMessage = Pattern.compile("#message#").matcher(emailMessage).replaceAll(message);
                String link = getText("contextLink") + "/updateRegistration.html?workshopid=" + ency_workshopid;
                emailMessage = Pattern.compile("#link#").matcher(emailMessage).replaceAll(link);

                EmailUtil mail = new EmailUtil();
                mail.sendEmail("senderemail", email, "senderemail", "", subject, emailMessage);
            } catch (Exception e) {
                e.printStackTrace();
            }
            // System.out.println("mail sentet to participant");
        }
        return success;
    }

    public int sendMailToRejectPartcipant(String participantid, String status, String email, String context, String description, String cc_email) {
        int success = 0;
        int userid;
        Person per = getName(email);
        WorkshopContent content = getWorkshopDetails(participantid);
        if (content.getCategorycode() == 4) {
            type = "coordinator";
        }
        if (content.getCategorycode() == 5 || content.getCategorycode() == 8) {
            type = "main";
        }
        if (status.equals("Confirmed")) {
            // do nothing
        } else {
            if (status.equals("Registration Invalid")) {
                fileName = "registration_reject.html";
                subject = "Registration Invalid for " + content.getWorkshopname();
                message = description;
            }

            try {

//                String contextPath = ServletActionContext.getServletContext().getRealPath("");
                String filePath = context + "/" + "mail-template";
                String emailMessage = HtmlUtility.read(filePath, fileName);
//                        String emailforlink = SimpleStringCipher.encrypt(email);
                String ency_workshopid = SimpleStringCipher.encrypt(Integer.toString(content.getWorkshopid()));
                emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(per.getFirstName()+" "+per.getLastName());
                emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceAll(email);
                emailMessage = Pattern.compile("#id#").matcher(emailMessage).replaceAll(participantid);
                emailMessage = Pattern.compile("#ide#").matcher(emailMessage).replaceAll(email);
                emailMessage = Pattern.compile("#type#").matcher(emailMessage).replaceAll(type);
                emailMessage = Pattern.compile("#participantid#").matcher(emailMessage).replaceAll(participantid);
                //  emailMessage = Pattern.compile("#workshopid#").matcher(emailMessage).replaceAll(Integer.toString(content.getWorkshopid()));
                emailMessage = Pattern.compile("#workshopid#").matcher(emailMessage).replaceAll(ency_workshopid);
                emailMessage = Pattern.compile("#workshopname#").matcher(emailMessage).replaceAll(content.getWorkshopname());
                emailMessage = Pattern.compile("#message#").matcher(emailMessage).replaceAll(message);
                String link = getText("contextLink") + "/updateRegistration.html?workshopid=" + ency_workshopid;
                emailMessage = Pattern.compile("#link#").matcher(emailMessage).replaceAll(link);
                //System.out.println(emailMessage);
                EmailUtil mail = new EmailUtil();
                mail.sendEmail("senderemail", email, "senderemail," + cc_email, "", subject, emailMessage);
            } catch (Exception e) {
                e.printStackTrace();
            }
            // System.out.println("mail sentet to participant");
        }
        return success;
    }

    public int sendMailToAcceptedSSM(String participantid, String status, String email, String context) {
        int success = 0;
        int userid;
        Person per = getName(email);
        WorkshopContent content = getWorkshopDetails(participantid);

        if (status.equals("Accepted")) {
            fileName = "request_approved.html";
            subject = "Registration Confirmed for " + content.getWorkshopname();
            try {
                String filePath = context + "/" + "mail-template";
                String emailMessage = HtmlUtility.read(filePath, fileName);
                emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(per.getFirstName() + " " + per.getLastName());
                emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceAll(email);
                emailMessage = Pattern.compile("#id#").matcher(emailMessage).replaceAll(participantid);
                emailMessage = Pattern.compile("#ide#").matcher(emailMessage).replaceAll(email);
                emailMessage = Pattern.compile("#type#").matcher(emailMessage).replaceAll(type);
                emailMessage = Pattern.compile("#participantid#").matcher(emailMessage).replaceAll(participantid);
                emailMessage = Pattern.compile("#workshopid#").matcher(emailMessage).replaceAll(Integer.toString(content.getWorkshopid()));
                emailMessage = Pattern.compile("#workshopname#").matcher(emailMessage).replaceAll(content.getWorkshopname());
                EmailUtil mail = new EmailUtil();
                mail.sendEmail("senderemail", email, "", "", subject, emailMessage);
                success++;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return success;
    }

    public Person getName(String email) {
        Person person = new Person();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select  IFNULL(p.firstname,'') as firstname, IFNULL(p.lastname,'') as lastname from person p, context c where c.idcontext=p.personid and c.email=?");
                //binding the userid and password to the query
                pstmt.setString(1, email);
                //executing the query
                res = pstmt.executeQuery();
                //checking whether any person exist with this email
                if (res.next()) { //if exist then set all the details in Person class object.
                    //creating the object of Person class.
                    person = new Person();
                    //setting the values into variable of Person class
                    person.setFirstName(res.getString("firstname"));
                    person.setLastName(res.getString("lastname"));

                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return person;
    }

    public WorkshopContent getWorkshopDetails(String participantid) {
        WorkshopContent content = new WorkshopContent();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select a.workshopid, w.workshopname, w.categorycode,ifnull(w.rc_payment_if_required,0) as rc_payment_if_required from accomodation a, workshops w where a.participantid=? and a.workshopid=w.workshopid");
                //binding the userid and password to the query
                pstmt.setString(1, participantid);
                //executing the query
                res = pstmt.executeQuery();
                //checking whether any person exist with this email
                if (res.next()) { //if exist then set all the details in Person class object.
                    //creating the object of Person class.
                    content = new WorkshopContent();
                    //setting the values into variable of Person class
                    content.setWorkshopid(res.getInt("workshopid"));
                    content.setWorkshopname(res.getString("workshopname"));
                    content.setCategorycode(res.getInt("categorycode"));
                    content.setPayment_at_rc(res.getInt("rc_payment_if_required"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return content;
    }
}
