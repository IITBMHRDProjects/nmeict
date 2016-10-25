/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import org.apache.struts2.StrutsStatics;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class LoginInterceptor {
    
//    String HTTP_REQUEST=org.apache.struts2.StrutsStatics.HTTP_REQUEST;
    
     public LoginInterceptor() {}

    public void destroy() {
        Utility.log("Login interceptor destroyed");
    }

    public void init() {
        Utility.log("Login interceptor initialized");
    }

    public String intercept(ActionInvocation actionInvocation) throws Exception {
        // Get the action context from the invocation so we can access the
        // HttpServletRequest and HttpSession objects.
        final ActionContext context = actionInvocation.getInvocationContext();      
        HttpServletRequest request = (HttpServletRequest) context.get(StrutsStatics.HTTP_REQUEST);
        HttpSession session = request.getSession(true);
        // Is there a "user" object stored in the user's HttpSession?
        Object user = session.getAttribute(Utility.USER_HANDLE);
        if (user == null) {
            // The user has not logged in yet.
            // and we need to send the login form.
            return Utility.LOGIN_FAILURE;
        } else {
            return actionInvocation.invoke();
        }
    }
}
