/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.bean.Participant;
import org.project.bean.WorkshopContent;
import org.project.bean.Person;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author abinaya
 */
public class WorkshopContentAction extends ActionSupport {

    /**
     * An array list for the contents of the workshop
     */
    private ArrayList<WorkshopContent> workshopContent;
    private Participant participant;
    private int ifWSC = 0;
    private int ifRCC = 0;
    private int ifRCC1 = 0;
    private int facultyStatus = 0;

    @Override
    public String execute() {
        /**
         * Getting user session object
         */
        try {
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            /**
             * cipher for decrypting the workshopid from the url
             */
            SimpleStringCipher cipher = new SimpleStringCipher();
            /**
             * getting the parameter from url
             */
            String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
            String workshopid = cipher.decrypt(workshopid_encrypted);
            UtilityProcess process = new UtilityProcess();
            //fetching the arraylist of workshopcontent
            workshopContent = (process.listWorkshopContent(workshopid));

            UserProcess userproc = new UserProcess();
            participant = new Participant();
            //check if user is logged in already and registered for the workshop.
            if (person != null) {
                participant = userproc.checkParticipant(workshopid, person.getLoginId());
                facultyStatus = userproc.getFactulyStatus(person.getLoginId());
                // check if workshop coordinator of this workshop
                ifWSC = process.ifExistInRelevantCoordinatorWorkshop(workshopContent.get(0).getWorkshopid(), person.getLoginId());
                // check if remote center coordinator of this workshop
                ifRCC = process.ifExistInRelevantRCC(workshopContent.get(0).getRespectiveCoWorkshopid(), person.getLoginName());
                // check if the person is RCC - can't register for any workshop
                setIfRCC1(process.ifRCC(person.getLoginName()));
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        this.setWorkshopContent(workshopContent);
    }

    public Participant getParticipant() {
        return participant;
    }

    public void setParticipant(Participant participant) {
        this.participant = participant;
    }

    /**
     * @return the ifWSC
     */
    public int getIfWSC() {
        return ifWSC;
    }

    /**
     * @param ifWSC the ifWSC to set
     */
    public void setIfWSC(int ifWSC) {
        this.ifWSC = ifWSC;
    }

    /**
     * @return the ifRCC
     */
    public int getIfRCC() {
        return ifRCC;
    }

    /**
     * @param ifRCC the ifRCC to set
     */
    public void setIfRCC(int ifRCC) {
        this.ifRCC = ifRCC;
    }

    /**
     * @return the ifRCC1
     */
    public int getIfRCC1() {
        return ifRCC1;
    }

    /**
     * @param ifRCC1 the ifRCC1 to set
     */
    public void setIfRCC1(int ifRCC1) {
        this.ifRCC1 = ifRCC1;
    }

    /**
     * @return the facultyStatus
     */
    public int getFacultyStatus() {
        return facultyStatus;
    }

    /**
     * @param facultyStatus the facultyStatus to set
     */
    public void setFacultyStatus(int facultyStatus) {
        this.facultyStatus = facultyStatus;
    }
}
