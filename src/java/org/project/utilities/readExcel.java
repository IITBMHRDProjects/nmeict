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
import java.util.Iterator;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.project.bean.Designation;
import org.project.bean.Institute;
import org.project.bean.Person;
import org.project.bean.Qualification;
import org.project.bean.RemoteCenter;
import org.project.bean.State;
import org.project.bean.Stream;
import org.project.bean.Title;

/**
 *
 * @author asl
 */
public class readExcel {

    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String filepath = "/home/asl/Desktop/html work/ProgramFile/programdata.xls";

    public static void main(String[] args) {
        readExcel rexcel = new readExcel();
        ArrayList cellStoreArrayList = null;
        ArrayList dataHolder = rexcel.readExcel();
        Person person = null;
        int inserRg = 0, noinsrRg = 0, inRes = 0;
        for (int i = 1; i < dataHolder.size(); i++) {
            cellStoreArrayList = (ArrayList) dataHolder.get(i);
            person = new Person();
            person.setEmail(cellStoreArrayList.get(0).toString());
            person.setFirstName(cellStoreArrayList.get(1).toString());
            person.setLastName(cellStoreArrayList.get(2).toString());
            Institute insti = new Institute();
            int insti_id = Integer.parseInt(cellStoreArrayList.get(3).toString().substring(0, cellStoreArrayList.get(3).toString().lastIndexOf(".")));
            insti.setInstituteId(insti_id);
            person.setInstitute(insti);
            inRes = rexcel.fillNewData(person);
            if (inRes > 0) {
                inserRg++;
            } else {
                noinsrRg++;
            }
            System.out.println(" 1 : " + cellStoreArrayList.get(0).toString());
            System.out.println(" 2 : " + cellStoreArrayList.get(1).toString());
            System.out.println(" 3 : " + cellStoreArrayList.get(2).toString());
            System.out.println(" 4 : " + insti_id);
        }

        System.out.println("inserted data " + inserRg + " // not inserted data " + noinsrRg);
        //rexcel.readExcel();
    }

