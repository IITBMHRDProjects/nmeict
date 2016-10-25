/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.project.action;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Content;
import org.project.process.UtilityProcess;

/**
 *
 * @author asl
 */
public class PageContentAction extends ActionSupport {
    private ArrayList<Content> content;
    
    @Override
    public String execute() {
        HttpServletRequest request = ServletActionContext.getRequest();
        UtilityProcess upro = new UtilityProcess();
        setContent(upro.listContent());
        return SUCCESS;
    }
    
    /**
     * @return the content
     */
    public ArrayList<Content> getContent() {
        return content;
    }

    /**
     * @param content the content to set
     */
    public void setContent(ArrayList<Content> content) {
        this.content = content;
    }
}
