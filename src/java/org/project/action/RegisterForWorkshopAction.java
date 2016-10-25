/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Random;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FilenameUtils;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.RemoteCenterCapacity;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.EmailUtil;
import org.project.utilities.FileUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;
import org.project.utilities.Validate;
import javax.activation.MimetypesFileTypeMap;

/**
 *
 * @author Abinaya
 */
public class RegisterForWorkshopAction extends ActionSupport {

    private WorkshopContent workshopContent;
    private Person person;
    private Participant participant;
    private Participant participant_check;
    private File permissionLetter;
    private String uniqueid;
    private String hiddenfee;
    private String pletterReqFlag;
    private int facultyStatus;

    public String registerParticipant() throws Exception {
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        UserProcess userproc = new UserProcess();
        participant_check = userproc.checkParticipant(Integer.toString(workshopContent.getWorkshopid()), person.getLoginId());
        int alreadyRegistered = participant_check.getIsAlreadyRegistered();
        int rcid_alreadyRegistered = 0;
        if (workshopContent.getCategorycode() == 4 && workshopContent.getRespectiveCoWorkshopid() == 0) {
            rcid_alreadyRegistered = userproc.checkRCAlreadyPresent(workshopContent.getWorkshopid(), participant.getRcid());
        }
        if (workshopContent.getCategorycode() == 8) {
            workshopContent.setFacultyFlag(pletterReqFlag);
        }
        if (alreadyRegistered > 0) {
            return Utility.ALREADY_REGISTERED;
        } else {
            if (rcid_alreadyRegistered > 0) {
                return Utility.RC_ALREADY_REGISTERED;
            } else {

                Participant p = userproc.insertParticipant(workshopContent, person, participant);
                Participant partnew = new Participant();
                partnew.setParticipantid(p.getParticipantid());
                participant = partnew;
                if (workshopContent.getCategorycode() == 8 && p.getParticipantid() > 0) {
                    //setUniqueid(generateTxnId());
                }
                if (p.getParticipantid() > 0) {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    // save file only if permission letter is required
                    if (workshopContent.getPermissionIfRequired() > 0) {
                        if (workshopContent.getCategorycode() == 8) {
                            if (workshopContent.getFacultyFlag().equals("1")) {
                                try {
                                    FileUtil.saveFile(getPermissionLetter(), "permissionLetter_" + p.getParticipantid() + ".jpg", context + File.separator + "Permission_Letter");
                                 } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            } else {
                                // no letter will be saved
                            }
                        } else {
                            try {
                                FileUtil.saveFile(getPermissionLetter(), "permissionLetter_" + p.getParticipantid() + ".jpg", context + File.separator + "Permission_Letter");
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    }
                    try {

                        //get the file name of the confirm email of this workshop
                        String fileName = "successMail_" + workshopContent.getWorkshopid() + ".html";
                        String contextPath = ServletActionContext.getServletContext().getRealPath("");
                        String filePath = contextPath + "/" + "mails";
                        String subject = "Successfully Enrolled for " + workshopContent.getWorkshopname();
                        String emailMessage = HtmlUtility.read(filePath, fileName);
                        String emailforlink = SimpleStringCipher.encrypt(person.getEmail());
                        emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(person.getFirstName() + " " + person.getLastName());
                        EmailUtil mail = new EmailUtil();
                        mail.sendEmail("senderemail", person.getEmail(), "senderemail", "", subject, emailMessage);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
//                    session.setAttribute("message", "<p>You have successfully registered for the"+ workshopContent.getWorkshopname()+".</p>");
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

    @Override
    public void validate() {
        clearFieldErrors();
//        String name=permissionLetter.getName();
//        String ext=(FilenameUtils.getExtension(name)).toLowerCase();
//        if(!(ext.equals("jpg")||ext.equals("jpeg"))){
//        addFieldError("permissionLetterError", getText("workshopRegistrationForm.permissionLetterError2"));
//        }
//       //get file size
//        long size=permissionLetter.length();
//        // check if exceeds 256kb
//        if( size!=0 && size<262144){
//         addFieldError("permissionLetterError", getText("workshopRegistrationForm.permissionLetterError1"));
//        }
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
     * @return the uniqueid
     */
    public String getUniqueid() {
        return uniqueid;
    }

    /**
     * @param uniqueid the uniqueid to set
     */
    public void setUniqueid(String uniqueid) {
        this.uniqueid = uniqueid;
    }

    /**
     * @return the hiddenfee
     */
    public String getHiddenfee() {
        return hiddenfee;
    }

    /**
     * @param hiddenfee the hiddenfee to set
     */
    public void setHiddenfee(String hiddenfee) {
        this.hiddenfee = hiddenfee;
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
