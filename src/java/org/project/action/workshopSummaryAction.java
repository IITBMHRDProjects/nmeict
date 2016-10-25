/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.text.ParseException;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.Summary;
import org.project.process.UtilityProcess;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class workshopSummaryAction extends ActionSupport {

    private ArrayList<Summary> summary;

    public String execute() throws ParseException {

        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            String start_date = ServletActionContext.getRequest().getParameter("sd");
            String end_date = ServletActionContext.getRequest().getParameter("ed");
            if (start_date.equals(null) || start_date.equals("")) {
                start_date = "none";
            }
            if (end_date.equals(null) || end_date.equals("")) {
                end_date = "none";
            }
            UtilityProcess uproc = new UtilityProcess();
            summary = uproc.getWorkshopSummaryReport(start_date, end_date);
            return Utility.SUCCESS;
        }
    }

    public String getRcWiseReoprt() throws ParseException{
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            String start_date = ServletActionContext.getRequest().getParameter("sd");
            String end_date = ServletActionContext.getRequest().getParameter("ed");
            if (start_date.equals(null) || start_date.equals("")) {
                start_date = "none";
            }
            if (end_date.equals(null) || end_date.equals("")) {
                end_date = "none";
            }

            UtilityProcess uproc = new UtilityProcess();
            summary = uproc.getRCWiseReport(start_date, end_date);
            return Utility.SUCCESS;
        }
    }

    public String getStateWiseReoprt() throws ParseException{
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            String start_date = ServletActionContext.getRequest().getParameter("sd");
            String end_date = ServletActionContext.getRequest().getParameter("ed");
            if (start_date.equals(null) || start_date.equals("")) {
                start_date = "none";
            }
            if (end_date.equals(null) || end_date.equals("")) {
                end_date = "none";
            }
            UtilityProcess uproc = new UtilityProcess();
            summary = uproc.getStateWiseSummaryReport(start_date, end_date);
            return Utility.SUCCESS;
        }
    }

    /**
     * @return the summary
     */
    public ArrayList<Summary> getSummary() {
        return summary;
    }

    /**
     * @param summary the summary to set
     */
    public void setSummary(ArrayList<Summary> summary) {
        this.summary = summary;
    }
}
