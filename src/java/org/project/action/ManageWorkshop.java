/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class ManageWorkshop extends ActionSupport {

    private ArrayList<WorkshopContent> recentWorkshops;

    public String execute() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess process = new UtilityProcess();
            recentWorkshops = (process.listRecentWorkshops());
            setRecentWorkshops(recentWorkshops);
            return Utility.SUCCESS;
        }
    }

    /**
     * @return the recentWorkshops
     */
    public ArrayList<WorkshopContent> getRecentWorkshops() {
        return recentWorkshops;
    }

    /**
     * @param recentWorkshops the recentWorkshops to set
     */
    public void setRecentWorkshops(ArrayList<WorkshopContent> recentWorkshops) {
        this.recentWorkshops = recentWorkshops;
    }
}
