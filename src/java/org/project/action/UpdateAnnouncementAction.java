/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;

import org.project.bean.Announcements;
import org.project.process.UtilityProcess;

/**
 *
 * @author dipesh
 */
public class UpdateAnnouncementAction extends ActionSupport {

    private Announcements announcement;
    private String s_Announcement;
    private String startdate;
    private String enddate;
    private String location;
    private String announcementid;
    private String radio_location;
    private ArrayList<Announcements> announcements;

    public String execute() throws Exception {
        UtilityProcess process = new UtilityProcess();
        HttpSession session = ServletActionContext.getRequest().getSession();
        // setAnnouncements(process.listAnnouncements());
        // setAnnouncements(announcements);
        /**
         * setting value of annnouncement, link to param announcement,link
         */
        String link = getAnnouncement().getLink().trim();
        String announcement1 = getAnnouncement().getAnnouncement().trim();
        /**
         * setting type and aanouncementid(annouc_id) as 0 for inserting
         * external announcement
         *
         */
        int type = 0;
        int announc_id = 0;
        String status = "Forthcoming";
        /* SimpleDateFormat from = new SimpleDateFormat("dd-MM-yyyy");
         SimpleDateFormat to = new SimpleDateFormat("yyyy-MM-dd");
         Date sdate = from.parse(getStartdate());
         Date edate = from.parse(getEnddate());
         String mysqlStartdate = to.format(sdate);
         String mysqlEnddate = to.format(edate);
         */
        /**
         * setting message as blank
         */
        session.setAttribute("message", "");
       if (s_Announcement.equals("-2")) {
            /**
             * if announcement is new then following operation perform
             */
            int res = 0;
            try {
                // insert method start here (insertAnnouncement)
                announcement.setAnnouncement(announcement1);
                announcement.setLink(link);
                announcement.setLocation(radio_location);
                // announcement.setLocation(location);
                announcement.setAnnouncementid(announc_id);
                announcement.setType(type);
                announcement.setStartdate(getStartdate());
                announcement.setEnddate(getEnddate());
                announcement.setStatus(status);
                setAnnouncement(announcement);
                res = process.insertAnnouncement(announcement);
                // res = process.insertAnnouncement(announcement1, link, mysqlStartdate, mysqlEnddate, location, type, announc_id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            /**
             * if res is greater then 0 means data inserted successfully
             */
            if (res > 0) {
                /**
                 * if insert successful then setting message as Data Inserted
                 * Successfully
                 */
                session.setAttribute("message", "<font color='green'>Data Inserted Successfully.</font>");
            } else {
                /**
                 * if insert failed then setting message as Insertion Failed
                 *
                 */
                session.setAttribute("message", "<font color='red'>Insertion Failed.</font>");
            }
        } else if (!s_Announcement.equals("-1") && !s_Announcement.equals("-2")) {
            /**
             * if announcement is not new or updating old announcement then
             * following operation perform
             *
             */
            int a_id = Integer.parseInt(announcementid);
            int result = 0;
            try {
                // update method start here (updateAnnouncement)
                announcement.setAnnouncement(announcement1);
                announcement.setLink(link);
                announcement.setLocation(radio_location);
                // announcement.setLocation(location);
                announcement.setAnnouncementid(a_id);
                announcement.setStartdate(getStartdate());
                announcement.setEnddate(getEnddate());
                setAnnouncement(announcement);
                result = process.updateAnnouncement(announcement);
                // result = process.updateAnnouncement(getAnnouncement().getAnnouncement(), link, mysqlStartdate, mysqlEnddate, location, a_id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (result > 0) {
                session.setAttribute("message", "<font color='green'>Data Successfully Updated.</font>");
            } else {
                session.setAttribute("message", "<font color='red'>Updation Failed.</font>");
            }
        } else {
            session.setAttribute("message", "<font color=''>No Change Reflected.</font>");
        }
        return SUCCESS;
    }

    /**
     * validate method for validating announcement,link,startdate,enddate
     */
    public void validate() {
        clearFieldErrors();
        if (getAnnouncement().getAnnouncement() == null || getAnnouncement().getAnnouncement().length() == 0) {
            addFieldError("Announcement", getText("announcement.required"));
        }
        if (getAnnouncement().getLink().trim() == null || getAnnouncement().getLink().trim().length() == 0) {
            addFieldError("Link", getText("link.required"));
         }
        if (getStartdate().equals(null) || getStartdate().trim().length() == 0) {
            addFieldError("StartDate", getText("sdate.required"));
        }
        if (getEnddate().equals(null) || getEnddate().trim().length() == 0) {
            addFieldError("EndDate", getText("edate.required"));
        }
        String location = "";
        try {
            location = getLocation();
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        /* if(location == null || location.trim().length()==0){
         addFieldError("Location", getText("location.required"));
         }*/
    }

    /**
     * @return the announcement
     */
    public Announcements getAnnouncement() {
        return announcement;
    }

    /**
     * @param announcement the announcement to set
     */
    public void setAnnouncement(Announcements announcement) {
        this.announcement = announcement;
    }

    /**
     * @return the s_Announcement
     */
    public String getS_Announcement() {
        return s_Announcement;
    }

    /**
     * @param s_Announcement the s_Announcement to set
     */
    public void setS_Announcement(String s_Announcement) {
        this.s_Announcement = s_Announcement;
    }

    /**
     * @return the startdate
     */
    public String getStartdate() {
        return startdate;
    }

    /**
     * @param startdate the startdate to set
     */
    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    /**
     * @return the enddate
     */
    public String getEnddate() {
        return enddate;
    }

    /**
     * @param enddate the enddate to set
     */
    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    /**
     * @return the location
     */
    public String getLocation() {
        return location;
    }

    /**
     * @param location the location to set
     */
    public void setLocation(String location) {
        this.location = location;
    }

    /**
     * @return the announcementid
     */
    public String getAnnouncementid() {
        return announcementid;
    }

    /**
     * @param announcementid the announcementid to set
     */
    public void setAnnouncementid(String announcementid) {
        this.announcementid = announcementid;
    }

    /**
     * @return the announcements
     */
    public ArrayList<Announcements> getAnnouncements() {
        return announcements;
    }

    /**
     * @param announcements the announcements to set
     */
    public void setAnnouncements(ArrayList<Announcements> announcements) {
        this.announcements = announcements;
    }

    /**
     * @return the radio_location
     */
    public String getRadio_location() {
        return radio_location;
    }

    /**
     * @param radio_location the radio_location to set
     */
    public void setRadio_location(String radio_location) {
        this.radio_location = radio_location;
    }
}
