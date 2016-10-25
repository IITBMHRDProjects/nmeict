/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.EmailUtil;
import org.project.utilities.FileUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class UpdateLetterAction extends ActionSupport {

    private String participantid;
    private String workshopid;
    private File permissionLetter;
    private Participant participant;
    private WorkshopContent workshopcontent;

    public String execute() throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        UtilityProcess process = new UtilityProcess();
        String email = "";
        /**
         * checking for user is log in or not
         */
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            /**
             * checking participant id is getting or not
             */
             if (Integer.parseInt(getParticipantid()) > 0) {
                 participant = new Participant();
                /**
                 * setting participantid and workshopid
                 */
                participant.setParticipantid(Integer.parseInt(participantid));
                setWorkshopcontent(new WorkshopContent());
                getWorkshopcontent().setWorkshopid(Integer.parseInt(workshopid));
                setParticipant(participant);
                setWorkshopcontent(getWorkshopcontent());
                /**
                 * calling the updateParticipantLetter method by passing
                 * participant , workshopcontent(participantid,workshopid)
                 */
                 int res = process.updateParticipantLetter(participant, getWorkshopcontent());
                /**
                 * if result greater than 0 then file saved or uploaded to
                 * directory
                 */
                if (res > 0) {
                    /**
                     * getting path for upload the file
                     */
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getPermissionLetter(), "permissionLetter_" + getParticipantid() + ".jpg", context + File.separator + "Permission_Letter");
                    /**
                     * after file upload mail should be send to particular
                     * participant for that we are getting email and name of
                     * participant to send a mail by callling following method
                     */
                   // email = process.getEmailOfParticipant(participant);
                  //  String name = process.getNameOfParticipant(email);
                    // mail code is here...
                    /*try {
                        String fileName = "permissionLetterUpdateConfrim_mail.html";
                        String contextPath = ServletActionContext.getServletContext().getRealPath("");
                        String filePath = contextPath + "/" + "mail-template";
                        String emailMessage = HtmlUtility.read(filePath, fileName);
                        emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(name);
                        EmailUtil mail = new EmailUtil();
                        mail.sendEmail("senderemail", email, "", "", "Dear Participant : Your Permission Letter Updated Successfully", emailMessage);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }*/
                     session.setAttribute("letter", "");
                }else {
                  session.setAttribute("letter", "Not Updated");
                }

            }
        }

        return Utility.SUCCESS;
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
     * @return the permissionLetter
     */
    public File getPermissionLetter() {
        return permissionLetter;
    }

    /**
     * @param permissionLetter the permissionLetter to set
     */
    public void setPermissionLetter(File permissionLetter) {
        this.permissionLetter = permissionLetter;
    }

    /**
     * @return the participant
     */
    public Participant getParticipant() {
        return participant;
    }

    /**
     * @param participant the participant to set
     */
    public void setParticipant(Participant participant) {
        this.participant = participant;
    }

    /**
     * @return the workshopcontent
     */
    public WorkshopContent getWorkshopcontent() {
        return workshopcontent;
    }

    /**
     * @param workshopcontent the workshopcontent to set
     */
    public void setWorkshopcontent(WorkshopContent workshopcontent) {
        this.workshopcontent = workshopcontent;
    }

    /**
     * @return the worskhopcontent
     */
}
