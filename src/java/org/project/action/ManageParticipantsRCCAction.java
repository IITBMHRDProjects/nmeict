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
import org.project.bean.RemoteCenter;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class ManageParticipantsRCCAction extends ActionSupport {

    private ArrayList<Person> participantdetails;
    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<RemoteCenter> remoteCenters;
    private int rcid_present = 0;

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
            String state = "all";
            UtilityProcess process = new UtilityProcess();
            //fetching the arraylist of workshopContent           
            setWorkshopContent(process.listWorkshopContent(workshopid));
            //fetching the arraylist of participant details
            setParticipantdetails(process.listParticipants(workshopid, rcid, "Request Approved"));
            //fetching arraylist of the remotecenters registered for the particular workshop
            setRemoteCenters(process.listRemoteCenters(workshopid, state));

            return Utility.SUCCESS;
        }
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
}
