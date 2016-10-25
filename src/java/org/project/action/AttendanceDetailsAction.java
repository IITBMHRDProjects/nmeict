/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.AttendanceSchedule;
import org.project.bean.AttendanceSheet;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class AttendanceDetailsAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<RemoteCenter> remoteCenters;
    private ArrayList<RemoteCenter> rc_institute;
    private WorkshopContent content;
    private int rcid_present = 0;
    private ArrayList<Person> participantdetails;
    private ArrayList<AttendanceSchedule> schedule;
    private ArrayList<AttendanceSchedule> schedule1, schedule2;
    private ArrayList<AttendanceSheet> sheet;
    private int ifAttendanceSheetCreated = 0;
    private int participantCount = 0;
    private ArrayList<AttendanceSchedule> schtest;
    private String schedule_path;
    private int checkUpload = 0;

    @Override
    public String execute() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            /**
             * cipher for decrypting the 'workshopid', 'rcid', status from the
             * 'url'
             */
            SimpleStringCipher cipher = new SimpleStringCipher();
            /**
             * getting the parameters from 'url'
             */
            String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
            String workshopid = cipher.decrypt(workshopid_encrypted);
            String rcid_encrypted = ServletActionContext.getRequest().getParameter("rcid");
            String rcid = cipher.decrypt(rcid_encrypted);
//        String status_encrypted = ServletActionContext.getRequest().getParameter("status");
//        String status = cipher.decrypt(status_encrypted);
            String state = "all";
            UtilityProcess process = new UtilityProcess();
            //fetching the arraylist of workshopContent           
            setWorkshopContent(process.listWorkshopContent(workshopid));
            //fetching the arraylist of participant details
//            setParticipantdetails(process.listParticipants(workshopid, rcid, "Confirmed"));
            //fetching arraylist of the remotecenters registered for the particular workshop
            setParticipantCount(process.getCount1(workshopid, rcid, "Confirmed"));

//            setRemoteCenters(process.listRemoteCenters(workshopid, state));
//        countOfParticipants = (process.getParticipantCount(workshopid, rcid));

            // get the program schedule
            setSchedule(process.getProgramSchedule(workshopid));


            //set present rcid
//            if (!rcid.equals("all")) {
//                setRcid_present(Integer.parseInt(rcid));
//            }

            ifAttendanceSheetCreated = process.ifAttendanceCreated(workshopid);

            return Utility.SUCCESS;
        }
    }

    public String getProgramSchedule() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            SimpleStringCipher cipher = new SimpleStringCipher();
            /**
             * getting the parameters from 'url'
             */
            String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
            String workshopid = cipher.decrypt(workshopid_encrypted);
            UtilityProcess process = new UtilityProcess();
            //fetching the arraylist of workshopContent           
            setWorkshopContent(process.listWorkshopContent(workshopid));
            // get the program schedule
            setSchedule(process.getProgramSchedule(workshopid));
            setSchtest(process.getDistinctDateProgramSchedule(workshopid));
            String context = ServletActionContext.getServletContext().getRealPath("");
            setSchedule_path("pdfs/schedule_" + workshopid + ".pdf");
            return Utility.SUCCESS;
        }
    }

    public String getAttendanceSheet() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            /**
             * cipher for decrypting the 'workshopid', 'rcid', status from the
             * 'url'
             */
            SimpleStringCipher cipher = new SimpleStringCipher();
            /**
             * getting the parameters from 'url'
             */
            String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
            String workshopid = cipher.decrypt(workshopid_encrypted);
            String rcid_encrypted = ServletActionContext.getRequest().getParameter("rcid");
            String rcid = cipher.decrypt(rcid_encrypted);
//        String status_encrypted = ServletActionContext.getRequest().getParameter("status");
//        String status = cipher.decrypt(status_encrypted);
            String state = "all";
            UtilityProcess process = new UtilityProcess();
            //fetching the arraylist of workshopContent           
            setWorkshopContent(process.listWorkshopContent(workshopid));
            //fetching the arraylist of participant details
            //setParticipantdetails(process.listParticipants(workshopid, rcid, "Confirmed"));
            //fetching arraylist of the remotecenters registered for the particular workshop
            setRemoteCenters(process.listRemoteCenters(workshopid, state));
//        countOfParticipants = (process.getParticipantCount(workshopid, rcid));

            // get the program schedule
            setSchedule1(process.getProgramSchedule1(workshopid, rcid));
//        setSchedule(process.getProgramSchedule(workshopid));
            // setSheet(process.getAttendanceSheet(workshopid));
            setSheet(process.getAttendanceSheetConsolidated(workshopid, rcid));

            //set present rcid
            if (!rcid.equals("all")) {
                setRcid_present(Integer.parseInt(rcid));
            }

            return Utility.SUCCESS;
        }
    }

    public String getAttendanceSheetWSC() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            /**
             * cipher for decrypting the 'workshopid', 'rcid', status from the
             * 'url'
             */
            SimpleStringCipher cipher = new SimpleStringCipher();
            /**
             * getting the parameters from 'url'
             */
            String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
            String workshopid = cipher.decrypt(workshopid_encrypted);
            String rcid_encrypted = ServletActionContext.getRequest().getParameter("rcid");
            String rcid = cipher.decrypt(rcid_encrypted);

            String date_encrypted = ServletActionContext.getRequest().getParameter("date");
            if (date_encrypted.equals("-SIpJewWW2Nr56jHwvqJiw")) {
                date_encrypted = "none";
            }
            // String date = cipher.decrypt(date_encrypted);
