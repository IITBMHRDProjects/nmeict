/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import nl.bitwalker.useragentutils.Browser;
import nl.bitwalker.useragentutils.OperatingSystem;
import nl.bitwalker.useragentutils.UserAgent;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.UserDashboard;
import org.project.process.UserProcess;
import org.project.utilities.Utility;

/**
 *
 * @author mayank
 */
public class LoginAction extends ActionSupport {

    private Person person;
    private ArrayList<UserDashboard> dashboard;

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
     * This method is called when user wants to login. This method check the
     * validity of the user.
     *
     * @return String It returns a result string for the action
     * @throws Exception
     */
    public String login() throws Exception {
        UserProcess uproc = new UserProcess();
        Person per = uproc.validateLogin(person.getLoginName().trim(), person.getPassword());
        int roleId;
        if (per != null) {

            // get the dashboard details
//            dashboard = uproc.getDashBoardInfo(person.getLoginName());
            HttpSession session = ServletActionContext.getRequest().getSession();
            session.setAttribute(Utility.USER_HANDLE, per);

            // set user dashboard in session
            // commented as written in home action.
//            session.setAttribute(Utility.USER_DASHBOARD, dashboard);
            //is client behind something?
            String ipAddress = ServletActionContext.getRequest().getHeader("X-FORWARDED-FOR");
            if (ipAddress == null) {
                ipAddress = ServletActionContext.getRequest().getRemoteAddr();
            }
            per.setIpAddress(ipAddress);
            //getting the browser and operating system of the logged in user
            String userAgentString = ServletActionContext.getRequest().getHeader("User-Agent");
            UserAgent userAgent = UserAgent.parseUserAgentString(userAgentString);
            OperatingSystem os = userAgent.getOperatingSystem();
            Browser browser = userAgent.getBrowser();
            uproc.updateLoginTimeStamp(per, browser.getName(), os.getName());
            roleId = per.getRoleId();
            if (roleId == 1) {
                return Utility.SUCCESS;
            } else if (roleId == 5 || roleId == 4 || roleId == 3 || roleId == 2 || roleId > 1000) {
                return Utility.ADMINSUCCESS;
            } else {
                return Utility.SUCCESS;
            }
        } else {
            clearActionErrors();
            addActionError("Invalid user name or password!");
            return Utility.ERROR;
        }

    }

    @Override
    public void validate() {
        clearFieldErrors();
        if (person.getLoginName() == null || person.getLoginName().length() < 1) {
            addFieldError("userName", getText("username.required"));
        }
        if (person.getPassword() == null || person.getPassword().length() < 1) {
            addFieldError("password", getText("password.required"));
        }
    }

    /**
     * @return the dashboard
     */
    public ArrayList<UserDashboard> getDashboard() {
        return dashboard;
    }

    /**
     * @param dashboard the dashboard to set
     */
    public void setDashboard(ArrayList<UserDashboard> dashboard) {
        this.dashboard = dashboard;
    }
}
