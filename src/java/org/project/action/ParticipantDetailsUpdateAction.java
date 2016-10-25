/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.regex.Pattern;
import nl.bitwalker.useragentutils.Browser;
import nl.bitwalker.useragentutils.OperatingSystem;
import nl.bitwalker.useragentutils.UserAgent;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;
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
public class ParticipantDetailsUpdateAction extends ActionSupport {

    private Person person;
    private File permissionLetter;
    private Participant participant;
    private WorkshopContent workshopcontent;
    private File eligibility;
    private int facultyStatus;

    public String updateParticipantDetails() throws Exception {
        int result = 0;
        //is client behind something?
        String ipAddress = ServletActionContext.getRequest().getHeader("X-FORWARDED-FOR");
        if (ipAddress == null) {
            ipAddress = ServletActionContext.getRequest().getRemoteAddr();
        }
        person.setIpAddress(ipAddress);
        //getting the browser and operating system of the logged in user
        String userAgentString = ServletActionContext.getRequest().getHeader("User-Agent");
        UserAgent userAgent = UserAgent.parseUserAgentString(userAgentString);
        OperatingSystem os = userAgent.getOperatingSystem();
        Browser browser = userAgent.getBrowser();
        UserProcess uproc = new UserProcess();
        person.setLoginName(person.getEmail());
        person.setFacultyStatus(Integer.toString(facultyStatus));
        // setting the instituteName through instituteId
        if (person.getInstitute().getInstituteId() > 0) {
            person.getInstitute().setInstituteName(uproc.getInstiName(person.getInstitute().getInstituteId()));
        }
        RemoteCenter rc = uproc.getRemoteCenterName(participant.getRcid());

        //updating user information in the database
        result = uproc.UpdateUser1(person, browser.getName(), os.getName(), getWorkshopcontent(), getParticipant());
        if (result > 0) {
            String context = ServletActionContext.getServletContext().getRealPath("");
            try {
                int participant_check = uproc.getParticipantID(person.getEmail(), Integer.toString(workshopcontent.getWorkshopid()));
                participant.setParticipantid(participant_check);
                FileUtil.saveFile(permissionLetter, "permissionLetter_" + participant.getParticipantid() + ".jpg", context + File.separator + "Permission_Letter");
            } catch (Exception filenotfound) {
                File checkFile = new File(context + "/Permission_Letter/" + "permissionLetter_" + participant.getParticipantid() + ".jpg");
                if (checkFile.exists() && !checkFile.isDirectory()) {
                } else {
                    uproc.setBlankLetter(participant.getParticipantid());
                }
//                filenotfound.printStackTrace();
            }

            try {
                String fileName = "update_participant_byadmin.html";
                String contextPath = ServletActionContext.getServletContext().getRealPath("");
                String filePath = contextPath + "/" + "mail-template";
                String subject = "Registration details updated successfully for " + workshopcontent.getWorkshopname();
                String emailMessage = HtmlUtility.read(filePath, fileName);
                emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(person.getFirstName()+" "+person.getLastName());
                emailMessage = Pattern.compile("#workshopname#").matcher(emailMessage).replaceAll(workshopcontent.getWorkshopname());
                emailMessage = Pattern.compile("#rcid#").matcher(emailMessage).replaceFirst("" + participant.getRcid());
                emailMessage = Pattern.compile("#rcname#").matcher(emailMessage).replaceAll(rc.getRemoteCenterName() + ", " + rc.getRc_city());
                EmailUtil mail = new EmailUtil();
                mail.sendEmail("senderemail", person.getEmail(), "", "", subject, emailMessage);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return Utility.SUCCESS;
        } else {
            clearActionErrors();
            addActionError(getText("updateProfile.UpdationError"));
            return Utility.ERROR;
        }
    }

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
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
     * @return the eligibility
     */
    public File getEligibility() {
        return eligibility;
    }

    /**
     * @param eligibility the eligibility to set
     */
    public void setEligibility(File eligibility) {
        this.eligibility = eligibility;
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
