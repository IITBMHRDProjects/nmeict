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
import org.project.bean.City;
import org.project.bean.Institute;
import org.project.bean.Person;
import org.project.bean.State;
import org.project.process.UtilityProcess;
import org.project.utilities.Utility;
import org.project.utilities.Validate;

/**
 *
 * @author asl
 */
public class UpdateInstituteAction extends ActionSupport {

    private Institute institute;
    private ArrayList<State> stateList;
    private ArrayList<City> cityList;
    private String idInstitute;
    private String typeActive;
    private String typeNotActive;
    private String typeNotApproved;

    public String updateInstitue() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess uproc = new UtilityProcess();
            int result = 0;
            institute.setInstituteId(Integer.parseInt(idInstitute));
            institute.setLast_updatedby(person.getLoginId());
            try {
                if(institute.getInstituteId() != 0){
                result=uproc.updateInstituteDetails(institute);
                }
            } catch (Exception e) {
                result = 0;
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
        if (idInstitute.trim().length() < 1 && idInstitute.trim() == null) {
            addFieldError("instituteidError", getText("instituteUpdate.instituteIdError"));
        }
        if (!Validate.validateInstitute(institute.getInstituteName())) {
            addFieldError("instituteNameError", getText("instituteUpadate.instituteNameError"));
        }

        if (institute.getState().getStateId() == -1) {
            addFieldError("instituteStateError", getText("registrationPage.personStateError"));
        }
        if (institute.getCity().getCityId() == -1) {
            addFieldError("perCityError", getText("registrationPage.personCityError"));
        }

        if(typeActive.equals("uncheck") && typeNotActive.equals("uncheck") && typeNotApproved.equals("uncheck")){
          addFieldError("instituteisActiveError", getText("instituteUpdate.activeType"));
        }
        
        if (institute.getIsActive() == 1) {
            if (!Validate.isStringValid(institute.getInstituteAddress(), 5, 430) || !Validate.validateAddress(institute.getInstituteAddress())) {
                addFieldError("instituteAddressError", getText("registrationPage.addressIsEmpty"));
            }
            if (Validate.validatePincode(String.valueOf(institute.getPincode())) == false) {
                addFieldError("institutePincodeError", getText("registrationPage.pincodeEmptyError"));
            }
        } else if (institute.getIsActive() != 1) {
            if (institute.getInstituteAddress().trim().length() > 0) {
                if (!Validate.isStringValid(institute.getInstituteAddress(), 5, 430) || !Validate.validateAddress(institute.getInstituteAddress())) {
                    addFieldError("instituteAddressError", getText("registrationPage.addressIsEmpty"));
                }
            }
            if (institute.getPincode() > 0) {
                if (Validate.validatePincode(String.valueOf(institute.getPincode())) == false) {
                    addFieldError("institutePincodeError", getText("registrationPage.pincodeEmptyError"));
                }
            }
        }
    } 

    /**
     * @return the institute
     */
    public Institute getInstitute() {
        return institute;
    }

    /**
     * @param institute the institute to set
     */
    public void setInstitute(Institute institute) {
        this.institute = institute;
    }

    /**
     * @return the stateList
     */
    public ArrayList<State> getStateList() {
        return stateList;
    }

    /**
     * @param stateList the stateList to set
     */
    public void setStateList(ArrayList<State> stateList) {
        this.stateList = stateList;
    }

    /**
     * @return the cityList
     */
    public ArrayList<City> getCityList() {
        return cityList;
    }

    /**
     * @param cityList the cityList to set
     */
    public void setCityList(ArrayList<City> cityList) {
        this.cityList = cityList;
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
