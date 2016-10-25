/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.google.common.cache.AbstractCache;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.City;
import org.project.bean.Institute;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;
import org.project.bean.State;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class ViewRemoteCenterAction extends ActionSupport {

    private ArrayList<RemoteCenter> remoteCenter;
    private RemoteCenter rc_details;
    private ArrayList<State> stateList;
    private ArrayList<City> cityList;
    private ArrayList<Institute> instituteList;

    @Override
    public String execute() {
        String rc = "all";
        try {
            /*
             * Getting user session object
             */
            HttpSession session = ServletActionContext.getRequest().getSession();
            String enc_rc = ServletActionContext.getRequest().getParameter("rcid");
            if (!enc_rc.equals("newRC")) {
                SimpleStringCipher cipher = new SimpleStringCipher();
                rc = cipher.decrypt(enc_rc);
            }
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            if (person == null) {
                return Utility.LOGIN_FAILURE;
            } else {
                UtilityProcess process = new UtilityProcess();
                setRemoteCenter(process.listRC());
                if (!rc.equals("all")) {
                    rc_details = process.rc_details(rc);
                    setStateList(process.listStates());
                    setCityList(process.listCity(Integer.parseInt(rc_details.getRc_state())));
                    instituteList=process.listInstitute(Integer.parseInt(rc_details.getRc_city()));
                }
                if (enc_rc.equals("newRC")) {
                    setStateList(process.listStates());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
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
     * @return the city
     */
    public ArrayList<City> getCityList() {
        return cityList;
    }

    /**
     * @param city the city to set
     */
    public void setCityList(ArrayList<City> cityList) {
        this.cityList = cityList;
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
     * @return the remoteCenter
     */
    public ArrayList<RemoteCenter> getRemoteCenter() {
        return remoteCenter;
    }

    /**
     * @param remoteCenter the remoteCenter to set
     */
    public void setRemoteCenter(ArrayList<RemoteCenter> remoteCenter) {
        this.remoteCenter = remoteCenter;
    }

    /**
     * @return the instituteList
     */
    public ArrayList<Institute> getInstituteList() {
        return instituteList;
    }

    /**
     * @param instituteList the instituteList to set
     */
    public void setInstituteList(ArrayList<Institute> instituteList) {
        this.instituteList = instituteList;
    }
}
