/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;
import org.project.process.UtilityProcess;
import org.project.utilities.FileUtil;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class UpdateRemoteCenterAction extends ActionSupport {

    private RemoteCenter rc_details;
    private int result;
    private File rcLogo;

    @Override
    public String execute() {
        try {
            /*
             * Getting user session object
             */
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            if (person == null) {
                return Utility.LOGIN_FAILURE;
            } else {
                UtilityProcess uprocess = new UtilityProcess();
                rc_details.setLast_updatedby(person.getLoginId());
                if (rc_details.getIsnew() == 0) {
                    result = uprocess.updateRCDetails(rc_details);
                    if (result > 0) {

                        try {
                            String context = ServletActionContext.getServletContext().getRealPath("");
                            FileUtil.saveFile(getRcLogo(), rc_details.getRemoteCenterId() + ".png", context + File.separator + "certificate_templates/logo");
                        } catch (Exception e) {
                        }

                        return Utility.SUCCESS;
                    }
                }
                if (rc_details.getIsnew() == 1) {
                    result = uprocess.insertRCDetails(rc_details);
                    if (result > 0) {
                        try {
                            String context = ServletActionContext.getServletContext().getRealPath("");
                            FileUtil.saveFile(getRcLogo(), "logo_" + rc_details.getRemoteCenterId() + ".png", context + File.separator + "certificate_templates/logo");
                        } catch (Exception e) {
                        }
                        return Utility.SUCCESS;
                    } else {
                        addActionError("Insertion Error. Please try with unique remote center id");
                        return Utility.ERROR;
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    /**
     * @return the rc_details
     */
    public RemoteCenter getRc_details() {
        return rc_details;
    }

    /**
     * @param rc_details the rc_details to set
     */
    public void setRc_details(RemoteCenter rc_details) {
        this.rc_details = rc_details;
    }

    /**
     * @return the result
     */
    public int getResult() {
        return result;
    }

    /**
     * @param result the result to set
     */
    public void setResult(int result) {
        this.result = result;
    }

    /**
     * @return the rcLogo
     */
    public File getRcLogo() {
        return rcLogo;
    }

    /**
     * @param rcLogo the rcLogo to set
     */
    public void setRcLogo(File rcLogo) {
        this.rcLogo = rcLogo;
    }
}
