/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.util.regex.Pattern;
import nl.bitwalker.useragentutils.Browser;
import nl.bitwalker.useragentutils.OperatingSystem;
import nl.bitwalker.useragentutils.UserAgent;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.EmailUtil;
import org.project.utilities.FileUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class RegisterParticipantOnInvite extends ActionSupport {

    private Person person;
    private Participant participant;
    private WorkshopContent workshopContent;
    private int notInLogin;
    private int isNewUser;
    private String idContext;
    private Participant participant_check;
    private String otherInstitute;
    private String h_photoPath;
    private File PersonPhoto;
    private String PersonPhotoContentType;
    private String PersonPhotoFileName;

    @Override
    public String execute() {
        try {
            int result = 0;
            UserProcess uproc = new UserProcess();
            UtilityProcess process = new UtilityProcess();
            //is client behind something?
            String ipAddress = ServletActionContext.getRequest().getHeader("X-FORWARDED-FOR");
            if (ipAddress == null) {
                ipAddress = ServletActionContext.getRequest().getRemoteAddr();
            }
            getPerson().setIpAddress(ipAddress);
            //getting the browser and operating system of the logged in user
            String userAgentString = ServletActionContext.getRequest().getHeader("User-Agent");
            UserAgent userAgent = UserAgent.parseUserAgentString(userAgentString);
            OperatingSystem os = userAgent.getOperatingSystem();
            Browser browser = userAgent.getBrowser();

            // checking city is other(if value is -2 then its other city)
            if (person.getCityId() == -2) {
                if (person.getOtherCity().trim().length() > 0) {
                    int resCityId = 0, checkAlPresent = 0;
                    /**
                     * checking if other city is already present
                     */
                    checkAlPresent = process.checkOtherCityPresent(person.getStateId(), person.getOtherCity());
                    /**
                     * if checkAlPresent return 0 then other city is not present
                     * and vice-versa
                     */
                    if (checkAlPresent == 0) {
                        /**
                         * here we insert the new other city to city table with
                         * respective state. and return cityid of new city.
                         */
                        resCityId = process.insertOtherCity(person.getStateId(), person.getOtherCity());
                        /**
                         * we use resCityId to set the person city in context
                         * table.
                         */
                        person.setCityId(resCityId);
                        /**
                         * use for setting the city in person table
                         */
                        person.getCity().setCityName(person.getOtherCity());
                        /**
                         * if checkAlPresent greater than 1 means same city is
                         * already present then in this case we set the old city
                         * id with same id and city in person
                         */
                    } else if (checkAlPresent > 0) {
                        person.setCityId(checkAlPresent);
                        person.getCity().setCityName(person.getOtherCity());
                    }
                } else {
                    person.getCity().setCityName(null);
                }
                /**
                 * setting selected city from drop down
                 */
            } else {
                person.getCity().setCityName(uproc.getUserCityFromPerson(person.getStateId(), person.getCityId()));
            }
            person.setLoginName(person.getEmail());
            // setting the instituteName through instituteId
            if (person.getInstitute().getInstituteId() > 0) {
                person.getInstitute().setInstituteName(uproc.getInstiName(person.getInstitute().getInstituteId()));
            }
            if (getOtherInstitute().length() > 0) {
                person.getInstitute().setInstituteName(getOtherInstitute());
            }



            if (getIsNewUser() == 1) {
                // register new user with sign up and entries in participant and accommodation
                result = uproc.registerUser(getPerson(), browser.getName(), os.getName());

                person.setLoginId(result);
                // insert participant
                setPhoto();
                return insertParticipant();

            } else {

                // check if participant already exist in the workshop
                setParticipant_check(uproc.checkParticipant(Integer.toString(getWorkshopContent().getWorkshopid()), Integer.parseInt(getIdContext())));
                int alreadyRegistered = getParticipant_check().getIsAlreadyRegistered();
                person.setLoginId(Integer.parseInt(getIdContext()));
                if (alreadyRegistered > 0) {
                    return Utility.ALREADY_REGISTERED;
                } else {
                    person.setLoginName(person.getEmail());
                    setPhoto();
                    result = uproc.UpdateUser(person, browser.getName(), os.getName());

                    if (getNotInLogin() == 1) {
                        // exist in context, no login details - create login entry, update his details of context, person and make an entry as participant
                        // just update login entry with password
                        uproc.changePassword(Integer.parseInt(getIdContext()), person.getPassword());
                    }
                    // insert participant
                    return insertParticipant();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Utility.ERROR;
        }
    }

    private String insertParticipant() {
        UserProcess uproc = new UserProcess();
        Participant p = uproc.insertParticipant(workshopContent, person, participant);

        if (p.getParticipantid() > 0) {
            String context = ServletActionContext.getServletContext().getRealPath("");
            // save file only if permission letter is required
//            if (workshopContent.getPermissionIfRequired() > 0) {
//                try {
//                    FileUtil.saveFile(getPermissionLetter(), "permissionLetter_" + p.getParticipantid() + ".jpg", context + File.separator + "Permission_Letter");
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
            try {

                //get the file name of the confirm email of this workshop
                String fileName = "successMail_" + workshopContent.getWorkshopid() + ".html";
                String contextPath = ServletActionContext.getServletContext().getRealPath("");
                String filePath = contextPath + "/" + "mails";
                String subject = "Successfully Enrolled for " + workshopContent.getWorkshopname();
                String emailMessage = HtmlUtility.read(filePath, fileName);
                String emailforlink = SimpleStringCipher.encrypt(person.getEmail());
                emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(person.getFirstName()+" "+person.getLastName());
                EmailUtil mail = new EmailUtil();
                mail.sendEmail("senderemail", person.getEmail(), "senderemail", "", subject, emailMessage);
            } catch (Exception e) {
                e.printStackTrace();
                return Utility.ERROR;
            }
//                    session.setAttribute("message", "<p>You have successfully registered for the"+ workshopContent.getWorkshopname()+".</p>");
            return Utility.SUCCESS;
        } else {
            clearActionErrors();
            addActionError("Oops! Database insertion error.");
            return Utility.ERROR;
        }
    }

    private void SavePersonPhoto() {
        UtilityProcess process = new UtilityProcess();
        int person_id = process.getUserIdOfParticipant(person.getEmail());
        String context = ServletActionContext.getServletContext().getRealPath("");
        try {
            FileUtil.saveFile(getPersonPhoto(), "photo_" + person_id + ".jpg", context + File.separator + "UserImages");
        } catch (Exception e) {
            System.out.println("problem in file upload");
        }
    }

    private void setPhoto() {
        if (getH_photoPath().length() != 0) {
            person.setImage(getH_photoPath());
            String filename = "";
            try {
                filename = getPersonPhotoFileName().trim();
            } catch (Exception e) {
            }
            if (filename != "") {
                SavePersonPhoto();
            }
        } else {
            String image = "";
            try {
                image = getPersonPhotoFileName().trim();
                person.setImage(image);
            } catch (Exception e) {
            }
            if (image.equals("") || image == "") {
                person.setImage(image);
            }
            SavePersonPhoto();
        }
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
     * @return the notInLogin
     */
    public int getNotInLogin() {
        return notInLogin;
    }

    /**
     * @param notInLogin the notInLogin to set
     */
    public void setNotInLogin(int notInLogin) {
        this.notInLogin = notInLogin;
    }

    /**
     * @return the isNewUser
     */
    public int getIsNewUser() {
        return isNewUser;
    }

    /**
     * @param isNewUser the isNewUser to set
     */
    public void setIsNewUser(int isNewUser) {
        this.isNewUser = isNewUser;
    }

    /**
     * @return the idContext
     */
    public String getIdContext() {
        return idContext;
    }

    /**
     * @param idcontext the idContext to set
     */
    public void setIdContext(String idContext) {
        this.idContext = idContext;
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
     * @return the otherInstitute
     */
    public String getOtherInstitute() {
        return otherInstitute;
    }

    /**
     * @param otherInstitute the otherInstitute to set
     */
    public void setOtherInstitute(String otherInstitute) {
        this.otherInstitute = otherInstitute;
    }

    /**
     * @return the h_photoPath
     */
    public String getH_photoPath() {
        return h_photoPath;
    }

    /**
     * @param h_photoPath the h_photoPath to set
     */
    public void setH_photoPath(String h_photoPath) {
        this.h_photoPath = h_photoPath;
    }

    /**
     * @return the PersonPhoto
     */
    public File getPersonPhoto() {
        return PersonPhoto;
    }

    /**
     * @param PersonPhoto the PersonPhoto to set
     */
    public void setPersonPhoto(File PersonPhoto) {
        this.PersonPhoto = PersonPhoto;
    }

    /**
     * @return the PersonPhotoContentType
     */
    public String getPersonPhotoContentType() {
        return PersonPhotoContentType;
    }

    /**
     * @param PersonPhotoContentType the PersonPhotoContentType to set
     */
    public void setPersonPhotoContentType(String PersonPhotoContentType) {
        this.PersonPhotoContentType = PersonPhotoContentType;
    }

    /**
     * @return the PersonPhotoFileName
     */
    public String getPersonPhotoFileName() {
        return PersonPhotoFileName;
    }

    /**
     * @param PersonPhotoFileName the PersonPhotoFileName to set
     */
    public void setPersonPhotoFileName(String PersonPhotoFileName) {
        this.PersonPhotoFileName = PersonPhotoFileName;
    }
}
