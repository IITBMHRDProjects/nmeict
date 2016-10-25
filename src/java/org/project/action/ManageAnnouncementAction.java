/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Announcements;
import org.project.bean.Person;
import org.project.process.UtilityProcess;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class ManageAnnouncementAction extends ActionSupport {

    private ArrayList<Announcements> announcements;

    public String execute() throws Exception {
        UtilityProcess process = new UtilityProcess();
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        }
        //fetching the arraylist of workshopContent  
        //  setAnnouncements(process.getAllAnnouncement());
        setAnnouncements(process.listAnnouncements());
        setAnnouncements(announcements);
        // System.out.println("in action class");
        return Utility.SUCCESS;
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
     * @return the announcement
     */
}