//        String status_encrypted = ServletActionContext.getRequest().getParameter("status");
//        String status = cipher.decrypt(status_encrypted);
            String state = "all";
            UtilityProcess process = new UtilityProcess();
            //fetching the arraylist of workshopContent           
            setWorkshopContent(process.listWorkshopContent(workshopid));
            //fetching the arraylist of participant details
            //setParticipantdetails(process.listParticipants(workshopid, rcid, "Confirmed"));
            //fetching arraylist of the remotecenters registered for the particular workshop
            setRemoteCenters(process.listRemoteCenters(workshopid, state));
//        countOfParticipants = (process.getParticipantCount(workshopid, rcid));

            // get the program schedule
            setSchedule1(process.getProgramSchedule2(workshopid, rcid, date_encrypted));
            setSchedule2(process.getDistinctDateProgramSchedule1(workshopid, rcid));
//        setSchedule(process.getProgramSchedule(workshopid));
//        setSheet(process.getAttendanceSheet(workshopid));

            //set present rcid
            if (!rcid.equals("all")) {
                setRcid_present(Integer.parseInt(rcid));
            }

            setCheckUpload(process.checkWSCCanUpload(workshopid, rcid));

            return Utility.SUCCESS;
        }
    }

    public String insertNewParticipantInAttendance() {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess process = new UtilityProcess();
            /*
             * participantCount is set here as participant id -- setting variable in jsp page for fetching in this action page.
             */
            int result = process.createAttendanceSheet(content.getWorkshopid(), participantCount);
            clearErrorsAndMessages();
            if (result > 0) {
                addActionMessage("Successfully created");
            } else {
                addActionError("Problem in insertion, try again.");
            }
            return Utility.SUCCESS;
        }
    }

    public String checkLogin() {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            return Utility.SUCCESS;
        }
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
     * @return the remoteCenters
     */
    public ArrayList<RemoteCenter> getRemoteCenters() {
        return remoteCenters;
    }

    /**
     * @param remoteCenters the remoteCenters to set
     */
    public void setRemoteCenters(ArrayList<RemoteCenter> remoteCenters) {
        this.remoteCenters = remoteCenters;
    }

    /**
     * @return the rc_institute
     */
    public ArrayList<RemoteCenter> getRc_institute() {
        return rc_institute;
    }

    /**
     * @param rc_institute the rc_institute to set
     */
    public void setRc_institute(ArrayList<RemoteCenter> rc_institute) {
        this.rc_institute = rc_institute;
    }

    /**
     * @return the content
     */
    public WorkshopContent getContent() {
        return content;
    }

    /**
     * @param content the content to set
     */
    public void setContent(WorkshopContent content) {
        this.content = content;
    }

    /**
     * @return the rcid_present
     */
    public int getRcid_present() {
        return rcid_present;
    }

    /**
     * @param rcid_present the rcid_present to set
     */
    public void setRcid_present(int rcid_present) {
        this.rcid_present = rcid_present;
    }

    /**
     * @return the participantdetails
     */
    public ArrayList<Person> getParticipantdetails() {
        return participantdetails;
    }

    /**
     * @param participantdetails the participantdetails to set
     */
    public void setParticipantdetails(ArrayList<Person> participantdetails) {
        this.participantdetails = participantdetails;
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

    /**
     * @return the sheet
     */
    public ArrayList<AttendanceSheet> getSheet() {
        return sheet;
    }

    /**
     * @param sheet the sheet to set
     */
    public void setSheet(ArrayList<AttendanceSheet> sheet) {
        this.sheet = sheet;
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

    /**
     * @return the ifAttendanceSheetCreated
     */
    public int getIfAttendanceSheetCreated() {
        return ifAttendanceSheetCreated;
    }

    /**
     * @param ifAttendanceSheetCreated the ifAttendanceSheetCreated to set
     */
    public void setIfAttendanceSheetCreated(int ifAttendanceSheetCreated) {
        this.ifAttendanceSheetCreated = ifAttendanceSheetCreated;
    }

    /**
     * @return the participantCount
     */
    public int getParticipantCount() {
        return participantCount;
    }

    /**
     * @param participantCount the participantCount to set
     */
    public void setParticipantCount(int participantCount) {
        this.participantCount = participantCount;
    }

    /**
     * @return the schtest
     */
    public ArrayList<AttendanceSchedule> getSchtest() {
        return schtest;
    }

    /**
     * @param schtest the schtest to set
     */
    public void setSchtest(ArrayList<AttendanceSchedule> schtest) {
        this.schtest = schtest;
    }

    /**
     * @return the schedule_path
     */
    public String getSchedule_path() {
        return schedule_path;
    }

    /**
     * @param schedule_path the schedule_path to set
     */
    public void setSchedule_path(String schedule_path) {
        this.schedule_path = schedule_path;
    }

    /**
     * @return the checkUpload
     */
    public int getCheckUpload() {
        return checkUpload;
    }

    /**
     * @param checkUpload the checkUpload to set
     */
    public void setCheckUpload(int checkUpload) {
        this.checkUpload = checkUpload;
    }

    /**
     * @return the schedule1
     */
    public ArrayList<AttendanceSchedule> getSchedule2() {
        return schedule2;
    }

    /**
     * @param schedule1 the schedule1 to set
     */
    public void setSchedule2(ArrayList<AttendanceSchedule> schedule2) {
        this.schedule2 = schedule2;
    }
}
