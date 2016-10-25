/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Institute;
import org.project.bean.Person;
import org.project.bean.State;
import org.project.process.UtilityProcess;
import org.project.utilities.DBConnection;
import org.project.utilities.SimpleStringCipher;

/**
 *
 * @author asl
 */
public class manageSurveyAction extends ActionSupport {
    private ArrayList<Person> per_details;
    private Person person;
    private String temp = null, temp2 = null;
    private Connection con;
    private PreparedStatement pstmt, pstmt1;
    private ResultSet res;

    public String execute() {
        try {
             HttpSession session = ServletActionContext.getRequest().getSession();
            temp = ServletActionContext.getRequest().getParameter("email");
            temp2 = ServletActionContext.getRequest().getParameter("rcid");
            SimpleStringCipher cipher = new SimpleStringCipher();
            temp = cipher.decrypt(temp);
            temp2 = cipher.decrypt(temp2);
            UtilityProcess process=new UtilityProcess();
            int already_present=0;
            already_present=process.checkAlreadyRegisterInSurvey(Integer.parseInt(temp2));
            if(already_present ==0){
               person=getDetailsOfPerson(temp, temp2);
               session.setAttribute("rc_exist1", "no");
               
            }else if(already_present > 0){
                
                session.setAttribute("rc_exist1", "yes");
            }
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        return SUCCESS;
    }

    public Person getDetailsOfPerson(String email, String id) {
       // ArrayList<Person> details = new ArrayList<Person>();
        Person per = null;
        try{
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                // pstmt = con.prepareStatement("SELECT respective_coordinatorid from workshops where workshopid=?");
               // pstmt = con.prepareStatement("select i.idinstitute,i.institutename,s.state from institute i,state s where i.state=s.stateid and i.idinstitute=?");
                pstmt =con.prepareStatement("select r.remotecenterid, r.remotecentername,s.state,c.city from remotecenter r,state s,city c where s.stateid=r.state and c.cityid= r.city and r.remotecenterid=?");
                 // pstmt.setString(1, email);
                pstmt.setInt(1, Integer.parseInt(id));
                res = pstmt.executeQuery();
               
                while (res.next()) {
                    per=new Person();
                    Institute institute = new Institute();
                    institute.setInstituteName(res.getString("remotecentername"));
                    institute.setInstituteId(res.getInt("remotecenterid"));
                    
                    State state=new State();
                    state.setStateName(res.getString("state"));
                    institute.setState(state);
                    per.setInstitute(institute);
                    //details.add(per);
                   // per.set
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
          DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return per;
    }

    /**
     * @return the person
     */
    public Person getPerson() {
        return person;
    }

    /**
     * @param person the person to set
     */
    public void setPerson(Person person) {
        this.person = person;
    }

    /**
     * @return the per_details
     */
    public ArrayList<Person> getPer_details() {
        return per_details;
    }

    /**
     * @param per_details the per_details to set
     */
    public void setPer_details(ArrayList<Person> per_details) {
        this.per_details = per_details;
    }
}
