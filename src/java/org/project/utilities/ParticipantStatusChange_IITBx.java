/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import com.opensymphony.xwork2.ActionSupport;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Participant;
import org.project.bean.Person;

/**
 *
 * @author Abinaya
 */
public class ParticipantStatusChange_IITBx extends ActionSupport {

    Connection con = null;
    PreparedStatement pstmt = null, pstmt1 = null;
    ResultSet res = null, res1 = null;

    public void participantInfo(String context, String workshopid, String type) throws IOException {
        if (con == null) {
            con = DBConnection.getDBConnection();
        }
        try {

            File file = new File(context + File.separator + "MoodleLinks" + File.separator + "moodlelink.txt");

            if (!file.exists()) {
                file.createNewFile();
            }

            pstmt = con.prepareStatement("update participant set status='Request Approved' where participantid IN (select participantid from accomodation where workshopid IN (?)) and status='Request Registered'");
            // String workshopids="32100021,32100019,32100020";
            pstmt.setString(1, workshopid);
            int rowsaffected = pstmt.executeUpdate();
            FileWriter fw = new FileWriter(file.getAbsoluteFile());
            BufferedWriter bw = new BufferedWriter(fw);
            pstmt1 = con.prepareStatement("select p.participantid, c.email from participant p, context c where p.status='Request Approved' and c.idcontext=p.contextid and p.participantid IN (select participantid from accomodation where workshopid=? )");
            pstmt1.setString(1, workshopid);            
            res1 = pstmt1.executeQuery();
            while (res1.next()) {
                String workshopType = type;
                int participantid = res1.getInt("participantid");
                String email = res1.getString("email");
                String content = "path/moodle/moodle-enrolment.php?id=" + participantid + "&ide=" + email + "&type=" + workshopType;
                bw.write(content);
                bw.newLine();
            }
            bw.close();
        } catch (SQLException sqle) {
        } finally {
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
    }

    public String execute() throws IOException, Exception {
        ParticipantStatusChange_IITBx obj = new ParticipantStatusChange_IITBx();
        String context = ServletActionContext.getServletContext().getRealPath("");
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        /**
         * cipher for decrypting the 'workshopid', 'rcid', status from the 'url'
         */
        SimpleStringCipher cipher = new SimpleStringCipher();
        /**
         * getting the parameters from 'url'
         */
        String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
        String workshopid = cipher.decrypt(workshopid_encrypted);
        String type = ServletActionContext.getRequest().getParameter("type");
        obj.participantInfo(context, workshopid, type);
        return SUCCESS;
    }
}
