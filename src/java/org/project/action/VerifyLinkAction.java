/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import nl.captcha.Captcha;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.process.UserProcess;
import org.project.utilities.EmailUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Validate;

/**
 *
 * @author asl
 */
public class VerifyLinkAction extends ActionSupport {

    private String email;
    private String captchaText;
    private Person person;
    private UserProcess uproc = new UserProcess();
    HttpSession session;

    public String execute() {
        session = (HttpSession) ServletActionContext.getRequest().getSession();
        int loginStatus = 0;
        try {
            person = uproc.getPerson(email.trim());
            if (person.getLoginName() != null) {
                loginStatus = uproc.getLoginStatus(email.trim());
                if (loginStatus > 0) {
                    session.setAttribute("result", "Status Already One");
                } else if (loginStatus <= 0) {
                    //person = uproc.getPerson(email);
                    checkMail(email.trim(), person.getFirstName()+" "+person.getLastName());
                    session.setAttribute("result", "Success");
                }
            } else if (person.getLoginName() == null) {
                session.setAttribute("result", "Status Error");
            }
        } catch (Exception e) {
            session.setAttribute("result", "Status Error");
            e.printStackTrace();
        }

        return SUCCESS;
    }

    public void checkMail(String email, String name) {
        email=email.trim();
        try {
            String fileName = "signup_mail.html";
            String contextPath = ServletActionContext.getServletContext().getRealPath("");
            String filePath = contextPath + "/" + "mail-template";
            String emailMessage = HtmlUtility.read(filePath, fileName);
            String verification_link = getText("contextLink") + "/validateEmail.html?tmpl=";
            String emailforlink = SimpleStringCipher.encrypt(email);
            String confirmation_link = verification_link + emailforlink;
            emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(name);
            emailMessage = Pattern.compile("#link1#").matcher(emailMessage).replaceAll(confirmation_link);
            EmailUtil mail = new EmailUtil();
            mail.sendEmail("senderemail", email, "", "", "Account creation initiated", emailMessage);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void validate() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
        clearFieldErrors();
        if (Validate.validateEmail(getEmail()) == false) {
            addFieldError("emailError", getText("emailError"));
        }
        if (uproc.isEmailAvailable(getEmail()) == false) {
            addFieldError("emailNotAvailableError", getText("emailnotAvaliable"));
        }
        if (getCaptchaText() == null || !captcha.isCorrect(getCaptchaText())) {
            addFieldError("captchaError", getText("captchaError"));
        }
    }

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
     * @return the uproc
     */
}
