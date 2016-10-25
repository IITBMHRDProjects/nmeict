/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.utilities.Utility;

/**
 *
 * @author mayank
 */
public class LogoutAction extends ActionSupport {
    /**
     * This method is called when user wants to logout. This method clear session of the user.
     * @return String It returns a result string for the action
     * @throws Exception 
     */
    public String logout() throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        if(session != null) {
            session.removeAttribute(Utility.USER_HANDLE);
            session.invalidate();
        }
        return Utility.SUCCESS;
    }
}
