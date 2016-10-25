/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.project.process.UserProcess;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class UnsubscribeAction extends ActionSupport {

    public String execute() {
        String email = ServletActionContext.getRequest().getParameter("ide").trim();
        if (email == null || email == "") {
            addActionMessage("Your email is not found");
        } else {
            UserProcess uproc = new UserProcess();
            Boolean ifUnsubscribed = uproc.unsubscribe(email);
            if (ifUnsubscribed) {
                addActionMessage("You have un-subscribed from our mailing list.");
            } else {
                addActionMessage("Your email is not registered with our website");
            }
        }
        return Utility.SUCCESS;

    }
}
