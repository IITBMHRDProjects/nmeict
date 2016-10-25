/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.process.UtilityProcess;
import org.project.utilities.FileUtil;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class UpdateMailContentAction extends ActionSupport {

    private File mailContent;
    private String mailContentContentType;
    private String mailContentFileName;
    private String mail_filename;
    private Person person;

    public String updateMailContent() {
        try {
            String context = ServletActionContext.getServletContext().getRealPath("");
            HttpSession session = ServletActionContext.getRequest().getSession();
            person = (Person) session.getAttribute(Utility.USER_HANDLE);
            int userId = person.getLoginId();
            UtilityProcess process = new UtilityProcess();
            if (mailContentFileName.trim() != "" || mailContentFileName.trim() != null) {
                // FileUtil.saveFile(getMailContent(), mailContentFileName.trim(), context + File.separator + "mail-template");
                 FileUtil.saveFile(getMailContent(), mail_filename.trim(), context + File.separator + "mail-template");
                
                 
                 /**
                  * 
                  * code for stored details of user who updated the data 
                  */
                 /*try {
                    int result = process.update_MailContent(mail_filename, userId);
                    if (result > 0) {
                    }
                } catch (Exception e) {

                }*/
                session.setAttribute("result", "success");
            } else {
                session.setAttribute("result", "fail");
            }
        } catch (Exception e) {
        }
        return SUCCESS;
    }

    /**
     * @return the mailContent
     */
    public File getMailContent() {
        return mailContent;
    }

    /**
     * @param mailContent the mailContent to set
     */
    public void setMailContent(File mailContent) {
        this.mailContent = mailContent;
    }

    /**
     * @return the mailContentContentType
     */
    public String getMailContentContentType() {
        return mailContentContentType;
    }

    /**
     * @param mailContentContentType the mailContentContentType to set
     */
    public void setMailContentContentType(String mailContentContentType) {
        this.mailContentContentType = mailContentContentType;
    }

    /**
     * @return the mailContentFileName
     */
    public String getMailContentFileName() {
        return mailContentFileName;
    }

    /**
     * @param mailContentFileName the mailContentFileName to set
     */
    public void setMailContentFileName(String mailContentFileName) {
        this.mailContentFileName = mailContentFileName;
    }

    /**
     * @return the mail_filename
     */
    public String getMail_filename() {
        return mail_filename;
    }

    /**
     * @param mail_filename the mail_filename to set
     */
    public void setMail_filename(String mail_filename) {
        this.mail_filename = mail_filename;
    }
}
