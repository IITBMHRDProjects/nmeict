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
import org.project.bean.HeadDesignation;
import org.project.bean.HeadDetails;
import org.project.bean.HeadTitle;
import org.project.bean.Person;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class viewHeadDetailsAction extends ActionSupport {
    private ArrayList<HeadDetails> headdetails;
    private HeadDetails head_details;
    private ArrayList<HeadTitle> head_title;
    private ArrayList<HeadDesignation> head_designation;
    
    public String execute(){
        UtilityProcess process=null;
        HttpSession session = ServletActionContext.getRequest().getSession();
        String instituteid = ServletActionContext.getRequest().getParameter("instituteid");
        String stream=ServletActionContext.getRequest().getParameter("stream");
        SimpleStringCipher cipher = new SimpleStringCipher();
        // String rc = cipher.decrypt(enc_instituteid);
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
        process=new UtilityProcess();
        setHeaddetails(process.listHeadDetails(Integer.parseInt(instituteid)));
        head_details=process.get_HeadDetails(Integer.parseInt(instituteid),Integer.parseInt(stream));
        head_title=process.listHeadTitles();
        head_designation=process.listHeadDesignations();
        }
     return Utility.SUCCESS;
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
     * @return the head_title
     */
    public ArrayList<HeadTitle> getHead_title() {
        return head_title;
    }

    /**
     * @param head_title the head_title to set
     */
    public void setHead_title(ArrayList<HeadTitle> head_title) {
        this.head_title = head_title;
    }

    /**
     * @return the head_designation
     */
    public ArrayList<HeadDesignation> getHead_designation() {
        return head_designation;
    }

    /**
     * @param head_designation the head_designation to set
     */
    public void setHead_designation(ArrayList<HeadDesignation> head_designation) {
        this.head_designation = head_designation;
    }
}
