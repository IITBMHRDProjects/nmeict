/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.City;
import org.project.bean.Designation;
import org.project.bean.HeadDesignation;
import org.project.bean.HeadTitle;
import org.project.bean.Institute;
import org.project.bean.Person;
import org.project.bean.Qualification;
import org.project.bean.State;
import org.project.bean.Stream;
import org.project.bean.Title;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.EmailUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class CreatePasswordAction extends ActionSupport {

    private String tmpl;
    private String password;
    private String cpassword;
    private String tmpl2;
    private Person person;
    private ArrayList<Title> titles;
    private ArrayList<Qualification> qualifications;
    private ArrayList<Designation> designations;
    private ArrayList<Stream> streams;
    private ArrayList<HeadTitle> headTitles;
    private ArrayList<HeadDesignation> headDesignations;
    private ArrayList<State> states;
    private ArrayList<City> cities;
    private ArrayList<Institute> institutes;
    private HttpSession session;
    private ArrayList<City> personcities;

    public String execute() {
        try {
            session = (HttpSession) ServletActionContext.getRequest().getSession();
            UserProcess uproc = new UserProcess();
            if ((tmpl.equals("") || tmpl.equals(null)) || (tmpl2.equals("") || tmpl2.equals(null))) {
                return Utility.ERROR;
            }
            String email = SimpleStringCipher.decrypt(getTmpl());
            String loginid = SimpleStringCipher.decrypt(getTmpl2());
            Person person = uproc.getPerson(email);
            boolean isExist = uproc.isLoginExist(email);
            if (isExist) {
                session.setAttribute("result", "false");
                return "UserExist";
            } else if (!isExist) {
                int login_id = Integer.parseInt(loginid);
                person = new Person();
                person.setLoginId(login_id);
                person.setLoginName(email);
                person.setPassword(password);
                person.setRoleId(1);
                int passUpdated = uproc.insertExistingUserDataInLogin(person);
                if (passUpdated > 0) {
                    setPersonDetails(login_id);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public void setPersonDetails(int userId) throws Exception {
        UserProcess uproc = new UserProcess();
        //fetching full information of the person for update
        person = uproc.getPersonInformation(userId);
        UtilityProcess process = new UtilityProcess();
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
        //fetching the arraylist of states
        setCities(process.listCity(person.getInstitute().getState().getStateId()));
            //fetching the arraylist of states
        //new added code for person city
        // personcities=process.listCity(person.getStateId()); 
        personcities = process.listPerCity(person.getStateId(), userId);
        setInstitutes(process.listPersonInstitute(person.getInstitute().getCity().getCityId(), person.getInstitute().getInstituteId()));
    }

    /**
     * @return the tmpl
     */
    public String getTmpl() {
        return tmpl;
    }

    /**
     * @param tmpl the tmpl to set
     */
    public void setTmpl(String tmpl) {
        this.tmpl = tmpl;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the cpassword
     */
    public String getCpassword() {
        return cpassword;
    }

    /**
     * @param cpassword the cpassword to set
     */
    public void setCpassword(String cpassword) {
        this.cpassword = cpassword;
    }

    /**
     * @return the tmpl2
     */
    public String getTmpl2() {
        return tmpl2;
    }

    /**
     * @param tmpl2 the tmpl2 to set
     */
    public void setTmpl2(String tmpl2) {
        this.tmpl2 = tmpl2;
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
