/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.SurveyForm;
import org.project.process.UtilityProcess;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class viewSurveyDetailsAction extends ActionSupport{
    private ArrayList<SurveyForm> surveyform; 
    public String execute(){
         String result="";
        UtilityProcess process=null;
        HttpSession session = ServletActionContext.getRequest().getSession();
       
        
        // String rc = cipher.decrypt(enc_instituteid);
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            try{
                process=new UtilityProcess();
               // surveyform=process.getAllSurveyData();
             }catch(Exception e){
            }
        }
     return Utility.SUCCESS;
    }

    /**
     * @return the surveyform
     */
    public ArrayList<SurveyForm> getSurveyform() {
        return surveyform;
    }

    /**
     * @param surveyform the surveyform to set
     */
    public void setSurveyform(ArrayList<SurveyForm> surveyform) {
        this.surveyform = surveyform;
    }
}
