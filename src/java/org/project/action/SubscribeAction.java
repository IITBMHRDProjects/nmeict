/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.process.UserProcess;
import org.project.utilities.Utility;

/**
 *
 * @author abinaya
 */
public class SubscribeAction extends ActionSupport {

    private Person person;

    public String execute() {
        String email = ServletActionContext.getRequest().getParameter("ide").trim();
        if (email == null || email == "") {
            addActionMessage("Your email is not found");
        } else {

            UserProcess uproc = new UserProcess();
            int if_already_subscribed = uproc.ifSubscribedUser(email);
            if (if_already_subscribed == 1) {
                addActionMessage("You have already subscribed to our mailing list.");
            } else {
                Boolean ifSubscribed = uproc.subscribe(email);
                if (ifSubscribed) {
                    addActionMessage("You have successfully subscribed to our mailing list.");
                } else {
                    addActionError("Your email is not registered with our website");
                }
            }
        }
        return Utility.SUCCESS;

    }

    public String doSubscribe() {
        String email = person.getLoginName();
        if (email == null || email == "") {
            addActionMessage("Your email is not found.");
        } else {
            UserProcess uproc = new UserProcess();
            int if_already_subscribed = uproc.ifSubscribedUser(person.getLoginName());
            if (if_already_subscribed == 1) {
                addActionMessage("You have already been subscribed to our website.");
            } else {
                Boolean ifSubscribed = uproc.subscribe(email);
                if (ifSubscribed) {
                    addActionMessage("You have been subscribed successfully to our website.");
                } else {
                    addActionError("Your email is not registered with our website.");
                }
            }
        }
        return Utility.SUCCESS;

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
}
