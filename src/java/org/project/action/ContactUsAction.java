/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.utilities.Utility;
import org.project.utilities.EmailUtil;
import org.project.utilities.Validate;
import org.project.utilities.HtmlUtility;
import com.opensymphony.xwork2.ActionSupport;
import java.util.regex.Pattern;
import org.apache.struts2.ServletActionContext;
import org.project.process.UtilityProcess;

/**
 *
 * @author mayank
 */
public class ContactUsAction extends ActionSupport {

    private String contactName;
    private String contactEmail;
    private String message;

    /**
     * @return the contactName
     */
    public String getContactName() {
        return contactName;
    }

    /**
     * @param contactName the contactName to set
     */
    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    /**
     * @return the contactEmail
     */
    public String getContactEmail() {
        return contactEmail;
    }

    /**
     * @param contactEmail the contactEmail to set
     */
    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    /**
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * @param message the message to set
     */
    public void setMessage(String message) {
        this.message = message;
    }

    public String message() {
        UtilityProcess uproc = new UtilityProcess();
        int updated = uproc.submitMessage(getContactName(), getContactEmail(), getMessage());
        if (updated > 0) {
            try {
                String fileName = "query_mail.html";
                String contextPath = ServletActionContext.getServletContext().getRealPath("");
                String filePath = contextPath + "/" + "mail-template";
                String emailMessage = HtmlUtility.read(filePath, fileName);
                emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(getContactName());
                EmailUtil mail = new EmailUtil();
                mail.sendEmail("senderemail", getContactEmail(), "", "", "Query/Message submitted", emailMessage);
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                String fileName = "queryinitiated_mail.html";
                String contextPath = ServletActionContext.getServletContext().getRealPath("");
                String filePath = contextPath + "/" + "mail-template";
                String emailMessage = HtmlUtility.read(filePath, fileName);
                emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(getContactName());
                emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceAll(getContactEmail());
                emailMessage = Pattern.compile("#message#").matcher(emailMessage).replaceAll(getMessage());
                EmailUtil mail = new EmailUtil();
                mail.sendEmail("senderemail", "senderemail", "", "", "Query/Message initiated from " + getContactName(), emailMessage);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return Utility.SUCCESS;
        } else {
            clearActionErrors();
            addActionError(" Database insertion problem, please resubmit the query/message!");
            return Utility.ERROR;
        }
    }

    @Override
    public void validate() {
        if (Validate.validateEmail(getContactEmail()) == false) {
            addFieldError("emailError", getText("registrationPage.emailerror"));
        }
        if (!Validate.isStringValid(getContactName(), 3, 40) || !Validate.validateName(getContactName())) {
            addFieldError("nameError", getText("contactUsPage.nameIsEmpty"));
        }
        if ((getMessage().equals("")) || !Validate.validateAddress(getMessage())) {
            addFieldError("messageError", getText("contactUsPage.messageIsEmpty"));
        }
    }
}
