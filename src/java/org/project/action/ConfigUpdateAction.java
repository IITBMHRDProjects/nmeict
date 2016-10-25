/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.City;
import org.project.bean.Lookups;
import org.project.bean.Person;
import org.project.bean.State;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class ConfigUpdateAction extends ActionSupport {

    private ArrayList<Lookups> lookups;
    private Person person_role;
    private Lookups lookUpDetail;
    private int isNewConfig = 0;
    private ArrayList<City> city;
    private City cityDetail;
    private ArrayList<State> stateList;

    public String getRoles() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = new Person();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess util = new UtilityProcess();
            setLookups(util.list_Roles());
            return Utility.SUCCESS;
        }
    }

    public String updateUserRole() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = new Person();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess util = new UtilityProcess();
//            setLookups(util.list_Roles());
            // update role 
            int result = util.updateUserRole(person_role);
            if (result > 0) {
                addActionError("Role Updated Successfully!");
            }
            return Utility.SUCCESS;
        }
    }

    public String viewConfigTableData() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = new Person();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess util = new UtilityProcess();
//            setLookups(util.list_Roles());
            // update role 
            lookups = util.listConfigTables();
            return Utility.SUCCESS;
        }
    }

    public String viewParticularConfigDetail() throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        String id_encrypted = ServletActionContext.getRequest().getParameter("id");
        Person person = new Person();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess util = new UtilityProcess();
            String lookup_id = "";
            if (id_encrypted.equals("newConfig")) {
                lookUpDetail = new Lookups();
                setIsNewConfig(1);
            } else {
                SimpleStringCipher cipher = new SimpleStringCipher();
                lookup_id = cipher.decrypt(id_encrypted);
                lookUpDetail = util.listConfigDetail(lookup_id);
                setIsNewConfig(0);
            }
            lookups = (util.listConfigTables());
            return Utility.SUCCESS;
        }
    }

    public String updateConfigTable() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = new Person();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess util = new UtilityProcess();
//            setLookups(util.list_Roles());
            // update role 
            int result = util.updateConfigTable(lookUpDetail);
            if (result > 0) {
//                addActionError("Data Updated Successfully!");
            }
            if (result == 0) {
                addActionError("Error. Please try creating new entry with distinct code and category combination");
            }
            return Utility.SUCCESS;
        }
    }

    public String viewCity() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = new Person();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess util = new UtilityProcess();
//            setLookups(util.list_Roles());
            // update role 
            setCity(util.listAllCities());
            return Utility.SUCCESS;
        }
    }

    public String viewParticularCityDetail() throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        String id = ServletActionContext.getRequest().getParameter("id");
        Person person = new Person();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess util = new UtilityProcess();
            String lookup_id = "";
            if (id.equals("newCity")) {
                lookUpDetail = new Lookups();
                setIsNewConfig(1);
            } else {
                cityDetail = util.listCityDetail(id);
                setIsNewConfig(0);
            }
            stateList = util.listStates();
            lookups = (util.listConfigTables());
            return Utility.SUCCESS;
        }
    }

    public String updateCityTable() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = new Person();
        person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess util = new UtilityProcess();
            int result = util.updateCityTable(cityDetail);
            if (result > 0) {
//                addActionError("Data Updated Successfully!");
            }
            if (result == 0) {
                addActionError("Error. Please try again");
            }
            return Utility.SUCCESS;
        }
    }

    /**
     * @return the lookups
     */
    public ArrayList<Lookups> getLookups() {
        return lookups;
    }

    /**
     * @param lookups the lookups to set
     */
    public void setLookups(ArrayList<Lookups> lookups) {
        this.lookups = lookups;
    }

    /**
     * @return the person_role
     */
    public Person getPerson_role() {
        return person_role;
    }

    /**
     * @param person_role the person_role to set
     */
    public void setPerson_role(Person person_role) {
        this.person_role = person_role;
    }

    /**
     * @return the lookUpDetail
     */
    public Lookups getLookUpDetail() {
        return lookUpDetail;
    }

    /**
     * @param lookUpDetail the lookUpDetail to set
     */
    public void setLookUpDetail(Lookups lookUpDetail) {
        this.lookUpDetail = lookUpDetail;
    }

    /**
     * @return the isNewConfig
     */
    public int getIsNewConfig() {
        return isNewConfig;
    }

    /**
     * @param isNewConfig the isNewConfig to set
     */
    public void setIsNewConfig(int isNewConfig) {
        this.isNewConfig = isNewConfig;
    }

    /**
     * @return the city
     */
    public ArrayList<City> getCity() {
        return city;
    }

    /**
     * @param city the city to set
     */
    public void setCity(ArrayList<City> city) {
        this.city = city;
    }

    /**
     * @return the cityDetail
     */
    public City getCityDetail() {
        return cityDetail;
    }

    /**
     * @param cityDetail the cityDetail to set
     */
    public void setCityDetail(City cityDetail) {
        this.cityDetail = cityDetail;
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
}
