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
import org.project.bean.Designation;
import org.project.bean.Qualification;
import org.project.bean.Person;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.process.UtilityProcess;
import org.project.utilities.Utility;

/**
 *
 * @author mayank
 */
public class SignUpAction extends ActionSupport {
    
    private ArrayList<Title> titles;
    private ArrayList<Qualification> qualifications;
    private ArrayList<Designation> designations;
    private ArrayList<Stream> streams;
    private ArrayList<HeadTitle> headTitles;
    private ArrayList<HeadDesignation> headDesignations;
    private ArrayList<State> states;
    
    @Override
    public String execute() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            UtilityProcess process = new UtilityProcess();
            //fetching the arraylist of titles
            titles = process.listTitles();
            
            //fetching the arraylist of qualifications
            qualifications = process.listQualifications();
            
            //fetching the arraylist of designations
            designations = process.listDesignations();
            
            //fetching the arraylist of streams
            streams = process.listStreams();
            
            //fetching the arraylist of headTitles
            headTitles = process.listHeadTitles();
            
            //fetching the arraylist of headDesignations
            headDesignations = process.listHeadDesignations();
            
            //fetching the arraylist of states
            states = process.listStates();
            
            
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
}
