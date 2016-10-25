/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
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
public class WorkshopRegistrationAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<State> stateList;
    private Participant participant;
    private Participant participant1;
    private Person person;
    private ArrayList<RemoteCenterCapacity> remoterCenterCapacity;
    private int acco_available;
    private ArrayList<RemoteCenter> rc_static;
    private int ifusernameupdated = 1;
    private int notValidParticipant = 1;
    // for RCC and WSC
    private int ifWSC = 0;
    private int ifRCC = 0;
    private int ifRCC1 = 0;
    private int facultyStatus = 0;

    @Override
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

                //set workshop content
                workshopContent = (process.listWorkshopContent(workshopid));

                // add check for RCC WSC
                setIfWSC(process.ifExistInRelevantCoordinatorWorkshop(workshopContent.get(0).getWorkshopid(), person.getLoginId()));
//                // check if remote center coordinator of this workshop
//                setIfRCC(process.ifExistInRelevantRCC(workshopContent.get(0).getRespectiveCoWorkshopid(), person.getLoginName()));
//                // check if the person is RCC - can't register for any workshop
                setIfRCC1(process.ifRCC(person.getLoginName()));
//                setIfWSC(0);
                setIfRCC(0);
//                setIfRCC1(0);

                //get state List
                stateList = (process.listStates());
                String context = ServletActionContext.getServletContext().getRealPath("");
                String filepath = context + File.separator + "UserImages/photo_" + person.getLoginId() + ".jpg";
                UserProcess userproc = new UserProcess();
//                setIfusernameupdated(userproc.checkIfUsernameUpdated(person.getLoginId(), filepath));
                setIfusernameupdated(1);
                /**
                 * code added to check if participant filled username and year
                 * of birth in the database for IITBx Type workshops
                 */
                if (workshopContent.get(0).getCategorycode() == 4 && workshopContent.get(0).getRespectiveCoWorkshopid() > 0) {
                    //    notValidParticipant = userproc.checkIfNotAValidParticipant(person.getLoginId(), workshopid);
                    notValidParticipant = 1;
                }
                participant = new Participant();
                //check if user is logged in already and registered for the workshop.
                participant = (userproc.checkParticipant(workshopid, person.getLoginId()));
                facultyStatus = userproc.getFactulyStatus(person.getLoginId());
                participant1 = (userproc.getParticipantName(person.getLoginId()));
                int state = 0;
//                remoterCenterCapacity = process.rccDetails(Integer.parseInt(workshopid), state);
//                ArrayList<RemoteCenterCapacity> rcc = process.rccDetails1(1, 1);
//                acco_available=rcc.get(0).getAccomo_remaining();
                setRc_static(process.listRemoteCenters(workshopid, "1"));
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
     * @return the remoterCenterCapacity
     */
    public ArrayList<RemoteCenterCapacity> getRemoterCenterCapacity() {
        return remoterCenterCapacity;
    }

    /**
     * @param rcc the remoterCenterCapacity to set
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

    /**
     * @return the rc_static
     */
    public ArrayList<RemoteCenter> getRc_static() {
        return rc_static;
    }

    /**
     * @param rc_static the rc_static to set
     */
    public void setRc_static(ArrayList<RemoteCenter> rc_static) {
        this.rc_static = rc_static;
    }

    /**
     * @return the ifusernameupdated
     */
    public int getIfusernameupdated() {
        return ifusernameupdated;
    }

    /**
     * @param ifusernameupdated the ifusernameupdated to set
     */
    public void setIfusernameupdated(int ifusernameupdated) {
        this.ifusernameupdated = ifusernameupdated;
    }

    /**
     * @return the notValidParticipant
     */
    public int getNotValidParticipant() {
        return notValidParticipant;
    }

    /**
     * @param notValidParticipant the notValidParticipant to set
     */
    public void setNotValidParticipant(int notValidParticipant) {
        this.notValidParticipant = notValidParticipant;
    }

    /**
     * @return the ifWSC
     */
    public int getIfWSC() {
        return ifWSC;
    }

    /**
     * @param ifWSC the ifWSC to set
     */
    public void setIfWSC(int ifWSC) {
        this.ifWSC = ifWSC;
    }

    /**
     * @return the ifRCC
     */
    public int getIfRCC() {
        return ifRCC;
    }

    /**
     * @param ifRCC the ifRCC to set
     */
    public void setIfRCC(int ifRCC) {
        this.ifRCC = ifRCC;
    }

    /**
     * @return the ifRCC1
     */
    public int getIfRCC1() {
        return ifRCC1;
    }

    /**
     * @param ifRCC1 the ifRCC1 to set
     */
    public void setIfRCC1(int ifRCC1) {
        this.ifRCC1 = ifRCC1;
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
