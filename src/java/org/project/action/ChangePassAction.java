/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;
import org.project.utilities.EmailUtil;
import org.project.utilities.Validate;
import org.project.utilities.HtmlUtility;
import com.opensymphony.xwork2.ActionSupport;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.process.UserProcess;

/**
 *
 * @author mayank
 */
public class ChangePassAction extends ActionSupport {

    private String password;
    private String epassword;
    private String cpassword; 

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the epassword
     */
    public String getEpassword() {
        return epassword;
    }

    /**
     * @param epassword the epassword to set
     */
    public void setEpassword(String epassword) {
        this.epassword = epassword;
    }

    /**
     * @return the cpassword
     */
    public String getCpassword() {
        return cpassword;
    }

    /**
     * @param cpassword the cpassword to set
     */
    public void setCpassword(String cpassword) {
        this.cpassword = cpassword;
    }

    public String checkPass() {
        UserProcess uproc = new UserProcess();
        HttpSession session = ServletActionContext.getRequest().getSession();
        // Is there a "person" object stored in the person's HttpSession?
        Person per = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (per == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            boolean isPasswordCorrect = uproc.isPasswordCorrect(getEpassword(), per.getLoginId());
            if (isPasswordCorrect) {
                int passUpdated = uproc.changePassword(per.getLoginId(), getPassword());
                if (passUpdated > 0) {
                    try {
                        String fileName = "passchange_mail.html";
                        String contextPath = ServletActionContext.getServletContext().getRealPath("");
                        String filePath = contextPath + "/" + "mail-template";
                        String emailMessage = HtmlUtility.read(filePath, fileName);
                        String emailforlink = SimpleStringCipher.encrypt(per.getEmail());
                        String subject="Password successfully changed ";
                        emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(per.getFirstName()+" "+per.getLastName());
                        emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceFirst(per.getEmail());
                        EmailUtil mail = new EmailUtil();
                        mail.sendEmail("senderemail", per.getEmail(), "", "", subject, emailMessage);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    return Utility.SUCCESS;
                } else {
                    return Utility.ERROR;
                }
            } else {
                clearActionErrors();
                addActionError("Existing password does not matched!");
                return Utility.ERROR;
            }
        }
    }

    @Override
    public void validate() {
        clearFieldErrors();
        if (!Validate.isStringValid(getEpassword(), 8, 16)) {
            addFieldError("epasswordError", getText("registrationPage.passworderror"));
        }
        if (!Validate.isStringValid(getPassword(), 8, 16)) {
            addFieldError("passwordError", getText("registrationPage.passworderror"));
        }
        if (!getPassword().equals(getCpassword()) || getCpassword().equals("")) {
            addFieldError("cpasswordError", getText("registrationPage.cpasswordError"));

        }
    }
}
