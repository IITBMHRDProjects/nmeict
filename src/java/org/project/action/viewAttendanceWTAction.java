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
import org.project.bean.AttendanceSchedule;
import org.project.bean.Person;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class viewAttendanceWTAction extends ActionSupport {
    private ArrayList<AttendanceSchedule> attendance;  
    
    public String getParticipantAttendance() throws Exception{
          HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE; 
        } else {
             SimpleStringCipher cipher = new SimpleStringCipher();
            /**
             * getting the parameters from 'url'
             */
            String workshopid_encrypted = ServletActionContext.getRequest().getParameter("workshopid");
            String workshopid = cipher.decrypt(workshopid_encrypted);
            String partid_encrypted = ServletActionContext.getRequest().getParameter("participantid");
            String pid = cipher.decrypt(partid_encrypted);
            UtilityProcess pro=new UtilityProcess();
            attendance=pro.getViewParticipantAttendance(workshopid, pid);
           // System.out.println(attendance);
            if(attendance !=null){
              session.setAttribute("result", "yes");
            }else{
              session.setAttribute("result", "no");
            }
            return Utility.SUCCESS;
        }
      
    }

    /**
     * @return the attendance
     */
    public ArrayList<AttendanceSchedule> getAttendance() {
        return attendance;
    }

    /**
     * @param attendance the attendance to set
     */
    public void setAttendance(ArrayList<AttendanceSchedule> attendance) {
        this.attendance = attendance;
    }
    
}
