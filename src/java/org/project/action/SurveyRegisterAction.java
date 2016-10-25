/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.RemoteCenter;
import org.project.bean.SurveyForm;
import org.project.process.UtilityProcess;
import org.project.utilities.FileUtil;

/**
 *
 * @author asl
 */
public class SurveyRegisterAction extends ActionSupport {

    private SurveyForm surveyform;
    private String rcid;
    private File surveyPdf;
    private String surveyPdfContentType;
    private String surveyPdfFileName;

    public String execute() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        UtilityProcess process = new UtilityProcess();
        if (rcid == null) {
            return ERROR;
        } else {
            int already_present = 0;
            already_present = process.checkAlreadyRegisterInSurvey(Integer.parseInt(rcid));
            if (already_present == 0) {
                RemoteCenter rcenter = new RemoteCenter();
                rcenter.setRemoteCenterId(Integer.parseInt(rcid));
                surveyform.setRemotecenter(rcenter);
                if (surveyform.getYesNofield().equals("no")) {
                    surveyform.setEmail("");
                    surveyform.setName("");
                    System.out.println(getSurveyPdfFileName());
                    String pdfsurvey = rcid + "_survey.pdf";
                    surveyform.setSurvey_pdf(pdfsurvey);
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    try {
                        FileUtil.saveFile(getSurveyPdf(), pdfsurvey, context + File.separator + "SurveyPDF");
                    } catch (Exception e) {
                        System.out.println("problem in file upload");
                    }
                }
                try {
                    int result = 0;
//                UtilityProcess process = new UtilityProcess();
                    result = process.RegiseterSurveyForm(surveyform);
                    if (result == 1) {
                        session.setAttribute("result", "success");
                    } else {
                        session.setAttribute("result", "error");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } else if (already_present > 0) {
                session.setAttribute("result", "rc_already_present");
            }
            return SUCCESS;
        }
    }

    /**
     * @return the surveyform
     */
    public SurveyForm getSurveyform() {
        return surveyform;
    }

    /**
     * @param surveyform the surveyform to set
     */
    public void setSurveyform(SurveyForm surveyform) {
        this.surveyform = surveyform;
    }

    /**
     * @return the rcid
     */
    public String getRcid() {
        return rcid;
    }

    /**
     * @param rcid the rcid to set
     */
    public void setRcid(String rcid) {
        this.rcid = rcid;
    }

    /**
     * @return the surveyPdfContentType
     */
    public String getSurveyPdfContentType() {
        return surveyPdfContentType;
    }

    /**
     * @param surveyPdfContentType the surveyPdfContentType to set
     */
    public void setSurveyPdfContentType(String surveyPdfContentType) {
        this.surveyPdfContentType = surveyPdfContentType;
    }

    /**
     * @return the surveyPdf
     */
    public File getSurveyPdf() {
        return surveyPdf;
    }

    /**
     * @param surveyPdf the surveyPdf to set
     */
    public void setSurveyPdf(File surveyPdf) {
        this.surveyPdf = surveyPdf;
    }

    /**
     * @return the surveyPdfFileName
     */
    public String getSurveyPdfFileName() {
        return surveyPdfFileName;
    }

    /**
     * @param surveyPdfFileName the surveyPdfFileName to set
     */
    public void setSurveyPdfFileName(String surveyPdfFileName) {
        this.surveyPdfFileName = surveyPdfFileName;
    }
}
