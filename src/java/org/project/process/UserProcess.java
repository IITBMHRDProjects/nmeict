/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.process;

import org.project.bean.Stream;
import org.project.bean.Participant;
import org.project.bean.HeadDesignation;
import org.project.bean.Institute;
import org.project.bean.WorkshopContent;
import org.project.bean.Qualification;
import org.project.bean.HeadTitle;
import org.project.bean.RegistrationDetails;
import org.project.bean.UserDashboard;
import org.project.bean.State;
import org.project.bean.Title;
import org.project.bean.City;
import org.project.bean.RemoteCenter;
import org.project.bean.Designation;
import org.project.bean.PaymentGateway;
import org.project.bean.Person;
import java.io.File;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import nl.bitwalker.useragentutils.Browser;
import nl.bitwalker.useragentutils.OperatingSystem;
import org.project.utilities.DBConnection;
import org.project.utilities.ErrorCode;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;
import java.util.Date;

/**
 *
 * @author mayank
 */
public class UserProcess {
    
    private Connection con;
    private PreparedStatement pstmt, pstmt1;
    private ResultSet res, res1;
    private Statement stmt;

    /**
     *
     * @param username
     * @param password
     * @return
     */
    public Person validateLogin(String username, String password) {
        Person person = null;
        int id = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select l.login_id, l.usertypeid, l.last_login, l.login_name,p.instituteid,p.streamId, IFNULL(p.firstname,'') as firstname, IFNULL(p.lastname,'') as lastname, p.experience, p.qualification, i.Institutename, IFNULL(p.image,'') as image,p.facultystatus  from person p, login l, institute i where i.idInstitute=p.instituteid and l.login_id = p.personid and l.login_name=lower(?) and l.password=md5(?) and l.loginstatus = 1 union select l.login_id, l.usertypeid, l.last_login, l.login_name,p.instituteid,p.streamId, p.firstname, p.lastname, p.experience, p.qualification, NULL, IFNULL(p.image,'') as image,p.facultystatus  from person p,  login l where p.instituteid =0 and l.login_id = p.personid and l.login_name=lower(?) and l.password=md5(?) and l.loginstatus = 1");
                //binding the userid and password to the query
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                pstmt.setString(3, username);
                pstmt.setString(4, password);
                //executing the query
                res = pstmt.executeQuery();
                //checking whether any person exist with this userid or password
                if (res.next()) { //if exist then set all the details in Person class object.
                    //creating the object of Person class.
                    person = new Person();
                    //setting the values into variable of Person class
                    person.setLoginId(res.getInt("login_id"));
                    person.setLoginName(res.getString("login_name"));
                    person.setEmail(res.getString("login_name"));
                    person.setFirstName(res.getString("firstname"));
                    person.setLastName(res.getString("lastname"));
                    person.setLastLogin(res.getTimestamp("last_login"));
                    person.setRoleId(res.getInt("usertypeid"));
                    //add more details for inerting participants 
                    Institute institute = new Institute();
                    institute.setInstituteId(res.getInt("instituteid"));
                    institute.setInstituteName(res.getString("Institutename"));
                    person.setInstitute(institute);
                    Qualification qualification = new Qualification();
                    qualification.setQualification(res.getString("qualification"));
                    person.setQualification(qualification);
                    person.setExperience(res.getString("experience"));
                    Stream stream = new Stream();
                    stream.setStreamId(res.getInt("streamId"));
                    person.setStream(stream);

                    // for checking if photoid exist in the site
                    person.setImage(res.getString("image"));
                    person.setFacultyStatus(res.getString("facultystatus"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return person;
    }

    /**
     *
     * @param person
     * @return
     */
    public int updateLoginTimeStamp(Person person, String browser, String operatingsystem) {
        int result = ErrorCode.ERROR;
        PreparedStatement pstmt1 = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("update login set last_login = CURRENT_TIMESTAMP , ipaddress =? , no_of_logins=(no_of_logins+1) where login_id = ?");
                pstmt.setString(1, person.getIpAddress());
                pstmt.setInt(2, person.getLoginId());
                int updated = pstmt.executeUpdate();
                if (updated == 1) {
                    pstmt1 = con.prepareStatement("insert into logs(ip_address, user_id, browser_used, os_used) values (?,?,?,?)");
                    pstmt1.setString(1, person.getIpAddress());
                    pstmt1.setInt(2, person.getLoginId());
                    pstmt1.setString(3, browser);
                    pstmt1.setString(4, operatingsystem);
                    int resultupdated = pstmt1.executeUpdate();
                    if (resultupdated == 1) {
                        result = ErrorCode.SUCCESS;
                    } else {
                        result = ErrorCode.ERROR;
                    }
                }
            }
        } catch (SQLException sqle) {
            result = ErrorCode.SQLEXCEPTION;
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }

    /**
     *
     * @return
     */
    public synchronized int nextContextId() {
        int nextId = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select max(idcontext) as nextId from context");
                res = pstmt.executeQuery();
                if (res.next()) {
                    nextId = res.getInt("nextId");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        if (nextId != 0) {
            return nextId + 1;
        } else {
            return 0;
        }
    }

    /**
     *
     * @param person
     * @return
     * @throws Exception
     */
    public synchronized int registerUser(Person person, String browser, String os) throws Exception {
        int id = 0;
        int update = 0;
        int pid = 0;
        int instituteResultUpdated = 0;
        int instituteId = 0;
        int idInstitute = -1;
        int updateNew, isLogsUpdated = 0;
        boolean isExist = false;
        int isRegsitered = ErrorCode.ERROR;
        if (con == null || con.isClosed()) {
            con = DBConnection.getDBConnection();
        }
        try {
            if (con != null) {
                int nextContextId = nextContextId();
                
                if (con == null || con.isClosed()) {
                    con = DBConnection.getDBConnection();
                }
                
                if (nextContextId == 0) {
                    return ErrorCode.ERROR;
                } else {
                    //  pstmt = con.prepareStatement("insert into context(email, mobile, homephone, email_verified,idcontext) values(?,?,?,?,?)");
                    pstmt = con.prepareStatement("insert into context(email, mobile, homephone, email_verified,idcontext,state,city) values(?,?,?,?,?,?,?)");
                    pstmt.setString(1, person.getEmail().trim());
                    pstmt.setString(2, person.getMobileNumber());
                    pstmt.setString(3, person.getPhoneNumber());
                    pstmt.setInt(4, 0);
                    pstmt.setInt(5, nextContextId);
                    pstmt.setInt(6, person.getStateId());
                    pstmt.setInt(7, person.getCityId());
                    int resultUpdated = pstmt.executeUpdate();
                    if (resultUpdated > 0) {
                        // pstmt = con.prepareStatement("insert into login(login_id,login_name, password, usertypeid, ipaddress, loginstatus,username) values(?,?,md5(?),?,?,0,?)");
                        pstmt = con.prepareStatement("insert into login(login_id,login_name, password, usertypeid, ipaddress, loginstatus) values(?,?,md5(?),?,?,0)");
                        pstmt.setInt(1, nextContextId);
                        pstmt.setString(2, person.getLoginName().trim());
                        pstmt.setString(3, person.getPassword());
                        pstmt.setInt(4, 1);
                        pstmt.setString(5, person.getIpAddress());
                        //pstmt.setString(6, person.getUsername()); 
                        int updated = pstmt.executeUpdate();
                        if (updated > 0) {
                            
                            idInstitute = isInstituteExist(person.getInstitute().getInstituteName());
                            if (con == null || con.isClosed()) {
                                con = DBConnection.getDBConnection();
                            }
                            if (con == null || con.isClosed()) {
                                con = DBConnection.getDBConnection();
                            }
                            if (idInstitute < 0) {
                                pstmt = con.prepareStatement("insert into institute(Institutename,state,city,pincode,address,last_update,isActive) values(?,?,?,?,?,current_timestamp,-1)");
                                pstmt.setString(1, person.getInstitute().getInstituteName());
                                pstmt.setInt(2, person.getInstitute().getState().getStateId());
                                pstmt.setInt(3, person.getInstitute().getCity().getCityId());
                                pstmt.setInt(4, person.getInstitute().getPincode());
                                pstmt.setString(5, person.getInstitute().getInstituteAddress());
                                instituteResultUpdated = pstmt.executeUpdate();
                                if (instituteResultUpdated > 0) {
                                    pstmt = con.prepareStatement("select idInstitute from institute where Institutename = ?");
                                    pstmt.setString(1, person.getInstitute().getInstituteName());
                                    res = pstmt.executeQuery();
                                    if (res.next()) {
                                        instituteId = res.getInt("idInstitute");
                                    }
                                }
                                // pstmt = con.prepareStatement("insert into person (personid, title_id,firstname,lastname,designation,genderinfo,city,address,pincode,experience, qualification,instituteid,streamid) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                pstmt = con.prepareStatement("insert into person (personid, title_id,firstname,lastname,designation,genderinfo,city,address,pincode,experience, qualification,instituteid,streamid,image,last_update,facultystatus) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),1)");
                                // pstmt = con.prepareStatement("insert into person (personid, title_id,firstname,lastname,designation,genderinfo,city,address,pincode,experience, qualification,instituteid,streamid,aadharid,yearofbirth) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                pstmt.setInt(1, nextContextId);
                                pstmt.setInt(2, person.getTitle().getTitleId());
                                pstmt.setString(3, capitalizeString(person.getFirstName().trim()));
                                if (!person.getLastName().equals("") || !person.getLastName().equals(null)) {
                                    pstmt.setString(4, capitalizeString(person.getLastName().trim()));
                                } else {
                                    pstmt.setString(4, "");
                                }
                                pstmt.setInt(5, person.getDesignation().getDesignationId());
                                pstmt.setString(6, person.getGender());
                                pstmt.setString(7, person.getCity().getCityName());
                                pstmt.setString(8, person.getAddress());
                                pstmt.setInt(9, person.getPincode());
                                pstmt.setString(10, person.getExperience());
                                pstmt.setString(11, person.getQualification().getQualification());
                                pstmt.setInt(12, instituteId);
                                pstmt.setInt(13, person.getStream().getStreamId());
                                pstmt.setString(14, "photo_" + nextContextId + ".jpg");
                                // pstmt.setString(14, person.getAadharId());
                                //  pstmt.setInt(15, person.getYearofbirth());
                                //pstmt.setString(16, "photo_" + nextContextId + ".jpg");
                                update = pstmt.executeUpdate();
                                if (update > 0) {
                                    isExist = isInstituteAndStreamExist(person.getInstitute().getInstituteId(), person.getStream().getStreamId());
                                    if (con == null || con.isClosed()) {
                                        con = DBConnection.getDBConnection();
                                    }
                                    if (isExist) {
                                        pstmt = con.prepareStatement("update academic set head_title=?,headname=?,heademail=?,head_designation=?,headaddress=?, head_contact=? where instituteid=? and streamid=?");
                                        //  pstmt.setInt(1, person.getInstitute().getHeadTitle().getHeadTitleId());
                                        pstmt.setInt(1, person.getInstitute().getHeadTitle().getH_headTitleId());
                                        pstmt.setString(2, person.getInstitute().getHeadName());
                                        pstmt.setString(3, person.getInstitute().getHeadEmail());
                                        //   pstmt.setInt(4, person.getInstitute().getHeadDesignation().getHeadDesignationId());
                                        pstmt.setInt(4, person.getInstitute().getHeadDesignation().getH_headDesignationId());
                                        pstmt.setString(5, person.getInstitute().getHeadAddress());
                                        pstmt.setString(6, person.getInstitute().getHeadContact());
                                        pstmt.setInt(7, instituteId);
                                        pstmt.setInt(8, person.getStream().getStreamId());
                                        updateNew = pstmt.executeUpdate();
                                    } else {
                                        pstmt = con.prepareStatement("insert into academic(instituteid,streamid,head_title,headname,heademail,head_designation,headaddress, head_contact,isActive,last_update) values(?,?,?,?,?,?,?,?,-1,current_timestamp)");
                                        pstmt.setInt(1, instituteId);
                                        pstmt.setInt(2, person.getStream().getStreamId());
                                        // pstmt.setInt(3, person.getInstitute().getHeadTitle().getHeadTitleId());
                                        pstmt.setInt(3, person.getInstitute().getHeadTitle().getH_headTitleId());
                                        pstmt.setString(4, person.getInstitute().getHeadName());
                                        pstmt.setString(5, person.getInstitute().getHeadEmail());
                                        //  pstmt.setInt(6, person.getInstitute().getHeadDesignation().getHeadDesignationId());
                                        pstmt.setInt(6, person.getInstitute().getHeadDesignation().getH_headDesignationId());
                                        pstmt.setString(7, person.getInstitute().getHeadAddress());
                                        pstmt.setString(8, person.getInstitute().getHeadContact());
                                        updateNew = pstmt.executeUpdate();
                                    }
                                    if (updateNew > 0) {
                                        pstmt = con.prepareStatement("insert into logs(ip_address,user_id,browser_used,os_used) values(?,?,?,?)");
                                        pstmt.setString(1, person.getIpAddress());
                                        pstmt.setInt(2, nextContextId);
                                        pstmt.setString(3, browser);
                                        pstmt.setString(4, os);
                                        isLogsUpdated = pstmt.executeUpdate();
                                    }
                                    isRegsitered = nextContextId;
                                }
                            } else {
                                pstmt = con.prepareStatement("update institute set address=?,pincode=?,last_update=current_timestamp  where idInstitute=?");
                                pstmt.setString(1, person.getInstitute().getInstituteAddress());
                                pstmt.setInt(2, person.getInstitute().getPincode());
                                pstmt.setInt(3, idInstitute);
                                updateNew = pstmt.executeUpdate();
                                if (updateNew > 0) {
                                    pstmt = con.prepareStatement("insert into person (personid, title_id,firstname,lastname,designation,genderinfo,city,address,pincode,experience, qualification,instituteid,streamid, image,last_update,facultystatus) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),1)");
                                    //pstmt = con.prepareStatement("insert into person (personid, title_id,firstname,lastname,designation,genderinfo,city,address,pincode,experience, qualification,instituteid,streamid, image,aadharid,yearofbirth) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                    pstmt.setInt(1, nextContextId);
                                    pstmt.setInt(2, person.getTitle().getTitleId());
                                    pstmt.setString(3, capitalizeString(person.getFirstName().trim()));
                                    if (!person.getLastName().equals("") || !person.getLastName().equals(null)) {
                                        pstmt.setString(4, capitalizeString(person.getLastName().trim()));
                                    } else {
                                        pstmt.setString(4, "");
                                    }
                                    pstmt.setInt(5, person.getDesignation().getDesignationId());
                                    pstmt.setString(6, person.getGender());
                                    pstmt.setString(7, person.getCity().getCityName());
                                    pstmt.setString(8, person.getAddress());
                                    pstmt.setInt(9, person.getPincode());
                                    pstmt.setString(10, person.getExperience());
                                    pstmt.setString(11, person.getQualification().getQualification());
                                    if (person.getInstitute().getInstituteId() == 0) {
                                        person.getInstitute().setInstituteId(idInstitute);
                                    }
                                    pstmt.setInt(12, person.getInstitute().getInstituteId());
                                    pstmt.setInt(13, person.getStream().getStreamId());
                                    // image added
                                    pstmt.setString(14, "photo_" + nextContextId + ".jpg");
                                    // pstmt.setString(15, person.getAadharId());
                                    // pstmt.setInt(16, person.getYearofbirth());
                                    update = pstmt.executeUpdate();
                                    if (update > 0) {
                                        isExist = isInstituteAndStreamExist(person.getInstitute().getInstituteId(), person.getStream().getStreamId());
                                        if (con == null || con.isClosed()) {
                                            con = DBConnection.getDBConnection();
                                        }
                                        if (isExist) {
                                            pstmt = con.prepareStatement("update academic set head_title=?,headname=?,heademail=?,head_designation=?,headaddress=?, head_contact=? where instituteid=? and streamid=?");
                                            // pstmt.setInt(1, person.getInstitute().getHeadTitle().getHeadTitleId());
                                            pstmt.setInt(1, person.getInstitute().getHeadTitle().getH_headTitleId());
                                            pstmt.setString(2, person.getInstitute().getHeadName());
                                            pstmt.setString(3, person.getInstitute().getHeadEmail());
                                            //   pstmt.setInt(4, person.getInstitute().getHeadDesignation().getHeadDesignationId());
                                            pstmt.setInt(4, person.getInstitute().getHeadDesignation().getH_headDesignationId());
                                            pstmt.setString(5, person.getInstitute().getHeadAddress());
                                            pstmt.setString(6, person.getInstitute().getHeadContact());
                                            pstmt.setInt(7, person.getInstitute().getInstituteId());
                                            pstmt.setInt(8, person.getStream().getStreamId());
                                            updateNew = pstmt.executeUpdate();
                                        } else {
                                            pstmt = con.prepareStatement("insert into academic(instituteid,streamid,head_title,headname,heademail,head_designation,headaddress, head_contact,isActive,last_update) values(?,?,?,?,?,?,?,?,-1,current_timestamp)");
                                            pstmt.setInt(1, person.getInstitute().getInstituteId());
                                            pstmt.setInt(2, person.getStream().getStreamId());
                                            //  pstmt.setInt(3, person.getInstitute().getHeadTitle().getHeadTitleId());
                                            pstmt.setInt(3, person.getInstitute().getHeadTitle().getH_headTitleId());
                                            pstmt.setString(4, person.getInstitute().getHeadName());
                                            pstmt.setString(5, person.getInstitute().getHeadEmail());
                                            // pstmt.setInt(6, person.getInstitute().getHeadDesignation().getHeadDesignationId());
                                            pstmt.setInt(6, person.getInstitute().getHeadDesignation().getH_headDesignationId());
                                            pstmt.setString(7, person.getInstitute().getHeadAddress());
                                            pstmt.setString(8, person.getInstitute().getHeadContact());
                                            updateNew = pstmt.executeUpdate();
                                        }
                                        if (updateNew > 0) {
                                            pstmt = con.prepareStatement("insert into logs(ip_address,user_id,browser_used,os_used) values(?,?,?,?)");
                                            pstmt.setString(1, person.getIpAddress());
                                            pstmt.setInt(2, nextContextId);
                                            pstmt.setString(3, browser);
                                            pstmt.setString(4, os);
                                            isLogsUpdated = pstmt.executeUpdate();
                                        }
                                        isRegsitered = nextContextId;
                                    } else {
                                        con.rollback();
                                        isRegsitered = ErrorCode.ERROR;
                                    }
                                } else {
                                    con.rollback();
                                    isRegsitered = ErrorCode.ERROR;
                                }
                            }
                        } else {
                            con.rollback();
                            isRegsitered = ErrorCode.ERROR;
                        }
                    } else {
                        con.rollback();
                        isRegsitered = ErrorCode.ERROR;
                    }
                }
            }
        } catch (SQLException sqle) {
            isRegsitered = ErrorCode.SQLEXCEPTION;
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return isRegsitered;
    }
    
    public synchronized int UpdateUser(Person person, String browser, String os) throws Exception {
        int isUserUpdated = ErrorCode.ERROR;
        int id = 0;
        int update = 0;
        int updated = 0;
        int instituteResultUpdated = 0;
        int instituteId = 0;
        int isLogsUpdated = 0;
        boolean isExist = false;
        int updateNew = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //con.setAutoCommit(false);
                // pstmt = con.prepareStatement("update context set mobile=?, homephone=?, email_verified=? where email=?");
                pstmt = con.prepareStatement("update context set mobile=?, homephone=?, email_verified=?,state=?,city=? where email=?");
                pstmt.setString(1, person.getMobileNumber());
                pstmt.setString(2, person.getPhoneNumber());
                pstmt.setInt(3, 0);
                pstmt.setInt(4, person.getStateId());
                pstmt.setInt(5, person.getCityId());
                pstmt.setString(6, person.getEmail());
                int resultUpdated = pstmt.executeUpdate();
                if (resultUpdated > 0) {
                    pstmt = con.prepareStatement("select idcontext from context where email = ?");
                    pstmt.setString(1, person.getEmail());
                    res = pstmt.executeQuery();
                    if (res.next()) {
                        id = res.getInt("idcontext");
                    }
                    boolean isLoginExist = isLoginExist(person.getEmail().trim());
                    if (isLoginExist) {
                        pstmt = con.prepareStatement("update login set login_id= ?, login_name=?, ipaddress=? where login_name=?");
                        //  pstmt = con.prepareStatement("update login set login_id= ?, login_name=?, ipaddress=?,username=? where login_name=?");
                        pstmt.setInt(1, id);
                        pstmt.setString(2, person.getLoginName().trim());
                        pstmt.setString(3, person.getIpAddress());
                        // pstmt.setString(4, person.getUsername());
                        pstmt.setString(4, person.getEmail());
                        updated = pstmt.executeUpdate();
                    } else {
                        pstmt = con.prepareStatement("insert into login(login_id,login_name, usertypeid, ipaddress) values(?,?,?,?)");
                        //  pstmt = con.prepareStatement("insert into login(login_id,login_name, usertypeid, ipaddress,username) values(?,?,?,?,?)");
                        pstmt.setInt(1, id);
                        pstmt.setString(2, person.getLoginName().trim());
                        pstmt.setInt(3, 1);
                        pstmt.setString(4, person.getIpAddress());
                        // pstmt.setString(5, person.getUsername());
                        updated = pstmt.executeUpdate();
                    }
                    if (updated > 0) {
                        int idInstitute = isInstituteExist(person.getInstitute().getInstituteName());
                        if (con == null || con.isClosed()) {
                            con = DBConnection.getDBConnection();
                        }
                        if (idInstitute < 0) {
                            pstmt = con.prepareStatement("insert into institute(Institutename,state,city,pincode,address,isActive,last_update) values(?,?,?,?,?,-1,current_timestamp)");
                            pstmt.setString(1, person.getInstitute().getInstituteName());
                            pstmt.setInt(2, person.getInstitute().getState().getStateId());
                            pstmt.setInt(3, person.getInstitute().getCity().getCityId());
                            pstmt.setInt(4, person.getInstitute().getPincode());
                            pstmt.setString(5, person.getInstitute().getInstituteAddress());
                            instituteResultUpdated = pstmt.executeUpdate();
                            if (instituteResultUpdated > 0) {
                                //con.setAutoCommit(true);
                                pstmt = con.prepareStatement("select idInstitute from institute where Institutename = ?");
                                pstmt.setString(1, person.getInstitute().getInstituteName());
                                res = pstmt.executeQuery();
                                if (res.next()) {
                                    instituteId = res.getInt("idInstitute");
                                }
                            }

                            // new ---  pstmt = con.prepareStatement("update person set title_id=?,firstname=?,lastname=?,designation=?,genderinfo=?,city=?,address=?,pincode=?,experience=?, qualification=?,instituteid=?,streamid=?,aadharid=?,yearofbirth=?,image=? where personid=?");
                            pstmt = con.prepareStatement("update person set title_id=?,firstname=?,lastname=?,designation=?,genderinfo=?,city=?,address=?,pincode=?,experience=?, qualification=?,instituteid=?,streamid=?,image=?,last_update=now(),facultystatus=1 where personid=?");
                            //new pstmt = con.prepareStatement("update person set title_id=?,firstname=?,lastname=?,designation=?,genderinfo=?,city=?,address=?,pincode=?,experience=?, qualification=?,instituteid=?,streamid=?,aadharid=?,yearofbirth=? where personid=?");
                            pstmt.setInt(1, person.getTitle().getTitleId());
                            pstmt.setString(2, capitalizeString(person.getFirstName().trim()));
                            if (!person.getLastName().trim().equals("") || !person.getLastName().trim().equals(null)) {
                                pstmt.setString(3, capitalizeString(person.getLastName().trim()));
                            } else {
                                pstmt.setString(3, "");
                            }
                            pstmt.setInt(4, person.getDesignation().getDesignationId());
                            pstmt.setString(5, person.getGender());
                            pstmt.setString(6, person.getCity().getCityName());
                            pstmt.setString(7, person.getAddress());
                            pstmt.setInt(8, person.getPincode());
                            pstmt.setString(9, person.getExperience());
                            pstmt.setString(10, person.getQualification().getQualification());
                            pstmt.setInt(11, instituteId);
                            pstmt.setInt(12, person.getStream().getStreamId());
                            //  pstmt.setString(13, person.getAadharId());
                            //  pstmt.setInt(14, person.getYearofbirth());
                            if (person.getImage().trim() != "") {
                                pstmt.setString(13, "photo_" + id + ".jpg");
                            } else {
                                pstmt.setString(13, null);
                            }
                            pstmt.setInt(14, id);
                            // pstmt.setInt(15, id);
                            update = pstmt.executeUpdate();
                            if (person.getInstitute().getInstituteId() == 0) {
                                person.getInstitute().setInstituteId(instituteId);
                            }
                            if (update > 0) {
                                isExist = isInstituteAndStreamExist(person.getInstitute().getInstituteId(), person.getStream().getStreamId());
                                if (con == null || con.isClosed()) {
                                    con = DBConnection.getDBConnection();
                                }
                                if (isExist) {
                                    pstmt = con.prepareStatement("update academic set head_title=?,headname=?,heademail=?,head_designation=?,headaddress=?, head_contact=? where instituteid=? and streamid=?");
                                    pstmt.setInt(1, person.getInstitute().getHeadTitle().getHeadTitleId());
                                    pstmt.setString(2, person.getInstitute().getHeadName());
                                    pstmt.setString(3, person.getInstitute().getHeadEmail());
                                    pstmt.setInt(4, person.getInstitute().getHeadDesignation().getHeadDesignationId());
                                    pstmt.setString(5, person.getInstitute().getHeadAddress());
                                    pstmt.setString(6, person.getInstitute().getHeadContact());
                                    pstmt.setInt(7, person.getInstitute().getInstituteId());
                                    pstmt.setInt(8, person.getStream().getStreamId());
                                    updateNew = pstmt.executeUpdate();
                                } else {
                                    pstmt = con.prepareStatement("insert into academic(instituteid,streamid,head_title,headname,heademail,head_designation,headaddress, head_contact,isActive,last_update) values(?,?,?,?,?,?,?,?,-1,current_timestamp)");
                                    pstmt.setInt(1, person.getInstitute().getInstituteId());
                                    pstmt.setInt(2, person.getStream().getStreamId());
                                    pstmt.setInt(3, person.getInstitute().getHeadTitle().getHeadTitleId());
                                    pstmt.setString(4, person.getInstitute().getHeadName());
                                    pstmt.setString(5, person.getInstitute().getHeadEmail());
                                    pstmt.setInt(6, person.getInstitute().getHeadDesignation().getHeadDesignationId());
                                    pstmt.setString(7, person.getInstitute().getHeadAddress());
                                    pstmt.setString(8, person.getInstitute().getHeadContact());
                                    updateNew = pstmt.executeUpdate();
                                }
                                /*
                                 * if (updateNew > 0) {
                                 */
                                pstmt = con.prepareStatement("insert into logs(ip_address,user_id,browser_used,os_used) values(?,?,?,?)");
                                pstmt.setString(1, person.getIpAddress());
                                pstmt.setInt(2, id);
                                pstmt.setString(3, browser);
                                pstmt.setString(4, os);
                                isLogsUpdated = pstmt.executeUpdate();
                                /*
                                 * }
                                 */
                                if (isLogsUpdated > 0) {
//                                    con.commit();
                                }
                            }
                        } else {
                            pstmt = con.prepareStatement("update institute set address=?,pincode=?,last_update=current_timestamp  where idInstitute=?");
                            pstmt.setString(1, person.getInstitute().getInstituteAddress());
                            pstmt.setInt(2, person.getInstitute().getPincode());
                            pstmt.setInt(3, idInstitute);
                            updateNew = pstmt.executeUpdate();
                            if (updateNew > 0) {
                            }
                            //new--- pstmt = con.prepareStatement("update person set title_id=?,firstname=?,lastname=?,designation=?,genderinfo=?,city=?,address=?,pincode=?,experience=?, qualification=?,instituteid=?,streamid=?,aadharid=?,yearofbirth=?,image=? where personid=?");
                            pstmt = con.prepareStatement("update person set title_id=?,firstname=?,lastname=?,designation=?,genderinfo=?,city=?,address=?,pincode=?,experience=?, qualification=?,instituteid=?,streamid=?,image=?,last_update=now(),facultystatus=1 where personid=?");
                            //new--  pstmt = con.prepareStatement("update person set title_id=?,firstname=?,lastname=?,designation=?,genderinfo=?,city=?,address=?,pincode=?,experience=?, qualification=?,instituteid=?,streamid=?,aadharid=?,yearofbirth=? where personid=?");
                            pstmt.setInt(1, person.getTitle().getTitleId());
                            pstmt.setString(2, capitalizeString(person.getFirstName()));
                            if (!person.getLastName().equals("") || !person.getLastName().equals(null)) {
                                pstmt.setString(3, capitalizeString(person.getLastName()));
                            } else {
                                pstmt.setString(3, "");
                            }
                            pstmt.setInt(4, person.getDesignation().getDesignationId());
                            pstmt.setString(5, person.getGender());
                            pstmt.setString(6, person.getCity().getCityName());
                            pstmt.setString(7, person.getAddress());
                            pstmt.setInt(8, person.getPincode());
                            pstmt.setString(9, person.getExperience());
                            pstmt.setString(10, person.getQualification().getQualification());
                            if (person.getInstitute().getInstituteId() == 0) {
                                person.getInstitute().setInstituteId(idInstitute);
                            }
                            
                            pstmt.setInt(11, person.getInstitute().getInstituteId());
                            pstmt.setInt(12, person.getStream().getStreamId());
                            // pstmt.setString(13, person.getAadharId());
                            // pstmt.setInt(14, person.getYearofbirth());
                            if (person.getImage().trim() != "") {
                                pstmt.setString(13, "photo_" + id + ".jpg");
                            } else {
                                pstmt.setString(13, null);
                            }
                            pstmt.setInt(14, id);
                            //pstmt.setInt(15, id);
                            update = pstmt.executeUpdate();
                            if (update > 0) {
                                isExist = isInstituteAndStreamExist(person.getInstitute().getInstituteId(), person.getStream().getStreamId());
                                if (con == null || con.isClosed()) {
                                    con = DBConnection.getDBConnection();
                                }
                                if (isExist) {
                                    pstmt = con.prepareStatement("update academic set head_title=?,headname=?,heademail=?,head_designation=?,headaddress=?, head_contact=? where instituteid=? and streamid=?");
                                    pstmt.setInt(1, person.getInstitute().getHeadTitle().getHeadTitleId());
                                    pstmt.setString(2, person.getInstitute().getHeadName());
                                    pstmt.setString(3, person.getInstitute().getHeadEmail());
                                    pstmt.setInt(4, person.getInstitute().getHeadDesignation().getHeadDesignationId());
                                    pstmt.setString(5, person.getInstitute().getHeadAddress());
                                    pstmt.setString(6, person.getInstitute().getHeadContact());
                                    pstmt.setInt(7, person.getInstitute().getInstituteId());
                                    pstmt.setInt(8, person.getStream().getStreamId());
                                    updateNew = pstmt.executeUpdate();
                                } else {
                                    pstmt = con.prepareStatement("insert into academic(instituteid,streamid,head_title,headname,heademail,head_designation,headaddress, head_contact,isActive,last_update) values(?,?,?,?,?,?,?,?,-1,current_timestamp)");
                                    pstmt.setInt(1, person.getInstitute().getInstituteId());
                                    pstmt.setInt(2, person.getStream().getStreamId());
                                    pstmt.setInt(3, person.getInstitute().getHeadTitle().getHeadTitleId());
                                    pstmt.setString(4, person.getInstitute().getHeadName());
                                    pstmt.setString(5, person.getInstitute().getHeadEmail());
                                    pstmt.setInt(6, person.getInstitute().getHeadDesignation().getHeadDesignationId());
                                    pstmt.setString(7, person.getInstitute().getHeadAddress());
                                    pstmt.setString(8, person.getInstitute().getHeadContact());
                                    updateNew = pstmt.executeUpdate();
                                }
                                if (updateNew > 0) {
                                    pstmt = con.prepareStatement("insert into logs(ip_address,user_id,browser_used,os_used) values(?,?,?,?)");
                                    pstmt.setString(1, person.getIpAddress());
                                    pstmt.setInt(2, id);
                                    pstmt.setString(3, browser);
                                    pstmt.setString(4, os);
                                    isLogsUpdated = pstmt.executeUpdate();
                                }
                                if (isLogsUpdated > 0) {
                                    // con.commit();
                                }
                            } else {
                                con.rollback();
                                isUserUpdated = ErrorCode.ERROR;
                            }
                        }
                    } else {
                        con.rollback();
                        isUserUpdated = ErrorCode.ERROR;
                    }
                } else {
                    con.rollback();
                    isUserUpdated = ErrorCode.ERROR;
                }
            }
        } catch (SQLException sqle) {
            isUserUpdated = ErrorCode.SQLEXCEPTION;
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return isUserUpdated;
    }

    /**
     * isEmailAvailable() methods checks whether the email exist or not. This
     * method search the given email in the context table, if found then return
     * false otherwise true.
     *
     * @param email email to be checked.
     * @return It returns true or false depending upon availability of email
     */
    public boolean isEmailAvailable(String email) {
        //creatinga a boolean variable result (by default true)
        boolean result = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select email from context where email=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email.trim());
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    result = true;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }

    /**
     *
     * @param instituteId
     * @param streamId
     * @return
     */
    public boolean isInstituteAndStreamExist(int instituteId, int streamId) {
        //creatinga a boolean variable result (by default false)
        boolean result = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select instituteid, streamid from academic where instituteid=? and streamid = ? and isActive in(-1,1)");
                //binding the parameter values to query statement
                pstmt.setInt(1, instituteId);
                pstmt.setInt(2, streamId);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if instituteId exist or not.
                    //if exist the result is set to true
                    result = true;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }

    /**
     *
     * @param instiName
     * @return
     */
    public int isInstituteExist(String instiName) {
        boolean isExist = false;
        int instituteid = -1;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select idInstitute,Institutename from institute where Institutename=? and isActive in (1,-1)");
                //binding the parameter values to query statement
                pstmt.setString(1, instiName);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    isExist = true;
                    instituteid = res.getInt("idInstitute");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return instituteid;
    }
    
    public String getInstiName(int instituteId) {
        String institName = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to fetch InstituteName through instituteId.
                pstmt = con.prepareStatement("select Institutename from institute where idInstitute=?");
                //binding the parameter values to query statement
                pstmt.setInt(1, instituteId);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    institName = res.getString("Institutename");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return institName;
    }

    /**
     * isLoginExist() methods checks whether the login_name exist or not. This
     * method search the given email in the login table, if found then return
     * true otherwise false.
     *
     * @param email login_name to be checked.
     * @return It returns true or false depending upon availability of
     * login_name
     */
    public boolean isLoginExist(String email) {
        //creatinga a boolean variable result (by default true)
        boolean result = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select login_name from login where login_name=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    result = true;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
        }
        //return the result
        return result;
    }

    /**
     * trackVisitor() function insert the ipAddress of the visitor in the
     * visitorlog table. This method is used to track the ip address of the
     * users who visits the website.
     *
     * @param ipAddress A string object containing ip address
     * @return void This method returns nothing
     */
    public synchronized int trackVisitor(String ipAddress) {
        int visitorId = 0;
        PreparedStatement pstmt1 = null;
        if (con == null) {
            con = DBConnection.getDBConnection();
        }
        if (DBConnection.isClosed(con)) {
            con = DBConnection.getDBConnection();
        }
        if (!DBConnection.isClosed(con)) {
            try {
                pstmt = con.prepareStatement("insert into visitorlog(time,ipaddress) values(CURRENT_TIMESTAMP,?)");
                pstmt.setString(1, ipAddress);
                int rowUpdated = pstmt.executeUpdate();
                if (rowUpdated == 1) {
                    pstmt1 = con.prepareStatement("select max(visitorid) as nextid from visitorlog ");
                    ResultSet res = pstmt1.executeQuery();
                    if (res.next()) {
                        visitorId = res.getInt("nextid");
                    }
                }
            } catch (SQLException sqle) {
                sqle.printStackTrace();
            } finally {
                DBConnection.closePStatement(pstmt1);
                DBConnection.closePStatement(pstmt);
                DBConnection.closeStatement(stmt);
                DBConnection.closeResultSet(res);
                DBConnection.closeDBConnection(con);
            }
        }
        return visitorId;
    }
    
    public Person getPerson(String email) {
        Person person = new Person();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select l.login_name, p.firstname, p.lastname from login l , person p where p.personid= l.login_id and login_name=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email.trim());
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    person.setLoginName(res.getString("login_name"));
                    person.setFirstName(res.getString("firstname"));
                    person.setLastName(res.getString("lastname"));
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return person;
    }

