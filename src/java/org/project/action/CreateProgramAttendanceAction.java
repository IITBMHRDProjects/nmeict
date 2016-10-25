/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.AttendanceSchedule;
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.DBConnection;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class CreateProgramAttendanceAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<AttendanceSchedule> schedule;
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet res;

    @Override
    public String execute() {

        try {
            /*
             * Getting user session object
             */
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
//            if (person == null) {
//                return Utility.LOGIN_FAILURE;
//            } else {
            UtilityProcess process = new UtilityProcess();
            /**
             * cipher for decrypting the workshopid from the url
             */
            SimpleStringCipher cipher = new SimpleStringCipher();
            /**
             * getting the parameter from url
             */
            String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
            String workshopid = cipher.decrypt(workshopid_encrypted);
            //set workshop content
            workshopContent = (process.listWorkshopContent(workshopid));

//            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    /**
     * Create the entry of program schedule in database
     *
     */
    public String createSchedule() {
        try {
            /*
             * Getting user session object
             */
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
//            if (person == null) {
//                return Utility.LOGIN_FAILURE;
//            } else {
            UtilityProcess process = new UtilityProcess();
            /**
             * cipher for decrypting the workshopid from the url
             */
            SimpleStringCipher cipher = new SimpleStringCipher();
            /**
             * getting the parameter from url
             */
            String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
            String workshopid = cipher.decrypt(workshopid_encrypted);
            //set workshop content
//            workshopContent = (process.listWorkshopContent(workshopid));
            //            }

            int result = createProgramSchedule(workshopid, schedule);
            if (result > 0) {
                return Utility.SUCCESS;
            } else {
                addActionError("Oops! Database insertion error.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;

    }

    /**
     *
     * @return
     */
    public int createProgramSchedule(String workshopid, ArrayList<AttendanceSchedule> schedule) throws ParseException {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {

                for (int i = 0; i < schedule.size(); i++) {

                    String date = schedule.get(i).getDateOfSession();
                    String no = schedule.get(i).getNumberOfSessions();
                    ArrayList comments = schedule.get(i).getSession_comm();
                    ArrayList time_slot = schedule.get(i).getSession_time();
                    ArrayList time_slot_to = schedule.get(i).getSession_time_to();
                    ArrayList isActive = schedule.get(i).getSession_radio();
                    //ArrayList date_till = schedule.get(i).getDate_till();
                    String date_till_1 = schedule.get(i).getDate_till_1();
                    DateFormat userDateFormat = new SimpleDateFormat("dd-mm-yyyy");
                    DateFormat dateFormatNeeded = new SimpleDateFormat("yyyy-mm-dd");
                    Date date_1 = userDateFormat.parse(date);
                    String date_2 = dateFormatNeeded.format(date_1);
                    int no_of_session = Integer.parseInt(no);

                    Date date3 = userDateFormat.parse("0000-00-00");
                    String date_till1 = date_till_1;
                    if (!date_till1.equals("") && !date_till1.equals(null)) {
                        date3 = userDateFormat.parse(date_till1);
                    }
                    String date4 = dateFormatNeeded.format(date3);

                    for (int iterator_for_session = 1; iterator_for_session <= no_of_session; iterator_for_session++) {
                        // date for update till 
//                        String date_till1 = date_till.get(iterator_for_session - 1).toString();

                        pstmt = con.prepareStatement("INSERT INTO program_schedule( workshopid, date, sessionid, comments, time_from, time_to, isActive, update_till) VALUES (?,?,?,?,?,?,?,?)");
                        pstmt.setString(1, workshopid);
                        pstmt.setString(2, date_2);
                        pstmt.setInt(3, iterator_for_session);
                        pstmt.setString(4, comments.get(iterator_for_session - 1).toString());
                        pstmt.setString(5, time_slot.get(iterator_for_session - 1).toString());
                        pstmt.setString(6, time_slot_to.get(iterator_for_session - 1).toString());
                        pstmt.setString(7, isActive.get(iterator_for_session - 1).toString());
                        pstmt.setString(8, date4);
                        result = pstmt.executeUpdate();
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }

    /**
     * @return the workshopContent
     */
    public ArrayList<WorkshopContent> getWorkshopContent() {
        return workshopContent;
    }

    /**
     * @param workshopContent the workshopContent to set
     */
    public void setWorkshopContent(ArrayList<WorkshopContent> workshopContent) {
        this.workshopContent = workshopContent;
    }

    /**
     * @return the schedule
     */
    public ArrayList<AttendanceSchedule> getSchedule() {
        return schedule;
    }

    /**
     * @param schedule the schedule to set
     */
    public void setSchedule(ArrayList<AttendanceSchedule> schedule) {
        this.schedule = schedule;
    }
}
