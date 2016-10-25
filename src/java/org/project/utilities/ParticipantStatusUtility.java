/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author dipesh
 */
public class ParticipantStatusUtility {

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet res = null;

    public void updateFacultyStatusOfParticipant(String pid, String status, String isFaculty, String Email) {
        // pid = "";
        //  status = "";
        // isFaculty = "true";
        if (status.equals("Request Approved")) {
            // execute the function
        } else {
            //revert back;
        }
        try {
            int result = updateFacultyStatus(pid, isFaculty);
            //if (result > 0) {
               // sendEmailForCerticiateType(status, Email, isFaculty);
            //}
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String args[]) {
        // System.out.println("hello");
        //ParticipantStatusUtility obj=new ParticipantStatusUtility();
        //String splited=obj.getDetailsOfWorkshops("155688");
        //String[] split=splited.split("@");
    }

    public int updateFacultyStatus(String pid, String isEligibleForCertificate) {
        int result = 0;
        String certificateStatus = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                if (isEligibleForCertificate.equals("true")) {
                    certificateStatus = "yes";
                } else if (isEligibleForCertificate.equals("false")) {
                    certificateStatus = "no";
                }
                pstmt = con.prepareStatement("update participant set eligible_for_certificate=? where participantid=?");
                pstmt.setString(1, certificateStatus);
                pstmt.setInt(2, Integer.parseInt(pid));
                result = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }

    public void sendEmailForCerticiateType(String context, String Email, String isfaculty) {
        try {
            String fileName = "";
            if (isfaculty.equals("true")) {
                fileName = "certificate_faculty.html";
            } else {
                fileName = "certificate_type.html";
            }
            String contextPath = ServletActionContext.getServletContext().getRealPath("");
            String filePath = contextPath + "/" + "mail-template";
            String emailMessage = HtmlUtility.read(filePath, fileName);
            String subject = "Certificate Type Recieved";
            // emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(person.getFirstName());
            // emailMessage = Pattern.compile("#link1#").matcher(emailMessage).replaceAll(confirmation_link);
            EmailUtil mail = new EmailUtil();
            mail.sendEmail("senderemail", Email, "", "", subject, emailMessage);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendEmailForPaymentDetailsToParticipant(String context, String Email, String status, String name, String wname) {
        try {
            String fileName = "";
            if (status.equals("S")) {
                fileName = "payment_success.html";
            } else if (status.equals("F")) {
                fileName = "payment_failure.html";
            }
            String contextPath = ServletActionContext.getServletContext().getRealPath("");
            String filePath = contextPath + "/" + "mail-template";
            String emailMessage = HtmlUtility.read(filePath, fileName);
            String subject = "Payment Status for "+wname;
            if (status.equals("S")) {
                //subject="";
            } else if (status.equals("F")) {
                //subject="";
            }
            emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(name);
            emailMessage = Pattern.compile("#wname#").matcher(emailMessage).replaceAll(wname);
            EmailUtil mail = new EmailUtil();
            mail.sendEmail("senderemail", Email, "", "", subject, emailMessage);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getDetailsOfWorkshops(String userid) {
        String data = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select per.firstname,per.lastname,w.workshopname from workshops w,person per,participant p,accomodation a where per.personid=p.personid and p.participantid=a.participantid and a.workshopid=w.workshopid and p.participantid=?");
                pstmt.setInt(1, Integer.parseInt(userid));
                res = pstmt.executeQuery();
                while (res.next()) {
                    data = res.getString("firstname") + " " + res.getString("lastname") + "@" + res.getString("workshopname");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
            DBConnection.closeResultSet(res);
        }
        return data;
    }
}
