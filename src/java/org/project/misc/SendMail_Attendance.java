/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.misc;

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
import java.util.regex.Pattern;
import org.project.bean.AttendanceSchedule;
import org.project.bean.AttendanceSheet;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.utilities.DBConnection;
import org.project.utilities.EmailUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;

/**
 *
 * @author Abinaya This class sends mails to the participants and WSC of all the
 * Main workshops. This class also sends the mails to (receiver) with the count
 * of participants and each session they attended on a particular day.
 */
public class SendMail_Attendance {

    private Connection con;
    private PreparedStatement pstmt, pstmt1, pstmt2;
    private ResultSet res, res1, res2;
    private ArrayList<WorkshopContent> ongoingWorkshops, wc, ongoingregistrations;
    private ArrayList<Person> wscList;
    private ArrayList<AttendanceSchedule> ps;
    private ArrayList<AttendanceSheet> as;
    private SimpleStringCipher cipher = new SimpleStringCipher();

    /**
     * get the recent events/ workshops for iteration
     */
    public static void main(String args[]) throws Exception {
        SendMail_Attendance obj = new SendMail_Attendance();
        obj.sendAttendanceReport();
    }

    public void sendAttendanceReport() throws Exception {
        SendMail_Attendance obj = new SendMail_Attendance();
        try {
            ongoingWorkshops = obj.listOnGoingWorkshops();

            for (int i = 0; i < ongoingWorkshops.size(); i++) {
                String wid = Integer.toString(ongoingWorkshops.get(i).getWorkshopid());

                wc = obj.listWorkshopContent(wid);
                /**
                 * get the respective coordinators of the main workshop
                 */
                // wscList = process.getCoordinatorList(wid);
                /**
                 * get the program schedule of that particular day.
                 */
                DateFormat required = new SimpleDateFormat("yyyy-MM-dd");

                String now = required.format(new Date());

                ps = obj.getProgramSchedule(wid, now);
                // if ps size not 0, get sessions and send mails
                if (ps.size() != 0) {

                    // System.out.println(wid + " " + required.format(new Date()) + " " + ps.size());
                    /*set session ids of the day*/
                    String session_ids = "";
                    for (int j = 0; j < ps.size(); j++) {
                        String present_session = Integer.toString(ps.get(j).getIdOfParticularSession());
                        session_ids = session_ids + present_session + " ";
                    }
                    session_ids = session_ids.trim();
                    session_ids = session_ids.replaceAll("\\s", ",");
                    //  System.out.println("session ids " + session_ids);
                    /**
                     * get the participants of this workshop and these sessions
                     */
                    as = getAttendanceSheet(wid, session_ids);
                    if (as.size() != 0) {
                        DateFormat userf = new SimpleDateFormat("dd-MM-yyyy");
                        System.out.println(as.get(0).getDateOfSession_1() + "  " + userf.format(as.get(0).getDateOfSession_1()));
                        String now_user = userf.format(as.get(0).getDateOfSession_1());
                        for (int k = 0; k < as.size(); k++) {
                            if (as.get(k).getAbsentEvenInASession() > 0) {
                                /*
                                 * If absent in a session of the update_till date, send mail to participant
                                 */
                                String absentTimeSlots = as.get(k).getAbsentTimeSlots();
                                absentTimeSlots = absentTimeSlots.trim();
                                absentTimeSlots = absentTimeSlots.replaceAll("\\s", " , ");
                                // System.out.println(as.get(k).getParticipantid() + " absent in no of sessions" + as.get(k).getAbsentEvenInASession() + " " + absentTimeSlots);

                                // send mail
                                try {
                                    String fileName = "attendanceForParticipants.html";
                                    String contextPath = "path/web";
                                    String filePath = contextPath + "/" + "mail-template";
                                    String emailMessage = HtmlUtility.read(filePath, fileName);
                                    String subject = "Attendance Submitted for STTP " + wc.get(0).getWorkshopname();
                                    String name = as.get(k).getParticipantDetail().getFirstName() + " " + as.get(k).getParticipantDetail().getLastName();
                                    String noOfSessionsAbsent = Integer.toString(as.get(k).getAbsentEvenInASession());
                                    // System.out.println(as.get(k).getParticipantDetail().getEmail());
                                    emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(name);
                                    emailMessage = Pattern.compile("#date#").matcher(emailMessage).replaceFirst(now_user);
                                    emailMessage = Pattern.compile("#workshopname#").matcher(emailMessage).replaceFirst(wc.get(0).getWorkshopname());
                                    emailMessage = Pattern.compile("#noOfSessionsAbsent#").matcher(emailMessage).replaceFirst(noOfSessionsAbsent);
                                    emailMessage = Pattern.compile("#absentSessions#").matcher(emailMessage).replaceFirst(absentTimeSlots);

                                    // System.out.println(emailMessage);

                                    EmailUtil mail = new EmailUtil();
                                    mail.sendEmail("senderemail", "test email", "", "", subject, emailMessage);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public ArrayList<WorkshopContent> listOnGoingWorkshops() {
        ArrayList<WorkshopContent> recentWorkshops = new ArrayList<WorkshopContent>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select workshopname,workshopid from workshops where (date_add(CURDATE(), interval 0 day) > startdate) and  (date_add(CURDATE(), interval -5 day) < enddate) and (categorycode = 5 or categorycode = 7 or categorycode = 8) order by workshops.startdate DESC");
                res = pstmt.executeQuery();
                WorkshopContent workshopContent = null;
                while (res.next()) {
                    workshopContent = new WorkshopContent();
                    workshopContent.setWorkshopname(res.getString("workshopname"));
                    workshopContent.setWorkshopid(res.getInt("workshopid"));
                    recentWorkshops.add(workshopContent);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return recentWorkshops;
    }

    public ArrayList<AttendanceSchedule> getProgramSchedule(String workshopid, String update_till) {
        ArrayList<AttendanceSchedule> details = new ArrayList<AttendanceSchedule>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //pstmt = con.prepareStatement("select streamid,head_title,headname,heademail,head_designation,headaddress,head_contact from academic where instituteid=?");
                pstmt = con.prepareStatement("select *, DATE_FORMAT( date, ' %M %D, %Y' ) as date1, DATE_FORMAT( update_till, '%d-%m-%Y' ) AS update_till1 from  program_schedule where workshopid=? and update_till=? and isActive=1 order by date, time_from");
                pstmt.setString(1, workshopid);
                pstmt.setString(2, update_till);
                res = pstmt.executeQuery();
                AttendanceSchedule obj_details = null;
                while (res.next()) {
                    obj_details = new AttendanceSchedule();
                    obj_details.setIdOfParticularSession(res.getInt("id"));
                    obj_details.setDate_string(res.getString("date1"));
                    obj_details.setDateOfSession(res.getString("date"));
                    obj_details.setNumberOfSessions(res.getString("sessionid"));
                    obj_details.setComments(res.getString("comments"));
//                    obj_details.setTime_slot(res.getString("time_slot"));
                    obj_details.setTime_from(res.getString("time_from"));
                    obj_details.setTime_to(res.getString("time_to"));
                    obj_details.setIsActive(res.getInt("isActive"));
                    obj_details.setDate_till_1(res.getString("update_till"));
                    details.add(obj_details);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return details;
    }

    public ArrayList<AttendanceSheet> getAttendanceSheet(String workshopid, String session_ids) {
        ArrayList<AttendanceSheet> details = new ArrayList<AttendanceSheet>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //pstmt = con.prepareStatement("select streamid,head_title,headname,heademail,head_designation,headaddress,head_contact from academic where instituteid=?");
                pstmt = con.prepareStatement("select distinct(participantid), rcid from attendance where workshopid=? limit 10");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                AttendanceSheet obj_details = null;
                while (res.next()) {
                    String participantid = res.getString(1);
                    String rcid = res.getString(2);



                    pstmt1 = con.prepareStatement("select a.*,ps.date, ps.time_from, ps.time_to from attendance a, program_schedule ps where a.participantid = ? and a.session IN (" + session_ids + ") and ps.id=a.session");
                    pstmt1.setString(1, participantid);
                    res1 = pstmt1.executeQuery();
                    obj_details = new AttendanceSheet();
                    obj_details.setParticipantid(participantid);
                    obj_details.setRcid(rcid);

                    pstmt2 = con.prepareStatement("select per.firstname, per.lastname, c.email from person per, context c, participant p where p.personid=per.personid and c.idcontext=p.personid and p.participantid=?");
                    pstmt2.setString(1, participantid);
                    res2 = pstmt2.executeQuery();
                    while (res2.next()) {
                        Person p = new Person();
                        p.setFirstName(res2.getString("firstname"));
                        p.setLastName(res2.getString("lastname"));
                        p.setEmail(res2.getString("email"));
                        obj_details.setParticipantDetail(p);
                    }

                    ArrayList<String> id = new ArrayList<String>();
                    ArrayList<String> isPresent = new ArrayList<String>();
                    ArrayList<String> sessionid = new ArrayList<String>();
                    ArrayList<String> time_slot = new ArrayList<String>();

                    int absentEvenInASession = 0;
                    String absentTimeSlots = "";


                    while (res1.next()) {
                        obj_details.setDateOfSession_1(res1.getDate("date"));
                        id.add(res1.getString("id"));
                        isPresent.add(res1.getString("isPresent"));
                        sessionid.add(res1.getString("session"));
                        time_slot.add(res1.getString("time_from") + "-" + res1.getString("time_to"));
                        // increment absentEvenInASession if attendance is No
                        if (res1.getString("isPresent").equals("No")) {
                            absentTimeSlots = absentTimeSlots + res1.getString("time_from") + "-" + res1.getString("time_to") + " ";
                            absentEvenInASession++;
                        }
                    }
                    try {
                        obj_details.setId(id);
                        obj_details.setIsPresent(isPresent);
                        obj_details.setSessionid(sessionid);
                        //obj_details.setTime_slot(time_slot);
                        obj_details.setAbsentTimeSlots(absentTimeSlots);
                        obj_details.setAbsentEvenInASession(absentEvenInASession);
                        details.add(obj_details);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        System.out.println(details.size());
        return details;

    }

    public ArrayList<WorkshopContent> listWorkshopContent(String workshopid) throws Exception {
        ArrayList<WorkshopContent> workshopContents = new ArrayList<WorkshopContent>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {

                pstmt = con.prepareStatement("SELECT categorycode,workshopid,workshopname,introduction,objectives,durationandvenue"
                        + ",teachingfaculty,author,whoshouldattend,note,coursefee,accomodation,howtoapply,certificatepath,broucherpath,DATE_FORMAT( startdate, '%d-%m-%Y' ) AS startdate1, DATE_FORMAT( enddate, '%d-%m-%Y' ) AS enddate1, "
                        + "schedulepath,mailcontentpath,contact,eventstatus,permissionletter,DATE_FORMAT( startdate, ' %M %D, %Y' ) AS startdate, DATE_FORMAT( enddate, '%M %D, %Y' ) AS enddate,sponsor, DATE_FORMAT( IFNULL(lastdateforappli,startdate-1), '%d-%m-%Y' ) AS lastdateforappli, DATE_FORMAT( IFNULL(startdateofappli, startdate-30), '%d-%m-%Y' ) AS startdateofappli,author,resourcepath,eligibility, announcement,respective_coordinatorid, "
                        + "permission_letter_ifrequired, accomodation_ifavailable,coursewarestatus, LMS_Moodle, LMS_IITBx, IFNULL(IITBx_coursename,'') as IITBx_coursename, IFNULL(Moodle_coursename,'') as Moodle_coursename, certificate_institute_wise, certificate_rc_wise, IFNULL(instructions,'') as instructions FROM workshops WHERE workshopid=? ");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                WorkshopContent workshopContent = null;
                while (res.next()) {
                    workshopContent = new WorkshopContent();
                    try {
                        String encryptedcode = cipher.encrypt(workshopid);
                        /**
                         * set the url parameters with the encrypted code
                         */
                        workshopContent.setWorkshopid_encrypted(encryptedcode);
                        workshopContent.setRcid_encrypted(cipher.encrypt("all"));
                        workshopContent.setStatus_encrypted(cipher.encrypt("all"));
                        /**
                         * set the link of participant list with default
                         * rcid=all (remotecenterid) and status=all
                         */
                        String link_participantList = "participantList.html?workshopid=" + encryptedcode + "&rcid=" + cipher.encrypt("all") + "&status=" + cipher.encrypt("all");
                        workshopContent.setLink_participantList(link_participantList);
                        /**
                         * set the link for the workshop registration with the
                         * encrypted workshopid.
                         */
                        String link = "workshopRegistration.html?workshopid=" + encryptedcode;
                        String link_updateRegistration = "updateRegistration.html?workshopid=" + encryptedcode;
                        workshopContent.setLink_updateRegistration(link_updateRegistration);
                        /**
                         * use the registration start date and the end date to
                         * find the status of the registration process, viz,
                         * open/closed/yet to start
                         */
                        String reglastdate = res.getString("lastdateforappli");
                        workshopContent.setLastdatereg(res.getString("lastdateforappli"));
                        String regstartdate = res.getString("startdateofappli");
                        workshopContent.setStartdatereg(res.getString("startdateofappli"));

                        SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
                        SimpleDateFormat dmy = new SimpleDateFormat("dd-MM-yyyy");

                        Date regdate = dmy.parse(reglastdate);
                        Date regstartingdate = dmy.parse(regstartdate);

                        // for attendance generate button 
                        Date startdate_1 = dmy.parse(res.getString("startdate1"));
                        Date startdate_3 = new Date(startdate_1.getTime() - (5 * 24 * 3600 * 1000));

                        Date startDateOfWorkshop = dmy.parse(res.getString("startdate1"));

                        java.util.Date now = new java.util.Date();
                        Calendar cal1 = Calendar.getInstance();
                        Calendar cal2 = Calendar.getInstance();
                        cal1.setTime(regdate);
                        cal2.setTime(now);
                        boolean sameDay = cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) && cal1.get(Calendar.MONTH) == cal2.get(Calendar.MONTH)
                                && cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR);

                        if (regstartingdate.after(now)) {
                            workshopContent.setEventstatus("Registration will start soon");
                            workshopContent.setLink("");
                        } else if (regdate.after(now)) {
                            workshopContent.setWorkshopExpiry(0);
                            workshopContent.setEventstatus("Click here for registration form");
                            workshopContent.setLink(link);
                        } else if (sameDay == true) {
                            workshopContent.setWorkshopExpiry(0);
                            workshopContent.setEventstatus("Click here for registration form");
                            workshopContent.setLink(link);
                        } else if (now.after(regdate)) {
                            workshopContent.setWorkshopExpiry(1);
                            workshopContent.setEventstatus("Registration Closed");
                            workshopContent.setLink("");
                        }
                        if (now.after(startDateOfWorkshop) || now == startDateOfWorkshop) {
                            workshopContent.setLessThanStartDate(1);
                            // to display WCC for attendance update
                            workshopContent.setIfCanDisplayWCCDashboard(1);
                        }
                        // to display attendance generate button
                        if (now.after(startdate_3) || now.equals(startdate_3)) {
                            workshopContent.setIfAttendanceCanBeCreated(1);
                        }

                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                    /**
                     * parameters set for the heading
                     */
                    workshopContent.setCategorycode(res.getInt("categorycode"));
                    workshopContent.setWorkshopid(res.getInt("workshopid"));
                    workshopContent.setWorkshopname(res.getString("workshopname"));
                    workshopContent.setStartdate(res.getString("startdate"));
                    workshopContent.setEnddate(res.getString("enddate"));

                    /**
                     * parameters for back end form
                     */
                    workshopContent.setStartdate1(res.getString("startdate1"));
                    workshopContent.setEnddate1(res.getString("enddate1"));
                    /**
                     * parameters set for the content
                     */
                    workshopContent.setIntroduction(res.getString("introduction"));
                    workshopContent.setObjectives(res.getString("objectives"));
                    workshopContent.setDurationvenue(res.getString("durationandvenue"));
                    workshopContent.setTeachingfaculty(res.getString("teachingfaculty"));
                    workshopContent.setAuthor(res.getString("author"));
                    workshopContent.setWhoshouldattend(res.getString("whoshouldattend"));
                    workshopContent.setNote(res.getString("note"));
                    workshopContent.setCoursefee(res.getString("coursefee"));
                    workshopContent.setAccomodation(res.getString("accomodation"));
                    workshopContent.setHowtoapply(res.getString("howtoapply"));
                    workshopContent.setContact(res.getString("contact"));
                    workshopContent.setInstructions(res.getString("instructions"));
                    /**
                     * parameters set for the brouchure and letter
                     */
                    workshopContent.setBrochurepath("pdfs/" + res.getString("broucherpath"));
                    workshopContent.setPermissionLetter("pdfs/" + res.getString("permissionletter"));
                    workshopContent.setEligibility("pdfs/" + res.getString("eligibility"));
                    /**
                     * parameters set miscellaneous
                     */
                    workshopContent.setCertificatepath(res.getString("certificatepath"));
                    workshopContent.setSchedulepath(res.getString("schedulepath"));
                    workshopContent.setMailcontentpath(res.getString("mailcontentpath"));
                    workshopContent.setSponsor(res.getString("sponsor"));
                    workshopContent.setResourcepath(res.getString("resourcepath"));
                    workshopContent.setAnnouncement(res.getString("announcement"));
                    workshopContent.setRespectiveCoWorkshopid(res.getInt("respective_coordinatorid"));

                    workshopContent.setAccommodation(res.getInt("accomodation_ifavailable"));
                    workshopContent.setPermissionIfRequired(res.getInt("permission_letter_ifrequired"));
                    workshopContent.setCoursewarestatus(res.getString("coursewarestatus"));

                    workshopContent.setLms_moodle(res.getInt("LMS_Moodle"));
                    workshopContent.setLms_iitbx(res.getInt("LMS_IITBx"));
                    workshopContent.setMoodle_coursename(res.getString("Moodle_coursename"));
                    workshopContent.setIitbx_coursename(res.getString("IITBx_coursename"));

                    workshopContent.setCertificateGroupRC(res.getInt("certificate_rc_wise"));
                    workshopContent.setCertificateGroupInstitute(res.getInt("certificate_institute_wise"));

                    workshopContents.add(workshopContent);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return workshopContents;
    }
}
