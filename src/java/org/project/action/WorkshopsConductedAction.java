/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.bean.WorkshopCount;
import org.project.bean.WorkshopContent;
import org.project.bean.Person;
import com.opensymphony.xwork2.ActionSupport;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class WorkshopsConductedAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContents;
    private ArrayList<WorkshopCount> workshopCount;
    private String update;

    public String execute() throws Exception {
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
            if (update.equals("view")) {
                Date date = new Date();
                Date may12009 = new GregorianCalendar(2009, 05, 01).getTime();
                long diff = date.getTime() - may12009.getTime();
                period = Long.toString(diff / (1000 * 60 * 60 * 24)) + " day";
            }
            //updateReg
            if (update.equals("updateReg")) {

                period = "15 day";
            }

            // update status - list all workshops
//            if (update.equals("status")) {
//                period = "2920 day";
//            }
            workshopContents = (process.listWorkshopsConducted1(period));
        } else {
            workshopContents = (process.listWorkshopsConducted(period));
        }

        //fetching the arraylist of announcements
        setWorkshopContents(workshopContents);
        workshopCount = (process.getWorkshopCount());
        setWorkshopCount(workshopCount);
        return Utility.SUCCESS;
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
}
