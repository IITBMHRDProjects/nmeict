/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.AttendanceSheet;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author dipesh
 */
public class ViewUploadedAttendanceByWSCAction extends ActionSupport {

    private ArrayList<AttendanceSheet> details;
    private ArrayList<WorkshopContent> workshopContent;

    public String viewUploadedAttendanceToWSC() {
        try {
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            if (person == null) {
                return Utility.LOGIN_FAILURE;
            } else {
                if (person != null) {
                    String rc_enc = ServletActionContext.getRequest().getParameter("rcid");
                    String wcid_enc = ServletActionContext.getRequest().getParameter("workshopid");
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String wid_dec = cipher.decrypt(wcid_enc);
                    String rcid_dec = cipher.decrypt(rc_enc);
                    UtilityProcess process = new UtilityProcess();
                    details = process.getUploadAttendaceByRC(wid_dec, rcid_dec);
                    workshopContent = (process.listWorkshopContent(wid_dec));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    /**
     * @return the details
     */
    public ArrayList<AttendanceSheet> getDetails() {
        return details;
    }

    /**
     * @param details the details to set
     */
    public void setDetails(ArrayList<AttendanceSheet> details) {
        this.details = details;
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
