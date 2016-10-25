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
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class updatePermissionLetterAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContent;
    private String participantid;
    private String workshopid;

    public String execute() throws Exception {
        SimpleStringCipher cipher = new SimpleStringCipher();
        UtilityProcess process = new UtilityProcess();
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        /**
         * getting request param(participantid,workshopid) and storing in
         * p_id,w_id variable
         */
        String p_d = ServletActionContext.getRequest().getParameter("pid");
        String w_id = ServletActionContext.getRequest().getParameter("workshopid");
        /**
         * decrypting participantid,workshopid and storing in
         * decrypt_pid,decrypt_wid param
         */
        String decrypt_pid = (String) cipher.decrypt(p_d);
        String decrypt_wid = (String) cipher.decrypt(w_id);
        String status = "";
        int participantid = 0, workshopid = 0;
        try {
            /**
             * converting String into integer
             */
            participantid = Integer.parseInt(decrypt_pid);
            workshopid = Integer.parseInt(decrypt_wid);
        } catch (Exception e) {
            e.printStackTrace();
        }
        /**
         * checking user is login or not if not login then redirected to login
         * page
         */
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            /**
             * checking participantid is getting or not if participant id
             * greater than 0 then getting the participantid
             *
             */
            if (participantid > 0) {
                /**
                 * getting status of participant by calling
                 * getParticipantStatus(participantid) method
                 *
                 */
                status = process.getParticipantStatus(participantid);
                /**
                 * if status is match with Request Approved, Confirmed,
                 * Cancelled then they cant access to update the permission
                 * letter only allowed who are Request Registered, Invalid.
                 *
                 */
                if (status.equals("Request Approved") || status.equals("Confirmed") || status.equals("Cancelled")) {
                    /**
                     * setting value to session
                     */
                    session.setAttribute("Statusforletter", "Not Applicable");
                    //  return "failure";
                } else {
                    session.setAttribute("Statusforletter", "Applicable");
                    /**
                     * getting workshopContent for particular workshop
                     */
                    workshopContent = (process.listWorkshopContent(decrypt_wid));
                    /**
                     * setting the decrypt pid,wid
                     */
                    setParticipantid(decrypt_pid);
                    setWorkshopid(decrypt_wid);
                }
            }
        }
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
     * @return the participantid
     */
    public String getParticipantid() {
        return participantid;
    }

    /**
     * @param participantid the participantid to set
     */
    public void setParticipantid(String participantid) {
        this.participantid = participantid;
    }

    /**
     * @return the workshopid
     */
    public String getWorkshopid() {
        return workshopid;
    }

    /**
     * @param workshopid the workshopid to set
     */
    public void setWorkshopid(String workshopid) {
        this.workshopid = workshopid;
    }
}
