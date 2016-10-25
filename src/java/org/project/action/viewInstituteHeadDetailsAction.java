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
import org.project.bean.HeadDetails;
import org.project.bean.Institute;
import org.project.bean.Person;
import org.project.bean.State;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class viewInstituteHeadDetailsAction extends ActionSupport{
    private Institute institute;
    private ArrayList<State> stateList;
    private ArrayList<City> cityList;
    private ArrayList<HeadDetails> headdetails;
    
    public String execute(){
        String result="";
        UtilityProcess process=null;
        HttpSession session = ServletActionContext.getRequest().getSession();
        String enc_instituteid = ServletActionContext.getRequest().getParameter("instituteid");
        SimpleStringCipher cipher = new SimpleStringCipher();
        // String rc = cipher.decrypt(enc_instituteid);
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            try{
                process=new UtilityProcess();
                setHeaddetails(process.listHeadDetails(Integer.parseInt(enc_instituteid)));
                institute=process.instituteDetails(Integer.parseInt(enc_instituteid));
            }catch(Exception e){
            }
        }
        
        return Utility.SUCCESS; 
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
     * @return the headdetails
     */
    public ArrayList<HeadDetails> getHeaddetails() {
        return headdetails;
    }

    /**
     * @param headdetails the headdetails to set
     */
    public void setHeaddetails(ArrayList<HeadDetails> headdetails) {
        this.headdetails = headdetails;
    }

  
}
