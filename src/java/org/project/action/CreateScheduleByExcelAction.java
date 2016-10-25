/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import org.project.bean.AttendanceSchedule;
import org.project.bean.Person;
import org.project.bean.DataExportActivityBean;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpSession;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.project.utilities.DBConnection;
import org.project.utilities.ExcelRead;
import org.project.utilities.FileUtil;
import org.project.utilities.Utility;

/**
 *
 * @author dipesh
 */
public class CreateScheduleByExcelAction extends ActionSupport {

    private ArrayList<Person> persondata;
    private ArrayList<AttendanceSchedule> schedule;
    private File excelread;
    private String excelreadContentType;
    private String excelreadFileName;
    Connection con = null;
    PreparedStatement stmt = null, stmt2 = null;
    ResultSet rs = null, rs2 = null;
    private int uploadId;
    private Pattern pattern;
    private Matcher matcher;
    private static final String TIME24HOURS_PATTERN = "([01]?[0-9]|2[0-3]):[0-5][0-9]";
    private ArrayList<DataExportActivityBean> resultOutput;

    public CreateScheduleByExcelAction() {
        pattern = Pattern.compile(TIME24HOURS_PATTERN);
    }

    public String execute() {
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

                String context = ServletActionContext.getServletContext().getRealPath("");
                try {
                    // FileUtil.saveFile(excelread, upload_name, context + File.separator + "pdfs");
                } catch (Exception e) {
                    System.out.println("problem in file upload");
                }
                //storing file in folder
                // rex.insertUploadFiles(upload_name, person.getLoginId());
                // int upl_id = rex.getuploadfileId(upload_name);
                // reading file 
                int reS = excuteReadExcelFunction(getExcelread(), getExcelreadFileName(), "test", person.getLoginId(), 1);
                if (reS > 0) {
                    try{
                    //setUploadId(upl_id);
                     ExcelRead rex = new ExcelRead();
                    int upload_id = rex.getuploadfileNextId();
                     String upload_name = "schedule_" + upload_id + "_" + getExcelreadFileName();
                    try {
                         FileUtil.saveFile(excelread, upload_name, context + File.separator + "Excel_Sheets");
                    } catch (Exception e) {
                        System.out.println("problem in file upload");
                    }
                    //storing file in folder
                     rex.insertUploadFiles(upload_name, person.getLoginId());
                    // int upl_id = rex.getuploadfileId(upload_name);
                    }catch(Exception e){
                     e.printStackTrace();
                    }
                    session.setAttribute("result", "success");
                } else {
                    session.setAttribute("result", "error");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("result", "fail");
            }
        }

