/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.FileUtil;
import org.project.utilities.Utility;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Announcements;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Validate;

/**
 *
 * @author Abinaya
 */
public class ManageWorkshopAction extends ActionSupport {

    private WorkshopContent content, content1;
    private Announcements announcements;
    private File permissionLetter;
    private File brochure;
    private File eligibility;
    private File mailcontent;
    private File certificate;
    private File programmeSchedule;

    /**
     * @return the content
     */
    public WorkshopContent getContent() {
        return content;
    }

    /**
     * @param content the content to set
     */
    public void setContent(WorkshopContent content) {
        this.content = content;
    }

    /**
     * @return the announcement
     */
    public Announcements getAnnouncements() {
        return announcements;
    }

    /**
     * @param announcement the announcement to set
     */
    public void setAnnouncements(Announcements announcements) {
        this.announcements = announcements;
    }

    /**
     * @return the permissionLetter
     */
    public File getPermissionLetter() {
        return permissionLetter;
    }

    /**
     * @param permissionLetter the permissionLetter to set
     */
    public void setPermissionLetter(File permissionLetter) {
        this.permissionLetter = permissionLetter;
    }

    /**
     * @return the brochure
     */
    public File getBrochure() {
        return brochure;
    }

    /**
     * @param brochure the brochure to set
     */
    public void setBrochure(File brochure) {
        this.brochure = brochure;
    }

    /**
     * @return the eligibility
     */
    public File getEligibility() {
        return eligibility;
    }

    /**
     * @param eligibility the eligibility to set
     */
    public void setEligibility(File eligibility) {
        this.eligibility = eligibility;
    }

    /**
     * @return the mailcontent
     */
    public File getMailcontent() {
        return mailcontent;
    }

    /**
     * @param mailcontent the mailcontent to set
     */
    public void setMailcontent(File mailcontent) {
        this.mailcontent = mailcontent;
    }

    /**
     * @return the certificate
     */
    public File getCertificate() {
        return certificate;
    }

    /**
     * @param certificate the certificate to set
     */
    public void setCertificate(File certificate) {
        this.certificate = certificate;
    }

