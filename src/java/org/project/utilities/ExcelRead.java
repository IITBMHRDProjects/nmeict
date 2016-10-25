/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.project.bean.Designation;
import org.project.bean.Institute;
import org.project.bean.Person;
import org.project.bean.Qualification;
import org.project.bean.RemoteCenter;
import org.project.bean.Stream;
import org.project.bean.Title;

/**
 *
 * @author asl
 */
public class ExcelRead {
    
    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    public static void main(String[] args) {
        
    }
    
    public int excuteReadExcelFunction(File file, String exfname, String exlfile, int loginid, int uploadid) {
        int res = 0;
        try {
            int inserRg = 0, noinsrRg = 0, inRes = 0;
            ArrayList cellStoreArrayList = null;
            ArrayList datasource = null;
            datasource = readexl(file, exfname);
            Person person = null;
            for (int i = 0; i < datasource.size(); i++) {
                person = new Person();
                cellStoreArrayList = (ArrayList) datasource.get(i);
                try {
                    int w_id = 0, rc_id = 0, pincode = 0;
                    RemoteCenter rc = new RemoteCenter();
                    Institute insti = new Institute();
                    Qualification qual = new Qualification();
                    Title title = new Title();
                    Designation desg = new Designation();
                    Stream strm = new Stream();
                    
                    if (cellStoreArrayList.get(1).toString().equals("")) {
                        rc.setRemoteCenterId(rc_id);
                    } else {
                        rc.setRemoteCenterId(Integer.parseInt(cellStoreArrayList.get(1).toString()));
                    }
                    title.setTitleName(cellStoreArrayList.get(2).toString());
                    qual.setQualification(cellStoreArrayList.get(6).toString());
                    desg.setDesignationName(cellStoreArrayList.get(7).toString());
                    strm.setStreamName(cellStoreArrayList.get(8).toString());
                    insti.setInstituteName(cellStoreArrayList.get(16).toString());
                    
                    if (cellStoreArrayList.get(0).toString().equals("")) {
                        person.setPer_workshopid(w_id);
                    } else {
                        person.setPer_workshopid(Integer.parseInt(cellStoreArrayList.get(0).toString()));
                    }
                    person.setRemoteCenter(rc);
                    person.setTitle(title);
                    person.setFirstName(cellStoreArrayList.get(3).toString());
                    person.setLastName(cellStoreArrayList.get(4).toString());
                    person.setEmail(cellStoreArrayList.get(5).toString());
                    person.setQualification(qual);
                    person.setDesignation(desg);
                    person.setStream(strm);
                    person.setExperience(cellStoreArrayList.get(9).toString());
                    person.setGender(cellStoreArrayList.get(10).toString());
                    person.setAddress(cellStoreArrayList.get(11).toString());
                    person.setPer_state(cellStoreArrayList.get(12).toString());
                    if (cellStoreArrayList.get(13).equals("")) {
                        person.setPincode(pincode);
                    } else {
                        person.setPincode(Integer.parseInt(cellStoreArrayList.get(13).toString()));
                    }
                    person.setMobileNumber(cellStoreArrayList.get(14).toString());
                    person.setPhoneNumber(cellStoreArrayList.get(15).toString());
                    person.setInstitute(insti);
                    person.setPer_filename(exlfile);
                    person.setLoginId(loginid);
                    person.setPer_filename_id(uploadid);
                    
                    inRes = fillNewData(person);
                    if (inRes > 0) {
                        inserRg++;
                    } else {
                        noinsrRg++;
                    }
                    
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (inserRg > 0) {
                res = 1;
            }
            // System.out.println("inserted data " + inserRg + " // not inserted data " + noinsrRg);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }
    
    public ArrayList readexl(File exfile, String exfilename) {
        ArrayList storvalues = new ArrayList();
        try {
            // File file2 = new File("/home/asl/Desktop/html work/ProgramFile/test_template.xls");
            FileInputStream file = new FileInputStream(exfile);
            //Workbook workbook = null;
            // String name = file2.getName();
            String name = exfilename;
            Workbook workbook = null;
            if (name.toLowerCase().endsWith("xlsx")) {
                workbook = new XSSFWorkbook(file);
                
            } else if (name.toLowerCase().endsWith("xls")) {
                workbook = new HSSFWorkbook(file);
            }

            //  workbook.setMissingCellPolicy(MissingCellPolicy.RETURN_BLANK_AS_NULL);
            DataFormatter fmt = new DataFormatter();
            
            for (int sn = 0; sn < workbook.getNumberOfSheets(); sn++) {
                Sheet sheet = workbook.getSheetAt(sn);
                for (int rn = sheet.getFirstRowNum() + 1; rn <= sheet.getLastRowNum(); rn++) {
                    Row row = sheet.getRow(rn);
                    if (row == null) {
                        // There is no data in this row, handle as needed
                    } else {
                        // Row "rn" has data
                        ArrayList storeval = new ArrayList();
                        // System.out.println("size " + row.getLastCellNum());
                        for (int cn = 0; cn < 17; cn++) {
                            // for (int cn = 0; cn < row.getLastCellNum(); cn++) {
                            Cell cell = row.getCell(cn);
                            //  cell.setCellType(Cell.CELL_TYPE_STRING);
                            String val = "";
                            // String strCellValue = "";

                            if (cell == null) {
                                // This cell is empty/blank/un-used, handle as needed
                            } else {
                                String cellStr = fmt.formatCellValue(cell);
                                val = cellStr;
                                // Do something with the value
                            }
                            storeval.add(val);
                        }
                        storvalues.add(storeval);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return storvalues;
    }
    
    public int fillNewData(Person per) {
        int res = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //   stmt = con.prepareStatement("insert into partregdata(email,firstname,lastname,instituteid) values(?,?,?,?)");
                stmt = con.prepareStatement("insert into partuserdata(workshopid,rcid,title,firstname,lastname,email,qualification,designation,discipline,experience,Gender,homeaddress,state,pincode,mobileno,contactno,institutename,status,filename,created_by,createdon,filename_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),?)");
                if (per.getPer_workshopid() == 0) {
                    stmt.setString(1, null);
                } else {
                    stmt.setInt(1, per.getPer_workshopid());
                }
                if (per.getRemoteCenter().getRemoteCenterId() == 0) {
                    stmt.setString(2, null);
                } else {
                    stmt.setInt(2, per.getRemoteCenter().getRemoteCenterId());
                }
                stmt.setString(3, isBlankValue(per.getTitle().getTitleName()));
                stmt.setString(4, isBlankValue(per.getFirstName()));
                stmt.setString(5, isBlankValue(per.getLastName()));
                stmt.setString(6, isBlankValue(per.getEmail()));
                stmt.setString(7, isBlankValue(per.getQualification().getQualification()));
                stmt.setString(8, isBlankValue(per.getDesignation().getDesignationName()));
                stmt.setString(9, isBlankValue(per.getStream().getStreamName()));
                stmt.setString(10, isBlankValue(per.getExperience()));
                stmt.setString(11, isBlankValue(per.getGender()));
                stmt.setString(12, isBlankValue(per.getAddress()));
                stmt.setString(13, isBlankValue(per.getPer_state()));
                if (per.getPincode() == 0) {
                    stmt.setString(14, null);
                } else {
                    stmt.setInt(14, per.getPincode());
                }
                stmt.setString(15, isBlankValue(per.getMobileNumber()));
                stmt.setString(16, isBlankValue(per.getPhoneNumber()));
                stmt.setString(17, isBlankValue(per.getInstitute().getInstituteName()));
                stmt.setString(18, "intial");
                stmt.setString(19, per.getPer_filename());
                stmt.setInt(20, per.getLoginId());
                stmt.setInt(21, per.getPer_filename_id());
                res = stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeDBConnection(con);
        }
        return res;
    }
    
    public int getuploadfileNextId() {
        int nxtId = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("select max(id) as 'nxtid' from uploadfiles");
                rs = stmt.executeQuery();
                while (rs.next()) {
                    nxtId = rs.getInt("nxtid");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return nxtId;
    }
    
    public int insertUploadFiles(String filename, int lid) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("insert into uploadfiles(filename,update_by,update_time) values(?,?,now())");
                stmt.setString(1, filename);
                stmt.setInt(2, lid);
                result = stmt.executeUpdate();
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }
    
    public String isBlankValue(String value) {
        String val = null;
        try {
            if (value.trim() == "" || value.trim().length() == 0) {
                return val;
            } else {
                val = value;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return val;
    }
    
    public int getuploadfileId(String filename) {
        int upload_id = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("select id as 'uplid' from uploadfiles where filename=?");
                stmt.setString(1, filename);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    upload_id = rs.getInt("uplid");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return upload_id;
    }
    
    public ArrayList<Person> getAllPartRegData(int fileid) {
        ArrayList<Person> partdata = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("select userinterfaceid,workshopid,rcid,title,firstname,lastname,email,qualification,designation,discipline,experience,Gender,homeaddress,state,pincode,mobileno,contactno,institutename,status from partuserdata where filename_id=? ");
                stmt.setInt(1, fileid);
                rs = stmt.executeQuery();
                Person person = null;
                while (rs.next()) {
                    person = new Person();
                    person.setPer_user_id(rs.getInt("userinterfaceid"));
                    person.setPer_workshopid(rs.getInt("workshopid"));
                    RemoteCenter rc = new RemoteCenter();
                    rc.setRemoteCenterId(rs.getInt("rcid"));
                    person.setRemoteCenter(rc);
                    Title title = new Title();
                    title.setTitleName(rs.getString("title"));
                    person.setTitle(title);
                    person.setFirstName(rs.getString("firstname"));
                    person.setLastName(rs.getString("lastname"));
                    person.setEmail(rs.getString("email"));
                    Qualification qual = new Qualification();
                    qual.setQualification(rs.getString("qualification"));
                    person.setQualification(qual);
                    Designation desg = new Designation();
                    desg.setDesignationName(rs.getString("designation"));
                    person.setDesignation(desg);
                    Stream stream = new Stream();
                    stream.setStreamName(rs.getString("discipline"));
                    person.setStream(stream);
                    person.setExperience(rs.getString("experience"));
                    person.setGender(rs.getString("Gender"));
                    person.setAddress(rs.getString("homeaddress"));
                    person.setPer_state(rs.getString("state"));
                    person.setPincode(rs.getInt("pincode"));
                    person.setMobileNumber(rs.getString("mobileno"));
                    person.setPhoneNumber(rs.getString("contactno"));
                    Institute insti = new Institute();
                    // insti.setInstituteId(rs.getInt("instituteid"));
                    insti.setInstituteName(rs.getString("institutename"));
                    person.setInstitute(insti);
                    person.setPer_userstatus(rs.getString("status"));
                    partdata.add(person);
                }
            }
        } catch (Exception e) {
            
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return partdata;
    }
    
    public boolean isFieldEmpty(String field) {
        boolean result = true;
        try {
            if (field == null) {
                result = false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public int invalidDataMessage(Person person) {
        int res = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("update partuserdata set status=?,errormessage=? where userinterfaceid=?");
                stmt.setString(1, person.getPer_userstatus());
                stmt.setString(2, person.getPer_errormessage());
                stmt.setInt(3, person.getPer_user_id());
                res = stmt.executeUpdate();
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return res;
    }
    
    public int validData(Person person) {
        int res = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("update partuserdata set status=?,titleid=?,qualificationid=?,designationid=?,streamid=?,stateid=?,instituteid=? where userinterfaceid=?");
                stmt.setString(1, person.getPer_userstatus());
                stmt.setInt(2, person.getTitle().getTitleId());
                stmt.setInt(3, person.getQualification().getQualificationId());
                stmt.setInt(4, person.getDesignation().getDesignationId());
                stmt.setInt(5, person.getStream().getStreamId());
                stmt.setInt(6, person.getStateId());
                stmt.setInt(7, person.getInstitute().getInstituteId());
                stmt.setInt(8, person.getPer_user_id());
                res = stmt.executeUpdate();
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return res;
    }
    
    public int checkValidDataExist(Person person) {
        int res = 0, wid = 0;
        String email = "";
        
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("select workshopid,email from partuserdata where email=? and workshopid=? and status='valid'");
                stmt.setString(1, person.getEmail());
                stmt.setInt(2, person.getPer_workshopid());
                
                rs = stmt.executeQuery();
                while (rs.next()) {
                    
                    wid = rs.getInt("workshopid");
                    email = rs.getString("email");
                    
                }
                
                if (wid != 0 && !email.equals("")) {
                    
                    res = 1;
                }
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return res;
    }
    
    public int getvalidIdOfField(Person person, String qtype) {
        int res = 0, title_id = 0, qual_id = 0, desg_id = 0, strm_id = 0, state_id = 0, insti_id = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query1 = "select participant_titlte_id from ParticipantTitle where lower(participanttitle)=? and isActive=1";
                String query2 = "select qualification_id from qualification where lower(qualification)=? and active=1";
                String query3 = "select iddesignation from designation where lower(designation)=? and isActive=1";
                String query4 = "select idstream from stream where lower(stream_name)=? and isActive=1";
                String query5 = "select stateid from state where lower(state)=? and isActive=1";
                String query6 = "select idInstitute from institute where lower(Institutename)=? and isActive=1";
                if (qtype.equals("title")) {
                    stmt = con.prepareStatement(query1);
                    stmt.setString(1, person.getTitle().getTitleName().toLowerCase());
                } else if (qtype.equals("qualification")) {
                    stmt = con.prepareStatement(query2);
                    stmt.setString(1, person.getQualification().getQualification().toLowerCase());
                } else if (qtype.equals("designation")) {
                    stmt = con.prepareStatement(query3);
                    stmt.setString(1, person.getDesignation().getDesignationName().toLowerCase());
                } else if (qtype.equals("discipline")) {
                    stmt = con.prepareStatement(query4);
                    stmt.setString(1, person.getStream().getStreamName().toLowerCase());
                } else if (qtype.equals("state")) {
                    stmt = con.prepareStatement(query5);
                    stmt.setString(1, person.getPer_state().toLowerCase());
                } else if (qtype.equals("institute")) {
                    stmt = con.prepareStatement(query6);
                    stmt.setString(1, person.getInstitute().getInstituteName().toLowerCase());
                }
                
                rs = stmt.executeQuery();
                while (rs.next()) {
                    if (qtype.equals("title")) {
                        title_id = rs.getInt("participant_titlte_id");
                        res = title_id;
                    } else if (qtype.equals("qualification")) {
                        qual_id = rs.getInt("qualification_id");
                        res = qual_id;
                    } else if (qtype.equals("designation")) {
                        desg_id = rs.getInt("iddesignation");
                        res = desg_id;
                    } else if (qtype.equals("discipline")) {
                        strm_id = rs.getInt("idstream");
                        res = strm_id;
                    } else if (qtype.equals("state")) {
                        state_id = rs.getInt("stateid");
                        res = state_id;
                    } else if (qtype.equals("institute")) {
                        insti_id = rs.getInt("idInstitute");
                        res = insti_id;
                    }
                    
                }
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return res;
    }
    
    public int workshopidValid(int workshopid) {
        int res = 0, wid = 0;
        String wname = null;
        
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("select workshopname,workshopid from workshops where workshopid=?");
                stmt.setInt(1, workshopid);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    wname = rs.getString("workshopname");
                    // wid = rs.getInt("workshopid");
                }
                if (isFieldEmpty(wname)) {
                    res = 1;
                }
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return res;
    }
    
    public int checkDateOfWorkshop(int workshopid) {
        int res = 0, wid = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("select workshopid from workshops where startdateofappli <= curdate() and lastdateforappli >= curdate() and workshopid=? ");
                stmt.setInt(1, workshopid);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    wid = rs.getInt("workshopid");
                }
                if (wid != 0) {
                    res = 1;
                }
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return res;
    }
    
    public boolean checkExperince(String exp) {
        boolean res = false;
        
        if (exp.equals("0-2 years")) {
            res = true;
        } else if (exp.equals("2-5 years")) {
            res = true;
        } else if (exp.equals("5-10 years")) {
            res = true;
        } else if (exp.equals(">10 years")) {
            res = true;
        }
        return res;
    }
    
    public boolean checkGender(String gender) {
        boolean res = false;
        if (gender.equals("M")) {
            res = true;
        } else if (gender.equals("F")) {
            res = true;
        }
        return res;
    }
    
    public ArrayList<Person> gelAllInvalidRecords(int fileid) {
        ArrayList<Person> partdata = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("select workshopid,email,firstname,lastname,institutename,errormessage from partuserdata where filename_id=? and status='error'");
                stmt.setInt(1, fileid);
                rs = stmt.executeQuery();
                Person person = null;
                while (rs.next()) {
                    person = new Person();
                    person.setPer_workshopid(rs.getInt("workshopid"));
                    if (!isFieldEmpty(rs.getString("email"))) {
                        person.setEmail("");
                    } else if (isFieldEmpty(rs.getString("email"))) {
                        person.setEmail(rs.getString("email"));
                    }
                    if (!isFieldEmpty(rs.getString("firstname"))) {
                        person.setFirstName("");
                    } else if (isFieldEmpty(rs.getString("firstname"))) {
                        person.setFirstName(rs.getString("firstname"));
                    }
                    if (!isFieldEmpty(rs.getString("lastname"))) {
                        person.setLastName("");
                    } else if (isFieldEmpty(rs.getString("lastname"))) {
                        person.setLastName(rs.getString("lastname"));
                    }
                    Institute insti = new Institute();
                    if (!isFieldEmpty(rs.getString("institutename"))) {
                        insti.setInstituteName("");
                    } else if (isFieldEmpty(rs.getString("institutename"))) {
                        insti.setInstituteName(rs.getString("institutename"));
                    }
                    if (!isFieldEmpty(rs.getString("errormessage"))) {
                        person.setPer_errormessage("");
                    } else if (isFieldEmpty(rs.getString("errormessage"))) {
                        person.setPer_errormessage(rs.getString("errormessage"));
                    }
                    
                    person.setInstitute(insti);
                    partdata.add(person);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return partdata;
    }
    
    public ArrayList<Person> getAllValidData(int fileid) {
        ArrayList<Person> partdata = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("select userinterfaceid,workshopid,email from partuserdata where filename_id=? and status='valid'");
                stmt.setInt(1, fileid);
                rs = stmt.executeQuery();
                Person person = null;
                while (rs.next()) {
                    person = new Person();
                    person.setPer_user_id(rs.getInt("userinterfaceid"));
                    person.setEmail(rs.getString("email"));
                    partdata.add(person);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return partdata;
    }
    
    public ArrayList<Person> getDetailsofInviteButNotRegister() {
        ArrayList<Person> invitenotregdata = new ArrayList<Person>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                String query = "select pud.userinterfaceid, pud.email,pud.workshopid,pud.firstname,pud.lastname,pud.rcid,pud.institutename from partuserdata pud where status='valid' and not exists (select  c.email from accomodation a,participant p,context c where a.participantid=p.participantid and p.contextid=c.idcontext and status != 'Cancelled' and pud.workshopid=a.workshopid and pud.email=c.email)";
                stmt = con.prepareStatement(query);
                rs = stmt.executeQuery();
                Person person = null;
                while (rs.next()) {
                    person = new Person();
                    person.setLoginId(rs.getInt("userinterfaceid"));
                    person.setEmail(rs.getString("email"));
                    person.setPer_workshopid(rs.getInt("workshopid"));
                    person.setFirstName(rs.getString("firstname"));
                    person.setLastName(rs.getString("lastname"));
                    RemoteCenter rc = new RemoteCenter();
                    rc.setRemoteCenterId(rs.getInt("rcid"));
                    person.setRemoteCenter(rc);
                    Institute insti = new Institute();
                    insti.setInstituteName(rs.getString("institutename"));
                    person.setInstitute(insti);
                    invitenotregdata.add(person);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return invitenotregdata;
    }
    
    public int setQuery_notRegisterData(String context) {
        int count = 0;
        String query;
        ExcelSheet excel = new ExcelSheet();
        try {
            query = "select pud.email,pud.workshopid,pud.firstname,pud.lastname,pud.rcid,pud.institutename from partuserdata pud where status='valid' and not exists (select  c.email from accomodation a,participant p,context c where a.participantid=p.participantid and p.contextid=c.idcontext and status != 'Cancelled' and pud.workshopid=a.workshopid and pud.email=c.email)";
            String fileName = null;
            fileName = context + "Excel_Sheets/InviteButNotRegister.xls";
            boolean result = excel.createExcel(query, fileName);
            if (result == true) {
                count = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return count;
    }
    
    public boolean check_RcIdExist(int rcid) {
        boolean result = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                stmt = con.prepareStatement("select remotecenterid from remotecenter where remotecenterid=? and active=1");
                stmt.setInt(1, rcid);
                rs = stmt.executeQuery();
                while (rs.next()) {
                    result = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(stmt);
            DBConnection.closeResultSet(rs);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }
}
