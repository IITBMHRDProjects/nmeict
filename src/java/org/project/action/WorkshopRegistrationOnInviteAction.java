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
import org.project.bean.City;
import org.project.bean.Designation;
import org.project.bean.HeadDesignation;
import org.project.bean.HeadTitle;
import org.project.bean.Institute;
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.Qualification;
import org.project.bean.RemoteCenter;
import org.project.bean.State;
import org.project.bean.Stream;
import org.project.bean.Title;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya This class is for registering participant on invite
 */
public class WorkshopRegistrationOnInviteAction extends ActionSupport {

    //Variable declarations
    private ArrayList<Title> titles;
    private ArrayList<Qualification> qualifications;
    private ArrayList<Designation> designations;
    private ArrayList<Stream> streams;
    private ArrayList<HeadTitle> headTitles;
    private ArrayList<HeadDesignation> headDesignations;
    private ArrayList<State> states;
    private ArrayList<State> stateList;
    private ArrayList<City> cities;
    private ArrayList<Institute> institutes;
    private Person person;
    private boolean photo_exist;
    private ArrayList<City> personcities;
    private ArrayList<WorkshopContent> workshopContent;
    private Participant participant;
    private int notValidParticipant = 1;
    private ArrayList<RemoteCenter> rc_static;
    private int isNewUser = 0;
    private int notInLogin = 0;
    private RemoteCenter rcid;
    private int idInterface = 0;
    private String if_id_exist_1 = "";

