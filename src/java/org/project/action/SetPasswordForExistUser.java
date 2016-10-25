/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import nl.captcha.Captcha;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.EmailUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;
import org.project.utilities.Validate;

/**
 *
 * @author asl
 */
public class SetPasswordForExistUser extends ActionSupport {

    private String email;
    private String captchaText;
    UserProcess uproc = new UserProcess();
    private Person person;
    HttpSession session = null;

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

    public String execute() {
        UtilityProcess process = new UtilityProcess();
        session = ServletActionContext.getRequest().getSession();
        boolean emailexist = false;
        int id = 0;
        try {
            person = uproc.getPerson(email);
            if (person.getLoginName() != null) {
                session.setAttribute("result", "false");
            } else if (person.getLoginName() == null) {
                emailexist = uproc.isEmailAvailable(email);
                String name  = process.getFirstName(email);
                if (emailexist == true) {
                    try {
                        id = process.getUserIdOfParticipant(email); 
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if(id > 0){
                        checkEmail(email, id,name);
                        session.setAttribute("result", "true");
                    }
                } else if (emailexist == false) {
                    session.setAttribute("result", "newUser");
                }
            }
        } catch (Exception e) {

        }

        return SUCCESS;
    }
    
      public String checkEmail(String email,int cid ,String name) {
        try {
            String fileName = "tempPasswordForExistUser.html";
            String contextPath = ServletActionContext.getServletContext().getRealPath("");
            String filePath = contextPath + "/" + "mail-template";
            String emailMessage = HtmlUtility.read(filePath, fileName);
            String subject="Account and Password creation initiated";
            String emailSecured = SimpleStringCipher.encrypt(email);
            String cidSecured = SimpleStringCipher.encrypt(String.valueOf(cid));
            String link = getText("contextLink") + "/createPassword.html?tmpl="+emailSecured+"&tmpl2="+cidSecured;
            String linkToSend = link;
            emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(name);
            emailMessage = Pattern.compile("#link#").matcher(emailMessage).replaceFirst(linkToSend);
            EmailUtil mail = new EmailUtil();
            mail.sendEmail("senderemail", getEmail(), "", "", subject, emailMessage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    public static void main(String[] args) {
        SetPasswordForExistUser obj_existUser = new SetPasswordForExistUser();
        obj_existUser.execute();
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
}