        return Utility.SUCCESS;
    }

    public int excuteReadExcelFunction(File file, String exfname, String exlfile, int loginid, int uploadid) {
        int res = 0;
        try {
            int inserRg = 0, noinsrRg = 0, inRes = 0;
            ArrayList cellStoreArrayList = null;
            ArrayList datasource = null;
            datasource = readexl(file, exfname);
            Person person = null;
            AttendanceSchedule schedule_program = null;
            String update_till_date;
            ArrayList<AttendanceSchedule> schedule = new ArrayList<AttendanceSchedule>();
            //validate the excel file
            int validateRes = validateExcelData(datasource);
            if (validateRes == 0) {
            } else {
                return res;
            }
            for (int i = 0; i < datasource.size(); i++) {
                schedule_program = new AttendanceSchedule();
                cellStoreArrayList = (ArrayList) datasource.get(i);

                String start_dt = cellStoreArrayList.get(1).toString();
                DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                Date date = (Date) formatter.parse(start_dt);
                SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");
                String finalString = newFormat.format(date);
                Calendar cal = Calendar.getInstance();
                cal.setTime(formatter.parse(start_dt));
                cal.add(Calendar.DATE, 2);
                Date udate = cal.getTime();
                String update_till = newFormat.format(udate);
                String tm_from = cellStoreArrayList.get(2).toString().substring(0, 5);
                String tm_to = cellStoreArrayList.get(3).toString().substring(0, 5);

                schedule_program.setWorkshopid(cellStoreArrayList.get(0).toString());
                schedule_program.setDateOfSession(finalString);
                schedule_program.setTime_from(tm_from);
                schedule_program.setTime_to(tm_to);
                schedule_program.setComments(cellStoreArrayList.get(4).toString());
                String attendanceCount = cellStoreArrayList.get(5).toString();
                int isActive = 2;
                if (attendanceCount.toLowerCase().equals("y")) {
                    isActive = 1;
                } else if (attendanceCount.toLowerCase().equals("n")) {
                    isActive = 0;
                }
                schedule_program.setIsActive(isActive);
                schedule_program.setDate_till_1(update_till);
                schedule.add(schedule_program);
            }
            int result = fillNewData(schedule);
            if (result > 0) {
                res = 1;
            }
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

    public int fillNewData(ArrayList<AttendanceSchedule> schedule_details) {
        int res = 0, sessionid = 1;
        String max_session = "1";
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                //   stmt = con.prepareStatement("insert into partregdata(email,firstname,lastname,instituteid) values(?,?,?,?)");
                for (int i = 0; i < schedule_details.size(); i++) {
                    try {
                        stmt = con.prepareStatement("select IFNULL(max(sessionid)+1,0) as sid from program_schedule where workshopid=? and date=?");
                        stmt.setString(1, schedule_details.get(i).getWorkshopid());
                        stmt.setString(2, schedule_details.get(i).getDateOfSession());
                        rs = stmt.executeQuery();
                        while (rs.next()) {
                            max_session = rs.getString("sid");
                        }
                        if (max_session.equals(null)) {
                            sessionid = sessionid;
                        } else if (!max_session.equals(null)) {
                            sessionid = Integer.parseInt(max_session);
                            sessionid = sessionid + 1;
                        }

                        stmt2 = con.prepareStatement("INSERT INTO program_schedule( workshopid, date, sessionid, comments, time_from, time_to, isActive, update_till) VALUES (?,?,?,?,?,?,?,?)");
                        stmt2.setString(1, schedule_details.get(i).getWorkshopid());
                        stmt2.setString(2, schedule_details.get(i).getDateOfSession());
                        stmt2.setInt(3, sessionid);
                        stmt2.setString(4, isBlankValue(schedule_details.get(i).getComments()));
                        stmt2.setString(5, schedule_details.get(i).getTime_from());
                        stmt2.setString(6, schedule_details.get(i).getTime_to());
                        stmt2.setInt(7, schedule_details.get(i).getIsActive());
                        stmt2.setString(8, schedule_details.get(i).getDate_till_1());
                        res = stmt2.executeUpdate();
                        //if (per.getPincode() == 0) {
                        //    stmt.setString(14, null);
                        //} else {
                        //    stmt.setInt(14, per.getPincode());
                        //}

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {            
            DBConnection.closePStatement(stmt2);
            DBConnection.closeResultSet(rs);
            DBConnection.closePStatement(stmt);
            DBConnection.closeDBConnection(con);
        }
        return res;
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

    public int validateExcelData(ArrayList datasource) {
        ArrayList cellStoreArrayList = null;
        AttendanceSchedule schedule_program = null;
        ArrayList<DataExportActivityBean> data_export = new ArrayList<DataExportActivityBean>();
        DataExportActivityBean dataExportBean = null;
        int result = 0;
        String errormsg = "";
        try {
            if (datasource.size() > 0) {
                for (int i = 0; i < datasource.size(); i++) {
                    dataExportBean = new DataExportActivityBean();
                    schedule_program = new AttendanceSchedule();
                    cellStoreArrayList = (ArrayList) datasource.get(i);
                    if (cellStoreArrayList.get(0).toString().equals("") || cellStoreArrayList.get(0).toString().length() == 0) {
                        result++;
                        errormsg += "* workshop id error ";
                    } else {
                        boolean res = validateOnlyInNumber(cellStoreArrayList.get(0).toString());
                        if (res == false) {
                            result++;
                            errormsg += "* workshop id is not a number ";
                        }
                    }

                    if (cellStoreArrayList.get(1).toString().equals("") || cellStoreArrayList.get(1).toString().length() == 0) {
                        result++;
                        errormsg += "* date error ";
                    } else {
                        boolean res = validateRequiredDateFormat(cellStoreArrayList.get(1).toString());
                        boolean res2 = validateDate1(cellStoreArrayList.get(1).toString());
                        if (res == false || res2 == false) {
                            result++;
                            errormsg += "* invalid date format ";
                        }
                    }
                    if (cellStoreArrayList.get(2).toString().equals("") || cellStoreArrayList.get(2).toString().length() == 0) {
                        result++;
                        errormsg += "* time-from error";
                    } else {
                        boolean res = validateTime(cellStoreArrayList.get(2).toString());
                        if (res == false) {
                            result++;
                            errormsg += "* invalid time-from ";
                        }
                    }
                    if (cellStoreArrayList.get(3).toString().equals("") || cellStoreArrayList.get(3).toString().length() == 0) {
                        result++;
                        errormsg += "* time-to Error ";
                    } else {
                        boolean res = validateTime(cellStoreArrayList.get(3).toString());
                        if (res == false) {
                            result++;
                            errormsg += "* invalid time-to ";
                        }
                    }
                    if (cellStoreArrayList.get(5).toString().equals("") || cellStoreArrayList.get(5).toString().length() == 0) {
                        result++;
                        errormsg += "* attendance counted error ";
                    } else {
                        if (!cellStoreArrayList.get(5).toString().trim().toLowerCase().equals("y") && !cellStoreArrayList.get(5).toString().trim().toLowerCase().equals("n")) {
                            result++;
                            errormsg += "*attendance counted not match ";
                        }
                    }
                    dataExportBean.setRow_num(String.valueOf(i + 1));
                    dataExportBean.setValidate_error(errormsg);
                    data_export.add(dataExportBean);
                    errormsg = "";
                }
            } else {
                result = 0;
            }
            resultOutput = data_export;
        } catch (Exception e) {
        }
        return result;
    }

    /**
     * following method validate the entered input is number or not if number
     * then return true,else false
     */
    public static boolean validateOnlyInNumber(String number) {
        /*
         * number should be at least 1 digits @result store and return the
         * @result boolean following code will test number should at least 1
         * digit and maximum till 15 digit
         */
        boolean result = (number != null) && (number.length() >= 1) && (number.length() <= 15) && (number.matches("^[0-9]*$"));
        return result;
    }

    /**
     * this function will validate given string in date format and return result
     * if true in valid format,else false @date
     */
    public static boolean validateRequiredDateFormat(String date) {
        // setting default result value to false
        boolean result = false;
        // validate here for (yyyy-mm-dd) format) if match then return true
        if (date.matches("\\d{4}-\\d{2}-\\d{2}")) {
            result = true;
        }
        return result;
    }

    /**
     * @result this function will check date in valid format
     */
    public static boolean validateDate1(String date) {
        boolean result = true;
        try {
            String[] date_split = date.split("-");
            String year = date_split[0];
            String month = date_split[1];
            String day = date_split[2];
            if (Integer.parseInt(month) > 12) {
                result = false;
            }
            if (Integer.parseInt(day) > 31) {
                result = false;
            }
        } catch (Exception e) {
            result = false;
            e.printStackTrace();
        }
        return result;
    }

    /*
     * this function will check time in valid format
     *
     */
    public boolean validateTime(String time) {
        if (time.length() < 5) {
            return false;
        }
        time = time.substring(0, 5);
        matcher = pattern.matcher(time);
        return matcher.matches();
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
     * @return the schedule
     */
    public ArrayList<AttendanceSchedule> getSchedule() {
        return schedule;
    }

    /**
     * @param schedule the schedule to set
     */
    public void setSchedule(ArrayList<AttendanceSchedule> schedule) {
        this.schedule = schedule;
    }

    /**
     * @return the resultOutput
     */
    public ArrayList<DataExportActivityBean> getResultOutput() {
        return resultOutput;
    }

    /**
     * @param resultOutput the resultOutput to set
     */
    public void setResultOutput(ArrayList<DataExportActivityBean> resultOutput) {
        this.resultOutput = resultOutput;
    }
}
