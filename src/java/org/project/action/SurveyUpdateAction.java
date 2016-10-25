/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;
import org.project.bean.SurveyForm;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;
import org.project.utilities.Validate;

/**
 *
 * @author asl
 */
public class SurveyUpdateAction extends ActionSupport {
private SurveyForm surveyform;
    

    public String execute() throws Exception {
        int result=0;
         setSurveyform(surveyform);
         HttpSession session = ServletActionContext.getRequest().getSession();
         UtilityProcess process=new UtilityProcess();
         try{
            //result= process.insertSurveyDetails(surveyform);
         }catch(Exception e){
         result=0;
         }
         
          if (result > 0) {
                session.setAttribute("result", "success");
            } else {
                session.setAttribute("result", "fail");
            }
        
        return SUCCESS;
    }
    
      @Override
    public void validate() {
        
        if(surveyform.getRemotecenter().getRemoteCenterId() == -1){
          addFieldError("remotecenterError", getText("workshopRegistrationForm.remotecenterError"));
        }
        if (Validate.validateEmail(surveyform.getEmail()) == false) {
            addFieldError("emailError", getText("registrationPage.emailerror"));
        }
        
        if(surveyform.getField1() == null || surveyform.getField1().trim() == ""){
          addFieldError("checkboxError","Please Select Any Option");
        }
        
        if(surveyform.getField2().equals("-1")){
          addFieldError("selectError","Please Select Any Option");
        }
        System.out.println(surveyform.getField3());
        if(surveyform.getField3() == null || surveyform.getField3().trim().length() == 0){
          addFieldError("txtboxError","Please Enter Answer");
        }
        if(surveyform.getField4() == null || surveyform.getField4().trim() == ""){
          addFieldError("yesnoError","Please Select Yes / No.");
        }
    }

    

    /**
     * @return the surveyform
     */
    public SurveyForm getSurveyform() {
        return surveyform;
    }

    /**
     * @param surveyform the surveyform to set
     */
    public void setSurveyform(SurveyForm surveyform) {
        this.surveyform = surveyform;
    }

  
}
