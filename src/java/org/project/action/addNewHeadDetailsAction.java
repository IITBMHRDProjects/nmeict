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
import org.project.bean.HeadTitle;
import org.project.bean.Person;
import org.project.bean.Stream;
import org.project.process.UtilityProcess;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class addNewHeadDetailsAction extends ActionSupport {

    private ArrayList<HeadTitle> head_title;
    private ArrayList<HeadDesignation> head_designation;
    private ArrayList<Stream> stream;

    public String execute() {
        UtilityProcess process = null;
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            process = new UtilityProcess();
            head_title = process.listHeadTitles();
            head_designation = process.listHeadDesignations();
            stream=process.listStreams();
        }
        return Utility.SUCCESS;
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

    /**
     * @return the stream
     */
    public ArrayList<Stream> getStream() {
        return stream;
    }

    /**
     * @param stream the stream to set
     */
    public void setStream(ArrayList<Stream> stream) {
        this.stream = stream;
    }
}
