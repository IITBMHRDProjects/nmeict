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
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class CoordinatorListAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<Person> coordinatorList;

    public String execute() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        UtilityProcess process = new UtilityProcess();
        /**
         * cipher for decrypting the 'workshopid', 'rcid', status from the 'url'
         */
        SimpleStringCipher cipher = new SimpleStringCipher();
        /**
         * getting the parameters from 'url'
         */
        String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
        String workshopid = cipher.decrypt(workshopid_encrypted);
        workshopContent = (process.listWorkshopContent(workshopid));
        setWorkshopContent(workshopContent);
        coordinatorList = (process.getCoordinatorList(workshopid));
        setCoordinatorList(coordinatorList);

        return Utility.SUCCESS;
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
     * @return the coordinatorList
     */
    public ArrayList<Person> getCoordinatorList() {
        return coordinatorList;
    }

    /**
     * @param coordinatorList the coordinatorList to set
     */
    public void setCoordinatorList(ArrayList<Person> coordinatorList) {
        this.coordinatorList = coordinatorList;
    }
}
