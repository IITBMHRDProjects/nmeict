/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.regex.Pattern;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.process.UserProcess;
import org.project.utilities.EmailUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author mayank
 */
public class ValidateEmail extends ActionSupport {

    private String tmpl;
    UserProcess uproc = new UserProcess();

    public String validateEmail() {
        try {
            tmpl = ServletActionContext.getRequest().getParameter("tmpl");
            setTmpl(tmpl);
            String email = SimpleStringCipher.decrypt(getTmpl());
            Person person = uproc.getPerson(email);
            boolean isExist = uproc.isLoginExist(email);
            int isStatusUpdated = uproc.updateLoginStatus(email);
            if (isExist && isStatusUpdated > 0) {
                try {
                    String fileName = "welcome_mail.html";
                    String contextPath = ServletActionContext.getServletContext().getRealPath("");
                    String filePath = contextPath + "/" + "mail-template";
                    String emailMessage = HtmlUtility.read(filePath, fileName);
                    emailMessage = Pattern.compile("#firstname#").matcher(emailMessage).replaceFirst(person.getFirstName()+" "+person.getLastName());
                   // emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceFirst(person.getEmail());
                    emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceFirst(person.getLoginName());
                    EmailUtil mail = new EmailUtil();
                    mail.sendEmail("senderemail", person.getEmail(), "", "", "Welcome to 'Project Name'", emailMessage);
                } catch (Exception e) {
                    e.printStackTrace();
                    return Utility.ERROR;
                }
                return Utility.SUCCESS;
            } else {
                return Utility.ERROR;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Utility.ERROR;
        }
    }

    /**
     * @return the tmp
     */
    public String getTmpl() {
        return tmpl;
    }

    /**
     * @param tmp the tmp to set
     */
    public void setTmpl(String tmp) {
        this.tmpl = tmpl;
    }
}
