/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.bean.WorkshopCount;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author dipesh
 */
public class DisplayPaymentDetailsAction extends ActionSupport {

    private ArrayList<WorkshopContent> workshopContents;
    private ArrayList<WorkshopCount> workshopCount;
    private String update;

    public String getDisplayDetailsOfPayment() {
        try {
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            UtilityProcess process = new UtilityProcess();
            String update_enc = ServletActionContext.getRequest().getParameter("update");
            String period = "90 day";
            if (update_enc != null && update_enc != "") {
                SimpleStringCipher cipher = new SimpleStringCipher();
                update = cipher.decrypt(update_enc);
                if (update.equals("paymentdetails")) {
                }
                //updateReg
                workshopContents = (process.listWorkshopsForPaymentDetails(period));
             } else {
                workshopContents = (process.listWorkshopsForPaymentDetails(period));
            }
            setWorkshopContents(workshopContents);
            workshopCount = (process.getWorkshopCount());
            setWorkshopCount(workshopCount);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
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
     * @return the workshopCount
     */
    public ArrayList<WorkshopCount> getWorkshopCount() {
        return workshopCount;
    }

    /**
     * @param workshopCount the workshopCount to set
     */
    public void setWorkshopCount(ArrayList<WorkshopCount> workshopCount) {
        this.workshopCount = workshopCount;
    }

    /**
     * @return the update
     */
    public String getUpdate() {
        return update;
    }

    /**
     * @param update the update to set
     */
    public void setUpdate(String update) {
        this.update = update;
    }
}
