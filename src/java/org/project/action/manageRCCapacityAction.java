/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
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
 * @author asl
 */
public class manageRCCapacityAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<WorkshopContent> workshopContentAll;
    private ArrayList<RemoteCenterCapacity> remoterCenterCapacity;

    public String execute() throws Exception {
        SimpleStringCipher cipher = new SimpleStringCipher();
        String workshopid_enc = ServletActionContext.getRequest().getParameter("workshopid");
        String state_enc = ServletActionContext.getRequest().getParameter("state");
        UtilityProcess process = new UtilityProcess();
        //fetching the arraylist of workshopContent  
        workshopContentAll = (process.listMainWorkshopId());
        setWorkshopContentAll(workshopContentAll);
        if (!workshopid_enc.equals("none")) {
            int workshopid = Integer.parseInt(cipher.decrypt(workshopid_enc));
            int state = Integer.parseInt(state_enc);
            if (workshopid != 0 || workshopid > 0) {
                remoterCenterCapacity = process.rccDetails_admin(workshopid, state);
                workshopContent = process.listWorkshopContent(Integer.toString(workshopid)); //Added by Abinaya for displaying the workshop content in the user interface.
            }
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
     * @return the workshopContentAll
     */
    public ArrayList<WorkshopContent> getWorkshopContentAll() {
        return workshopContentAll;
    }

    /**
     * @param workshopContentAll the workshopContentAll to set
     */
    public void setWorkshopContentAll(ArrayList<WorkshopContent> workshopContentAll) {
        this.workshopContentAll = workshopContentAll;
    }

    /**
     * @return the remoterCenterCapacity
     */
    public ArrayList<RemoteCenterCapacity> getRemoterCenterCapacity() {
        return remoterCenterCapacity;
    }

    /**
     * @param remoterCenterCapacity the remoterCenterCapacity to set
     */
    public void setRemoterCenterCapacity(ArrayList<RemoteCenterCapacity> remoterCenterCapacity) {
        this.remoterCenterCapacity = remoterCenterCapacity;
    }
}
