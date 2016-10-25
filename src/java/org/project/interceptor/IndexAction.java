/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.interceptor;

import com.googlecode.sslplugin.annotation.Secured;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *
 * @author asl
 */
@Secured
public class IndexAction extends ActionSupport {

    // configure the logger for this class
    private static Log log = LogFactory.getLog(IndexAction.class);

    /**
     * This method is called in https mode, as it has the
     *
     * @Secured annotation in class level.
     *
     * @return
     * @throws Exception
     */
    public String execute() throws Exception {
        log.info("Inside execute() method");
        return SUCCESS;
    }

    /**
     * This method is called in https mode, as it has the
     *
     * @Secured annotation in class level.
     *
     * @return
     * @throws Exception
     */
    public String execute1() throws Exception {
        log.info("Inside execute1() method");
        return SUCCESS;
    }
}
