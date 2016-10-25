/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import java.util.*;
import java.util.regex.Pattern;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.process.UserProcess;

/**
 *
 * @author mayank
 */
public class SendMail {

    public void sendMailToSpecificUsers() {
        String email = "Mention Email here";
        try {
            String fileName = "passwordChange_Mail.html";
            String contextPath = ServletActionContext.getServletContext().getRealPath("");
            String filePath = contextPath + "/" + "mail-template";
            String emailMessage = HtmlUtility.read(filePath, fileName);
            String link = "http://path/tempPassword.html?tmpl=";
            String emailSecured = SimpleStringCipher.encrypt(email);
            String linkToSend = link + emailSecured;
            emailMessage = Pattern.compile("#link#").matcher(emailMessage).replaceFirst(linkToSend);
            EmailUtil mail = new EmailUtil();
            mail.sendEmail("senderemail", email, "", "", "Welcome to 'Project Name' : Change password", emailMessage);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void main(String args[]) {
        
        //Code for mail to specific users
        SendMail sMail = new SendMail();
        sMail.sendMailToSpecificUsers();
        
        //code for mail sending to bulk users
        UserProcess process = new UserProcess();
        ArrayList list = process.getEmailIds();
        if (list != null && list.size() > 0) {
            try {
                System.out.println("The size is : " + list.size());
                for (int i = 0; i < list.size(); i++) {
                    Person person = (Person) list.get(i);
                    System.out.println(person.getEmail());
                    String fileName = "passwordChange_Mail.html";
                    String contextPath = ServletActionContext.getServletContext().getRealPath("");
                    String filePath = contextPath + "/" + "mail-template";
                    String emailMessage = HtmlUtility.read(filePath, fileName);
                    String link = "http://path/tempPassword.html?tmpl=";
                    String emailSecured = SimpleStringCipher.encrypt(person.getEmail());
                    String linkToSend = link + emailSecured;
                    emailMessage = Pattern.compile("#link#").matcher(emailMessage).replaceFirst(linkToSend);
                    EmailUtil mail = new EmailUtil();
                    mail.sendEmail("senderemail", person.getEmail(), "", "", "Welcome to 'Project Name' : Change password", emailMessage);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}