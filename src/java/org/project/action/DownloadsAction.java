/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Downloads;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class DownloadsAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContents;
    private ArrayList<Downloads> downloads;

    public String execute() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        SimpleStringCipher cipher = new SimpleStringCipher();
        /**
         * getting the parameter from url
         */
        String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
        String workshopid = cipher.decrypt(workshopid_encrypted);

        String update_enc = ServletActionContext.getRequest().getParameter("update");
        UtilityProcess process = new UtilityProcess();
        //fetching the arraylist of announcements
        setWorkshopContents((process.listWorkshopContent(workshopid)));
        setWorkshopContents(getWorkshopContents());
        setDownloads(process.listDownloads(workshopid));        
        return Utility.SUCCESS;
    }

    /**
     * @return the workshopContents
     */
    public ArrayList<WorkshopContent> getWorkshopContents() {
        return workshopContents;
    }

    /**
     * @param workshopContents the workshopContents to set
     */
    public void setWorkshopContents(ArrayList<WorkshopContent> workshopContents) {
        this.workshopContents = workshopContents;
    }

    /**
     * @return the downloads
     */
    public ArrayList<Downloads> getDownloads() {
        return downloads;
    }

    /**
     * @param downloads the downloads to set
     */
    public void setDownloads(ArrayList<Downloads> downloads) {
        this.downloads = downloads;
    }
}
