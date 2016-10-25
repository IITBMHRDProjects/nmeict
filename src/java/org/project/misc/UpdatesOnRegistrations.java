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
import org.project.bean.RegistrationDetails;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.DBConnection;
import org.project.utilities.EmailUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;

/**
 *
 * @author Abinaya
 */
public class UpdatesOnRegistrations {

    private Connection con;
    private PreparedStatement pstmt, pstmt1, pstmt2;
    private ResultSet res, res1, res2;
    private ArrayList<WorkshopContent> wc, ongoingregistrations;
    private SimpleStringCipher cipher = new SimpleStringCipher();
    ArrayList<RegistrationDetails> countOfParticipants;

    public static void main(String args[]) throws Exception {
        UpdatesOnRegistrations obj = new UpdatesOnRegistrations();
        obj.sendCountReport();
    }

    public void sendCountReport() throws Exception {
        UpdatesOnRegistrations obj = new UpdatesOnRegistrations();
        try {
            ongoingregistrations = obj.listOnGoingRegistrations();

            String list = "";
            for (int i = 0; i < ongoingregistrations.size(); i++) {
                String wid = Integer.toString(ongoingregistrations.get(i).getWorkshopid());

                wc = obj.listWorkshopContent(wid);

                DateFormat required = new SimpleDateFormat("yyyy-MM-dd");

                String now = required.format(new Date());

                UtilityProcess process = new UtilityProcess();
                countOfParticipants = process.getParticipantCount(wid, "all");
                list += "<br>";
                list += "<b>" + wc.get(0).getWorkshopname() + "</b>";
                list += "<br>";
                list += "<ul><li>Number of partcicpants registered : <b>" + countOfParticipants.get(0).getTotalParticipants() + "</b> </li>"
                        + "<li>Number of participants confirmed : <b>" + countOfParticipants.get(0).getConfirmedParticipants() + "</b></li>"
                        + "</ul>";

            }

            //System.out.println(list);
            if (ongoingregistrations.size() != 0) {
                try {
                    String fileName = "countOfOngoingRegistrations.html";
                    String contextPath = "/path/web";
                    String filePath = contextPath + "/" + "mail-template";
                    String emailMessage = HtmlUtility.read(filePath, fileName);
                    String subject = "Updates on Ongoing Registrations in 'Project Name' website ";

                    emailMessage = Pattern.compile("#list#").matcher(emailMessage).replaceFirst(list);

//                    System.out.println(emailMessage);

                    EmailUtil mail = new EmailUtil();
                    mail.sendEmail("senderemail", "cc_email", "", "", subject, emailMessage);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
    }

    public ArrayList<WorkshopContent> listOnGoingRegistrations() {
        ArrayList<WorkshopContent> recentWorkshops = new ArrayList<WorkshopContent>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select workshopname,workshopid from workshops where (date_add(CURDATE(), interval 0 day) > startdateofappli) and  (date_add(CURDATE(), interval -5 day) < lastdateforappli)  order by workshops.startdate DESC");
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
