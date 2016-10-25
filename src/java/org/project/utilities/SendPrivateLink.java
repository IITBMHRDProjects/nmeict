/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import java.util.regex.Pattern;

/**
 *
 * @author asl
 */
public class SendPrivateLink {

    String fileName = "";
    String subject = "";
    String type = "";

    public int sendPrivateLinkToUser(int userid, String context, String email) {
        int res = 0;
        try {
            String fileName = "register_private_link.html";
            String filePath = context + "/" + "mail-template";
            subject="You have been invited to register for the Blended MOOCs workshop ";
            String emailMessage = HtmlUtility.read(filePath, fileName);
            String idforlink = SimpleStringCipher.encrypt(String.valueOf(userid));
             emailMessage = Pattern.compile("#userid#").matcher(emailMessage).replaceAll(idforlink);
            EmailUtil mail = new EmailUtil();
//                    commented for not sending mail to coordinators while testing from test server.
            mail.sendEmail("senderemail", email, "senderemail", "", subject, emailMessage);
            System.out.println(emailMessage);
            res=1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

}
