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
import java.util.ArrayList;
import java.util.regex.Pattern;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;

/**
 *
 * @author Abinaya
 */
public class SendMailToRcc extends ActionSupport {

    private Connection con;
    private PreparedStatement pstmt, pstmt1;
    private ResultSet res, res1;
    private Statement stmt, stmt1;
    String fileName = "";
    String subject = "";
    String type = "";

    /**
     * @param workshopid
     * @param context
     * @return if mail was successfully sent
     *
     */
    public int sendMail(String workshopid, String context) throws Exception {
        int success = 0;
        int userid;
        String workshopName = "", enc_workshopid = "", email = "", rcid = "";
        UtilityProcess utilproc = new UtilityProcess();
        ArrayList<WorkshopContent> content = new ArrayList<WorkshopContent>();;
        ArrayList<Person> person = new ArrayList<Person>();
        try {
            content = new ArrayList<WorkshopContent>();
            content = utilproc.listWorkshopContent(workshopid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        fileName = "remotecenter_capacity.html";
        for (int i = 0; i < content.size(); i++) {
            workshopName = content.get(i).getWorkshopname();
            enc_workshopid = content.get(i).getWorkshopid_encrypted();
            subject = "To fetch Capacity Information of RC for" + content.get(i).getWorkshopname();
        }
        try {
            person = new ArrayList<Person>();
            person = getRCCList(workshopid);
            for (int j = 0; j < person.size(); j++) {
                email = person.get(j).getEmail();
                rcid = person.get(j).getRemoteCenter().getEnc_RC();
                try {
                    String filePath = context + "/" + "mail-template";
                    String emailMessage = HtmlUtility.read(filePath, fileName);
                    emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst("Remote Center Coordinator");
                    emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceAll(email);
                    emailMessage = Pattern.compile("#rcid#").matcher(emailMessage).replaceAll(rcid);
                    emailMessage = Pattern.compile("#workshopid#").matcher(emailMessage).replaceAll(enc_workshopid);
                    emailMessage = Pattern.compile("#workshopname#").matcher(emailMessage).replaceAll(workshopName);
                    EmailUtil mail = new EmailUtil();
//                    commented for not sending mail to coordinators while testing from test server.
                    mail.sendEmail("senderemail", email, "senderemail", "", subject, emailMessage);
//                    mail.sendEmail("senderemail", "senderemail", "senderemail", "", subject, emailMessage);
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

    /**
     * @param workshopid
     * @return array list of remote center coordinators
     *
     */
    public ArrayList<Person> getRCCList(String workshopid) throws Exception {
        ArrayList<Person> coordinatorList = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("SELECT respective_coordinatorid from workshops where workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                Person coordinators = null;
                while (res.next()) {
                    String coordinator_workshopid = res.getString("respective_coordinatorid");
                    if (!coordinator_workshopid.equals("0") && !coordinator_workshopid.equals("")) {
//                        pstmt1 = con.prepareStatement("SELECT  r.remotecenterid , rcd.email FROM accomodation a, remotecenter r,  participant p ,  remotecenterdetails rcd  WHERE a.instituteid = r.remotecenterid and  p.participantid=a.participantid and a.workshopid =? and p.status='Confirmed' and rcd.rcid=a.instituteid and rcd.rcid NOT IN (select distinct(rcid)  from remotecentercapacity where workshopid=?) order by r.remotecenterid");
                        pstmt1 = con.prepareStatement("SELECT  r.remotecenterid , IFNULL(r.email,'') as email FROM accomodation a, remotecenter r,  participant p  WHERE a.instituteid = r.remotecenterid and  p.participantid=a.participantid and a.workshopid =? and (p.status='Confirmed' or p.status='Completed') and r.remotecenterid NOT IN (select distinct(rcid)  from remotecentercapacity where workshopid=?) order by r.remotecenterid");
                        pstmt1.setString(1, coordinator_workshopid);
                        pstmt1.setString(2, workshopid);
                        res1 = pstmt1.executeQuery();
                        while (res1.next()) {
                            coordinators = new Person();
                            RemoteCenter rc = new RemoteCenter();
                            rc.setRemoteCenterId(res1.getInt("remotecenterid"));
                            SimpleStringCipher cipher = new SimpleStringCipher();
                            String enc_rc = cipher.encrypt(res1.getString("remotecenterid"));
                            rc.setEnc_RC(enc_rc);
                            coordinators.setRemoteCenter(rc);
                            coordinators.setEmail(res1.getString("email"));
                            coordinatorList.add(coordinators);
                        }
                    } else {
                        //no related coordinator workshop id found. So fetch details from workshop_coordinator

//                        pstmt1 = con.prepareStatement("SELECT rcd.rcid, rcd.email from workshop_coordinator wc, remotecenterdetails rcd where  rcd.rcid=wc.rcid  and  wc.workshopid=? and rcd.rcid NOT IN (select distinct(rcid)  from remotecentercapacity where workshopid=?) order by wc.rcid");
                        pstmt1 = con.prepareStatement("SELECT r.remotecenterid as rcid, r.email from workshop_coordinator wc, remotecenter r where  r.remotecenterid=wc.rcid  and  wc.workshopid=? and r.remotecenterid NOT IN (select distinct(rcid)  from remotecentercapacity where workshopid=?) order by wc.rcid");
                        pstmt1.setString(1, workshopid);
                        pstmt1.setString(2, workshopid);
                        res1 = pstmt1.executeQuery();
                        while (res1.next()) {
                            coordinators = new Person();
                            RemoteCenter rc = new RemoteCenter();
                            rc.setRemoteCenterId(res1.getInt("rcid"));
                            SimpleStringCipher cipher = new SimpleStringCipher();
                            String enc_rc = cipher.encrypt(res1.getString("rcid"));
                            rc.setEnc_RC(enc_rc);
                            coordinators.setRemoteCenter(rc);
                            coordinators.setEmail(res1.getString("email"));
                            coordinatorList.add(coordinators);
                        }
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return coordinatorList;
    }
}
