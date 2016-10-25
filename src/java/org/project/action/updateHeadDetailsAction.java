/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.HeadDetails;
import org.project.bean.Person;
import org.project.bean.Stream;
import org.project.process.UtilityProcess;
import org.project.utilities.Utility;
import org.project.utilities.Validate;

/**
 *
 * @author asl
 */
public class updateHeadDetailsAction extends ActionSupport {

    private HeadDetails head_details;
    private String idInstitute;
    private String streamId;
    private String typeActive;
    private String typeNotActive;
    private String typeNotApproved;

    public String execute() {
        int result = 0;
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            try {
                UtilityProcess uproc = new UtilityProcess();
                head_details.setInstituteId(Integer.parseInt(getIdInstitute()));
                Stream stream = new Stream();
                stream.setStreamId(Integer.parseInt(streamId));
                head_details.setStream(stream);
                if (head_details.getInstituteId() != 0 && head_details.getStream().getStreamId() !=0) {
                    head_details.setLast_updateby(person.getLoginId());
                    result = uproc.updateHeadDetails(head_details);
                }else{
                  
                }
            } catch (Exception e) {
                result = 0;
                e.printStackTrace();
            }
            if (result > 0) {
                session.setAttribute("result", "success");
            } else {
                session.setAttribute("result", "fail");
            }
        }

        return Utility.SUCCESS;
    }
    
     @Override
    public void validate() {
        
        if (!Validate.isStringValid(head_details.getName().trim(), 2, 30) || !Validate.validateName(head_details.getName().trim())) {
            addFieldError("headNameError", getText("HeadUpdate.hname"));
        }
        
        if (Validate.validateEmail(head_details.getEmail().trim()) == false) {
            addFieldError("headEmailError", getText("HeadUpdate.hemail"));
        }

        if (head_details.getHeadtitle().getHeadTitleId() == -1) {
            addFieldError("headTitleError", getText("HeadUpdate.htitle"));
        }
        if (head_details.getHeaddesignation().getHeadDesignationId() == -1) {
            addFieldError("headDesignationError", getText("HeadUpdate.hdesignation"));
        }
        
         if ((head_details.getHeadaddress().trim().equals("")) || Validate.validateAddress(head_details.getHeadaddress().trim()) == false) {
            addFieldError("headAddressError", getText("registrationPage.addressIsEmpty"));
        }
        
         if (Validate.validatePhoneNumber(head_details.getHeadphone().trim()) == false) {
            addFieldError("headPhoneNumberError", getText("registrationPage.phoneIsEmpty"));
        }
       

        if(getTypeActive().equals("uncheck") && getTypeNotActive().equals("uncheck") && getTypeNotApproved().equals("uncheck")){
          addFieldError("headisActiveError", getText("instituteUpdate.activeType"));
        }
        
      
       
        
    }

    /**
     * @return the head_details
     */
    public HeadDetails getHead_details() {
        return head_details;
    }

    /**
     * @param head_details the head_details to set
     */
    public void setHead_details(HeadDetails head_details) {
        this.head_details = head_details;
    }

    /**
     * @return the idInstitute
     */
    public String getIdInstitute() {
        return idInstitute;
    }

    /**
     * @param idInstitute the idInstitute to set
     */
    public void setIdInstitute(String idInstitute) {
        this.idInstitute = idInstitute;
    }

    /**
     * @return the streamId
     */
    public String getStreamId() {
        return streamId;
    }

    /**
     * @param streamId the streamId to set
     */
    public void setStreamId(String streamId) {
        this.streamId = streamId;
    }

    /**
     * @return the typeActive
     */
    public String getTypeActive() {
        return typeActive;
    }

    /**
     * @param typeActive the typeActive to set
     */
    public void setTypeActive(String typeActive) {
        this.typeActive = typeActive;
    }

    /**
     * @return the typeNotActive
     */
    public String getTypeNotActive() {
        return typeNotActive;
    }

    /**
     * @param typeNotActive the typeNotActive to set
     */
    public void setTypeNotActive(String typeNotActive) {
        this.typeNotActive = typeNotActive;
    }

    /**
     * @return the typeNotApproved
     */
    public String getTypeNotApproved() {
        return typeNotApproved;
    }

    /**
     * @param typeNotApproved the typeNotApproved to set
     */
    public void setTypeNotApproved(String typeNotApproved) {
        this.typeNotApproved = typeNotApproved;
    }

}
