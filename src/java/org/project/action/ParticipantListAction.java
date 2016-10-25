/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.bean.RegistrationDetails;
import org.project.bean.RemoteCenter;
import org.project.bean.WorkshopContent;
import org.project.bean.Person;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.process.UtilityProcess;
import org.project.utilities.GeneratePdf;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class ParticipantListAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<Person> participantdetails;
    private ArrayList<RemoteCenter> remoteCenters;
    private ArrayList<RemoteCenter> rc_institute;
    private ArrayList<RegistrationDetails> countOfParticipants;
    private WorkshopContent content;
    private int rcid_present = 0;
    private int if_certificate_generated = 0;

    @Override
    public String execute() throws Exception {
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
        String rcid_encrypted = ServletActionContext.getRequest().getParameter("rcid");
        String rcid = cipher.decrypt(rcid_encrypted);
        String status_encrypted = ServletActionContext.getRequest().getParameter("status");
        String status = cipher.decrypt(status_encrypted);
        String state = "all";
        UtilityProcess process = new UtilityProcess();
        //fetching the arraylist of workshopContent           
        workshopContent = (process.listWorkshopContent(workshopid));
        //fetching the arraylist of participant details
        participantdetails = (process.listParticipants(workshopid, rcid, status));
        //fetching arraylist of the remotecenters registered for the particular workshop
        remoteCenters = (process.listRemoteCenters(workshopid, state));
        countOfParticipants = (process.getParticipantCount(workshopid, rcid));

        //set present rcid
        if (!rcid.equals("all")) {
            setRcid_present(Integer.parseInt(rcid));
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
            String rcid_encrypted = ServletActionContext.getRequest().getParameter("rcid");
            String rcid = cipher.decrypt(rcid_encrypted);
//        String status_encrypted = ServletActionContext.getRequest().getParameter("status");
//        String status = cipher.decrypt(status_encrypted);
            String state = "all";
            UtilityProcess process = new UtilityProcess();
            //fetching the arraylist of workshopContent           
            workshopContent = (process.listWorkshopContent(workshopid));
            //fetching the arraylist of participant details         
           // participantdetails = (process.listParticipants(workshopid, rcid, "Completed"));
            //new code added on 09-02-2016
            participantdetails = (process.listParticipantsForCertificateOnly(workshopid, rcid, "Completed"));
            //fetching arraylist of the remotecenters registered for the particular workshop
            //remoteCenters = (process.listRemoteCenters(workshopid, state));
            remoteCenters = (process.listRemoteCentersForCertificate(workshopid, state));
            countOfParticipants = (process.getParticipantCount(workshopid, rcid));
            rc_institute = process.listInstitute(workshopid);
            //set present rcid
            if (!rcid.equals("all")) {
                setRcid_present(Integer.parseInt(rcid));
            }

            String context = ServletActionContext.getServletContext().getRealPath("");
            content = workshopContent.get(0);
            GeneratePdf pdf = new GeneratePdf();
            pdf.generatePdf(context, workshopContent.get(0), participantdetails, rcid);
            if_certificate_generated = process.getCertificateAudit(workshopid, rcid);

            return Utility.SUCCESS;
        }
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
     * @return the 'remoteCenters'
     */
    public ArrayList<RemoteCenter> getRemoteCenters() {
        return remoteCenters;
    }

    /**
     * @param remoteCenters the 'remoteCenters' to set
     */
    public void setRemoteCenters(ArrayList<RemoteCenter> remotecenters) {
        this.remoteCenters = remotecenters;
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

    /**
     * @return the rc_institute
     */
    public ArrayList<RemoteCenter> getRc_institute() {
        return rc_institute;
    }

    /**
     * @param rc_institute the rc_institute to set
     */
    public void setRc_institute(ArrayList<RemoteCenter> rc_institute) {
        this.rc_institute = rc_institute;
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
}
