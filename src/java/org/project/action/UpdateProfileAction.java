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
import org.project.bean.Designation;
import org.project.bean.Institute;
import org.project.bean.Qualification;
import org.project.bean.Person;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.Utility;

/**
 *
 * @author mayank
 */
public class UpdateProfileAction extends ActionSupport {

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
    private boolean photo_exist;
    private ArrayList<City> personcities;

    @Override
    public String execute() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        int userId = person.getLoginId();

        UserProcess uproc = new UserProcess();
        //fetching full information of the person for update
        person = uproc.getPersonInformation(userId);

        UtilityProcess process = new UtilityProcess();
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
        person.setLoginId(userId);
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
}
