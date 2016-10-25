/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.StrutsStatics;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class LoggerInterceptor {
     public LoggerInterceptor() {
    }
    
    public void destroy() {
        Utility.log("Logger interceptor destroyed");
    }

    public void init() {
        Utility.log("Logger interceptor initialized");
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
        
        System.out.println("Hello I have been called in logger.");
        return actionInvocation.invoke();
    }
}