    /**
     * This function updates the login status of the person in the login table.
     * Loginstatus should be 1 for login in to website.
     *
     * @param email
     * @return int 0 for update failure and 1 for successful update
     */
    public int updateLoginStatus(String email) {
        int isUpdated = 0, isVerifyUpdated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("update login set loginstatus=1 where login_name=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email);
                //executing the update.
                isUpdated = pstmt.executeUpdate();
                // creating a  query for update email_verifed to one.
                pstmt1 = con.prepareStatement("update context set email_verified=1 where email=?");
                pstmt1.setString(1, email);
                //executing the update.
                isVerifyUpdated = pstmt1.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeDBConnection(con);
        }
        return isUpdated;
    }
    
    public boolean isPasswordCorrect(String password, int loginId) {
        boolean isCorrect = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select login_name, login_id, password from login where password=md5(?) and login_id= ?");
                //binding the parameter values to query statement
                pstmt.setString(1, password);
                pstmt.setInt(2, loginId);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    isCorrect = true;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return isCorrect;
    }
    
    public int changePassword(int loginId, String password) {
        int updated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("update login set password = md5(?) where login_id=?");
                //binding the parameter values to query statement
                pstmt.setString(1, password);
                pstmt.setInt(2, loginId);
                updated = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return updated;
    }
    