    /**
     *
     * @return update -first the delete the file
     */
    public String manageWorkshop() throws Exception {
        int result = 0, result1 = 0;
        boolean isWorkshopIsNew = content.getIsNew();
        UtilityProcess uproc = new UtilityProcess();
        if (!isWorkshopIsNew) {
            result = uproc.UpdateWorkshop(content);
            if (result > 0) {
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getBrochure(), "brouchure_" + content.getWorkshopid() + ".pdf", context + File.separator + "pdfs");
                } catch (Exception e) {
                }

                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getPermissionLetter(), "permissionLetter_" + content.getWorkshopid() + ".pdf", context + File.separator + "pdfs");
                } catch (Exception e) {
                }
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getEligibility(), "eligibility_" + content.getWorkshopid() + ".pdf", context + File.separator + "pdfs");
                } catch (Exception e) {
                }
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getMailcontent(), "successMail_" + content.getWorkshopid() + ".html", context + File.separator + "mails");
                } catch (Exception e) {
                }

                //for certificate
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getCertificate(), "certificate_" + content.getWorkshopid() + ".xhtml", context + File.separator + "certificate_templates/certificate");
                } catch (Exception e) {
                }

                // for programme schedule
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getProgrammeSchedule(), "schedule_" + content.getWorkshopid() + ".pdf", context + File.separator + "pdfs");
                } catch (Exception e) {
                }

                try {
                    Announcements ann = new Announcements();
                    String announcementName = content.getAnnouncement();
                    ann.setAnnouncement(announcementName);
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String encryptedWorkshopid = cipher.encrypt(Integer.toString(content.getWorkshopid()));
                    ann.setLink("workshopContent.html?workshopid=" + encryptedWorkshopid);
                    ann.setAnnouncementid(content.getWorkshopid());
                    ann.setLocation("inhouse");
                    ann.setStartdate(content.getStartdate());
                    ann.setEnddate(content.getEnddate());
                    ann.setType(1);
                    ann.setStatus("Forthcoming");
                    /*
                     * add private announcements if cateogry code is 4 and related workshopid is not 0
                     */
                    if ((result == 4 && content.getRespectiveCoWorkshopid() != 0)) {
                        //   ann.setVisible("N");
                        // get the visible action
                        String visible = uproc.checkIfAnnouncementVisible(Integer.toString(content.getWorkshopid()));
                        ann.setVisible(visible);
                    }

//                    if (content.getCategorycode() != 6) {
                    // get the visiblity status from announcements table
                    String visible = uproc.checkIfAnnouncementVisible(Integer.toString(content.getWorkshopid()));
                    ann.setVisible(visible);
                    setAnnouncements(ann);
                    result1 = uproc.updateAnnouncement(getAnnouncements());
//                    }

                } catch (Exception sqle) {
                    sqle.printStackTrace();
                }
                return Utility.SUCCESS;
            } else {
                clearActionErrors();
                addActionError("Oops! Database update error.");
                return Utility.ERROR;
            }
        } else {
            result = uproc.insertWorkshop(content);
            if (result > 0) {
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getBrochure(), "brouchure_" + content.getWorkshopid() + ".pdf", context + File.separator + "pdfs");
                } catch (Exception e) {
                }
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getPermissionLetter(), "permissionLetter_" + content.getWorkshopid() + ".pdf", context + File.separator + "pdfs");
                } catch (Exception e) {
                }
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getEligibility(), "eligibility_" + content.getWorkshopid() + ".pdf", context + File.separator + "pdfs");
                } catch (Exception e) {
                }
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getMailcontent(), "successMail_" + content.getWorkshopid() + ".html", context + File.separator + "mails");
                } catch (Exception e) {
                }
                //for certificate
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getCertificate(), "certificate_" + content.getWorkshopid() + ".html", context + File.separator + "certificate_templates");
                } catch (Exception e) {
                }
                // for programme schedule
                try {
                    String context = ServletActionContext.getServletContext().getRealPath("");
                    FileUtil.saveFile(getProgrammeSchedule(), "schedule_" + content.getWorkshopid() + ".pdf", context + File.separator + "pdfs");
                } catch (Exception e) {
                }

                try {
                    Announcements ann = new Announcements();
                    String announcementName = content.getAnnouncement();
                    ann.setAnnouncement(announcementName);
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String encryptedWorkshopid = cipher.encrypt(Integer.toString(content.getWorkshopid()));
                    ann.setLink("workshopContent.html?workshopid=" + encryptedWorkshopid);
                    ann.setAnnouncementid(content.getWorkshopid());
                    ann.setLocation("inhouse");
                    ann.setStartdate(content.getStartdate());
                    ann.setEnddate(content.getEnddate());
                    ann.setType(1);
                    ann.setStatus("Forthcoming");
                    /*
                     * add private announcements if cateogry code is 4 and related workshopid is not 0
                     */
                    if (content.getCategorycode() == 4 && content.getRespectiveCoWorkshopid() != 0) {
//                        ann.setVisible("N");
                        ann.setVisible("Y");
                    }
                    setAnnouncements(ann);

//                    if (content.getCategorycode() != 6) {
                    result1 = uproc.insertAnnouncement(getAnnouncements());
//                    }

                    if (content.getCategorycode() == 4 && content.getMaincc() != 0) {
                        int res_coor_id = content.getWorkshopid();
                        setContent1(content);
                        // set content1 parameters if it's a coordinator workshop
                        content1.setWorkshopid(uproc.getLatestWorkshopid(content.getMaincc()));
                        content1.setWorkshopname("Main -" + content.getWorkshopname());
                        content1.setRespectiveCoWorkshopid(res_coor_id);
                        content1.setCategorycode(content.getMaincc());

                        DateFormat dateFormatNeeded = new SimpleDateFormat("dd-MM-yyyy");

                        Date startdate = dateFormatNeeded.parse(content.getStartdate());
                        startdate.setDate(startdate.getDate() + 90);
                        Date enddate = dateFormatNeeded.parse(content.getEnddate());
                        enddate.setDate(enddate.getDate() + 90);
                        Date startdateAppli = dateFormatNeeded.parse(content.getStartdatereg());
                        startdateAppli.setDate(startdateAppli.getDate() + 90);
                        Date enddateAppli = dateFormatNeeded.parse(content.getLastdatereg());
                        enddateAppli.setDate(enddateAppli.getDate() + 90);

                        content1.setStartdate(dateFormatNeeded.format(startdate));
                        content1.setEnddate(dateFormatNeeded.format(enddate));
                        content1.setStartdatereg(dateFormatNeeded.format(startdateAppli));
                        content1.setLastdatereg(dateFormatNeeded.format(enddateAppli));
                        content1.setDateToBeDisplayed(1);

                        uproc.insertWorkshop(content1);

                        encryptedWorkshopid = cipher.encrypt(Integer.toString(content1.getWorkshopid()));
                        Announcements ann1 = ann;
                        ann1.setAnnouncementid(content1.getWorkshopid());
                        ann1.setAnnouncement("Main -" + ann.getAnnouncement());
                        ann1.setLink("workshopContent.html?workshopid=" + encryptedWorkshopid);
                        ann1.setStartdate(content.getStartdate());
                        ann1.setEnddate(content.getEnddate());
                        ann1.setVisible("N");

                        uproc.insertAnnouncement(ann1);
                    }

                } catch (Exception sqle) {
                    sqle.printStackTrace();
                }
                return Utility.SUCCESS;
            } else {
                clearActionErrors();
                addActionError("Oops! Database insertion error.");
                return Utility.ERROR;
            }
        }
    }

    @Override
    public void validate() {
        clearFieldErrors();
//        if (!Validate.isStringValid(content.getWorkshopname(), 8, 40)) {
//            //add action errors..
//        }
    }

    /**
     * @return the programmeSchedule
     */
    public File getProgrammeSchedule() {
        return programmeSchedule;
    }

    /**
     * @param programmeSchedule the programmeSchedule to set
     */
    public void setProgrammeSchedule(File programmeSchedule) {
        this.programmeSchedule = programmeSchedule;
    }

    public WorkshopContent getContent1() {
        return content1;
    }

    public void setContent1(WorkshopContent content1) {
        this.content1 = content1;
    }
}
