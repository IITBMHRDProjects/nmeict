/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.utilities.EmailUtil;
import org.project.utilities.FileUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class UpdateWorkshopRegistration extends ActionSupport {

    private WorkshopContent workshopContent;
    private Person person;
    private Participant participant;
    private Participant participant_check;
    private File permissionLetter;
    private String pletterReqFlag;

    public String updateParticipant() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        UserProcess userproc = new UserProcess();
        String letterUpdated = "Yes";

        participant_check = userproc.checkParticipant(Integer.toString(workshopContent.getWorkshopid()), person.getLoginId());
        int alreadyRegistered = participant_check.getIsAlreadyRegistered();
        int isnotvalidForUpdate = participant_check.getIsNotValidForUpdate();
        int rcid_alreadyRegistered = 0;
        if (workshopContent.getCategorycode() == 4) {
//            rcid_alreadyRegistered = userproc.checkRCAlreadyPresent(workshopContent.getWorkshopid(), participant.getRcid());
            rcid_alreadyRegistered = 0;
        }
        if (workshopContent.getCategorycode() == 8) {
            workshopContent.setFacultyFlag(pletterReqFlag);
        }
        if (alreadyRegistered > 0 && isnotvalidForUpdate == 1) {
            return Utility.ALREADY_REGISTERED;
        } else {
            if (rcid_alreadyRegistered > 0) {
                return Utility.RC_ALREADY_REGISTERED;
            } else {
                participant.setParticipantid(participant_check.getParticipantid());
                Participant p = userproc.updateParticipant(workshopContent, person, participant);

                if (p.getParticipantid() > 0) {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    if (workshopContent.getCategorycode() == 8) {
                        if (workshopContent.getFacultyFlag().equals("1")) {
                            try {
                                FileUtil.saveFile(getPermissionLetter(), "permissionLetter_" + p.getParticipantid() + ".jpg", context + File.separator + "Permission_Letter");
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        } else {
                            // no letter will be saved - set letter table to blank.
                            userproc.setBlankLetter(p.getParticipantid());
                        }
                    } else {
                        try {
                            FileUtil.saveFile(getPermissionLetter(), "permissionLetter_" + p.getParticipantid() + ".jpg", context + File.separator + "Permission_Letter");
                        } catch (FileNotFoundException filenotfound) {
                            letterUpdated = "No";
                            filenotfound.printStackTrace();
                        }
                    }
                    try {

                        //get the file name of the confirm email of this workshop
                        String fileName = "update_registration_success.html";
                        String contextPath = ServletActionContext.getServletContext().getRealPath("");
                        String filePath = contextPath + "/" + "mail-template";
                        String subject = "Registration details updated successfully for " + workshopContent.getWorkshopname();
                        String emailMessage = HtmlUtility.read(filePath, fileName);
                        String emailforlink = SimpleStringCipher.encrypt(person.getEmail());
                        emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(person.getFirstName()+ " " + person.getLastName());
                        emailMessage = Pattern.compile("#workshopname#").matcher(emailMessage).replaceFirst(workshopContent.getWorkshopname());
                        emailMessage = Pattern.compile("#rcname#").matcher(emailMessage).replaceFirst(p.getRcname());
                        emailMessage = Pattern.compile("#rcid#").matcher(emailMessage).replaceFirst("" + participant.getRcid());
                        EmailUtil mail = new EmailUtil();
                        mail.sendEmail("senderemail", person.getEmail(), "", "", subject, emailMessage);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if (participant_check.getStatus().equals("Registration Invalid")) {
                        try {
                            String fileName = "details_updated_copy_support.html";
                            String contextPath = ServletActionContext.getServletContext().getRealPath("");
                            String filePath = contextPath + "/" + "mail-template";
                            String emailMessage = HtmlUtility.read(filePath, fileName);
                            emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(person.getFirstName() + " " + person.getLastName());
                            emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceAll(person.getEmail());
                            emailMessage = Pattern.compile("#participantid#").matcher(emailMessage).replaceAll(Integer.toString(participant.getParticipantid()));
                            emailMessage = Pattern.compile("#rcid#").matcher(emailMessage).replaceFirst(Integer.toString(participant.getRcid()));
                            emailMessage = Pattern.compile("#workshopname#").matcher(emailMessage).replaceFirst(workshopContent.getWorkshopname());
                            emailMessage = Pattern.compile("#letterupdated#").matcher(emailMessage).replaceAll(letterUpdated);
                            EmailUtil mail = new EmailUtil();
                            mail.sendEmail("senderemail", "senderemail", "", "", "Valid permission letter uploaded for " + workshopContent.getWorkshopname() + " by participant " + person.getFirstName() + " " + person.getLastName(), emailMessage);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    return Utility.SUCCESS;
                } else {
                    clearActionErrors();
                    addActionError("Oops! Database insertion error.");
                    return Utility.ERROR;
                }
            }
        }
    }

    /**
     * @return the workshopContent
     */
    public WorkshopContent getWorkshopContent() {
        return workshopContent;
    }

    /**
     * @param workshopContent the workshopContent to set
     */
    public void setWorkshopContent(WorkshopContent workshopContent) {
        this.workshopContent = workshopContent;
    }

    /**
     * @return the person
     */
    public Person getPerson() {
        return person;
    }

    /**
     * @param person the person to set
     */
    public void setPerson(Person person) {
        this.person = person;
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
     * @return the participant_check
     */
    public Participant getParticipant_check() {
        return participant_check;
    }

    /**
     * @param participant_check the participant_check to set
     */
    public void setParticipant_check(Participant participant_check) {
        this.participant_check = participant_check;
    }

    /**
     * @return the pletterReqFlag
     */
    public String getPletterReqFlag() {
        return pletterReqFlag;
    }

    /**
     * @param pletterReqFlag the pletterReqFlag to set
     */
    public void setPletterReqFlag(String pletterReqFlag) {
        this.pletterReqFlag = pletterReqFlag;
    }
}
