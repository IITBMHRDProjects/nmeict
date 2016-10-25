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
public class viewSummaryAction extends ActionSupport {

    private ArrayList<Summary> summary;
    private ArrayList<Person> notregdata;

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
            summary = uproc.getSummaryReport(start_date, end_date);
            return Utility.SUCCESS;
        }
    }

    public String GetDetailsOfLoginButNotRegister() {
        try {
            UtilityProcess uproc = new UtilityProcess();
            notregdata = uproc.getdataLoginButNotReg();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
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

    /**
     * @return the notregdata
     */
    public ArrayList<Person> getNotregdata() {
        return notregdata;
    }

    /**
     * @param notregdata the notregdata to set
     */
    public void setNotregdata(ArrayList<Person> notregdata) {
        this.notregdata = notregdata;
    }

}
