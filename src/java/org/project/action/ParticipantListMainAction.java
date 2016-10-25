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
public class ParticipantListMainAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<Person> participantList_main;

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
        String rcid_encrypted = ServletActionContext.getRequest().getParameter("rcid");
        String rcid = cipher.decrypt(rcid_encrypted);
        String status_encrypted = ServletActionContext.getRequest().getParameter("status");
        String status = cipher.decrypt(status_encrypted);
        workshopContent = (process.listWorkshopContent(workshopid));
        setWorkshopContent(workshopContent);
        /*
         * add participants who are both confirmed and 
         */
        participantList_main=new ArrayList<Person>();
        participantList_main.addAll(process.listParticipants(workshopid, rcid, "Confirmed"));
        participantList_main.addAll(process.listParticipants(workshopid, rcid, "Completed"));
        setParticipantList_main(participantList_main);
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
     * @return the participantList_main
     */
    public ArrayList<Person> getParticipantList_main() {
        return participantList_main;
    }

    /**
     * @param participantList_main the participantList_main to set
     */
    public void setParticipantList_main(ArrayList<Person> participantList_main) {
        this.participantList_main = participantList_main;
    }
}
