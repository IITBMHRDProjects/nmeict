/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.utilities.SimpleStringCipher;
import org.project.utilities.FileUtil;
import org.project.utilities.Utility;
import org.project.utilities.EmailUtil;
import org.project.utilities.Validate;
import org.project.utilities.HtmlUtility;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import nl.bitwalker.useragentutils.Browser;
import nl.bitwalker.useragentutils.OperatingSystem;
import nl.bitwalker.useragentutils.UserAgent;
import nl.captcha.Captcha;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;

/**
 *
 * @author mayank
 */
public class UpdateAction extends ActionSupport {

    private Person person;
    private String confirmEmail;
    private String termsAndConditions;
    private String otherInstitute;
    private String captchaText;
    private File PersonPhoto;
    private String PersonPhotoContentType;
    private String PersonPhotoFileName;
    private String h_photoPath;

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    /**
     * @return the confirmEmail
     */
    public String getConfirmEmail() {
        return confirmEmail;
    }

    /**
     * @param confirmEmail the confirmEmail to set
     */
    public void setConfirmEmail(String confirmEmail) {
        this.confirmEmail = confirmEmail;
    }

    /**
     * @return the termsAndConditions
     */
    public String getTermsAndConditions() {
        return termsAndConditions;
    }

    /**
     * @param termsAndConditions the termsAndConditions to set
     */
    public void setTermsAndConditions(String termsAndConditions) {
        this.termsAndConditions = termsAndConditions;
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
     * @return the captchaText
     */
    public String getCaptchaText() {
        return captchaText;
    }

    /**
     * @param captchaText the captchaText to set
     */
    public void setCaptchaText(String captchaText) {
        this.captchaText = captchaText;
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

    public String updateProfile() throws Exception {
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
        // person.getCity().setCityName(uproc.getUserCityFromPerson(person.getStateId(), person.getCityId())); 
        person.setLoginName(person.getEmail());
        // setting the instituteName through instituteId
        if (person.getInstitute().getInstituteId() > 0) {
            person.getInstitute().setInstituteName(uproc.getInstiName(person.getInstitute().getInstituteId()));
        }
        if (getOtherInstitute().length() > 0) {
            person.getInstitute().setInstituteName(getOtherInstitute());
        }

        UtilityProcess objUpro = new UtilityProcess();
        // checking city is other(if value is -2 then its other city)
        if (person.getCityId() == -2) {
            if (person.getOtherCity().trim().length() > 0) {
                int resCityId = 0, checkAlPresent = 0;
                /**
                 * checking if other city is already present
                 */
                checkAlPresent = objUpro.checkOtherCityPresent(person.getStateId(), person.getOtherCity());
                /**
                 * if checkAlPresent return 0 then other city is not present and
                 * vice-versa
                 */
                if (checkAlPresent == 0) {
                    /**
                     * here we insert the new other city to city table with
                     * respective state. and return cityid of new city.
                     */
                    resCityId = objUpro.insertOtherCity(person.getStateId(), person.getOtherCity());
                    /**
                     * we use resCityId to set the person city in context table.
                     */
                    person.setCityId(resCityId);
                    /**
                     * use for setting the city in person table
                     */
                    person.getCity().setCityName(person.getOtherCity());
                    /**
                     * if checkAlPresent greater than 1 means same city is
                     * already present then in this case we set the old city id
                     * with same id and city in person
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
        //updating user information in the database
        int htitleId = -1, hdesignId = -1;
        htitleId = person.getInstitute().getHeadTitle().getH_headTitleId();
        hdesignId = person.getInstitute().getHeadDesignation().getH_headDesignationId();
        person.getInstitute().getHeadTitle().setHeadTitleId(htitleId);
        person.getInstitute().getHeadDesignation().setHeadDesignationId(hdesignId);
        /*
         * commented code for year of birth int hiddnYOB=-1;
         * hiddnYOB=person.getHiddenYearOfBirth();
         * person.setYearofbirth(hiddnYOB);
         */
        if (person.getFacultyStatus().equals("1") || person.getFacultyStatus().equals("0")) {
            if (h_photoPath.length() != 0) {
                person.setImage(h_photoPath);
                String filename = "";
                try {
                    filename = PersonPhotoFileName.trim();
                } catch (Exception e) {
                }
                if (filename != "") {
                    SavePersonPhoto();
                }
            } else {
                String image = "";
                try {
                    image = PersonPhotoFileName.trim();
                    person.setImage(image);
                } catch (Exception e) {
                }
                if (image.equals("") || image == "") {
                    person.setImage(image);
                }
                SavePersonPhoto();
            }
        } else {
            //normal user
        }
        if (person.getFacultyStatus().equals("1")) {
            result = uproc.UpdateUser(person, browser.getName(), os.getName());
        } else if (person.getFacultyStatus().equals("0")) {
            result = uproc.UpdateNormalUser(person, browser.getName(), os.getName());
        }
        if (result > 0) {
            try {
                String fileName = "emailconfirm_mail.html";
                String contextPath = ServletActionContext.getServletContext().getRealPath("");
                String filePath = contextPath + "/" + "mail-template";
                String emailMessage = HtmlUtility.read(filePath, fileName);
                String verification_link = getText("contextLink") + "/validateEmail.html?tmpl=";
                String emailforlink = SimpleStringCipher.encrypt(person.getEmail());
                String confirmation_link = verification_link + emailforlink;
                emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(person.getFirstName() + " " + person.getLastName());
                emailMessage = Pattern.compile("#link1#").matcher(emailMessage).replaceAll(confirmation_link);
                EmailUtil mail = new EmailUtil();
                mail.sendEmail("senderemail", person.getEmail(), "", "", "Profile updated successfully", emailMessage);
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

    @Override
    public void validate() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
        clearFieldErrors();
        if (Validate.validateEmail(person.getEmail()) == false) {
            addFieldError("emailError", getText("registrationPage.emailerror"));
        }

        /*
         * if (!person.getEmail().equalsIgnoreCase(getConfirmEmail()) ||
         * getConfirmEmail().equals("")) { /*if
         * (!person.getEmail().equalsIgnoreCase(getConfirmEmail()) ||
         * getConfirmEmail().equals("")) { addFieldError("cemailError",
         * getText("registrationPage.cemailerror")); }
         */
        if (person.getTitle().getTitleId() == -1) {
            addFieldError("titleError", getText("registrationPage.titleError"));
        }
        //if (!Validate.isStringValid(person.getFirstName(), 2, 30) || !Validate.validateName(person.getFirstName())) {
        if (!Validate.isStringValid(person.getFirstName(), 2, 30) || !Validate.validateLastName(person.getFirstName())) {
            addFieldError("firstNameError", getText("registrationPage.fnameIsEmpty"));
        }
        // if (!Validate.isStringValid(person.getLastName(), 1, 30) || !Validate.validateName(person.getLastName())) {
         if (!(person.getLastName().trim().equals("") || person.getLastName().trim().equals(null) || person.getLastName().trim().equals(" "))) {
            if (!Validate.isStringValid(person.getLastName(), 1, 30) || !Validate.validateLastName(person.getLastName())) {
                addFieldError("lastNameError", getText("registrationPage.lnameIsEmpty"));
            }
        }
        if (person.getQualification().getQualificationId() == -1) {
            addFieldError("qualificationError", getText("registrationPage.qualificationError"));
        }
        /*
         * if (person.getDesignation().getDesignationId() == -1) {
         * addFieldError("designationError",
         * getText("registrationPage.designationError")); }
         */
        if (person.getStream().getStreamId() == -1) {
            addFieldError("streamError", getText("registrationPage.disciplineError"));
        }
        /*
         * if (person.getExperience() == null ||
         * person.getExperience().equals("")) { addFieldError("experienceError",
         * getText("registrationPage.experienceError")); }
         */
        if (person.getGender() == null || person.getGender().equals("")) {
            addFieldError("genderError", getText("registrationPage.genderError"));
        }
        /*
         * if (person.getInstitute().getState().getStateId() == -1) {
         * addFieldError("instituteStateError",
         * getText("registrationPage.stateInstituteError")); } if
         * (person.getInstitute().getCity().getCityId() == -1) {
         * addFieldError("instituteCityError",
         * getText("registrationPage.cityInstituteError")); } if
         * (person.getInstitute().getInstituteId() == -1) {
         * addFieldError("instituteError",
         * getText("registrationPage.instituteError")); } if
         * (getOtherInstitute() != null && getOtherInstitute().length() > 0) {
         * if (!Validate.validateInstitute(getOtherInstitute())) {
         * addFieldError("otherInstituteError",
         * getText("registrationPage.otherInstituteError")); } }
         */
        /*
         * if
         * (!Validate.isStringValid(person.getInstitute().getInstituteAddress(),
         * 5, 150) ||
         * !Validate.validateAddress(person.getInstitute().getInstituteAddress()))
         * { addFieldError("instituteAddressError",
         * getText("registrationPage.addressIsEmpty")); }
         */
        /*
         * if
         * (Validate.validatePincode(String.valueOf(person.getInstitute().getPincode()))
         * == false) { addFieldError("institutePincodeError",
         * getText("registrationPage.pincodeEmptyError")); }
         */
        if ((person.getAddress().equals("")) || !Validate.validateAddress(person.getAddress())) {
            addFieldError("addressError", getText("registrationPage.addressIsEmpty"));
        }
        /*
         * if (person.getCity().getCityName() == null ||
         * Validate.isAllAlphabet(person.getCity().getCityName()) == false) {
         * addFieldError("cityError", getText("registrationPage.cityIsEmpty"));
         * }
         */
        /*
         * if (person.getCity().getCityName() == null ||
         * Validate.isValidCity(person.getCity().getCityName()) == false) {
         * addFieldError("cityError", getText("registrationPage.cityIsEmpty"));
         * }
         */
        if (Validate.validatePincode(String.valueOf(person.getPincode())) == false) {
            addFieldError("pincodeError", getText("registrationPage.pincodeEmptyError"));
        }
        if (Validate.validateMobileNumber(String.valueOf(person.getMobileNumber())) == false) {
            addFieldError("mobileNumberError", getText("registrationPage.mobileEmptyError"));
        }
        if (person.getPhoneNumber() != null) {
            if (Validate.validatePhoneNumber("0" + person.getPhoneNumber()) == false) {
                addFieldError("phoneNumberError", getText("registrationPage.phoneIsEmpty"));
            }
        }
        //if (person.getInstitute().getHeadTitle().getHeadTitleId() == -1 || person.getInstitute().getHeadTitle().getHeadTitleId() == 0) {
       /*
         * if (person.getInstitute().getHeadTitle().getH_headTitleId() == -1 ||
         * person.getInstitute().getHeadTitle().getH_headTitleId() == 0) {
         * addFieldError("headTitleError",
         * getText("registrationPage.titleError")); } // if
         * (!Validate.isStringValid(person.getInstitute().getHeadName(), 2, 30)
         * || !Validate.validateName(person.getInstitute().getHeadName())) { if
         * (!Validate.isStringValid(person.getInstitute().getHeadName(), 2, 30)
         * || !Validate.validateLastName(person.getInstitute().getHeadName())) {
         * addFieldError("headNameError",
         * getText("registrationPage.headNameIsEmpty")); } //if
         * (person.getInstitute().getHeadDesignation().getHeadDesignationId() ==
         * -1 ||
         * person.getInstitute().getHeadDesignation().getHeadDesignationId() ==
         * 0) { if
         * (person.getInstitute().getHeadDesignation().getH_headDesignationId()
         * == -1 ||
         * person.getInstitute().getHeadDesignation().getH_headDesignationId()
         * == 0) { addFieldError("headDesignationError",
         * getText("registrationPage.headDesignationError")); } if
         * (Validate.validateEmail(person.getInstitute().getHeadEmail()) ==
         * false) { addFieldError("headEmailError",
         * getText("registrationPage.emailerror")); } if
         * (Validate.validatePhoneNumber(person.getInstitute().getHeadContact())
         * == false) { addFieldError("headPhoneNumberError",
         * getText("registrationPage.phoneIsEmpty")); }
         */
//        if ((person.getInstitute().getHeadAddress().equals("")) || Validate.validateAddress(person.getInstitute().getHeadAddress()) == false) {
//            addFieldError("headAddressError", getText("registrationPage.addressIsEmpty"));
//        }
        if (getCaptchaText() == null || !captcha.isCorrect(getCaptchaText())) {
            addFieldError("captchaError", getText("captchaError"));
        }
        if (getTermsAndConditions() == null) {
            addFieldError("termAndConditionsError", getText("registrationPage.termsAndConditionsError"));
        }

        if (person.getStateId() == -1) {
            addFieldError("perStateError", getText("registrationPage.personStateError"));
        }
        if (person.getCityId() == -1) {
            addFieldError("perCityError", getText("registrationPage.personCityError"));
        }
        /*
         * if (person.getYearofbirth() == -1) { addFieldError("perYearofBirth",
         * getText("registrationPage.yearofbirthEmpty")); }
         */
        /*
         * code commented of username and year of birth if
         * (person.getHiddenYearOfBirth() == -1 || person.getHiddenYearOfBirth()
         * == 0) { addFieldError("perYearofBirth",
         * getText("registrationPage.yearofbirthEmpty")); }
         */
        /*
         * if (person.getUsername().trim().length() == 0) {
         * addFieldError("userNameError",
         * getText("registrationPage.usernameerror")); }
         */
        /*
         * if (person.getAadharId().trim().length() == 0) {
         * addFieldError("adharIdError",
         * getText("registrationPage.aadharidCheck")); }
         */

        //check person is faculty or not
        if (person.getFacultyStatus().equals("1")) {
            if (person.getDesignation().getDesignationId() == -1) {
                addFieldError("designationError", getText("registrationPage.designationError"));
            }
            if (person.getExperience() == null || person.getExperience().equals("")) {
                addFieldError("experienceError", getText("registrationPage.experienceError"));
            }
            if (person.getInstitute().getState().getStateId() == -1) {
                addFieldError("instituteStateError", getText("registrationPage.stateInstituteError"));
            }
            if (person.getInstitute().getCity().getCityId() == -1) {
                addFieldError("instituteCityError", getText("registrationPage.cityInstituteError"));
            }
            if (person.getInstitute().getInstituteId() == -1) {
                addFieldError("instituteError", getText("registrationPage.instituteError"));
            }
            if (getOtherInstitute() != null && getOtherInstitute().length() > 0) {
                if (!Validate.validateInstitute(getOtherInstitute())) {
                    addFieldError("otherInstituteError", getText("registrationPage.otherInstituteError"));
                }
            }
            if (!Validate.isStringValid(person.getInstitute().getInstituteAddress(), 5, 430) || !Validate.validateAddress(person.getInstitute().getInstituteAddress())) {
                addFieldError("instituteAddressError", getText("registrationPage.addressIsEmpty"));
            }
            if (Validate.validatePincode(String.valueOf(person.getInstitute().getPincode())) == false) {
                addFieldError("institutePincodeError", getText("registrationPage.pincodeEmptyError"));
            }
            if (person.getInstitute().getHeadTitle().getH_headTitleId() == -1 || person.getInstitute().getHeadTitle().getH_headTitleId() == 0) {
                addFieldError("headTitleError", getText("registrationPage.titleError"));
            }
            if (!Validate.isStringValid(person.getInstitute().getHeadName(), 2, 30) || !Validate.validateName(person.getInstitute().getHeadName())) {
                addFieldError("headNameError", getText("registrationPage.headNameIsEmpty"));
            }
            // if (person.getInstitute().getHeadDesignation().getHeadDesignationId() == -1) {
            if (person.getInstitute().getHeadDesignation().getH_headDesignationId() == -1 || person.getInstitute().getHeadDesignation().getH_headDesignationId() == 0) {
                addFieldError("headDesignationError", getText("registrationPage.headDesignationError"));
            }
            if (Validate.validateEmail(person.getInstitute().getHeadEmail()) == false) {
                addFieldError("headEmailError", getText("registrationPage.emailerror"));
            }
            if (Validate.validatePhoneNumber(person.getInstitute().getHeadContact()) == false) {
                addFieldError("headPhoneNumberError", getText("registrationPage.phoneIsEmpty"));
            }
            if ((person.getInstitute().getHeadAddress().equals("")) || Validate.validateAddress(person.getInstitute().getHeadAddress()) == false) {
                addFieldError("headAddressError", getText("registrationPage.addressIsEmpty"));
            }
            if (h_photoPath.trim().length() == 0) {
                if (PersonPhoto == null) {
                    addFieldError("photoError", getText("registrationPage.photoError"));
                }
            }
        } else if (person.getFacultyStatus().equals("0")) {
            //set person institute to 0
            if (person.getDesignation().getDesignationId() == -1) {
                addFieldError("designationError", getText("registrationPage.designationError"));
            }
            if (person.getExperience() == null || person.getExperience().equals("")) {
                addFieldError("experienceError", getText("registrationPage.experienceError"));
            }
            if (person.getInstitute().getState().getStateId() == -1) {
                addFieldError("instituteStateError", getText("registrationPage.stateInstituteError"));
            }
            if (person.getInstitute().getCity().getCityId() == -1) {
                addFieldError("instituteCityError", getText("registrationPage.cityInstituteError"));
            }
            if (person.getInstitute().getInstituteId() == -1) {
                addFieldError("instituteError", getText("registrationPage.instituteError"));
            }
            if (getOtherInstitute() != null && getOtherInstitute().length() > 0) {
                if (!Validate.validateInstitute(getOtherInstitute())) {
                    addFieldError("otherInstituteError", getText("registrationPage.otherInstituteError"));
                }
            }
            if (!Validate.isStringValid(person.getInstitute().getInstituteAddress(), 5, 430) || !Validate.validateAddress(person.getInstitute().getInstituteAddress())) {
                addFieldError("instituteAddressError", getText("registrationPage.addressIsEmpty"));
            }
            if (Validate.validatePincode(String.valueOf(person.getInstitute().getPincode())) == false) {
                addFieldError("institutePincodeError", getText("registrationPage.pincodeEmptyError"));
            }
            if (h_photoPath.trim().length() == 0) {
                if (PersonPhoto == null) {
                    addFieldError("photoError", getText("registrationPage.photoError"));
                }
            }
        }
    }

    /**
     * @return the permissionLetter
     */
    public String getH_photoPath() {
        return h_photoPath;
    }

    /**
     * @param permissionLetter the permissionLetter to set
     */
    public void setH_photoPath(String h_photoPath) {
        this.h_photoPath = h_photoPath;
    }

    /**
     * @return the participant
     */
    public String getPersonPhotoContentType() {
        return PersonPhotoContentType;
    }

    /**
     * @param participant the participant to set
     */
    public void setPersonPhotoContentType(String PersonPhotoContentType) {
        this.PersonPhotoContentType = PersonPhotoContentType;
    }

    /**
     * @return the workshopcontent
     */
    public String getPersonPhotoFileName() {
        return PersonPhotoFileName;
    }

    /**
     * @param workshopcontent the workshopcontent to set
     */
    public void setPersonPhotoFileName(String PersonPhotoFileName) {
        this.PersonPhotoFileName = PersonPhotoFileName;
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
}
