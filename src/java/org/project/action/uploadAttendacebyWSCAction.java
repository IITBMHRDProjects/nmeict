/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.FileUtil;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author dipesh
 */
public class uploadAttendacebyWSCAction extends ActionSupport {

    private File upload_attenadance;
    private String upload_attenadanceContentType;
    private String upload_attenadanceFileName;
    private String up_wid;
    private String up_rcid;
    private String up_date;
    private ArrayList<WorkshopContent> workshopContent;
    private ArrayList<RemoteCenter> remoteCenters;
    private String workshopid_enc;
    private String rcid_enc;

    public String upload_Attendace() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        try {
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            if (person == null) {
                return Utility.LOGIN_FAILURE;
            } else {
                UtilityProcess objUpro = new UtilityProcess();
                String result_upload = "";
                SimpleStringCipher cipher = new SimpleStringCipher();
                setWorkshopid_enc(getUp_wid());
                setRcid_enc(getUp_rcid());
                setUp_wid(cipher.decrypt(getUp_wid()));
                setUp_rcid(cipher.decrypt(getUp_rcid()));
                String filename = getUp_wid() + "_" + getUp_rcid() + "_" + getUp_date();
                int person_login=person.getLoginId();
                result_upload = objUpro.insertUploadScannedAttendance(Integer.parseInt(up_wid), Integer.parseInt(up_rcid), filename, up_date,person_login);
                if (result_upload.equals("error")) {
                    session.setAttribute("result", "error");
                } else {
                    int up_flag = 0;
                    try {
                        String context = ServletActionContext.getServletContext().getRealPath("");
                        FileUtil.saveFile(getUpload_attenadance(), result_upload, context + File.separator + "AttendancePDF");
                        up_flag = 1;
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    if (up_flag == 1) {
                        session.setAttribute("result", "success");
                    } else if (up_flag == 0) {
                        session.setAttribute("result", "uploadfailed");
                    }
                }
            }
        } catch (Exception e) {
            session.setAttribute("result", "error");
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    public void validate() {
        if (upload_attenadance.equals(null) || upload_attenadance.equals("")) {
            addFieldError("upload_attenadance", "Please Upload only pdf file(less than 2 mb )");
        }

        boolean file_type = false;
        try {
            file_type = isPDF(upload_attenadance);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(uploadAttendacebyWSCAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (file_type == false) {
            addFieldError("uploadError", "Please Upload only pdf file format (less than 2 mb )");
        }
    }

    public boolean isPDF(File file) throws FileNotFoundException {
        //File file = new File(file_path);
        Scanner input = new Scanner(new FileReader(file));
        while (input.hasNextLine()) {
            final String checkline = input.nextLine();
            if (checkline.contains("%PDF-")) {
                // a match!
                return true;
            }
        }
        return false;
    }

    public String viewUploadedAttendance() {
        try {
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            if (person == null) {
                return Utility.LOGIN_FAILURE;
            } else {
                UtilityProcess process = new UtilityProcess();
                String period = "90 day";
                setWorkshopContent(process.listWorkshopsConducted(period));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    public String displayUploadAttendance() {
        try {
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            if (person == null) {
                return Utility.LOGIN_FAILURE;
            } else {
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    /**
     * @return the upload_attenadance
     */
    public File getUpload_attenadance() {
        return upload_attenadance;
    }

    /**
     * @param upload_attenadance the upload_attenadance to set
     */
    public void setUpload_attenadance(File upload_attenadance) {
        this.upload_attenadance = upload_attenadance;
    }

    /**
     * @return the upload_attenadanceContentType
     */
    public String getUpload_attenadanceContentType() {
        return upload_attenadanceContentType;
    }

    /**
     * @param upload_attenadanceContentType the upload_attenadanceContentType to
     * set
     */
    public void setUpload_attenadanceContentType(String upload_attenadanceContentType) {
        this.upload_attenadanceContentType = upload_attenadanceContentType;
    }

    /**
     * @return the upload_attenadanceFileName
     */
    public String getUpload_attenadanceFileName() {
        return upload_attenadanceFileName;
    }

    /**
     * @param upload_attenadanceFileName the upload_attenadanceFileName to set
     */
    public void setUpload_attenadanceFileName(String upload_attenadanceFileName) {
        this.upload_attenadanceFileName = upload_attenadanceFileName;
    }

    /**
     * @return the up_wid
     */
    public String getUp_wid() {
        return up_wid;
    }

    /**
     * @param up_wid the up_wid to set
     */
    public void setUp_wid(String up_wid) {
        this.up_wid = up_wid;
    }

    /**
     * @return the up_rcid
     */
    public String getUp_rcid() {
        return up_rcid;
    }

    /**
     * @param up_rcid the up_rcid to set
     */
    public void setUp_rcid(String up_rcid) {
        this.up_rcid = up_rcid;
    }

    /**
     * @return the up_date
     */
    public String getUp_date() {
        return up_date;
    }

    /**
     * @param up_date the up_date to set
     */
    public void setUp_date(String up_date) {
        this.up_date = up_date;
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
     * @return the workshopid_enc
     */
    public String getWorkshopid_enc() {
        return workshopid_enc;
    }

    /**
     * @param workshopid_enc the workshopid_enc to set
     */
    public void setWorkshopid_enc(String workshopid_enc) {
        this.workshopid_enc = workshopid_enc;
    }

    /**
     * @return the rcid_enc
     */
    public String getRcid_enc() {
        return rcid_enc;
    }

    /**
     * @param rcid_enc the rcid_enc to set
     */
    public void setRcid_enc(String rcid_enc) {
        this.rcid_enc = rcid_enc;
    }
}
