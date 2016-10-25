/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.bean.RegistrationDetails;
import org.project.bean.State;
import org.project.bean.RemoteCenter;
import org.project.bean.WorkshopContent;
import org.project.bean.Person;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.GeneratePdf;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class ParticipantListActionStateWise extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<Person> participantdetails;
    private ArrayList<State> state_list;
    private ArrayList<RemoteCenter> institute_list;
//    private ArrayList<RemoteCenter> rc_institute;
    private ArrayList<RegistrationDetails> countOfParticipants;
    private WorkshopContent content;
    private int state_present = 0;
    private int if_certificate_generated = 0;

    @Override
     public String execute() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        /**
         * cipher for decrypting the 'workshopid', 'state', status from the
         * 'url'
         */
        SimpleStringCipher cipher = new SimpleStringCipher();
        /**
         * getting the parameters from 'url'
         */
        String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
        String workshopid = cipher.decrypt(workshopid_encrypted);
        String state_encrypted = ServletActionContext.getRequest().getParameter("state");
        String state = cipher.decrypt(state_encrypted);
        String status_encrypted = ServletActionContext.getRequest().getParameter("status");
        String status = cipher.decrypt(status_encrypted);
        UtilityProcess process = new UtilityProcess();
        UserProcess uproc = new UserProcess();
        //fetching the arraylist of workshopContent           
        workshopContent = (process.listWorkshopContent(workshopid));
        //fetching the arraylist of participant details
        participantdetails = (process.listParticipantsStateWise1(workshopid, state, status));
        //fetching arraylist of the remotecenters registered for the particular workshop

        countOfParticipants = (process.getParticipantCountStateWise1(workshopid, state));

        setState_list(process.listStates());        
        //set present rcid
        if (!state.equals("all")) {
            setState_present(Integer.parseInt(state));
            int all = countOfParticipants.get(0).getTotal_rc_participants();
            countOfParticipants.get(0).setTotalParticipants(all);
        }
        return Utility.SUCCESS;
    }

    public String getConfirmedParticipants() throws Exception {
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
            String ins_encrypted = ServletActionContext.getRequest().getParameter("ins");
            String institute = cipher.decrypt(ins_encrypted);
//        String status_encrypted = ServletActionContext.getRequest().getParameter("status");
//        String status = cipher.decrypt(status_encrypted);
            UtilityProcess process = new UtilityProcess();
            //fetching the arraylist of workshopContent           
            workshopContent = (process.listWorkshopContent(workshopid));
            //fetching the arraylist of participant details         
            // participantdetails = (process.listParticipants(workshopid, rcid, "Completed"));
            //new code added on 09-02-2016
            participantdetails = (process.listParticipantsForCertificateOnlyStateWise(workshopid, institute, "Completed"));

//            System.out.println("size of list : " + participantdetails.size());
//fetching arraylist of the remotecenters registered for the particular workshop
            //remoteCenters = (process.listRemoteCenters(workshopid, state));
//            remoteCenters = (process.listRemoteCentersForCertificate(workshopid, state));
            countOfParticipants = (process.getParticipantCountStateWise(workshopid, institute));
//            setState_list(process.listStates());

            setInstitute_list(process.listInstitutesForCertificate(workshopid));

            //set present rcid
            if (!institute.equals("all")) {
                setState_present(Integer.parseInt(institute));
            }

            String context = ServletActionContext.getServletContext().getRealPath("");
            content = workshopContent.get(0);
            GeneratePdf pdf = new GeneratePdf();
            pdf.generatePdfStateWise(context, workshopContent.get(0), participantdetails, institute);
            if_certificate_generated = process.getCertificateAuditStateWise(workshopid, institute);

            return Utility.SUCCESS;
        }
    }
    
    public String getAllStateWiseParticipants() throws Exception{
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        /**
         * cipher for decrypting the 'workshopid', 'rcid', status from the 'url'
         */
        SimpleStringCipher cipher = new SimpleStringCipher();
        /**
         * getting the parameters from 'url'
         */
        String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
        String workshopid = cipher.decrypt(workshopid_encrypted);
        String state_encrypted = ServletActionContext.getRequest().getParameter("state");
        String state = cipher.decrypt(state_encrypted);
        String status_encrypted = ServletActionContext.getRequest().getParameter("status");
        String status = cipher.decrypt(status_encrypted);
        UtilityProcess process = new UtilityProcess();
        //UserProcess uproc = new UserProcess();
        //fetching the arraylist of workshopContent           
        workshopContent = (process.listWorkshopContent(workshopid));
        //fetching the arraylist of participant details
        participantdetails = (process.listParticipantsStateWise1(workshopid, state, status));
        //fetching arraylist of the remotecenters registered for the particular workshop

        countOfParticipants = (process.getParticipantCountStateWise1(workshopid, state));
        
        setState_list(process.listStates());
        //set present rcid
        if (!state.equals("all")) {
            setState_present(Integer.parseInt(state));
            int all = countOfParticipants.get(0).getTotal_rc_participants();
            countOfParticipants.get(0).setTotalParticipants(all);
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
        this.workshopContent = workshopContent;
    }

    /**
     * @return the 'participantdetails'
     */
    public ArrayList<Person> getParticipantdetails() {
        return participantdetails;
    }

    /**
     * @param participantdetails the 'participantdetails' to set
     */
    public void setParticipantdetails(ArrayList<Person> participantdetails) {
        this.participantdetails = participantdetails;
    }

    /**
     * @return the countOfParticipants
     */
    public ArrayList<RegistrationDetails> getCountOfParticipants() {
        return countOfParticipants;
    }

    /**
     * @param countOfParticipants the countOfParticipants to set
     */
    public void setCountOfParticipants(ArrayList<RegistrationDetails> countOfParticipants) {
        this.countOfParticipants = countOfParticipants;
    }

    /**
     * @return the content
     */
    public WorkshopContent getContent() {
        return content;
    }

    /**
     * @param content the content to set
     */
    public void setContent(WorkshopContent content) {
        this.content = content;
    }

    /**
     * @return the if_certificate_generated
     */
    public int getIf_certificate_generated() {
        return if_certificate_generated;
    }

    /**
     * @param if_certificate_generated the if_certificate_generated to set
     */
    public void setIf_certificate_generated(int if_certificate_generated) {
        this.if_certificate_generated = if_certificate_generated;
    }

    /**
     * @return the state_present
     */
    public int getState_present() {
        return state_present;
    }

    /**
     * @param state_present the state_present to set
     */
    public void setState_present(int state_present) {
        this.state_present = state_present;
    }

    /**
     * @return the state_list
     */
    public ArrayList<State> getState_list() {
        return state_list;
    }

    /**
     * @param state_list the state_list to set
     */
    public void setState_list(ArrayList<State> state_list) {
        this.state_list = state_list;
    }
    /**
     * @return the institute_list
     */
    public ArrayList<RemoteCenter> getInstitute_list() {
        return institute_list;
    }

    /**
     * @param institute_list the institute_list to set
     */
    public void setInstitute_list(ArrayList<RemoteCenter> institute_list) {
        this.institute_list = institute_list;
    }

}
