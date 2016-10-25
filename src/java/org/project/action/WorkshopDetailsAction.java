/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.bean.WorkshopContent;
import org.project.bean.Person;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class WorkshopDetailsAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<Person> participantList;
    private ArrayList<Person> participantCenters_main;

    @Override
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
        String rcid = "all";
        //To display the list of participants who are confirmed
        String status = "Confirmed";
        //fetching the arraylist of announcements
        workshopContent = (process.listWorkshopContent(workshopid));
        setWorkshopContent(workshopContent);
        /*
         * code added to show both confirmed and the completed participants
         * get list 1 for status confirmed
         * get list 2 for status completed
         */
        ArrayList<Person> list_confirmed = process.listParticipants(workshopid, rcid, "Confirmed");
        ArrayList<Person> list_completed = process.listParticipants(workshopid, rcid, "Completed");

//        participantList = (process.listParticipants(workshopid, rcid, status));
        participantList= new ArrayList<Person>();
        participantList.addAll(list_confirmed);        
        participantList.addAll(list_completed);
        setParticipantList(participantList);
        participantCenters_main = process.listParticipantCenters(workshopid);
        setParticipantCenters_main(participantCenters_main);
        return Utility.SUCCESS;
    }

    /**
     * @return the workshopContents
     */
    public ArrayList<WorkshopContent> getWorkshopContent() {
        return workshopContent;
    }

    /**
     * @param workshopContent the workshopContents to set
     */
    public void setWorkshopContent(ArrayList<WorkshopContent> workshopContent) {
        this.workshopContent = workshopContent;
    }

    /**
     * @return the participantList
     */
    public ArrayList<Person> getParticipantList() {
        return participantList;
    }

    /**
     * @param participantList the participantList to set
     */
    public void setParticipantList(ArrayList<Person> participantList) {
        this.participantList = participantList;
    }

    /**
     * @return the participantCenters_main
     */
    public ArrayList<Person> getParticipantCenters_main() {
        return participantCenters_main;
    }

    /**
     * @param participantCenters_main the participantCenters_main to set
     */
    public void setParticipantCenters_main(ArrayList<Person> participantCenters_main) {
        this.participantCenters_main = participantCenters_main;
    }
}
