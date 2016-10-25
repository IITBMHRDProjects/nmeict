/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import javax.crypto.Cipher;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.DataExportActivityBean;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.bean.WorkshopCount;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author dipesh
 */
public class WorkshopAttendedReportAction extends ActionSupport {

    private ArrayList<DataExportActivityBean> participantwisedata;
    private ArrayList<DataExportActivityBean> institutewisedata;
    private int totalsize = 0;
    private ArrayList<WorkshopContent> workshopContents;
    private ArrayList<WorkshopCount> workshopCount;
    private String update;

    public String getWorkshopAttendedReport() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        }
        if (person != null) {
            try {
                String workshop_criteria = ServletActionContext.getRequest().getParameter("val");
                UtilityProcess upro = new UtilityProcess();
                if (workshop_criteria.equals("participant")) {
                    try {
                        String range = null;
                        range = ServletActionContext.getRequest().getParameter("range");
                        participantwisedata = upro.getParticipantWiseWorkshopReport(Integer.parseInt(range));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else if (workshop_criteria.equals("institute")) {
                    institutewisedata = upro.getInstituteWiseWorkshopReport();
                } else {
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return SUCCESS;
    }

    public String getFacultyAttendedByInstitute() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        }
        if (person != null) {
            try {
                String workshopid = ServletActionContext.getRequest().getParameter("workshopid");
                UtilityProcess upro = new UtilityProcess();
                SimpleStringCipher cipher = new SimpleStringCipher();
                workshopid=cipher.decrypt(workshopid);
                int workshop_id=0;
                workshop_id=Integer.parseInt(workshopid);
                System.out.println(workshop_id);
                if (workshop_id > 0) {
                    try {
                        institutewisedata = upro.getInstituteWiseFacultyAttendedReport(workshop_id);
                         System.out.println(institutewisedata.size());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return SUCCESS;
    }

    
     public String getWorkshopList() {
        try {
            /*
             * Getting user session object
             */
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            UtilityProcess process = new UtilityProcess();
            String update_enc = ServletActionContext.getRequest().getParameter("update");
            String period = "90 day";
            if (update_enc != null && update_enc != "") {
                SimpleStringCipher cipher = new SimpleStringCipher();
                update = cipher.decrypt(update_enc);
                if (update.equals("listworkshop") || update.equals("listworkshopreport")) {
                    Date date = new Date();
                    Date may12009 = new GregorianCalendar(2009, 05, 01).getTime();
                    long diff = date.getTime() - may12009.getTime();
                    period = Long.toString(diff / (1000 * 60 * 60 * 24)) + " day";
                }
                //updateReg
                if (update.equals("updateReg")) {

                    period = "15 day";
                }
                if (update.equals("listworkshop")) {
                 //   workshopContents = (process.listWorkshopsOfFaculty(period, person));
                } else if (update.equals("listworkshopreport")) {
                    workshopContents = (process.listWorkshopsConducted(period));
                }
                
            } else {
                //workshopContents = (process.listWorkshopsConducted(period));
            }

            //fetching the arraylist of announcements

            setWorkshopContents(workshopContents);
            workshopCount = (process.getWorkshopCount());
            setWorkshopCount(workshopCount);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }
    /**
     * @return the participantwisedata
     */
    public ArrayList<DataExportActivityBean> getParticipantwisedata() {
        return participantwisedata;
    }

    /**
     * @param participantwisedata the participantwisedata to set
     */
    public void setParticipantwisedata(ArrayList<DataExportActivityBean> participantwisedata) {
        this.participantwisedata = participantwisedata;
    }

    /**
     * @return the institutewisedata
     */
    public ArrayList<DataExportActivityBean> getInstitutewisedata() {
        return institutewisedata;
    }

    /**
     * @param institutewisedata the institutewisedata to set
     */
    public void setInstitutewisedata(ArrayList<DataExportActivityBean> institutewisedata) {
        this.institutewisedata = institutewisedata;
    }

    /**
     * @return the totalsize
     */
    public int getTotalsize() {
        return totalsize;
    }

    /**
     * @param totalsize the totalsize to set
     */
    public void setTotalsize(int totalsize) {
        this.totalsize = totalsize;
    }

    /**
     * @return the workshopContents
     */
    public ArrayList<WorkshopContent> getWorkshopContents() {
        return workshopContents;
    }

    /**
     * @param workshopContents the workshopContents to set
     */
    public void setWorkshopContents(ArrayList<WorkshopContent> workshopContents) {
        this.workshopContents = workshopContents;
    }

    /**
     * @return the workshopCount
     */
    public ArrayList<WorkshopCount> getWorkshopCount() {
        return workshopCount;
    }

    /**
     * @param workshopCount the workshopCount to set
     */
    public void setWorkshopCount(ArrayList<WorkshopCount> workshopCount) {
        this.workshopCount = workshopCount;
    }

    /**
     * @return the update
     */
    public String getUpdate() {
        return update;
    }

    /**
     * @param update the update to set
     */
    public void setUpdate(String update) {
        this.update = update;
    }
}
