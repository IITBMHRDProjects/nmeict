/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Institute;
import org.project.bean.Person;
import org.project.utilities.DBConnection;
import org.project.utilities.ExcelRead;
import org.project.utilities.FileUtil;
import org.project.utilities.Utility;
import org.project.utilities.readExcel;

/**
 *
 * @author asl
 */
public class readexceldataAction extends ActionSupport {

    private ArrayList<Person> persondata;
    private File excelread;
    private String excelreadContentType;
    private String excelreadFileName;
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    private int uploadId;

    public String displayReadExcel() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        }
        return Utility.SUCCESS;
    }

    public String ReadExcelData() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        } else {
            try {
                //readExcel rex = new readExcel();
                ExcelRead rex = new ExcelRead();
                int upload_id = rex.getuploadfileNextId();
                String upload_name = "pdfs_" + upload_id + "_" + excelreadFileName;
                String context = ServletActionContext.getServletContext().getRealPath("");
                try {
                    FileUtil.saveFile(excelread, upload_name, context + File.separator + "pdfs");
                } catch (Exception e) {
                    System.out.println("problem in file upload");
                }
                //storing file in folder
                rex.insertUploadFiles(upload_name, person.getLoginId());
                int upl_id = rex.getuploadfileId(upload_name);
                // reading file 
                int reS = rex.excuteReadExcelFunction(excelread, excelreadFileName, upload_name, person.getLoginId(), upl_id);
                if (reS > 0) {
                    setUploadId(upl_id);
                    session.setAttribute("result", "success");
                } else {
                    session.setAttribute("result", "fail");
                }
                // System.out.println("file is " + excelreadFileName);
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("result", "fail");
            }
        }

        return Utility.SUCCESS;
    }

    public ArrayList<Person> getAllPartRegData() {
        ArrayList<Person> partdata = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("select participant_titlte_id,participanttitle,isActive from ParticipantTitle where isActive=1 order by participanttitle");
                rs = stmt.executeQuery();
                Person person = null;
                while (rs.next()) {
                    person = new Person();
                    person.setEmail(rs.getString("email"));
                    person.setFirstName(rs.getString("firstname"));
                    person.setLastName(rs.getString("lastname"));
                    Institute insti = new Institute();
                    insti.setInstituteId(rs.getInt("instituteid"));
                    person.setInstitute(insti);
                    partdata.add(person);
                }
            }
        } catch (Exception e) {

        } finally {
            DBConnection.closeResultSet(rs);
            DBConnection.closePStatement(stmt);
            DBConnection.closeDBConnection(con);
        }
        return partdata;
    }

    public String getInviteNotRegData() {
        HttpSession session = ServletActionContext.getRequest().getSession();
        Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
        if (person == null) {
            return Utility.LOGIN_FAILURE;
        }
        if (person != null) {
            try {
                ExcelRead exr=new ExcelRead();
                persondata=exr.getDetailsofInviteButNotRegister();
                setPersondata(persondata);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return SUCCESS;
    }

    /**
     * @return the excelread
     */
    public File getExcelread() {
        return excelread;
    }

    /**
     * @param excelread the excelread to set
     */
    public void setExcelread(File excelread) {
        this.excelread = excelread;
    }

    /**
     * @return the excelreadContentType
     */
    public String getExcelreadContentType() {
        return excelreadContentType;
    }

    /**
     * @param excelreadContentType the excelreadContentType to set
     */
    public void setExcelreadContentType(String excelreadContentType) {
        this.excelreadContentType = excelreadContentType;
    }

    /**
     * @return the excelreadFileName
     */
    public String getExcelreadFileName() {
        return excelreadFileName;
    }

    /**
     * @param excelreadFileName the excelreadFileName to set
     */
    public void setExcelreadFileName(String excelreadFileName) {
        this.excelreadFileName = excelreadFileName;
    }

    /**
     * @return the persondata
     */
    public ArrayList<Person> getPersondata() {
        return persondata;
    }

    /**
     * @param persondata the persondata to set
     */
    public void setPersondata(ArrayList<Person> persondata) {
        this.persondata = persondata;
    }

    /**
     * @return the uploadId
     */
    public int getUploadId() {
        return uploadId;
    }

    /**
     * @param uploadId the uploadId to set
     */
    public void setUploadId(int uploadId) {
        this.uploadId = uploadId;
    }

}
