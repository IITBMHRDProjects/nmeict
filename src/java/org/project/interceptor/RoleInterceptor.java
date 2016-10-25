/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.StrutsStatics;
import org.project.bean.Person;
import org.project.bean.Role;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class RoleInterceptor {
     private static final String USER_HANDLE = "loggedInUser";

    public RoleInterceptor() {
    }

    public void destroy() {
        Utility.log("Role interceptor destroyed");
    }

    public void init() {
        Utility.log("Role interceptor initialized");
    }

    public String intercept(ActionInvocation actionInvocation) throws Exception {
        // Get the action context from the invocation so we can access the
        // HttpServletRequest and HttpSession objects.
        final ActionContext context = actionInvocation.getInvocationContext();
        HttpServletRequest request = (HttpServletRequest) context.get(StrutsStatics.HTTP_REQUEST);
        HttpSession session = request.getSession(true);
        /*
         * get all the parameters of this action
         */
        Map<String, String> params = actionInvocation.getProxy().getConfig().getParams();
        // Is there a "user" object stored in the user's HttpSession?
        Person user = (Person) session.getAttribute(USER_HANDLE);
        if (user == null) {
            // The user has not logged in yet.
            // and we need to send the login form.
            request.setAttribute("errorMessage", Utility.LOGIN_FAILURE);
            return Utility.LOGIN_FAILURE;
        } else if (user != null) {
            String activity = "";
            boolean isAuthorized = false;
            if (params != null) {
                activity = params.get("activity");
                try {
                    int activityId = Integer.parseInt(activity);
                /*    Person role = user.getRoleId();
                    Set<RoleActivityMap> roleActivityMap = role.getRoleActivityMaps();
                    for (RoleActivityMap value : roleActivityMap) {
                        if (value.getActivity().getActivityId() == activityId) {
                            isAuthorized = true;
                        }
                    } */
                } catch (Exception e) {
                    request.setAttribute("errorMessage", Utility.ROLE_FAILURE);
                    return Utility.ROLE_FAILURE;
                }
            } else {
                isAuthorized = false;
            }
            if (isAuthorized) {    /* if user is authorized to perform this action */
                return actionInvocation.invoke();
            } else {    /* else user is not authorized */
                request.setAttribute("errorMessage", Utility.ROLE_FAILURE);
                return Utility.ROLE_FAILURE;
            }
        } else {
            request.setAttribute("errorMessage", Utility.ROLE_FAILURE);
            return Utility.ROLE_FAILURE;
        }
    }
}
