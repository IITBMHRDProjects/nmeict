/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.RemoteCenterCapacity;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;

/**
 *
 * @author asl
 */
public class RCCDetailsAction extends ActionSupport {

    private ArrayList<RemoteCenterCapacity> remoterCenterCapacity;
    private RemoteCenterCapacity rcc;
    private ArrayList<WorkshopContent> workshopContent;
    private int h_workshopid;
    private int h_rcid;
    private int state = 0;

    public String execute() throws Exception {
        SimpleStringCipher cipher=new SimpleStringCipher();
        String workshopid_enc = ServletActionContext.getRequest().getParameter("workshopid");
        String state_enc=ServletActionContext.getRequest().getParameter("state");
//        if(!state_enc.equals("0")){
//             state_enc=cipher.decrypt(state_enc);
//        }
        int workshopid=Integer.parseInt(cipher.decrypt(workshopid_enc));
        int state=Integer.parseInt(state_enc);
        UtilityProcess process = new UtilityProcess();

        if (workshopid != 0 || workshopid > 0) {
            remoterCenterCapacity = process.rccDetails(workshopid, state);
            workshopContent=process.listWorkshopContent(Integer.toString(workshopid)); //Added by Abinaya for displaying the workshop content in the user interface.
        }

        setRemoterCenterCapacity(remoterCenterCapacity);
        return SUCCESS;
    }
    
    /**
     * Function Not used. Separate function for update is used in UpdateRCCAction
     * Comment added by Abinaya.
     */
    //method for updating available seats, accomodation details of reomote center capacity
    public String updateCapacity() throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        String avaseats1 = getRcc().getS_available_seats();
        String avaccomo1 = getRcc().getS_available_accomo();
        int avaseats = 0, avaccomo = 0;
        int flag = 0;
        try {
            avaseats = Integer.parseInt(avaseats1);
            avaccomo = Integer.parseInt(avaccomo1);
            flag = 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        // int avaseats = getRcc().getAvailable_seats();
        // int avaccomo = getRcc().getAvailable_accomo();
        UtilityProcess process = new UtilityProcess();
        UserProcess user_process = new UserProcess();

        if (h_workshopid == 0 || h_rcid == 0) {
            session.setAttribute("update_result", "<font color='red'>No data is updated.</font>");
        } else if (h_workshopid != 0 || h_rcid != 0) {
            /*   if (flag == 1) {
             int update_res = user_process.updateRemoteCenterCapacity(h_workshopid, h_rcid, avaseats, avaccomo);
             if (update_res == 1) {
             session.setAttribute("update_result", "Successfully Updated the data.");
             } else if (update_res < 0) {
             session.setAttribute("update_result", "No data is updated.");
             }
             } else if(flag == 0){
             session.setAttribute("update_result", "<font color='red'>update failed .. invalid number entered.</font>");
             }*/
        }
        //fetching the arraylist of workshopContent  
        // workshopContent = (process.listMainWorkshopContent());
        setWorkshopContent(workshopContent);
        return SUCCESS;
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

    /**
     * @return the rcc
     */
    public RemoteCenterCapacity getRcc() {
        return rcc;
    }

    /**
     * @param rcc the rcc to set
     */
    public void setRcc(RemoteCenterCapacity rcc) {
        this.rcc = rcc;
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
     * @return the h_workshopid
     */
    public int getH_workshopid() {
        return h_workshopid;
    }

    /**
     * @param h_workshopid the h_workshopid to set
     */
    public void setH_workshopid(int h_workshopid) {
        this.h_workshopid = h_workshopid;
    }

    /**
     * @return the h_rcid
     */
    public int getH_rcid() {
        return h_rcid;
    }

    /**
     * @param h_rcid the h_rcid to set
     */
    public void setH_rcid(int h_rcid) {
        this.h_rcid = h_rcid;
    }
    /**
     * @return the capacity
     */
}
