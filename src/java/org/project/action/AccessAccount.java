/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.process.UtilityProcess;
import org.project.process.UserProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;
import org.project.utilities.EmailUtil;
import org.project.utilities.Validate;
import org.project.utilities.HtmlUtility;
import com.opensymphony.xwork2.ActionSupport;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import nl.captcha.Captcha;
import org.apache.struts2.ServletActionContext;


/**
 *
 * @author mayank
 */
public class AccessAccount extends ActionSupport {

    private String email;
    private String captchaText;
    UserProcess uproc = new UserProcess(); 

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
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

    public String checkEmail() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        UtilityProcess util = new UtilityProcess();

        if (uproc.isLoginEmailAvailable(getEmail().trim()) == false) {
            session.setAttribute("validateError", "notinlogin");
            return Utility.SUCCESS;
        }
        if (uproc.getLoginStatus(getEmail().trim()) <= 0) {
            session.setAttribute("validateError", "notverify");
            return Utility.SUCCESS;
        }

        try {
            String fileName = "ForgotPassword_mail.html";
            String contextPath = ServletActionContext.getServletContext().getRealPath("");
            String filePath = contextPath + "/" + "mail-template";
            String emailMessage = HtmlUtility.read(filePath, fileName);
            String link = getText("contextLink") + "/tempPassword.html?tmpl=";
            String emailSecured = SimpleStringCipher.encrypt(getEmail().trim());
            String linkToSend = link + emailSecured;
            emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(util.getFirstName(getEmail()));
            emailMessage = Pattern.compile("#link#").matcher(emailMessage).replaceFirst(linkToSend);

            EmailUtil mail = new EmailUtil();
            mail.sendEmail("senderemail", getEmail().trim(), "", "", "Reset password link ", emailMessage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.setAttribute("validateError", "success");
        return Utility.SUCCESS;
    }

    @Override
    public void validate() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
        clearFieldErrors();
        if (Validate.validateEmail(getEmail().trim()) == false) {
            addFieldError("emailError", getText("emailError"));
        }
        if (uproc.isEmailAvailable(getEmail().trim()) == false) {
            addFieldError("emailNotAvailableError", getText("emailnotAvaliable"));
        }
        if (getCaptchaText() == null || !captcha.isCorrect(getCaptchaText())) {
            addFieldError("captchaError", getText("captchaError"));
        }
    }
}
