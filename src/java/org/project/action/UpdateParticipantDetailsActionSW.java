/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.bean.Stream;
import org.project.bean.HeadTitle;
import org.project.bean.HeadDesignation;
import org.project.bean.Title;
import org.project.bean.State;
import org.project.bean.City;
import org.project.bean.RemoteCenter;
import org.project.bean.Designation;
import org.project.bean.Institute;
import org.project.bean.Qualification;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import org.apache.struts2.ServletActionContext;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;

/**
 *
 * @author dipesh
 */
public class UpdateParticipantDetailsActionSW extends ActionSupport {
     //Variable declarations
    private ArrayList<Title> titles;
    private ArrayList<Qualification> qualifications;
    private ArrayList<Designation> designations;
    private ArrayList<Stream> streams;
    private ArrayList<HeadTitle> headTitles;
    private ArrayList<HeadDesignation> headDesignations;
    private ArrayList<State> states;
    private ArrayList<City> cities;
    private ArrayList<Institute> institutes;
    private Person person;
    // variables added by Abinaya Remote Center Update /Permission Letter
    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<State> stateList;
    private ArrayList<RemoteCenter> remotecenterList;
    private Person participantDetails;
    private int acco_available;
    private int userid;
    private int facultyStatus = 0;
    
    public String execute() throws Exception {
     UtilityProcess process = new UtilityProcess();
        String email_enc = ServletActionContext.getRequest().getParameter("email");
        String wcid_enc = ServletActionContext.getRequest().getParameter("workshopid");
        SimpleStringCipher cipher = new SimpleStringCipher();
        String email = cipher.decrypt(email_enc);
        String wcid = cipher.decrypt(wcid_enc);
        int userId = process.getUserIdOfParticipant(email);
        setUserid(userId);
        UserProcess uproc = new UserProcess();  
        workshopContent = (process.listWorkshopContent(wcid));
        
        setPerson(uproc.getPersonInformation1(userId));

        // check if not a faculty for self sustained workshops
        facultyStatus = uproc.getFactulyStatus(userId);
        
         //fetching the arraylist of titles
        setTitles(process.listTitles());
        setTitles(getTitles());
        //fetching the arraylist of qualifications
        setQualifications(process.listQualifications());
        setQualifications(getQualifications());
        //fetching the arraylist of designations
        setDesignations(process.listDesignations());
        setDesignations(getDesignations());
        //fetching the arraylist of streams
        setStreams(process.listStreams());
        setStreams(getStreams());
        //fetching the arraylist of headTitles
        setHeadTitles(process.listHeadTitles());
        setHeadTitles(getHeadTitles());
        //fetching the arraylist of headDesignations
        setHeadDesignations(process.listHeadDesignations());
        setHeadDesignations(getHeadDesignations());
        //fetching the arraylist of states
        setStates(process.listStates());
        
        stateList = (process.listStates());
        participantDetails = uproc.getParticipantDetails(wcid, userId);
        setCities(process.listCity(participantDetails.getInstitute().getState().getStateId()));
         // set institute
        setInstitutes(process.listInstitute1(participantDetails.getInstitute().getCity().getCityId()));
     return SUCCESS;
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
     * @return the userid
     */
    public int getUserid() {
        return userid;
    }

    /**
     * @param userid the userid to set
     */
    public void setUserid(int userid) {
        this.userid = userid;
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
    /**
     * @return the person
     */
}
