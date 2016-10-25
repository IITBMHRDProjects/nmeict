/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import org.apache.struts2.ServletActionContext;
import org.project.bean.RemoteCenterCapacity;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class DisplayRCCActionForUser extends ActionSupport {

    private ArrayList<RemoteCenterCapacity> rccDetails;
    private ArrayList<WorkshopContent> workshopContent;

    @Override
    public String execute() throws Exception {
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
        UtilityProcess process = new UtilityProcess();
        rccDetails = process.rccDetails1(Integer.parseInt(workshopid), Integer.parseInt(rcid));
        workshopContent = process.listWorkshopContent(workshopid);
        return Utility.SUCCESS;

    }

    /**
     * @return the rccDetails
     */
    public ArrayList<RemoteCenterCapacity> getRccDetails() {
        return rccDetails;
    }

    /**
     * @param rccDetails the rccDetails to set
     */
    public void setRccDetails(ArrayList<RemoteCenterCapacity> rccDetails) {
        this.rccDetails = rccDetails;
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
}
