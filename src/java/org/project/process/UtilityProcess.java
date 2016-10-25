/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.process;

import org.project.bean.Stream;
import org.project.bean.WorkshopCount;
import org.project.bean.Institute;
import org.project.bean.CertificateAudit;
import org.project.bean.Qualification;
import org.project.bean.Summary;
import org.project.bean.Announcements;
import org.project.bean.HeadTitle;
import org.project.bean.Designation;
import org.project.bean.PaymentGateway;
import org.project.bean.WSCNominations;
import org.project.bean.DataExportActivityBean;
import org.project.bean.SurveyForm;
import org.project.bean.Downloads;
import org.project.bean.Participant;
import org.project.bean.Content;
import org.project.bean.HeadDesignation;
import org.project.bean.Lookups;
import org.project.bean.ParticipantReasons;
import org.project.bean.StatusMatrix;
import org.project.bean.WorkshopContent;
import org.project.bean.HeadDetails;
import org.project.bean.RegistrationDetails;
import org.project.bean.Title;
import org.project.bean.State;
import org.project.bean.City;
import org.project.bean.AttendanceSchedule;
import org.project.bean.RemoteCenterCapacity;
import org.project.bean.RemoteCenter;
import org.project.bean.Person;
import org.project.bean.AttendanceSheet;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import org.project.utilities.DBConnection;
import org.project.utilities.ErrorCode;
import org.project.utilities.SimpleStringCipher;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.project.utilities.ExcelSheet;

/**
 *
 * @author mayank
 */
public class UtilityProcess {

    private Connection con;
    private PreparedStatement pstmt, pstmt1, pstmt2, pstmt3, pstmt4;
    private ResultSet res, res1, res2, res3, res4;
    private Statement stmt;
    SimpleStringCipher cipher = new SimpleStringCipher();

