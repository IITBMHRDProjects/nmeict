/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.CertificateAudit;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;
import org.project.bean.WSCNominations;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.EmailUtil;
import org.project.utilities.HtmlUtility;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class NominationsAction extends ActionSupport {

    private ArrayList<WSCNominations> nominations;
    private ArrayList<WorkshopContent> workshopContent;
    private WSCNominations nomination;

    private ArrayList<CertificateAudit> certificateAudit;

    @Override
    public String execute() {
        try {
            /*
             * Getting user session object
             */
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            UserProcess uproc = new UserProcess();
            UtilityProcess process = new UtilityProcess();
            if (person == null) {
                return Utility.LOGIN_FAILURE;
            } else {
                nominations = process.getWSCNominations();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    public String listWorkshops() throws Exception {

        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);

        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            UtilityProcess process = new UtilityProcess();
            //fetching the arraylist of workshopContent  
            setWorkshopContent(process.listMainWorkshopId());
            setWorkshopContent(getWorkshopContent());
            return Utility.SUCCESS;
        }
    }

    public String doNominate() throws Exception {

        UtilityProcess process = new UtilityProcess();
        //fetching the arraylist of workshopContent  
        /*
         * Getting user session object
         */
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);

        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            nomination.setPerson(person);
            int result = process.nominateWSC(nomination);
            if (result > 0) {
                UserProcess uprocess = new UserProcess();
                Person nominee = uprocess.getPerson(nomination.getNominee_email());
                Person original_coordinator = uprocess.getPerson(nomination.getCooridnator_email());
                WorkshopContent wc = (process.listWorkshopContent(Integer.toString(nomination.getWc().getWorkshopid()))).get(0);
                RemoteCenter rc = process.rc_details(Integer.toString(nomination.getRc().getRemoteCenterId()));
                try {
                    String fileName = "nominateWSC.html";
                    String contextPath = ServletActionContext.getServletContext().getRealPath("");
                    String filePath = contextPath + "/" + "mail-template";
                    String emailMessage = HtmlUtility.read(filePath, fileName);
                    String subject = "Nomination for Workshop Coordinator";
                    emailMessage = Pattern.compile("#name#").matcher(emailMessage).replaceFirst(nominee.getFirstName() + " " + nominee.getLastName());
                    emailMessage = Pattern.compile("#WorkshopName#").matcher(emailMessage).replaceAll(wc.getWorkshopname());
                    emailMessage = Pattern.compile("#OriginalCoordinatorName#").matcher(emailMessage).replaceAll(original_coordinator.getFirstName() + " " + original_coordinator.getLastName());
                    emailMessage = Pattern.compile("#rcid#").matcher(emailMessage).replaceAll(nomination.getRc().getRemoteCenterId() + " - " + rc.getRemoteCenterName() + ", " + rc.getCity1());
                    emailMessage = Pattern.compile("#ValidTill#").matcher(emailMessage).replaceAll(nomination.getActive_till());
                    EmailUtil mail = new EmailUtil();
                    mail.sendEmail("senderemail", nomination.getNominee_email(), nomination.getCooridnator_email() + " , senderemail", "", subject, emailMessage);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                addActionMessage("Successfuly created");
            } else {
                addActionError("Failed. Please try later");
            }
            nominations = process.getWSCNominations();
            return Utility.SUCCESS;
        }
    }

    public String certificateAudit() {
        try {
            /*
             * Getting user session object
             */
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            UserProcess uproc = new UserProcess();
            UtilityProcess process = new UtilityProcess();
            if (person == null) {
                return Utility.LOGIN_FAILURE;
            } else {
                certificateAudit = process.getCertificateAudit();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    /**
     * @return the nominations
     */
    public ArrayList<WSCNominations> getNominations() {
        return nominations;
    }

    /**
     * @param nominations the nominations to set
     */
    public void setNominations(ArrayList<WSCNominations> nominations) {
        this.nominations = nominations;
    }

    /**
     * @return the workshopContent
     */
    public ArrayList<WorkshopContent> getWorkshopContent() {
        return workshopContent;
    }

    /**
     * @param workshopContent the workshopContent to set
     */
    public void setWorkshopContent(ArrayList<WorkshopContent> workshopContent) {
        this.workshopContent = workshopContent;
    }

    /**
     * @return the nomination
     */
    public WSCNominations getNomination() {
        return nomination;
    }

    /**
     * @param nomination the nomination to set
     */
    public void setNomination(WSCNominations nomination) {
        this.nomination = nomination;
    }

    /**
     * @return the certificateAudit
     */
    public ArrayList<CertificateAudit> getCertificateAudit() {
        return certificateAudit;
    }

    /**
     * @param certificateAudit the certificateAudit to set
     */
    public void setCertificateAudit(ArrayList<CertificateAudit> certificateAudit) {
        this.certificateAudit = certificateAudit;
    }
}