    public int excuteReadExcelFunction(File file, String exfname) {
        int res = 0;
        try {
            ArrayList cellStoreArrayList = null;
            ArrayList dataHolder = readExcel2(file, exfname);
            Person person = null;
            int inserRg = 0, noinsrRg = 0, inRes = 0;
            for (int i = 1; i < dataHolder.size(); i++) {
                cellStoreArrayList = (ArrayList) dataHolder.get(i);
                person = new Person();
                int w_id = Integer.parseInt(cellStoreArrayList.get(0).toString().substring(0, cellStoreArrayList.get(0).toString().lastIndexOf(".")));
                int rc_id = Integer.parseInt(cellStoreArrayList.get(1).toString().substring(0, cellStoreArrayList.get(1).toString().lastIndexOf(".")));
                int pincode=Integer.parseInt(cellStoreArrayList.get(13).toString().substring(0, cellStoreArrayList.get(13).toString().lastIndexOf(".")));
                int mobileno=Integer.parseInt(cellStoreArrayList.get(14).toString().substring(0, cellStoreArrayList.get(14).toString().lastIndexOf(".")));
                int contactno=Integer.parseInt(cellStoreArrayList.get(15).toString().substring(0, cellStoreArrayList.get(15).toString().lastIndexOf(".")));
                  
                RemoteCenter rc=new RemoteCenter();
                Institute insti = new Institute();
                Qualification qual=new Qualification();
                Title title=new Title();
                Designation desg=new Designation();
                Stream strm=new Stream();
               
                 rc.setRemoteCenterId(rc_id);
                title.setTitleName(cellStoreArrayList.get(2).toString());
                qual.setQualification(cellStoreArrayList.get(6).toString());
                desg.setDesignationName(cellStoreArrayList.get(7).toString());
                strm.setStreamName(cellStoreArrayList.get(8).toString());
                insti.setInstituteName(cellStoreArrayList.get(16).toString());
                
                person.setPer_workshopid(w_id);
                person.setRemoteCenter(rc);
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
                person.setPincode(pincode);
                person.setPer_mobile(mobileno);
                person.setPer_phone(contactno);
                person.setInstitute(insti);
                
                
               // int insti_id = Integer.parseInt(cellStoreArrayList.get(3).toString().substring(0, cellStoreArrayList.get(3).toString().lastIndexOf(".")));
              //  insti.setInstituteId(insti_id);
              //  person.setInstitute(insti);
                inRes = fillNewData(person);
                if (inRes > 0) {
                    inserRg++;
                } else {
                    noinsrRg++;
                }
                //   System.out.println(" 1 : " + cellStoreArrayList.get(0).toString());
                //   System.out.println(" 2 : " + cellStoreArrayList.get(1).toString());
                //    System.out.println(" 3 : " + cellStoreArrayList.get(2).toString());
                //    System.out.println(" 4 : " + insti_id);
            }

            if (inserRg > 0) {
                res = 1;
            }

            System.out.println("inserted data " + inserRg + " // not inserted data " + noinsrRg);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

    public ArrayList readExcel2(File exfile, String exfilename) {
        ArrayList col = new ArrayList();
        ArrayList cellArrayLisstHolder = new ArrayList();
        File file2 = new File(filepath);
        try {
            FileInputStream file = new FileInputStream(exfile);
            //Workbook workbook = null;
            //  String name = file2.getName();
           // System.out.println("path " + exfile.getName());
            String name = exfilename;
            Workbook workbook = null;
            Sheet sheet2 = null;

            if (name.toLowerCase().endsWith("xlsx")) {
                workbook = new XSSFWorkbook(file);

            } else if (name.toLowerCase().endsWith("xls")) {
                workbook = new HSSFWorkbook(file);
            }

            Sheet sheet = workbook.getSheetAt(0);
            Row firstrow = sheet.getRow(0);
            for (Cell cell : firstrow) {
            }

            Iterator<Row> rowiterator = sheet.iterator();
            while (rowiterator.hasNext()) {
                Row row = rowiterator.next();
                Iterator<Cell> celliterator = row.cellIterator();
                ArrayList cellStoreArrayList = new ArrayList();
                while (celliterator.hasNext()) {

                    Cell cell = celliterator.next();
                    // while(celliterator.hasNext()){
                    cellStoreArrayList.add(cell);
                }
                cellArrayLisstHolder.add(cellStoreArrayList);
                System.out.println("");
            }
            file.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cellArrayLisstHolder;
    }

    public ArrayList readExcel() {
        ArrayList col = new ArrayList();
        ArrayList cellArrayLisstHolder = new ArrayList();
        File file2 = new File("/home/asl/Desktop/html work/ProgramFile/programdata.xls");
        try {
            FileInputStream file = new FileInputStream(file2);
            //Workbook workbook = null;
            String name = file2.getName();
            Workbook workbook = null;
            Sheet sheet2 = null;

            if (name.toLowerCase().endsWith("xlsx")) {
                workbook = new XSSFWorkbook(file);

            } else if (name.toLowerCase().endsWith("xls")) {
                workbook = new HSSFWorkbook(file);
            }

            Sheet sheet = workbook.getSheetAt(0);
            Row firstrow = sheet.getRow(0);
            for (Cell cell : firstrow) {
            }

            Iterator<Row> rowiterator = sheet.iterator();
            while (rowiterator.hasNext()) {
                Row row = rowiterator.next();
                Iterator<Cell> celliterator = row.cellIterator();
                ArrayList cellStoreArrayList = new ArrayList();
                while (celliterator.hasNext()) {

                    Cell cell = celliterator.next();
                    // while(celliterator.hasNext()){
                    cellStoreArrayList.add(cell);
                    //  }
                   /* switch (cell.getCellType()) {
                     case Cell.CELL_TYPE_NUMERIC:
                     // System.out.print(cell.getNumericCellValue() + "\t");
                     case Cell.CELL_TYPE_STRING:
                     // System.out.print(cell.getStringCellValue() + "\t");

                     }*/

                }
                cellArrayLisstHolder.add(cellStoreArrayList);
                System.out.println("");
            }
            file.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cellArrayLisstHolder;
    }

    public int fillNewData(Person per) {
        int res = 0;
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
             //   stmt = con.prepareStatement("insert into partregdata(email,firstname,lastname,instituteid) values(?,?,?,?)");
                 stmt = con.prepareStatement("insert into partuserdata(workshopid,rcid,title,firstname,lastname,email,qualification,designation,discipline,experience,Gender,homeaddress,state,pincode,mobileno,contactno,institutename) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                stmt.setInt(1, per.getPer_workshopid());
                //stmt.setInt(2, per.getper);
                stmt.setString(2, per.getFirstName());
                stmt.setString(3, per.getLastName());
                stmt.setInt(4, per.getInstitute().getInstituteId());
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

}