    /**
     *
     * @return
     */
    public ArrayList<Title> listTitles() {
        ArrayList<Title> titles = new ArrayList<Title>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select participant_titlte_id,participanttitle,isActive from ParticipantTitle where isActive=1 order by participanttitle");
                res = pstmt.executeQuery();
                Title title = null;
                while (res.next()) {
                    title = new Title();
                    title.setTitleId(res.getInt("participant_titlte_id"));
                    title.setTitleName(res.getString("participanttitle"));
                    title.setIsActive(res.getBoolean("isActive"));
                    titles.add(title);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return titles;
    }

    /**
     *
     * @return
     */
    public ArrayList<Qualification> listQualifications() {
        ArrayList<Qualification> qualifications = new ArrayList<Qualification>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select qualification_id,qualification,active from qualification where active=1 order by qualification");
                res = pstmt.executeQuery();
                Qualification qualification = null;
                while (res.next()) {
                    qualification = new Qualification();
                    qualification.setQualificationId(res.getInt("qualification_id"));
                    qualification.setQualification(res.getString("qualification"));
                    qualification.setIsAllowed(res.getBoolean("active"));
                    qualifications.add(qualification);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return qualifications;
    }

    /**
     *
     * @return
     */
    public ArrayList<Designation> listDesignations() {
        ArrayList<Designation> designations = new ArrayList<Designation>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select iddesignation,designation,isActive from designation where isActive=1 order by designation");
                res = pstmt.executeQuery();
                Designation designation = null;
                while (res.next()) {
                    designation = new Designation();
                    designation.setDesignationId(res.getInt("iddesignation"));
                    designation.setDesignationName(res.getString("designation"));
                    designation.setIsActive(res.getBoolean("isActive"));
                    designations.add(designation);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return designations;
    }

    /**
     *
     * @return
     */
    public ArrayList<Stream> listStreams() {
        ArrayList<Stream> streams = new ArrayList<Stream>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select idstream,stream_name,isActive from stream where isActive=1 order by stream_name");
                res = pstmt.executeQuery();
                Stream stream = null;
                while (res.next()) {
                    stream = new Stream();
                    stream.setStreamId(res.getInt("idstream"));
                    stream.setStreamName(res.getString("stream_name"));
                    stream.setIsActive(res.getBoolean("isActive"));
                    streams.add(stream);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return streams;
    }

    /**
     *
     * @return
     */
    public ArrayList<HeadTitle> listHeadTitles() {
        ArrayList<HeadTitle> headTitles = new ArrayList<HeadTitle>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select head_title_id,head_title,isActive from head_title where isActive=1 order by head_title");
                res = pstmt.executeQuery();
                HeadTitle headTitle = null;
                while (res.next()) {
                    headTitle = new HeadTitle();
                    headTitle.setHeadTitleId(res.getInt("head_title_id"));
                    headTitle.setHeadTitleName(res.getString("head_title"));
                    headTitle.setIsActive(res.getBoolean("isActive"));
                    headTitles.add(headTitle);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return headTitles;
    }

    /**
     *
     * @return
     */
    public ArrayList<HeadDesignation> listHeadDesignations() {
        ArrayList<HeadDesignation> headDesignations = new ArrayList<HeadDesignation>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select headdesignation_id,head_designation,isActive from headdesignation where isActive=1 order by head_designation");
                res = pstmt.executeQuery();
                HeadDesignation headDesignation = null;
                while (res.next()) {
                    headDesignation = new HeadDesignation();
                    headDesignation.setHeadDesignationId(res.getInt("headdesignation_id"));
                    headDesignation.setHeadDesignationName(res.getString("head_designation"));
                    headDesignation.setIsActive(res.getBoolean("isActive"));
                    headDesignations.add(headDesignation);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return headDesignations;
    }

    /**
     *
     * @return
     */
    public ArrayList<State> listStates() throws Exception {
        ArrayList<State> states = new ArrayList<State>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select stateid,state,isActive from state where isActive=1 order by state");
                res = pstmt.executeQuery();
                State state = null;
                while (res.next()) {
                    state = new State();
                    state.setStateId(res.getInt("stateid"));
                    state.setStateName(res.getString("state"));

                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String enc_state = cipher.encrypt(res.getString("stateid"));

                    state.setEnc_state(enc_state);

                    states.add(state);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return states;
    }

    /**
     *
     * @param stateid
     * @return
     */
    public ArrayList<City> listCity(int stateid) {
        ArrayList<City> cities = new ArrayList<City>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select cityid,city from city where isActive=1 and stateid=? order by city");
                // pstmt = con.prepareStatement("select cityid,city from city where stateid=? order by city");
                pstmt.setInt(1, stateid);
                res = pstmt.executeQuery();
                City city = null;
                while (res.next()) {
                    city = new City();
                    city.setCityId(res.getInt("cityid"));
                    city.setCityName(res.getString("city"));
                    cities.add(city);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return cities;
    }

    /**
     *
     * @param cityid
     * @return
     */
    public ArrayList<Institute> listParticipantInstitute(int instituteid) {
        ArrayList<Institute> institutes = new ArrayList<Institute>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select idInstitute,Institutename,address,pincode from institute where idInstitute=?");
                pstmt.setInt(1, instituteid);
                res = pstmt.executeQuery();
                Institute institute = null;
                while (res.next()) {
                    institute = new Institute();
                    institute.setInstituteId(res.getInt("idInstitute"));
                    institute.setInstituteName(res.getString("Institutename"));
                    institute.setInstituteAddress(res.getString("address"));
                    institute.setPincode(res.getInt("pincode"));
                    institutes.add(institute);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return institutes;
    }

    /**
     * This function returns the ArrayList of the announcements present in the
     * announcement table of the database.
     *
     * @return
     */
    public ArrayList<Announcements> listAnnouncements() {
        ArrayList<Announcements> announcements = new ArrayList<Announcements>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
//                pstmt = con.prepareStatement("select announcement,link from announcement  order by announcement.startdate");
                pstmt = con.prepareStatement("select announcementid,announcement,link, location from announcement where (date_add(CURDATE(), interval 120 day) > startdate) and  (date_add(CURDATE(), interval -90 day) < enddate)  order by announcement.startdate desc");
                res = pstmt.executeQuery();
                Announcements announcement = null;
                while (res.next()) {
                    announcement = new Announcements();
                    announcement.setAnnouncementid(res.getInt("announcementid"));
                    announcement.setAnnouncement(res.getString("announcement"));
                    announcement.setLink(res.getString("link"));
                    announcements.add(announcement);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return announcements;
    }

    public ArrayList<Announcements> listPublicAnnouncements() {
        ArrayList<Announcements> announcements = new ArrayList<Announcements>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
//                pstmt = con.prepareStatement("select announcement,link from announcement  order by announcement.startdate");
                pstmt = con.prepareStatement("select announcementid,announcement,link, location from announcement where (date_add(CURDATE(), interval 120 day) > startdate) and  (date_add(CURDATE(), interval -90 day) < enddate) and visible='Y' order by announcement.startdate desc");
                res = pstmt.executeQuery();
                Announcements announcement = null;
                while (res.next()) {
                    announcement = new Announcements();
                    announcement.setAnnouncementid(res.getInt("announcementid"));
                    announcement.setAnnouncement(res.getString("announcement"));
                    announcement.setLink(res.getString("link"));
                    announcements.add(announcement);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return announcements;
    }

    /**
     * This function returns the ArrayList of the announcements present in the
     * announcement table of the database.
     *
     * @return
     */
    public ArrayList<Announcements> listAnnouncements(int loginid) {
        ArrayList<Announcements> announcements = new ArrayList<Announcements>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
//                pstmt = con.prepareStatement("select announcement,link from announcement  order by announcement.startdate");
                // pstmt = con.prepareStatement("select announcementid,announcement,link, location,visible from announcement where (date_add(CURDATE(), interval 90 day) > enddate) and  (date_add(CURDATE(), interval -90 day) < enddate)  order by announcement.startdate desc");
                pstmt = con.prepareStatement("select ann1.* , IFNULL((select p.participantid from participant p, accomodation ac1 where ac1.workshopid =  a.respective_coordinatorid and p.personid=? and ac1.participantid=p.participantid and p.status='Completed'),0) as ifexist1, IFNULL((select p.participantid from participant p, accomodation ac1 where ac1.workshopid = b.respective_coordinatorid and p.personid=? and ac1.participantid=p.participantid and p.status='Completed'),0) as ifexist2 from workshops a, workshops b, announcement ann1 where a.workshopid in (select ann.announcementid from announcement ann where visible='N' and (date_add(CURDATE(), interval 90 day) > a.enddate) and  (date_add(CURDATE(), interval -90 day) < a.enddate)) and b.workshopid=a.respective_coordinatorid and ann1.announcementid=a.workshopid");
                pstmt.setInt(1, loginid);
                pstmt.setInt(2, loginid);
                res = pstmt.executeQuery();
                Announcements announcement = null;
                while (res.next()) {
                    announcement = new Announcements();
                    announcement.setAnnouncementid(res.getInt("announcementid"));
                    announcement.setAnnouncement(res.getString("announcement"));
                    announcement.setLink(res.getString("link"));
                    if (res.getString("location").equals("inhouse")) {
                    }
                    if (res.getInt("ifexist1") > 0 || res.getInt("ifexist2") > 0) {
                        announcements.add(announcement);
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
        return announcements;
    }

    /**
     * This function returns the ArrayList of the workshop Contents to be
     * displayed in the page from the table workshops. We use this function for
     * both workshop Conducted page and the workshop content pages.
     *
     * @return
     */
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
                        + "permission_letter_ifrequired, accomodation_ifavailable,coursewarestatus, LMS_Moodle, LMS_IITBx, IFNULL(IITBx_coursename,'') as IITBx_coursename, IFNULL(Moodle_coursename,'') as Moodle_coursename, certificate_institute_wise, certificate_rc_wise, IFNULL(instructions,'') as instructions,  IFNULL(certificate_criteria,'') as certificate_criteria,feeamount,ifnull(datetobedisplayed,1) as datetobedisplayed, ifnull(extraDownloads,0) as extraDownloads, "
                        + " ifnull(without_RC, '0') as without_RC, ifnull(iitb_payment_if_required,'0') as iitb_payment_if_required, ifnull(rc_payment_if_required,'0') as rc_payment_if_required, withdrawal_button_tbd  FROM workshops WHERE workshopid=? ");
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
                        if (res.getInt("without_RC") == 1) {
                            link_participantList = "participantListSW.html?workshopid=" + encryptedcode + "&state=" + cipher.encrypt("all") + "&status=" + cipher.encrypt("all");

                        }

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

                        Date enddate_1 = dmy.parse(res.getString("enddate1"));
                        Date enddate_3 = new Date(enddate_1.getTime());

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
                        /*On Invite workshops - participants can't apply directly*/
                        if (res.getInt("categorycode") == 6) {
                            workshopContent.setEventstatus("Enrollment is strictly by Invitation");
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
                        if (now.after(enddate_3)) {
                            workshopContent.setWorkshopCompleted(1);
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
                     * parameters for payments and usage of RC
                     */
                    workshopContent.setPayment_at_rc(res.getInt("rc_payment_if_required"));
                    workshopContent.setPayment_at_iitb(res.getInt("iitb_payment_if_required"));
                    workshopContent.setWithout_RC(res.getInt("without_RC"));
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
                    workshopContent.setCertificateCriteria(res.getString("certificate_criteria"));
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

                    // fee paramete added
                    workshopContent.setFeeAmount(res.getString("feeamount"));
                    workshopContent.setDateToBeDisplayed(res.getInt("datetobedisplayed"));
                    workshopContent.setExtraDownloads(res.getString("extraDownloads"));

                    workshopContent.setWithdrawal_flag(res.getInt("withdrawal_button_tbd"));

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

    /**
     * This function returns the ArrayList of the list of participants from the
     * database
     *
     * @return
     */
    public ArrayList<Person> listParticipants(String workshopid, String rcid, String status) throws Exception {
        ArrayList<Person> participantList = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                /**
                 * The category code is fetched to fetch the list from the table
                 * and to determine if it is a coordinator workshop or a main
                 * workshop
                 */
                pstmt = con.prepareStatement("Select categorycode, respective_coordinatorid from workshops WHERE workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                Person list = null;
                while (res.next()) {
                    int categorycode = res.getInt("categorycode");
                    int res_coord_id = res.getInt("respective_coordinatorid");
                    if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                        /**
                         * category 5 is main workshop. the conditions are used
                         * to select the query depending on the status and rcid.
                         */
                        if ((rcid).equals("all") && (status).equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                        } else if (!rcid.equals("all") && status.equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus  from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and a.instituteid=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(rcid));
                        } else if (!rcid.equals("all") && !status.equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus  from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and a.instituteid=? and p.status=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(rcid));
                            pstmt1.setString(3, status);
                        } else if (rcid.equals("all") && !status.equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus  from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setString(2, status);
                        }
                    } else {
                        if (categorycode == 4 && res_coord_id == 0) {
                            /**
                             * category 4 is coordinator workshop, the
                             * conditions are used to select the query depending
                             * on the status and rcid
                             */
                            if (rcid.equals("all") && status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname, per.genderinfo,c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name FROM accomodation a, remotecenter r, designation d, person per, participant p , letter l,context  c , state s, city ci, stream st where ci.cityid=r.city and s.stateid=r.state and p.participantid=a.participantid and p.contextid=c.idcontext and per.personid=p.personid and a.instituteid=r.remotecenterid and d.iddesignation=per.designation and l.participantid=p.participantid and st.idstream=p.streamid and a.workshopid=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname, per.genderinfo,c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name,p.instituteid FROM accomodation a left join remotecenter r on a.instituteid=r.remotecenterid left join  participant p on p.participantid=a.participantid left join person per on per.personid=p.personid left join designation d on d.iddesignation=per.designation left join  letter l on l.participantid=p.participantid left join context c on p.contextid=c.idcontext left join  state s on s.stateid=r.state left join  city ci on ci.cityid=r.city left join   stream st on  st.idstream=p.streamid where a.workshopid=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                            } else if (rcid.equals("all") && !status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname, per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name FROM accomodation a, remotecenter r, designation d, person per, participant p , letter l,context  c , state s, city ci, stream st where ci.cityid=r.city and s.stateid=r.state and p.participantid=a.participantid and p.contextid=c.idcontext and per.personid=p.personid and a.instituteid=r.remotecenterid and d.iddesignation=per.designation and l.participantid=p.participantid and st.idstream=p.streamid and a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname, per.genderinfo,c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name,p.instituteid FROM accomodation a left join remotecenter r on a.instituteid=r.remotecenterid left join  participant p on p.participantid=a.participantid left join person per on per.personid=p.personid left join designation d on d.iddesignation=per.designation left join  letter l on l.participantid=p.participantid left join context c on p.contextid=c.idcontext left join  state s on s.stateid=r.state left join  city ci on ci.cityid=r.city left join   stream st on  st.idstream=p.streamid where a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                                pstmt1.setString(2, status);
                            }
                        }
                        if ((categorycode == 4 && res_coord_id != 0) || categorycode == 6) {
                            /**
                             * category 4 is coordinator workshop, the
                             * conditions are used to select the query depending
                             * on the status and rcid
                             */
                            if (rcid.equals("all") && status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,p.instituteid,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                            } else if (rcid.equals("all") && !status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,p.instituteid,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                                pstmt1.setString(2, status);
                            }
                        }
                    }
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        list = new Person();
                        /**
                         * Set the details of the remote center of the
                         * participant in the ArrayList
                         */
                        RemoteCenter rc = new RemoteCenter();
                        rc.setRemoteCenterName(res1.getString("remotecentername"));
                        rc.setRc_state(res1.getString("state"));
                        rc.setRc_city(res1.getString("city"));
                        rc.setRemoteCenterId(res1.getInt("remotecenterid"));
                        list.setRemoteCenter(rc);
                        /**
                         * set the First Name, Last Name , mobile and email of
                         * the participant
                         */
                        list.setImage("photo_" + res1.getString("personid") + ".jpg");
                        list.setFirstName(res1.getString("firstname"));
                        list.setLastName(res1.getString("lastname"));
                        list.setMobileNumber(res1.getString("mobile"));
                        SimpleStringCipher cipher = new SimpleStringCipher();
                        String email_enc = cipher.encrypt(res1.getString("email"));
                        list.setEmail_enc(email_enc);
                        list.setEmail(res1.getString("email"));
                        /**
                         * set the registration details status, registration
                         * time , letter name, accommodation
                         */
                        RegistrationDetails registrationDetails = new RegistrationDetails();
                        registrationDetails.setStatus(res1.getString("status"));
                        registrationDetails.setRegtime(res1.getDate("regtime"));
                        registrationDetails.setLetter(res1.getString("letter"));
                        registrationDetails.setAccomodation(res1.getString("accomodation"));
                        registrationDetails.setParticipantid(res1.getString("participantid"));
                        if (categorycode == 8) {
                            registrationDetails.setPayment(res1.getString("payment"));
                            registrationDetails.setIsEligibleForCertificate(res1.getString("eligible_for_certificate"));
                            list.setFacultyStatus(res1.getString("facultystatus"));
                        }
                        list.setRegistrationDetails(registrationDetails);

                        Designation designation = new Designation();
                        designation.setDesignationName(res1.getString("designation"));
                        list.setDesignation(designation);
                        /**
                         * set the gender
                         */
                        list.setGender(res1.getString("genderinfo"));
                        /**
                         * Add the institute details if it is a main workshop
                         */
                        if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                            Institute institute = new Institute();
                            institute.setInstituteName(res1.getString("institutename"));
                            institute.setInstituteId(res1.getInt("instituteid"));
                            list.setInstitute(institute);
                        } else {
                            Institute institute = new Institute();
                            institute.setInstituteName("cc4");
                            list.setInstitute(institute);
                        }

                        /**
                         * Set qualification and experience
                         */
                        Qualification qualification = new Qualification();
                        qualification.setQualification(res1.getString("qualification"));
                        list.setQualification(qualification);

                        list.setExperience(res1.getString("experience"));
                        /**
                         * add stream in the list
                         */
                        Stream stream = new Stream();
                        stream.setStreamName(res1.getString("stream_name"));
                        list.setStream(stream);
                        /**
                         * add the details in the array list
                         */
                        /**
                         * Adding the status Matrix
                         */
                        StatusMatrix sm = new StatusMatrix();

                        pstmt2 = con.prepareStatement("select * from status_matrix where InitialStatus=?");
                        pstmt2.setString(1, res1.getString("status"));
                        res2 = pstmt2.executeQuery();
                        if (res2.next()) {
                            sm.setIfDisplayRegistered(res2.getString("Registered"));
                            sm.setIfDisplayInvalid(res2.getString("Invalid"));
                            sm.setIfDisplayApproved(res2.getString("Approved"));
                            sm.setIfDisplayConfirmed(res2.getString("Confirmed"));
                            sm.setIfDisplayCompleted(res2.getString("Completed"));
                            sm.setIfDisplayCancelled(res2.getString("Cancelled"));

                        }
                        list.setStatusMatrix(sm);

                        participantList.add(list);
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participantList;
    }

    /**
     * This function returns the ArrayList of the 'remotecenters' present in the
     * 'remotecentercapacity' table of the database if the main workshop, or
     * returns the active 'remotecenters' for the coordinator workshop.
     *
     * @return
     */
    public ArrayList<RemoteCenter> listRemoteCenters(String workshopid, String state) {
        ArrayList<RemoteCenter> remoteCenters = new ArrayList<RemoteCenter>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("Select categorycode from workshops WHERE workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                RemoteCenter remoteCenter = null;
                while (res.next()) {
                    int categorycode = res.getInt("categorycode");
                    if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                        if (state.equals("all")) {
                            pstmt1 = con.prepareStatement("select rc.rcid as remotecenterid ,r.remotecentername as remotecentername, c.city from remotecenter r, remotecentercapacity rc, city c where r.city=c.cityid and r.remotecenterid=rc.rcid and rc.workshopid=? order by rc.rcid");
                            pstmt1.setString(1, workshopid);
                        } else {
                            pstmt1 = con.prepareStatement("select rc.rcid as remotecenterid,r.remotecentername as remotecentername, c.city from remotecenter r, remotecentercapacity rc, city c where r.city=c.cityid and r.remotecenterid=rc.rcid and rc.workshopid=? and r.state=? order by r.remotecentername");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setString(2, state);
                        }
                    } else if (categorycode == 4 || categorycode == 6) {
                        if (state.equals("all")) {
                            pstmt1 = con.prepareStatement("select r.remotecenterid,r.remotecentername, c.city from remotecenter r, city c where active=1 and c.cityid=r.city  order by remotecentername");
                        } else {
                            pstmt1 = con.prepareStatement("select r.remotecenterid,r.remotecentername, c.city from remotecenter r, city c where c.cityid=r.city and active=1 and state=? order by remotecentername");
                            pstmt1.setString(1, state);
                        }
                    }
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        remoteCenter = new RemoteCenter();
                        remoteCenter.setRemoteCenterId(res1.getInt("remotecenterid"));
                        remoteCenter.setRemoteCenterName(res1.getString("remotecentername"));
                        remoteCenter.setRc_city(res1.getString("city"));
                        //set encrypted rc_id
                        String rc = res1.getString("remotecenterid");
                        SimpleStringCipher cipher = new SimpleStringCipher();
                        try {
                            String enc_rcid = cipher.encrypt(rc);
                            remoteCenter.setEnc_RC(enc_rcid);
                        } catch (Exception ex) {
                            Logger.getLogger(UtilityProcess.class.getName()).log(Level.SEVERE, null, ex);
                        }
                        remoteCenters.add(remoteCenter);
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
        return remoteCenters;
    }

    public ArrayList<WorkshopCount> getWorkshopCount() {
        ArrayList<WorkshopCount> workshopCount = new ArrayList<WorkshopCount>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select  (select count(workshopid) from workshops where ( categorycode=? or categorycode=? or categorycode=? or categorycode=?) and workshopid > 0 ) AS total,"
                        + " (select count(workshopid) from workshops where categorycode=? and workshopid > 0 ) AS coordinator,"
                        + "(select count(workshopid) from workshops where categorycode=? and workshopid > 0 ) AS main, "
                        + " (select count(workshopid) from workshops where (categorycode=? or categorycode =?) and workshopid > 0 ) AS ssm ");
                pstmt.setInt(1, 4);
                pstmt.setInt(2, 5);
                pstmt.setInt(3, 7);
                pstmt.setInt(4, 8);
                pstmt.setInt(5, 4);
                pstmt.setInt(6, 5);
                pstmt.setInt(7, 7);
                pstmt.setInt(8, 8);
                res = pstmt.executeQuery();
                WorkshopCount count = null;
                while (res.next()) {
                    count = new WorkshopCount();
                    count.setTotalWorkshops(res.getInt("total"));
                    count.setMainWorkshops(res.getInt("main"));
                    count.setCoordinatorWorkshops(res.getInt("coordinator"));
                    count.setSSMWorkshops(res.getInt("ssm"));
                    workshopCount.add(count);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return workshopCount;
    }

    /**
     * This function returns the ArrayList of the workshops conducted present in
     * the workshops table of the database.
     *
     * @return
     */
    public ArrayList<WorkshopContent> listWorkshopsConducted(String period) throws Exception {
        ArrayList<WorkshopContent> workshopContents = new ArrayList<WorkshopContent>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (period.equals("90 day")) {
                    pstmt = con.prepareStatement("select workshopname,categorycode,workshopid,author,DATE_FORMAT( startdate, ' %M %D, %Y' ) AS startdate, DATE_FORMAT( enddate, '%M %D, %Y' ) AS enddate, (date_add(enddate, interval 90 day ) >= CURDATE()) as expiry, (date_add(enddate, interval 0 day ) < CURDATE()) as workshopComplete, coursewarestatus,resourcepath,eventstatus, respective_coordinatorid, certificate_rc_wise,certificate_institute_wise,ifnull(datetobedisplayed,1) as datetobedisplayed, ifnull(extraDownloads,0) as extraDownloads from workshops where workshopid>0 order by workshops.startdate DESC");
                } else {
                    pstmt = con.prepareStatement("select workshopname,categorycode,workshopid,author,DATE_FORMAT( startdate, ' %M %D, %Y' ) AS startdate, DATE_FORMAT( enddate, '%M %D, %Y' ) AS enddate, (date_add(enddate, interval " + period + " ) >= CURDATE()) as expiry,(date_add(enddate, interval 0 day ) < CURDATE()) as workshopComplete, coursewarestatus,resourcepath,eventstatus, respective_coordinatorid, certificate_rc_wise,certificate_institute_wise,ifnull(datetobedisplayed,1) as datetobedisplayed, ifnull(extraDownloads,0) as extraDownloads from workshops where workshopid>0 order by workshops.startdate DESC");
//                pstmt.setString(1,"interval "+period);

                }
                res = pstmt.executeQuery();
                WorkshopContent workshopContent = null;
                while (res.next()) {
                    workshopContent = new WorkshopContent();
                    workshopContent.setWorkshopname(res.getString("workshopname"));
                    workshopContent.setCategorycode(res.getInt("categorycode"));
                    workshopContent.setWorkshopid(res.getInt("workshopid"));
                    workshopContent.setTeachingfaculty(res.getString("author"));
                    workshopContent.setStartdate(res.getString("startdate"));
                    workshopContent.setEnddate(res.getString("enddate"));
                    workshopContent.setCoursewarestatus(res.getString("coursewarestatus"));
                    if ((res.getString("coursewarestatus")).equals("Available Soon")) {
                        workshopContent.setResourcepath("#");
                    } else {
                        workshopContent.setResourcepath(res.getString("resourcepath"));
                    }
                    workshopContent.setEventstatus(res.getString("eventstatus"));
                    //generate link for the event content
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String eventContentPath = "workshopDetails.html?workshopid=" + cipher.encrypt(res.getString("workshopid")) + "&category=" + cipher.encrypt(res.getString("categorycode"));
                    //set the event content path
                    workshopContent.setEventdetailspagepath(eventContentPath);
                    String encryptedId = cipher.encrypt(Integer.toString(res.getInt("workshopid")));
                    workshopContent.setWorkshopExpiry(res.getInt("expiry"));
                    workshopContent.setWorkshopid_encrypted(encryptedId);
                    workshopContent.setRespectiveCoWorkshopid(res.getInt("respective_coordinatorid"));
                    // for certificate

                    workshopContent.setCertificateGroupRC(res.getInt("certificate_rc_wise"));
                    workshopContent.setCertificateGroupInstitute(res.getInt("certificate_institute_wise"));

                    // for rcc and wsc - show particular workshop in home page depending on the respective coordinator workshop id
                    if (res.getInt("respective_coordinatorid") != 0) {
                        pstmt1 = con.prepareStatement("select (select enddate from workshops where workshopid=?) < CURDATE() as test1");
                        pstmt1.setInt(1, res.getInt("respective_coordinatorid"));
                        res1 = pstmt1.executeQuery();
                        while (res1.next()) {
                            workshopContent.setIfResCoorWorkshopIsComplete(res1.getInt("test1"));
                        }
                    }
                    workshopContent.setDateToBeDisplayed(res.getInt("datetobedisplayed"));
                    workshopContent.setWorkshopCompleted(res.getInt("workshopComplete"));
                    workshopContent.setExtraDownloads(res.getString("extraDownloads"));
                    workshopContents.add(workshopContent);
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
        return workshopContents;
    }

    /**
     * This function returns the ArrayList of the workshops conducted present in
     * the workshops table of the database.
     *
     * @return
     */
    public ArrayList<WorkshopContent> listWorkshopsConducted1(String period) throws Exception {
        ArrayList<WorkshopContent> workshopContents = new ArrayList<WorkshopContent>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (period.equals("90 day")) {
                    pstmt = con.prepareStatement("select workshopname,categorycode,workshopid,author,DATE_FORMAT( startdate, ' %M %D, %Y' ) AS startdate, DATE_FORMAT( enddate, '%M %D, %Y' ) AS enddate, (date_add(enddate, interval 90 day ) >= CURDATE()) as expiry, coursewarestatus,resourcepath,eventstatus, respective_coordinatorid, certificate_rc_wise,certificate_institute_wise,ifnull(datetobedisplayed,1) as datetobedisplayed, ifnull(extraDownloads,0) as extraDownloads, ifnull(without_RC,'0') as without_RC from workshops order by workshops.startdate DESC");
                } else {
                    pstmt = con.prepareStatement("select workshopname,categorycode,workshopid,author,DATE_FORMAT( startdate, ' %M %D, %Y' ) AS startdate, DATE_FORMAT( enddate, '%M %D, %Y' ) AS enddate, (date_add(enddate, interval " + period + " ) >= CURDATE()) as expiry, coursewarestatus,resourcepath,eventstatus, respective_coordinatorid, certificate_rc_wise,certificate_institute_wise,ifnull(datetobedisplayed,1) as datetobedisplayed, ifnull(extraDownloads,0) as extraDownloads, ifnull(without_RC,'0') as without_RC  from workshops order by workshops.startdate DESC");
//                pstmt.setString(1,"interval "+period);
                }
                res = pstmt.executeQuery();
                WorkshopContent workshopContent = null;
                while (res.next()) {
                    workshopContent = new WorkshopContent();
                    workshopContent.setWorkshopname(res.getString("workshopname"));
                    workshopContent.setCategorycode(res.getInt("categorycode"));
                    workshopContent.setWorkshopid(res.getInt("workshopid"));
                    workshopContent.setTeachingfaculty(res.getString("author"));
                    workshopContent.setStartdate(res.getString("startdate"));
                    workshopContent.setEnddate(res.getString("enddate"));
                    workshopContent.setCoursewarestatus(res.getString("coursewarestatus"));
                    if ((res.getString("coursewarestatus")).equals("Available Soon")) {
                        workshopContent.setResourcepath("#");
                    } else {
                        workshopContent.setResourcepath(res.getString("resourcepath"));
                    }
                    workshopContent.setEventstatus(res.getString("eventstatus"));
                    //generate link for the event content
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String eventContentPath = "workshopDetails.html?workshopid=" + cipher.encrypt(res.getString("workshopid")) + "&category=" + cipher.encrypt(res.getString("categorycode"));
                    //set the event content path
                    workshopContent.setEventdetailspagepath(eventContentPath);
                    String encryptedId = cipher.encrypt(Integer.toString(res.getInt("workshopid")));
                    workshopContent.setWorkshopExpiry(res.getInt("expiry"));
                    workshopContent.setWorkshopid_encrypted(encryptedId);
                    workshopContent.setRespectiveCoWorkshopid(res.getInt("respective_coordinatorid"));

                    // for certificate
                    workshopContent.setCertificateGroupRC(res.getInt("certificate_rc_wise"));
                    workshopContent.setCertificateGroupInstitute(res.getInt("certificate_institute_wise"));
                    workshopContent.setDateToBeDisplayed(res.getInt("datetobedisplayed"));
                    workshopContent.setExtraDownloads(res.getString("extraDownloads"));
                    workshopContent.setWithout_RC(res.getInt("without_RC"));
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

    /**
     * This function returns the ArrayList of the count of participants present
     * in the accommodation table of the database.
     *
     * @return
     */
    public int getCount(String workshopid, String rcid, String status) {
        int countOfParticipants = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (rcid.equals("all") && status.equals("all")) {
                    // for all remote centers and all status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=?");
                    pstmt.setString(1, workshopid);
                }
                if (!rcid.equals("all") && status.equals("all")) {
                    // for specific remote centers and all status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=? and a.instituteid=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, rcid);
                }
                if (rcid.equals("all") && !status.equals("all")) {
                    // for all remote centers and specific status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=?  and p.status=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, status);
                }
                if (!rcid.equals("all") && !status.equals("all")) {
                    // for specific remote centers and specific status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=? and a.instituteid=?  and p.status=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, rcid);
                    pstmt.setString(3, status);
                }
                res = pstmt.executeQuery();
                while (res.next()) {
                    countOfParticipants = res.getInt(1);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
        }
        return countOfParticipants;
    }

    /**
     * This function returns the ArrayList of the count of different status of
     * the participants in a particular workshop.
     *
     * @return
     */
    public ArrayList<RegistrationDetails> getParticipantCount(String workshopid, String rcid) throws Exception {
        ArrayList<RegistrationDetails> countArray = new ArrayList<RegistrationDetails>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                RegistrationDetails count = null;
                count = new RegistrationDetails();

                int totalParticipants = getCount(workshopid, "all", "all");
                int registeredParticipants = getCount(workshopid, rcid, "Request Registered");
                int verifiedParticipants = getCount(workshopid, rcid, "Request Verified");
                int invalidParticipants = getCount(workshopid, rcid, "Registration Invalid");
                int approvedParticipants = getCount(workshopid, rcid, "Request Approved");
                int confirmedParticipants = getCount(workshopid, rcid, "Confirmed");
                int waitlistedParticipants = getCount(workshopid, rcid, "Waitlisted");
                int cancelledParticipants = getCount(workshopid, rcid, "Cancelled");
                int completedParticipants = getCount(workshopid, rcid, "Completed");
                int acceptedParticipants = getCount(workshopid, rcid, "Accepted");
                // for all status specific rc
                int total_rc = getCount(workshopid, rcid, "all");
                count.setTotalParticipants(totalParticipants);
                count.setRegisteredParticipants(registeredParticipants);
                count.setVerifiedParticipants(verifiedParticipants);
                count.setApprovedParticipants(approvedParticipants);
                count.setConfirmedParticipants(confirmedParticipants);
                count.setWaitlistedParticipants(waitlistedParticipants);
                count.setCancelledParticipants(cancelledParticipants);
                count.setInvalidParticipants(invalidParticipants);
                count.setCompletedParticipants(completedParticipants);
                count.setAcceptedParticipants(acceptedParticipants);
                count.setTotal_rc_participants(total_rc);
                countArray.add(count);

            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return countArray;
    }

    /**
     * This function returns the ArrayList of the Participant's center present
     * in the accommodation table of the database for the given workshop.
     *
     * @return
     */
    public ArrayList<Person> listParticipantCenters(String workshopid) throws Exception {
        ArrayList<Person> participantCenters_main = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("SELECT a.instituteid, r.remotecentername, count(a.instituteid) as count FROM accomodation a, remotecenter r,participant p WHERE a.instituteid = r.remotecenterid and a.participantid=p.participantid and (p.status='Confirmed' or p.status='Completed') and a.workshopid = ? group by a.instituteid");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                Person participantCenters = null;
                while (res.next()) {
                    participantCenters = new Person();
                    RemoteCenter rc = new RemoteCenter();
                    rc.setRemoteCenterName(res.getString("remotecentername"));
                    participantCenters.setRemoteCenter(rc);
                    RegistrationDetails rd = new RegistrationDetails();
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    rd.setLink("list.html?workshopid=" + cipher.encrypt(workshopid) + "&rcid=" + cipher.encrypt(res.getString("instituteid")) + "&status=" + cipher.encrypt("Confirmed"));
                    rd.setTotalParticipants(res.getInt("count"));
                    participantCenters.setRegistrationDetails(rd);
                    participantCenters_main.add(participantCenters);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participantCenters_main;
    }

    /**
     * This function returns the ArrayList of the coordinators of the respective
     * main workshop If the relation exist, it displays coordinator from
     * accomodation table, else it fetches details from workshop_coordinator
     * table.
     *
     * @return
     */
    public ArrayList<Person> getCoordinatorList(String workshopid) throws Exception {
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
                        pstmt1 = con.prepareStatement("SELECT  r.remotecentername,  ci.city  , per.firstname,per.lastname, r.remotecenterid,c.mobile,c.email, s.state FROM accomodation a, remotecenter r, designation d, person per, participant p , context  c , state s, city ci WHERE a.instituteid = r.remotecenterid and  p.participantid=a.participantid and  c.idcontext=p.contextid and s.stateid= r.state and ci.cityid = r.city and per. personid=p.contextid  and per.designation=d.iddesignation and a.workshopid =? and (p.status='Confirmed' or p.status='Completed')  order by r.remotecenterid ");
                        pstmt1.setString(1, coordinator_workshopid);
                        res1 = pstmt1.executeQuery();
                        while (res1.next()) {
                            coordinators = new Person();
                            coordinators.setFirstName(res1.getString("firstname") + " " + res1.getString("lastname"));
                            RemoteCenter rc = new RemoteCenter();
                            rc.setRemoteCenterId(res1.getInt("remotecenterid"));
                            rc.setRemoteCenterName(res1.getString("remotecentername"));
                            rc.setRc_city(res1.getString("city"));
                            rc.setRc_state(res1.getString("state"));
                            coordinators.setRemoteCenter(rc);
                            coordinators.setEmail(res1.getString("email"));
                            coordinators.setMobileNumber(res1.getString("mobile"));
                            coordinatorList.add(coordinators);
                        }
                    } else {
                        //no related coordinator workshop id found. So fetch details from workshop_coordinator

                        pstmt1 = con.prepareStatement("SELECT wc.rcid,wc.name,wc.contact, wc.email,r.remotecentername,c.city, s.state from workshop_coordinator wc, remotecenter r,city c, state s where r.remotecenterid=wc.rcid and r.city=c.cityid and r.state=s.stateid and workshopid =? order by wc.rcid ");
                        pstmt1.setString(1, workshopid);
                        res1 = pstmt1.executeQuery();
                        while (res1.next()) {
                            coordinators = new Person();
                            coordinators.setFirstName(res1.getString("name"));
                            RemoteCenter rc = new RemoteCenter();
                            rc.setRemoteCenterId(res1.getInt("rcid"));
                            rc.setRemoteCenterName(res1.getString("remotecentername"));
                            rc.setRc_city(res1.getString("city"));
                            rc.setRc_state(res1.getString("state"));
                            coordinators.setRemoteCenter(rc);
                            coordinators.setEmail(res1.getString("email"));
                            coordinators.setMobileNumber(res1.getString("contact"));
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

    public int submitMessage(String name, String email, String message) {
        int result = ErrorCode.ERROR;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("insert into contactus(contact_name, contact_email, message) values (?,?,?)");
                //binding the parameter values to query statement
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, message);
                result = pstmt.executeUpdate();
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
     *
     * @param content
     * @return
     * @throws Exception
     */
    public synchronized int insertWorkshop(WorkshopContent content) throws Exception {
        int isInserted = ErrorCode.ERROR;
        if (con == null || con.isClosed()) {
            con = DBConnection.getDBConnection();
        }
        try {
            if (con != null) {
                //code
                pstmt = con.prepareStatement("INSERT INTO workshops(workshopname,categorycode,workshopid,author,introduction,objectives,"
                        + "eventstatus,eventdetailspagepath,resourcepath,coursewarestatus,announcement,whoshouldattend,note,certificatepath,"
                        + "broucherpath,mailcontentpath,contact,schedulepath,sponsor,howtoapply,accomodation,coursefee,teachingfaculty,durationandvenue,"
                        + "lastdateforappli,startdate,enddate,startdateofappli,contentupdate,permissionletter,eligibility,respective_coordinatorid,permission_letter_ifrequired,"
                        + " accomodation_ifavailable, LMS_Moodle, LMS_IITBx, IITBx_coursename,Moodle_coursename, certificate_institute_wise,certificate_rc_wise, instructions, "
                        + "certificate_criteria, feeamount,datetobedisplayed, rc_payment_if_required, iitb_payment_if_required, without_RC, withdrawal_button_tbd )"
                        + " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,false,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                String eventstatus = null;
                String startdate = content.getStartdate();
                String enddate = content.getEnddate();
                String lastdate = content.getLastdatereg();
                String startdateofreg = content.getStartdatereg();
                DateFormat userDateFormat = new SimpleDateFormat("dd-mm-yyyy");
                DateFormat dateFormatNeeded = new SimpleDateFormat("yyyy-mm-dd");
                Date date = userDateFormat.parse(startdate);
                String startdate1 = dateFormatNeeded.format(date);
                Date date1 = userDateFormat.parse(enddate);
                String enddate1 = dateFormatNeeded.format(date1);
                Date date2 = userDateFormat.parse(lastdate);
                String lastdate1 = dateFormatNeeded.format(date2);
                Date date3 = userDateFormat.parse(startdateofreg);
                String startdateofreg1 = dateFormatNeeded.format(date3);
                Calendar calender1 = Calendar.getInstance();
                calender1.setTime(date1);
                calender1.add(Calendar.MONTH, 1);
                java.util.Date now = new java.util.Date();
                Calendar calender3 = Calendar.getInstance();
                Calendar calender2 = Calendar.getInstance();
                calender3.setTime(date2);
                calender2.setTime(now);
                boolean sameDay = calender3.get(Calendar.YEAR) == calender2.get(Calendar.YEAR)
                        && calender3.get(Calendar.DAY_OF_YEAR) == calender3.get(Calendar.DAY_OF_YEAR);
                if (sameDay == true) {
                    eventstatus = "ForthComing";
                } else if (date2.after(now)) {
                    eventstatus = "Forthcoming";
                } else if (date2.before(now)) {
                    eventstatus = "RegistrationClosed";
                } else if (calender1.getTime().after(now)) {
                    eventstatus = "Completed";
                }

                String eventDetailsPath = content.getResourcepath();
                String resourcePath = content.getResourcepath();
                String brochurepath = "brouchure_" + content.getWorkshopid() + ".pdf";
                String mailcontentpath = "successMail_" + content.getWorkshopid() + ".html";
                String permissionletter = "permissionLetter_" + content.getWorkshopid() + ".pdf";
                String eligibility = "eligibility_" + content.getWorkshopid() + ".pdf";

                pstmt.setString(1, content.getWorkshopname());
                pstmt.setInt(2, content.getCategorycode());
                pstmt.setInt(3, content.getWorkshopid());
                pstmt.setString(4, content.getAuthor());
                pstmt.setString(5, content.getIntroduction());
                pstmt.setString(6, content.getObjectives());
                pstmt.setString(7, eventstatus);
                pstmt.setString(8, eventDetailsPath);
                pstmt.setString(9, resourcePath);
                pstmt.setString(10, content.getCoursewarestatus());
                pstmt.setString(11, content.getAnnouncement());
                pstmt.setString(12, content.getWhoshouldattend());
                pstmt.setString(13, content.getNote());
                pstmt.setString(14, content.getCertificatepath());
                pstmt.setString(15, brochurepath);
                pstmt.setString(16, mailcontentpath);
                pstmt.setString(17, content.getContact());
                pstmt.setString(18, brochurepath);
                pstmt.setString(19, content.getSponsor());
                pstmt.setString(20, content.getHowtoapply());
                pstmt.setString(21, content.getAccomodation());
                pstmt.setString(22, content.getCoursefee());
                pstmt.setString(23, content.getTeachingfaculty());
                pstmt.setString(24, content.getDurationvenue());
                pstmt.setString(25, lastdate1);
                pstmt.setString(26, startdate1);
                pstmt.setString(27, enddate1);
                pstmt.setString(28, startdateofreg1);
                pstmt.setString(29, permissionletter);
                pstmt.setString(30, eligibility);
                pstmt.setInt(31, content.getRespectiveCoWorkshopid());
                pstmt.setInt(32, content.getPermissionIfRequired());
                pstmt.setInt(33, content.getAccommodation());
                pstmt.setInt(34, content.getLms_moodle());
                pstmt.setInt(35, content.getLms_iitbx());
                pstmt.setString(36, content.getIitbx_coursename());
                pstmt.setString(37, content.getMoodle_coursename());
                pstmt.setInt(38, content.getCertificateGroupInstitute());
                pstmt.setInt(39, content.getCertificateGroupRC());
                pstmt.setString(40, content.getInstructions());
                pstmt.setString(41, content.getCertificateCriteria());
                if (content.getCategorycode() == 8) {
                    pstmt.setString(42, content.getFeeAmount());
//                    content.setPayment_at_iitb(1);
                } else {
                    pstmt.setString(42, null);
                }
                pstmt.setInt(43, content.getDateToBeDisplayed());

                pstmt.setInt(44, content.getPayment_at_rc());
                pstmt.setInt(45, content.getPayment_at_iitb());
                pstmt.setInt(46, content.getWithout_RC());
                pstmt.setInt(47, content.getWithdrawal_flag());

                isInserted = pstmt.executeUpdate();

                // call function for updating workshop coordinators table - updating attendance 
                if (content.getRespectiveCoWorkshopid() != 0) {
                    pstmt = con.prepareStatement("insert into workshop_coordinator (workshopid,rcid,email,contextid) select ? as workshopid,a.instituteid,c.email,c.idcontext  from accomodation a, context c, participant p where a.participantid=p.participantid and p.contextid=c.idcontext and p.status IN ('Confirmed' , 'Completed') and  a.workshopid= ?");
                    pstmt.setInt(1, content.getWorkshopid());
                    pstmt.setInt(2, content.getRespectiveCoWorkshopid());
                    pstmt.executeUpdate();
                }
            }
        } catch (Exception sqle) {
            isInserted = ErrorCode.SQLEXCEPTION;
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return isInserted;
    }

    /**
     *
     * @param content
     * @return
     * @throws Exception
     */
    public synchronized int UpdateWorkshop(WorkshopContent content) throws Exception {
        int isInserted = ErrorCode.ERROR;
        int categorycode = 0;
        if (con == null || con.isClosed()) {
            con = DBConnection.getDBConnection();
        }
        try {
            if (con != null) {
                String eventstatus = null;
                String startdate = content.getStartdate();
                String enddate = content.getEnddate();
                String lastdate = content.getLastdatereg();
                String startdateofreg = content.getStartdatereg();
                DateFormat userDateFormat = new SimpleDateFormat("dd-mm-yyyy");
                DateFormat dateFormatNeeded = new SimpleDateFormat("yyyy-mm-dd");
                Date date = userDateFormat.parse(startdate);
                String startdate1 = dateFormatNeeded.format(date);
                Date date1 = userDateFormat.parse(enddate);
                String enddate1 = dateFormatNeeded.format(date1);
                Date date2 = userDateFormat.parse(lastdate);
                String lastdate1 = dateFormatNeeded.format(date2);
                Date date3 = userDateFormat.parse(startdateofreg);
                String startdateofreg1 = dateFormatNeeded.format(date3);
                Calendar calender1 = Calendar.getInstance();
                calender1.setTime(date1);
                calender1.add(Calendar.MONTH, 1);
                java.util.Date now = new java.util.Date();
                Calendar calender3 = Calendar.getInstance();
                Calendar calender2 = Calendar.getInstance();
                calender3.setTime(date2);
                calender2.setTime(now);
                boolean sameDay = calender3.get(Calendar.YEAR) == calender2.get(Calendar.YEAR)
                        && calender3.get(Calendar.DAY_OF_YEAR) == calender3.get(Calendar.DAY_OF_YEAR);
                if (sameDay == true) {
                    eventstatus = "ForthComing";
                } else if (date2.after(now)) {
                    eventstatus = "Forthcoming";
                } else if (date2.before(now)) {
                    eventstatus = "RegistrationClosed";
                } else if (calender1.getTime().after(now)) {
                    eventstatus = "Completed";
                }

                String eventDetailsPath = content.getResourcepath();
                String resourcePath = content.getResourcepath();
                String brochurepath = "brouchure_" + content.getWorkshopid() + ".pdf";
                String mailcontentpath = "successMail_" + content.getWorkshopid() + ".html";
                String permissionletter = "permissionLetter_" + content.getWorkshopid() + ".pdf";
                String eligibility = "eligibility_" + content.getWorkshopid() + ".pdf";

                int res_co_id = content.getRespectiveCoWorkshopid();

                pstmt = con.prepareStatement(" Update workshops set "
                        + "workshopname=?,"
                        + "workshopid=?, "
                        + "author=?, "
                        + "introduction=?, "
                        + "objectives=?, "
                        + "startdate=?,"
                        + "enddate=?, "
                        + "eventdetailspagepath=?, "
                        + "resourcepath=?, "
                        + "coursewarestatus=?,"
                        + "announcement=?,"
                        + "whoshouldattend=?, "
                        + "note=?, "
                        + "certificatepath=?,"
                        + "permissionletter=?, "
                        + "eligibility=?,"
                        + "broucherpath=?, "
                        + "mailcontentpath=?, "
                        + "contact=?,"
                        + "schedulepath=?, "
                        + "sponsor=?,"
                        + "howtoapply=?,"
                        + "accomodation=?,"
                        + "coursefee=?,"
                        + "teachingfaculty=?,"
                        + "durationandvenue=?,"
                        + "startdateofappli=?,"
                        + "lastdateforappli=?, "
                        + "respective_coordinatorid=? , "
                        + "permission_letter_ifrequired=?,"
                        + "accomodation_ifavailable=?, "
                        + "LMS_Moodle=?, "
                        + "LMS_IITBx=?, "
                        + "IITBx_coursename=?,"
                        + "Moodle_coursename=?, "
                        + "certificate_institute_wise=?, "
                        + "certificate_rc_wise=? ,"
                        + "instructions=?, "
                        + "certificate_criteria=?, "
                        + "feeamount=?, "
                        + "datetobedisplayed=?, "
                        + "rc_payment_if_required=?, "
                        + "iitb_payment_if_required=?, "
                        + "without_RC=?, "
                        + "withdrawal_button_tbd = ? "
                        + " where workshopid= ? ");
                pstmt.setString(1, content.getWorkshopname());
                pstmt.setInt(2, content.getWorkshopid());
                pstmt.setString(3, content.getAuthor());
                pstmt.setString(4, content.getIntroduction());
                pstmt.setString(5, content.getObjectives());
                pstmt.setString(6, startdate1);
                pstmt.setString(7, enddate1);
                pstmt.setString(8, eventDetailsPath);
                pstmt.setString(9, resourcePath);
                pstmt.setString(10, content.getCoursewarestatus());
                pstmt.setString(11, content.getAnnouncement());
                pstmt.setString(12, content.getWhoshouldattend());
                pstmt.setString(13, content.getNote());
                pstmt.setString(14, content.getCertificatepath());
                pstmt.setString(15, permissionletter);
                pstmt.setString(16, eligibility);
                pstmt.setString(17, brochurepath);
                pstmt.setString(18, mailcontentpath);
                pstmt.setString(19, content.getContact());
                pstmt.setString(20, brochurepath);
                pstmt.setString(21, content.getSponsor());
                pstmt.setString(22, content.getHowtoapply());
                pstmt.setString(23, content.getAccomodation());
                pstmt.setString(24, content.getCoursefee());
                pstmt.setString(25, content.getTeachingfaculty());
                pstmt.setString(26, content.getDurationvenue());
                pstmt.setString(27, startdateofreg1);
                pstmt.setString(28, lastdate1);
                pstmt.setInt(29, content.getRespectiveCoWorkshopid());
                pstmt.setInt(30, content.getPermissionIfRequired());
                pstmt.setInt(31, content.getAccommodation());
                pstmt.setInt(32, content.getLms_moodle());
                pstmt.setInt(33, content.getLms_iitbx());
                pstmt.setString(34, content.getIitbx_coursename());
                pstmt.setString(35, content.getMoodle_coursename());
                pstmt.setInt(36, content.getCertificateGroupInstitute());
                pstmt.setInt(37, content.getCertificateGroupRC());
                pstmt.setString(38, content.getInstructions());
                pstmt.setString(39, content.getCertificateCriteria());
                if (Integer.parseInt(content.getCcpay().trim()) == 8) {
                    pstmt.setString(40, content.getFeeAmount());
                } else {
                    pstmt.setString(40, null);
                }
                pstmt.setInt(41, content.getDateToBeDisplayed());
                /* Setting payment options and setting if workshop withput RC - added on Aug 25 2016*/
                pstmt.setInt(42, content.getPayment_at_rc());
                pstmt.setInt(43, content.getPayment_at_iitb());
                pstmt.setInt(44, content.getWithout_RC());
                pstmt.setInt(45, content.getWithdrawal_flag());
                pstmt.setInt(46, content.getWorkshopid());
                isInserted = pstmt.executeUpdate();

                if (isInserted > 0) {
                    pstmt = con.prepareStatement("select categorycode from workshops where workshopid=?");
                    pstmt.setInt(1, content.getWorkshopid());
                    res = pstmt.executeQuery();
                    if (res.next()) {
                        categorycode = res.getInt("categorycode");
                    }
                }

                if (categorycode == 5 || categorycode == 7 || (categorycode == 8 && content.getWithout_RC() == 0)) {
                    // call function for updating workshop coordinators table - updating attendance 
                    if (res_co_id != 0) {
                        pstmt1 = con.prepareStatement("delete from workshop_coordinator where workshopid=?");
                        pstmt1.setInt(1, content.getWorkshopid());
                        pstmt1.execute();
                        pstmt2 = con.prepareStatement("insert into workshop_coordinator (workshopid,rcid,email,contextid) select ? as workshopid,a.instituteid,c.email,c.idcontext  from accomodation a, context c, participant p where a.participantid=p.participantid and p.contextid=c.idcontext and p.status IN ('Confirmed' , 'Completed') and  a.workshopid= ?");
                        pstmt2.setInt(1, content.getWorkshopid());
                        pstmt2.setInt(2, res_co_id);
                        pstmt2.executeUpdate();
                    }
                }

            }
        } catch (Exception sqle) {
            categorycode = ErrorCode.SQLEXCEPTION;
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return categorycode;
    }

    public int getLatestWorkshopid(int categorycode) {
        int workshopid = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (categorycode == 5 || categorycode == 4 || categorycode == 6 || categorycode == 7 || categorycode == 8) {
                    pstmt = con.prepareStatement("select IFNULL(max(workshopid),0) as workshopid from workshops where categorycode=?");
                    pstmt.setInt(1, categorycode);
                    res = pstmt.executeQuery();
                    if (res.next()) {
                        workshopid = res.getInt(1);
                        if (workshopid != 0) {
                            workshopid = workshopid + 1;
                        } else {
                            if (workshopid == 0 && categorycode == 6) {
                                workshopid = 600000;
                            }
                            if (workshopid == 0 && categorycode == 7) {
                                workshopid = 700000;
                            }
                            if (workshopid == 0 && categorycode == 8) {
                                workshopid = 800000;
                            }
                        }
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
        return workshopid;
    }

    public ArrayList<WorkshopContent> listRecentWorkshops() {
        ArrayList<WorkshopContent> recentWorkshops = new ArrayList<WorkshopContent>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                /* un comment this line later*/
                pstmt = con.prepareStatement("select workshopname,workshopid from workshops where (date_add(CURDATE(), interval 365 day) > startdate) and  (date_add(CURDATE(), interval -365 day) < enddate) order by workshops.startdate DESC");
//                pstmt = con.prepareStatement("select workshopname,workshopid from workshops order by workshops.startdate DESC");
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

    /**
     * This function returns the ArrayList of the announcement of the respective
     * announcement
     *
     * @return
     */
    public ArrayList<Announcements> getAnnouncementData(String Announcement) throws Exception {
        ArrayList<Announcements> announcement = new ArrayList<Announcements>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                int announ_id = Integer.parseInt(Announcement);
                pstmt = con.prepareStatement("select announcementid,announcement,link,DATE_FORMAT( startdate, '%d-%m-%Y' ) AS stardate1, DATE_FORMAT( enddate, '%d-%m-%Y' ) AS enddate1,location,visible from announcement where announcementid = ?");
                pstmt.setInt(1, announ_id);
                res = pstmt.executeQuery();
                Announcements announcementContent = null;
                while (res.next()) {
                    announcementContent = new Announcements();
                    /**
                     * setting
                     * announcement,announcementid,link,startdate,enddate,location
                     * to Announcement bean object
                     */
                    announcementContent.setAnnouncementid(res.getInt("announcementid"));
                    announcementContent.setAnnouncement(res.getString("announcement"));
                    announcementContent.setLink(res.getString("link"));
                    announcementContent.setStartdate(res.getString("stardate1"));
                    announcementContent.setEnddate(res.getString("enddate1"));
                    // announcementContent.setStartdate(res.getDate("startdate"));
                    //  announcementContent.setEnddate(res.getDate("enddate"));
                    announcementContent.setLocation(res.getString("location"));
                    announcementContent.setVisible(res.getString("visible"));
                    /**
                     * adding announcement bean object to Arraylist
                     */
                    announcement.add(announcementContent);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return announcement;
    }

    /**
     * @param annnouncement,link,startdate,enddate,location,type,announcementid
     * This function will insert the new announcement to announcement table of
     * database. and return the result as integer.
     * @return
     */
    // insertAnnouncement(Announcements announcement)
    // public synchronized int insertAnnouncement(String announcement, String link, String startdate, String enddate, String location, int type, int announcementid) throws Exception {
    public synchronized int insertAnnouncement(Announcements announcement) throws Exception {
        PreparedStatement pstmt1 = null;
        ResultSet rs = null;
        int a_announcementid = 0;
        int result = 0;
        int announcement_type = 0;

        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                announcement_type = announcement.getType();
                /**
                 * if announcement type is 0 then it will get the max
                 * announcementid from announcement table
                 */
                if (announcement_type == 0) {
                    try {
                        pstmt1 = con.prepareStatement("select max(announcementid)  as announcementid from announcement where type = 0");
                        rs = pstmt1.executeQuery();
                        while (rs.next()) {
                            a_announcementid = rs.getInt("announcementid");
                            a_announcementid++;
                        }
                    } catch (SQLException sqle) {
                        sqle.printStackTrace();
                    } finally {
                        pstmt1.close();
                        rs.close();
                    }
                } else if (announcement_type > 0) {
                    a_announcementid = announcement.getAnnouncementid();
                }
                if (a_announcementid != 0) {
                    int checkResult = 0;
                    try {
                        /**
                         * checking if same announcement is in database
                         */
                        //    checkResult = checkAnnouncement(announcement.getAnnouncement());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if (checkResult == 0) {
                        pstmt = con.prepareStatement("insert into announcement(announcement,link,startdate,enddate,location,announcementid,type,status, visible) values(?,?,?,?,?,?,?,?,?)");
                        /**
                         * setting
                         * announcement,link,startdate,enddate,location,a_annnouncementid
                         * to prepared statement object
                         */
                        pstmt.setString(1, announcement.getAnnouncement());
                        pstmt.setString(2, announcement.getLink());
                        /**
                         * converting stardate, enddate to mysqldate format that
                         * is from dd-MM-yyyy to yyyy-MM-dd format we use the
                         * simpleDateFormat
                         */
                        SimpleDateFormat from = new SimpleDateFormat("dd-MM-yyyy");
                        SimpleDateFormat to = new SimpleDateFormat("yyyy-MM-dd");
                        /**
                         * parsing the stardate, enddate for date format
                         */
                        Date sdate = from.parse(announcement.getStartdate());
                        Date edate = from.parse(announcement.getEnddate());
                        /**
                         * setting formatted date in mysqlStartdate,
                         * mysqlEnddate param
                         */
                        String mysqlStartdate = to.format(sdate);
                        String mysqlEnddate = to.format(edate);
                        pstmt.setString(3, mysqlStartdate);
                        pstmt.setString(4, mysqlEnddate);
                        pstmt.setString(5, announcement.getLocation());
                        pstmt.setInt(6, a_announcementid);
                        pstmt.setInt(7, announcement_type);
                        pstmt.setString(8, announcement.getStatus());
                        pstmt.setString(9, announcement.getVisible());
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
     * @param announcement,link,startdate,endate,location this function is used
     * to update the announcement,link,startdate,enddate,location to
     * announcement table of databases on the bases of announcementid
     * @return if update successful then it will return result as = 1 else it
     * will return result as 0
     */
    // public synchronized int updateAnnouncement(String announcement, String link, String startdate, String enddate, String location, int announcementid) throws Exception {
    public synchronized int updateAnnouncement(Announcements announcement) throws Exception {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("update announcement set announcement = ?,link= ?, startdate = ?,enddate = ?,location = ? , visible=?  where announcementid = ?");
                /**
                 * setting param to preparedStatament object
                 */
                pstmt.setString(1, announcement.getAnnouncement());
                pstmt.setString(2, announcement.getLink());
                /**
                 * converting stardate, enddate to mysqldate format that is from
                 * dd-MM-yyyy to yyyy-MM-dd format we use the simpleDateFormat
                 */
                SimpleDateFormat from = new SimpleDateFormat("dd-MM-yyyy");
                SimpleDateFormat to = new SimpleDateFormat("yyyy-MM-dd");
                /**
                 * parsing the stardate, enddate for date format
                 */
                Date sdate = from.parse(announcement.getStartdate());
                Date edate = from.parse(announcement.getEnddate());
                /**
                 * setting formatted date in mysqlStartdate, mysqlEnddate param
                 */
                String mysqlStartdate = to.format(sdate);
                String mysqlEnddate = to.format(edate);
                pstmt.setString(3, mysqlStartdate);
                pstmt.setString(4, mysqlEnddate);
                pstmt.setString(5, announcement.getLocation());
                pstmt.setString(6, announcement.getVisible());
                pstmt.setInt(7, announcement.getAnnouncementid());
                result = pstmt.executeUpdate();
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
     * @param Announcement this method is checking the respective announcement
     * is present in announcement table of database
     * @return int result
     */
    public int checkAnnouncement(String Announcement) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select announcement from announcement where announcement = ?");
                pstmt.setString(1, Announcement);
                res = pstmt.executeQuery();
                while (res.next()) {
                    String val = res.getString("announcement");
                    val = val.trim();
                    if (val != null || val != "") {
                        result = 1;
                        /**
                         * result is set as 1 if announcement is match else it
                         * will set to 0
                         */
                    } else {
                        // result =0;
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
     * @param Announcement this method is checking the respective announcement
     * is present in announcement table of database
     * @return int result
     */
    public String checkIfAnnouncementVisible(String Announcementid) {
        String result = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select visible from announcement where announcementid = ?");
                pstmt.setString(1, Announcementid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    result = res.getString("visible");
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

    public ArrayList<WorkshopContent> listMainWorkshopId() throws Exception {
        ArrayList<WorkshopContent> workshopid = new ArrayList<WorkshopContent>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                // pstmt = con.prepareStatement("select workshopid, workshopname from workshops where categorycode=5 order by workshopid");
                pstmt = con.prepareStatement("select workshopid, workshopname, categorycode, without_RC from workshops where (categorycode = 5 or categorycode = 7 or categorycode = 8) order by startdate desc;");
                res = pstmt.executeQuery();
                WorkshopContent content = null;
                while (res.next()) {
                    content = new WorkshopContent();
                    content.setWorkshopid(res.getInt("workshopid"));
                    content.setWorkshopname(res.getString("workshopname"));
                    content.setCategorycode(res.getInt("categorycode"));
                    content.setWithout_RC(res.getInt("without_RC"));
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    content.setWorkshopid_encrypted(cipher.encrypt(res.getString("workshopid")));
                    workshopid.add(content);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return workshopid;
    }

    public ArrayList<RemoteCenterCapacity> rccDetails(int workshopid, int state) throws Exception {
        ArrayList<RemoteCenterCapacity> remotecenterCapacity = new ArrayList<RemoteCenterCapacity>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query = "";
                if (state == 0) {
                    query = "select c.rcid, r.remotecentername , c.available_seats, c.available_accomo,c.workshopid, ci.city, s.state, c.acco_cost, c.food_cost from remotecenter r , remotecentercapacity c, city ci, state s where r.state=s.stateid and r.remotecenterid = c.rcid and workshopid = ? and ci.cityid=r.city  order by c.rcid ";
                    pstmt = con.prepareStatement(query);
                    pstmt.setInt(1, workshopid);
                } else {
                    query = "select c.rcid, r.remotecentername , c.available_seats, c.available_accomo,c.workshopid, ci.city, s.state, c.acco_cost, c.food_cost from remotecenter r , remotecentercapacity c, city ci, state s where r.state=s.stateid and r.remotecenterid = c.rcid and workshopid = ? and r.state=? and ci.cityid=r.city order by c.rcid ";
                    pstmt = con.prepareStatement(query);
                    pstmt.setInt(1, workshopid);
                    pstmt.setInt(2, state);
                }

                res = pstmt.executeQuery();
                RemoteCenterCapacity rccContent = null;
                while (res.next()) {
                    rccContent = new RemoteCenterCapacity();
                    rccContent.setRcid(res.getInt("rcid"));
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String rcc_enc = cipher.encrypt(res.getString("rcid"));
                    rccContent.setRcid_enc(rcc_enc);
                    rccContent.setAvailable_accomo(res.getInt("available_accomo"));
                    rccContent.setAvailable_seats(res.getInt("available_seats"));
                    rccContent.setRemotecentername(res.getString("remotecentername") + ", " + res.getString("city"));
                    rccContent.setState(res.getString("state"));
                    rccContent.setWorkshopid(res.getInt("workshopid"));
                    rccContent.setAcco_cost(res.getString("acco_cost"));
                    rccContent.setFood_cost(res.getString("food_cost"));
                    // query added by abinaya to set the seats booked and remaining
                    pstmt1 = con.prepareStatement("select count( a.participantid ) as booked_seats , (select count( a.participantid ) from accomodation a, participant p  where a.participantid=p.participantid and p.status !='Cancelled' and a.instituteid=? and a.workshopid =? and a.accomodation = 'Yes') as booked_acc from accomodation a, participant p where a.participantid=p.participantid and p.status != 'Cancelled' and a.instituteid=? and a.workshopid =?");
                    pstmt1.setInt(1, res.getInt("rcid"));
                    pstmt1.setInt(2, workshopid);
                    pstmt1.setInt(3, res.getInt("rcid"));
                    pstmt1.setInt(4, workshopid);
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        rccContent.setSeats_booked(res1.getInt(1));
                        rccContent.setAccomo_booked(res1.getInt(2));
                        int seats_remaining = res.getInt("available_seats") - res1.getInt(1);
                        if (seats_remaining < 0) {
                            rccContent.setSeats_remaining(0);
                        } else {
                            rccContent.setSeats_remaining(seats_remaining);
                        }
                    }

                    remotecenterCapacity.add(rccContent);
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
        return remotecenterCapacity;
    }

    public synchronized int updateRemoteCenterCapacity(RemoteCenterCapacity rcc) {
        int updated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating query for updating the remote center capacity.
                pstmt = con.prepareStatement("update remotecentercapacity set available_seats = ? , available_accomo = ?, acco_cost=?, food_cost=? where rcid = ? and workshopid = ?");
                pstmt.setInt(1, rcc.getAvailable_seats());
                pstmt.setInt(2, rcc.getAvailable_accomo());
                pstmt.setString(3, rcc.getAcco_cost());
                pstmt.setString(4, rcc.getFood_cost());
                pstmt.setInt(5, rcc.getRcid());
                pstmt.setInt(6, rcc.getWorkshopid());
                updated = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return updated;
    }

    /**
     *
     * @return
     */
    public ArrayList<RemoteCenter> listRC() throws Exception {
        ArrayList<RemoteCenter> rcList = new ArrayList<RemoteCenter>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select r.remotecenterid,r.remotecentername,c.city,s.state,r.active, r.pincode, r.district, IFNULL(r.email,'') as email, IFNULL(r.status,'') as status, r.Instituteid, i.Institutename, r.autonomous, IFNULL(r.acd_cal_startdate,'') as acd_cal_startdate, IFNULL(affiliated_university,'') as affiliated_university from remotecenter r left join city c on r.city=c.cityid left join state s on s.stateid=r.state left join institute i on i.idInstitute=r.Instituteid order by sign(remotecenterid) desc,abs(remotecenterid)");
                //pstmt.setInt(1, state);
                res = pstmt.executeQuery();
                RemoteCenter rc = null;
                while (res.next()) {
                    rc = new RemoteCenter();
                    rc.setRemoteCenterId(res.getInt("remotecenterid"));
                    rc.setRemoteCenterName(res.getString("remotecentername"));
                    rc.setIsActive(res.getBoolean("active"));
                    rc.setIsactive(res.getInt("active"));
                    rc.setRc_city(res.getString("city"));
                    rc.setRc_state(res.getString("state"));
                    rc.setPincode(res.getInt("pincode"));
                    rc.setDistrict(res.getString("district"));
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String rc_enc = cipher.encrypt(res.getString("remotecenterid"));
                    rc.setRc_enc(rc_enc);
                    rc.setRc_coordinator_email(res.getString("email"));
                    rc.setRc_status(res.getString("status"));
                    //institute details
                    rc.setRes_instituteid(res.getInt("Instituteid"));
                    rc.setInstituteName(res.getString("institutename"));

                    // autonomous and academic cal startdate
                    rc.setRc_autonomous(res.getString("autonomous"));
                    rc.setAcademic_cal(res.getString("acd_cal_startdate"));
                    rc.setAffiliated_university(res.getString("affiliated_university"));
                    rcList.add(rc);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return rcList;
    }

    public String updateParticipantStatus(String participantid, String status) {
        int updated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating query for updating the remote center capacity.
                pstmt = con.prepareStatement("update participant set status = ? where participantid = ?");
                pstmt.setString(1, status);
                pstmt.setString(2, participantid);
                updated = pstmt.executeUpdate();

                if (updated > 0 && status.equals("Cancelled")) {
                    // update attendance sheet if any
                    pstmt = con.prepareStatement("delete from attendance where participantid=?");
                    pstmt.setString(1, participantid);
                    pstmt.executeUpdate();
                }

            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        if (updated > 0) {
            return status;
        } else {
            return "notupdated";
        }
    }
//  function commented by Abinaya
//    /**
//     * this method will update the participant status of particular participant
//     *
//     * @param status
//     * @param email
//     * @param workshopid
//     * @return
//     */
//    public int updateParticipantStatus(String status, String email, int workshopid) {
//        int update = 0;
//        String p_status = "";
//        int p_id = 0, c_id = 0;
//        PreparedStatement pstmt2 = null;
//        try {
//            if (con == null || con.isClosed()) {
//                con = DBConnection.getDBConnection();
//            }
//            if (con != null) {
//                /**
//                 * coding for update participant status first we get the
//                 * participantid from participant table to update particular
//                 * participant status
//                 */
//                String query = "select p.participantid,p.status,p.contextid from participant p,context c,accomodation m where c.idcontext=p.contextid and p.participantid=m.participantid and m.workshopid=? and c.email=?;";
//                pstmt = con.prepareStatement(query);
//                pstmt.setInt(1, workshopid);
//                pstmt.setString(2, email);
//                res = pstmt.executeQuery();
//                while (res.next()) {
//                    p_id = res.getInt("p.participantid");
//                    p_status = res.getString("p.status");
//                    c_id = res.getInt("p.contextid");
//                }
//                /**
//                 * setting status on p_status param
//                 */
//                try {
//                    if (status.equals("Approved")) {
//                        p_status = "Request Approved";
//                    } else if (status.equals("Invalid")) {
//                        p_status = "Registration Invalid";
//                    } else if (status.equals("Confirmed")) {
//                        p_status = "Confirmed";
//                    } else if (status.equals("Canceled")) {
//                        p_status = "Cancelled";
//                    }
//                    if (p_id != 0) {
//                        /**
//                         * if participant id is not 0 then it will update the
//                         * status of participant
//                         */
//                        pstmt2 = con.prepareStatement("update participant set status=? where participantid=?");
//                        pstmt2.setString(1, p_status);
//                        pstmt2.setInt(2, p_id);
//                        update = pstmt2.executeUpdate();
//                    }
//                } catch (Exception e) {
//                } finally {
//                    pstmt2.close();;
//                }
//            }
//        } catch (SQLException sqle) {
//            sqle.printStackTrace();
//        } finally {
//            DBConnection.closeResultSet(res);
//            DBConnection.closePStatement(pstmt);
//            DBConnection.closeDBConnection(con);
//        }
//        return update;
//    }

    public int getUserIdOfParticipant(String email) {
        int id = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select idcontext from context where email=?");
                pstmt.setString(1, email);
                res = pstmt.executeQuery();
                while (res.next()) {
                    id = res.getInt("idcontext");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return id;
    }

    public synchronized int insertRemoteCenterCapacity(RemoteCenterCapacity rcc) {
        int updated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating query for updating the remote center capacity.
                pstmt = con.prepareStatement("insert into remotecentercapacity(rcid,workshopid,available_seats,available_accomo, enrolled_status,acco_cost, food_cost) values(?,?,?,?,?,?,?)");
                pstmt.setInt(1, rcc.getRcid());
                pstmt.setInt(2, rcc.getWorkshopid());
                pstmt.setInt(3, rcc.getAvailable_seats());
                pstmt.setInt(4, rcc.getAvailable_accomo());
                pstmt.setString(5, "N");
                pstmt.setString(6, rcc.getAcco_cost());
                pstmt.setString(7, rcc.getFood_cost());
                updated = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return updated;
    }

    /**
     * this method will get the participant status of a particular participant
     *
     * @param participantid
     * @return
     */
    public String getParticipantStatus(int participantid) {
        String status = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                /**
                 * getting status of particular participant
                 */
                pstmt = con.prepareStatement("select status from participant where participantid = ?");
                pstmt.setInt(1, participantid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    /**
                     * setting the value in status param
                     */
                    status = res.getString("status");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return status;
    }

    /**
     * this method will update the participant letter for particular participant
     * and no of times letter updated
     *
     * @param participant
     * @param workshopcontent
     * @return
     */
    public int updateParticipantLetter(Participant participant, WorkshopContent workshopcontent) {
        int result = 0;
        int verified = 0;
        PreparedStatement pstmt1 = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                /**
                 * update query for updating letter of participant
                 */
                pstmt = con.prepareStatement("update letter set letter=? where participantid=? and workshopid=?");
                /**
                 * setting letter in format of
                 * permissionLetter_participantid.jpg
                 */
                pstmt.setString(1, "permissionLetter_" + participant.getParticipantid() + ".jpg");
                pstmt.setInt(2, participant.getParticipantid());
                pstmt.setInt(3, workshopcontent.getWorkshopid());
                result = pstmt.executeUpdate();
                /**
                 * if letter updated successfull then updating the no. of times
                 * the letter updated by participant for that we increment the
                 * verified column of letter table
                 *
                 */
                if (result > 0) {
                    try {
                        /**
                         * getting the value of verified that is already how
                         * many times letter uploaded
                         */
                        pstmt1 = con.prepareStatement("select verified from letter where participantid=?");
                        pstmt1.setInt(1, participant.getParticipantid());
                        res = pstmt1.executeQuery();
                        while (res.next()) {
                            verified = res.getInt("verified");
                            /**
                             * incrementing the verified param
                             */
                            verified++;
                            /**
                             * updating the verified in letter table
                             */
                            pstmt1 = con.prepareStatement("update letter set verified=? where participantid=?");
                            pstmt1.setInt(1, verified);
                            pstmt1.setInt(2, participant.getParticipantid());
                            int res = pstmt1.executeUpdate();
                            if (res > 0) {
                                /**
                                 * setting verified value in result param
                                 */
                                result = verified;
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        pstmt1.close();
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }

    /**
     * this method will get the email of particular participant
     *
     * @param participant
     * @return
     */
    public String getEmailOfParticipant(Participant participant) {
        String email = null;
        int cid = 0;
        PreparedStatement pstmt1 = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select contextid from participant where participantid=?");
                pstmt.setInt(1, participant.getParticipantid());
                res = pstmt.executeQuery();
                while (res.next()) {
                    cid = res.getInt("contextid");
                }
                if (cid > 0) {
                    try {
                        pstmt1 = con.prepareStatement("select email from context where idcontext=?");
                        pstmt1.setInt(1, cid);
                        res = pstmt1.executeQuery();
                        while (res.next()) {
                            email = res.getString("email");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        pstmt1.close();
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return email;
    }

    /**
     * this method will get the name(firstname and lastname) of particular
     * participant
     *
     * @param email
     * @return
     */
    public String getNameOfParticipant(String email) {
        String name = "";
        int cid = 0;
        PreparedStatement pstmt1 = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select idcontext from context where email=?");
                pstmt.setString(1, email);
                res = pstmt.executeQuery();
                while (res.next()) {
                    cid = res.getInt("idcontext");
                }
                if (cid > 0) {
                    try {
                        pstmt1 = con.prepareStatement("select firstname,lastname from person where personid=?");
                        pstmt1.setInt(1, cid);
                        res = pstmt1.executeQuery();
                        while (res.next()) {
                            name = res.getString("firstname") + " " + res.getString("lastname");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        pstmt1.close();
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return name;
    }

    public int checkRemoteCenterCapacity(int workshopid, int rcid) {
        int updated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating query for updating the remote center capacity.
                pstmt = con.prepareStatement("select rcid,workshopid from remotecentercapacity where rcid = ? and workshopid = ?");
                pstmt.setInt(1, rcid);
                pstmt.setInt(2, workshopid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    int result = 0;
                    result = res.getInt("rcid");
                    if (result > 0) {
                        updated = 1;
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
        return updated;
    }

    public ArrayList<Institute> listPersonInstitute(int cityid, int instituteid) {
        ArrayList<Institute> institutes = new ArrayList<Institute>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select idInstitute,Institutename,address, pincode from institute where city=? and isActive =1 or idInstitute=? order by Institutename");
                pstmt.setInt(1, cityid);
                pstmt.setInt(2, instituteid);

                res = pstmt.executeQuery();
                Institute institute = null;
                while (res.next()) {
                    institute = new Institute();
                    institute.setInstituteId(res.getInt("idInstitute"));
                    institute.setInstituteName(res.getString("Institutename"));
                    institute.setInstituteAddress(res.getString("address"));
                    institute.setPincode(res.getInt("pincode"));
                    institutes.add(institute);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return institutes;
    }

    public ArrayList<Institute> listInstitute(int cityid) {
        ArrayList<Institute> institutes = new ArrayList<Institute>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select idInstitute,Institutename,address, pincode from institute where city=? and isActive =1 order by Institutename");
                pstmt.setInt(1, cityid);
                res = pstmt.executeQuery();
                Institute institute = null;
                while (res.next()) {
                    institute = new Institute();
                    institute.setInstituteId(res.getInt("idInstitute"));
                    institute.setInstituteName(res.getString("Institutename"));
                    institute.setInstituteAddress(res.getString("address"));
                    institute.setPincode(res.getInt("pincode"));
                    institutes.add(institute);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return institutes;
    }

    /*
     * returns inactive institutes as well. for back end
     */
    public ArrayList<Institute> listInstitute1(int cityid) {
        ArrayList<Institute> institutes = new ArrayList<Institute>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select idInstitute,Institutename,address, pincode from institute where city=?  order by Institutename");
                pstmt.setInt(1, cityid);
                res = pstmt.executeQuery();
                Institute institute = null;
                while (res.next()) {
                    institute = new Institute();
                    institute.setInstituteId(res.getInt("idInstitute"));
                    institute.setInstituteName(res.getString("Institutename"));
                    institute.setInstituteAddress(res.getString("address"));
                    institute.setPincode(res.getInt("pincode"));
                    institutes.add(institute);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return institutes;
    }

    public String getFirstName(String email) {
        String name = "";
        int cid = 0;
        PreparedStatement pstmt1 = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select idcontext from context where email=?");
                pstmt.setString(1, email);
                res = pstmt.executeQuery();
                while (res.next()) {
                    cid = res.getInt("idcontext");
                }
                if (cid > 0) {
                    try {
                        //pstmt1 = con.prepareStatement("select firstname from person where personid=?");
                        // concating firstname with lastname
                        pstmt1 = con.prepareStatement("select concat(ifnull(firstname,''),' ',ifnull(lastname,'')) as firstname from person where personid=?");
                        pstmt1.setInt(1, cid);
                        res = pstmt1.executeQuery();
                        while (res.next()) {
                            name = res.getString("firstname");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        pstmt1.close();
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return name;
    }

    /**
     *
     * @return
     */
    public int setQuery(String workshopid, String categorycode, String rcid, String context, String res_coid) {
        int count = 0;
        String query;
        ExcelSheet excel = new ExcelSheet();
        try {
            if (categorycode.equals("5") || categorycode.equals("7") || categorycode.equals("8")) {
                if (!rcid.equals("all")) {
//                    query = "SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,c.homephone,  p.qualification, p.experience,a.accomodation, CONCAT(r.remotecentername,',',ci.city) as center ,i.institutename, p.status, s.state, ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid='" + workshopid + "' and a.instituteid='" + rcid + "' order by p.regtime";
                    query = "select a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,IFNULL(i.idInstitute,'') as InstituteId ,i.institutename, IFNULL(i.address,'') as Institute_Address, IFNULL(i.pincode, '') as Institute_Pincode, CONCAT(r.remotecentername,',',ci.city) as remotecentername , r.remotecenterid, s.state,  ci.city,a.accomodation,  p.status,d.designation, p.qualification, st.stream_name,   p.experience, c.homephone, l.letter, p.regtime from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid='" + workshopid + "' and a.instituteid='" + rcid + "' order by p.regtime";
                } else {
//                    query = "SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,c.homephone,  p.qualification, p.experience,a.accomodation, CONCAT(r.remotecentername,',',ci.city) as center,i.institutename, p.status, s.state, ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid='" + workshopid + "' order by p.regtime";
                    query = "select a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, IFNULL(i.idInstitute,'') as InstituteId, i.institutename,IFNULL(i.address,'') as Institute_Address, IFNULL(i.pincode, '') as Institute_Pincode, CONCAT(r.remotecentername,',',ci.city) as remotecentername , r.remotecenterid, s.state,  ci.city,a.accomodation,  p.status,d.designation, p.qualification, st.stream_name,   p.experience, c.homephone, l.letter, p.regtime from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid='" + workshopid + "' order by p.regtime";
                }
            } else {
//                if (Integer.parseInt(res_coid) == 0) {
//                    query = "SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, c.homephone, p.qualification, p.experience,a.accomodation, r.remotecentername as center , p.status, s.state, ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name  FROM accomodation a   left join  participant p on p.participantid=a.participantid  left join  person per on per.personid=p.personid  left join context  c on p.contextid=c.idcontext  left join  letter l on l.participantid=p.participantid  left join remotecenter r on a.instituteid=r.remotecenterid  left join designation d on d.iddesignation=per.designation left join state s on  s.stateid=r.state  left join city ci on ci.cityid=r.city  left join stream st on p.streamid=st.idstream  where  a.workshopid='" + workshopid + "' order by p.regtime";
//                    query = "select a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, i.institutename, CONCAT(r.remotecentername,',',ci.city) as remotecentername , r.remotecenterid, s.state,  ci.city,a.accomodation,  p.status,d.designation, p.qualification, st.stream_name,   p.experience, c.homephone, l.letter, p.regtime  FROM accomodation a   left join  participant p on p.participantid=a.participantid  left join  person per on per.personid=p.personid  left join context  c on p.contextid=c.idcontext  left join  letter l on l.participantid=p.participantid  left join remotecenter r on a.instituteid=r.remotecenterid  left join designation d on d.iddesignation=per.designation left join state s on  s.stateid=r.state  left join city ci on ci.cityid=r.city  left join stream st on p.streamid=st.idstream  where  a.workshopid='" + workshopid + "' order by p.regtime";
//                } else {
                // query = "SELECT a.participantid, per.firstname, per.lastname, c.email,c.mobile, c.homephone, p.qualification, p.experience,a.accomodation, r.remotecentername as center , p.status,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name  FROM accomodation a   left join  participant p on p.participantid=a.participantid  left join  person per on per.personid=p.personid  left join context  c on p.contextid=c.idcontext  left join  letter l on l.participantid=p.participantid  left join remotecenter r on a.instituteid=r.remotecenterid  left join designation d on d.iddesignation=per.designation left join state s on  s.stateid=r.state  left join city ci on ci.cityid=r.city  left join stream st on p.streamid=st.idstream  where  a.workshopid='" + workshopid + "' order by p.regtime";
//                    query = "SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, c.homephone,   p.qualification, p.experience,a.accomodation ,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=' " + workshopid + "' order by p.regtime";
//                query = "select a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, i.institutename, CONCAT(r.remotecentername,',',ci.city) as remotecentername , r.remotecenterid, s.state,  ci.city,a.accomodation,  p.status,d.designation, p.qualification, st.stream_name,   p.experience, c.homephone, l.letter, p.regtime from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=' " + workshopid + "' order by p.regtime";
//                }
                query = "select a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, IFNULL(i.idInstitute,'') as InstituteId, i.institutename,IFNULL(i.address,'') as Institute_Address, IFNULL(i.pincode, '') as Institute_Pincode, CONCAT(r.remotecentername,',',ci.city) as remotecentername , r.remotecenterid, s.state,  ci.city,a.accomodation,  p.status,d.designation, p.qualification, st.stream_name,   p.experience, c.homephone, l.letter, p.regtime from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=' " + workshopid + "' order by p.regtime";

            }

            String fileName = null;
            if (!rcid.equals("all")) {
                fileName = context + "Excel_Sheets/" + workshopid + "_" + rcid + ".xls";
            } else {
                fileName = context + "Excel_Sheets/" + workshopid + ".xls";
            }
            boolean result = excel.createExcel(query, fileName);
            if (result == true) {
                count = 1;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;

    }

    public ArrayList<Institute> listPInstitute(int cityid, int userid) {
        ArrayList<Institute> institutes = new ArrayList<Institute>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select idInstitute,Institutename,address, pincode from institute where city=? and isActive =1 union select idInstitute,Institutename,address, pincode from institute where city=? and idInstitute in (select instituteid from person where personid=?) and isActive=-1 order by Institutename");
                //  pstmt = con.prepareStatement("select idInstitute,Institutename,address, pincode from institute where city=? and isActive in (1,-1) order by Institutename");
                pstmt.setInt(1, cityid);
                pstmt.setInt(2, cityid);
                pstmt.setInt(3, userid);
                res = pstmt.executeQuery();
                Institute institute = null;
                while (res.next()) {
                    institute = new Institute();
                    institute.setInstituteId(res.getInt("idInstitute"));
                    institute.setInstituteName(res.getString("Institutename"));
                    institute.setInstituteAddress(res.getString("address"));
                    institute.setPincode(res.getInt("pincode"));
                    institutes.add(institute);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return institutes;
    }

    public ArrayList<RemoteCenterCapacity> rccDetails1(int workshopid, int rcid) throws Exception {
        ArrayList<RemoteCenterCapacity> remotecenterCapacity = new ArrayList<RemoteCenterCapacity>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query = "";

                query = "select c.rcid, r.remotecentername , c.available_seats, c.available_accomo,c.workshopid, c.acco_cost, c.food_cost from remotecenter r , remotecentercapacity c where r.remotecenterid = c.rcid and workshopid = ? and c.rcid=? order by c.rcid ";
                pstmt = con.prepareStatement(query);
                pstmt.setInt(1, workshopid);
                pstmt.setInt(2, rcid);
                res = pstmt.executeQuery();
                RemoteCenterCapacity rccContent = null;
                while (res.next()) {
                    rccContent = new RemoteCenterCapacity();
                    rccContent.setRcid(res.getInt("rcid"));
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String rcc_enc = cipher.encrypt(res.getString("rcid"));
                    rccContent.setRcid_enc(rcc_enc);
                    rccContent.setAvailable_accomo(res.getInt("available_accomo"));
                    rccContent.setAvailable_seats(res.getInt("available_seats"));
                    rccContent.setRemotecentername(res.getString("remotecentername"));
                    rccContent.setWorkshopid(res.getInt("workshopid"));
                    rccContent.setAcco_cost(res.getString("acco_cost"));
                    rccContent.setFood_cost(res.getString("food_cost"));

                    // query added by abinaya to set the seats booked and remaining
                    pstmt1 = con.prepareStatement("select count( participantid ) as booked_seats, (select count( participantid ) from accomodation where instituteid=? and workshopid =? and accomodation = 'Yes') as booked_acc from accomodation where instituteid=? and workshopid =?");
                    pstmt1.setInt(1, res.getInt("rcid"));
                    pstmt1.setInt(2, workshopid);
                    pstmt1.setInt(3, res.getInt("rcid"));
                    pstmt1.setInt(4, workshopid);
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        rccContent.setSeats_booked(res1.getInt(1));
                        rccContent.setAccomo_booked(res1.getInt(2));
                        int seats_remaining = res.getInt("available_seats") - res1.getInt(1);
                        int accomo_remaining = res.getInt("available_accomo") - res1.getInt(2);
                        if (seats_remaining < 0) {
                            rccContent.setSeats_remaining(0);
                        } else {
                            rccContent.setSeats_remaining(seats_remaining);
                        }
                        if (accomo_remaining < 0) {
                            rccContent.setAccomo_remaining(0);
                        } else {
                            rccContent.setAccomo_remaining(accomo_remaining);
                        }
                    }
                    remotecenterCapacity.add(rccContent);
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
        return remotecenterCapacity;
    }

    public ArrayList<HeadDetails> listParticipantHeadInstitute(int instituteid, int streamid) {
        ArrayList<HeadDetails> headDetails = new ArrayList<HeadDetails>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select head_title,headname,heademail,head_designation,head_contact,headaddress from academic where instituteid=? and streamid=? and isActive in (-1,1)");
                // pstmt = con.prepareStatement("select idInstitute,Institutename,address,pincode from institute where idInstitute=?");
                pstmt.setInt(1, instituteid);
                pstmt.setInt(2, streamid);
                res = pstmt.executeQuery();
                HeadDetails headdetails = null;
                while (res.next()) {
                    headdetails = new HeadDetails();
                    HeadTitle htitle = new HeadTitle();
                    HeadDesignation hdesignation = new HeadDesignation();
                    htitle.setHeadTitleId(res.getInt("head_title"));
                    hdesignation.setHeadDesignationId(res.getInt("head_designation"));
                    headdetails.setHeadtitle(htitle);
                    headdetails.setHeaddesignation(hdesignation);
                    headdetails.setName(res.getString("headname"));
                    headdetails.setEmail(res.getString("heademail"));
                    headdetails.setHeadphone(res.getString("head_contact"));
                    headdetails.setHeadaddress(res.getString("headaddress"));
                    headDetails.add(headdetails);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return headDetails;
    }

    public ArrayList<Lookups> listLookups(String Category) {
        ArrayList<Lookups> lookupDetails = new ArrayList<Lookups>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select id,category,code,description,isActive from lookups where   category=?");
                pstmt.setString(1, Category);
                res = pstmt.executeQuery();
                Lookups lookup = null;
                while (res.next()) {
                    Lookups lookupDetail = new Lookups();
                    lookupDetail.setCategory(res.getString("category"));
                    lookupDetail.setCode(res.getString("code"));
                    lookupDetail.setDescription(res.getString("description"));
                    lookupDetail.setIsactive(res.getInt("isActive"));
                    lookupDetails.add(lookupDetail);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return lookupDetails;
    }

    public ArrayList<Lookups> listLookups(String Category, int isActive) {
        ArrayList<Lookups> lookupDetails = new ArrayList<Lookups>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select id,category,code,description,isActive from lookups where isActive=? and  category=?");
                pstmt.setInt(1, isActive);
                pstmt.setString(2, Category);
                res = pstmt.executeQuery();
                Lookups lookup = null;
                while (res.next()) {
                    Lookups lookupDetail = new Lookups();
                    lookupDetail.setCategory(res.getString("category"));
                    lookupDetail.setCode(res.getString("code"));
                    lookupDetail.setDescription(res.getString("description"));
                    lookupDetail.setIsactive(res.getInt("isActive"));
                    lookupDetails.add(lookupDetail);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return lookupDetails;
    }

    /**
     * This function returns the ArrayList of the workshop Contents to be
     * displayed in the page from the table workshops. We use this function for
     * both workshop Conducted page and the workshop content pages.
     *
     * @return
     */
    public ArrayList<Downloads> listDownloads(String workshopid) throws Exception {

        ArrayList<Downloads> downloads = new ArrayList<Downloads>();

        if (con == null || con.isClosed()) {
            con = DBConnection.getDBConnection();
        }
        if (con != null) {
            try {
                pstmt = con.prepareStatement("select * from downloads where workshopid=? ");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                Downloads download = null;
                while (res.next()) {
                    download = new Downloads();
                    /**
                     * set the parameters
                     */
                    download.setWorkshopid(res.getInt("workshopid"));
                    download.setSession(res.getString("session"));
                    download.setVideo_name(res.getString("video_name"));
                    download.setPath(res.getString("file_name"));
                    // download.setDownload_name(res.getString("download_name"));
                    downloads.add(download);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                DBConnection.closeResultSet(res);
                DBConnection.closePStatement(pstmt);
                DBConnection.closeDBConnection(con);
            }
        }
        return downloads;
    }

    /**
     * This function returns the String of the result query if participant is
     * exist in relevant workshop then return true else return false.
     *
     * @return
     */
    public String checkParticipantExistInRelevantWorkshop(int workshopid, int userid) {
        String result = "false";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select c.email,c.idcontext,m.workshopid,p.participantid from context c,participant p,accomodation m where c.idcontext=p.contextid and p.participantid=m.participantid and m.workshopid=? and c.idcontext=? and p.status='Confirmed'");
                // pstmt.setInt(1, 5000020);
                pstmt.setInt(1, workshopid);
                pstmt.setInt(2, userid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    result = "true";
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
     * This function returns the String of the result query if remote center
     * capacity deleted succesfully then return true else false.
     *
     * @return
     */
    public boolean deleteParticularRCCapacity(int workshopid, int rcid, int ava_seats, int ava_accomo, int usertypeid) throws SQLException {
        boolean result = false;
        int delete_res = 0, insert_res = 0;
        PreparedStatement stmtNew = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                stmtNew = con.prepareStatement("insert into remotecentercapacity_deleted(workshopid,rcid,available_seats,available_accomo,loginid,deleted_time) values(?,?,?,?,?,now())");
                stmtNew.setInt(1, workshopid);
                stmtNew.setInt(2, rcid);
                stmtNew.setInt(3, ava_seats);
                stmtNew.setInt(4, ava_accomo);
                stmtNew.setInt(5, usertypeid);
                insert_res = stmtNew.executeUpdate();
                if (insert_res < 1) {
                    con.rollback();
                    result = false;
                } else if (insert_res > 0) {
                    //pstmt = con.prepareStatement("select c.email,c.idcontext,m.workshopid,p.participantid from context c,participant p,accomodation m where c.idcontext=p.contextid and p.participantid=m.participantid and m.workshopid=? and c.idcontext=? and p.status='Confirmed'");
                    pstmt = con.prepareStatement("delete from remotecentercapacity where workshopid=? and rcid=?");
                    pstmt.setInt(1, workshopid);
                    pstmt.setInt(2, rcid);
                    delete_res = pstmt.executeUpdate();
                    if (delete_res > 0) {
                        result = true;
                    }
                }

            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            stmtNew.close();
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }

    /**
     * this function return the city id as result for newly inserted in city
     * table the newly city is inserted with active = -1
     *
     * @param stateid
     * @param otherCity
     * @return
     */
    public int insertOtherCity(int stateid, String otherCity) {
        int result = -1;
        PreparedStatement pstmtNew = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("insert into city(stateid,city,isActive) values(?,?,-1)");
                // pstmt.setInt(1, 5000020);
                pstmt.setInt(1, stateid);
                pstmt.setString(2, otherCity);
                int result1 = pstmt.executeUpdate();
                if (result1 > 0) {
                    pstmtNew = con.prepareStatement("select cityid from city where city=? and stateid=? and isActive=-1");
                    pstmtNew.setString(1, otherCity);
                    pstmtNew.setInt(2, stateid);
                    res = pstmtNew.executeQuery();
                    while (res.next()) {
                        result = res.getInt("cityid");
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmtNew);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }

    /**
     * this method return city id if other city is present then return the old
     * cityid else return 0(for active 1 as well as -1 case)
     *
     * @param stateid
     * @param othercity
     * @return
     */
    public int checkOtherCityPresent(int stateid, String othercity) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select cityid from city where stateid=? and city=? and isActive in(1,-1)");
                // pstmt.setInt(1, 5000020);
                pstmt.setInt(1, stateid);
                pstmt.setString(2, othercity);
                res = pstmt.executeQuery();
                while (res.next()) {
                    result = res.getInt("cityid");
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
     *
     * @param stateid
     * @return
     */
    public ArrayList<City> listPerCity(int stateid, int userid) {
        ArrayList<City> cities = new ArrayList<City>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select cityid,city from city where isActive=1 and stateid=? union select cityid,city from city where stateid=? and cityid in(select city from context where idcontext=?)and isActive=-1 order by city");
                // pstmt = con.prepareStatement("select cityid,city from city where isActive=1 and stateid=? order by city");
                // pstmt = con.prepareStatement("select cityid,city from city where stateid=? order by city");
                pstmt.setInt(1, stateid);
                pstmt.setInt(2, stateid);
                pstmt.setInt(3, userid);
                res = pstmt.executeQuery();
                City city = null;
                while (res.next()) {
                    city = new City();
                    city.setCityId(res.getInt("cityid"));
                    city.setCityName(res.getString("city"));
                    cities.add(city);
                }
                city = new City();
                city.setCityId(-2);
                city.setCityName("Other");
                cities.add(city);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return cities;
    }

    /**
     *
     * @return
     */
    public RemoteCenter rc_details(String rcid) throws Exception {
        RemoteCenter rc_details = new RemoteCenter();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select r.remotecenterid,r.remotecentername,r.city,r.state,r.active, IFNULL(r.pincode ,'0') as pincode, IFNULL(r.district ,'') as district, r.email, r.status, r.Instituteid, i.institutename, autonomous, IFNULL(acd_cal_startdate,'') as acd_cal_startdate, IFNULL(affiliated_university,'') as affiliated_university, s.state as state1, c.city as city1 from remotecenter r left join city c on r.city=c.cityid left join state s on s.stateid=r.state left join institute i on i.idInstitute=Instituteid where  r.remotecenterid=?");
                pstmt.setString(1, rcid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    rc_details = new RemoteCenter();
                    rc_details.setRemoteCenterId(res.getInt("remotecenterid"));
                    rc_details.setRemoteCenterName(res.getString("remotecentername"));
                    rc_details.setIsActive(res.getBoolean("active"));
                    // for perspective remote center
                    rc_details.setIsactive(res.getInt("active"));
                    rc_details.setRc_city(res.getString("city"));
                    rc_details.setRc_state(res.getString("state"));
                    // rc state and city string
                    rc_details.setState1(res.getString("state1"));
                    rc_details.setCity1(res.getString("city1"));
                    rc_details.setPincode(res.getInt("pincode"));
                    rc_details.setDistrict(res.getString("district"));
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String rc_enc = cipher.encrypt(res.getString("remotecenterid"));
                    rc_details.setRc_coordinator_email(res.getString("email"));
                    rc_details.setRc_status(res.getString("status"));
                    rc_details.setRc_enc(rc_enc);

                    //institute details
                    rc_details.setRes_instituteid(res.getInt("Instituteid"));
                    rc_details.setInstituteName(res.getString("institutename"));

                    // autonomous and academic cal added
                    rc_details.setRc_autonomous(res.getString("autonomous"));
                    rc_details.setAcademic_cal(res.getString("acd_cal_startdate"));
                    rc_details.setAffiliated_university(res.getString("affiliated_university"));
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return rc_details;
    }

    public int updateRCDetails(RemoteCenter rc_details) throws Exception {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("update remotecenter set remotecentername=?,city=?,state=?,active=?,pincode=? , district=?, email=?, status=?, last_updatedby=?, last_update= NOW(), Instituteid=?, autonomous=?, acd_cal_startdate=?, affiliated_university=? where remotecenterid=?");
                pstmt.setString(1, rc_details.getRemoteCenterName());
                pstmt.setString(2, rc_details.getRc_city());
                pstmt.setString(3, rc_details.getRc_state());
                pstmt.setInt(4, rc_details.getIsactive());
                pstmt.setInt(5, rc_details.getPincode());
                pstmt.setString(6, rc_details.getDistrict());
                pstmt.setString(7, rc_details.getRc_coordinator_email());
                pstmt.setString(8, rc_details.getRc_status());
                pstmt.setInt(9, rc_details.getLast_updatedby());
                pstmt.setInt(10, rc_details.getRes_instituteid());
                pstmt.setString(11, rc_details.getRc_autonomous());
                pstmt.setString(12, rc_details.getAcademic_cal());
                pstmt.setString(13, rc_details.getAffiliated_university());
                pstmt.setInt(14, rc_details.getRemoteCenterId());
                result = pstmt.executeUpdate();
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

    public int insertRCDetails(RemoteCenter rc_details) throws Exception {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("insert into remotecenter (remotecenterid,remotecentername,city,state,active,pincode, district, rating,email,status,last_updatedby, Instituteid, autonomous, acd_cal_startdate, affiliated_university) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                pstmt.setInt(1, rc_details.getRemoteCenterId());
                pstmt.setString(2, rc_details.getRemoteCenterName());
                pstmt.setString(3, rc_details.getRc_city());
                pstmt.setString(4, rc_details.getRc_state());
                pstmt.setInt(5, rc_details.getIsactive());
                pstmt.setInt(6, rc_details.getPincode());
                pstmt.setString(7, rc_details.getDistrict());
                pstmt.setString(8, "3");
                pstmt.setString(9, rc_details.getRc_coordinator_email());
                pstmt.setString(10, rc_details.getRc_status());
                pstmt.setInt(11, rc_details.getLast_updatedby());
                pstmt.setInt(12, rc_details.getRes_instituteid());
                pstmt.setString(13, rc_details.getRc_autonomous());
                pstmt.setString(14, rc_details.getAcademic_cal());
                pstmt.setString(15, rc_details.getAffiliated_university());
                result = pstmt.executeUpdate();
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
     * this method return the integer result as if participant is exit for
     * particular workshop with particular remote center id. if not exist then
     * return as 0
     *
     * @param workshopid
     * @param instituteid
     * @return
     */
    public int partcipantExistInRemoteCenter(int workshopid, int instituteid) {
        int result = 0;
        int p_id = 0, count = 0, cancel_count = 0;
        PreparedStatement prepst1 = null;
        ResultSet resN1 = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                // pstmt = con.prepareStatement("select count(*) as totalExist from accomodation where workshopid=? and instituteid=?");
                pstmt = con.prepareStatement("select participantid from accomodation where workshopid=? and instituteid=?");
                pstmt.setInt(1, workshopid);
                pstmt.setInt(2, instituteid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    p_id = res.getInt("participantid");

                    //result = res.getInt("totalExist");
                    prepst1 = con.prepareStatement("select participantid,status from participant where participantid=?");
                    prepst1.setInt(1, p_id);
                    resN1 = prepst1.executeQuery();
                    while (resN1.next()) {
                        if (!resN1.getString("status").equals("Cancelled")) {
                            result = 1;
                            return result;
                        } else if (resN1.getString("status").equals("Cancelled")) {
                            cancel_count++;
                        }
                    }
                    count++;
                }
                if (count == cancel_count) {
                    result = 0;
                } else if (count != cancel_count) {
                    result = 1;
                } else {
                    result = 1;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            result = 1;
        } finally {
            DBConnection.closeResultSet(resN1);
            DBConnection.closePStatement(prepst1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }

    /**
     * This method return the list of institute details as result depending upon
     * the specify active type(i.e- Active-1,inActive-0, not Approved-(-1).
     *
     * @param activeType
     * @return
     */
    public ArrayList<Institute> list_InstituteDetails(int activeType) {
        ArrayList<Institute> institutes = new ArrayList<Institute>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //pstmt = con.prepareStatement("select  i.idInstitute,i.Institutename,s.state,c.city,i.pincode,i.address,i.isActive from institute i,city c,state s where i.isActive=? and i.city=c.cityid and i.state=s.stateid");
                pstmt = con.prepareStatement("select i.idInstitute,i.Institutename,ifnull(s.state,'') as state,ifnull(c.city,'') as city,ifnull(i.pincode,'') as pincode,ifnull(i.address,'') as address,i.isActive from institute i left join city c on i.city=c.cityid left join state s on i.state=s.stateid  where i.isActive=? order by idinstitute");
                pstmt.setInt(1, activeType);
                res = pstmt.executeQuery();
                Institute institute = null;
                while (res.next()) {
                    institute = new Institute();
                    institute.setInstituteId(res.getInt("idInstitute"));
                    institute.setInstituteName(res.getString("Institutename"));
                    institute.setInstituteAddress(res.getString("address"));
                    institute.setPincode(res.getInt("pincode"));
                    State state = new State();
                    state.setStateName(res.getString("state"));
                    City city = new City();
                    city.setCityName(res.getString("city"));
                    institute.setIsActive(res.getInt("isActive"));
                    institute.setState(state);
                    institute.setCity(city);
                    institutes.add(institute);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return institutes;
    }

    public ArrayList<Lookups> list_Roles() {
        ArrayList<Lookups> roles = new ArrayList<Lookups>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("SELECT * FROM `lookups` where category='ROLE' and isActive=1 order by code");
                res = pstmt.executeQuery();
                Lookups lookup = null;
                while (res.next()) {
                    lookup = new Lookups();
                    lookup.setCode(res.getString("code"));
                    lookup.setDescription(res.getString("description"));
                    roles.add(lookup);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return roles;
    }

    public int updateUserRole(Person person) {
        int id = 0, result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("update login set usertypeid=? where login_name=?");
                pstmt.setInt(1, person.getRoleId());
                pstmt.setString(2, person.getEmail());
                result = pstmt.executeUpdate();
                if (result > 0) {
                    id = 1;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return id;
    }

    public ArrayList<Lookups> listConfigTables() {
        int id = 0, result = 0;
        ArrayList<Lookups> lookups = new ArrayList<Lookups>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select distinct(category) from lookups");
                res = pstmt.executeQuery();
                Lookups lookup = null;
                while (res.next()) {
                    lookup = new Lookups();
                    lookup.setCategory(res.getString("category"));
                    lookups.add(lookup);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return lookups;
    }

    public ArrayList<Lookups> listConfigTableDetails(String category) throws Exception {
        int id = 0, result = 0;
        ArrayList<Lookups> lookups = new ArrayList<Lookups>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select id,category,code,description, IFNULL(comment,'') as comment,isActive from lookups where category=?");
                pstmt.setString(1, category);
                res = pstmt.executeQuery();
                Lookups lookup = null;
                while (res.next()) {
                    lookup = new Lookups();
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    lookup.setLookup_id_enc(cipher.encrypt(res.getString("id")));
                    lookup.setLookup_id(res.getInt("id"));
                    lookup.setCategory(res.getString("category"));
                    lookup.setCode(res.getString("code"));
                    lookup.setDescription(res.getString("description"));
                    lookup.setComment(res.getString("comment"));
                    lookup.setIsactive(res.getInt("isActive"));
                    lookups.add(lookup);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return lookups;
    }

    public Lookups listConfigDetail(String id) throws Exception {
        Lookups lookup = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select id,category,code,description, IFNULL(comment,'') as comment,isActive from lookups where id=?");
                pstmt.setString(1, id);
                res = pstmt.executeQuery();

                while (res.next()) {
                    lookup = new Lookups();
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    lookup.setLookup_id_enc(cipher.encrypt(res.getString("id")));
                    lookup.setLookup_id(res.getInt("id"));
                    lookup.setCategory(res.getString("category"));
                    lookup.setCode(res.getString("code"));
                    lookup.setDescription(res.getString("description"));
                    lookup.setComment(res.getString("comment"));
                    lookup.setIsactive(res.getInt("isActive"));
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return lookup;
    }

    public int updateConfigTable(Lookups lookup) {
        int id = 0, result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String category = lookup.getCategory();
                String code = lookup.getCode();
                String comment = lookup.getComment();
                String description = lookup.getDescription();
                int isActive = lookup.getIsactive();
                if (lookup.getCategory().equals("newConfigCategory")) {
                    // create new category
                    category = lookup.getNewCategory();
                }
                if (lookup.getIsNewConfig() == 1) {
                    // insert into config table
                    pstmt = con.prepareStatement("insert into lookups (description, comment,isActive,category,code) values(?,?,?,?,?)");
                } else {
                    // update the config table
                    pstmt = con.prepareStatement("update lookups set description=?, comment=?, isActive=? where category=? and code=? ");
                }
                pstmt.setString(1, description);
                pstmt.setString(2, comment);
                pstmt.setInt(3, isActive);
                pstmt.setString(4, category);
                pstmt.setString(5, code);
                result = pstmt.executeUpdate();
                if (result > 0) {
                    id = 1;
                }
            }
        } catch (SQLException sqle) {
//            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return id;
    }

    public ArrayList<City> listAllCities() {
        ArrayList<City> cities = new ArrayList<City>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select c.cityid,c.city,c.isActive,c.stateid, s.state from city c, state s where c.stateid=s.stateid order by stateid, city");
                res = pstmt.executeQuery();
                City city = null;
                while (res.next()) {
                    city = new City();
                    city.setCityId(res.getInt("cityid"));
                    city.setCityName(res.getString("city"));
                    city.setIsActive(res.getInt("isActive"));
                    State state = new State();
                    state.setStateId(res.getInt("stateid"));
                    state.setStateName(res.getString("state"));
                    city.setState(state);
                    cities.add(city);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return cities;
    }

    public City listCityDetail(String id) throws Exception {
        City city = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select c.cityid,c.city,c.isActive,c.stateid, s.state from city c, state s where c.stateid=s.stateid and c.cityid=? order by stateid");
                pstmt.setString(1, id);
                res = pstmt.executeQuery();

                while (res.next()) {
                    city = new City();
                    city.setCityId(res.getInt("cityid"));
                    city.setCityName(res.getString("city"));
                    city.setIsActive(res.getInt("isActive"));
                    State state = new State();
                    state.setStateId(res.getInt("stateid"));
                    state.setStateName(res.getString("state"));
                    city.setState(state);

                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return city;
    }

    public int updateCityTable(City city) {
        int id = 0, result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                int state = city.getState().getStateId();
                String cityName = city.getCityName();
                int isActive = city.getIsActive();

                if (city.getIsNewConfig() == 1) {
                    // insert into config table
                    pstmt = con.prepareStatement("insert into city (stateid, city,isActive) values(?,?,?)");
                } else {
                    // update the config table
                    pstmt = con.prepareStatement("update city set stateid=?, city=?, isActive=? where cityid=?");
                    pstmt.setInt(4, city.getCityId());
                }
                pstmt.setInt(1, state);
                pstmt.setString(2, cityName);
                pstmt.setInt(3, isActive);
                result = pstmt.executeUpdate();
                if (result > 0) {
                    id = 1;
                }
            }
        } catch (SQLException sqle) {
//            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return id;
    }

    public Institute instituteDetails(int instituteid) {
        Institute institute = new Institute();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select idInstitute,Institutename,address,pincode,state,city,isActive from institute where idInstitute=?");
                pstmt.setInt(1, instituteid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    institute.setInstituteId(res.getInt("idInstitute"));
                    institute.setInstituteName(res.getString("Institutename"));
                    institute.setInstituteAddress(res.getString("address"));
                    institute.setPincode(res.getInt("pincode"));
                    State state = new State();
                    //state.setStateName(res.getString("state"));
                    state.setStateId(res.getInt("state"));
                    City city = new City();
                    //city.setCityName(res.getString("city"));
                    city.setCityId(res.getInt("city"));
                    institute.setIsActive(res.getInt("isActive"));
                    institute.setState(state);
                    institute.setCity(city);

                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return institute;
    }

    public int updateInstituteDetails(Institute institute) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("update institute set Institutename=?,address=?,pincode=?,state=?,city=?,isActive=?,last_updatedby=?,last_update=NOW() where idInstitute=?");
                pstmt.setString(1, institute.getInstituteName());
                pstmt.setString(2, institute.getInstituteAddress());
                pstmt.setInt(3, institute.getPincode());
                pstmt.setInt(4, institute.getState().getStateId());
                pstmt.setInt(5, institute.getCity().getCityId());
                pstmt.setInt(6, institute.getIsActive());
                pstmt.setInt(7, institute.getLast_updatedby());
                pstmt.setInt(8, institute.getInstituteId());
                result = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            //DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }

    /**
     * this method return integer if query and excel file created successfully.
     *
     * @param type
     * @param context
     * @return
     */
    public int setQuery_instituteDetails(int type, String context) {
        int count = 0;
        String query;
        ExcelSheet excel = new ExcelSheet();
        try {
            //query="select idinstitute,institutename,address,pincode,state,city from institute where isActive="+type+"");
            query = "select i.idinstitute,i.institutename,i.address,i.pincode,s.state,ci.city from institute i left join state s on i.state=s.stateid left join city ci on i.city=ci.cityid where i.isActive=" + type + "";
            String fileName = null;
            if (type == 0) {
                fileName = context + "Excel_Sheets/In_Active_Institute.xls";
            } else if (type == 1) {
                fileName = context + "Excel_Sheets/Active_Institute.xls";
            } else if (type == -1) {
                fileName = context + "Excel_Sheets/Not_Approved_Institute.xls";
            }

            boolean result = excel.createExcel(query, fileName);
            if (result == true) {
                count = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;
    }

    /**
     * this method return the array data type of content from pagelist table
     *
     * @param page
     * @return
     */
    public ArrayList<Content> getPage_Content(String page) {
        ArrayList<Content> contents = new ArrayList<Content>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select content,comment,class from pagelist where name=?");
                pstmt.setString(1, page);
                res = pstmt.executeQuery();
                Content content = null;
                while (res.next()) {
                    content = new Content();
                    content.setContent(res.getString("content"));
                    content.setComment(res.getString("comment"));
                    content.setClass_type(res.getInt("class"));
                    contents.add(content);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return contents;
    }

    /**
     * this method return int as result of update in pagelist table depending
     * upon the specify name of the page if data is updated then return 1 as
     * result and 0 if not updated
     *
     * @param content
     * @param page
     * @param userId
     * @param comment
     * @return
     */
    public int setNew_PageContent(String content, String page, int userId, String comment) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("update pagelist set content=?,comment=?,last_update=now(),last_updatedby=? where name=?");
                pstmt.setString(1, content);
                pstmt.setString(2, comment);
                pstmt.setInt(3, userId);
                pstmt.setString(4, page);
                result = pstmt.executeUpdate();
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
     * this method return array list data of pagelist table
     *
     * @return
     */
    public ArrayList<Content> listContent() {
        ArrayList<Content> contents = new ArrayList<Content>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select id,name,description from pagelist");
                res = pstmt.executeQuery();
                Content content = null;
                while (res.next()) {
                    content = new Content();
                    content.setId(res.getInt("id"));
                    content.setName(res.getString("name"));
                    content.setDescription(res.getString("description"));
                    contents.add(content);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return contents;
    }

    public ArrayList<RemoteCenter> listInstitute(String workshopid) throws Exception {
        ArrayList<RemoteCenter> rc_list = new ArrayList<RemoteCenter>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select distinct(i.idInstitute), i.Institutename, s.state  from institute i left join state s on s.stateid=i.state  left join participant p on i.idInstitute=p.instituteid   left join accomodation a  on p.participantid=a.participantid where a.workshopid=? order by Institutename");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();

                RemoteCenter rc = null;
                while (res.next()) {
                    rc = new RemoteCenter();
                    rc.setRemoteCenterId(res.getInt("idInstitute"));
                    rc.setRemoteCenterName(res.getString("Institutename"));
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    rc.setEnc_RC(cipher.encrypt(res.getString("idInstitute")));
                    rc.setRc_state(res.getString("state"));
                    rc_list.add(rc);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return rc_list;
    }

    /**
     * this method return array list data of head details of particular
     * institute
     *
     * @return
     */
    public ArrayList<HeadDetails> listHeadDetails(int instituteid) {
        ArrayList<HeadDetails> details = new ArrayList<HeadDetails>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //pstmt = con.prepareStatement("select streamid,head_title,headname,heademail,head_designation,headaddress,head_contact from academic where instituteid=?");
                pstmt = con.prepareStatement("select a.headname,a.heademail, a.headaddress, a.head_contact, t.head_title, d.head_designation,s.stream_name,a.streamid,a.isActive from academic a left join head_title t on a.head_title=t.head_title_id left join headdesignation d on a.head_designation=d.headdesignation_id left join stream s on a.streamid=s.idstream where a.instituteid=?");
                pstmt.setInt(1, instituteid);
                res = pstmt.executeQuery();
                HeadDetails obj_details = null;
                HeadTitle obj_title = null;
                HeadDesignation obj_designation = null;
                Stream stream = null;
                while (res.next()) {
                    obj_details = new HeadDetails();
                    obj_details.setName(res.getString("headname"));
                    obj_details.setEmail(res.getString("heademail"));
                    obj_details.setHeadaddress(res.getString("headaddress"));
                    obj_details.setHeadphone(res.getString("head_contact"));
                    /*
                     * created HeadTitle object
                     */
                    obj_title = new HeadTitle();
                    //obj_title.setH_headTitleId(res.getInt("head_title"));
                    obj_title.setHeadTitleName(res.getString("head_title"));
                    /*
                     * created HeadDesignation object
                     */
                    obj_designation = new HeadDesignation();
                    //obj_designation.setH_headDesignationId(res.getInt("head_designation"));
                    obj_designation.setHeadDesignationName(res.getString("head_designation"));
                    /*
                     *
                     */
                    stream = new Stream();
                    stream.setStreamId(res.getInt("streamid"));
                    stream.setStreamName(res.getString("stream_name"));
                    /*
                     * adding both object to HeadDetails entity
                     */
                    obj_details.setHeadtitle(obj_title);
                    obj_details.setHeaddesignation(obj_designation);
                    obj_details.setStream(stream);
                    obj_details.setIsActive(res.getInt("isActive"));
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

    /**
     * this method
     *
     * @return
     */
    public HeadDetails get_HeadDetails(int instituteid, int streamid) {
        HeadDetails obj_details = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //pstmt = con.prepareStatement("select streamid,head_title,headname,heademail,head_designation,headaddress,head_contact from academic where instituteid=?");
                pstmt = con.prepareStatement("select a.headname,a.heademail, a.headaddress, a.head_contact, t.head_title,a.head_title as 'head_id', d.head_designation,a.head_designation as 'head_desg_id',s.stream_name,a.streamid,a.isActive from academic a left join head_title t on a.head_title=t.head_title_id left join headdesignation d on a.head_designation=d.headdesignation_id left join stream s on a.streamid=s.idstream where a.instituteid=? and a.streamid=?");
                pstmt.setInt(1, instituteid);
                pstmt.setInt(2, streamid);
                res = pstmt.executeQuery();

                HeadTitle obj_title = null;
                HeadDesignation obj_designation = null;
                Stream stream = null;
                while (res.next()) {
                    obj_details = new HeadDetails();
                    obj_details.setName(res.getString("headname"));
                    obj_details.setEmail(res.getString("heademail"));
                    obj_details.setHeadaddress(res.getString("headaddress"));
                    obj_details.setHeadphone(res.getString("head_contact"));
                    /*
                     * created HeadTitle object
                     */
                    obj_title = new HeadTitle();
                    obj_title.setHeadTitleId(res.getInt("head_id"));
                    obj_title.setHeadTitleName(res.getString("head_title"));
                    /*
                     * created HeadDesignation object
                     */
                    obj_designation = new HeadDesignation();
                    obj_designation.setHeadDesignationId(res.getInt("head_desg_id"));
                    obj_designation.setHeadDesignationName(res.getString("head_designation"));
                    /*
                     *
                     */
                    stream = new Stream();
                    stream.setStreamId(res.getInt("streamid"));
                    stream.setStreamName(res.getString("stream_name"));
                    obj_details.setIsActive(res.getInt("isActive"));
                    /*
                     * adding both object to HeadDetails entity
                     */
                    obj_details.setHeadtitle(obj_title);
                    obj_details.setHeaddesignation(obj_designation);
                    obj_details.setStream(stream);

                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return obj_details;
    }

    /**
     * this method return integer as result 1 if data update successfully else
     * return 0 if not updated.
     *
     * @param headdetails
     * @return
     */
    public int updateHeadDetails(HeadDetails headdetails) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
//                pstmt = con.prepareStatement("update academic set headname=?,heademail=?,headaddress=?,head_contact=?,head_title=?,head_designation=?,last_updatedby=?,isActive=?,last_update=now() where instituteid=? and streamid=?");
                pstmt = con.prepareStatement("update academic set headname=?,heademail=?,headaddress=?,head_contact=?,head_title=?,head_designation=?,last_updatedby=?,isActive=?,last_update=now() where instituteid=?");
                pstmt.setString(1, headdetails.getName());
                pstmt.setString(2, headdetails.getEmail());
                pstmt.setString(3, headdetails.getHeadaddress());
                pstmt.setString(4, headdetails.getHeadphone());
                pstmt.setInt(5, headdetails.getHeadtitle().getHeadTitleId());
                pstmt.setInt(6, headdetails.getHeaddesignation().getHeadDesignationId());
                pstmt.setInt(7, headdetails.getLast_updateby());
                pstmt.setInt(8, headdetails.getIsActive());
                pstmt.setInt(9, headdetails.getInstituteId());
//                pstmt.setInt(10, headdetails.getStream().getStreamId());
                result = pstmt.executeUpdate();
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

    public int addNewHeadDetails(HeadDetails headdetails) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("insert into academic(instituteid,streamid,head_title,headname,heademail,head_designation,headaddress,head_contact,isActive,last_update,last_updatedby) values(?,?,?,?,?,?,?,?,?,now(),?)");
                pstmt.setInt(1, headdetails.getInstituteId());
                pstmt.setInt(2, headdetails.getStream().getStreamId());
                pstmt.setInt(3, headdetails.getHeadtitle().getHeadTitleId());
                pstmt.setString(4, headdetails.getName());
                pstmt.setString(5, headdetails.getEmail());
                pstmt.setInt(6, headdetails.getHeaddesignation().getHeadDesignationId());
                pstmt.setString(7, headdetails.getHeadaddress());
                //pstmt.setInt(8, Integer.parseInt(headdetails.getHeadphone()));
                pstmt.setString(8, headdetails.getHeadphone());
                pstmt.setInt(9, headdetails.getIsActive());
                pstmt.setInt(10, headdetails.getLast_updateby());
                result = pstmt.executeUpdate();
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

    public int checkAlreadyHeadDetails(int instituteid, int streamid) {
        int result = 0, id = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select streamid from academic where instituteid=? and streamid=?");
                pstmt.setInt(1, instituteid);
                pstmt.setInt(2, streamid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    id = res.getInt("streamid");
                }
                if (id > 0) {
                    result = 1;
                } else {
                    result = 0;
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
     * this method return array list data of head details of particular
     * institute
     *
     * @return
     */
    public ArrayList<Summary> getSummaryReport(String start_date, String end_date) throws ParseException {
        ArrayList<Summary> details = new ArrayList<Summary>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                DateFormat userDateFormat = new SimpleDateFormat("dd-mm-yyyy");
                DateFormat dateFormatNeeded = new SimpleDateFormat("yyyy-mm-dd");
                String query7 = "";

//                String query5 = "select workshop ,name\n"
//                        + ", sum(if( status in ('Approved','Elig. Approved','Request Approved') ,count,0)) 'Approved'\n"
//                        + ",sum(if(status in ('','1','Cancelled','incomplete','Request Verified','Waiting','Waitlisted','Withdrawn')  or status is null,count,0)) 'Cancelled'\n"
//                        + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed','Completed'),count,0)) 'Confirmed'\n"
//                        + ",sum(if(status ='Completed',count,0)) 'Certified'\n"
//                        + ",sum(if(status in ( 'Registration Invalid','Rejected'),count,0)) 'Invalid'\n"
//                        + ",sum(if(status in ( 'enrolled','Prov. Enrolled','Registered','Request Registered'),count,0)) 'Registered'\n"
//                        + ",sum(count) Total\n"
//                        + "from participant_status1 group by workshop,name\n"
//                        + "union all \n"
//                        + "select \"All\" WorkshopId,' ' Workshopname\n"
//                        + ", sum(if( status in ('Approved','Elig. Approved','Request Approved') ,count,0)) 'Approved'\n"
//                        + ",sum(if(status in ('','1','Cancelled','incomplete','Request Verified','Waiting','Waitlisted','Withdrawn')  or status is null,count,0)) 'Cancelled'\n"
//                        + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed','Completed'),count,0)) 'Confirmed'\n"
//                        + ",sum(if(status ='Completed',count,0)) 'Certified'\n"
//                        + ",sum(if(status in ( 'Registration Invalid','Rejected'),count,0)) 'Invalid'\n"
//                        + ",sum(if(status in ( 'enrolled','Prov. Enrolled','Registered','Request Registered'),count,0)) 'Registered'\n"
//                        + ",sum(count) Total\n"
//                        + "from participant_status1;";
//
//                String query6 = "select workshop ,name, DATE_FORMAT(startdate, '%d %M %Y') as startdate1,DATE_FORMAT(enddate, '%d %M %Y') as enddate1,\n"
//                        + "sum(if( status in ('Approved','Elig. Approved','Request Approved') ,count,0)) 'Approved'\n"
//                        + ",sum(if(status in ('','1','Cancelled','incomplete','Request Verified','Waiting','Waitlisted',\n"
//                        + "'Withdrawn')  or status is null,count,0)) 'Cancelled'\n"
//                        + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed','Completed'),count,0)) 'Confirmed'\n"
//                        + ",sum(if(status ='Completed',count,0)) 'Certified'\n"
//                        + ",sum(if(status in ( 'Registration Invalid','Rejected'),count,0)) 'Invalid'\n"
//                        + ",sum(if(status in ( 'enrolled','Prov. Enrolled','Registered','Request Registered'),count,0)) 'Registered'\n"
//                        + ",sum(count) Total from participant_status1 \n"
//                        + "group by workshop,name order by startdate desc; ";
                if (start_date.equals("none") && end_date.equals("none")) {
                    query7 = "select p.workshop ,name,DATE_FORMAT(p.startdate, '%d %M %Y') as startdate1,DATE_FORMAT(p.enddate, '%d %M %Y') as enddate1\n"
                            + ", sum(if( status in ('Approved','Elig. Approved','Request Approved') ,count,0)) 'Approved'\n"
                            + ",sum(if(status in ('','1','Cancelled','incomplete','Request Verified','Waiting','Waitlisted','Withdrawn')  or status is null,count,0)) 'Cancelled'\n"
                            + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed'),count,0)) 'Confirmed'\n"
                            + ",sum(if(status ='Completed',count,0)) 'Certified'"
                            + ",sum(if(status in ( 'Registration Invalid','Rejected'),count,0)) 'Invalid'\n"
                            + ",sum(if(status in ( 'enrolled','Prov. Enrolled','Registered','Request Registered'),count,0)) 'Registered'\n"
                            + ",sum(count) Total\n"
                            + "from participant_status p, workshops w "
                            + "where workshop=w.workshopid and workshop > 0 group by p.workshop,p.name order by p.startdate desc";
                    pstmt = con.prepareStatement(query7);
                }
                if (!start_date.equals("none") && !end_date.equals("none")) {
                    query7 = "select p.workshop ,name,DATE_FORMAT(p.startdate, '%d %M %Y') as startdate1,DATE_FORMAT(p.enddate, '%d %M %Y') as enddate1\n"
                            + ", sum(if( status in ('Approved','Elig. Approved','Request Approved') ,count,0)) 'Approved'\n"
                            + ",sum(if(status in ('','1','Cancelled','incomplete','Request Verified','Waiting','Waitlisted','Withdrawn')  or status is null,count,0)) 'Cancelled'\n"
                            + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed'),count,0)) 'Confirmed'\n"
                            + ",sum(if(status ='Completed',count,0)) 'Certified'"
                            + ",sum(if(status in ( 'Registration Invalid','Rejected'),count,0)) 'Invalid'\n"
                            + ",sum(if(status in ( 'enrolled','Prov. Enrolled','Registered','Request Registered'),count,0)) 'Registered'\n"
                            + ",sum(count) Total\n"
                            + "from participant_status p, workshops w "
                            + "where workshop=w.workshopid and workshop > 0 and w.startdate >= ? and w.startdate <= ? "
                            + "group by p.workshop,p.name order by p.startdate desc";
                    Date start_date_1 = userDateFormat.parse(start_date);
                    String start_date_2 = dateFormatNeeded.format(start_date_1);
                    Date end_date_1 = userDateFormat.parse(end_date);
                    String end_date_2 = dateFormatNeeded.format(end_date_1);
                    pstmt = con.prepareStatement(query7);
                    pstmt.setString(1, start_date_2);
                    pstmt.setString(2, end_date_2);
                }
                if (!start_date.equals("none") && end_date.equals("none")) {
                    query7 = "select p.workshop ,name,DATE_FORMAT(p.startdate, '%d %M %Y') as startdate1,DATE_FORMAT(p.enddate, '%d %M %Y') as enddate1\n"
                            + ", sum(if( status in ('Approved','Elig. Approved','Request Approved') ,count,0)) 'Approved'\n"
                            + ",sum(if(status in ('','1','Cancelled','incomplete','Request Verified','Waiting','Waitlisted','Withdrawn')  or status is null,count,0)) 'Cancelled'\n"
                            + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed'),count,0)) 'Confirmed'\n"
                            + ",sum(if(status ='Completed',count,0)) 'Certified'"
                            + ",sum(if(status in ( 'Registration Invalid','Rejected'),count,0)) 'Invalid'\n"
                            + ",sum(if(status in ( 'enrolled','Prov. Enrolled','Registered','Request Registered'),count,0)) 'Registered'\n"
                            + ",sum(count) Total\n"
                            + "from participant_status p, workshops w "
                            + "where workshop=w.workshopid and workshop > 0 and w.startdate >= ?  group by p.workshop,p.name order by p.startdate desc";
                    Date start_date_1 = userDateFormat.parse(start_date);
                    String start_date_2 = dateFormatNeeded.format(start_date_1);
                    pstmt = con.prepareStatement(query7);
                    pstmt.setString(1, start_date_2);

                }
                if (start_date.equals("none") && !end_date.equals("none")) {
                    query7 = "select p.workshop ,name,DATE_FORMAT(p.startdate, '%d %M %Y') as startdate1,DATE_FORMAT(p.enddate, '%d %M %Y') as enddate1\n"
                            + ", sum(if( status in ('Approved','Elig. Approved','Request Approved') ,count,0)) 'Approved'\n"
                            + ",sum(if(status in ('','1','Cancelled','incomplete','Request Verified','Waiting','Waitlisted','Withdrawn')  or status is null,count,0)) 'Cancelled'\n"
                            + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed'),count,0)) 'Confirmed'\n"
                            + ",sum(if(status ='Completed',count,0)) 'Certified'"
                            + ",sum(if(status in ( 'Registration Invalid','Rejected'),count,0)) 'Invalid'\n"
                            + ",sum(if(status in ( 'enrolled','Prov. Enrolled','Registered','Request Registered'),count,0)) 'Registered'\n"
                            + ",sum(count) Total\n"
                            + "from participant_status p, workshops w  "
                            + "where workshop=w.workshopid and workshop > 0 and  w.startdate <= ? group by p.workshop,p.name order by p.startdate desc";
                    Date end_date_1 = userDateFormat.parse(end_date);
                    String end_date_2 = dateFormatNeeded.format(end_date_1);
                    pstmt = con.prepareStatement(query7);
                    pstmt.setString(1, end_date_2);
                }
                res = pstmt.executeQuery();
                Summary summary = null;
                while (res.next()) {
                    summary = new Summary();
                    summary.setWorkshopid(res.getString("workshop"));
                    summary.setWorkshopname(res.getString("name"));
                    summary.setApproved(res.getString("Approved"));
                    summary.setConfirmed(res.getString("Confirmed"));
                    summary.setRegistered(res.getString("Registered"));
                    summary.setCancelled(res.getString("Cancelled"));
                    summary.setInvalid(res.getString("Invalid"));
                    summary.setCertified(res.getString("Certified"));
                    summary.setTotal(res.getString("Total"));
                    summary.setStartdate(res.getString("startdate1"));
                    summary.setEnddate(res.getString("enddate1"));
                    details.add(summary);
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

    /**
     * this method return integer if query and excel file created successfully.
     *
     * @param type
     * @param context
     * @return
     */
    public int setQuery_SummaryDetails(String type, String context) {
        int count = 0;
        String query1, query2;
        ExcelSheet excel = new ExcelSheet();
        try {
            query1 = "select workshop as 'Workshop ID',name as 'Workshop Name'\n"
                    + ", sum(if( status in ('Approved','Elig. Approved','Request Approved') ,count,0)) 'Approved'\n"
                    + ",sum(if(status in ('','1','Cancelled','incomplete','Request Verified','Waiting','Waitlisted','Withdrawn')  or status is null,count,0)) 'Cancelled'\n"
                    + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed','Completed'),count,0)) 'Confirmed'\n"
                    + ",sum(if(status ='Completed',count,0)) 'Certified'\n"
                    + ",sum(if(status in ( 'Registration Invalid','Rejected'),count,0)) 'Invalid'\n"
                    + ",sum(if(status in ( 'enrolled','Prov. Enrolled','Registered','Request Registered'),count,0)) 'Registered'\n"
                    + ",sum(count) Total\n"
                    + "from participant_status1 group by workshop,name\n"
                    + "union all \n"
                    + "select \"All\" WorkshopId,' ' Workshopname\n"
                    + ", sum(if( status in ('Approved','Elig. Approved','Request Approved') ,count,0)) 'Approved'\n"
                    + ",sum(if(status in ('','1','Cancelled','incomplete','Request Verified','Waiting','Waitlisted','Withdrawn')  or status is null,count,0)) 'Cancelled'\n"
                    + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed','Completed'),count,0)) 'Confirmed'\n"
                    + ",sum(if(status ='Completed',count,0)) 'Certified'\n"
                    + ",sum(if(status in ( 'Registration Invalid','Rejected'),count,0)) 'Invalid'\n"
                    + ",sum(if(status in ( 'enrolled','Prov. Enrolled','Registered','Request Registered'),count,0)) 'Registered'\n"
                    + ",sum(count) Total\n"
                    + "from participant_status1";

            query2 = "select workshop as 'Workshop ID',name as 'Workshop Name'\n"
                    + ",sum(count) Registered\n"
                    + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed','Completed'),count,0)) 'Confirmed'\n"
                    + ",sum(if(status ='Completed',count,0)) 'Certified'\n"
                    + "from participant_status1 group by workshop,name\n"
                    + "union all\n"
                    + "select \"All\" WorkshopId,' ' Workshopname\n"
                    + ",sum(count) Registered\n"
                    + ",sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed','Completed'),count,0)) 'Confirmed'\n"
                    + ",sum(if(status ='Completed',count,0)) 'Certified'\n"
                    + "from participant_status1;";
            String query3 = "select workshop as 'Workshop ID',name as 'Workshop Name',DATE_FORMAT(startdate, '%d %M %Y') as startdate,DATE_FORMAT(enddate, '%d %M %Y') as enddate,sum(if( status in ('Approved','Elig. Approved','Request Approved') ,count,0)) 'Approved',sum(if(status in ('','1','Cancelled','incomplete','Request Verified','Waiting','Waitlisted','Withdrawn')  or status is null,count,0)) 'Cancelled',sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed','Completed'),count,0)) 'Confirmed',sum(if(status ='Completed',count,0)) 'Certified',sum(if(status in ( 'Registration Invalid','Rejected'),count,0)) 'Invalid',sum(if(status in ( 'enrolled','Prov. Enrolled','Registered','Request Registered'),count,0)) 'Registered',sum(count) Total from participant_status group by workshop,name";
            String query4 = "select workshop as 'Workshop ID',name as 'Workshop Name',DATE_FORMAT(startdate, '%d %M %Y') as startdate,DATE_FORMAT(enddate, '%d %M %Y') as enddate,sum(count) Registered,sum(if(status in ( 'Confirmed','Moodle Accessed','Request Confirmed','Completed'),count,0)) 'Confirmed',sum(if(status ='Completed',count,0)) 'Certified'from participant_status group by workshop,name";
            String fileName = null;
            if (type.equals("status")) {
                fileName = context + "Excel_Sheets/StatusWiseReport.xls";
            } else if (type.equals("summary")) {
                fileName = context + "Excel_Sheets/SummaryWiseReport.xls";
            }
            boolean result = false;
            if (type.equals("status")) {
                result = excel.createExcel(query3, fileName);
            } else if (type.equals("summary")) {
                result = excel.createExcel(query4, fileName);
            }
            if (result == true) {
                count = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;
    }

//     /*public ArrayList<RemoteCenter> listRemoteCentersStatewise(int state) {
//     ArrayList<RemoteCenter> remoteCenters = new ArrayList<RemoteCenter>();
//     try {
//     if (con == null || con.isClosed()) {
//     con = DBConnection.getDBConnection();
//     }
//     if (con != null) {
//     pstmt = con.prepareStatement("select r.remotecenterid,r.remotecentername,c.city from remotecenter r ,city c where r.city=c.cityid and r.state=? order by r.remotecenterid");
//     // pstmt1 = con.prepareStatement("Select reomtecenterid,remotecentername from remotecenter WHERE state=?");
//     pstmt.setInt(1, state);
//     res = pstmt.executeQuery();
//     RemoteCenter remoteCenter = null;
//     while (res.next()) {
//     remoteCenter = new RemoteCenter();
//     remoteCenter.setRemoteCenterId(res.getInt("remotecenterid"));
//     remoteCenter.setRemoteCenterName(res.getString("remotecentername"));
//     remoteCenter.setRc_city(res.getString("city"));
//     remoteCenters.add(remoteCenter);
//     }
//     }
//     } catch (SQLException sqle) {
//     sqle.printStackTrace();
//     } finally {
//     DBConnection.closeResultSet(res1);
//     DBConnection.closePStatement(pstmt1);
//     DBConnection.closeResultSet(res);
//     DBConnection.closePStatement(pstmt);
//     DBConnection.closeDBConnection(con);
//     }
//     return remoteCenters;
//     }*/
//
//     /*public int insertSurveyDetails(SurveyForm surveyform) {
//     int result = 0;
//     try {
//     if (con == null || con.isClosed()) {
//     con = DBConnection.getDBConnection();
//     }
//     if (con != null) {
//     pstmt = con.prepareStatement("insert into vc_survey(instituteid,email,comments,answer1,answer2,answer3,answer4,answer5,answer6,answer7,answer8,answer9,answer10) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
//     pstmt.setInt(1, surveyform.getRemotecenter().getRemoteCenterId());
//     pstmt.setString(2, surveyform.getEmail());
//     pstmt.setString(3, surveyform.getComments());
//     pstmt.setString(4, surveyform.getField1());
//     pstmt.setString(5, surveyform.getField2());
//     pstmt.setString(6, surveyform.getField3());
//     pstmt.setString(7, surveyform.getField4());
//     pstmt.setString(8, "");
//     pstmt.setString(9, "");
//     pstmt.setString(10, "");
//     pstmt.setString(11, "");
//     pstmt.setString(12, "");
//     pstmt.setString(13, "");
//     result = pstmt.executeUpdate();
//     }
//     } catch (SQLException sqle) {
//     sqle.printStackTrace();
//     } finally {
//     DBConnection.closeResultSet(res);
//     DBConnection.closePStatement(pstmt);
//     DBConnection.closeDBConnection(con);
//     }
//     return result;
//     }*/
//     
//     /*public int insertSurveyDetails(SurveyForm surveyform) {
//     int result = 0;
//     try {
//     if (con == null || con.isClosed()) {
//     con = DBConnection.getDBConnection();
//     }
//     if (con != null) {
//     pstmt = con.prepareStatement("insert into vc_survey(instituteid,email,comments,answer1,answer2,answer3,answer4,answer5,answer6,answer7,answer8,answer9,answer10) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
//     pstmt.setInt(1, surveyform.getRemotecenter().getRemoteCenterId());
//     pstmt.setString(2, surveyform.getEmail());
//     pstmt.setString(3, surveyform.getComments());
//     pstmt.setString(4, surveyform.getField1());
//     pstmt.setString(5, surveyform.getField2());
//     pstmt.setString(6, surveyform.getField3());
//     pstmt.setString(7, surveyform.getField4());
//     pstmt.setString(8, "");
//     pstmt.setString(9, "");
//     pstmt.setString(10, "");
//     pstmt.setString(11, "");
//     pstmt.setString(12, "");
//     pstmt.setString(13, "");
//     result = pstmt.executeUpdate();
//     }
//     } catch (SQLException sqle) {
//     sqle.printStackTrace();
//     } finally {
//     DBConnection.closeResultSet(res);
//     DBConnection.closePStatement(pstmt);
//     DBConnection.closeDBConnection(con);
//     }
//     return result;
//     } */
//    /**
//     *
//     * @return
//     */
//    /*public ArrayList<SurveyForm> getAllSurveyData() {
//     ArrayList<SurveyForm> surveyforms = new ArrayList<SurveyForm>();
//     try {
//     if (con == null || con.isClosed()) {
//     con = DBConnection.getDBConnection();
//     }
//     if (con != null) {
//     // pstmt = con.prepareStatement("select email,instituteid,comments,answer1,answer1,answer2,answer3,answer4,answer5,answer6,answer7,answer8,answer9,answer10 from vc_survey");
//     pstmt = con.prepareStatement("select s.email,r.remotecentername,c.city,s.instituteid,s.comments,s.answer1,s.answer1,s.answer2,s.answer3,s.answer4,s.answer5,s.answer6,s.answer7,s.answer8,s.answer9,s.answer10 from vc_survey s,remotecenter r,city c where r.remotecenterid=s.instituteid and r.city=c.cityid");
//     res = pstmt.executeQuery();
//     SurveyForm surveyform = null;
//     while (res.next()) {
//     surveyform = new SurveyForm();
//     RemoteCenter remotecenter = new RemoteCenter();
//     remotecenter.setRemoteCenterId(res.getInt("instituteid"));
//     remotecenter.setRemoteCenterName(res.getString("remotecentername") + "," + res.getString("city"));
//     surveyform.setRemotecenter(remotecenter);
//     surveyform.setEmail(res.getString("email"));
//     surveyform.setComments(res.getString("comments"));
//     surveyform.setField1(res.getString("answer1"));
//     surveyform.setField2(res.getString("answer2"));
//     surveyform.setField3(res.getString("answer3"));
//     surveyform.setField4(res.getString("answer4"));
//     surveyforms.add(surveyform);
//     }
//     }
//     } catch (SQLException sqle) {
//     sqle.printStackTrace();
//     } finally {
//     DBConnection.closeResultSet(res);
//     DBConnection.closeResultSet(res1);
//     DBConnection.closePStatement(pstmt);
//     DBConnection.closePStatement(pstmt1);
//     DBConnection.closeDBConnection(con);
//     }
//     return surveyforms;
//     }*/
//    /**
//     * this method return array list data of head details of particular
//     * institute
//     *
//     * @return
//     */
    public ArrayList<Summary> getWorkshopSummaryReport(String start_date, String end_date) throws ParseException {
        ArrayList<Summary> details = new ArrayList<Summary>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                DateFormat userDateFormat = new SimpleDateFormat("dd-mm-yyyy");
                DateFormat dateFormatNeeded = new SimpleDateFormat("yyyy-mm-dd");
                String query4 = "";
                /*
                 String query4 = "select w.workshopid,w.workshopname,categorycode,count(distinct a.rcid ) rc, count(distinct instituteid) as 'intstituteid',\n"
                 + "count(distinct city) as 'city', count(distinct state) as 'state',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total, sum(Male) as 'male',sum(unknown_exp) as 'unknown_exp',\n"
                 + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10'\n"
                 + ", sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others'\n"
                 + "from confirmed_participants a , workshops w\n"
                 + "where a.workshopid = w.workshopid\n"
                 + "and a.participantid in (select participantid from participant where status ='Confirmed')\n"
                 //  + "and (w.categorycode =5  or (w.categorycode=4 and w.respective_coordinatorid !=0))\n"
                 + "group by w.workshopid, w.workshopname ,categorycode\n"
                 + "order by startdate desc;";
                 */
                if (start_date.equals("none") && end_date.equals("none")) {
                    query4 = "select w.workshopid,w.workshopname,w.categorycode,count(distinct a.rcid ) rc, count(distinct instituteid) as 'intstituteid',count(distinct city) as 'city', count(distinct state) as 'state', "
                            + "sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total, sum(Male) as 'male',sum(unknown_exp) as 'unknown_exp', "
                            + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10', sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others' "
                            + " from confirmed_participants a , workshops w "
                            + "where a.workshopid = w.workshopid and w.workshopid > 0 and a.participantid in (select participantid from participant where status IN ('Confirmed','Moodle Accessed','Request Confirmed','Completed')) group by w.workshopid, w.workshopname ,w.categorycode order by w.startdate desc;";
                    pstmt = con.prepareStatement(query4);
                }
                if (!start_date.equals("none") && !end_date.equals("none")) {
                    query4 = "select w.workshopid,w.workshopname,w.categorycode,count(distinct a.rcid ) rc, count(distinct instituteid) as 'intstituteid',count(distinct city) as 'city', count(distinct state) as 'state', "
                            + "sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total, sum(Male) as 'male',sum(unknown_exp) as 'unknown_exp', "
                            + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10', sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others' "
                            + " from confirmed_participants a , workshops w "
                            + "where a.workshopid = w.workshopid and w.workshopid > 0 and w.startdate >= ? and w.startdate <= ? "
                            + " and a.participantid in (select participantid from participant where status IN ('Confirmed','Moodle Accessed','Request Confirmed','Completed')) group by w.workshopid, w.workshopname ,w.categorycode order by w.startdate desc;";
                    Date start_date_1 = userDateFormat.parse(start_date);
                    String start_date_2 = dateFormatNeeded.format(start_date_1);
                    Date end_date_1 = userDateFormat.parse(end_date);
                    String end_date_2 = dateFormatNeeded.format(end_date_1);
                    pstmt = con.prepareStatement(query4);
                    pstmt.setString(1, start_date_2);
                    pstmt.setString(2, end_date_2);
                }

                if (!start_date.equals("none") && end_date.equals("none")) {
                    query4 = "select w.workshopid,w.workshopname,w.categorycode,count(distinct a.rcid ) rc, count(distinct instituteid) as 'intstituteid',count(distinct city) as 'city', count(distinct state) as 'state', "
                            + "sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total, sum(Male) as 'male',sum(unknown_exp) as 'unknown_exp', "
                            + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10', sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others' "
                            + " from confirmed_participants a , workshops w "
                            + "where a.workshopid = w.workshopid and w.workshopid > 0 and w.startdate >= ? "
                            + "and a.participantid in (select participantid from participant where status IN ('Confirmed','Moodle Accessed','Request Confirmed','Completed')) group by w.workshopid, w.workshopname ,w.categorycode order by w.startdate desc;";
                    Date start_date_1 = userDateFormat.parse(start_date);
                    String start_date_2 = dateFormatNeeded.format(start_date_1);
                    pstmt = con.prepareStatement(query4);
                    pstmt.setString(1, start_date_2);
                }
                if (start_date.equals("none") && !end_date.equals("none")) {
                    query4 = "select w.workshopid,w.workshopname,w.categorycode,count(distinct a.rcid ) rc, count(distinct instituteid) as 'intstituteid',count(distinct city) as 'city', count(distinct state) as 'state', "
                            + "sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total, sum(Male) as 'male',sum(unknown_exp) as 'unknown_exp', "
                            + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10', sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others' "
                            + " from confirmed_participants a , workshops w "
                            + "where a.workshopid = w.workshopid and w.workshopid > 0 and  w.startdate <= ?"
                            + "and a.participantid in (select participantid from participant where status IN ('Confirmed','Moodle Accessed','Request Confirmed','Completed')) group by w.workshopid, w.workshopname ,w.categorycode order by w.startdate desc;";
                    Date end_date_1 = userDateFormat.parse(end_date);
                    String end_date_2 = dateFormatNeeded.format(end_date_1);
                    pstmt = con.prepareStatement(query4);
                    pstmt.setString(1, end_date_2);
                }
                res = pstmt.executeQuery();
                Summary summary = null;
                while (res.next()) {
                    summary = new Summary();
                    summary.setWorkshopid(res.getString("workshopid"));
                    summary.setWorkshopname(res.getString("workshopname"));
                    summary.setCategorycode(res.getString("categorycode"));
                    summary.setRcid(res.getString("rc"));
                    summary.setInstituteid(res.getString("intstituteid"));
                    summary.setCity(res.getString("city"));
                    summary.setState(res.getString("state"));
                    summary.setFemale(res.getString("female"));
                    summary.setMale(res.getString("male"));
                    summary.setUnknown_experience(res.getString("unknown_exp"));
                    summary.setExperience_lessthan2(res.getString("exp_less_than_2"));
                    summary.setExperience_2to10(res.getString("exp_2_to_10"));
                    summary.setExperience_greaterthan10(res.getString("exp_greater_than_10"));
                    summary.setDoctorate(res.getString("doctorate"));
                    summary.setPostgraduate(res.getString("postgraduate"));
                    summary.setGraduate(res.getString("graduate"));
                    summary.setDiploma(res.getString("diploma"));
                    summary.setOthers(res.getString("others"));
                    summary.setOther_gender(res.getString("other_gender"));
                    summary.setTotal(res.getString("total"));
                    details.add(summary);
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

    /**
     * this method return integer if query and excel file created successfully.
     *
     * @param type
     * @param context
     * @return
     */
    public int setQuery_ParticipantSummaryDetails(String type, String context) {
        int count = 0;
        String query1, query2;
        ExcelSheet excel = new ExcelSheet();
        try {
            query1 = "select w.workshopid,w.workshopname,sum(Male) as 'male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total from confirmed_participants a , workshops w where a.workshopid = w.workshopid and a.participantid in (select participantid from participant where status ='Confirmed') group by w.workshopid, w.workshopname ,categorycode order by startdate desc ";

            query2 = "select w.workshopid,w.workshopname,\n"
                    + "sum(unknown_exp) as 'unknown_exp',\n"
                    + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10',count(*) as total\n"
                    + "from confirmed_participants a , workshops w\n"
                    + "where a.workshopid = w.workshopid\n"
                    + "and a.participantid in (select participantid from participant where status ='Confirmed')\n"
                    //+ "and (w.categorycode =5  or (w.categorycode=4 and w.respective_coordinatorid !=0))\n"
                    + "group by w.workshopid, w.workshopname ,categorycode\n"
                    + "order by startdate desc";
            String query3 = "select w.workshopid,w.workshopname,\n"
                    + "sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others',count(*) as total \n"
                    + "from confirmed_participants a , workshops w\n"
                    + "where a.workshopid = w.workshopid\n"
                    + "and a.participantid in (select participantid from participant where status ='Confirmed')\n"
                    //+ "and (w.categorycode =5  or (w.categorycode=4 and w.respective_coordinatorid !=0))\n"
                    + "group by w.workshopid, w.workshopname ,categorycode\n"
                    + "order by startdate desc";
            String query4 = "select w.workshopid,w.workshopname,\n"
                    + "count(distinct city) as 'city', count(distinct state) as 'state',count(*) as total\n"
                    + "from confirmed_participants a , workshops w\n"
                    + "where a.workshopid = w.workshopid\n"
                    + "and a.participantid in (select participantid from participant where status ='Confirmed')\n"
                    //+ "and (w.categorycode =5  or (w.categorycode=4 and w.respective_coordinatorid !=0))\n"
                    + "group by w.workshopid, w.workshopname ,categorycode\n"
                    + "order by startdate desc";
            String query5 = "select w.workshopid,w.workshopname,count(distinct a.rcid ) rc, count(distinct instituteid) as 'intstituteid',\n"
                    + "count(distinct city) as 'city', count(distinct state) as 'state',count(*) as total \n"
                    + "from confirmed_participants a , workshops w\n"
                    + "where a.workshopid = w.workshopid\n"
                    + "and a.participantid in (select participantid from participant where status ='Confirmed')\n"
                    //+ "and (w.categorycode =5  or (w.categorycode=4 and w.respective_coordinatorid !=0))\n"
                    + "group by w.workshopid, w.workshopname ,categorycode\n"
                    + "order by startdate desc";
            String query6 = "select w.workshopid,w.workshopname,categorycode,count(distinct a.rcid ) rc, count(distinct instituteid) as 'intstituteid',\n"
                    + "count(distinct city) as 'city', count(distinct state) as 'state',sum(Female) as 'female',sum(otherg) as 'other_gender', sum(Male) as 'male',sum(unknown_exp) as 'unknown_exp',\n"
                    + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10'\n"
                    + ", sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others',count(*) as 'total participants' \n"
                    + "from confirmed_participants a , workshops w\n"
                    + "where a.workshopid = w.workshopid\n"
                    + "and a.participantid in (select participantid from participant where status ='Confirmed')\n"
                    //+ "and (w.categorycode =5  or (w.categorycode=4 and w.respective_coordinatorid !=0))\n"
                    + "group by w.workshopid, w.workshopname ,categorycode\n"
                    + "order by startdate desc";
            String fileName = null;
            if (type.equals("gender")) {
                fileName = context + "Excel_Sheets/GenderWiseReport.xls";
            } else if (type.equals("experience")) {
                fileName = context + "Excel_Sheets/ExperienceWiseReport.xls";
            } else if (type.equals("qualification")) {
                fileName = context + "Excel_Sheets/QualificationWiseReport.xls";
            } else if (type.equals("state_city")) {
                fileName = context + "Excel_Sheets/State_CityWiseReport.xls";
            } else if (type.equals("geographical")) {
                fileName = context + "Excel_Sheets/GeographicalWiseReport.xls";
            } else if (type.equals("all")) {
                fileName = context + "Excel_Sheets/AllReport.xls";
            }
            boolean result = false;
            if (type.equals("gender")) {
                result = excel.createExcel(query1, fileName);
            } else if (type.equals("experience")) {
                result = excel.createExcel(query2, fileName);
            } else if (type.equals("qualification")) {
                result = excel.createExcel(query3, fileName);
            } else if (type.equals("state_city")) {
                result = excel.createExcel(query4, fileName);
            } else if (type.equals("geographical")) {
                result = excel.createExcel(query5, fileName);
            } else if (type.equals("all")) {
                result = excel.createExcel(query6, fileName);
            }
            if (result == true) {
                count = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;
    }

    public ArrayList<Summary> getRCWiseReport(String start_date, String end_date) throws ParseException {
        ArrayList<Summary> details = new ArrayList<Summary>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                DateFormat userDateFormat = new SimpleDateFormat("dd-mm-yyyy");
                DateFormat dateFormatNeeded = new SimpleDateFormat("yyyy-mm-dd");
                String query5 = "";
//                String query4 = "select rcid, remotecentername, count(distinct workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid',sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total,sum(unknown_exp) as 'unknown_exp',\n"
//                        + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10'\n"
//                        + ", sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others' from confirmed_participants c,remotecenter r where r.remotecenterid = c.rcid group by (case when rcid in (0,-1) then \"Unknown\" else rcid end);";
                if (start_date.equals("none") && end_date.equals("none")) {

                    query5 = "select rcid, remotecentername ,s.state,ci.city, count(distinct c.workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid',sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total,sum(unknown_exp) as 'unknown_exp',\n"
                            + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10'\n"
                            + ", sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others' from confirmed_participants c,remotecenter r,state s,city ci where r.remotecenterid = c.rcid and r.state=s.stateid and r.city=ci.cityid group by (case when rcid in (0,-1) then \"Unknown\" else rcid end)";
                    pstmt = con.prepareStatement(query5);
                }
                if (!start_date.equals("none") && !end_date.equals("none")) {

                    query5 = "select rcid, remotecentername,s.state,ci.city, count(distinct c.workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid',sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total,sum(unknown_exp) as 'unknown_exp',\n"
                            + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10'\n"
                            + ", sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others' from confirmed_participants c,remotecenter r,state s,city ci, workshops w "
                            + "where c.workshopid=w.workshopid and w.workshopid > 0 and w.startdate >= ? and w.startdate <= ? and r.remotecenterid = c.rcid and r.state=s.stateid and r.city=ci.cityid group by (case when rcid in (0,-1) then \"Unknown\" else rcid end);";

                    Date start_date_1 = userDateFormat.parse(start_date);
                    String start_date_2 = dateFormatNeeded.format(start_date_1);
                    Date end_date_1 = userDateFormat.parse(end_date);
                    String end_date_2 = dateFormatNeeded.format(end_date_1);
                    pstmt = con.prepareStatement(query5);
                    pstmt.setString(1, start_date_2);
                    pstmt.setString(2, end_date_2);
                }
                if (!start_date.equals("none") && end_date.equals("none")) {

                    query5 = "select rcid, remotecentername,s.state,ci.city, count(distinct c.workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid',sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total,sum(unknown_exp) as 'unknown_exp',\n"
                            + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10'\n"
                            + ", sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others' from confirmed_participants c,remotecenter r,state s,city ci, workshops w "
                            + "where c.workshopid=w.workshopid and w.workshopid > 0 and w.startdate >= ?  and r.remotecenterid = c.rcid and r.state=s.stateid and r.city=ci.cityid group by (case when rcid in (0,-1) then \"Unknown\" else rcid end);";
                    Date start_date_1 = userDateFormat.parse(start_date);
                    String start_date_2 = dateFormatNeeded.format(start_date_1);
                    pstmt = con.prepareStatement(query5);
                    pstmt.setString(1, start_date_2);
                }
                if (start_date.equals("none") && !end_date.equals("none")) {

                    query5 = "select rcid, remotecentername,s.state,ci.city, count(distinct c.workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid',sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total,sum(unknown_exp) as 'unknown_exp',\n"
                            + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10'\n"
                            + ", sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others' from confirmed_participants c,remotecenter r,state s,city ci, workshops w "
                            + " where c.workshopid=w.workshopid and w.workshopid > 0 and  w.startdate <= ? and r.remotecenterid = c.rcid and r.state=s.stateid and r.city=ci.cityid group by (case when rcid in (0,-1) then \"Unknown\" else rcid end);";
                    Date end_date_1 = userDateFormat.parse(end_date);
                    String end_date_2 = dateFormatNeeded.format(end_date_1);
                    pstmt = con.prepareStatement(query5);
                    pstmt.setString(1, end_date_2);
                }

//                pstmt = con.prepareStatement(query5);
                res = pstmt.executeQuery();
                Summary summary = null;
                while (res.next()) {
                    summary = new Summary();
                    summary.setRcid(res.getString("rcid"));

                    String rc_name = res.getString("remotecentername");
                    rc_name = rc_name.replace('’', '\'');
                    summary.setRcname(rc_name);
                    summary.setWorkshopid(res.getString("workshopid"));
                    summary.setInstituteid(res.getString("instituteid"));
                    summary.setParticipantid(res.getString("participantid"));
                    summary.setFemale(res.getString("female"));
                    summary.setMale(res.getString("male"));
                    summary.setUnknown_experience(res.getString("unknown_exp"));
                    summary.setExperience_lessthan2(res.getString("exp_less_than_2"));
                    summary.setExperience_2to10(res.getString("exp_2_to_10"));
                    summary.setExperience_greaterthan10(res.getString("exp_greater_than_10"));
                    summary.setDoctorate(res.getString("doctorate"));
                    summary.setPostgraduate(res.getString("postgraduate"));
                    summary.setGraduate(res.getString("graduate"));
                    summary.setDiploma(res.getString("diploma"));
                    summary.setOthers(res.getString("others"));
                    summary.setOther_gender(res.getString("other_gender"));
                    summary.setTotal(res.getString("total"));
                    summary.setState(res.getString("state"));
                    summary.setCity(res.getString("city"));
                    details.add(summary);
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

    public int setQuery_RCWiseDetails(String type, String context) {
        int count = 0;
        String query1;
        ExcelSheet excel = new ExcelSheet();
        try {
            query1 = "select rcid, remotecentername,s.state,ci.city, count(distinct workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid',sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total,sum(unknown_exp) as 'unknown_exp',\n"
                    + "sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10'\n"
                    + ", sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others' from confirmed_participants c,remotecenter r,state s,city ci where r.remotecenterid = c.rcid and r.state=s.stateid and r.city=ci.cityid group by (case when rcid in (0,-1) then \"Unknown\" else rcid end);";

            String query2 = "select rcid, remotecentername,s.state,ci.city,sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total from confirmed_participants c,remotecenter r,state s,city ci where r.remotecenterid = c.rcid and r.state=s.stateid and r.city=ci.cityid group by (case when rcid in (0,-1) then \"Unknown\" else rcid end);";
            String query3 = "select rcid, remotecentername,s.state,ci.city,sum(unknown_exp) as 'unknown_exp',sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10',count(*) as total from confirmed_participants c,remotecenter r,state s,city ci where r.remotecenterid = c.rcid and r.state=s.stateid and r.city=ci.cityid group by (case when rcid in (0,-1) then \"Unknown\" else rcid end);";
            String query4 = "select rcid, remotecentername,s.state,ci.city,sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others',count(*) as total from confirmed_participants c,remotecenter r,state s,city ci where r.remotecenterid = c.rcid and r.state=s.stateid and r.city=ci.cityid group by (case when rcid in (0,-1) then \"Unknown\" else rcid end);";
            String query5 = "select rcid, remotecentername,s.state,ci.city,count(distinct workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid' from confirmed_participants c,remotecenter r,state s,city ci where r.remotecenterid = c.rcid and r.state=s.stateid and r.city=ci.cityid group by (case when rcid in (0,-1) then \"Unknown\" else rcid end);";
            /*
             * String fileName = null; fileName = context +
             * "Excel_Sheets/RCWiseReport.xls"; boolean result = false; result =
             * excel.createExcel(query1, fileName); if (result == true) { count
             * = 1; }
             */

            String fileName = null;
            if (type.equals("gender")) {
                fileName = context + "Excel_Sheets/RCGenderWiseReport.xls";
            } else if (type.equals("experience")) {
                fileName = context + "Excel_Sheets/RCExperienceWiseReport.xls";
            } else if (type.equals("qualification")) {
                fileName = context + "Excel_Sheets/RCQualificationWiseReport.xls";
            } else if (type.equals("geographical")) {
                fileName = context + "Excel_Sheets/RCGeographicalWiseReport.xls";
            } else if (type.equals("all")) {
                fileName = context + "Excel_Sheets/RCAllReport.xls";
            }
            boolean result = false;
            if (type.equals("gender")) {
                result = excel.createExcel(query2, fileName);
            } else if (type.equals("experience")) {
                result = excel.createExcel(query3, fileName);
            } else if (type.equals("qualification")) {
                result = excel.createExcel(query4, fileName);
            } else if (type.equals("geographical")) {
                result = excel.createExcel(query5, fileName);
            } else if (type.equals("all")) {
                result = excel.createExcel(query1, fileName);
            }
            if (result == true) {
                count = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;
    }

    public ArrayList<Summary> getStateWiseSummaryReport(String start_date, String end_date) throws ParseException {
        ArrayList<Summary> details = new ArrayList<Summary>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {

                DateFormat userDateFormat = new SimpleDateFormat("dd-mm-yyyy");
                DateFormat dateFormatNeeded = new SimpleDateFormat("yyyy-mm-dd");
                String query5 = "";
                if (start_date.equals("none") && end_date.equals("none")) {
                    query5 = "select s.state, count(distinct rcid) as 'rcid',count(distinct workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid'\n"
                            + ",sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total,\n"
                            + "sum(unknown_exp) as 'unknown_exp',sum(less_than_2) as 'exp_less_than_2',sum(2_to_10)\n"
                            + "as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10', sum(Doctorate) as 'doctorate',\n"
                            + "sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',\n"
                            + "sum(others) as 'others' from confirmed_participants c,remotecenter r,state s\n"
                            + "where r.remotecenterid = c.rcid and s.stateid=r.state group by r.state order by s.state;";
                    pstmt = con.prepareStatement(query5);
                }
                if (!start_date.equals("none") && !end_date.equals("none")) {
                    query5 = "select s.state, count(distinct rcid) as 'rcid',count(distinct c.workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid'\n"
                            + ",sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total,\n"
                            + "sum(unknown_exp) as 'unknown_exp',sum(less_than_2) as 'exp_less_than_2',sum(2_to_10)\n"
                            + "as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10', sum(Doctorate) as 'doctorate',\n"
                            + "sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',\n"
                            + "sum(others) as 'others' from confirmed_participants c,remotecenter r,state s, workshops w\n"
                            + "where c.workshopid=w.workshopid and w.workshopid > 0 and w.startdate >= ? and w.startdate <= ? and r.remotecenterid = c.rcid and s.stateid=r.state group by r.state order by s.state;";

                    Date start_date_1 = userDateFormat.parse(start_date);
                    String start_date_2 = dateFormatNeeded.format(start_date_1);
                    Date end_date_1 = userDateFormat.parse(end_date);
                    String end_date_2 = dateFormatNeeded.format(end_date_1);
                    pstmt = con.prepareStatement(query5);
                    pstmt.setString(1, start_date_2);
                    pstmt.setString(2, end_date_2);
                }
                if (!start_date.equals("none") && end_date.equals("none")) {
                    query5 = "select s.state, count(distinct rcid) as 'rcid',count(distinct c.workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid'\n"
                            + ",sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total,\n"
                            + "sum(unknown_exp) as 'unknown_exp',sum(less_than_2) as 'exp_less_than_2',sum(2_to_10)\n"
                            + "as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10', sum(Doctorate) as 'doctorate',\n"
                            + "sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',\n"
                            + "sum(others) as 'others' from confirmed_participants c,remotecenter r,state s, workshops w\n"
                            + "where c.workshopid=w.workshopid and w.workshopid > 0 and w.startdate >= ? and  r.remotecenterid = c.rcid and s.stateid=r.state group by r.state order by s.state;";

                    Date start_date_1 = userDateFormat.parse(start_date);
                    String start_date_2 = dateFormatNeeded.format(start_date_1);
                    pstmt = con.prepareStatement(query5);
                    pstmt.setString(1, start_date_2);
                }
                if (start_date.equals("none") && !end_date.equals("none")) {
                    query5 = "select s.state, count(distinct rcid) as 'rcid',count(distinct c.workshopid) as 'workshopid', count(distinct c.instituteid) as 'instituteid',count(participantid) as 'participantid'\n"
                            + ",sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total,\n"
                            + "sum(unknown_exp) as 'unknown_exp',sum(less_than_2) as 'exp_less_than_2',sum(2_to_10)\n"
                            + "as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10', sum(Doctorate) as 'doctorate',\n"
                            + "sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',\n"
                            + "sum(others) as 'others' from confirmed_participants c,remotecenter r,state s, workshops w\n"
                            + "where  c.workshopid=w.workshopid and w.workshopid > 0 and  w.startdate <= ? and  r.remotecenterid = c.rcid and s.stateid=r.state group by r.state order by s.state;";

                    Date end_date_1 = userDateFormat.parse(end_date);
                    String end_date_2 = dateFormatNeeded.format(end_date_1);
                    pstmt = con.prepareStatement(query5);
                    pstmt.setString(1, end_date_2);
                }
                res = pstmt.executeQuery();
                Summary summary = null;
                while (res.next()) {
                    summary = new Summary();
                    summary.setState(res.getString("state"));
                    summary.setRcid(res.getString("rcid"));
                    summary.setWorkshopid(res.getString("workshopid"));
                    summary.setInstituteid(res.getString("instituteid"));
                    summary.setParticipantid(res.getString("participantid"));
                    summary.setFemale(res.getString("female"));
                    summary.setMale(res.getString("male"));
                    summary.setUnknown_experience(res.getString("unknown_exp"));
                    summary.setExperience_lessthan2(res.getString("exp_less_than_2"));
                    summary.setExperience_2to10(res.getString("exp_2_to_10"));
                    summary.setExperience_greaterthan10(res.getString("exp_greater_than_10"));
                    summary.setDoctorate(res.getString("doctorate"));
                    summary.setPostgraduate(res.getString("postgraduate"));
                    summary.setGraduate(res.getString("graduate"));
                    summary.setDiploma(res.getString("diploma"));
                    summary.setOthers(res.getString("others"));
                    summary.setOther_gender(res.getString("other_gender"));
                    summary.setTotal(res.getString("total"));
                    details.add(summary);
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

    public int setQuery_RCStateWiseDetails(String type, String context) {
        int count = 0;
        String query1;
        ExcelSheet excel = new ExcelSheet();
        try {
            query1 = "select s.state, count(distinct rcid) as 'rc',count(distinct workshopid) as 'workshops', count(distinct c.instituteid) as 'institutes',count(participantid) as 'participants',sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',sum(unknown_exp) as 'unknown_exp',sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10', sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others',count(*) as total from confirmed_participants c,remotecenter r,state s where r.remotecenterid = c.rcid and s.stateid=r.state group by r.state order by s.state;";

            String query2 = "select s.state,sum(Male) as 'Male',sum(Female) as 'female',sum(otherg) as 'other_gender',count(*) as total from confirmed_participants c,remotecenter r,state s where r.remotecenterid = c.rcid and s.stateid=r.state group by r.state order by s.state;";
            String query3 = "select s.state ,sum(unknown_exp) as 'unknown_exp',sum(less_than_2) as 'exp_less_than_2',sum(2_to_10) as 'exp_2_to_10',sum(greater_than_10) as 'exp_greater_than_10'  from confirmed_participants c,remotecenter r,state s where r.remotecenterid = c.rcid and s.stateid=r.state group by r.state order by s.state;";
            String query4 = "select s.state, sum(Doctorate) as 'doctorate',sum(PostGraduate) as 'postgraduate',sum(Graduate) as 'graduate',sum(Diploma) as 'diploma',sum(others) as 'others',count(*) as total from confirmed_participants c,remotecenter r,state s where r.remotecenterid = c.rcid and s.stateid=r.state group by r.state order by s.state;";
            String query5 = "select s.state, count(distinct rcid) as 'rc',count(distinct workshopid) as 'workshops', count(distinct c.instituteid) as 'institutes',count(participantid) as 'participants' from confirmed_participants c,remotecenter r,state s where r.remotecenterid = c.rcid and s.stateid=r.state group by r.state order by s.state;";

            String fileName = null;
            if (type.equals("gender")) {
                fileName = context + "Excel_Sheets/RCStateGenderWiseReport.xls";
            } else if (type.equals("experience")) {
                fileName = context + "Excel_Sheets/RCStateExperienceWiseReport.xls";
            } else if (type.equals("qualification")) {
                fileName = context + "Excel_Sheets/RCStateQualificationWiseReport.xls";
            } else if (type.equals("geographical")) {
                fileName = context + "Excel_Sheets/RCStateGeographicalWiseReport.xls";
            } else if (type.equals("all")) {
                fileName = context + "Excel_Sheets/RCStateAllReport.xls";
            }
            boolean result = false;
            if (type.equals("gender")) {
                result = excel.createExcel(query2, fileName);
            } else if (type.equals("experience")) {
                result = excel.createExcel(query3, fileName);
            } else if (type.equals("qualification")) {
                result = excel.createExcel(query4, fileName);
            } else if (type.equals("geographical")) {
                result = excel.createExcel(query5, fileName);
            } else if (type.equals("all")) {
                result = excel.createExcel(query1, fileName);
            }
            if (result == true) {
                count = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;
    }

    public int RegiseterSurveyForm(SurveyForm surveyform) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (surveyform.getYesNofield().equals("yes")) {
                    pstmt = con.prepareStatement("insert into vc_survey(instituteid,email,answer1,answer2,answer3,answer4,answer5,answer6,answer7,answer8,answer9,answer10,answer11,answer12,answer13,answer14,answer15,answer16,answer17,answer18,answer19,answer20,answer21,answer22,answer23,name,answer24,answer25,answer26,designation) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                    pstmt.setInt(1, surveyform.getRemotecenter().getRemoteCenterId());
                    pstmt.setString(2, surveyform.getEmail());
                    pstmt.setString(3, surveyform.getYesPartQ1_1());
                    pstmt.setString(4, surveyform.getYesPartQ1_2());
                    pstmt.setString(5, surveyform.getYesPartQ1_3());
                    pstmt.setString(6, surveyform.getYesPartQ1_4());
                    pstmt.setString(7, surveyform.getYesPartQ1_5());
                    pstmt.setString(8, surveyform.getYesPartQ1_6());
                    pstmt.setString(9, surveyform.getYesPartQ1_7());
                    pstmt.setString(10, surveyform.getYesPartQ1_8());
                    pstmt.setString(11, surveyform.getYesPartQ2_1_1());
                    pstmt.setString(12, surveyform.getYesPartQ2_1_2());
                    pstmt.setString(13, surveyform.getYesPartQ2_1_3());
                    pstmt.setString(14, surveyform.getYesPartQ2_1_4());
                    pstmt.setString(15, surveyform.getYesPartQ2_2_1());
                    pstmt.setString(16, surveyform.getYesPartQ2_2_2());
                    pstmt.setString(17, surveyform.getYesPartQ2_2_3());
                    pstmt.setString(18, surveyform.getYesPartQ2_2_4());
                    pstmt.setString(19, surveyform.getYesPartQ2_3_1());
                    pstmt.setString(20, surveyform.getYesPartQ2_3_2());
                    pstmt.setString(21, surveyform.getYesPartQ2_3_3());
                    pstmt.setString(22, surveyform.getYesPartQ2_3_4());
                    pstmt.setString(23, surveyform.getYesPartQ3());
                    pstmt.setString(24, surveyform.getYesPartQ4());
                    pstmt.setString(25, surveyform.getYesPartQ5());
                    pstmt.setString(26, surveyform.getName());
                    pstmt.setString(27, surveyform.getYesPartQ7());
                    pstmt.setString(28, surveyform.getYesPartQ8());
                    pstmt.setString(29, surveyform.getYesPartQ9());
                    pstmt.setString(30, surveyform.getDesignation());
                    result = pstmt.executeUpdate();
                } else if (surveyform.getYesNofield().equals("no")) {
                    pstmt = con.prepareStatement("insert into vc_survey(instituteid,answerNo,surveypdf) values(?,?,?)");
                    pstmt.setInt(1, surveyform.getRemotecenter().getRemoteCenterId());
                    pstmt.setString(2, surveyform.getNoPartQ1());
                    pstmt.setString(3, surveyform.getSurvey_pdf());
                    result = pstmt.executeUpdate();
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

    public int checkAlreadyRegisterInSurvey(int rcid) {
        int result = 0, id = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select instituteid from vc_survey where instituteid=?");
                pstmt.setInt(1, rcid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    id = res.getInt("instituteid");
                }
                if (id == 0) {
                    result = 0;
                } else if (id > 0) {
                    result = 1;
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

    public ArrayList<AttendanceSchedule> getProgramSchedule(String workshopid) {
        ArrayList<AttendanceSchedule> details = new ArrayList<AttendanceSchedule>();
        int if_time_slot_null = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //pstmt = con.prepareStatement("select streamid,head_title,headname,heademail,head_designation,headaddress,head_contact from academic where instituteid=?");
                pstmt = con.prepareStatement("select *, DATE_FORMAT( date, ' %M %D, %Y' ) as date1, DATE_FORMAT( update_till, '%d-%m-%Y' ) AS update_till1 from  program_schedule where workshopid=? order by date, time_from");
                pstmt.setString(1, workshopid);
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

                    // increment if_time_slot_null or blank
                    if (res.getString("time_from").trim().equals("") || res.getString("time_to").trim().equals("") || res.getString("time_from").equals(null) || res.getString("time_to").equals(null)) {
                        obj_details.setIf_time_slot_null(if_time_slot_null + 1);
                    }

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

    // function for updating the comments
    public int updateSessionComment(String comment, String id, String time_from, String time_to, int isActive, String update_till) {
        int result = 0;
        String workshopid = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.

                pstmt = con.prepareStatement("update program_schedule set comments=?, time_from=?, isActive=?, time_to=?, update_till=? where id=? ");
                //binding the parameter values to query statement
                pstmt.setString(1, comment);
                pstmt.setString(2, time_from);
                pstmt.setInt(3, isActive);
                pstmt.setString(4, time_to);
                pstmt.setString(5, update_till);
                pstmt.setString(6, id);
                result = pstmt.executeUpdate();

                pstmt = con.prepareStatement("select * from program_schedule where id=?");
                pstmt.setString(1, id);
                res = pstmt.executeQuery();
                while (res.next()) {
                    workshopid = res.getString("workshopid");
                    String date = res.getString("date");

                    pstmt = con.prepareStatement("update program_schedule set update_till=? where workshopid=? and date=?");
                    pstmt.setString(1, update_till);
                    pstmt.setString(2, workshopid);
                    pstmt.setString(3, date);
                    result = result + pstmt.executeUpdate();
                }
                /**
                 * If active =0 , delete from attendance sheet, if 1 - create
                 * sheet
                 */
                if (isActive == 0) {
                    pstmt1 = con.prepareStatement("delete from attendance where session=?");
                    pstmt1.setString(1, id);
                    pstmt1.execute();
                }
                if (isActive == 1) {
                    int ifAttendanceSheetCreated = ifAttendanceCreated(workshopid);

                    if (con == null || con.isClosed()) {
                        con = DBConnection.getDBConnection();
                    }
                    if (ifAttendanceSheetCreated > 0) {
                        pstmt1 = con.prepareStatement("select count(*) as count from attendance where session=?");
                        pstmt1.setString(1, id);
                        res1 = pstmt1.executeQuery();

                        while (res1.next()) {
                            int count = res1.getInt("count");
                            if (count == 0) {
                                pstmt1 = con.prepareStatement("insert into  attendance (workshopid,participantid,rcid,session)  select a.workshopid,a.participantid,a.instituteid,ps.id from accomodation a ,participant p, program_schedule ps  where a.workshopid=? and ps.id=? and a.participantid =p.participantid and p.status='Confirmed' and ps.workshopid=a.workshopid and ps.isActive=1");
                                pstmt1.setString(1, workshopid);
                                pstmt1.setString(2, id);
                                pstmt1.executeUpdate();
                            }
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
        return result;
    }

    public int insertNewSession(String comment, String date, String workshopid, String time_slot_from, String time_slot_to, int isActive, String update_till) throws ParseException {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                DateFormat userDateFormat = new SimpleDateFormat("dd-mm-yyyy");
                DateFormat dateFormatNeeded = new SimpleDateFormat("yyyy-mm-dd");
                Date date_1 = userDateFormat.parse(date);
                String date_2 = dateFormatNeeded.format(date_1);
                Date date3 = userDateFormat.parse("0000-00-00");
                String date_till1 = update_till;
                if (!date_till1.equals("") && !date_till1.equals(null)) {
                    date3 = userDateFormat.parse(date_till1);
                }
                String date4 = dateFormatNeeded.format(date3);
                pstmt = con.prepareStatement("select IFNULL(max(sessionid)+1,1) as session from program_schedule where workshopid=? and  date=?");
                //binding the parameter values to query statement
                pstmt.setString(1, workshopid);
                pstmt.setString(2, date_2);
                res = pstmt.executeQuery();
                while (res.next()) {
                    String session = res.getString("session");
                    pstmt = con.prepareStatement("insert into program_schedule (workshopid,date,sessionid,comments, time_from, isActive,time_to, update_till) values (?,?,?,?,?,?,?,?)");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, date_2);
                    pstmt.setString(3, session);
                    pstmt.setString(4, comment);
                    pstmt.setString(5, time_slot_from);
                    pstmt.setInt(6, isActive);
                    pstmt.setString(7, time_slot_to);
                    pstmt.setString(8, date4);
                    result = pstmt.executeUpdate();
                    /*
                     * new code
                     */
                    int nextId = 0;
                    if (result > 0) {
                        pstmt = con.prepareStatement("select max(id) as nid from program_schedule");
                        res = pstmt.executeQuery();
                        while (res.next()) {
                            nextId = res.getInt("nid");
                        }
                        if (nextId > 0) {
                            pstmt = con.prepareStatement("insert into  attendance (workshopid,participantid,rcid,session) select a.workshopid,a.participantid,a.instituteid,ps.id from accomodation a ,participant p, program_schedule ps  where a.workshopid=? and a.participantid =p.participantid and p.status='Confirmed' and p.participantid IN (select distinct(participantid) from attendance where workshopid=?) and ps.workshopid=a.workshopid and ps.isActive=1 and ps.id=?");
                            pstmt.setString(1, workshopid);
                            pstmt.setString(2, workshopid);
                            pstmt.setInt(3, nextId);
                            pstmt.executeUpdate();
                        }
                    }
                    /*
                     * new code end here
                     */
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

    public int deleteSession(String id) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.

                pstmt = con.prepareStatement("delete from program_schedule where id=?");
                pstmt.setString(1, id);
                result = pstmt.executeUpdate();
                pstmt = con.prepareStatement("delete from attendance where session=?");
                pstmt.setString(1, id);
                result += pstmt.executeUpdate();
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

    // function for updating the comments
    public RemoteCenter getRemoteCenterOfUser(String id) {
        RemoteCenter rc = new RemoteCenter();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.

                pstmt = con.prepareStatement("select r.remotecenterid, r.remotecentername, r.state as stateid, s.state from remotecenter r, state s, partuserdata p where r.state=s.stateid and p.rcid=r.remotecenterid and p.userinterfaceid=? ");
                //binding the parameter values to query statement
                pstmt.setString(1, id);
                res = pstmt.executeQuery();
                while (res.next()) {
                    // set the remote center                    
                    rc.setRemoteCenterId(res.getInt("remotecenterid"));
                    rc.setRemoteCenterName(res.getString("remotecentername"));
                    rc.setRc_state(res.getString("stateid"));
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return rc;
    }

    public int createAttendanceSheet(String workshopid) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.

                pstmt = con.prepareStatement("insert into  attendance (workshopid,participantid,rcid,session)  select a.workshopid,a.participantid,a.instituteid,ps.id from accomodation a ,participant p, program_schedule ps  where a.workshopid=? and a.participantid =p.participantid and p.status='Confirmed' and ps.workshopid=a.workshopid and ps.isActive=1");
                pstmt.setString(1, workshopid);
                result = pstmt.executeUpdate();
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

    public ArrayList<AttendanceSheet> getAttendanceSheet(String workshopid) {
        ArrayList<AttendanceSheet> details = new ArrayList<AttendanceSheet>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //pstmt = con.prepareStatement("select streamid,head_title,headname,heademail,head_designation,headaddress,head_contact from academic where instituteid=?");
                pstmt = con.prepareStatement("select distinct(participantid), rcid from attendance where workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                AttendanceSheet obj_details = null;
                while (res.next()) {
                    String participantid = res.getString(1);
                    String rcid = res.getString(2);
                    pstmt1 = con.prepareStatement("select * from attendance where participantid = ?");
                    pstmt1.setString(1, participantid);
                    res1 = pstmt1.executeQuery();
                    obj_details = new AttendanceSheet();
                    obj_details.setParticipantid(participantid);
                    obj_details.setRcid(rcid);
                    ArrayList<String> id = new ArrayList<String>();
                    ArrayList<String> isPresent = new ArrayList<String>();
                    ArrayList<String> sessionid = new ArrayList<String>();
                    while (res1.next()) {
                        id.add(res1.getString("id"));
                        isPresent.add(res1.getString("isPresent"));
                        sessionid.add(res1.getString("session"));
                    }
                    obj_details.setId(id);
                    obj_details.setIsPresent(isPresent);
                    obj_details.setSessionid(sessionid);

                    details.add(obj_details);
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
        return details;
    }

    public ArrayList<AttendanceSchedule> getProgramSchedule1(String workshopid, String rcid) {
        ArrayList<AttendanceSchedule> details = new ArrayList<AttendanceSchedule>();
        PreparedStatement pstmt3 = null;
        ResultSet res3 = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select date,DATE_FORMAT( date, ' %M %D, %Y' ) as date1, count(sessionid) as no_of_sessions from program_schedule WHERE workshopid=? and isActive=1 group by date order by date asc");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                AttendanceSchedule obj_details = null;
                while (res.next()) {
                    obj_details = new AttendanceSchedule();
                    obj_details.setDate_string(res.getString("date1"));
                    obj_details.setDateOfSession(res.getString("date"));
                    obj_details.setNumberOfSessions(res.getString("no_of_sessions"));

                    // get distinct participant id of workshop from attendance table
                    if (rcid.equals("all") || rcid.equals("All")) {
                        pstmt1 = con.prepareStatement("select distinct(participantid), rcid from attendance where workshopid=?");
                        pstmt1.setString(1, workshopid);
                    } else {
                        pstmt1 = con.prepareStatement("select distinct(participantid), rcid from attendance where workshopid=? and rcid=?");
                        pstmt1.setString(1, workshopid);
                        pstmt1.setString(2, rcid);
                    }
                    res1 = pstmt1.executeQuery();
                    ArrayList<AttendanceSheet> sheetlist = new ArrayList<AttendanceSheet>();
                    while (res1.next()) {
                        AttendanceSheet as = new AttendanceSheet();
                        as.setParticipantid(res1.getString("participantid"));
                        as.setRcid(res1.getString("rcid"));

                        pstmt3 = con.prepareStatement("select per.firstname, per.lastname, c.email from person per, context c, participant p where p.personid=per.personid and c.idcontext=p.personid and p.participantid=?");
                        pstmt3.setString(1, res1.getString("participantid"));
                        res3 = pstmt3.executeQuery();
                        while (res3.next()) {
                            Person p = new Person();
                            p.setFirstName(res3.getString("firstname"));
                            p.setLastName(res3.getString("lastname"));
                            p.setEmail(res3.getString("email"));
                            as.setParticipantDetail(p);
                        }

                        pstmt2 = con.prepareStatement("select id, session, isPresent from attendance where session IN (select distinct(id) from program_schedule where isActive=1 and date=? and workshopid=? order by time_from) and participantid=?");
                        pstmt2.setString(1, res.getString("date"));
                        pstmt2.setString(2, workshopid);
                        pstmt2.setString(3, res1.getString("participantid"));
                        res2 = pstmt2.executeQuery();
                        ArrayList<String> id = new ArrayList<String>();
                        ArrayList<String> isPresent = new ArrayList<String>();
                        ArrayList<String> sessionid = new ArrayList<String>();
                        int attendance_count = 0;
                        while (res2.next()) {
                            id.add(res2.getString("id"));
                            isPresent.add(res2.getString("isPresent"));
                            sessionid.add(res2.getString("session"));
                            as.setId(id);
                            as.setIsPresent(isPresent);
                            as.setSessionid(sessionid);
                            if (res2.getString("isPresent").equals("Yes")) {
                                attendance_count++;
                            }
                            /*
                             * pstmt3 = con.prepareStatement("select count(*) as
                             * no_session_attend from program_schedule
                             * ps,attendance a where ps.id=a.session and
                             * a.workshopid=? and a.isPresent='Yes' and
                             * a.participantid=? and ps.date=?");
                             * pstmt3.setString(1, workshopid);
                             * pstmt3.setString(2,
                             * res1.getString("participantid"));
                             * pstmt3.setString(3, res.getString("date")); res3
                             * = pstmt3.executeQuery(); if(res3.next()){ //
                             * while (res3.next()) {
                             * obj_details.setSessionAttend(res3.getString("no_session_attend"));
                             * }else{ obj_details.setSessionAttend("0"); }
                             * System.out.println(res1.getString("participantid")+"
                             * "+res.getString("date")+"
                             * "+obj_details.getSessionAttend());
                             */
                        }
                        as.setSessionAttended(String.valueOf(attendance_count));
                        //obj_details.setSessionAttend(String.valueOf(attendance_count));
                        sheetlist.add(as);
                    }
                    obj_details.setAs(sheetlist);
                    details.add(obj_details);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res3);
            DBConnection.closePStatement(pstmt3);
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return details;
    }

    public ArrayList<AttendanceSchedule> getProgramSchedule2(String workshopid, String rcid, String date) {
        ArrayList<AttendanceSchedule> details = new ArrayList<AttendanceSchedule>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (date.equals("none")) {
                    // no program schedule is set
                } else {
                    if (date.equals("all")) {
                        pstmt = con.prepareStatement("select date,DATE_FORMAT( date, ' %M %D, %Y' ) as date1, count(sessionid) as no_of_sessions from program_schedule WHERE workshopid=? and isActive=1 group by date order by date asc");
                        pstmt.setString(1, workshopid);
                    } else {
                        pstmt = con.prepareStatement("select date,DATE_FORMAT( date, ' %M %D, %Y' ) as date1, count(sessionid) as no_of_sessions from program_schedule WHERE workshopid=? and isActive=1 and date=? group by date order by date asc");
                        pstmt.setString(1, workshopid);
                        pstmt.setString(2, date);
                    }

                    res = pstmt.executeQuery();
                    AttendanceSchedule obj_details = null;
                    while (res.next()) {
                        obj_details = new AttendanceSchedule();
                        obj_details.setDate_string(res.getString("date1"));
                        obj_details.setDateOfSession(res.getString("date"));
                        obj_details.setNumberOfSessions(res.getString("no_of_sessions"));

                        // get distinct participant id of workshop from attendance table
                        if (rcid.equals("all") || rcid.equals("All")) {
                            pstmt1 = con.prepareStatement("select distinct(participantid), rcid from attendance where workshopid=?");
                            pstmt1.setString(1, workshopid);
                        } else {
                            pstmt1 = con.prepareStatement("select distinct(participantid), rcid from attendance where workshopid=? and rcid=?");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setString(2, rcid);
                        }
                        res1 = pstmt1.executeQuery();
                        ArrayList<AttendanceSheet> sheetlist = new ArrayList<AttendanceSheet>();
                        while (res1.next()) {
                            AttendanceSheet as = new AttendanceSheet();
                            as.setParticipantid(res1.getString("participantid"));
                            as.setRcid(res1.getString("rcid"));

                            pstmt3 = con.prepareStatement("select per.firstname, per.lastname, c.email from person per, context c, participant p where p.personid=per.personid and c.idcontext=p.personid and p.participantid=?");
                            pstmt3.setString(1, res1.getString("participantid"));
                            res3 = pstmt3.executeQuery();
                            while (res3.next()) {
                                Person p = new Person();
                                p.setFirstName(res3.getString("firstname"));
                                p.setLastName(res3.getString("lastname"));
                                p.setEmail(res3.getString("email"));
                                as.setParticipantDetail(p);
                            }

                            pstmt2 = con.prepareStatement("select id, session, isPresent  from attendance where session IN (select distinct(id) from program_schedule where isActive=1 and date=? and workshopid=? order by time_from) and participantid=?");
                            pstmt2.setString(1, res.getString("date"));
                            pstmt2.setString(2, workshopid);
                            pstmt2.setString(3, res1.getString("participantid"));
                            res2 = pstmt2.executeQuery();
                            ArrayList<String> id = new ArrayList<String>();
                            ArrayList<String> isPresent = new ArrayList<String>();
                            ArrayList<String> sessionid = new ArrayList<String>();
                            while (res2.next()) {
                                id.add(res2.getString("id"));
                                isPresent.add(res2.getString("isPresent"));
                                sessionid.add(res2.getString("session"));
                                as.setId(id);
                                as.setIsPresent(isPresent);
                                as.setSessionid(sessionid);

                                pstmt4 = con.prepareStatement("select ((CURDATE() >= date) && ( CURDATE() <= update_till)) as ifCanBeUpdated from program_schedule where id=?");
                                pstmt4.setString(1, res2.getString("session"));
                                res4 = pstmt4.executeQuery();
                                while (res4.next()) {
                                    as.setIfAttendanceCanBeUpdated(res4.getInt("ifCanBeUpdated"));
                                }
                            }
                            sheetlist.add(as);
                        }
                        obj_details.setAs(sheetlist);
                        details.add(obj_details);
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res4);
            DBConnection.closePStatement(pstmt4);
            DBConnection.closeResultSet(res3);
            DBConnection.closePStatement(pstmt3);
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return details;
    }

    public ArrayList<AttendanceSchedule> getDistinctDateProgramSchedule(String workshopid) {
        ArrayList<AttendanceSchedule> details = new ArrayList<AttendanceSchedule>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select date,DATE_FORMAT( date, ' %d  %b  %Y ' ) as date1, count(sessionid) as no_of_sessions, ((CURDATE() >= date) && ( CURDATE() <= update_till)) as ifCanBeUpdated from program_schedule WHERE workshopid=? group by date order by date asc");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                AttendanceSchedule obj_details = null;
                while (res.next()) {
                    obj_details = new AttendanceSchedule();
                    obj_details.setDate_string(res.getString("date1"));
                    obj_details.setDateOfSession(res.getString("date"));
                    obj_details.setNumberOfSessions(res.getString("no_of_sessions"));
                    obj_details.setTime_slot(res.getString("ifCanBeUpdated"));
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

    public ArrayList<AttendanceSchedule> getDistinctDateProgramSchedule1(String workshopid, String rcid) {
        ArrayList<AttendanceSchedule> details = new ArrayList<AttendanceSchedule>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select date,DATE_FORMAT( date, ' %d  %b  %Y ' ) as date1, count(sessionid) as no_of_sessions, ((CURDATE() >= date) && ( CURDATE() <= update_till)) as ifCanBeUpdated from program_schedule WHERE workshopid=? group by date order by date asc");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                AttendanceSchedule obj_details = null;
                while (res.next()) {
                    obj_details = new AttendanceSchedule();
                    obj_details.setDate_string(res.getString("date1"));
                    obj_details.setDateOfSession(res.getString("date"));
                    obj_details.setNumberOfSessions(res.getString("no_of_sessions"));
                    obj_details.setTime_slot(res.getString("ifCanBeUpdated"));

                    pstmt1 = con.prepareStatement("select distinct(isPresent) from attendance where session IN (select id from program_schedule where date=?) and rcid=? order by isPresent desc");
                    pstmt1.setString(1, res.getString("date"));
                    pstmt1.setString(2, rcid);
                    res1 = pstmt1.executeQuery();
                    if (res1.next()) {
                        if (res1.getString("isPresent").equals("Yes")) {
                            obj_details.setIfUpdatedByWSC(1);
                        } else {
                            obj_details.setIfUpdatedByWSC(0);
                        }
                    }
                    details.add(obj_details);
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
        return details;
    }

    public int ifExistInRelevantCoordinatorWorkshop(int workshopid, int userid) {
        int result = 0;
        int rcid = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.

                // check in nominated coordinators table
                pstmt = con.prepareStatement("select * from wsc_nominations wsc, context c where wsc.workshopid=? and c.email=wsc.nominated_email and c.idcontext=? and wsc.active_till >= CURDATE()");
                pstmt.setInt(1, workshopid);
                pstmt.setInt(2, userid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    rcid = res.getInt("rcid");
                    if (rcid > 0) {
                        result = rcid;
                    }
                }
                // check if original workshop coordinator, if no check if he is normal wsc

                if (rcid == 0) {

                    pstmt = con.prepareStatement("select * from wsc_nominations wsc, context c where wsc.workshopid=? and c.email=wsc.coordinator_email and c.idcontext=? and wsc.active_till >= CURDATE()");
                    pstmt.setInt(1, workshopid);
                    pstmt.setInt(2, userid);
                    res = pstmt.executeQuery();
                    if (res.next()) {
//                        System.out.println("coordinator already nominated.. cant login as wsc now");
                    } else {
                        pstmt = con.prepareStatement("select wc.* from workshop_coordinator wc where wc.workshopid=? and wc.contextid=? ");
                        pstmt.setInt(1, workshopid);
                        pstmt.setInt(2, userid);
                        res = pstmt.executeQuery();
                        while (res.next()) {
//                            System.out.println("Inside workshop coordinator table");
                            rcid = res.getInt("rcid");
                            if (rcid > 0) {
                                result = rcid;
                            }
                        }
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

    public int ifExistInRelevantRCC(int workshopid, String email) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select rcd.* from remotecenter rcd where rcd.remotecenterid IN (select distinct(a.instituteid) from accomodation a, participant p where  a.participantid=p.participantid and p.status IN ('Confirmed' , 'Completed' ) and a.workshopid=?)  and rcd.active=1  and rcd.email=?");
                pstmt.setInt(1, workshopid);
                pstmt.setString(2, email);
                res = pstmt.executeQuery();
                while (res.next()) {
                    result = res.getInt("remotecenterid");
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

    public int ifRCC(String email) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select rcd.* from remotecenter rcd where rcd.email=?");
                pstmt.setString(1, email);
                res = pstmt.executeQuery();
                while (res.next()) {
                    result = res.getInt("remotecenterid");
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

    public int ifAttendanceCreated(String workshopid) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select * from attendance where workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    result = 1;
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

    public ArrayList<Person> getdataLoginButNotReg() {
        ArrayList<Person> details = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query1 = "select login.login_id, login.login_name,person.firstname,person.lastname ,institute.idinstitute,institute.institutename from login, person,institute  where person.personid=login.login_id and institute.idinstitute=person.instituteid and  not exists (select contextid from participant where participant.contextid=login.login_id) and login.usertypeid=1";
                pstmt = con.prepareStatement(query1);
                res = pstmt.executeQuery();
                Person obj_details = null;
                while (res.next()) {
                    obj_details = new Person();
                    obj_details.setLoginId(res.getInt("login_id"));
                    obj_details.setEmail(res.getString("login_name"));
                    obj_details.setFirstName(res.getString("firstname"));
                    obj_details.setLastName(res.getString(("lastname")));
                    Institute insti = new Institute();
                    insti.setInstituteId(res.getInt("idinstitute"));
                    insti.setInstituteName(res.getString("institutename"));
                    obj_details.setInstitute(insti);
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

    public int setQuery_loginButNotRegisterData(String context) {
        int count = 0;
        String query;
        ExcelSheet excel = new ExcelSheet();
        try {
            query = "select login.login_id, login.login_name,person.firstname,person.lastname ,institute.institutename from login, person,institute  where person.personid=login.login_id and institute.idinstitute=person.instituteid and  not exists (select contextid from participant where participant.contextid=login.login_id) and login.usertypeid=1";
            String fileName = null;
            fileName = context + "Excel_Sheets/LoginButNotRegister.xls";
            boolean result = excel.createExcel(query, fileName);
            if (result == true) {
                count = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;
    }

    public int updateSessionCommentOfParticipant(String workshopid, String participantid, String date, String session_values) {
        int result = 0, iteratorVar = 0, sessionAttended = 0;
        String[] sessionvalues = null;
        if (session_values != "" || session_values != null) {
            try {
                sessionvalues = session_values.split(",");
            } catch (Exception e) {
            }
        }
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select * from attendance where participantid=? and session IN (select id from program_schedule where workshopid=? and isActive=1 and date=? order by time_from asc)");
                pstmt.setString(1, participantid);
                pstmt.setString(2, workshopid);
                pstmt.setString(3, date);
                //System.out.println(pstmt);
                res = pstmt.executeQuery();
                while (res.next()) {
                    // get id for updating row
                    int id = res.getInt("id");
                    pstmt1 = con.prepareStatement("update attendance set isPresent=? where id=?");
                    pstmt1.setString(1, sessionvalues[iteratorVar]);
                    pstmt1.setInt(2, id);
                    result = pstmt1.executeUpdate();
                    //System.out.println(pstmt1);
                    iteratorVar++;
                }
                //System.out.println(result);
                if (result > 0) {
                    sessionAttended++;
                    pstmt2 = con.prepareStatement("select count(*) as no_session_attend from  program_schedule ps,attendance a where ps.id=a.session and a.workshopid=?  and a.isPresent='Yes' and a.participantid=? and ps.date=? group by ps.date;");
                    pstmt2.setString(1, workshopid);
                    pstmt2.setString(2, participantid);
                    pstmt2.setString(3, date);
                    res2 = pstmt2.executeQuery();
                    while (res2.next()) {
                        sessionAttended = sessionAttended + res2.getInt("no_session_attend");
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return sessionAttended;
    }

    public String getStatusReason(String participantid, String status) {
        String reason = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select * from participantreasons where participantid=? and status =? ");
                pstmt.setString(1, participantid);
                pstmt.setString(2, status);
                res = pstmt.executeQuery();
                while (res.next()) {
                    reason = res.getString("reasons");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return reason;
    }

    public int getCount1(String workshopid, String rcid, String status) {
        int countOfParticipants = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (rcid.equals("all") && status.equals("all")) {
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=?");
                    pstmt.setString(1, workshopid);
                }
                if (!rcid.equals("all") && status.equals("all")) {
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=? and a.instituteid=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, rcid);
                }
                if (rcid.equals("all") && !status.equals("all")) {
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=?  and p.status=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, status);
                }
                if (!rcid.equals("all") && !status.equals("all")) {
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=? and a.instituteid=?  and p.status=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, rcid);
                    pstmt.setString(3, status);
                }
                res = pstmt.executeQuery();
                while (res.next()) {
                    countOfParticipants = res.getInt(1);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return countOfParticipants;
    }

    public int storeParticipantReasons(int action, ParticipantReasons preasons) {
        int resUp = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query1 = "insert into participantreasons(workshopid,participantid,status,reasons,last_update,update_by) values(?,?,?,?,now(),?)";
                String query2 = "update participantreasons set reasons=?,last_update=now(),update_by=? where workshopid=? and participantid=? and status =?";
                if (action == 1) {
                    pstmt = con.prepareStatement(query1);
                    pstmt.setInt(1, preasons.getWorkshopid());
                    pstmt.setInt(2, preasons.getParticipantid());
                    pstmt.setString(3, preasons.getStatus());
                    pstmt.setString(4, preasons.getReason());
                    pstmt.setInt(5, preasons.getUpdateby());
                    resUp = pstmt.executeUpdate();
                } else if (action == 0) {
                    pstmt = con.prepareStatement(query2);
                    pstmt.setString(1, preasons.getReason());
                    pstmt.setInt(2, preasons.getUpdateby());
                    pstmt.setInt(3, preasons.getWorkshopid());
                    pstmt.setInt(4, preasons.getParticipantid());
                    pstmt.setString(5, preasons.getStatus());
                    resUp = pstmt.executeUpdate();
                }

            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return resUp;
    }

    public int getparticipantWorkshopId(int p_id) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query1 = "select workshopid from accomodation where participantid=?";
                pstmt = con.prepareStatement(query1);
                pstmt.setInt(1, p_id);
                res = pstmt.executeQuery();
                while (res.next()) {
                    result = res.getInt("workshopid");
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

    public int checkWorkshopIdInReasons(int w_id, int p_id, String reason_status) {
        int result = 0;
        String status = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query1 = "select status from participantreasons where workshopid=? and participantid=? and status=?";
                pstmt = con.prepareStatement(query1);
                pstmt.setInt(1, w_id);
                pstmt.setInt(2, p_id);
                pstmt.setString(3, reason_status);
                res = pstmt.executeQuery();
                while (res.next()) {
                    status = res.getString("status");
                }
                if (status.trim() != "" && status != null) {
                    result = 1;
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
     * this function return the attendance details of particular participant
     *
     * @param workshopid
     * @param participantid
     * @return
     */
    public ArrayList<AttendanceSchedule> getViewParticipantAttendance(String workshopid, String participantid) {
        ArrayList<AttendanceSchedule> details = new ArrayList<AttendanceSchedule>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query1 = "select date,DATE_FORMAT( date, ' %M %D, %Y' ) as date1, count(sessionid) as no_of_sessions from program_schedule WHERE workshopid=? and isActive=1 group by date order by date asc";
                pstmt = con.prepareStatement(query1);
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                AttendanceSchedule obj_details = null;
                while (res.next()) {
                    obj_details = new AttendanceSchedule();
                    obj_details.setDateOfSession(res.getString("date"));
                    obj_details.setDate_string(res.getString("date1"));
                    obj_details.setNumberOfSessions(res.getString("no_of_sessions"));
                    pstmt1 = con.prepareStatement("select count(*) as no_session_attend from  program_schedule ps,attendance a where ps.id=a.session and a.workshopid=?  and a.isPresent='Yes' and a.participantid=? and ps.date=? group by ps.date;");
                    pstmt1.setString(1, workshopid);
                    pstmt1.setString(2, participantid);
                    pstmt1.setString(3, res.getString("date"));
                    res2 = pstmt1.executeQuery();
                    while (res2.next()) {
                        obj_details.setSessionAttend(res2.getString("no_session_attend"));
                    }
                    details.add(obj_details);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return details;
    }

    public ArrayList<AttendanceSheet> getAttendanceSheetConsolidated(String workshopid, String rc) {
        ArrayList<AttendanceSheet> details = new ArrayList<AttendanceSheet>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //pstmt = con.prepareStatement("select streamid,head_title,headname,heademail,head_designation,headaddress,head_contact from academic where instituteid=?");
                //pstmt = con.prepareStatement("select distinct(participantid), rcid from attendance where workshopid=? and rcid=?");
                pstmt = con.prepareStatement("select distinct(at.participantid), at.rcid,per.firstname,per.lastname,c.email,rc.remotecentername,ci.city from attendance at,person per,participant pa,context c,remotecenter rc,city ci where at.participantid=pa.participantid and pa.personid=per.personid and per.personid=c.idcontext and at.rcid=rc.remotecenterid and rc.city=ci.cityid and workshopid=? and rcid=?");
                pstmt.setString(1, workshopid);
                pstmt.setString(2, rc);
                res = pstmt.executeQuery();
                AttendanceSheet obj_details = null;
                while (res.next()) {
                    String participantid = res.getString(1);
                    String rcid = res.getString(2);
                    // pstmt1 = con.prepareStatement("select * from attendance where participantid = ?");
                    pstmt1 = con.prepareStatement("select at.workshopid,at.participantid,at.rcid,at.session,at.isPresent,at.id from attendance at,program_schedule p where at.participantid = ? and at.session=p.id order by p.date,time_from");
                    pstmt1.setString(1, participantid);
                    res1 = pstmt1.executeQuery();
                    obj_details = new AttendanceSheet();
                    obj_details.setParticipantid(participantid);
                    obj_details.setRcid(rcid);
                    Person per = null;
                    per = new Person();
                    per.setEmail(res.getString("email"));
                    per.setLastName(res.getString("lastname"));
                    per.setFirstName(res.getString("firstname"));
                    RemoteCenter rc_obj = new RemoteCenter();
                    rc_obj.setRemoteCenterName(res.getString("remotecentername"));
                    rc_obj.setRc_city(res.getString("city"));
                    per.setRemoteCenter(rc_obj);
                    obj_details.setParticipantDetail(per);
                    ArrayList<String> id = new ArrayList<String>();
                    ArrayList<String> isPresent = new ArrayList<String>();
                    ArrayList<String> sessionid = new ArrayList<String>();
                    while (res1.next()) {
                        id.add(res1.getString("id"));
                        isPresent.add(res1.getString("isPresent"));
                        sessionid.add(res1.getString("session"));
                        pstmt3 = con.prepareStatement("select (select count(*) from  program_schedule ps,attendance a where ps.id=a.session and a.workshopid=?  and a.isPresent='Yes' and a.participantid=?) as no_session_attend,(select count(*) from  program_schedule ps,attendance a where ps.id=a.session and a.workshopid=? and a.participantid=?) as total_sessions");
                        pstmt3.setString(1, workshopid);
                        pstmt3.setString(2, res1.getString("participantid"));
                        pstmt3.setString(3, workshopid);
                        pstmt3.setString(4, res1.getString("participantid"));
                        res3 = pstmt3.executeQuery();
                        while (res3.next()) {
                            obj_details.setSessionAttended(res3.getString("no_session_attend"));
                            obj_details.setTotalSessions(res3.getString("total_sessions"));
                        }

                    }
                    obj_details.setId(id);
                    obj_details.setIsPresent(isPresent);
                    obj_details.setSessionid(sessionid);

                    details.add(obj_details);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res3);
            DBConnection.closePStatement(pstmt3);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return details;
    }

    public String insertUploadScannedAttendance(int w_id, int rc_id, String filename, String date, int loginid) {
        int result = 0;
        String file_name = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                int upload_id = 0;
                pstmt = con.prepareStatement("select max(id) as id from uploadscannedattendancedetails");
                res = pstmt.executeQuery();
                if (res.next()) {
                    upload_id = res.getInt("id");
                    upload_id++;
                    file_name = filename + "_" + upload_id + ".pdf";
                    // System.out.println("id "+upload_id);
                }

                String query1 = "insert into uploadscannedattendancedetails(id,workshopid,rcid,filename,date,updated_by,updated_on) values(?,?,?,?,?,?,now())";
                pstmt = con.prepareStatement(query1);
                pstmt.setInt(1, upload_id);
                pstmt.setInt(2, w_id);
                pstmt.setInt(3, rc_id);
                pstmt.setString(4, file_name);
                pstmt.setString(5, date);
                pstmt.setInt(6, loginid);
                result = pstmt.executeUpdate();

                if (result > 0) {
                    return file_name;
                } else {
                    file_name = "error";
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return file_name;
    }

    public ArrayList<AttendanceSheet> getUploadAttendaceByRC(String workshopid, String rcid) {
        ArrayList<AttendanceSheet> details = new ArrayList<AttendanceSheet>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query1 = "select filename,DATE_FORMAT( date, ' %M %D, %Y' ) as date from uploadscannedattendancedetails where workshopid=? and rcid=?";
                pstmt = con.prepareStatement(query1);
                pstmt.setString(1, workshopid);
                pstmt.setString(2, rcid);
                res = pstmt.executeQuery();
                AttendanceSheet obj_details = null;
                while (res.next()) {
                    obj_details = new AttendanceSheet();
                    obj_details.setUpload_fileName(res.getString("filename"));
                    obj_details.setUpload_date(res.getString("date"));
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

    public int checkWSCCanUpload(String workshopid, String rcid) throws ParseException {
        int result = 0, query_res = 0, date_res = 0;
        String target = "", current = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //pstmt = con.prepareStatement("select count(*) as total from accomodation where workshopid=? and instituteid=?");
                pstmt = con.prepareStatement("select count(*) as total from accomodation a ,participant p where a.participantid=p.participantid and  a.workshopid=? and a.instituteid=? and p.status='Confirmed'");
                pstmt.setString(1, workshopid);
                pstmt.setString(2, rcid);
                res = pstmt.executeQuery();
                if (res.next()) {
                    query_res = res.getInt("total");
                }

                pstmt2 = con.prepareStatement("SELECT IFNULL(DATE_ADD(max(update_till), INTERVAL 2 DAY), 'NONE') AS target_date,now() as 'current_date' from program_schedule where workshopid=?");
                pstmt2.setString(1, workshopid);
                res2 = pstmt2.executeQuery();
                if (res2.next()) {
                    target = res2.getString("target_date");
                    current = res2.getString("current_date");
                }
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date2 = sdf.parse(current);

                if (!target.equals("NONE")) {
                    Date date1 = sdf.parse(target);

                    if ((date2.compareTo(date1) < 0) || (date2.compareTo(date1) == 0)) {
                        date_res = 1;
                    }
                } else {
                    date_res = 0;
                }

                if (query_res > 0 && date_res > 0) {
                    result = 1;
                }

            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }

    public ArrayList<AttendanceSchedule> getProgramSchedule_ConsolidatedAttendace(String workshopid, String rcid, String date) {
        ArrayList<AttendanceSchedule> details = new ArrayList<AttendanceSchedule>();
        PreparedStatement pstmt3 = null;
        ResultSet res3 = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select date,DATE_FORMAT( date, ' %M %D, %Y' ) as date1, count(sessionid) as no_of_sessions from program_schedule WHERE workshopid=? and isActive=1  and date=? group by date order by date asc");
                pstmt.setString(1, workshopid);
                pstmt.setString(2, date);
                res = pstmt.executeQuery();
                AttendanceSchedule obj_details = null;
                while (res.next()) {
                    obj_details = new AttendanceSchedule();
                    obj_details.setDate_string(res.getString("date1"));
                    obj_details.setDateOfSession(res.getString("date"));
                    obj_details.setNumberOfSessions(res.getString("no_of_sessions"));

                    // get distinct participant id of workshop from attendance table
                    if (rcid.equals("all") || rcid.equals("All")) {
                        pstmt1 = con.prepareStatement("select distinct(participantid), rcid from attendance where workshopid=? order by rcid");
                        pstmt1.setString(1, workshopid);
                    } else {
                        pstmt1 = con.prepareStatement("select distinct(participantid), rcid from attendance where workshopid=? and rcid=?");
                        pstmt1.setString(1, workshopid);
                        pstmt1.setString(2, rcid);
                    }
                    res1 = pstmt1.executeQuery();
                    ArrayList<AttendanceSheet> sheetlist = new ArrayList<AttendanceSheet>();
                    while (res1.next()) {
                        AttendanceSheet as = new AttendanceSheet();
                        as.setParticipantid(res1.getString("participantid"));
                        as.setRcid(res1.getString("rcid"));

                        String query = "select per.firstname, per.lastname, c.email,rc.remotecenterid,rc.remotecentername,ci.city from person per, context c, participant p,remotecenter rc,accomodation am,city ci where p.personid=per.personid and c.idcontext=p.personid and p.participantid=am.participantid and am.instituteid=rc.remotecenterid and rc.city=ci.cityid and p.participantid=?";
                        // pstmt3 = con.prepareStatement("select per.firstname, per.lastname, c.email from person per, context c, participant p where p.personid=per.personid and c.idcontext=p.personid and p.participantid=?");
                        pstmt3 = con.prepareStatement(query);
                        pstmt3.setString(1, res1.getString("participantid"));
                        res3 = pstmt3.executeQuery();
                        while (res3.next()) {
                            Person p = new Person();
                            p.setFirstName(res3.getString("firstname"));
                            p.setLastName(res3.getString("lastname"));
                            p.setEmail(res3.getString("email"));
                            RemoteCenter rc_ob = new RemoteCenter();
                            rc_ob.setRemoteCenterId(res3.getInt("remotecenterid"));
                            rc_ob.setRemoteCenterName(res3.getString("remotecentername") + "," + res3.getString("city"));
                            p.setRemoteCenter(rc_ob);
                            as.setParticipantDetail(p);
                        }

                        pstmt2 = con.prepareStatement("select id, session, isPresent from attendance where session IN (select distinct(id) from program_schedule where isActive=1 and date=? and workshopid=? order by time_from) and participantid=?");
                        pstmt2.setString(1, res.getString("date"));
                        pstmt2.setString(2, workshopid);
                        pstmt2.setString(3, res1.getString("participantid"));
                        res2 = pstmt2.executeQuery();
                        ArrayList<String> id = new ArrayList<String>();
                        ArrayList<String> isPresent = new ArrayList<String>();
                        ArrayList<String> sessionid = new ArrayList<String>();
                        int attendance_count = 0;
                        while (res2.next()) {
                            id.add(res2.getString("id"));
                            isPresent.add(res2.getString("isPresent"));
                            sessionid.add(res2.getString("session"));
                            as.setId(id);
                            as.setIsPresent(isPresent);
                            as.setSessionid(sessionid);
                            if (res2.getString("isPresent").equals("Yes")) {
                                attendance_count++;
                            }
                        }
                        as.setSessionAttended(String.valueOf(attendance_count));
                        //obj_details.setSessionAttend(String.valueOf(attendance_count));
                        sheetlist.add(as);
                    }
                    obj_details.setAs(sheetlist);
                    details.add(obj_details);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res3);
            DBConnection.closePStatement(pstmt3);
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return details;
    }

    public ArrayList<Person> listParticipants_CertificatePurpose(String workshopid, String rcid, String status) throws Exception {
        ArrayList<Person> participantList = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                /**
                 * The category code is fetched to fetch the list from the table
                 * and to determine if it is a coordinator workshop or a main
                 * workshop
                 */
                pstmt = con.prepareStatement("Select categorycode, respective_coordinatorid from workshops WHERE workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                Person list = null;
                while (res.next()) {
                    int categorycode = res.getInt("categorycode");
                    int res_coord_id = res.getInt("respective_coordinatorid");
                    if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                        /**
                         * category 5 is main workshop. the conditions are used
                         * to select the query depending on the status and rcid.
                         */
                        if ((rcid).equals("all") && (status).equals("all")) {
                            if (categorycode == 8) {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid, i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.eligible_for_certificate='yes' order by p.regtime");
                            } else {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid, i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                            }
                            pstmt1.setString(1, workshopid);
                        } else if (!rcid.equals("all") && status.equals("all")) {
                            if (categorycode == 8) {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and a.instituteid=? and p.eligible_for_certificate='yes' order by p.regtime");
                            } else {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and a.instituteid=? order by p.regtime");
                            }
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(rcid));
                        } else if (!rcid.equals("all") && !status.equals("all")) {
                            if (categorycode == 8) {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and a.instituteid=? and p.status=? and p.eligible_for_certificate='yes' order by p.regtime");
                            } else {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and a.instituteid=? and p.status=? order by p.regtime");
                            }
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(rcid));
                            pstmt1.setString(3, status);
                        } else if (rcid.equals("all") && !status.equals("all")) {
                            if (categorycode == 8) {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? and p.eligible_for_certificate='yes' order by p.regtime");
                            } else {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                            }
                            pstmt1.setString(1, workshopid);
                            pstmt1.setString(2, status);
                        }
                    } else {
                        if (categorycode == 4 && res_coord_id == 0) {
                            /**
                             * category 4 is coordinator workshop, the
                             * conditions are used to select the query depending
                             * on the status and rcid
                             */
                            if (rcid.equals("all") && status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname, per.genderinfo,c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name FROM accomodation a, remotecenter r, designation d, person per, participant p , letter l,context  c , state s, city ci, stream st where ci.cityid=r.city and s.stateid=r.state and p.participantid=a.participantid and p.contextid=c.idcontext and per.personid=p.personid and a.instituteid=r.remotecenterid and d.iddesignation=per.designation and l.participantid=p.participantid and st.idstream=p.streamid and a.workshopid=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname, per.genderinfo,c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name,p.instituteid FROM accomodation a left join remotecenter r on a.instituteid=r.remotecenterid left join  participant p on p.participantid=a.participantid left join person per on per.personid=p.personid left join designation d on d.iddesignation=per.designation left join  letter l on l.participantid=p.participantid left join context c on p.contextid=c.idcontext left join  state s on s.stateid=r.state left join  city ci on ci.cityid=r.city left join   stream st on  st.idstream=p.streamid where a.workshopid=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                            } else if (rcid.equals("all") && !status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname, per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name FROM accomodation a, remotecenter r, designation d, person per, participant p , letter l,context  c , state s, city ci, stream st where ci.cityid=r.city and s.stateid=r.state and p.participantid=a.participantid and p.contextid=c.idcontext and per.personid=p.personid and a.instituteid=r.remotecenterid and d.iddesignation=per.designation and l.participantid=p.participantid and st.idstream=p.streamid and a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname, per.genderinfo,c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name,p.instituteid FROM accomodation a left join remotecenter r on a.instituteid=r.remotecenterid left join  participant p on p.participantid=a.participantid left join person per on per.personid=p.personid left join designation d on d.iddesignation=per.designation left join  letter l on l.participantid=p.participantid left join context c on p.contextid=c.idcontext left join  state s on s.stateid=r.state left join  city ci on ci.cityid=r.city left join   stream st on  st.idstream=p.streamid where a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                                pstmt1.setString(2, status);
                            }
                        }
                        if ((categorycode == 4 && res_coord_id != 0) || categorycode == 6) {
                            /**
                             * category 4 is coordinator workshop, the
                             * conditions are used to select the query depending
                             * on the status and rcid
                             */
                            if (rcid.equals("all") && status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,p.instituteid,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                            } else if (rcid.equals("all") && !status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,p.instituteid,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                                pstmt1.setString(2, status);
                            }
                        }
                    }
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        pstmt3 = con.prepareStatement("select CONCAT('Prof.', ' ', per.firstname , ' ' , per.lastname) as wsc_name from person per, participant p, accomodation a, ParticipantTitle t where a.instituteid=? and workshopid=? and a.participantid=p.participantid and p.personid=per.personid and t.participant_titlte_id=per.title_id");
                        // pstmt3 = con.prepareStatement("select CONCAT(t.participanttitle, ' ', per.firstname , ' ' , per.lastname) as wsc_name from person per, participant p, accomodation a, ParticipantTitle t where a.instituteid=? and workshopid=? and a.participantid=p.participantid and p.personid=per.personid and t.participant_titlte_id=per.title_id");
                        pstmt3.setInt(1, res1.getInt("remotecenterid"));
                        pstmt3.setInt(2, res_coord_id);
                        res3 = pstmt3.executeQuery();

                        list = new Person();

                        /**
                         * Set the details of the remote center of the
                         * participant in the ArrayList
                         */
                        RemoteCenter rc = new RemoteCenter();
                        rc.setRemoteCenterName(res1.getString("remotecentername"));
                        rc.setRc_state(res1.getString("state"));
                        rc.setRc_city(res1.getString("city"));
                        rc.setRemoteCenterId(res1.getInt("remotecenterid"));
                        while (res3.next()) {
                            rc.setRc_coordinator_email(res3.getString("wsc_name"));
                        }
                        list.setRemoteCenter(rc);
                        /**
                         * set the First Name, Last Name , mobile and email of
                         * the participant
                         */
                        list.setImage("photo_" + res1.getString("personid") + ".jpg");
                        list.setFirstName(res1.getString("firstname"));
                        list.setLastName(res1.getString("lastname"));
                        list.setMobileNumber(res1.getString("mobile"));
                        SimpleStringCipher cipher = new SimpleStringCipher();
                        String email_enc = cipher.encrypt(res1.getString("email"));
                        list.setEmail_enc(email_enc);
                        list.setEmail(res1.getString("email"));
                        /**
                         * set the registration details status, registration
                         * time , letter name, accommodation
                         */
                        RegistrationDetails registrationDetails = new RegistrationDetails();
                        registrationDetails.setStatus(res1.getString("status"));
                        registrationDetails.setRegtime(res1.getDate("regtime"));
                        registrationDetails.setLetter(res1.getString("letter"));
                        registrationDetails.setAccomodation(res1.getString("accomodation"));
                        registrationDetails.setParticipantid(res1.getString("participantid"));
                        list.setRegistrationDetails(registrationDetails);

                        Designation designation = new Designation();
                        designation.setDesignationName(res1.getString("designation"));
                        list.setDesignation(designation);
                        /**
                         * set the gender
                         */
                        list.setGender(res1.getString("genderinfo"));
                        /**
                         * Add the institute details if it is a main workshop
                         */
                        if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                            Institute institute = new Institute();
                            institute.setInstituteName(res1.getString("institutename"));
                            institute.setInstituteId(res1.getInt("instituteid"));
                            list.setInstitute(institute);
                        } else {
                            Institute institute = new Institute();
                            institute.setInstituteName("cc4");
                            list.setInstitute(institute);
                        }

                        /**
                         * Set qualification and experience
                         */
                        Qualification qualification = new Qualification();
                        qualification.setQualification(res1.getString("qualification"));
                        list.setQualification(qualification);

                        list.setExperience(res1.getString("experience"));
                        /**
                         * add stream in the list
                         */
                        Stream stream = new Stream();
                        stream.setStreamName(res1.getString("stream_name"));
                        list.setStream(stream);
                        /**
                         * add the details in the array list
                         */
                        /**
                         * Adding the status Matrix
                         */
                        StatusMatrix sm = new StatusMatrix();

                        pstmt2 = con.prepareStatement("select * from status_matrix where InitialStatus=?");
                        pstmt2.setString(1, res1.getString("status"));
                        res2 = pstmt2.executeQuery();
                        if (res2.next()) {
                            sm.setIfDisplayRegistered(res2.getString("Registered"));
                            sm.setIfDisplayInvalid(res2.getString("Invalid"));
                            sm.setIfDisplayApproved(res2.getString("Approved"));
                            sm.setIfDisplayConfirmed(res2.getString("Confirmed"));
                            sm.setIfDisplayCompleted(res2.getString("Completed"));
                            sm.setIfDisplayCancelled(res2.getString("Cancelled"));

                        }
                        list.setStatusMatrix(sm);

                        participantList.add(list);
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res3);
            DBConnection.closePStatement(pstmt3);
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participantList;
    }

    public int changeState_BMW(int userinterfaceid, String val) {
        int updated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating query for updating the remote center capacity.
                if (val.equals("enable") || val.equals("disable")) {
                    int id = userinterfaceid * (-1);
                    pstmt = con.prepareStatement("update partuserdata set userinterfaceid = ? where userinterfaceid = ?");
                    pstmt.setInt(1, id);
                    pstmt.setInt(2, userinterfaceid);
                    updated = pstmt.executeUpdate();
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return updated;
    }

    public int insertPDFGenerateCode(String w_id, String rc_id, String pdfcode, String date, int loginid) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                int upload_id = 0;
                pstmt = con.prepareStatement("select max(id) as id from generatepdfcode");
                res = pstmt.executeQuery();
                if (res.next()) {
                    upload_id = res.getInt("id");
                    upload_id++;
                }
                String query1 = "insert into generatepdfcode(id,workshopid,rcid,generatecode,date,generated_by,generated_on) values(?,?,?,?,?,?,now())";
                pstmt = con.prepareStatement(query1);
                pstmt.setInt(1, upload_id);
                pstmt.setInt(2, Integer.parseInt(w_id));
                pstmt.setInt(3, Integer.parseInt(rc_id));
                pstmt.setString(4, pdfcode);
                pstmt.setString(5, date);
                pstmt.setInt(6, loginid);
                result = pstmt.executeUpdate();
                if (result > 0) {
                    result = 1;
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

    public int setQuery_RCDetailsData(String context) {
        int count = 0;
        String query;
        ExcelSheet excel = new ExcelSheet();
        try {
            query = "select r.remotecenterid,r.remotecentername,c.city,s.state,r.active, r.pincode, r.district, IFNULL(r.email,'') as email, IFNULL(r.status,'') as status, r.Instituteid, i.Institutename, r.autonomous, IFNULL(r.acd_cal_startdate,'') as acd_cal_startdate, IFNULL(affiliated_university,'') as affiliated_university from remotecenter r left join city c on r.city=c.cityid left join state s on s.stateid=r.state left join institute i on i.idInstitute=r.Instituteid order by sign(remotecenterid) desc,abs(remotecenterid)";
            String fileName = null;
            fileName = context + "Excel_Sheets/RCDetails.xls";
            boolean result = excel.createExcel(query, fileName);
            if (result == true) {
                count = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;
    }

    public String WSC_email(String workshopid, String rcid) {
        String wsc_email = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select * from workshop_coordinator where workshopid=? and rcid=? ");
                pstmt.setString(1, workshopid);
                pstmt.setString(2, rcid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    wsc_email = res.getString("email");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return wsc_email;
    }

    public int nominateWSC(WSCNominations nomination) throws ParseException {
        int value = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("insert into wsc_nominations(workshopid, rcid, coordinator_email,nominated_email,active_till,updated_by) values(?,?,?,?,?,?)");
                pstmt.setInt(1, nomination.getWc().getWorkshopid());
                pstmt.setInt(2, nomination.getRc().getRemoteCenterId());
                pstmt.setString(3, nomination.getCooridnator_email());
                pstmt.setString(4, nomination.getNominee_email().trim());

                SimpleDateFormat userdateFormat = new SimpleDateFormat("dd-MM-yyyy");
                SimpleDateFormat requiredFormat = new SimpleDateFormat("yyyy-MM-dd");

                Date active_till_1 = userdateFormat.parse(nomination.getActive_till());
                String active_till = requiredFormat.format(active_till_1);
                pstmt.setString(5, active_till);
                pstmt.setInt(6, nomination.getPerson().getLoginId());
                value = pstmt.executeUpdate();

            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return value;
    }

    public ArrayList<WSCNominations> getWSCNominations() throws ParseException {
        ArrayList<WSCNominations> nominations = new ArrayList<WSCNominations>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select n.*, (date_add(w.enddate, INTERVAL 15 DAY) < CURDATE()) as expiry from wsc_nominations n, workshops w where n.workshopid = w.workshopid order by w.enddate desc");
                res = pstmt.executeQuery();
                while (res.next()) {
                    WSCNominations n = new WSCNominations();
                    n.setId(res.getInt("id"));
                    WorkshopContent wc = new WorkshopContent();
                    wc.setWorkshopid(res.getInt("workshopid"));
                    n.setWc(wc);
                    RemoteCenter rc = new RemoteCenter();
                    rc.setRemoteCenterId(res.getInt("rcid"));
                    n.setRc(rc);
                    n.setCooridnator_email(res.getString("coordinator_email"));
                    n.setNominee_email(res.getString("nominated_email"));
                    n.setExpiry(res.getInt("expiry"));
                    SimpleDateFormat userdateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    SimpleDateFormat requiredFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date active_till_1 = requiredFormat.parse(res.getString("active_till"));
                    String active_till = userdateFormat.format(active_till_1);
                    n.setActive_till(active_till);
                    nominations.add(n);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return nominations;
    }

    public int updatedNominatedWSC(String id, String active_till) throws ParseException {
        int updated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                SimpleDateFormat userdateFormat = new SimpleDateFormat("dd-MM-yyyy");
                SimpleDateFormat requiredFormat = new SimpleDateFormat("yyyy-MM-dd");

                Date active_till_1 = userdateFormat.parse(active_till);
                String active_till_req = requiredFormat.format(active_till_1);

                pstmt = con.prepareStatement("update wsc_nominations set active_till=? where id=? ");
                pstmt.setString(1, active_till_req);
                pstmt.setString(2, id);
                updated = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return updated;
    }

    public String checkIfExistInWSCNominations(String workshopid, String rcid) {
        String wsc_email_exist = "0";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select * from wsc_nominations where workshopid=? and rcid=? ");
                pstmt.setString(1, workshopid);
                pstmt.setString(2, rcid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    wsc_email_exist = "1";
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return wsc_email_exist;
    }

    public ArrayList<RemoteCenterCapacity> rccDetails_admin(int workshopid, int state) throws Exception {
        ArrayList<RemoteCenterCapacity> remotecenterCapacity = new ArrayList<RemoteCenterCapacity>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query = "";
                if (state == 0) {
                    query = "select c.rcid, r.remotecentername , c.available_seats, c.available_accomo,c.workshopid, ci.city, s.state, c.acco_cost, c.food_cost from remotecenter r , remotecentercapacity c, city ci, state s where r.state=s.stateid and r.remotecenterid = c.rcid and workshopid = ? and ci.cityid=r.city  order by c.rcid ";
                    pstmt = con.prepareStatement(query);
                    pstmt.setInt(1, workshopid);
                } else {
                    query = "select c.rcid, r.remotecentername , c.available_seats, c.available_accomo,c.workshopid, ci.city, s.state, c.acco_cost, c.food_cost from remotecenter r , remotecentercapacity c, city ci, state s where r.state=s.stateid and r.remotecenterid = c.rcid and workshopid = ? and r.state=? and ci.cityid=r.city order by c.rcid ";
                    pstmt = con.prepareStatement(query);
                    pstmt.setInt(1, workshopid);
                    pstmt.setInt(2, state);
                }

                res = pstmt.executeQuery();
                RemoteCenterCapacity rccContent = null;
                while (res.next()) {
                    rccContent = new RemoteCenterCapacity();
                    rccContent.setRcid(res.getInt("rcid"));
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String rcc_enc = cipher.encrypt(res.getString("rcid"));
                    rccContent.setRcid_enc(rcc_enc);
                    rccContent.setAvailable_accomo(res.getInt("available_accomo"));
                    rccContent.setAvailable_seats(res.getInt("available_seats"));
                    rccContent.setRemotecentername(res.getString("remotecentername") + ", " + res.getString("city"));
                    rccContent.setState(res.getString("state"));
                    rccContent.setWorkshopid(res.getInt("workshopid"));
                    rccContent.setAcco_cost(res.getString("acco_cost"));
                    rccContent.setFood_cost(res.getString("food_cost"));
                    // query added by abinaya to set the seats booked and remaining
//                    pstmt1 = con.prepareStatement("select count( a.participantid ) as booked_seats , (select count( a.participantid ) from accomodation a, participant p  where a.participantid=p.participantid and p.status !='Cancelled' and a.instituteid=? and a.workshopid =? and a.accomodation = 'Yes') as booked_acc from accomodation a, participant p where a.participantid=p.participantid and p.status != 'Cancelled' and a.instituteid=? and a.workshopid =?");
//                    pstmt1.setInt(1, res.getInt("rcid"));
//                    pstmt1.setInt(2, workshopid);
//                    pstmt1.setInt(3, res.getInt("rcid"));
//                    pstmt1.setInt(4, workshopid);
//                    res1 = pstmt1.executeQuery();
//                    while (res1.next()) {
//                        rccContent.setSeats_booked(res1.getInt(1));
//                        rccContent.setAccomo_booked(res1.getInt(2));
//                        int seats_remaining = res.getInt("available_seats") - res1.getInt(1);
//                        if (seats_remaining < 0) {
//                            rccContent.setSeats_remaining(0);
//                        } else {
//                            rccContent.setSeats_remaining(seats_remaining);
//                        }
//                    }

                    remotecenterCapacity.add(rccContent);
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
        return remotecenterCapacity;
    }

    public int createAttendanceSheet(int workshopid, int participantid) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.

                pstmt = con.prepareStatement("delete from attendance where participantid=?");
                pstmt.setInt(1, participantid);
                pstmt.executeUpdate();

                pstmt = con.prepareStatement("insert into  attendance (workshopid,participantid,rcid,session)  select a.workshopid,a.participantid,a.instituteid,ps.id from accomodation a ,participant p, program_schedule ps  where a.workshopid=? and a.participantid=? and a.participantid =p.participantid and p.status='Confirmed' and ps.workshopid=a.workshopid and ps.isActive=1");
                pstmt.setInt(1, workshopid);
                pstmt.setInt(2, participantid);
                result = pstmt.executeUpdate();
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

    public String checkIfCanBeNominatedAsWSC(String email, String workshopid, String rcid) {
        String result = "";
        int res_1 = 1, res_2 = 1, res_3 = 1, res_4 = 1, res_5 = 1;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.

                pstmt = con.prepareStatement("select usertypeid from login where login_name=?");
                pstmt.setString(1, email);
                res = pstmt.executeQuery();
                if (res.next()) {
                    if (res.getInt("usertypeid") > 1) {
                        res_1 = 0; // not a normal user - either teacher/admin/software person
                        result += " The entered user is admin ";
                    } else {
                        // check if participant of same workshop
                        pstmt = con.prepareStatement("select p.* from participant p, context c, accomodation a where"
                                + " c.email=? and c.idcontext=p.contextid and a.participantid=p.participantid and a.workshopid=?");
                        pstmt.setString(1, email);
                        pstmt.setString(2, workshopid);
                        res = pstmt.executeQuery();
                        if (res.next()) {
                            res_2 = 0;
                            result += " The entered user is a participant in this workshop ";
                        } else {
                            // check if from same rc, if different rcc throw error
                            pstmt = con.prepareStatement("select * from remotecenter where email=? ");
                            pstmt.setString(1, email);
                            res = pstmt.executeQuery();
                            if (res.next()) {
                                String rc_from_table = res.getString("remotecenterid");
                                if (rc_from_table.equals(rcid)) {
                                    // okay .. can be nominated
                                } else {
                                    res_3 = 0;
                                    result += " The entered user is a RCC of another remotecenter ";

                                }
                            } else {
                                pstmt = con.prepareStatement("select * from wsc_nominations where nominated_email=? and workshopid=? ");
                                pstmt.setString(1, email);
                                pstmt.setString(2, workshopid);
                                res = pstmt.executeQuery();
                                if (res.next()) {
                                    res_4 = 0;
                                    result += " The entered user is a nominee of another RC for this workshop";
                                } else {
                                    pstmt = con.prepareStatement("select p.* from participant p, context c, accomodation a, workshops w where"
                                            + " c.email=? and c.idcontext=p.contextid and a.participantid=p.participantid and a.workshopid=w.respective_coordinatorid and w.workshopid=?");
                                    pstmt.setString(1, email);
                                    pstmt.setString(2, workshopid);
                                    res = pstmt.executeQuery();
                                    if (res.next()) {
                                        res_5 = 0;
                                        result += " The entered user is a WSC of another RC for this workshop";
                                    }
                                }
                            }
                        }
                    }
                } else {
                    res_1 = 0; // not a registered user
                    result += "Not a registered user";
                }
//                System.out.println("res1 " + res_1 + " res2 " + res_2 + " res3 " + res_3 + " res4" + res_4 + " res5 " + res_5);
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

    public int insert_certificate_audit(int workshopid, int rcid, ArrayList<Person> participantDetails, int updated_by) {
        int result = 0;

        String participants = "";
        if (participantDetails.size() != 0) {
            for (int i = 0; i < participantDetails.size() - 1; i++) {
                participants += participantDetails.get(i).getRegistrationDetails().getParticipantid() + ", ";
            }
            participants += participantDetails.get(participantDetails.size() - 1).getRegistrationDetails().getParticipantid();
            try {
                if (con == null || con.isClosed()) {
                    con = DBConnection.getDBConnection();
                }
                if (con != null) {//checking whether con is null or not.

                    pstmt = con.prepareStatement("insert into  certificate_audit (workshopid,rcid, dispatch,updated_by)  values(?,?,?,?)");
                    pstmt.setInt(1, workshopid);
                    pstmt.setInt(2, rcid);
                    pstmt.setString(3, participants);
                    pstmt.setInt(4, updated_by);
                    result = pstmt.executeUpdate();
                }
            } catch (SQLException sqle) {
                sqle.printStackTrace();
            } finally {
                DBConnection.closeResultSet(res);
                DBConnection.closePStatement(pstmt);
                DBConnection.closeDBConnection(con);
            }
        }
        return result;
    }

    public ArrayList<CertificateAudit> getCertificateAudit() throws ParseException {
        ArrayList<CertificateAudit> c_audit = new ArrayList<CertificateAudit>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select ca.*, p.firstname, p.lastname from certificate_audit ca , person p where p.personid=ca.updated_by order by time desc");
                res = pstmt.executeQuery();
                while (res.next()) {
                    CertificateAudit n = new CertificateAudit();

                    n.setWorkshopid(res.getInt("workshopid"));
                    n.setRcid(res.getInt("rcid"));
//                    n.setParticipants(res.getString("dispatch"));
                    n.setTime(res.getTimestamp("time"));
                    n.setUpdated_by(res.getString("updated_by") + " - " + res.getString("firstname") + " " + res.getString("lastname"));

                    String part = res.getString("dispatch");
                    String part_temp[] = part.split(", ");
                    String all_participants = "";
                    if (part_temp.length != 0) {
                        for (int i = 1; i <= part_temp.length; i++) {

                            pstmt1 = con.prepareStatement("select p.firstname, p.lastname from person p, participant pa where pa.personid=p.personid and pa.participantid=?");
                            pstmt1.setString(1, part_temp[i - 1]);
                            res1 = pstmt1.executeQuery();
                            while (res1.next()) {
                                //(i) + ") " +
                                all_participants += part_temp[i - 1] + " - " + res1.getString("firstname") + " " + res1.getString("lastname") + "\n";
                            }
                        }

                    }
                    n.setParticipants(all_participants);
                    c_audit.add(n);
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
        return c_audit;
    }

    public int getCertificateAudit(String workshopid, String rcid) throws ParseException {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select ca.*, p.firstname, p.lastname from certificate_audit ca , person p where p.personid=ca.updated_by and ca.workshopid=? and ca.rcid=?");
                pstmt.setString(1, workshopid);
                pstmt.setString(2, rcid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    result++;
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

    public ArrayList<DataExportActivityBean> getParticipantWiseWorkshopReport(int range) {
        ArrayList<DataExportActivityBean> data_export_obj = new ArrayList<DataExportActivityBean>();
        DataExportActivityBean data_bean = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
//            String query = "select count(distinct(a.workshopid)) as workshopCount, pa.personid,p.genderinfo,concat(p.firstname,' ',p.lastname) as name from participant pa, accomodation a,person p where pa.participantid = a.participantid and pa.personid=p.personid  and pa.status in ('Confirmed','Completed', 'Moodle Accessed', 'Request Confirmed')  group by pa.personid order by pa.personid ";
            String query = "select count(distinct(a.workshopid)) as workshopCount, pa.personid,p.genderinfo,concat(p.firstname,' ',p.lastname) as name "
                    + "from participant pa left join accomodation a on pa.participantid = a.participantid left join person p on pa.personid=p.personid where pa.status in ('Confirmed','Completed', 'Moodle Accessed', 'Request Confirmed') "
                    + " group by pa.personid order by pa.personid";
            if (range == 1) {
                pstmt = con.prepareStatement(query);
            }
            res = pstmt.executeQuery();
            while (res.next()) {
                data_bean = new DataExportActivityBean();
                data_bean.setPer_user_id(res.getInt("personid"));
                data_bean.setGender(res.getString("genderinfo"));
                data_bean.setNo_of_workshop_attend(res.getInt("workshopCount"));
                //data_bean.setName(res.getString("name"));
                data_bean.setName(res.getString("name"));
                data_export_obj.add(data_bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // DBConnection.closeResultSet(res2);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            // DBConnection.closePStatement(pstmt2);
            DBConnection.closeDBConnection(con);
        }
        return data_export_obj;
    }

    public ArrayList<DataExportActivityBean> getInstituteWiseWorkshopReport() {
        ArrayList<DataExportActivityBean> data_institute = new ArrayList<DataExportActivityBean>();
        DataExportActivityBean data_bean = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            String query1 = "select count(distinct(a.workshopid)) as workshopCount,pa.instituteid,i.institutename from participant pa,accomodation a, institute i where  pa.instituteid = i.idInstitute and a.participantid = pa.participantid and i.isActive IN (1,0,-1) and pa.status in ('Confirmed','Completed','Moodle Accessed', 'Request Confirmed')  group by pa.instituteid  order by pa.instituteid";
            pstmt = con.prepareStatement(query1);
            res = pstmt.executeQuery();
            while (res.next()) {
                data_bean = new DataExportActivityBean();
                data_bean.setIdInstitute(res.getInt("instituteid"));
                data_bean.setInstituteName(res.getString("Institutename"));
                data_bean.setNo_of_workshop_attend(res.getInt("workshopCount"));
                data_institute.add(data_bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // DBConnection.closeResultSet(res2);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            //  DBConnection.closePStatement(pstmt2);
            DBConnection.closeDBConnection(con);
        }
        return data_institute;
    }

    public String insert_paymentdetails(PaymentGateway paymentgateway) {
        String result = "";
        int result2 = 0;
        int nextid = -1;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.

                pstmt = con.prepareStatement("select max(uid) as id from paymentdetails");
                res = pstmt.executeQuery();
                while (res.next()) {
                    nextid = res.getInt("id");
                }
                if (nextid > 0) {
                    nextid++;
                } else {
                    nextid = 1;
                }

                pstmt = con.prepareStatement("insert into  paymentdetails (uid,userid,reqid,totalamt,name,purpose,workshopid)  values(?,?,?,?,?,?,?)");
                pstmt.setInt(1, nextid);
                pstmt.setString(2, paymentgateway.getUserId());
                pstmt.setString(3, paymentgateway.getReqId());
                pstmt.setString(4, paymentgateway.getTotalAmt());
                pstmt.setString(5, paymentgateway.getName());
                pstmt.setString(6, paymentgateway.getPurpose());
                pstmt.setInt(7, Integer.parseInt(paymentgateway.getWorkshopid()));
                result2 = pstmt.executeUpdate();

                if (result2 > 0) {
                    result = "success";
                } else {
                    result = "fails";
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
            DBConnection.closeResultSet(res);
        }
        return result;
    }

    public int update_paymentdetails(PaymentGateway paymentgateway) {
        int result2 = 0, countRow = 0, workshopid = 0;
        String status = "", purpose = null, pername = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select userid,reqid,ifnull(status,'') as status,workshopid,purpose,name from paymentdetails where userid=? and reqid=?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                pstmt.setString(1, paymentgateway.getUserId());
                pstmt.setString(2, paymentgateway.getReqId());
                res = pstmt.executeQuery();
                res.last();
                workshopid = res.getInt("workshopid");
                purpose = res.getString("purpose");
                pername = res.getString("name");
                paymentgateway.setWorkshopid(String.valueOf(workshopid));
                paymentgateway.setPurpose(purpose);
                paymentgateway.setName(pername);
                countRow = res.getRow();
                if (countRow == 1) {
                    res.first();
                    status = res.getString("status");
                    if (status.equals("S") || status.equals("F")) {
                        int resflag = insertNewPaymentRecordByParticipant(paymentgateway);
                        result2 = resflag;
                    } else {
                        pstmt = con.prepareStatement("update paymentdetails set reqtype=?,totalamt=?,transid=?,refno=?,status=?,trans_date=?,trans_time=?,provid=?,msg=? where userid=? and reqid=?");
                        pstmt.setString(1, paymentgateway.getReqestType());
                        pstmt.setString(2, paymentgateway.getTotalAmt());
                        pstmt.setString(3, paymentgateway.getTransId());
                        pstmt.setString(4, paymentgateway.getRefNo());
                        pstmt.setString(5, paymentgateway.getStatus());
                        pstmt.setString(6, paymentgateway.getTransDate());
                        pstmt.setString(7, paymentgateway.getTransTime());
                        pstmt.setString(8, paymentgateway.getProvId());
                        pstmt.setString(9, paymentgateway.getMsg());
                        pstmt.setString(10, paymentgateway.getUserId());
                        pstmt.setString(11, paymentgateway.getReqId());
                        result2 = pstmt.executeUpdate();
                    }
                } else {
                    int resflag2 = insertNewPaymentRecordByParticipant(paymentgateway);
                    result2 = resflag2;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result2;
    }

    public int update_paymentdetailsReconsilation(PaymentGateway paymentgateway) {
        int result2 = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                if (paymentgateway.getReqestType().equals("R")) {
                    pstmt = con.prepareStatement("update paymentdetails set reqtype=?,totalamt=?,transid=?,refno=?,recon_date=?,recon_time=?,provid=?,status=? where userid=? and reqid=?");
                    pstmt.setString(1, paymentgateway.getReqestType());
                    pstmt.setString(2, paymentgateway.getTotalAmt());
                    pstmt.setString(3, paymentgateway.getTransId());
                    pstmt.setString(4, paymentgateway.getRefNo());
                    pstmt.setString(5, paymentgateway.getReconDate());
                    pstmt.setString(6, paymentgateway.getReconTime());
                    pstmt.setString(7, paymentgateway.getProvId());
                    pstmt.setString(8, paymentgateway.getStatus());
                    pstmt.setString(9, paymentgateway.getUserId());
                    pstmt.setString(10, paymentgateway.getReqId());
                } else if (paymentgateway.getReqestType().equals("J")) {
                    pstmt = con.prepareStatement("update paymentdetails set reqtype=?,totalamt=?,transid=?,refno=?,recon_date=?,recon_time=?,provid=?,status=? where userid=? and reqid=?");
                    pstmt.setString(1, paymentgateway.getReqestType());
                    pstmt.setString(2, paymentgateway.getTotalAmt());
                    pstmt.setString(3, paymentgateway.getTransId());
                    pstmt.setString(4, paymentgateway.getRefNo());
                    pstmt.setString(5, paymentgateway.getReconDate());
                    pstmt.setString(6, paymentgateway.getReconTime());
                    pstmt.setString(7, paymentgateway.getProvId());
                    pstmt.setString(8, paymentgateway.getStatus());
                    pstmt.setString(9, paymentgateway.getUserId());
                    pstmt.setString(10, paymentgateway.getReqId());
                } else if (paymentgateway.getReqestType().equals("I")) {
                    pstmt = con.prepareStatement("update paymentdetails set reqtype=?,totalamt=?,transid=?,refno=?,status=?,trans_date=?,trans_time=?,provid=?,msg=? where userid=? and reqid=?");
                    pstmt.setString(1, paymentgateway.getReqestType());
                    pstmt.setString(2, paymentgateway.getTotalAmt());
                    pstmt.setString(3, paymentgateway.getTransId());
                    pstmt.setString(4, paymentgateway.getRefNo());
                    pstmt.setString(5, paymentgateway.getStatus());
                    pstmt.setString(6, paymentgateway.getTransDate());
                    pstmt.setString(7, paymentgateway.getTransTime());
                    pstmt.setString(8, paymentgateway.getProvId());
                    pstmt.setString(9, paymentgateway.getMsg());
                    pstmt.setString(10, paymentgateway.getUserId());
                    pstmt.setString(11, paymentgateway.getReqId());
                }
                result2 = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result2;
    }

    public int update_paymentStatus(String participantid) {
        int result2 = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("update participant set payment='paid' where participantid=?");
                pstmt.setInt(1, Integer.parseInt(participantid));
                result2 = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result2;
    }

    public int check_paymentAlreadyMade(String participantid) {
        int result = 0;
        String rtype = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select reqid from paymentdetails where userid=? and status='S' and reqtype in ('I','R')");
                pstmt.setInt(1, Integer.parseInt(participantid));
                res = pstmt.executeQuery();
                while (res.next()) {
                    rtype = res.getString("reqid");
                }
                if (!rtype.equals("") || !rtype.equals(null)) {
                    if (rtype.length() > 1) {
                        result = 1;
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

    public PaymentGateway getPaymentDetailsOfParticipant(String userid, String uniqueid) {
        // ArrayList<PaymentGateway> pg_object = new ArrayList<PaymentGateway>();
        PaymentGateway pg_bean = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            String query = "select name,workshopid,purpose from paymentdetails where userid=? and reqid=? ";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, userid);
            pstmt.setString(2, uniqueid);
            res = pstmt.executeQuery();
            while (res.next()) {
                pg_bean = new PaymentGateway();
                pg_bean.setName(res.getString("name"));
                pg_bean.setWorkshopid(res.getString("workshopid"));
                pg_bean.setPurpose(res.getString("purpose"));
                // pg_object.add(pg_bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return pg_bean;
    }

    public ArrayList<PaymentGateway> getParticipantsPaymentDetails(String workshopid) {
        ArrayList<PaymentGateway> participants = new ArrayList<PaymentGateway>();
        PaymentGateway data_bean = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            String query = "select pg.userid,pg.name,c.email,a.instituteid,pg.reqid,pg.reqtype,pg.totalamt,pg.transid,pg.refno,pg.status,pg.trans_date,pg.trans_time,pg.provid,pg.msg,pg.purpose,cast(pg.recon_date AS CHAR)as recon_date,pg.recon_time,p.payment,r.remotecentername,ci.city from paymentdetails pg, participant p, accomodation a, context c,remotecenter r,city ci where pg.userid=p.participantid and p.participantid=a.participantid and p.personid=c.idcontext and a.instituteid=r.remotecenterid and r.city=ci.cityid and pg.workshopid=?";
            // String query1 = "select count(distinct(a.workshopid)) as workshopCount,pa.instituteid,i.institutename from participant pa,accomodation a, institute i where  pa.instituteid = i.idInstitute and a.participantid = pa.participantid and i.isActive=1 and pa.status in ('Confirmed','Completed')  group by pa.instituteid  order by pa.instituteid";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, workshopid);
            res = pstmt.executeQuery();
            while (res.next()) {
                data_bean = new PaymentGateway();
                data_bean.setUserId(res.getString("userid"));
                data_bean.setName(res.getString("name"));
                data_bean.setEmail(res.getString("email"));
                data_bean.setRcid(res.getString("instituteid"));
                data_bean.setReqId(res.getString("reqid"));
                data_bean.setReqestType(res.getString("reqtype"));
                data_bean.setTotalAmt(res.getString("totalamt"));
                data_bean.setTransId(res.getString("transid"));
                data_bean.setRefNo(res.getString("refno"));
                data_bean.setStatus(res.getString("status"));
                data_bean.setTransDate(res.getString("trans_date"));
                data_bean.setTransTime(res.getString("trans_time"));
                data_bean.setProvId(res.getString("provid"));
                data_bean.setMsg(res.getString("msg"));
                data_bean.setPurpose(res.getString("purpose"));
                data_bean.setReconDate(res.getString("recon_date"));
                data_bean.setReconTime(res.getString("recon_time"));
                //data_bean.setReconTime(res.getString("recon_time"));
                data_bean.setPaymentStatus(res.getString("payment"));
                data_bean.setRcname(res.getString("remotecentername"));
                data_bean.setCity(res.getString("city"));
                participants.add(data_bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participants;
    }

    public int setQuery_PaymentDetailsOfParticipants(String type, String context) {
        int count = 0;
        String query;
        ExcelSheet excel = new ExcelSheet();
        try {
            query = "select pg.userid,pg.name,c.email,a.instituteid,pg.reqid,pg.reqtype,pg.totalamt,pg.transid,pg.refno,pg.status,pg.trans_date,pg.trans_time,pg.provid,pg.msg,pg.purpose,cast(pg.recon_date AS CHAR)as recon_date,pg.recon_time,p.payment,r.remotecentername,ci.city from paymentdetails pg, participant p, accomodation a, context c,remotecenter r,city ci where pg.userid=p.participantid and p.participantid=a.participantid and p.personid=c.idcontext and a.instituteid=r.remotecenterid and r.city=ci.cityid and pg.workshopid='" + type + "'";
            String fileName = null;
            fileName = context + "Excel_Sheets/paymentdetailsSummary.xls";
            boolean result = false;
            result = excel.createExcel(query, fileName);
            if (result == true) {
                count = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;
    }

    public int insertNewPaymentRecordByParticipant(PaymentGateway pgateway) {
        int result = 0, result2 = 0;
        int nextid = -1;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.

                pstmt = con.prepareStatement("select max(uid) as id from paymentdetails");
                res = pstmt.executeQuery();
                while (res.next()) {
                    nextid = res.getInt("id");
                }
                if (nextid > 0) {
                    nextid++;
                } else {
                    nextid = 1;
                }

                pstmt = con.prepareStatement("insert into  paymentdetails (uid,userid,reqid,totalamt,name,purpose,workshopid,reqtype,transid,refno,status,trans_date,trans_time,provid,msg)  values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                pstmt.setInt(1, nextid);
                pstmt.setString(2, pgateway.getUserId());
                pstmt.setString(3, pgateway.getReqId());
                pstmt.setString(4, pgateway.getTotalAmt());
                pstmt.setString(5, pgateway.getName());
                pstmt.setString(6, pgateway.getPurpose());
                pstmt.setInt(7, Integer.parseInt(pgateway.getWorkshopid()));
                pstmt.setString(8, pgateway.getReqestType());
                pstmt.setString(9, pgateway.getTransId());
                pstmt.setString(10, pgateway.getRefNo());
                pstmt.setString(11, pgateway.getStatus());
                pstmt.setString(12, pgateway.getTransDate());
                pstmt.setString(13, pgateway.getTransTime());
                pstmt.setString(14, pgateway.getProvId());
                pstmt.setString(15, pgateway.getMsg());
                result2 = pstmt.executeUpdate();
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

    public int check_paymentDetailsExist(String participantid) {
        int result = 0, count = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select reqid from paymentdetails where userid=? and status in ('S','F')");
                pstmt.setInt(1, Integer.parseInt(participantid));
                res = pstmt.executeQuery();
                while (res.next()) {
                    count++;
                }
                if (count > 0) {
                    result = 1;
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

    public ArrayList<PaymentGateway> getTransactionDetailsOfParticipant(String workshopid, String pid) {
        ArrayList<PaymentGateway> participants = new ArrayList<PaymentGateway>();
        PaymentGateway data_bean = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            String query = "select pg.userid,pg.name,c.email,a.instituteid,pg.reqid,pg.reqtype,pg.totalamt,pg.transid,pg.refno,pg.status,pg.trans_date,pg.trans_time,pg.provid,pg.msg,pg.purpose,cast(pg.recon_date AS CHAR)as recon_date,pg.recon_time,p.payment,r.remotecentername,ci.city from paymentdetails pg, participant p, accomodation a, context c,remotecenter r,city ci where pg.userid=p.participantid and p.participantid=a.participantid and p.personid=c.idcontext and a.instituteid=r.remotecenterid and r.city=ci.cityid and pg.workshopid=? and pg.userid=? and pg.status in ('S','F')";
            // String query1 = "select count(distinct(a.workshopid)) as workshopCount,pa.instituteid,i.institutename from participant pa,accomodation a, institute i where  pa.instituteid = i.idInstitute and a.participantid = pa.participantid and i.isActive=1 and pa.status in ('Confirmed','Completed')  group by pa.instituteid  order by pa.instituteid";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, workshopid);
            pstmt.setString(2, pid);
            res = pstmt.executeQuery();
            while (res.next()) {
                data_bean = new PaymentGateway();
                data_bean.setUserId(res.getString("userid"));
                data_bean.setName(res.getString("name"));
                data_bean.setEmail(res.getString("email"));
                data_bean.setRcid(res.getString("instituteid"));
                data_bean.setReqId(res.getString("reqid"));
                data_bean.setReqestType(res.getString("reqtype"));
                data_bean.setTotalAmt(res.getString("totalamt"));
                data_bean.setTransId(res.getString("transid"));
                data_bean.setRefNo(res.getString("refno"));
                data_bean.setStatus(res.getString("status"));
                data_bean.setTransDate(res.getString("trans_date"));
                data_bean.setTransTime(res.getString("trans_time"));
                data_bean.setProvId(res.getString("provid"));
                data_bean.setMsg(res.getString("msg"));
                data_bean.setPurpose(res.getString("purpose"));
                data_bean.setReconDate(res.getString("recon_date"));
                data_bean.setReconTime(res.getString("recon_time"));
                //data_bean.setReconTime(res.getString("recon_time"));
                data_bean.setPaymentStatus(res.getString("payment"));
                data_bean.setRcname(res.getString("remotecentername"));
                data_bean.setCity(res.getString("city"));
                participants.add(data_bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participants;
    }

    public ArrayList<RemoteCenter> listRemoteCentersForCertificate(String workshopid, String state) {
        ArrayList<RemoteCenter> remoteCenters = new ArrayList<RemoteCenter>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("Select categorycode from workshops WHERE workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                RemoteCenter remoteCenter = null;
                while (res.next()) {
                    int categorycode = res.getInt("categorycode");
                    if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                        if (state.equals("all")) {
                            pstmt1 = con.prepareStatement("select rc.rcid as remotecenterid ,r.remotecentername as remotecentername, c.city from remotecenter r, remotecentercapacity rc, city c where r.city=c.cityid and r.remotecenterid=rc.rcid and rc.workshopid=? order by rc.rcid");
                            pstmt1.setString(1, workshopid);
                        } else {
                            pstmt1 = con.prepareStatement("select rc.rcid as remotecenterid,r.remotecentername as remotecentername, c.city from remotecenter r, remotecentercapacity rc, city c where r.city=c.cityid and r.remotecenterid=rc.rcid and rc.workshopid=? and r.state=? order by r.remotecentername");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setString(2, state);
                        }
                    } else if (categorycode == 4 || categorycode == 6) {
                        if (state.equals("all")) {
                            pstmt1 = con.prepareStatement("select r.remotecenterid,r.remotecentername, c.city from remotecenter r, city c where active=1 and c.cityid=r.city  order by remotecentername");
                        } else {
                            pstmt1 = con.prepareStatement("select r.remotecenterid,r.remotecentername, c.city from remotecenter r, city c where c.cityid=r.city and active=1 and state=? order by remotecentername");
                            pstmt1.setString(1, state);
                        }
                    }
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        remoteCenter = new RemoteCenter();
                        remoteCenter.setRemoteCenterId(res1.getInt("remotecenterid"));
                        remoteCenter.setRemoteCenterName(res1.getString("remotecentername"));
                        remoteCenter.setRc_city(res1.getString("city"));
                        //set encrypted rc_id
                        String rc = res1.getString("remotecenterid");
                        SimpleStringCipher cipher = new SimpleStringCipher();
                        try {
                            String enc_rcid = cipher.encrypt(rc);
                            remoteCenter.setEnc_RC(enc_rcid);

                        } catch (Exception ex) {
                            Logger.getLogger(UtilityProcess.class
                                    .getName()).log(Level.SEVERE, null, ex);
                        }
                        int count = 0;
                        pstmt2 = con.prepareStatement("select id,time from certificate_audit where workshopid=? and rcid=?");
                        pstmt2.setString(1, workshopid);
                        pstmt2.setString(2, rc);
                        res2 = pstmt2.executeQuery();
                        res2.last();
                        count = res2.getRow();
                        if (count > 0) {
                            remoteCenter.setIsAlreadyCertiGen("yes");
                            remoteCenter.setGenerateTime(res2.getString("time"));
                        }

                        int certificateCount = 0;
                        String[] totalParticipants;
                        pstmt3 = con.prepareStatement("select dispatch from certificate_audit where rcid=? and time in (select max(time) from certificate_audit where rcid=? and workshopid=?)");
                        pstmt3.setString(1, rc);
                        pstmt3.setString(2, rc);
                        pstmt3.setString(3, workshopid);
                        res3 = pstmt3.executeQuery();
                        while (res3.next()) {
                            String participants = res3.getString("dispatch");
                            totalParticipants = participants.split(",");
                            certificateCount = totalParticipants.length;
                        }
                        remoteCenter.setCertiGeneratedCount(String.valueOf(certificateCount));

                        if (categorycode == 8) {
                            pstmt4 = con.prepareStatement("select count(*) as totalcount from participant p,accomodation a where p.participantid=a.participantid and a.workshopid=? and a.instituteid=? and p.status='Completed' and p.eligible_for_certificate='yes'");
                        } else {
                            pstmt4 = con.prepareStatement("select count(*) as totalcount from participant p,accomodation a where p.participantid=a.participantid and a.workshopid=? and a.instituteid=? and p.status='Completed'");
                        }
                        pstmt4.setString(1, workshopid);
                        pstmt4.setString(2, rc);
                        res4 = pstmt4.executeQuery();
                        while (res4.next()) {
                            remoteCenter.setParticipantCount(res4.getString("totalcount"));
                        }
                        remoteCenters.add(remoteCenter);
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res4);
            DBConnection.closePStatement(pstmt4);
            DBConnection.closeResultSet(res3);
            DBConnection.closePStatement(pstmt3);
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return remoteCenters;
    }

    public ArrayList<WorkshopContent> listWorkshopsWithRemark(String period) throws Exception {
        ArrayList<WorkshopContent> workshopContents = new ArrayList<WorkshopContent>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (period.equals("90 day")) {
                    pstmt = con.prepareStatement("select workshopname,categorycode,workshopid, startdate, enddate, (date_add(enddate, interval 90 day ) >= CURDATE()) as expiry,workshop_remark,date(last_updated) as last_updated from workshops order by workshops.startdate DESC");
                } else {
                    pstmt = con.prepareStatement("select workshopname,categorycode,workshopid,startdate,enddate, (date_add(enddate, interval " + period + " ) >= CURDATE()) as expiry,workshop_remark,date(last_updated) as last_updated from workshops order by workshops.startdate DESC");
//                pstmt.setString(1,"interval "+period);
                }
                res = pstmt.executeQuery();
                WorkshopContent workshopContent = null;
                while (res.next()) {
                    workshopContent = new WorkshopContent();
                    workshopContent.setWorkshopname(res.getString("workshopname"));
                    workshopContent.setCategorycode(res.getInt("categorycode"));
                    workshopContent.setWorkshopid(res.getInt("workshopid"));
                    workshopContent.setStartdate(res.getString("startdate"));
                    workshopContent.setEnddate(res.getString("enddate"));
                    workshopContent.setWorkshopRemark(res.getString("workshop_remark"));
                    workshopContent.setLastUpdated(res.getString("last_updated"));
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

    public int update_workshopRemark(String wid, String remark) {
        int result = 0, count = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("update workshops set workshop_remark=?,last_updated=now() where workshopid=?");
                pstmt.setString(1, remark);
                pstmt.setInt(2, Integer.parseInt(wid));
                result = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt);
            DBConnection.closeResultSet(res);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }

    public ArrayList<WorkshopContent> listWorkshopsForPaymentDetails(String period) throws Exception {
        ArrayList<WorkshopContent> workshopContents = new ArrayList<WorkshopContent>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (period.equals("90 day")) {
                    pstmt = con.prepareStatement("select workshopname,categorycode,workshopid, startdate, enddate, (date_add(enddate, interval 90 day ) >= CURDATE()) as expiry,workshop_remark,startdateofappli from workshops order by workshops.startdate DESC");
                } else {
                    pstmt = con.prepareStatement("select workshopname,categorycode,workshopid,startdate,enddate, (date_add(enddate, interval " + period + " ) >= CURDATE()) as expiry,workshop_remark,startdateofappli from workshops order by workshops.startdate DESC");
//                pstmt.setString(1,"interval "+period);
                }
                res = pstmt.executeQuery();
                WorkshopContent workshopContent = null;
                while (res.next()) {
                    workshopContent = new WorkshopContent();
                    workshopContent.setWorkshopname(res.getString("workshopname"));
                    workshopContent.setCategorycode(res.getInt("categorycode"));
                    workshopContent.setWorkshopid(res.getInt("workshopid"));
                    workshopContent.setStartdate(res.getString("startdate"));
                    workshopContent.setEnddate(res.getString("enddate"));
                    workshopContent.setWorkshopRemark(res.getString("workshop_remark"));
                    workshopContent.setWorkshopExpiry(res.getInt("expiry"));
                    workshopContent.setStartdatereg(res.getString("startdateofappli"));
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String encryptedId = cipher.encrypt(Integer.toString(res.getInt("workshopid")));
                    workshopContent.setWorkshopid_encrypted(encryptedId);

                    if (res.getInt("categorycode") == 8) {
                        pstmt1 = con.prepareStatement("select ifnull(sum(totalamt),0) as amount from paymentdetails where status='S' and workshopid=?");
                        pstmt1.setInt(1, res.getInt("workshopid"));
                        res1 = pstmt1.executeQuery();
                        while (res1.next()) {
                            String amount = res1.getString("amount");
                            workshopContent.setTotalSumOfPayment(amount);
                        }
                    } else {
                        workshopContent.setTotalSumOfPayment("NA");

                    }
                    pstmt2 = con.prepareStatement("select count(*) as totalcount from participant p,accomodation a where p.participantid=a.participantid and p.status not in ('Cancelled') and a.workshopid=?");
                    pstmt2.setInt(1, res.getInt("workshopid"));
                    res2 = pstmt2.executeQuery();
                    while (res2.next()) {
                        String totalcount = res2.getString("totalcount");
                        workshopContent.setTotalCount(totalcount);
                    }

                    workshopContents.add(workshopContent);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return workshopContents;
    }

    public ArrayList<Person> listParticipantsForCertificateOnly(String workshopid, String rcid, String status) throws Exception {
        ArrayList<Person> participantList = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                /**
                 * The category code is fetched to fetch the list from the table
                 * and to determine if it is a coordinator workshop or a main
                 * workshop
                 */
                pstmt = con.prepareStatement("Select categorycode, respective_coordinatorid from workshops WHERE workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                Person list = null;
                while (res.next()) {
                    int categorycode = res.getInt("categorycode");
                    int res_coord_id = res.getInt("respective_coordinatorid");
                    if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                        /**
                         * category 5 is main workshop. the conditions are used
                         * to select the query depending on the status and rcid.
                         */
                        if ((rcid).equals("all") && (status).equals("all")) {
                            if (categorycode == 8) {
                                // select participants only eligible for certificates
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid, i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.eligible_for_certificate='yes' order by p.regtime");
                            } else {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid, i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                            }
                            pstmt1.setString(1, workshopid);
                        } else if (!rcid.equals("all") && status.equals("all")) {
                            if (categorycode == 8) {
                                // select participants only eligible for certificates
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate  from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and a.instituteid=? and p.eligible_for_certificate='yes' order by p.regtime");
                            } else {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate  from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and a.instituteid=? order by p.regtime");
                            }
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(rcid));
                        } else if (!rcid.equals("all") && !status.equals("all")) {
                            if (categorycode == 8) {
                                // select participants only eligible for certificates
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate  from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and a.instituteid=? and p.status=? and p.eligible_for_certificate='yes' order by p.regtime");
                            } else {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate  from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and a.instituteid=? and p.status=? order by p.regtime");
                            }
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(rcid));
                            pstmt1.setString(3, status);
                        } else if (rcid.equals("all") && !status.equals("all")) {
                            if (categorycode == 8) {
                                // select participants only eligible for certificates
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate  from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? and p.eligible_for_certificate='yes' order by p.regtime");
                            } else {
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername ,p.instituteid,i.institutename, p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate  from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                            }
                            pstmt1.setString(1, workshopid);
                            pstmt1.setString(2, status);
                        }
                    } else {
                        if (categorycode == 4 && res_coord_id == 0) {
                            /**
                             * category 4 is coordinator workshop, the
                             * conditions are used to select the query depending
                             * on the status and rcid
                             */
                            if (rcid.equals("all") && status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname, per.genderinfo,c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name FROM accomodation a, remotecenter r, designation d, person per, participant p , letter l,context  c , state s, city ci, stream st where ci.cityid=r.city and s.stateid=r.state and p.participantid=a.participantid and p.contextid=c.idcontext and per.personid=p.personid and a.instituteid=r.remotecenterid and d.iddesignation=per.designation and l.participantid=p.participantid and st.idstream=p.streamid and a.workshopid=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname, per.genderinfo,c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name,p.instituteid FROM accomodation a left join remotecenter r on a.instituteid=r.remotecenterid left join  participant p on p.participantid=a.participantid left join person per on per.personid=p.personid left join designation d on d.iddesignation=per.designation left join  letter l on l.participantid=p.participantid left join context c on p.contextid=c.idcontext left join  state s on s.stateid=r.state left join  city ci on ci.cityid=r.city left join   stream st on  st.idstream=p.streamid where a.workshopid=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                            } else if (rcid.equals("all") && !status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname, per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name FROM accomodation a, remotecenter r, designation d, person per, participant p , letter l,context  c , state s, city ci, stream st where ci.cityid=r.city and s.stateid=r.state and p.participantid=a.participantid and p.contextid=c.idcontext and per.personid=p.personid and a.instituteid=r.remotecenterid and d.iddesignation=per.designation and l.participantid=p.participantid and st.idstream=p.streamid and a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname, per.genderinfo,c.email,c.mobile,  p.qualification, p.experience,a.accomodation, r.remotecentername as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name,p.instituteid FROM accomodation a left join remotecenter r on a.instituteid=r.remotecenterid left join  participant p on p.participantid=a.participantid left join person per on per.personid=p.personid left join designation d on d.iddesignation=per.designation left join  letter l on l.participantid=p.participantid left join context c on p.contextid=c.idcontext left join  state s on s.stateid=r.state left join  city ci on ci.cityid=r.city left join   stream st on  st.idstream=p.streamid where a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                                pstmt1.setString(2, status);
                            }
                        }
                        if ((categorycode == 4 && res_coord_id != 0) || categorycode == 6) {
                            /**
                             * category 4 is coordinator workshop, the
                             * conditions are used to select the query depending
                             * on the status and rcid
                             */
                            if (rcid.equals("all") && status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,p.instituteid,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                            } else if (rcid.equals("all") && !status.equals("all")) {
                                //pstmt1 = con.prepareStatement("SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,p.instituteid,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                                pstmt1.setString(1, workshopid);
                                pstmt1.setString(2, status);
                            }
                        }
                    }
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        list = new Person();
                        /**
                         * Set the details of the remote center of the
                         * participant in the ArrayList
                         */
                        RemoteCenter rc = new RemoteCenter();
                        rc.setRemoteCenterName(res1.getString("remotecentername"));
                        rc.setRc_state(res1.getString("state"));
                        rc.setRc_city(res1.getString("city"));
                        rc.setRemoteCenterId(res1.getInt("remotecenterid"));
                        list.setRemoteCenter(rc);
                        /**
                         * set the First Name, Last Name , mobile and email of
                         * the participant
                         */
                        list.setImage("photo_" + res1.getString("personid") + ".jpg");
                        list.setFirstName(res1.getString("firstname"));
                        list.setLastName(res1.getString("lastname"));
                        list.setMobileNumber(res1.getString("mobile"));
                        SimpleStringCipher cipher = new SimpleStringCipher();
                        String email_enc = cipher.encrypt(res1.getString("email"));
                        list.setEmail_enc(email_enc);
                        list.setEmail(res1.getString("email"));
                        /**
                         * set the registration details status, registration
                         * time , letter name, accommodation
                         */
                        RegistrationDetails registrationDetails = new RegistrationDetails();
                        registrationDetails.setStatus(res1.getString("status"));
                        registrationDetails.setRegtime(res1.getDate("regtime"));
                        registrationDetails.setLetter(res1.getString("letter"));
                        registrationDetails.setAccomodation(res1.getString("accomodation"));
                        registrationDetails.setParticipantid(res1.getString("participantid"));
                        if (categorycode == 8) {
                            registrationDetails.setPayment(res1.getString("payment"));
                            registrationDetails.setIsEligibleForCertificate(res1.getString("eligible_for_certificate"));
                        }
                        list.setRegistrationDetails(registrationDetails);

                        Designation designation = new Designation();
                        designation.setDesignationName(res1.getString("designation"));
                        list.setDesignation(designation);
                        /**
                         * set the gender
                         */
                        list.setGender(res1.getString("genderinfo"));
                        /**
                         * Add the institute details if it is a main workshop
                         */
                        if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                            Institute institute = new Institute();
                            institute.setInstituteName(res1.getString("institutename"));
                            institute.setInstituteId(res1.getInt("instituteid"));
                            list.setInstitute(institute);
                        } else {
                            Institute institute = new Institute();
                            institute.setInstituteName("cc4");
                            list.setInstitute(institute);
                        }

                        /**
                         * Set qualification and experience
                         */
                        Qualification qualification = new Qualification();
                        qualification.setQualification(res1.getString("qualification"));
                        list.setQualification(qualification);

                        list.setExperience(res1.getString("experience"));
                        /**
                         * add stream in the list
                         */
                        Stream stream = new Stream();
                        stream.setStreamName(res1.getString("stream_name"));
                        list.setStream(stream);
                        /**
                         * add the details in the array list
                         */
                        /**
                         * Adding the status Matrix
                         */
                        StatusMatrix sm = new StatusMatrix();

                        pstmt2 = con.prepareStatement("select * from status_matrix where InitialStatus=?");
                        pstmt2.setString(1, res1.getString("status"));
                        res2 = pstmt2.executeQuery();
                        if (res2.next()) {
                            sm.setIfDisplayRegistered(res2.getString("Registered"));
                            sm.setIfDisplayInvalid(res2.getString("Invalid"));
                            sm.setIfDisplayApproved(res2.getString("Approved"));
                            sm.setIfDisplayConfirmed(res2.getString("Confirmed"));
                            sm.setIfDisplayCompleted(res2.getString("Completed"));
                            sm.setIfDisplayCancelled(res2.getString("Cancelled"));

                        }
                        list.setStatusMatrix(sm);

                        participantList.add(list);
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participantList;
    }

    public ArrayList<DataExportActivityBean> getInstituteWiseFacultyAttendedReport(int workshopid) {
        ArrayList<DataExportActivityBean> data_institute = new ArrayList<DataExportActivityBean>();
        DataExportActivityBean data_bean = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            // String query1 = "select count(distinct(a.workshopid)) as workshopCount,pa.instituteid,i.institutename from participant pa,accomodation a, institute i where  pa.instituteid = i.idInstitute and a.participantid = pa.participantid and i.isActive=1 and pa.status in ('Confirmed','Completed')  group by pa.instituteid  order by pa.instituteid";
            String query1 = "select count(pa.participantid) as workshopCount,pa.instituteid,a.workshopid,i.institutename from participant pa,accomodation a,institute i where pa.participantid=a.participantid and pa.instituteid=i.idinstitute and pa.status in ('Confirmed','Completed') and a.workshopid =? and pa.instituteid in (select idinstitute from institute where isActive in(1,-1,0)) group by pa.instituteid";
            pstmt = con.prepareStatement(query1);
            pstmt.setInt(1, workshopid);
            res = pstmt.executeQuery();
            while (res.next()) {
                data_bean = new DataExportActivityBean();
                data_bean.setIdInstitute(res.getInt("instituteid"));
                data_bean.setInstituteName(res.getString("institutename"));
                data_bean.setNo_of_workshop_attend(res.getInt("workshopCount"));
                data_institute.add(data_bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // DBConnection.closeResultSet(res2);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            //  DBConnection.closePStatement(pstmt2);
            DBConnection.closeDBConnection(con);
        }
        return data_institute;
    }

    public int update_payment_acknowledgement(String participantid) {
        int result2 = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("update participant set payment='reconciled' where participantid=?");
                pstmt.setInt(1, Integer.parseInt(participantid));
                result2 = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result2;
    }

    public ArrayList<Person> listParticipantsStateWise(String workshopid, String institute_id, String status) throws Exception {
        ArrayList<Person> participantList = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                /**
                 * The category code is fetched to fetch the list from the table
                 * and to determine if it is a coordinator workshop or a main
                 * workshop
                 */
                pstmt = con.prepareStatement("Select categorycode, respective_coordinatorid, without_RC from workshops WHERE workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                Person list = null;
                while (res.next()) {
                    int categorycode = res.getInt("categorycode");
                    int res_coord_id = res.getInt("respective_coordinatorid");
                    int without_RC = res.getInt("without_RC");
                    if (without_RC == 1) {
                        /**
                         * category 5, 7 and 8 are main workshops. the
                         * conditions are used to select the query depending on
                         * the status and state.
                         */
                        if ((institute_id).equals("all") && (status).equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=c.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                        } else if (!institute_id.equals("all") && status.equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=c.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and i.idinstitute=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(institute_id));
                        } else if (!institute_id.equals("all") && !status.equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=c.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and i.idinstitute=? and p.status=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(institute_id));
                            pstmt1.setString(3, status);
                        } else if (institute_id.equals("all") && !status.equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=c.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setString(2, status);
                        }
                    } else {
                        // no coordinator workshop occurs without a rc coordinator. In case of any future changes write code here ..
                    }
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        list = new Person();
                        /**
                         * Set the details of the state of the participant in
                         * the ArrayList
                         */
                        RemoteCenter rc = new RemoteCenter();
                        rc.setRc_state(res1.getString("state"));
                        rc.setRc_city(res1.getString("city"));
                        list.setRemoteCenter(rc);
                        /**
                         * set the First Name, Last Name , mobile and email of
                         * the participant
                         */
                        list.setImage("photo_" + res1.getString("personid") + ".jpg");
                        list.setFirstName(res1.getString("firstname"));
                        list.setLastName(res1.getString("lastname"));
                        list.setMobileNumber(res1.getString("mobile"));
                        SimpleStringCipher cipher = new SimpleStringCipher();
                        String email_enc = cipher.encrypt(res1.getString("email"));
                        list.setEmail_enc(email_enc);
                        list.setEmail(res1.getString("email"));
                        /**
                         * set the registration details status, registration
                         * time , letter name, accommodation
                         */
                        RegistrationDetails registrationDetails = new RegistrationDetails();
                        registrationDetails.setStatus(res1.getString("status"));
                        registrationDetails.setRegtime(res1.getDate("regtime"));
                        registrationDetails.setLetter(res1.getString("letter"));
                        registrationDetails.setAccomodation(res1.getString("accomodation"));
                        registrationDetails.setParticipantid(res1.getString("participantid"));
                        if (categorycode == 8) {
                            registrationDetails.setPayment(res1.getString("payment"));
                            registrationDetails.setIsEligibleForCertificate(res1.getString("eligible_for_certificate"));
                            list.setFacultyStatus(res1.getString("facultystatus"));
                        }
                        list.setRegistrationDetails(registrationDetails);

                        Designation designation = new Designation();
                        designation.setDesignationName(res1.getString("designation"));
                        list.setDesignation(designation);
                        /**
                         * set the gender
                         */
                        list.setGender(res1.getString("genderinfo"));
                        /**
                         * Add the institute details if it is a main workshop
                         */
                        if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                            Institute institute = new Institute();
                            institute.setInstituteName(res1.getString("institutename"));
                            institute.setInstituteId(res1.getInt("instituteid"));
                            list.setInstitute(institute);
                        } else {
                            Institute institute = new Institute();
                            institute.setInstituteName("cc4");
                            list.setInstitute(institute);
                        }

                        /**
                         * Set qualification and experience
                         */
                        Qualification qualification = new Qualification();
                        qualification.setQualification(res1.getString("qualification"));
                        list.setQualification(qualification);

                        list.setExperience(res1.getString("experience"));
                        /**
                         * add stream in the list
                         */
                        Stream stream = new Stream();
                        stream.setStreamName(res1.getString("stream_name"));
                        list.setStream(stream);
                        /**
                         * add the details in the array list
                         */
                        /**
                         * Adding the status Matrix
                         */
                        StatusMatrix sm = new StatusMatrix();

                        pstmt2 = con.prepareStatement("select * from status_matrix where InitialStatus=?");
                        pstmt2.setString(1, res1.getString("status"));
                        res2 = pstmt2.executeQuery();
                        if (res2.next()) {
                            sm.setIfDisplayRegistered(res2.getString("Registered"));
                            sm.setIfDisplayInvalid(res2.getString("Invalid"));
                            sm.setIfDisplayApproved(res2.getString("Approved"));
                            sm.setIfDisplayConfirmed(res2.getString("Confirmed"));
                            sm.setIfDisplayCompleted(res2.getString("Completed"));
                            sm.setIfDisplayCancelled(res2.getString("Cancelled"));

                        }
                        list.setStatusMatrix(sm);

                        participantList.add(list);
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participantList;
    }

    public ArrayList<RegistrationDetails> getParticipantCountStateWise(String workshopid, String institute_id) throws Exception {
        ArrayList<RegistrationDetails> countArray = new ArrayList<RegistrationDetails>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                RegistrationDetails count = null;
                count = new RegistrationDetails();

                int totalParticipants = getCountStateWise(workshopid, "all", "all");
                int registeredParticipants = getCountStateWise(workshopid, institute_id, "Request Registered");
                int verifiedParticipants = getCountStateWise(workshopid, institute_id, "Request Verified");
                int invalidParticipants = getCountStateWise(workshopid, institute_id, "Registration Invalid");
                int approvedParticipants = getCountStateWise(workshopid, institute_id, "Request Approved");
                int confirmedParticipants = getCountStateWise(workshopid, institute_id, "Confirmed");
                int waitlistedParticipants = getCountStateWise(workshopid, institute_id, "Waitlisted");
                int cancelledParticipants = getCountStateWise(workshopid, institute_id, "Cancelled");
                int completedParticipants = getCountStateWise(workshopid, institute_id, "Completed");
                int acceptedParticipants = getCountStateWise(workshopid, institute_id, "Accepted");
                // for all status specific rc
                int total_rc = getCountStateWise(workshopid, institute_id, "all");
                count.setTotalParticipants(totalParticipants);
                count.setRegisteredParticipants(registeredParticipants);
                count.setVerifiedParticipants(verifiedParticipants);
                count.setApprovedParticipants(approvedParticipants);
                count.setConfirmedParticipants(confirmedParticipants);
                count.setWaitlistedParticipants(waitlistedParticipants);
                count.setCancelledParticipants(cancelledParticipants);
                count.setInvalidParticipants(invalidParticipants);
                count.setCompletedParticipants(completedParticipants);
                count.setAcceptedParticipants(acceptedParticipants);
                count.setTotal_rc_participants(total_rc);
                countArray.add(count);

            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return countArray;
    }

    public int getCountStateWise(String workshopid, String institute_id, String status) {
        int countOfParticipants = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (institute_id.equals("all") && status.equals("all")) {
                    // for all remote centers and all status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=?");
                    pstmt.setString(1, workshopid);
                }
                if (!institute_id.equals("all") && status.equals("all")) {
                    // for specific remote centers and all status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p, context c WHERE p.participantid=a.participantid and a.workshopid=? and p.contextid = c.idcontext and p.instituteid=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, institute_id);
                }
                if (institute_id.equals("all") && !status.equals("all")) {
                    // for all remote centers and specific status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=?  and p.status=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, status);
                }
                if (!institute_id.equals("all") && !status.equals("all")) {
                    // for specific remote centers and specific status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p, context c WHERE p.participantid=a.participantid and p.contextid = c.idcontext and a.workshopid=? and p.instituteid=?  and p.status=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, institute_id);
                    pstmt.setString(3, status);
                }
                res = pstmt.executeQuery();
                while (res.next()) {
                    countOfParticipants = res.getInt(1);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
        }
        return countOfParticipants;
    }

    public ArrayList<Person> listParticipantsForCertificateOnlyStateWise(String workshopid, String institute_id, String status) throws Exception {
        ArrayList<Person> participantList = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                /**
                 * The category code is fetched to fetch the list from the table
                 * and to determine if it is a coordinator workshop or a main
                 * workshop
                 */
                pstmt = con.prepareStatement("Select categorycode, respective_coordinatorid, without_RC from workshops WHERE workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                Person list = null;
                while (res.next()) {
                    int categorycode = res.getInt("categorycode");
                    int res_coord_id = res.getInt("respective_coordinatorid");
                    int without_RC = res.getInt("without_RC");
                    if (categorycode == 8 && without_RC == 1) {
                        /**
                         * category 5 is main workshop. the conditions are used
                         * to select the query depending on the status and rcid.
                         */
                        if ((institute_id).equals("all") && (status).equals("all")) {
                            // select participants only eligible for certificates
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state, s.stateid, ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation  left join institute i on p.instituteid=i.idinstitute left join state s on s.stateid=i.state left join city ci on ci.cityid=i.city left join stream st on p.streamid=st.idstream where a.workshopid=? and p.eligible_for_certificate='yes' order by p.regtime");
                            pstmt1.setString(1, workshopid);
                        } else if (!institute_id.equals("all") && status.equals("all")) {

                            // select participants only eligible for certificates
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state, s.stateid, ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation  left join institute i on p.instituteid=i.idinstitute left join state s on s.stateid=i.state left join city ci on ci.cityid=i.city left join stream st on p.streamid=st.idstream where a.workshopid=? and p.instituteid=? and p.eligible_for_certificate='yes' order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(institute_id));
                        } else if (!institute_id.equals("all") && !status.equals("all")) {

                            // select participants only eligible for certificates
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state, s.stateid, ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join state s on s.stateid=i.state left join city ci on ci.cityid=i.city left join stream st on p.streamid=st.idstream where a.workshopid=? and p.instituteid=? and p.status=?  and p.eligible_for_certificate='yes' order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(institute_id));
                            pstmt1.setString(3, status);
                        } else if (institute_id.equals("all") && !status.equals("all")) {

                            // select participants only eligible for certificates
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation ,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state, s.stateid,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join state s on s.stateid=i.state left join city ci on ci.cityid=i.city left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=?  and p.eligible_for_certificate='yes' order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setString(2, status);
                        }
                    }

//                    System.out.println(pstmt1);
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        list = new Person();
                        /**
                         * Set the details of the remote center of the
                         * participant in the ArrayList
                         */
                        RemoteCenter rc = new RemoteCenter();
                        rc.setRc_state(res1.getString("state"));
                        rc.setRc_city(res1.getString("city"));
                        list.setRemoteCenter(rc);

                        list.setStateId(res1.getInt("stateid"));
                        /**
                         * set the First Name, Last Name , mobile and email of
                         * the participant
                         */
                        list.setImage("photo_" + res1.getString("personid") + ".jpg");
                        list.setFirstName(res1.getString("firstname"));
                        list.setLastName(res1.getString("lastname"));
                        list.setMobileNumber(res1.getString("mobile"));
                        SimpleStringCipher cipher = new SimpleStringCipher();
                        String email_enc = cipher.encrypt(res1.getString("email"));
                        list.setEmail_enc(email_enc);
                        list.setEmail(res1.getString("email"));
                        /**
                         * set the registration details status, registration
                         * time , letter name, accommodation
                         */
                        RegistrationDetails registrationDetails = new RegistrationDetails();
                        registrationDetails.setStatus(res1.getString("status"));
                        registrationDetails.setRegtime(res1.getDate("regtime"));
                        registrationDetails.setLetter(res1.getString("letter"));
                        registrationDetails.setAccomodation(res1.getString("accomodation"));
                        registrationDetails.setParticipantid(res1.getString("participantid"));
                        if (categorycode == 8) {
                            registrationDetails.setPayment(res1.getString("payment"));
                            registrationDetails.setIsEligibleForCertificate(res1.getString("eligible_for_certificate"));
                        }
                        list.setRegistrationDetails(registrationDetails);

                        Designation designation = new Designation();
                        designation.setDesignationName(res1.getString("designation"));
                        list.setDesignation(designation);
                        /**
                         * set the gender
                         */
                        list.setGender(res1.getString("genderinfo"));
                        /**
                         * Add the institute details if it is a main workshop
                         */
                        if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                            Institute institute = new Institute();
                            institute.setInstituteName(res1.getString("institutename"));
                            institute.setInstituteId(res1.getInt("instituteid"));
                            list.setInstitute(institute);
                        } else {
                            Institute institute = new Institute();
                            institute.setInstituteName("cc4");
                            list.setInstitute(institute);
                        }

                        /**
                         * Set qualification and experience
                         */
                        Qualification qualification = new Qualification();
                        qualification.setQualification(res1.getString("qualification"));
                        list.setQualification(qualification);

                        list.setExperience(res1.getString("experience"));
                        /**
                         * add stream in the list
                         */
                        Stream stream = new Stream();
                        stream.setStreamName(res1.getString("stream_name"));
                        list.setStream(stream);
                        /**
                         * add the details in the array list
                         */
                        /**
                         * Adding the status Matrix
                         */
                        StatusMatrix sm = new StatusMatrix();

                        pstmt2 = con.prepareStatement("select * from status_matrix where InitialStatus=?");
                        pstmt2.setString(1, res1.getString("status"));
                        res2 = pstmt2.executeQuery();
                        if (res2.next()) {
                            sm.setIfDisplayRegistered(res2.getString("Registered"));
                            sm.setIfDisplayInvalid(res2.getString("Invalid"));
                            sm.setIfDisplayApproved(res2.getString("Approved"));
                            sm.setIfDisplayConfirmed(res2.getString("Confirmed"));
                            sm.setIfDisplayCompleted(res2.getString("Completed"));
                            sm.setIfDisplayCancelled(res2.getString("Cancelled"));

                        }
                        list.setStatusMatrix(sm);

                        participantList.add(list);
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participantList;
    }

    public int getCertificateAuditStateWise(String workshopid, String institute_id) throws ParseException {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select ca.* from certificate_audit ca  where ca.workshopid=? and ca.rcid=?");
                pstmt.setString(1, workshopid);
                pstmt.setString(2, institute_id);
                res = pstmt.executeQuery();
                while (res.next()) {
                    result++;
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

    public ArrayList<RemoteCenter> listInstitutesForCertificate(String workshopid) {
        ArrayList<RemoteCenter> remoteCenters = new ArrayList<RemoteCenter>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("Select categorycode, without_RC from workshops WHERE workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                RemoteCenter remoteCenter = null;
                while (res.next()) {
                    int categorycode = res.getInt("categorycode");
                    int without_RC = res.getInt("without_RC");
                    if (categorycode == 8 && without_RC == 1) {
                        pstmt1 = con.prepareStatement("select distinct(i.idInstitute), i.Institutename, s.state  from institute i left join state s on s.stateid=i.state  left join participant p on i.idInstitute=p.instituteid   left join accomodation a  on p.participantid=a.participantid where a.workshopid=? order by Institutename");
                        pstmt1.setString(1, workshopid);
                        res1 = pstmt1.executeQuery();
                    }
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        remoteCenter = new RemoteCenter();
                        remoteCenter.setRemoteCenterId(res1.getInt("idInstitute"));
                        remoteCenter.setRemoteCenterName(res1.getString("Institutename"));
                        remoteCenter.setRc_state(res1.getString("state"));
                        //set encrypted rc_id
                        String rc = res1.getString("idInstitute");
                        SimpleStringCipher cipher = new SimpleStringCipher();
                        try {
                            String enc_rcid = cipher.encrypt(rc);
                            remoteCenter.setEnc_RC(enc_rcid);

                        } catch (Exception ex) {
                            Logger.getLogger(UtilityProcess.class
                                    .getName()).log(Level.SEVERE, null, ex);
                        }
                        int count = 0;
                        pstmt2 = con.prepareStatement("select id,time from certificate_audit where workshopid=? and rcid=?");
                        pstmt2.setString(1, workshopid);
                        pstmt2.setString(2, rc);
                        res2 = pstmt2.executeQuery();
                        res2.last();
                        count = res2.getRow();
                        if (count > 0) {
                            remoteCenter.setIsAlreadyCertiGen("yes");
                            remoteCenter.setGenerateTime(res2.getString("time"));
                        }

                        int certificateCount = 0;
                        String[] totalParticipants;
                        pstmt3 = con.prepareStatement("select dispatch from certificate_audit where rcid=? and time in (select max(time) from certificate_audit where rcid=? and workshopid=?)");
                        pstmt3.setString(1, rc);
                        pstmt3.setString(2, rc);
                        pstmt3.setString(3, workshopid);
                        res3 = pstmt3.executeQuery();
                        while (res3.next()) {
                            String participants = res3.getString("dispatch");
                            totalParticipants = participants.split(",");
                            certificateCount = totalParticipants.length;
                        }
                        remoteCenter.setCertiGeneratedCount(String.valueOf(certificateCount));

                        if (categorycode == 8) {
                            pstmt4 = con.prepareStatement("select count(*) as totalcount from participant p,accomodation a where p.participantid=a.participantid and a.workshopid=? and p.instituteid=?  and p.status='Completed' and p.eligible_for_certificate='yes'");
                        } else {
                            pstmt4 = con.prepareStatement("select count(*) as totalcount from participant p,accomodation a where p.participantid=a.participantid and a.workshopid=? and p.instituteid=?  and p.status='Completed'");
                        }
                        pstmt4.setString(1, workshopid);
                        pstmt4.setString(2, rc);
                        res4 = pstmt4.executeQuery();
                        while (res4.next()) {
                            remoteCenter.setParticipantCount(res4.getString("totalcount"));
                        }
                        remoteCenters.add(remoteCenter);
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res4);
            DBConnection.closePStatement(pstmt4);
            DBConnection.closeResultSet(res3);
            DBConnection.closePStatement(pstmt3);
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return remoteCenters;
    }

    public ArrayList<Person> listParticipantsStateWise1(String workshopid, String state, String status) throws Exception {
        ArrayList<Person> participantList = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                /**
                 * The category code is fetched to fetch the list from the table
                 * and to determine if it is a coordinator workshop or a main
                 * workshop
                 */
                pstmt = con.prepareStatement("Select categorycode, respective_coordinatorid, without_RC from workshops WHERE workshopid=?");
                pstmt.setString(1, workshopid);
                res = pstmt.executeQuery();
                Person list = null;
                while (res.next()) {
                    int categorycode = res.getInt("categorycode");
                    int res_coord_id = res.getInt("respective_coordinatorid");
                    int without_RC = res.getInt("without_RC");
                    if (without_RC == 1) {
                        /**
                         * category 5, 7 and 8 are main workshops. the
                         * conditions are used to select the query depending on
                         * the status and state.
                         */
                        /* if ((state).equals("all") && (status).equals("all")) {
                         pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=c.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                         pstmt1.setString(1, workshopid);
                         } else if (!state.equals("all") && status.equals("all")) {
                         pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=c.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and c.state=? order by p.regtime");
                         pstmt1.setString(1, workshopid);
                         pstmt1.setInt(2, Integer.parseInt(state));
                         } else if (!state.equals("all") && !status.equals("all")) {
                         pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=c.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and c.state=? and p.status=? order by p.regtime");
                         pstmt1.setString(1, workshopid);
                         pstmt1.setInt(2, Integer.parseInt(state));
                         pstmt1.setString(3, status);
                         } else if (state.equals("all") && !status.equals("all")) {
                         pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=c.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                         pstmt1.setString(1, workshopid);
                         pstmt1.setString(2, status);
                         }*/

                        if ((state).equals("all") && (status).equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation, p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation   left join institute i on p.instituteid=i.idinstitute left join state s on s.stateid=i.state left join city ci on ci.cityid=i.city left join stream st on p.streamid=st.idstream where a.workshopid=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                        } else if (!state.equals("all") && status.equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join institute i on i.idinstitute=p.instituteid left join state s on s.stateid=i.state left join city ci on ci.cityid=i.city left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join stream st on p.streamid=st.idstream where a.workshopid=? and s.stateid=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(state));
                        } else if (!state.equals("all") && !status.equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join institute i on i.idinstitute=p.instituteid left join state s on s.stateid=i.state left join city ci on ci.cityid=i.city left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join stream st on p.streamid=st.idstream where a.workshopid=? and s.stateid=? and p.status=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setInt(2, Integer.parseInt(state));
                            pstmt1.setString(3, status);
                        } else if (state.equals("all") && !status.equals("all")) {
                            pstmt1 = con.prepareStatement("SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,p.instituteid, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment, p.eligible_for_certificate,per.facultystatus from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation   left join institute i on p.instituteid=i.idinstitute left join state s on s.stateid=i.state left join city ci on ci.cityid=i.city left join stream st on p.streamid=st.idstream where a.workshopid=? and p.status=? order by p.regtime");
                            pstmt1.setString(1, workshopid);
                            pstmt1.setString(2, status);
                        }

                    } else {
                        // no coordinator workshop occurs without a rc coordinator. In case of any future changes write code here ..
                    }
                    res1 = pstmt1.executeQuery();
                    while (res1.next()) {
                        list = new Person();
                        /**
                         * Set the details of the state of the participant in
                         * the ArrayList
                         */
                        RemoteCenter rc = new RemoteCenter();
                        rc.setRc_state(res1.getString("state"));
                        rc.setRc_city(res1.getString("city"));
                        list.setRemoteCenter(rc);
                        /**
                         * set the First Name, Last Name , mobile and email of
                         * the participant
                         */
                        list.setImage("photo_" + res1.getString("personid") + ".jpg");
                        list.setFirstName(res1.getString("firstname"));
                        list.setLastName(res1.getString("lastname"));
                        list.setMobileNumber(res1.getString("mobile"));
                        SimpleStringCipher cipher = new SimpleStringCipher();
                        String email_enc = cipher.encrypt(res1.getString("email"));
                        list.setEmail_enc(email_enc);
                        list.setEmail(res1.getString("email"));
                        /**
                         * set the registration details status, registration
                         * time , letter name, accommodation
                         */
                        RegistrationDetails registrationDetails = new RegistrationDetails();
                        registrationDetails.setStatus(res1.getString("status"));
                        registrationDetails.setRegtime(res1.getDate("regtime"));
                        registrationDetails.setLetter(res1.getString("letter"));
                        registrationDetails.setAccomodation(res1.getString("accomodation"));
                        registrationDetails.setParticipantid(res1.getString("participantid"));
                        if (categorycode == 8) {
                            registrationDetails.setPayment(res1.getString("payment"));
                            registrationDetails.setIsEligibleForCertificate(res1.getString("eligible_for_certificate"));
                            list.setFacultyStatus(res1.getString("facultystatus"));
                        }
                        list.setRegistrationDetails(registrationDetails);

                        Designation designation = new Designation();
                        designation.setDesignationName(res1.getString("designation"));
                        list.setDesignation(designation);
                        /**
                         * set the gender
                         */
                        list.setGender(res1.getString("genderinfo"));
                        /**
                         * Add the institute details if it is a main workshop
                         */
                        if (categorycode == 5 || categorycode == 7 || categorycode == 8) {
                            Institute institute = new Institute();
                            institute.setInstituteName(res1.getString("institutename"));
                            institute.setInstituteId(res1.getInt("instituteid"));
                            list.setInstitute(institute);
                        } else {
                            Institute institute = new Institute();
                            institute.setInstituteName("cc4");
                            list.setInstitute(institute);
                        }

                        /**
                         * Set qualification and experience
                         */
                        Qualification qualification = new Qualification();
                        qualification.setQualification(res1.getString("qualification"));
                        list.setQualification(qualification);

                        list.setExperience(res1.getString("experience"));
                        /**
                         * add stream in the list
                         */
                        Stream stream = new Stream();
                        stream.setStreamName(res1.getString("stream_name"));
                        list.setStream(stream);
                        /**
                         * add the details in the array list
                         */
                        /**
                         * Adding the status Matrix
                         */
                        StatusMatrix sm = new StatusMatrix();

                        pstmt2 = con.prepareStatement("select * from status_matrix where InitialStatus=?");
                        pstmt2.setString(1, res1.getString("status"));
                        res2 = pstmt2.executeQuery();
                        if (res2.next()) {
                            sm.setIfDisplayRegistered(res2.getString("Registered"));
                            sm.setIfDisplayInvalid(res2.getString("Invalid"));
                            sm.setIfDisplayApproved(res2.getString("Approved"));
                            sm.setIfDisplayConfirmed(res2.getString("Confirmed"));
                            sm.setIfDisplayCompleted(res2.getString("Completed"));
                            sm.setIfDisplayCancelled(res2.getString("Cancelled"));

                        }
                        list.setStatusMatrix(sm);

                        participantList.add(list);
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participantList;
    }

    public ArrayList<RegistrationDetails> getParticipantCountStateWise1(String workshopid, String state) throws Exception {
        ArrayList<RegistrationDetails> countArray = new ArrayList<RegistrationDetails>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                RegistrationDetails count = null;
                count = new RegistrationDetails();

                int totalParticipants = getCountStateWise1(workshopid, "all", "all");
                int registeredParticipants = getCountStateWise1(workshopid, state, "Request Registered");
                int verifiedParticipants = getCountStateWise1(workshopid, state, "Request Verified");
                int invalidParticipants = getCountStateWise1(workshopid, state, "Registration Invalid");
                int approvedParticipants = getCountStateWise1(workshopid, state, "Request Approved");
                int confirmedParticipants = getCountStateWise1(workshopid, state, "Confirmed");
                int waitlistedParticipants = getCountStateWise1(workshopid, state, "Waitlisted");
                int cancelledParticipants = getCountStateWise1(workshopid, state, "Cancelled");
                int completedParticipants = getCountStateWise1(workshopid, state, "Completed");
                int acceptedParticipants = getCountStateWise1(workshopid, state, "Accepted");
                // for all status specific rc
                int total_rc = getCountStateWise1(workshopid, state, "all");
                count.setTotalParticipants(totalParticipants);
                count.setRegisteredParticipants(registeredParticipants);
                count.setVerifiedParticipants(verifiedParticipants);
                count.setApprovedParticipants(approvedParticipants);
                count.setConfirmedParticipants(confirmedParticipants);
                count.setWaitlistedParticipants(waitlistedParticipants);
                count.setCancelledParticipants(cancelledParticipants);
                count.setInvalidParticipants(invalidParticipants);
                count.setCompletedParticipants(completedParticipants);
                count.setAcceptedParticipants(acceptedParticipants);
                count.setTotal_rc_participants(total_rc);
                countArray.add(count);

            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return countArray;
    }

    public int getCountStateWise1(String workshopid, String state, String status) {
        int countOfParticipants = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                if (state.equals("all") && status.equals("all")) {
                    // for all remote centers and all status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=?");
                    pstmt.setString(1, workshopid);
                }
                if (!state.equals("all") && status.equals("all")) {
                    // for specific remote centers and all status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p, institute i WHERE p.participantid=a.participantid and a.workshopid=? and p.instituteid = i.idInstitute and i.state=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, state);
                }
                if (state.equals("all") && !status.equals("all")) {
                    // for all remote centers and specific status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p WHERE p.participantid=a.participantid and a.workshopid=?  and p.status=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, status);
                }
                if (!state.equals("all") && !status.equals("all")) {
                    // for specific remote centers and specific status
                    pstmt = con.prepareStatement("SELECT count(a.participantid) FROM accomodation a, participant p, institute i WHERE p.participantid=a.participantid and p.instituteid = i.idInstitute and a.workshopid=? and i.state=?  and p.status=?");
                    pstmt.setString(1, workshopid);
                    pstmt.setString(2, state);
                    pstmt.setString(3, status);
                }
                res = pstmt.executeQuery();
                while (res.next()) {
                    countOfParticipants = res.getInt(1);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
        }
        return countOfParticipants;
    }

    public int initiateRefund(ParticipantReasons reason, int action, String email) {
        int value = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                // setting status = cancelled if the refund is initiated by participant
                pstmt = con.prepareStatement("update participant set payment='refund initiated', status='Cancelled' where participantid=?");
                pstmt.setInt(1, reason.getParticipantid());
                value = pstmt.executeUpdate();

                if (value > 0) {
                    //insert into participant reasons                    
                    storeParticipantReasons(action, reason);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return value;
    }

    public int refundByAccountsTeam(ParticipantReasons reason, int action, String email) {
        int value = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("update participant set payment='refunded' where participantid=?");
                pstmt.setInt(1, reason.getParticipantid());
                value = pstmt.executeUpdate();

                if (value > 0) {
                    //insert into participant reasons                    
                    storeParticipantReasons(action, reason);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return value;
    }

    public int getTransactionDetailsOfUser(String userid, String reqid) {
        int countrow = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select userid,reqid,ifnull(status,'') as status,workshopid,purpose,name from paymentdetails where userid=? and reqid=?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                // pstmt = con.prepareStatement("select userid,reqid,ifnull(status,'') as status,workshopid,purpose,name from paymentdetails where userid=? and reqid=?");
                pstmt.setString(1, userid);
                pstmt.setString(2, reqid);
                res = pstmt.executeQuery();
                res.last();
                countrow = res.getRow();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return countrow;
    }

    public ArrayList<PaymentGateway> getDetailsOfUser(String userid, String reqid) {
        int countrow = 0;
        ArrayList<PaymentGateway> getDetails = new ArrayList<PaymentGateway>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select ifnull(status,'') as status,workshopid,purpose,name,ifnull(reqtype,'') as reqtype from paymentdetails where userid=? and reqid=? limit 1", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                pstmt.setString(1, userid);
                pstmt.setString(2, reqid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    PaymentGateway pgbean = new PaymentGateway();
                    pgbean.setStatus(res.getString("status"));
                    pgbean.setWorkshopid(res.getString("workshopid"));
                    pgbean.setPurpose(res.getString("purpose"));
                    pgbean.setName(res.getString("name"));
                    pgbean.setReqestType(res.getString("reqtype"));
                    getDetails.add(pgbean);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return getDetails;
    }

    public int setQuerySW(String workshopid, String categorycode, String state, String context, String res_coid) {
        int count = 0;
        String query;
        ExcelSheet excel = new ExcelSheet();
        try {
            if (categorycode.equals("5") || categorycode.equals("7") || categorycode.equals("8")) {
                if (!state.equals("all")) {
//                    query = "SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,c.homephone,  p.qualification, p.experience,a.accomodation, CONCAT(r.remotecentername,',',ci.city) as center ,i.institutename, p.status, s.state, ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid='" + workshopid + "' and a.instituteid='" + rcid + "' order by p.regtime";
                    // query = "select a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,IFNULL(i.idInstitute,'') as InstituteId ,i.institutename, IFNULL(i.address,'') as Institute_Address, IFNULL(i.pincode, '') as Institute_Pincode, CONCAT(r.remotecentername,',',ci.city) as remotecentername , r.remotecenterid, s.state,  ci.city,a.accomodation,  p.status,d.designation, p.qualification, st.stream_name,   p.experience, c.homephone, l.letter, p.regtime from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid='" + workshopid + "' and a.instituteid='" + state + "' order by p.regtime";
                    query = "SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,IFNULL(p.instituteid,'') as InstituteId, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=c.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid='" + workshopid + "' and c.state='" + state + "' order by p.regtime";
                } else {
//                    query = "SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,c.homephone,  p.qualification, p.experience,a.accomodation, CONCAT(r.remotecentername,',',ci.city) as center,i.institutename, p.status, s.state, ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=r.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid='" + workshopid + "' order by p.regtime";
                    query = "SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile,  p.qualification, p.experience,a.accomodation,IFNULL(p.instituteid,'') as InstituteId, IFNULL(i.institutename,'NA') as institutename, p.status, s.state,  ci.city  , d.designation, l.letter, p.regtime, st.stream_name, p.payment from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=c.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid='" + workshopid + "' order by p.regtime";
                    //query = "select a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, IFNULL(i.idInstitute,'') as InstituteId, i.institutename,IFNULL(i.address,'') as Institute_Address, IFNULL(i.pincode, '') as Institute_Pincode,s.state,  ci.city,  p.status,d.designation, p.qualification, st.stream_name,   p.experience, p.payment l.letter, p.regtime from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join state s on s.stateid=c.state left join city ci on ci.cityid=r.city left join institute i on p.instituteid=i.idinstitute left join stream st on p.streamid=st.idstream where a.workshopid='" + workshopid + "' order by p.regtime";
                }
            } else {
//                if (Integer.parseInt(res_coid) == 0) {
//                    query = "SELECT a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, c.homephone, p.qualification, p.experience,a.accomodation, r.remotecentername as center , p.status, s.state, ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name  FROM accomodation a   left join  participant p on p.participantid=a.participantid  left join  person per on per.personid=p.personid  left join context  c on p.contextid=c.idcontext  left join  letter l on l.participantid=p.participantid  left join remotecenter r on a.instituteid=r.remotecenterid  left join designation d on d.iddesignation=per.designation left join state s on  s.stateid=r.state  left join city ci on ci.cityid=r.city  left join stream st on p.streamid=st.idstream  where  a.workshopid='" + workshopid + "' order by p.regtime";
//                    query = "select a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, i.institutename, CONCAT(r.remotecentername,',',ci.city) as remotecentername , r.remotecenterid, s.state,  ci.city,a.accomodation,  p.status,d.designation, p.qualification, st.stream_name,   p.experience, c.homephone, l.letter, p.regtime  FROM accomodation a   left join  participant p on p.participantid=a.participantid  left join  person per on per.personid=p.personid  left join context  c on p.contextid=c.idcontext  left join  letter l on l.participantid=p.participantid  left join remotecenter r on a.instituteid=r.remotecenterid  left join designation d on d.iddesignation=per.designation left join state s on  s.stateid=r.state  left join city ci on ci.cityid=r.city  left join stream st on p.streamid=st.idstream  where  a.workshopid='" + workshopid + "' order by p.regtime";
//                } else {
                // query = "SELECT a.participantid, per.firstname, per.lastname, c.email,c.mobile, c.homephone, p.qualification, p.experience,a.accomodation, r.remotecentername as center , p.status,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name  FROM accomodation a   left join  participant p on p.participantid=a.participantid  left join  person per on per.personid=p.personid  left join context  c on p.contextid=c.idcontext  left join  letter l on l.participantid=p.participantid  left join remotecenter r on a.instituteid=r.remotecenterid  left join designation d on d.iddesignation=per.designation left join state s on  s.stateid=r.state  left join city ci on ci.cityid=r.city  left join stream st on p.streamid=st.idstream  where  a.workshopid='" + workshopid + "' order by p.regtime";
//                    query = "SELECT a.participantid,per.personid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, c.homephone,   p.qualification, p.experience,a.accomodation ,i.institutename as remotecentername , p.status, s.state,  ci.city  , r.remotecenterid, d.designation, l.letter, p.regtime, st.stream_name from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=' " + workshopid + "' order by p.regtime";
//                query = "select a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, i.institutename, CONCAT(r.remotecentername,',',ci.city) as remotecentername , r.remotecenterid, s.state,  ci.city,a.accomodation,  p.status,d.designation, p.qualification, st.stream_name,   p.experience, c.homephone, l.letter, p.regtime from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=' " + workshopid + "' order by p.regtime";
//                }
                query = "select a.participantid, per.firstname, per.lastname,per.genderinfo, c.email,c.mobile, IFNULL(i.idInstitute,'') as InstituteId, i.institutename,IFNULL(i.address,'') as Institute_Address, IFNULL(i.pincode, '') as Institute_Pincode, CONCAT(r.remotecentername,',',ci.city) as remotecentername , r.remotecenterid, s.state,  ci.city,a.accomodation,  p.status,d.designation, p.qualification, st.stream_name,   p.experience, c.homephone, l.letter, p.regtime from accomodation a left join participant p  on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join letter l on l.participantid=a.participantid left join remotecenter r on a.instituteid=r.remotecenterid left join person per on per.personid=c.idcontext left join designation d on d.iddesignation=per.designation left join institute i on p.instituteid=i.idinstitute left join city ci on ci.cityid=i.city  left join state s on s.stateid=i.state left join stream st on p.streamid=st.idstream where a.workshopid=' " + workshopid + "' order by p.regtime";

            }

            String fileName = null;
            if (!state.equals("all")) {
                String state1 = "";
                try {
                    if (con == null || con.isClosed()) {
                        con = DBConnection.getDBConnection();
                    }
                    if (con != null) {
                        pstmt = con.prepareStatement("select state from state where stateid=?");
                        pstmt.setString(1, state);
                        res = pstmt.executeQuery();
                        while (res.next()) {
                            state1 = res.getString("state");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    DBConnection.closeResultSet(res);
                    DBConnection.closePStatement(pstmt);
                    DBConnection.closeDBConnection(con);
                }

                fileName = context + "Excel_Sheets/" + workshopid + "_" + state1 + ".xls";
            } else {
                fileName = context + "Excel_Sheets/" + workshopid + ".xls";
            }
            boolean result = excel.createExcel(query, fileName);
            if (result == true) {
                count = 1;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;

    }

    public String getStateName(String stateid) {
        String state = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select state from state where stateid=?");
                pstmt.setString(1, stateid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    state = res.getString("state");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return state;
    }
}//end of class

