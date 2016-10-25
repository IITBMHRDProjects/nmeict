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
public class TempPasswordAction extends ActionSupport {

    private String tmpl;
    private String password;
    private String cpassword;

    /**
     * @return the tmpl
     */
    public String getTmpl() {
        return tmpl;
    }

    /**
     * @param tmpl the tmpl to set
     */
    public void setTmpl(String tmpl) {
        this.tmpl = tmpl;
    }

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

    public String updatePass() {
        try {
            UserProcess uproc = new UserProcess();
            String email = SimpleStringCipher.decrypt(getTmpl());
            Person person = uproc.getPerson(email);
            boolean isExist = uproc.isLoginExist(email);
            if (isExist) {
                int passUpdated = uproc.updatePassword(getPassword(), email);
                if (passUpdated > 0) {
                    try {
                        String fileName = "passchange_mail.html";
                        String contextPath = ServletActionContext.getServletContext().getRealPath("");
                        String filePath = contextPath + "/" + "mail-template";
                        String emailMessage = HtmlUtility.read(filePath, fileName);
                        String emailforlink = SimpleStringCipher.encrypt(person.getLoginName());
                        emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(person.getFirstName()+" "+person.getLastName());
                        emailMessage = Pattern.compile("#email#").matcher(emailMessage).replaceFirst(person.getLoginName());
                        EmailUtil mail = new EmailUtil();
                        mail.sendEmail("senderemail", email, "", "", "Password successfully changed", emailMessage);
                        return Utility.SUCCESS;
                    } catch (Exception e) {
                        e.printStackTrace();
                        return Utility.ERROR;
                    }

                } else {
                    return Utility.ERROR;
                }
            } else {
                return Utility.ERROR;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Utility.ERROR;
        }
    }

    @Override
    public void validate() {
    }
}