    public int updatePassword(String password, String email) {
        int updated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("update login set password = md5(?) where login_name=?");
                //binding the parameter values to query statement
                pstmt.setString(1, password);
                pstmt.setString(2, email);
                updated = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return updated;
    }

    /**
     * This function fetches all the information of the user related to its
     * profile by passing the int userId to the function and returns the Person
     * object
     *
     * @param userId
     * @return Person person
     */
    public Person getPersonInformation(int userId) {
        //Variable declaration
        Person per = null;
        PreparedStatement pstmt1 = null;
        ResultSet res1 = null;
        int instiId, streamId = 0;
        try {
            if (con == null || con.isClosed()) { //checking whether connection is closed or null
                con = DBConnection.getDBConnection(); //if yes, getting the connection object
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                // pstmt = con.prepareStatement("select login_name,DATE_FORMAT(last_login,'%d %b %Y %h:%i %p') as last_login from login where login_id=?");
                pstmt = con.prepareStatement("select login_name from login where login_id=?");
                // pstmt = con.prepareStatement("select login_name,username from login where login_id=?");
                //binding the parameter values to query statement
                pstmt.setInt(1, userId);
                //executing the query.
                res = pstmt.executeQuery();
                //checking whether any person exist with this userid
                if (res.next()) {//if exist then set all the details in Person class object.
                    per = new Person();
                    per.setLoginName(res.getString("login_name"));
                    per.setEmail(res.getString("login_name"));
                    // per.setUsername(res.getString("username"));
                    //getting values from person table
                    pstmt = null;
                    //creating a query statement to get the values from person table
                    //original-- pstmt = con.prepareStatement("select title_id, firstname, lastname, designation, genderinfo,city,address, pincode,experience,qualification,instituteid, streamid from person where personid=?");
                    pstmt = con.prepareStatement("select title_id, firstname, ifnull(lastname,'') as lastname, designation, genderinfo,city,address, pincode,experience,qualification,instituteid, streamid,image,DATE_FORMAT(last_update,'%d %b %Y %h:%i %p') as last_update,facultystatus from person where personid=?");
                    //new--   pstmt = con.prepareStatement("select title_id, firstname, lastname, designation, genderinfo,city,address, pincode,experience,qualification,instituteid, streamid,aadharid,yearofbirth,image from person where personid=?");
                    //binding the parameter values to query statement
                    pstmt.setInt(1, userId);
                    //executing the query.
                    res1 = pstmt.executeQuery();
                    //checking whether any person exist with this userid
                    if (res1.next()) {//if exist then set all the details in Person class object.
                        per.setFirstName(res1.getString("firstname"));
                        per.setLastName(res1.getString("lastname"));
                        per.setAddress(res1.getString("address"));
                        per.setGender(res1.getString("genderinfo"));
                        per.setPincode(res1.getInt("pincode"));
                        per.setExperience(res1.getString("experience"));
                        City city = new City();
                        city.setCityName(res1.getString("city"));
                        per.setCity(city);
                        Title title = new Title();
                        title.setTitleId(res1.getInt("title_id"));
                        per.setTitle(title);
                        Designation designation = new Designation();
                        designation.setDesignationId(res1.getInt("designation"));
                        per.setDesignation(designation);
                        Qualification qualification = new Qualification();
                        qualification.setQualification(res1.getString("qualification"));
                        per.setQualification(qualification);
                        Stream stream = new Stream();
                        stream.setStreamId(res1.getInt("streamid"));
                        streamId = res1.getInt("streamid");
                        per.setStream(stream);
                        // per.setAadharId(res1.getString("aadharid"));
                        // per.setYearofbirth(res1.getInt("yearofbirth"));
                        instiId = res1.getInt("instituteid");
                        per.setImage(res1.getString("image"));
                        per.setLast_login1(res1.getString("last_update"));
                        per.setFacultyStatus(res1.getString("facultystatus"));
                        //creating a query statement to get the values from person table
                        //original--  pstmt1 = con.prepareStatement("select mobile, homephone from context where idcontext=?");
                        pstmt1 = con.prepareStatement("select mobile, homephone,state,city from context where idcontext=?");
                        //binding the parameter values to query statement
                        pstmt1.setInt(1, userId);
                        //executing the query.
                        res = pstmt1.executeQuery();
                        if (res.next()) {
                            per.setMobileNumber(res.getString("mobile"));
                            per.setPhoneNumber(res.getString("homephone"));
                            per.setStateId(res.getInt("state"));
                            per.setCityId(res.getInt("city"));
                        }
                        pstmt1 = null;
                        //creating a query statement to get the values from person table
                        pstmt1 = con.prepareStatement("select idInstitute, Institutename,city,state,pincode,address from institute where idInstitute=?");
                        //binding the parameter values to query statement
                        pstmt1.setInt(1, instiId);
                        //executing the query.
                        res = pstmt1.executeQuery();
                        if (res.next()) {
                            Institute institute = new Institute();
                            institute.setInstituteId(res.getInt("idInstitute"));
                            institute.setInstituteName(res.getString("Institutename"));
                            institute.setInstituteAddress(res.getString("address"));
                            institute.setPincode(res.getInt("pincode"));
                            city.setCityId(res.getInt("city"));
                            institute.setCity(city);
                            State state = new State();
                            state.setStateId(res.getInt("state"));
                            institute.setState(state);
                            per.setInstitute(institute);
                        }
                        pstmt = null;
                        //creating a query statement to get the values from person table
                        pstmt = con.prepareStatement("select head_title,headname,heademail,head_designation,head_contact,headaddress from academic where instituteid=? and streamid=? and isActive in (1,-1)");
                        //binding the parameter values to query statement
                        pstmt.setInt(1, instiId);
                        pstmt.setInt(2, streamId);
                        //executing the query.
                        res = pstmt.executeQuery();
                        if (res.next()) {
                            Institute institute = new Institute();
                            institute.setHeadName(res.getString("headname"));
                            institute.setHeadEmail(res.getString("heademail"));
                            HeadTitle headTitle = new HeadTitle();
                            headTitle.setHeadTitleId(res.getInt("head_title"));
                            institute.setHeadTitle(headTitle);
                            HeadDesignation headDesignation = new HeadDesignation();
                            headDesignation.setHeadDesignationId(res.getInt("head_designation"));
                            institute.setHeadDesignation(headDesignation);
                            institute.setHeadAddress(res.getString("headaddress"));
                            institute.setHeadContact(res.getString("head_contact"));
                            per.setHeadInstitute(institute);
                        }
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return per;
    }
    
    public Person getPersonInformation1(int userId) {
        //Variable declaration
        Person per = null;
        PreparedStatement pstmt1 = null;
        ResultSet res1 = null;
        int instiId, streamId = 0;
        try {
            if (con == null || con.isClosed()) { //checking whether connection is closed or null
                con = DBConnection.getDBConnection(); //if yes, getting the connection object
            }
            if (con != null) {//checking whether con is null or not.
//                //creating a query statement to check whether given userId exist or not.
//                pstmt = con.prepareStatement("select email from context where idcontext=?");
//                //binding the parameter values to query statement
//                pstmt.setInt(1, userId);
//                //executing the query.
//                res = pstmt.executeQuery();
//                //checking whether any person exist with this userid
//                if (res.next()) {//if exist then set all the details in Person class object.
//                    per = new Person();
//                    per.setLoginName(res.getString("email"));
//                    //getting values from person table
//                    pstmt = null;
//                    //creating a query statement to get the values from person table
//                    pstmt = con.prepareStatement("select title_id, firstname, lastname, designation, genderinfo,city,address, pincode,experience,qualification,instituteid, streamid from person where personid=?");
//                    //binding the parameter values to query statement
//                    pstmt.setInt(1, userId);
//                    //executing the query.
//                    res1 = pstmt.executeQuery();
//                    //checking whether any person exist with this userid
//                    if (res1.next()) {//if exist then set all the details in Person class object.
//                        per.setFirstName(res1.getString("firstname"));
//                        per.setLastName(res1.getString("lastname"));
//                        per.setAddress(res1.getString("address"));
//                        per.setGender(res1.getString("genderinfo"));
//                        per.setPincode(res1.getInt("pincode"));
//                        per.setExperience(res1.getString("experience"));
//                        City city = new City();
//                        city.setCityName(res1.getString("city"));
//                        per.setCity(city);
//                        Title title = new Title();
//                        title.setTitleId(res1.getInt("title_id"));
//                        per.setTitle(title);
//                        Designation designation = new Designation();
//                        designation.setDesignationId(res1.getInt("designation"));
//                        per.setDesignation(designation);
//                        Qualification qualification = new Qualification();
//                        qualification.setQualification(res1.getString("qualification"));
//                        per.setQualification(qualification);
//                        Stream stream = new Stream();
//                        stream.setStreamId(res1.getInt("streamid"));
//                        streamId = res1.getInt("streamid");
//                        per.setStream(stream);
//                        instiId = res1.getInt("instituteid");
//                        //creating a query statement to get the values from person table
//                        pstmt1 = con.prepareStatement("select mobile, homephone from context where idcontext=?");
//                        //binding the parameter values to query statement
//                        pstmt1.setInt(1, userId);
//                        //executing the query.
//                        res = pstmt1.executeQuery();
//                        if (res.next()) {
//                            per.setMobileNumber(res.getString("mobile"));
//                            per.setPhoneNumber(res.getString("homephone"));
//                        }
//                        pstmt1 = null;
//                        //creating a query statement to get the values from person table
//                        pstmt1 = con.prepareStatement("select idInstitute, Institutename,city,state,pincode,address from institute where idInstitute=?");
//                        //binding the parameter values to query statement
//                        pstmt1.setInt(1, instiId);
//                        //executing the query.
//                        res = pstmt1.executeQuery();
//                        if (res.next()) {
//                            Institute institute = new Institute();
//                            institute.setInstituteId(res.getInt("idInstitute"));
//                            institute.setInstituteName(res.getString("Institutename"));
//                            institute.setInstituteAddress(res.getString("address"));
//                            institute.setPincode(res.getInt("pincode"));
//                            city.setCityId(res.getInt("city"));
//                            institute.setCity(city);
//                            State state = new State();
//                            state.setStateId(res.getInt("state"));
//                            institute.setState(state);
//                            per.setInstitute(institute);
//                        }
//                        pstmt = null;
//                        //creating a query statement to get the values from person table
//                        pstmt = con.prepareStatement("select head_title,headname,heademail,head_designation,head_contact,headaddress from academic where instituteid=? and streamid=? and isActive in (1,-1)");
//                        //binding the parameter values to query statement
//                        pstmt.setInt(1, instiId);
//                        pstmt.setInt(2, streamId);
//                        //executing the query.
//                        res = pstmt.executeQuery();
//                        if (res.next()) {
//                            Institute institute = new Institute();
//                            institute.setHeadName(res.getString("headname"));
//                            institute.setHeadEmail(res.getString("heademail"));
//                            HeadTitle headTitle = new HeadTitle();
//                            headTitle.setHeadTitleId(res.getInt("head_title"));
//                            institute.setHeadTitle(headTitle);
//                            HeadDesignation headDesignation = new HeadDesignation();
//                            headDesignation.setHeadDesignationId(res.getInt("head_designation"));
//                            institute.setHeadDesignation(headDesignation);
//                            institute.setHeadAddress(res.getString("headaddress"));
//                            institute.setHeadContact(res.getString("head_contact"));
//                            per.setHeadInstitute(institute);
//                        }
//                    }
//                }

                pstmt = con.prepareStatement("select c.email, c.mobile, c.homephone , p.title_id, p.firstname, ifnull(p.lastname,'') as lastname, p.designation, p.genderinfo,p.city,p.address, p.pincode,p.experience,p.qualification,p.instituteid, p.streamid, IFNULL(i.idInstitute, 0) as idInstitute, i.Institutename, IFNULL(i.city, 0) as ins_city, IFNULL(i.state, 0) as state ,i.pincode,i.address,DATE_FORMAT(p.last_update,'%d %b %Y %h:%i %p') as last_updated from context c left join person p on c.idcontext=p.personid left join institute i on p.instituteid=i.idinstitute where c.idcontext=? ");
                //binding the parameter values to query statement
                pstmt.setInt(1, userId);
                //executing the query.
                res = pstmt.executeQuery();
                //checking whether any person exist with this userid
                if (res.next()) {//if exist then set all the details in Person class object.
                    per = new Person();
                    per.setLoginName(res.getString("email"));
                    per.setMobileNumber(res.getString("mobile"));
                    per.setPhoneNumber(res.getString("homephone"));
                    per.setFirstName(res.getString("firstname"));
                    per.setLastName(res.getString("lastname"));
                    per.setAddress(res.getString("address"));
                    per.setGender(res.getString("genderinfo"));
                    per.setPincode(res.getInt("pincode"));
                    per.setExperience(res.getString("experience"));
                    City city = new City();
                    city.setCityName(res.getString("city"));
                    per.setCity(city);
                    Title title = new Title();
                    title.setTitleId(res.getInt("title_id"));
                    per.setTitle(title);
                    Designation designation = new Designation();
                    designation.setDesignationId(res.getInt("designation"));
                    per.setDesignation(designation);
                    Qualification qualification = new Qualification();
                    qualification.setQualification(res.getString("qualification"));
                    per.setQualification(qualification);
                    Stream stream = new Stream();
                    stream.setStreamId(res.getInt("streamid"));
                    //  streamId = res1.getInt("streamid");
                    per.setStream(stream);
                    //  instiId = res1.getInt("instituteid");
                    Institute institute = new Institute();
                    institute.setInstituteId(res.getInt("idInstitute"));
                    institute.setInstituteName(res.getString("Institutename"));
                    institute.setInstituteAddress(res.getString("address"));
                    institute.setPincode(res.getInt("pincode"));
                    city.setCityId(res.getInt("ins_city"));
                    institute.setCity(city);
                    State state = new State();
                    state.setStateId(res.getInt("state"));
                    institute.setState(state);
                    per.setInstitute(institute);
                    per.setLast_login1(res.getString("last_updated"));
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return per;
    }
    
    public ArrayList getEmailIds() {
        ArrayList list = new ArrayList();
        try {
            if (con == null || con.isClosed()) { //checking whether connection is closed or null
                con = DBConnection.getDBConnection(); //if yes, getting the connection object
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select login_name from login");
                //executing the query.
                res = pstmt.executeQuery();
                //checking whether any person exist with this userid
                while (res.next()) {//if exist then set the values.
                    Person person = new Person();
                    person.setEmail(res.getString("login_name"));
                    list.add(person);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return list;
    }

    /**
     * Check if participant is already registered for the workshop
     *
     * @return result
     */
    public Participant checkParticipant(String workshopid, int loginid) {
        Participant participant = new Participant();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given user is registered for workshop already or not.
//                pstmt = con.prepareStatement("select p.participantid, p.status from participant p, accomodation a where a.participantid=p.participantid and a.workshopid=? and p.contextid=?");
                pstmt = con.prepareStatement("select p.participantid, p.status, per.firstname, per.lastname, i.institutename from participant p left join accomodation a on a.participantid=p.participantid "
                        + "left join person per on per.personid=p.personid  left join institute i on i.idinstitute=per.instituteid where a.workshopid=? and p.contextid=? and p.payment NOT IN ('refunded','refund initiated')");
                //binding the parameter values to query statement
                pstmt.setString(1, workshopid);
                pstmt.setInt(2, loginid);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    int pid = res.getInt("participantid");
                    String status = res.getString("status");
                    participant = new Participant();
                    participant.setParticipantid(pid);
                    participant.setIsAlreadyRegistered(1);
                    participant.setStatus(res.getString("status"));
                    if (status.equals("Request Approved") || status.equals("Confirmed") || status.equals("Cancelled") || status.equals("Completed")) {
                        participant.setIsNotValidForUpdate(1);
                    } else {
                        participant.setIsNotValidForUpdate(0);
                    }
                    //if exist the result is set to false                    
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participant;
    }
    
    public Participant insertParticipant(WorkshopContent content, Person person, Participant participant) {
        int result = 0;
        Participant p = new Participant();
        
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.

                pstmt = con.prepareStatement("select p.participantid from participant p, accomodation a where p.personid=? and a.participantid=p.participantid and a.workshopid=? and p.payment NOT IN ('refunded','refund initiated')");
                pstmt.setInt(1, person.getLoginId());
                pstmt.setInt(2, content.getWorkshopid());
                res = pstmt.executeQuery();
                if (res.next()) {
                    result = 0;
                } else {
                    //insert into participant, accomodation and letter tables.
                    int participantid = getMaxParticipantid();
                    if (participantid != 0) {
                        //  create a java calendar instance
                        Calendar calendar = Calendar.getInstance();
                        //  get a java.util.Date from the calendar instance.
                        //    this date will represent the current instant, or "now".
                        java.util.Date now = calendar.getTime();
                        // a java current time (now) instance
                        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());
                        //    pstmt = con.prepareStatement("INSERT INTO `participant`(`participantid`, `contextid`, `personid`, `experience`, `qualification`, `instituteid_streamid`, `status`, `regtime`) VALUES (?,?,?,?,?,?,?,?)");

                        Person person1 = getPersonInformation(person.getLoginId());
                        if (con == null || con.isClosed()) {
                            con = DBConnection.getDBConnection();
                        }
                        
                        pstmt = con.prepareStatement("INSERT INTO `participant`(`participantid`, `contextid`, `personid`, `experience`, `qualification`, `instituteid_streamid`, `status`, `regtime`,instituteid,streamid) VALUES (?,?,?,?,?,?,?,?,?,?)");
                        //binding the parameter values to query statement
                        pstmt.setInt(1, participantid);
                        pstmt.setInt(2, person.getLoginId());
                        pstmt.setInt(3, person.getLoginId());
                        pstmt.setString(4, person.getExperience());
                        pstmt.setString(5, person.getQualification().getQualification());
                        pstmt.setString(6, person1.getInstitute().getInstituteId() + "_" + person1.getStream().getStreamId());
                        pstmt.setString(7, "Request Registered");
                        pstmt.setTimestamp(8, currentTimestamp);
                        //Added by Sheweta
                        pstmt.setInt(9, person1.getInstitute().getInstituteId());
                        pstmt.setInt(10, person1.getStream().getStreamId());
                        //executing the query.
                        int resultUpdated = pstmt.executeUpdate();
                        if (resultUpdated > 0) {
                            //insert into letter
                            pstmt = con.prepareStatement("INSERT INTO `letter`(`participantid`, `workshopid`, `letter`) VALUES (?,?,?)");
                            pstmt.setInt(1, participantid);
                            pstmt.setInt(2, content.getWorkshopid());
                            if (content.getCategorycode() == 8) {
                                if (content.getFacultyFlag().equals("1")) {
                                    pstmt.setString(3, "permissionLetter_" + participantid + ".jpg");
                                } else {
                                    pstmt.setString(3, "");
                                }
                                
                            } else {
                                pstmt.setString(3, "permissionLetter_" + participantid + ".jpg");
                            }
                            int resultUpdated1 = pstmt.executeUpdate();
                            if (resultUpdated1 > 0) {

                                //check if user is already enrolled for workshop
                                pstmt = con.prepareStatement("select p.participantid from participant p, accomodation a where p.personid=? and a.participantid=p.participantid and a.workshopid=? and p.payment NOT IN ('refunded','refund initiated')");
                                pstmt.setInt(1, person.getLoginId());
                                pstmt.setInt(2, content.getWorkshopid());
                                res = pstmt.executeQuery();
                                if (res.next()) {
                                    // delete the entries from letter and participant table
                                    pstmt = con.prepareStatement("delete p,l from participant p, letter l where l.participantid=p.participantid and p.participantid=?");
                                    pstmt.setInt(1, participantid);
                                    pstmt.execute();
                                    result = 0;
                                } else {
                                    if (content.getRespectiveCoWorkshopid() > 0 && content.getCategorycode() == 4) {
                                        pstmt = con.prepareStatement("INSERT INTO `accomodation`(`participantid`, `workshopid`, `instituteid`, `accomodation`, `ins_same_as_rc`) VALUES (?,?,?,?,?)");
                                        pstmt.setInt(1, participantid);
                                        pstmt.setInt(2, content.getWorkshopid());
                                        pstmt.setInt(3, participant.getRcid());
                                        // insert as yes and no
                                        String accommodation = "No";
                                        if (participant.getAccomodation() == 1) {
                                            accommodation = "Yes";
                                        }
                                        pstmt.setString(4, accommodation);
                                        // set if ins is rc
                                        pstmt.setInt(5, participant.getIf_institute_is_rc());
                                    } else {
                                        pstmt = con.prepareStatement("INSERT INTO `accomodation`(`participantid`, `workshopid`, `instituteid`, `accomodation`) VALUES (?,?,?,?)");
                                        pstmt.setInt(1, participantid);
                                        pstmt.setInt(2, content.getWorkshopid());
                                        pstmt.setInt(3, participant.getRcid());
                                        // insert as yes and no
                                        String accommodation = "No";
                                        if (participant.getAccomodation() == 1) {
                                            accommodation = "Yes";
                                        }
                                        pstmt.setString(4, accommodation);
                                    }
                                    int resultUpdated2 = pstmt.executeUpdate();
                                    if (resultUpdated2 > 0) {
                                        //set Participant id
                                        p.setParticipantid(participantid);
                                        result = 1;
                                        /*
                                         * updating participant status as
                                         * 'Confirmed' if IITB-x workshops
                                         */
//                                if (content.getCategorycode() == 4 && content.getRespectiveCoWorkshopid() != 0) {
//                                    pstmt = con.prepareStatement("update participant set status='Confirmed' where participantid=? ");
//                                    pstmt.setInt(1, participantid);
//                                    int res1 = pstmt.executeUpdate();
//                                }
                                    } else {
                                        //delete entries of accomodation, participant and letter
                                        result = 0;
                                    }
                                }
                            } else {
                                // delete participant and letter entry
                                result = 0;
                            }
                            
                        } else {
                            //delete the participant table entry and set result 0
                            result = 0;
                        }
                        
                    } else {
                        result = 0;
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return p;
    }
    
    public Participant updateParticipant(WorkshopContent content, Person person, Participant participant) {
        int result = 0;
        Participant p = new Participant();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //insert into participant, accomodation and letter tables.
                int participantid = participant.getParticipantid();
                if (participantid != 0) {
                    //  create a java calendar instance
                    Calendar calendar = Calendar.getInstance();
                    //  get a java.util.Date from the calendar instance.
                    //    this date will represent the current instant, or "now".
                    java.util.Date now = calendar.getTime();
                    // a java current time (now) instance
                    java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());
                    //    pstmt = con.prepareStatement("INSERT INTO `participant`(`participantid`, `contextid`, `personid`, `experience`, `qualification`, `instituteid_streamid`, `status`, `regtime`) VALUES (?,?,?,?,?,?,?,?)");

                    Person person1 = getPersonInformation(person.getLoginId());
                    if (con == null || con.isClosed()) {
                        con = DBConnection.getDBConnection();
                    }
                    pstmt = con.prepareStatement("UPDATE participant SET experience=? , qualification=?,instituteid_streamid=?,status=?,instituteid=?,streamid=? WHERE participantid=?");
                    //binding the parameter values to query statement

                    pstmt.setString(1, person.getExperience());
                    pstmt.setString(2, person.getQualification().getQualification());
                    pstmt.setString(3, person1.getInstitute().getInstituteId() + "_" + person1.getStream().getStreamId());
                    pstmt.setString(4, "Request Registered");

                    //Added by Sheweta
                    pstmt.setInt(5, person1.getInstitute().getInstituteId());
                    pstmt.setInt(6, person1.getStream().getStreamId());
                    pstmt.setInt(7, participantid);
                    //executing the query.
                    int resultUpdated = pstmt.executeUpdate();
                    if (resultUpdated > 0) {
                        //insert into letter
                        if (content.getCategorycode() == 8) {
                            if (content.getFacultyFlag().equals("1")) {
                                pstmt = con.prepareStatement("update letter set verified=?,letter=? where participantid=?");
                                pstmt.setInt(3, participantid);
                                pstmt.setInt(1, 0);
                                pstmt.setString(2, "permissionLetter_" + participantid + ".jpg");
                            } else {
                                pstmt = con.prepareStatement("update letter set verified=? where participantid=?");
                                pstmt.setInt(2, participantid);
                                pstmt.setInt(1, 0);
                            }
                            
                        } else {
                            pstmt = con.prepareStatement("update letter set verified=? where participantid=?");
                            pstmt.setInt(2, participantid);
                            pstmt.setInt(1, 0);
                        }
                        int resultUpdated1 = pstmt.executeUpdate();
                        if (resultUpdated1 > 0) {
                            pstmt = con.prepareStatement("update accomodation set instituteid=?, accomodation=? where participantid=?");
                            pstmt.setInt(1, participant.getRcid());
                            // insert as yes and no
                            String accommodation = "No";
                            if (participant.getAccomodation() == 1) {
                                accommodation = "Yes";
                            }
                            pstmt.setString(2, accommodation);
                            pstmt.setInt(3, participantid);
                            int resultUpdated2 = pstmt.executeUpdate();
                            if (resultUpdated2 > 0) {
                                //set Participant id
                                pstmt = con.prepareStatement("select r.remotecentername, ci.city from remotecenter r, city ci where remotecenterid=? and r.city=ci.cityid");
                                pstmt.setInt(1, participant.getRcid());
                                res = pstmt.executeQuery();
                                if (res.next()) {
                                    p.setRcname(res.getString("remotecentername") + ", " + res.getString("city"));
                                }
                                p.setParticipantid(participantid);
                                result = 1;
                            } else {
                                //delete entries of accomodation, participant and letter
                                result = 0;
                            }
                        } else {
                            // delete participant and letter entry
                            result = 0;
                        }
                        
                    } else {
                        //delete the participant table entry and set result 0
                        result = 0;
                    }
                } else {
                    result = 0;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return p;
    }
    
    public int getMaxParticipantid() {
        int participantid = 0;
        try {
            pstmt = con.prepareStatement("select max(participantid) as participantid from participant");
            res = pstmt.executeQuery();
            while (res.next()) {
                participantid = res.getInt("participantid") + 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
        }
        return participantid;
    }

    /**
     * getLoginStatus() methods will return the loginstatus of particular user.
     * This method search the given email in the login table, if found then
     * return loginstatus otherwise return 0.
     *
     * @param email login_name to be checked.
     * @return It returns integer result depending upon loginstatus
     *
     */
    public int getLoginStatus(String email) {
        //creatinga a boolean variable result (by default true)
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select loginstatus from login where login_name=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set with loginstatus
                    result = res.getInt("loginstatus");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }
    
    public synchronized int insertExistingUserDataInLogin(Person person) {
        int updated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                //pstmt = con.prepareStatement("update login set password = md5(?) where login_id=?");
                pstmt = con.prepareStatement("insert into login(login_id,login_name,password,usertypeid,loginstatus) values(?,?,md5(?),?,?)");
                //binding the parameter values to query statement
                pstmt.setInt(1, person.getLoginId());
                pstmt.setString(2, person.getLoginName());
                pstmt.setString(3, person.getPassword());
                pstmt.setInt(4, person.getRoleId());
                pstmt.setInt(5, 1);
                updated = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return updated;
    }

    /**
     * Check if participant is already registered for the workshop
     *
     * @return result
     */
    public int checkRCAlreadyPresent(int workshopid, int rcid) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given rcid is already registered for workshop.
                pstmt = con.prepareStatement("select a.participantid  from accomodation  a, participant p where p.participantid=a.participantid and p.status!='Cancelled' and a.instituteid=? and a.workshopid=?");
                //binding the parameter values to query statement
                pstmt.setInt(2, workshopid);
                pstmt.setInt(1, rcid);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    int pid = res.getInt("participantid");
                    //if exist the result is set to false
                    if (pid > 0) {
                        result = 1;
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }
    
    public boolean isLoginEmailAvailable(String email) {
        //creatinga a boolean variable result (by default true)
        boolean result = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select email from context c,login l where c.email=l.login_name and c.email=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    result = true;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }
    
    public Participant getParticipantName(int loginid) {
        Participant participant = new Participant();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given user is registered for workshop already or not.
//                pstmt = con.prepareStatement("select p.participantid, p.status from participant p, accomodation a where a.participantid=p.participantid and a.workshopid=? and p.contextid=?");
                pstmt = con.prepareStatement("select  per.firstname, ifnull(per.lastname,'') as lastname, i.institutename from  person per left join institute i on per.instituteid=i.idinstitute  where  per.personid=? ");
                //binding the parameter values to query statement
                pstmt.setInt(1, loginid);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.                    
                    participant = new Participant();
                    //set institute and name
                    participant.setName(res.getString("firstname") + " " + res.getString("lastname"));
                    Institute institute = new Institute();
                    institute.setInstituteName(res.getString("institutename"));
                    participant.setInstitute(institute);
                    //if exist the result is set to false                    
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participant;
    }
    
    public Person getParticipantDetails(String workshopid, int loginid) throws Exception {
        Person participantdetail = new Person();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given user is registered for workshop already or not.
//                pstmt = con.prepareStatement("select p.participantid, p.status from participant p, accomodation a where a.participantid=p.participantid and a.workshopid=? and p.contextid=?");
//                pstmt = con.prepareStatement("select  per.firstname, per.lastname, i.institutename, i.idinstitute as ins_id , i.city as ins_city, i.state as ins_state, a.instituteid, r.state, a.accomodation from  person per, institute i, remotecenter r, accomodation a, participant p where  a.participantid=p.participantid and p.personid=per.personid and a.instituteid=r.remotecenterid and  per.instituteid=i.idinstitute and per.personid=?  and a.workshopid=?");
                pstmt = con.prepareStatement("select  per.firstname, ifnull(per.lastname,'') as lastname, i.institutename, IFNULL(i.idinstitute,0) as ins_id , IFNULL(i.city,0) as ins_city, IFNULL(i.state,0) as ins_state, a.instituteid, r.state, a.accomodation from accomodation a left join participant p on a.participantid=p.participantid     left join person per on  p.personid=per.personid left join institute i on per.instituteid=i.idinstitute left join remotecenter r on a.instituteid=r.remotecenterid where per.personid=? and a.workshopid=?");
                //binding the parameter values to query statement
                pstmt.setInt(1, loginid);
                pstmt.setString(2, workshopid);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.                    
                    participantdetail = new Person();
                    participantdetail.setFirstName(res.getString("firstname"));
                    participantdetail.setLastName(res.getString("lastname"));
                    // set accomodation
                    RegistrationDetails details = new RegistrationDetails();
                    details.setAccomodation(res.getString("accomodation"));
                    participantdetail.setRegistrationDetails(details);
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String rcid = res.getString("instituteid");
                    String enc_rc = cipher.encrypt(rcid);
                    RemoteCenter remotecenter = new RemoteCenter();
                    remotecenter.setRemoteCenterId(res.getInt("instituteid"));
                    remotecenter.setEnc_RC(enc_rc);
                    remotecenter.setRc_state(res.getString("state"));
                    participantdetail.setRemoteCenter(remotecenter);
                    //set institute and name
                    Institute institute = new Institute();
                    institute.setInstituteName(res.getString("institutename"));
                    institute.setInstituteId(res.getInt("ins_id"));
                    City city = new City();
                    city.setCityId(res.getInt("ins_city"));
                    institute.setCity(city);
                    State state_ins = new State();
                    state_ins.setStateId(res.getInt("ins_state"));
                    institute.setState(state_ins);
                    participantdetail.setInstitute(institute);
                    //if exist the result is set to false                    
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return participantdetail;
    }
    
    public synchronized int UpdateUser1(Person person, String browser, String os, WorkshopContent wc, Participant participant) throws Exception {
        int isUserUpdated = ErrorCode.ERROR;
        int id = 0;
        int update = 0;
        int updated = 0;
        int instituteResultUpdated = 0;
        int instituteId = 0;
        int isLogsUpdated = 0;
        boolean isExist = false;
        int updateNew = 0;
        boolean isLatest = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("update context set mobile=?, homephone=?, email_verified=? where email=?");
                pstmt.setString(1, person.getMobileNumber());
                pstmt.setString(2, person.getPhoneNumber());
                pstmt.setInt(3, 0);
                pstmt.setString(4, person.getEmail());
                int resultUpdated = pstmt.executeUpdate();
                if (resultUpdated > 0) {
                    pstmt = con.prepareStatement("select idcontext from context where email = ?");
                    pstmt.setString(1, person.getEmail());
                    res = pstmt.executeQuery();
                    if (res.next()) {
                        id = res.getInt("idcontext");
                    }
                    boolean isLoginExist = isLoginExist(person.getEmail());
                    if (isLoginExist) {
                        pstmt = con.prepareStatement("update login set login_id= ?, login_name=?, ipaddress=? where login_name=?");
                        pstmt.setInt(1, id);
                        pstmt.setString(2, person.getLoginName());
                        pstmt.setString(3, person.getIpAddress());
                        pstmt.setString(4, person.getLoginName());
                        updated = pstmt.executeUpdate();
                    } else {
                        pstmt = con.prepareStatement("insert into login(login_id,login_name, usertypeid, ipaddress) values(?,?,?,?)");
                        pstmt.setInt(1, id);
                        pstmt.setString(2, person.getLoginName());
                        pstmt.setInt(3, 1);
                        pstmt.setString(4, person.getIpAddress());
                        updated = pstmt.executeUpdate();
                    }
                    if (updated > 0) {
                        int idInstitute = 0;
                        if (Integer.parseInt(person.getFacultyStatus()) == 1) {
                            idInstitute = isInstituteExist(person.getInstitute().getInstituteName());
                        }
                        if (con == null || con.isClosed()) {
                            con = DBConnection.getDBConnection();
                        }
                        if (idInstitute < 0) {
                        } else {
                            //check if latest workshop, if so update person.

//                            isLatest = checkIfLatestWorkshop(wc.getWorkshopid());
//                            if (con == null || con.isClosed()) {
//                                con = DBConnection.getDBConnection();
//                            }
//                            if (isLatest == true) {
                            pstmt = con.prepareStatement("update person set title_id=?,firstname=?,lastname=?,designation=?,genderinfo=?,city=?,address=?,pincode=?,experience=?, qualification=?,instituteid=?,streamid=? where personid=?");
                            pstmt.setInt(1, person.getTitle().getTitleId());
                            pstmt.setString(2, capitalizeString(person.getFirstName()));
                            if (!person.getLastName().equals("") || !person.getLastName().equals(null)) {
                                pstmt.setString(3, capitalizeString(person.getLastName()));
                            } else {
                                pstmt.setString(3, "");
                            }
                            if (person.getFacultyStatus().equals("1")) {
                                pstmt.setInt(4, person.getDesignation().getDesignationId());
                                pstmt.setString(9, person.getExperience());
                                pstmt.setInt(11, person.getInstitute().getInstituteId());
                                
                            } else {
                                pstmt.setInt(4, 0);
                                pstmt.setString(9, null);
                                pstmt.setInt(11, 0);
                            }
                            pstmt.setString(5, person.getGender());
                            pstmt.setString(6, person.getCity().getCityName());
                            pstmt.setString(7, person.getAddress());
                            pstmt.setInt(8, person.getPincode());
                            pstmt.setString(10, person.getQualification().getQualification());
                            pstmt.setInt(12, person.getStream().getStreamId());
                            pstmt.setInt(13, id);
                            update = pstmt.executeUpdate();
                            if (update > 0) {
                                isExist = isInstituteAndStreamExist(person.getInstitute().getInstituteId(), person.getStream().getStreamId());
                                if (con == null || con.isClosed()) {
                                    con = DBConnection.getDBConnection();
                                }
                                pstmt = con.prepareStatement("insert into logs(ip_address,user_id,browser_used,os_used) values(?,?,?,?)");
                                pstmt.setString(1, person.getIpAddress());
                                pstmt.setInt(2, id);
                                pstmt.setString(3, browser);
                                pstmt.setString(4, os);
                                isLogsUpdated = pstmt.executeUpdate();
                            } else {
                                con.rollback();
                                isUserUpdated = ErrorCode.ERROR;
                            }
//                            }
                            // update participant table, accommodation 
                            int participant_check = getParticipantID(person.getEmail(), Integer.toString(wc.getWorkshopid()));
                            
                            if (participant_check > 0) {
                                participant.setParticipantid(participant_check);
                                if (con == null || con.isClosed()) {
                                    con = DBConnection.getDBConnection();
                                }
                                // update participant table
                                pstmt = con.prepareStatement("UPDATE participant SET experience=? , qualification=?,instituteid_streamid=?,instituteid=?,streamid=? WHERE participantid=?");
                                //binding the parameter values to query statement
                                if (person.getFacultyStatus().equals("1")) {
                                    pstmt.setString(1, person.getExperience());
                                    pstmt.setString(3, person.getInstitute().getInstituteId() + "_" + person.getStream().getStreamId());
                                    pstmt.setInt(4, person.getInstitute().getInstituteId());
                                } else {
                                    pstmt.setString(1, null);
                                    pstmt.setString(3, 0 + "_" + person.getStream().getStreamId());
                                    pstmt.setInt(4, 0);
                                }
                                
                                pstmt.setString(2, person.getQualification().getQualification());
                                pstmt.setInt(5, person.getStream().getStreamId());
                                pstmt.setInt(6, participant.getParticipantid());
                                //executing the query.
                                int resultUpdated1 = pstmt.executeUpdate();
                                if (resultUpdated1 > 0) {
                                    pstmt = con.prepareStatement("update letter set verified=? , letter=? where participantid=?");
                                    pstmt.setInt(3, participant.getParticipantid());
                                    if (person.getFacultyStatus().equals("1")) {
                                        pstmt.setString(2, "permissionLetter_" + participant.getParticipantid() + ".jpg");
                                    } else {
                                        pstmt.setString(2, "");
                                    }
                                    pstmt.setInt(1, 1);
                                    pstmt.executeUpdate();
                                    
                                    participant.getRcid();
                                    participant.getParticipantid();
                                    
                                    pstmt = con.prepareStatement("update accomodation set instituteid=?, accomodation=? where participantid=?");
                                    pstmt.setInt(1, participant.getRcid());
                                    // insert as yes and no
                                    String accommodation = "No";
                                    if (participant.getAccomodation() == 1) {
                                        accommodation = "Yes";
                                    }
                                    pstmt.setString(2, accommodation);
                                    pstmt.setInt(3, participant.getParticipantid());
                                    int resultUpdated2 = pstmt.executeUpdate();
                                    if (resultUpdated2 > 0) {
                                        isUserUpdated = participant.getParticipantid();
                                    } else {
                                        isUserUpdated = ErrorCode.ERROR;
                                    }
                                }
                            } else {
                                isUserUpdated = ErrorCode.ERROR;
                            }
                        }
                    } else {
                        con.rollback();
                        isUserUpdated = ErrorCode.ERROR;
                    }
                } else {
                    con.rollback();
                    isUserUpdated = ErrorCode.ERROR;
                }
            }
        } catch (SQLException sqle) {
            isUserUpdated = ErrorCode.SQLEXCEPTION;
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return isUserUpdated;
    }
    
    public boolean checkIfLatestWorkshop(int workshopid) {
        boolean isLatest = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given user is registered for workshop already or not.
//                pstmt = con.prepareStatement("select p.participantid, p.status from participant p, accomodation a where a.participantid=p.participantid and a.workshopid=? and p.contextid=?");
                pstmt = con.prepareStatement("SELECT  DATEDIFF( max(startdate) , (select startdate from workshops where workshopid= ?)) as datediff from workshops");
                //binding the parameter values to query statement
                pstmt.setInt(1, workshopid);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.                    
                    int datediff = res.getInt("datediff");
                    if (datediff == 0) {
                        isLatest = true;
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return isLatest;
    }
    
    public int getParticipantID(String email, String workshopid) {
        //creatinga a boolean variable result (by default true)
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select p.participantid from participant p, context c , accomodation a where c.email=? and a.workshopid=? and a.participantid=p.participantid and c.idcontext=p.contextid");
                //binding the parameter values to query statement
                pstmt.setString(1, email);
                pstmt.setString(2, workshopid);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    result = res.getInt("participantid");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }
    
    public RemoteCenter getRemoteCenterName(int rcid) {
        RemoteCenter rc = new RemoteCenter();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given user is registered for workshop already or not.
//                pstmt = con.prepareStatement("select p.participantid, p.status from participant p, accomodation a where a.participantid=p.participantid and a.workshopid=? and p.contextid=?");
                pstmt = con.prepareStatement("select r.remotecentername, ci.city from remotecenter r, city ci where remotecenterid=? and r.city=ci.cityid");
                //binding the parameter values to query statement
                pstmt.setInt(1, rcid);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) {
                    
                    rc = new RemoteCenter();
                    rc.setRemoteCenterName(res.getString("remotecentername"));
                    rc.setRc_city(res.getString("city"));
                    rc.setRemoteCenterId(rcid);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return rc;
    }

    /**
     * isUsernameAvailable() methods checks whether the email exist or not. This
     * method search the given email in the context table, if found then return
     * false otherwise true.
     *
     * @param email email to be checked.
     * @return It returns true or false depending upon availability of email
     */
    public boolean isUsernameAvailable(String username) {
        //creatinga a boolean variable result (by default true)
        boolean result = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select username from login where username=?");
                //binding the parameter values to query statement
                pstmt.setString(1, username);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    result = true;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }
    
    public String getUserCityFromPerson(int stateid, int cityid) {
        String cityname = null;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("select city from city where stateid=? and cityid=? and isActive=1");
                // pstmt.setInt(1, 5000020);
                pstmt.setInt(1, stateid);
                pstmt.setInt(2, cityid);
                res = pstmt.executeQuery();
                while (res.next()) {
                    cityname = res.getString("city");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return cityname;
    }

    /**
     * Check if participant is already registered for the workshop
     *
     * @return result
     */
    public int checkIfUsernameUpdated(int loginid, String filepath) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given rcid is already registered for workshop.
//                pstmt = con.prepareStatement("SELECT IFNULL(l.username, 0) as username, IFNULL(p.yearofbirth,0) as yearofbirth  from login l, person p where p.personid=l.login_id and l.login_id=?");
//                //binding the parameter values to query statement
//                pstmt.setInt(1, loginid);
//                //executing the query.
//                res = pstmt.executeQuery();
//                if (res.next()) { //checking if userid exist or not.
//                    String username = res.getString("username");
//                    int yearOfBirth = res.getInt("yearofbirth");
//                }
                //if exist the result is set to false
                /*
                 * check if the user Image of the person exist
                 */
                int ifFileExist = 0;
                File f = new File(filepath);
                if (f.exists()) {
                    ifFileExist = 1;
                }
//                    if (!username.equals("0") && yearOfBirth > 0 && ifFileExist == 1) {
                if (ifFileExist == 1) {
                    result = 1;
                } else {
                    result = 0;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }
    
    public int checkIfNotAValidParticipant(int loginid, String workshopid) {
        int result = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given rcid is already registered for workshop.
                pstmt = con.prepareStatement("select (SELECT  `respective_coordinatorid`  from workshops where workshopid=?) as rescoord_id1, (select respective_coordinatorid from workshops where workshopid =(select respective_coordinatorid from workshops where workshopid=?)) as rescoord_id2 ");
                //binding the parameter values to query statement
                pstmt.setString(1, workshopid);
                pstmt.setString(2, workshopid);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    int workshop1 = res.getInt("rescoord_id1");
                    int workshop2 = res.getInt("rescoord_id2");
                    //if exist the result is set to false
                    if (workshop1 != 0) {
                        pstmt = con.prepareStatement("select p.participantid, p.status from participant p, person per, accomodation a where a.participantid=p.participantid and per.personid=p.personid and p.personid=? and a.workshopid=? and p.status='Completed'");
                        pstmt.setInt(1, loginid);
                        pstmt.setInt(2, workshop1);
                        res = pstmt.executeQuery();
                        if (res.next()) {
                            result = res.getInt("p.participantid");
                        } else if (workshop2 != 0) {
                            pstmt = con.prepareStatement("select p.participantid, p.status from participant p, person per, accomodation a where a.participantid=p.participantid and per.personid=p.personid and p.personid=? and a.workshopid=? and p.status='Completed'");
                            pstmt.setInt(1, loginid);
                            pstmt.setInt(2, workshop2);
                            res = pstmt.executeQuery();
                            if (res.next()) {
                                result = res.getInt("p.participantid");
                            }
                        }
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return result;
    }
    
    public ArrayList<UserDashboard> getDashBoardInfo(String email) throws Exception {
        ArrayList<UserDashboard> details = new ArrayList<UserDashboard>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                // setting variable for UserDashBoard
                UserDashboard detail;

                //creating a query statement to check whether given userId exist or not.
//                pstmt = con.prepareStatement("select w.workshopname, a.workshopid, p.participantid, p.status, c.email from accomodation a left join participant p on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join workshops w on  w.workshopid=a.workshopid where p.contextid IN ( select idcontext from context where email=?)");
                pstmt = con.prepareStatement("select w.workshopname,w.categorycode,w.workshopid, DATE_FORMAT( w.startdate, '%d-%m-%Y' ) AS startdate,date_format(w.startdate,'%b - %Y') date,ifnull(w.rc_payment_if_required,0) as rc_payment_if_required,p.status,c.email, c.idcontext, p.regtime, p.participantid, rc.email as rcc_email, w.feeamount,ifnull(w.datetobedisplayed,1) as datetobedisplayed, "
                        + "p.payment,w.lastdateforappli as checksdate,w.startdateofappli, w.withdrawal_button_tbd from accomodation a,(select * from participant order by field(status,'Confirmed','Moodle Accessed','Request Confirmed' ,'Completed','Approved','Elig. Approved','Request Approved','Registration Invalid','Rejected' ,'enrolled','Prov. Enrolled','Registered','Request Registered','','1','Cancelled','incomplete' "
                        + ",'Request Verified','Waiting','Waitlisted','Withdrawn')) p , context c,workshops w, remotecenter rc where w.workshopid=a.workshopid and p.participantid =a.participantid and p.contextid =c.idcontext and rc.remotecenterid = a.instituteid and c.email =?  and p.payment NOT IN ('refund initiated','refunded')  group by w.workshopname,w.workshopid,date_format(w.startdate,'%b - %Y'),c.email order by w.startdate desc");

                //binding the parameter values to query statement
                pstmt.setString(1, email);
                //executing the query.
                res = pstmt.executeQuery();
                while (res.next()) {
                    detail = new UserDashboard();
                    //checking if userid exist or not.
                    //if exist the result is set to false
                    Person person = new Person();
                    person.setLoginId(res.getInt("idcontext"));
                    person.setLoginName(res.getString("email"));
                    detail.setPerson(person);
                    RegistrationDetails registrationDetails = new RegistrationDetails();
                    registrationDetails.setStatus(res.getString("status"));
                    registrationDetails.setParticipantid(res.getString("participantid"));
                    registrationDetails.setRcc_email(res.getString("rcc_email"));
                    registrationDetails.setPayment(res.getString("payment"));
                    registrationDetails.setChecksDate(res.getString("checksdate"));
                    detail.setRegistrationDetails(registrationDetails);
                    WorkshopContent content = new WorkshopContent();

                    // check if the workshop already started
                    java.util.Date now = new java.util.Date();
                    SimpleDateFormat dmy = new SimpleDateFormat("dd-MM-yyyy");
                    
                    java.util.Date startdate = dmy.parse(res.getString("startdate"));
                    content.setWorkshopExpiry(0);
                    if (startdate.before(now)) {
                        content.setWorkshopExpiry(1);
                    }
                    
                    content.setWorkshopname(res.getString("workshopname"));
                    content.setWorkshopid(res.getInt("workshopid"));
                    content.setStartdate(res.getString("date"));
                    content.setCategorycode(res.getInt("categorycode"));
                    content.setStartdatereg(res.getString("startdateofappli"));
                    content.setDateToBeDisplayed(res.getInt("datetobedisplayed"));
                    content.setPayment_at_rc(res.getInt("rc_payment_if_required"));
                    content.setWithdrawal_flag(res.getInt("withdrawal_button_tbd"));
                    detail.setWorkshops(content);
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String enc_workshopid = cipher.encrypt(res.getString("workshopid"));
                    detail.setSchedule_url("viewProgramSchedule.html?workshopid=" + enc_workshopid);
                    PaymentGateway pg = new PaymentGateway();
                    pg.setTotalAmt(res.getString("feeamount"));
                    detail.setPaymentgateway(pg);
                    details.add(detail);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return details;
    }
    
    public String[] doesIdExist_PrivateWorkshop(String id) {
        //creatinga a boolean variable result (by default true)
        String[] result = new String[2];
        result[0] = "notExist";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select workshopid, email from partuserdata where userinterfaceid=?");
                //binding the parameter values to query statement
                pstmt.setString(1, id);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    result[0] = "exist";
                    result[1] = res.getString("workshopid");
                    String email = res.getString("email");
                    // check if email exist in context table
                    pstmt = con.prepareStatement("select idcontext from context where email=?");
                    pstmt.setString(1, email);
                    res = pstmt.executeQuery();
                    if (res.next()) {
                        result[0] = res.getString("idcontext");
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
        }
        //return the result
        return result;
    }
    
    public boolean isUsernameAvailable1(String id) {
        //creatinga a boolean variable result (by default true)
        boolean result = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select username from login where login_id=?");
                //binding the parameter values to query statement
                pstmt.setString(1, id);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    result = true;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }
    
    public Person getPartUserData(String id) {
        //creatinga a Person
        Person person = new Person();
        
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select * from partuserdata where userinterfaceid=?");
                //binding the parameter values to query statement
                pstmt.setString(1, id);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    person.setFirstName(res.getString("firstname"));
                    person.setLastName(res.getString("lastname"));
                    person.setEmail(res.getString("email"));
                    person.setAddress(res.getString("homeaddress"));
                    person.setGender(res.getString("Gender"));
                    person.setPincode(res.getInt("pincode"));
                    if (res.getString("experience") != null) {
                        person.setExperience((res.getString("experience")).trim());
                    } else {
                        person.setExperience("");
                    }
                    City city = new City();
//                    city.setCityName(res.getString("city"));
//                    person.setCity(city);
                    Title title = new Title();
                    title.setTitleId(res.getInt("titleid"));
                    person.setTitle(title);
                    Designation designation = new Designation();
                    designation.setDesignationId(res.getInt("designationid"));
                    person.setDesignation(designation);
                    Qualification qualification = new Qualification();
                    if (res.getString("qualification") != null) {
                        qualification.setQualification((res.getString("qualification")).trim());
                    } else {
                        qualification.setQualification("");
                    }
                    person.setQualification(qualification);
                    Stream stream = new Stream();
                    stream.setStreamId(res.getInt("streamid"));
                    int streamId = res.getInt("streamid");
                    person.setStream(stream);
                    int instiId = res.getInt("instituteid");
//                    person.setImage(res.getString("image"));

                    person.setMobileNumber(res.getString("mobileno"));
                    person.setPhoneNumber(res.getString("contactno"));
                    person.setStateId(res.getInt("stateid"));
//                    person.setCityId(res.getInt("city"));

                    //creating a query statement to get the values from person table
                    pstmt1 = con.prepareStatement("select idInstitute, Institutename,city,state,pincode,address from institute where idInstitute=?");
                    //binding the parameter values to query statement
                    pstmt1.setInt(1, instiId);
                    //executing the query.
                    res = pstmt1.executeQuery();
                    if (res.next()) {
                        Institute institute = new Institute();
                        institute.setInstituteId(res.getInt("idInstitute"));
                        institute.setInstituteName(res.getString("Institutename"));
                        institute.setInstituteAddress(res.getString("address"));
                        institute.setPincode(res.getInt("pincode"));
                        city.setCityId(res.getInt("city"));
                        institute.setCity(city);
                        State state = new State();
                        state.setStateId(res.getInt("state"));
                        institute.setState(state);
                        person.setInstitute(institute);
                    }
                    pstmt = null;
                    //creating a query statement to get the values from person table
                    pstmt = con.prepareStatement("select head_title,headname,heademail,head_designation,head_contact,headaddress from academic where instituteid=? and streamid=? and isActive in (1,-1)");
                    //binding the parameter values to query statement
                    pstmt.setInt(1, instiId);
                    pstmt.setInt(2, streamId);
                    //executing the query.
                    res = pstmt.executeQuery();
                    if (res.next()) {
                        Institute institute = new Institute();
                        institute.setHeadName(res.getString("headname"));
                        institute.setHeadEmail(res.getString("heademail"));
                        HeadTitle headTitle = new HeadTitle();
                        headTitle.setHeadTitleId(res.getInt("head_title"));
                        institute.setHeadTitle(headTitle);
                        HeadDesignation headDesignation = new HeadDesignation();
                        headDesignation.setHeadDesignationId(res.getInt("head_designation"));
                        institute.setHeadDesignation(headDesignation);
                        institute.setHeadAddress(res.getString("headaddress"));
                        institute.setHeadContact(res.getString("head_contact"));
                        person.setHeadInstitute(institute);
                    }
                    
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return person;
    }
    
    public boolean isEmailAvailableInLogin(String email) {
        //creatinga a boolean variable result (by default true)
        boolean result = false;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not in login.
                pstmt = con.prepareStatement("select login_name from login where login_name=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    //if exist the result is set to false
                    result = true;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }
    
    public String capitalizeString(String string) {
        char[] chars = string.toLowerCase().toCharArray();
        boolean found = false;
        for (int i = 0; i < chars.length; i++) {
            if (!found && Character.isLetter(chars[i])) {
                chars[i] = Character.toUpperCase(chars[i]);
                found = true;
            } else if (Character.isWhitespace(chars[i]) || chars[i] == '.' || chars[i] == '\'') { // You can add other chars here
                found = false;
            }
        }
        return String.valueOf(chars);
    }
    
    public boolean unsubscribe(String email) {
        //creatinga a boolean variable result (by default true)
        boolean result = false;
        int rowsUpdated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to update context.
                pstmt = con.prepareStatement("update context set email_verified=0 where email=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email);
                //executing the query.
                rowsUpdated = pstmt.executeUpdate();
                if (rowsUpdated > 0) { //checking if userid exist or not.
                    //if exist the result is set to false  
                    result = true;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }
    
    public int getFactulyStatus(int loginid) {
        int facultyStatus = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given user is registered for workshop already or not.
//                pstmt = con.prepareStatement("select p.participantid, p.status from participant p, accomodation a where a.participantid=p.participantid and a.workshopid=? and p.contextid=?");
                pstmt = con.prepareStatement("select  per.facultystatus from  person per  where  per.personid=? ");
                //binding the parameter values to query statement
                pstmt.setInt(1, loginid);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.                    
                    facultyStatus = (res.getInt("facultystatus"));
                    
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return facultyStatus;
    }
    
    public int setBlankLetter(int participantid) {
        int status = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                pstmt = con.prepareStatement("update letter set letter='' where participantid=? ");
                //binding the parameter values to query statement
                pstmt.setInt(1, participantid);
                //executing the query.
                status = pstmt.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return status;
    }

    /**
     *
     * @param person
     * @return
     * @throws Exception
     */
    public synchronized int registerNormalUser(Person person, String browser, String os) throws Exception {
        int id = 0;
        int update = 0;
        int pid = 0;
        int instituteResultUpdated = 0;
        int instituteId = 0;
        int idInstitute = -1;
        int updateNew, isLogsUpdated = 0;
        boolean isExist = false;
        int isRegsitered = ErrorCode.ERROR;
        if (con == null || con.isClosed()) {
            con = DBConnection.getDBConnection();
        }
        try {
            if (con != null) {
                int nextContextId = nextContextId();
                if (con == null || con.isClosed()) {
                    con = DBConnection.getDBConnection();
                }
                if (nextContextId == 0) {
                    return ErrorCode.ERROR;
                } else {
                    //  pstmt = con.prepareStatement("insert into context(email, mobile, homephone, email_verified,idcontext) values(?,?,?,?,?)");
                    pstmt = con.prepareStatement("insert into context(email, mobile, homephone, email_verified,idcontext,state,city) values(?,?,?,?,?,?,?)");
                    pstmt.setString(1, person.getEmail().trim());
                    pstmt.setString(2, person.getMobileNumber());
                    pstmt.setString(3, person.getPhoneNumber());
                    pstmt.setInt(4, 0);
                    pstmt.setInt(5, nextContextId);
                    pstmt.setInt(6, person.getStateId());
                    pstmt.setInt(7, person.getCityId());
                    int resultUpdated = pstmt.executeUpdate();
                    if (resultUpdated > 0) {
                        // pstmt = con.prepareStatement("insert into login(login_id,login_name, password, usertypeid, ipaddress, loginstatus,username) values(?,?,md5(?),?,?,0,?)");
                        pstmt = con.prepareStatement("insert into login(login_id,login_name, password, usertypeid, ipaddress, loginstatus) values(?,?,md5(?),?,?,0)");
                        pstmt.setInt(1, nextContextId);
                        pstmt.setString(2, person.getLoginName().trim());
                        pstmt.setString(3, person.getPassword());
                        pstmt.setInt(4, 1);
                        pstmt.setString(5, person.getIpAddress());
                        //pstmt.setString(6, person.getUsername()); 
                        int updated = pstmt.executeUpdate();
                        if (updated > 0) {
                            // check for instittue
                            idInstitute = isInstituteExist(person.getInstitute().getInstituteName());
                            if (con == null || con.isClosed()) {
                                con = DBConnection.getDBConnection();
                            }
                            if (con == null || con.isClosed()) {
                                con = DBConnection.getDBConnection();
                            }
                            
                            if (idInstitute < 0) {
                                pstmt = con.prepareStatement("insert into institute(Institutename,state,city,pincode,address,last_update,isActive) values(?,?,?,?,?,current_timestamp,-1)");
                                pstmt.setString(1, person.getInstitute().getInstituteName());
                                pstmt.setInt(2, person.getInstitute().getState().getStateId());
                                pstmt.setInt(3, person.getInstitute().getCity().getCityId());
                                pstmt.setInt(4, person.getInstitute().getPincode());
                                pstmt.setString(5, person.getInstitute().getInstituteAddress());
                                instituteResultUpdated = pstmt.executeUpdate();
                                if (instituteResultUpdated > 0) {
                                    pstmt = con.prepareStatement("select idInstitute from institute where Institutename = ?");
                                    pstmt.setString(1, person.getInstitute().getInstituteName());
                                    res = pstmt.executeQuery();
                                    if (res.next()) {
                                        instituteId = res.getInt("idInstitute");
                                    }
                                }
                                pstmt = con.prepareStatement("insert into person (personid, title_id,firstname,lastname,designation,genderinfo,city,address,pincode,experience, qualification,instituteid,streamid,image,last_update,facultystatus) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),0)");
                                pstmt.setInt(1, nextContextId);
                                pstmt.setInt(2, person.getTitle().getTitleId());
                                pstmt.setString(3, capitalizeString(person.getFirstName().trim()));
                                if (!person.getLastName().equals("") || !person.getLastName().equals(null)) {
                                    pstmt.setString(4, capitalizeString(person.getLastName().trim()));
                                } else {
                                    pstmt.setString(4, "");
                                }
                                pstmt.setInt(5, person.getDesignation().getDesignationId());
                                pstmt.setString(6, person.getGender());
                                pstmt.setString(7, person.getCity().getCityName());
                                pstmt.setString(8, person.getAddress());
                                pstmt.setInt(9, person.getPincode());
                                pstmt.setString(10, person.getExperience());
                                pstmt.setString(11, person.getQualification().getQualification());
                                pstmt.setInt(12, instituteId);
                                pstmt.setInt(13, person.getStream().getStreamId());
                                pstmt.setString(14, "photo_" + nextContextId + ".jpg");
                                // pstmt.setString(14, person.getAadharId());
                                //  pstmt.setInt(15, person.getYearofbirth());
                                //pstmt.setString(16, "photo_" + nextContextId + ".jpg");
                                update = pstmt.executeUpdate();
                                if (update > 0) {
                                    pstmt = con.prepareStatement("insert into logs(ip_address,user_id,browser_used,os_used) values(?,?,?,?)");
                                    pstmt.setString(1, person.getIpAddress());
                                    pstmt.setInt(2, nextContextId);
                                    pstmt.setString(3, browser);
                                    pstmt.setString(4, os);
                                    isLogsUpdated = pstmt.executeUpdate();
                                    
                                } else {
                                    con.rollback();
                                    isRegsitered = ErrorCode.ERROR;
                                }
                                isRegsitered = nextContextId;
                            } else {
                                pstmt = con.prepareStatement("update institute set address=?,pincode=?,last_update=current_timestamp  where idInstitute=?");
                                pstmt.setString(1, person.getInstitute().getInstituteAddress());
                                pstmt.setInt(2, person.getInstitute().getPincode());
                                pstmt.setInt(3, idInstitute);
                                updateNew = pstmt.executeUpdate();
                                if (updateNew > 0) {
                                    pstmt = con.prepareStatement("insert into person (personid, title_id,firstname,lastname,designation,genderinfo,city,address,pincode,experience, qualification,instituteid,streamid, image,last_update,facultystatus) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),0)");
                                    //pstmt = con.prepareStatement("insert into person (personid, title_id,firstname,lastname,designation,genderinfo,city,address,pincode,experience, qualification,instituteid,streamid, image,aadharid,yearofbirth) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                                    pstmt.setInt(1, nextContextId);
                                    pstmt.setInt(2, person.getTitle().getTitleId());
                                    pstmt.setString(3, capitalizeString(person.getFirstName().trim()));
                                    if (!person.getLastName().equals("") || !person.getLastName().equals(null)) {
                                        pstmt.setString(4, capitalizeString(person.getLastName().trim()));
                                    } else {
                                        pstmt.setString(4, "");
                                    }
                                    pstmt.setInt(5, person.getDesignation().getDesignationId());
                                    pstmt.setString(6, person.getGender());
                                    pstmt.setString(7, person.getCity().getCityName());
                                    pstmt.setString(8, person.getAddress());
                                    pstmt.setInt(9, person.getPincode());
                                    pstmt.setString(10, person.getExperience());
                                    pstmt.setString(11, person.getQualification().getQualification());
                                    if (person.getInstitute().getInstituteId() == 0) {
                                        person.getInstitute().setInstituteId(idInstitute);
                                    }
                                    pstmt.setInt(12, person.getInstitute().getInstituteId());
                                    pstmt.setInt(13, person.getStream().getStreamId());
                                    // image added
                                    pstmt.setString(14, "photo_" + nextContextId + ".jpg");
                                    // pstmt.setString(15, person.getAadharId());
                                    // pstmt.setInt(16, person.getYearofbirth());
                                    update = pstmt.executeUpdate();
                                    if (update > 0) {
                                        pstmt = con.prepareStatement("insert into logs(ip_address,user_id,browser_used,os_used) values(?,?,?,?)");
                                        pstmt.setString(1, person.getIpAddress());
                                        pstmt.setInt(2, nextContextId);
                                        pstmt.setString(3, browser);
                                        pstmt.setString(4, os);
                                        isLogsUpdated = pstmt.executeUpdate();
                                    } else {
                                        con.rollback();
                                        isRegsitered = ErrorCode.ERROR;
                                    }
                                    
                                }
                                isRegsitered = nextContextId;
                            }
                        } else {
                            con.rollback();
                            isRegsitered = ErrorCode.ERROR;
                        }
                    } else {
                        con.rollback();
                        isRegsitered = ErrorCode.ERROR;
                    }
                }
            }
        } catch (SQLException sqle) {
            isRegsitered = ErrorCode.SQLEXCEPTION;
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return isRegsitered;
    }
    
    public synchronized int UpdateNormalUser(Person person, String browser, String os) throws Exception {
        int isUserUpdated = ErrorCode.ERROR;
        int id = 0;
        int update = 0;
        int updated = 0;
        int instituteResultUpdated = 0;
        int instituteId = 0;
        int isLogsUpdated = 0;
        boolean isExist = false;
        int updateNew = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //con.setAutoCommit(false);
                // pstmt = con.prepareStatement("update context set mobile=?, homephone=?, email_verified=? where email=?");
                pstmt = con.prepareStatement("update context set mobile=?, homephone=?, email_verified=?,state=?,city=? where email=?");
                pstmt.setString(1, person.getMobileNumber());
                pstmt.setString(2, person.getPhoneNumber());
                pstmt.setInt(3, 0);
                pstmt.setInt(4, person.getStateId());
                pstmt.setInt(5, person.getCityId());
                pstmt.setString(6, person.getEmail());
                int resultUpdated = pstmt.executeUpdate();
                if (resultUpdated > 0) {
                    pstmt = con.prepareStatement("select idcontext from context where email = ?");
                    pstmt.setString(1, person.getEmail());
                    res = pstmt.executeQuery();
                    if (res.next()) {
                        id = res.getInt("idcontext");
                    }
                    boolean isLoginExist = true;/*
                     * isLoginExist(person.getEmail().trim());
                     */
                    
                    if (isLoginExist) {
                        pstmt = con.prepareStatement("update login set login_id= ?, login_name=?, ipaddress=? where login_name=?");
                        //  pstmt = con.prepareStatement("update login set login_id= ?, login_name=?, ipaddress=?,username=? where login_name=?");
                        pstmt.setInt(1, id);
                        pstmt.setString(2, person.getLoginName().trim());
                        pstmt.setString(3, person.getIpAddress());
                        // pstmt.setString(4, person.getUsername());
                        pstmt.setString(4, person.getEmail());
                        updated = pstmt.executeUpdate();
                    } else {
                        pstmt = con.prepareStatement("insert into login(login_id,login_name, usertypeid, ipaddress) values(?,?,?,?)");
                        //  pstmt = con.prepareStatement("insert into login(login_id,login_name, usertypeid, ipaddress,username) values(?,?,?,?,?)");
                        pstmt.setInt(1, id);
                        pstmt.setString(2, person.getLoginName().trim());
                        pstmt.setInt(3, 1);
                        pstmt.setString(4, person.getIpAddress());
                        // pstmt.setString(5, person.getUsername());
                        updated = pstmt.executeUpdate();
                    }
                    if (updated > 0) {
                        int idInstitute = isInstituteExist(person.getInstitute().getInstituteName());
                        if (con == null || con.isClosed()) {
                            con = DBConnection.getDBConnection();
                        }
                        if (idInstitute < 0) {
                            pstmt = con.prepareStatement("insert into institute(Institutename,state,city,pincode,address,isActive,last_update) values(?,?,?,?,?,-1,current_timestamp)");
                            pstmt.setString(1, person.getInstitute().getInstituteName());
                            pstmt.setInt(2, person.getInstitute().getState().getStateId());
                            pstmt.setInt(3, person.getInstitute().getCity().getCityId());
                            pstmt.setInt(4, person.getInstitute().getPincode());
                            pstmt.setString(5, person.getInstitute().getInstituteAddress());
                            instituteResultUpdated = pstmt.executeUpdate();
                            if (instituteResultUpdated > 0) {
                                //con.setAutoCommit(true);
                                pstmt = con.prepareStatement("select idInstitute from institute where Institutename = ?");
                                pstmt.setString(1, person.getInstitute().getInstituteName());
                                res = pstmt.executeQuery();
                                if (res.next()) {
                                    instituteId = res.getInt("idInstitute");
                                }
                            }
                            pstmt = con.prepareStatement("update person set title_id=?,firstname=?,lastname=?,designation=?,genderinfo=?,city=?,address=?,pincode=?,experience=?, qualification=?,instituteid=?,streamid=?,image=?,last_update=now(),facultystatus=0 where personid=?");
                            pstmt.setInt(1, person.getTitle().getTitleId());
                            pstmt.setString(2, capitalizeString(person.getFirstName().trim()));
                            if (!person.getLastName().trim().equals("") || !person.getLastName().trim().equals(null)) {
                                pstmt.setString(3, capitalizeString(person.getLastName().trim()));
                            } else {
                                pstmt.setString(3, "");
                            }
                            pstmt.setInt(4, person.getDesignation().getDesignationId());
                            pstmt.setString(5, person.getGender());
                            pstmt.setString(6, person.getCity().getCityName());
                            pstmt.setString(7, person.getAddress());
                            pstmt.setInt(8, person.getPincode());
                            pstmt.setString(9, person.getExperience());
                            pstmt.setString(10, person.getQualification().getQualification());
                            pstmt.setInt(11, instituteId);
                            pstmt.setInt(12, person.getStream().getStreamId());
                            if (person.getImage().trim() != "") {
                                pstmt.setString(13, "photo_" + id + ".jpg");
                            } else {
                                pstmt.setString(13, null);
                            }
                            pstmt.setInt(14, id);
                            update = pstmt.executeUpdate();
                            if (person.getInstitute().getInstituteId() == 0) {
                                person.getInstitute().setInstituteId(instituteId);
                            }
                            if (update > 0) {
                                pstmt = con.prepareStatement("insert into logs(ip_address,user_id,browser_used,os_used) values(?,?,?,?)");
                                pstmt.setString(1, person.getIpAddress());
                                pstmt.setInt(2, id);
                                pstmt.setString(3, browser);
                                pstmt.setString(4, os);
                                isLogsUpdated = pstmt.executeUpdate();
                            }
                        } else {
                            pstmt = con.prepareStatement("update institute set address=?,pincode=?,last_update=current_timestamp  where idInstitute=?");
                            pstmt.setString(1, person.getInstitute().getInstituteAddress());
                            pstmt.setInt(2, person.getInstitute().getPincode());
                            pstmt.setInt(3, idInstitute);
                            updateNew = pstmt.executeUpdate();
                            
                            pstmt = con.prepareStatement("update person set title_id=?,firstname=?,lastname=?,designation=?,genderinfo=?,city=?,address=?,pincode=?,experience=?, qualification=?,instituteid=?,streamid=?,image=?,last_update=now(),facultystatus=0 where personid=?");
                            pstmt.setInt(1, person.getTitle().getTitleId());
                            pstmt.setString(2, capitalizeString(person.getFirstName()));
                            if (!person.getLastName().equals("") || !person.getLastName().equals(null)) {
                                pstmt.setString(3, capitalizeString(person.getLastName()));
                            } else {
                                pstmt.setString(3, "");
                            }
                            pstmt.setInt(4, person.getDesignation().getDesignationId());
                            pstmt.setString(5, person.getGender());
                            pstmt.setString(6, person.getCity().getCityName());
                            pstmt.setString(7, person.getAddress());
                            pstmt.setInt(8, person.getPincode());
                            pstmt.setString(9, person.getExperience());
                            pstmt.setString(10, person.getQualification().getQualification());
                            if (person.getInstitute().getInstituteId() == 0) {
                                person.getInstitute().setInstituteId(idInstitute);
                            }
                            
                            pstmt.setInt(11, person.getInstitute().getInstituteId());
                            pstmt.setInt(12, person.getStream().getStreamId());
                            // pstmt.setString(13, person.getAadharId());
                            // pstmt.setInt(14, person.getYearofbirth());
                            if (person.getImage().trim() != "") {
                                pstmt.setString(13, "photo_" + id + ".jpg");
                            } else {
                                pstmt.setString(13, null);
                            }
                            pstmt.setInt(14, id);
                            //pstmt.setInt(15, id);
                            update = pstmt.executeUpdate();
                            if (update > 0) {
                                pstmt = con.prepareStatement("insert into logs(ip_address,user_id,browser_used,os_used) values(?,?,?,?)");
                                pstmt.setString(1, person.getIpAddress());
                                pstmt.setInt(2, id);
                                pstmt.setString(3, browser);
                                pstmt.setString(4, os);
                                isLogsUpdated = pstmt.executeUpdate();
                            }
                        }
                        
                    } else {
                        con.rollback();
                        isUserUpdated = ErrorCode.ERROR;
                    }
                } else {
                    con.rollback();
                    isUserUpdated = ErrorCode.ERROR;
                }
            }
        } catch (SQLException sqle) {
            isUserUpdated = ErrorCode.SQLEXCEPTION;
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return isUserUpdated;
    }
    
    public boolean subscribe(String email) {
        //creatinga a boolean variable result (by default true)
        boolean result = false;
        int rowsUpdated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to update context.
                pstmt = con.prepareStatement("update context set email_verified=1 where email=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email);
                //executing the query.
                rowsUpdated = pstmt.executeUpdate();
                if (rowsUpdated > 0) { //checking if userid exist or not.
                    //if exist the result is set to false  
                    result = true;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }
    
    public int ifSubscribedUser(String email) {
        //creatinga a boolean variable result (by default true)
        int result = 0;
        int rowsUpdated = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to update context.
                pstmt = con.prepareStatement("select * from context where email=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email);
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    result = res.getInt("email_verified");
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }
    
    public String checkIfEmailExist(String email) {
        //creatinga a boolean variable result (by default true)
        String result = "";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                //creating a query statement to check whether given userId exist or not.
                pstmt = con.prepareStatement("select email,idcontext from context where email=?");
                //binding the parameter values to query statement
                pstmt.setString(1, email.trim());
                //executing the query.
                res = pstmt.executeQuery();
                if (res.next()) { //checking if userid exist or not.
                    if (res.getInt("idcontext") != 0) {
                        //if exist the result is set to false
                        int login_id = 0;
                        pstmt1 = con.prepareStatement("select login_id,loginstatus from login where login_name=?");
                        pstmt1.setString(1, email.trim());
                        res1 = pstmt1.executeQuery();
                        if (res1.next()) {
                            login_id = res1.getInt("login_id");
                        }
                        if (login_id != 0) {
                            result = "existinlogin";
                        } else if (login_id == 0) {
                            // give set password interface link here.
                            result = "notexistinlogin";
                        }
                    }
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        //return the result
        return result;
    }
    
    public ArrayList<UserDashboard> getRefundClaimsInfo(String email) throws Exception {
        ArrayList<UserDashboard> details = new ArrayList<UserDashboard>();
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {//checking whether con is null or not.
                // setting variable for UserDashBoard
                UserDashboard detail;

                //creating a query statement to check whether given userId exist or not.
//                pstmt = con.prepareStatement("select w.workshopname, a.workshopid, p.participantid, p.status, c.email from accomodation a left join participant p on p.participantid=a.participantid left join context c on c.idcontext=p.contextid left join workshops w on  w.workshopid=a.workshopid where p.contextid IN ( select idcontext from context where email=?)");
                pstmt = con.prepareStatement("select w.workshopname,w.categorycode,w.workshopid, DATE_FORMAT( w.startdate, '%d-%m-%Y' ) AS startdate,date_format(w.startdate,'%b - %Y') date,ifnull(w.rc_payment_if_required,0) as rc_payment_if_required,p.status,c.email, c.idcontext, p.regtime, p.participantid, rc.email as rcc_email, w.feeamount,ifnull(w.datetobedisplayed,1) as datetobedisplayed, "
                        + "p.payment,w.lastdateforappli as checksdate,w.startdateofappli from accomodation a,(select * from participant order by field(status,'Confirmed','Moodle Accessed','Request Confirmed' ,'Completed','Approved','Elig. Approved','Request Approved','Registration Invalid','Rejected' ,'enrolled','Prov. Enrolled','Registered','Request Registered','','1','Cancelled','incomplete' "
                        + ",'Request Verified','Waiting','Waitlisted','Withdrawn')) p , context c,workshops w, remotecenter rc where w.workshopid=a.workshopid and p.participantid =a.participantid and p.contextid =c.idcontext and rc.remotecenterid = a.instituteid and c.email =?  and p.payment IN ('refund initiated','refunded')  group by w.workshopname,w.workshopid,date_format(w.startdate,'%b - %Y'),c.email order by w.startdate desc");

                //binding the parameter values to query statement
                pstmt.setString(1, email);
                //executing the query.
                res = pstmt.executeQuery();
                while (res.next()) {
                    detail = new UserDashboard();
                    //checking if userid exist or not.
                    //if exist the result is set to false
                    Person person = new Person();
                    person.setLoginId(res.getInt("idcontext"));
                    person.setLoginName(res.getString("email"));
                    detail.setPerson(person);
                    RegistrationDetails registrationDetails = new RegistrationDetails();
                    registrationDetails.setStatus(res.getString("status"));
                    registrationDetails.setParticipantid(res.getString("participantid"));
                    registrationDetails.setRcc_email(res.getString("rcc_email"));
                    registrationDetails.setPayment(res.getString("payment"));
                    registrationDetails.setChecksDate(res.getString("checksdate"));
                    detail.setRegistrationDetails(registrationDetails);
                    WorkshopContent content = new WorkshopContent();

                    // check if the workshop already started
                    java.util.Date now = new java.util.Date();
                    SimpleDateFormat dmy = new SimpleDateFormat("dd-MM-yyyy");
                    
                    java.util.Date startdate = dmy.parse(res.getString("startdate"));
                    content.setWorkshopExpiry(0);
                    if (startdate.before(now)) {
                        content.setWorkshopExpiry(1);
                    }
                    
                    content.setWorkshopname(res.getString("workshopname"));
                    content.setWorkshopid(res.getInt("workshopid"));
                    content.setStartdate(res.getString("date"));
                    content.setCategorycode(res.getInt("categorycode"));
                    content.setStartdatereg(res.getString("startdateofappli"));
                    content.setDateToBeDisplayed(res.getInt("datetobedisplayed"));
                    content.setPayment_at_rc(res.getInt("rc_payment_if_required"));
                    detail.setWorkshops(content);
                    SimpleStringCipher cipher = new SimpleStringCipher();
                    String enc_workshopid = cipher.encrypt(res.getString("workshopid"));
                    detail.setSchedule_url("viewProgramSchedule.html?workshopid=" + enc_workshopid);
                    PaymentGateway pg = new PaymentGateway();
                    pg.setTotalAmt(res.getString("feeamount"));
                    detail.setPaymentgateway(pg);
                    details.add(detail);
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
        return details;
    }
}
