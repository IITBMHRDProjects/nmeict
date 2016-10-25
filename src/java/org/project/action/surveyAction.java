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
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.RemoteCenterCapacity;
import org.project.bean.State;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class surveyAction extends ActionSupport {
    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<State> stateList;
    private Participant participant;
    private Participant participant1;
    private Person person;
    private ArrayList<RemoteCenterCapacity> remoterCenterCapacity;
    private int acco_available;
    
    public String execute() throws Exception{
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
           // if (person == null) {
             //   return Utility.LOGIN_FAILURE;
          //  } else {
                UtilityProcess process = new UtilityProcess();
                /**
                 * cipher for decrypting the workshopid from the url
                 */
                SimpleStringCipher cipher = new SimpleStringCipher();
                /**
                 * getting the parameter from url
                 */
               // String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
               // String workshopid = cipher.decrypt(workshopid_encrypted);
                //set workshop content
              //  setWorkshopContent(process.listWorkshopContent(workshopid));
                //get state List
                setStateList(process.listStates());

               // UserProcess userproc = new UserProcess();
               // setParticipant(new Participant());
                //check if user is logged in already and registered for the workshop.
              //  setParticipant(userproc.checkParticipant(workshopid, person.getLoginId()));
               // setParticipant1(userproc.getParticipantName(person.getLoginId()));
               // int state = 0;
              //  setRemoterCenterCapacity(process.rccDetails(Integer.parseInt(workshopid), state));
//                ArrayList<RemoteCenterCapacity> rcc = process.rccDetails1(1, 1);
//                acco_available=rcc.get(0).getAccomo_remaining();
            
        //}
     return SUCCESS;
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
     * @return the stateList
     */
    public ArrayList<State> getStateList() {
        return stateList;
    }

    /**
     * @param stateList the stateList to set
     */
    public void setStateList(ArrayList<State> stateList) {
        this.stateList = stateList;
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
     * @return the participant1
     */
    public Participant getParticipant1() {
        return participant1;
    }

    /**
     * @param participant1 the participant1 to set
     */
    public void setParticipant1(Participant participant1) {
        this.participant1 = participant1;
    }

    /**
     * @return the person
     */
    public Person getPerson() {
        return person;
    }

    /**
     * @param person the person to set
     */
    public void setPerson(Person person) {
        this.person = person;
    }

    /**
     * @return the remoterCenterCapacity
     */
    public ArrayList<RemoteCenterCapacity> getRemoterCenterCapacity() {
        return remoterCenterCapacity;
    }

    /**
     * @param remoterCenterCapacity the remoterCenterCapacity to set
     */
    public void setRemoterCenterCapacity(ArrayList<RemoteCenterCapacity> remoterCenterCapacity) {
        this.remoterCenterCapacity = remoterCenterCapacity;
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

   

    
}