    @Override
    public String execute() {

        try {
            // get the ID.
            String idInterface1 = ServletActionContext.getRequest().getParameter("id");
            SimpleStringCipher cipher = new SimpleStringCipher();
//            // decrypt the id
            String idInterface = cipher.decrypt(idInterface1);
            setIdInterface(Integer.parseInt(idInterface));
            UserProcess uproc = new UserProcess();
            UtilityProcess process = new UtilityProcess();

            // check if exist in context table
            String[] result = uproc.doesIdExist_PrivateWorkshop(idInterface);
            String if_id_exist = result[0];
//            System.out.println("if exist .. " + if_id_exist);
            // check if exist in login
            if (if_id_exist.equals("notExist")) {
                // does not exist
                return Utility.ERROR;
            } else {
                participant = new Participant();
                participant.setIsAlreadyRegistered(0);
                setParticipant(participant);
                String workshopid = result[1];
//                System.out.println(workshopid);
                setWorkshopContent(process.listWorkshopContent(workshopid));
                setStateList(process.listStates());
                // get the remote center from partuserdata table
                setRcid(process.getRemoteCenterOfUser(idInterface));
                setRc_static(process.listRemoteCenters(workshopid, rcid.getRc_state()));

                if (if_id_exist.equals("exist")) {
                    setIf_id_exist_1("exist");
                    // exist but not in context
                    // show page with password creation with data from interface table
                    person = uproc.getPartUserData(idInterface);
                    isNewUser = 1;
                    titles = process.listTitles();
                    setTitles(titles);
                    //fetching the arraylist of qualifications
                    qualifications = process.listQualifications();
                    setQualifications(qualifications);
                    //fetching the arraylist of designations
                    designations = process.listDesignations();
                    setDesignations(designations);
                    //fetching the arraylist of streams
                    streams = process.listStreams();
                    setStreams(streams);
                    //fetching the arraylist of headTitles
                    headTitles = process.listHeadTitles();
                    setHeadTitles(headTitles);
                    //fetching the arraylist of headDesignations
                    headDesignations = process.listHeadDesignations();
                    setHeadDesignations(headDesignations);
                    //fetching the arraylist of states
                    states = process.listStates();
                    cities = process.listCity(person.getInstitute().getState().getStateId());
                    //new added code for person city
                    // personcities=process.listCity(person.getStateId());
//                    personcities = process.listPerCity(person.getStateId(), userId);
                    //fetching the arraylist of states
                    // institutes = process.listInstitute(person.getInstitute().getCity().getCityId());
                    institutes = process.listInstitute(person.getInstitute().getCity().getCityId());


                } else {
                    int userId = Integer.parseInt(if_id_exist);
                    setIf_id_exist_1(if_id_exist);
                    // exist in context, check if available in login table.
                    boolean if_exist_inLogin = uproc.isUsernameAvailable1(if_id_exist);
                    if (if_exist_inLogin) {
                        // check for participant entry for the specified workshop and open workshop registration page.
                        // show page without creation with filled data

                        person = uproc.getPersonInformation(userId);
                        participant = uproc.checkParticipant(workshopid, Integer.parseInt(if_id_exist));


                    } else {
                        // open the sign up page with minimal details for registration
                        // show password creation
                        person = uproc.getPartUserData(idInterface);
                        notInLogin = 1;
                    }
//                    UtilityProcess process = new UtilityProcess();
                    //fetching the arraylist of titles
                    titles = process.listTitles();
                    setTitles(titles);
                    //fetching the arraylist of qualifications
                    qualifications = process.listQualifications();
                    setQualifications(qualifications);
                    //fetching the arraylist of designations
                    designations = process.listDesignations();
                    setDesignations(designations);
                    //fetching the arraylist of streams
                    streams = process.listStreams();
                    setStreams(streams);
                    //fetching the arraylist of headTitles
                    headTitles = process.listHeadTitles();
                    setHeadTitles(headTitles);
                    //fetching the arraylist of headDesignations
                    headDesignations = process.listHeadDesignations();
                    setHeadDesignations(headDesignations);
                    //fetching the arraylist of states
                    states = process.listStates();
                    //fetching the arraylist of states
                    cities = process.listCity(person.getInstitute().getState().getStateId());
                    //new added code for person city
                    // personcities=process.listCity(person.getStateId());
                    personcities = process.listPerCity(person.getStateId(), userId);
                    //fetching the arraylist of states
                    // institutes = process.listInstitute(person.getInstitute().getCity().getCityId());
                    institutes = process.listPInstitute(person.getInstitute().getCity().getCityId(), userId);
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    String old_image = "";
                    if (person.getImage() == null || person.getImage() == "") {
                        old_image = "false";
                    }
                    if (old_image.equals("false")) {
                        photo_exist = false;
                    } else {
                        boolean endswith = person.getImage().endsWith(".jpg");
                        if (endswith == true) {
                        } else {
                            person.setImage(person.getImage() + ".jpg");
                        }
                        /* File file = new File(context + File.separator + "Photo/" + person.getImage());
                         if (file.exists()) {
                         // photo_exist = true;
                         } else {
                         // photo_exist = false;
                         }*/
                        photo_exist = true;
                    }
                    person.setLoginId(Integer.parseInt(if_id_exist));
                    return Utility.SUCCESS;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    /**
     * @return the titles
     */
    public ArrayList<Title> getTitles() {
        return titles;
    }

    /**
     * @param titles the titles to set
     */
    public void setTitles(ArrayList<Title> titles) {
        this.titles = titles;
    }

    /**
     * @return the qualifications
     */
    public ArrayList<Qualification> getQualifications() {
        return qualifications;
    }

    /**
     * @param qualifications the qualifications to set
     */
    public void setQualifications(ArrayList<Qualification> qualifications) {
        this.qualifications = qualifications;
    }

    /**
     * @return the designations
     */
    public ArrayList<Designation> getDesignations() {
        return designations;
    }

    /**
     * @param designations the designations to set
     */
    public void setDesignations(ArrayList<Designation> designations) {
        this.designations = designations;
    }

    /**
     * @return the streams
     */
    public ArrayList<Stream> getStreams() {
        return streams;
    }

    /**
     * @param streams the streams to set
     */
    public void setStreams(ArrayList<Stream> streams) {
        this.streams = streams;
    }

    /**
     * @return the headTitles
     */
    public ArrayList<HeadTitle> getHeadTitles() {
        return headTitles;
    }

    /**
     * @param headTitles the headTitles to set
     */
    public void setHeadTitles(ArrayList<HeadTitle> headTitles) {
        this.headTitles = headTitles;
    }

    /**
     * @return the headDesignations
     */
    public ArrayList<HeadDesignation> getHeadDesignations() {
        return headDesignations;
    }

    /**
     * @param headDesignations the headDesignations to set
     */
    public void setHeadDesignations(ArrayList<HeadDesignation> headDesignations) {
        this.headDesignations = headDesignations;
    }

    /**
     * @return the states
     */
    public ArrayList<State> getStates() {
        return states;
    }

    /**
     * @param states the states to set
     */
    public void setStates(ArrayList<State> states) {
        this.states = states;
    }

    /**
     * @return the cities
     */
    public ArrayList<City> getCities() {
        return cities;
    }

    /**
     * @param cities the cities to set
     */
    public void setCities(ArrayList<City> cities) {
        this.cities = cities;
    }

    /**
     * @return the institutes
     */
    public ArrayList<Institute> getInstitutes() {
        return institutes;
    }

    /**
     * @param institutes the institutes to set
     */
    public void setInstitutes(ArrayList<Institute> institutes) {
        this.institutes = institutes;
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
     * @return the photo_exist
     */
    public boolean isPhoto_exist() {
        return photo_exist;
    }

    /**
     * @param photo_exist the photo_exist to set
     */
    public void setPhoto_exist(boolean photo_exist) {
        this.photo_exist = photo_exist;
    }

    /**
     * @return the personcities
     */
    public ArrayList<City> getPersoncities() {
        return personcities;
    }

    /**
     * @param personcities the personcities to set
     */
    public void setPersoncities(ArrayList<City> personcities) {
        this.personcities = personcities;
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
     * @return the isNewUser
     */
    public int getIsNewUser() {
        return isNewUser;
    }

    /**
     * @param isNewUser the isNewUser to set
     */
    public void setIsNewUser(int isNewUser) {
        this.isNewUser = isNewUser;
    }

    /**
     * @return the notInLogin
     */
    public int getNotInLogin() {
        return notInLogin;
    }

    /**
     * @param notInLogin the notInLogin to set
     */
    public void setNotInLogin(int notInLogin) {
        this.notInLogin = notInLogin;
    }

    /**
     * @return the rcid
     */
    public RemoteCenter getRcid() {
        return rcid;
    }

    /**
     * @param rcid the rcid to set
     */
    public void setRcid(RemoteCenter rcid) {
        this.rcid = rcid;
    }

    /**
     * @return the idInterface
     */
    public int getIdInterface() {
        return idInterface;
    }

    /**
     * @param idInterface the idInterface to set
     */
    public void setIdInterface(int idInterface) {
        this.idInterface = idInterface;
    }

    /**
     * @return the if_id_exist_1
     */
    public String getIf_id_exist_1() {
        return if_id_exist_1;
    }

    /**
     * @param if_id_exist_1 the if_id_exist_1 to set
     */
    public void setIf_id_exist_1(String if_id_exist_1) {
        this.if_id_exist_1 = if_id_exist_1;
    }
}
