/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.bean.Person;
import org.project.bean.Announcements;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.process.UtilityProcess;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class AnnouncementsAction extends ActionSupport {

    /**
     * An array list for announcements inside and outside organisation
     */
    private ArrayList<Announcements> announcements;

    @Override
    public String execute() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        UtilityProcess process = new UtilityProcess();
        //fetching the arraylist of announcements
        announcements = new ArrayList<Announcements>();
        if (person == null) {
            announcements.addAll(process.listPublicAnnouncements());
        }
        if (person != null && person.getLoginId() > 0) {
            announcements.addAll(process.listAnnouncements(person.getLoginId()));
            announcements.addAll(process.listPublicAnnouncements());
        }
        setAnnouncements(announcements);


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
}
