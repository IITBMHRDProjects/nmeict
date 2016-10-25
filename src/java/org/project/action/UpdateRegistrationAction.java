/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;
import org.project.bean.RemoteCenterCapacity;
import org.project.bean.State;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class UpdateRegistrationAction {

    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<State> stateList;
    private ArrayList<RemoteCenter> remotecenterList;
    private Participant participant;
    private Person participantDetails;
    private int acco_available;
    private int facultyStatus = 0;

    public String execute() {

        try {
            /*
             * Getting user session object
             */
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            if (person == null) {
                return Utility.LOGIN_FAILURE;
            } else {

                UtilityProcess process = new UtilityProcess();
                /**
                 * cipher for decrypting the workshopid from the url
                 */
                SimpleStringCipher cipher = new SimpleStringCipher();
                /**
                 * getting the parameter from url
                 */
                String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
                String workshopid = cipher.decrypt(workshopid_encrypted);

                UserProcess userproc = new UserProcess();
                facultyStatus = userproc.getFactulyStatus(person.getLoginId());
                participant = new Participant();
                //check if user is logged in already and registered for the workshop.
                participant = (userproc.checkParticipant(workshopid, person.getLoginId()));
                if (participant.getParticipantid() > 0) {
                    int isNotValid = participant.getIsNotValidForUpdate();
                    workshopContent = (process.listWorkshopContent(workshopid));
                    int workshop_exp = workshopContent.get(0).getWorkshopExpiry();
                    int start_date_exp = workshopContent.get(0).getLessThanStartDate();
                    if ((isNotValid == 0 && workshop_exp != 1) || (isNotValid == 0 && workshop_exp == 1 && start_date_exp == 0 && participant.getStatus().equals("Registration Invalid"))) {
                        //set workshop content
                        workshopContent = (process.listWorkshopContent(workshopid));
                        //get state List
                        stateList = (process.listStates());
                        participantDetails = userproc.getParticipantDetails(workshopid, person.getLoginId());
                        String state = participantDetails.getRemoteCenter().getRc_state();
                        remotecenterList = process.listRemoteCenters(workshopid, state);
                        if ((workshopContent.get(0).getCategorycode() == 5 && workshopContent.get(0).getWithout_RC() == 0) || workshopContent.get(0).getCategorycode() == 7 || (workshopContent.get(0).getCategorycode() == 8 && workshopContent.get(0).getWithout_RC() == 0)) {
                            ArrayList<RemoteCenterCapacity> rcc = process.rccDetails1(Integer.parseInt(workshopid), participantDetails.getRemoteCenter().getRemoteCenterId());
                            setAcco_available(rcc.get(0).getAccomo_remaining());
                        } else {
                            setAcco_available(-1);
                        }
                        return Utility.SUCCESS;
                    } else {
                        return Utility.ALREADY_REGISTERED;
                    }
                } else {
                    return Utility.NOT_REGISTERED;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
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
        this.setWorkshopContent(workshopContent);
    }

    /**
     * @return the stateList
     */
    public ArrayList<State> getStateList() {
        return stateList;
    }

    /**
     * @param stateList the stateList to set
     */
    public void setStateList(ArrayList<State> stateList) {
        this.setStateList(stateList);
    }

    /**
     * @return the participant
     */
    public Participant getParticipant() {
        return participant;
    }

    /**
     * @param participant the participant to set
     */
    public void setParticipant(Participant participant) {
        this.participant = participant;
    }

    /**
     * @return the remotecenterList
     */
    public ArrayList<RemoteCenter> getRemotecenterList() {
        return remotecenterList;
    }

    /**
     * @param remotecenterList the remotecenterList to set
     */
    public void setRemotecenterList(ArrayList<RemoteCenter> remotecenterList) {
        this.remotecenterList = remotecenterList;
    }

    /**
     * @return the participantDetails
     */
    public Person getParticipantDetails() {
        return participantDetails;
    }

    /**
     * @param participantDetails the participantDetails to set
     */
    public void setParticipantDetails(Person participantDetails) {
        this.participantDetails = participantDetails;
    }

    /**
     * @return the acco_available
     */
    public int getAcco_available() {
        return acco_available;
    }

    /**
     * @param acco_available the acco_available to set
     */
    public void setAcco_available(int acco_available) {
        this.acco_available = acco_available;
    }

    /**
     * @return the facultyStatus
     */
    public int getFacultyStatus() {
        return facultyStatus;
    }

    /**
     * @param facultyStatus the facultyStatus to set
     */
    public void setFacultyStatus(int facultyStatus) {
        this.facultyStatus = facultyStatus;
    }
}
