/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import jxl.Workbook;
import jxl.write.*;
import org.apache.poi.hpsf.HPSFException;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.project.bean.AttendanceSheet;
import org.project.bean.AttendanceSchedule;

/**
 *
 * @author dipesh
 */
public class ExportAttendanceDetails {

    public boolean createExcel(ArrayList<AttendanceSheet> details, String fileName, String Context, ArrayList<AttendanceSchedule> schedule) throws HPSFException {
        boolean count = false;

        ArrayList data = new ArrayList();
        ArrayList headers = new ArrayList();
        AttendanceSheet obj_details = null;
        AttendanceSchedule obj_schedule = null;
        String filepath = Context + "/Excel_Sheets/" + fileName;
        File file123 = new File(filepath);
        headers.add("Id");
        headers.add("Name");
        headers.add("Email");
        for (int j = 0; j < schedule.size(); j++) {
            obj_schedule = (org.project.bean.AttendanceSchedule) schedule.get(j);
            for (int k = 1; k <= Integer.parseInt(obj_schedule.getNumberOfSessions()); k++) {
                headers.add("S " + k);
            }
        }
        String n = obj_schedule.getNumberOfSessions();
        for (int k = 0; k < details.size(); k++) {
       }
        for (int i = 0; i < details.size(); i++) {
            obj_details = (org.project.bean.AttendanceSheet) details.get(i);
            ArrayList cells = new ArrayList();
            cells.add("" + obj_details.getParticipantid());
            String name = obj_details.getParticipantDetail().getFirstName() + " " + obj_details.getParticipantDetail().getLastName();
            cells.add("" + name);
            cells.add("" + obj_details.getParticipantDetail().getEmail());
            for (int ispr = 0; ispr < obj_details.getIsPresent().size(); ispr++) {
                if (obj_details.getIsPresent().get(ispr).toString().equals("Yes")) {
                    cells.add("P");
                } else {
                    cells.add("A");
                }
            }
            data.add(cells);
        }

        exportToExcel("Test", headers, data, file123, schedule);
        count = true;
        return count;
    }

    public static void main(String[] args) throws HPSFException {

    }

    public static void exportToExcel(String sheetName, ArrayList headers,
            ArrayList data, File outputFile, ArrayList<AttendanceSchedule> schedule) throws HPSFException {
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet(sheetName);

        int rowIdx = 0;
        short cellIdx = 0;
        // font
        HSSFCellStyle styleBold = wb.createCellStyle();
        HSSFFont font = wb.createFont();
        font.setFontHeightInPoints((short) 10);
        font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        styleBold.setFont(font);

        HSSFCellStyle styleBold1 = wb.createCellStyle();
        HSSFFont font1 = wb.createFont();
        font1.setFontHeightInPoints((short) 9);
        font1.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
        styleBold1.setFont(font1);

        HSSFCellStyle styleBold2 = wb.createCellStyle();
        HSSFFont font2 = wb.createFont();
        font2.setFontHeightInPoints((short) 9);
        styleBold2.setFont(font2);

        // Header
        HSSFRow hssfHeader = sheet.createRow(rowIdx);
        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        HSSFCell hssfCell1 = hssfHeader.createCell(cellIdx++);
        hssfCell1.setCellStyle(styleBold);
        hssfCell1.setCellValue("Participant Info");
        sheet.addMergedRegion(new CellRangeAddress(
                0, //first row (0-based)
                0, //last row (0-based)
                0, //first column (0-based)
                2 //last column (0-based)
        ));
        AttendanceSchedule obj_schedule = null;
        int cellIndex = 3;
        for (int j = 0; j < schedule.size(); j++) {
            obj_schedule = (org.project.bean.AttendanceSchedule) schedule.get(j);
            HSSFCell hssfCell2 = hssfHeader.createCell(cellIndex);
            hssfCell2.setCellStyle(styleBold);
            hssfCell2.setCellValue(obj_schedule.getDate_string());
            int num = Integer.parseInt(obj_schedule.getNumberOfSessions());
            sheet.addMergedRegion(new CellRangeAddress(
                    0, //first row (0-based)
                    0, //last row (0-based)
                    cellIndex, //first column (0-based)
                    cellIndex + num - 1 //last column (0-based)
            ));
            cellIndex = cellIndex + num;
        }

        /* HSSFCell hssfCell2 = hssfHeader.createCell(3);
         System.out.println("next " + cellIdx);
         hssfCell2.setCellStyle(cellStyle);
         hssfCell2.setCellValue("Date Wise Session");
         sheet.addMergedRegion(new CellRangeAddress(
         0, //first row (0-based)
         0, //last row (0-based)
         3, //first column (0-based)
         5 //last column (0-based)
         ));*/
        int cellIdx1 = 0;
        HSSFRow hssfHeader2 = sheet.createRow(1);
        for (Iterator cells = headers.iterator(); cells.hasNext();) {
            HSSFCell hssfCell = hssfHeader2.createCell(cellIdx1++);
            hssfCell.setCellStyle(styleBold1);
            hssfCell.setCellValue((String) cells.next());
        }
        // Data
        rowIdx = 2;
        for (Iterator rows = data.iterator(); rows.hasNext();) {
            ArrayList row = (ArrayList) rows.next();
            HSSFRow hssfRow = sheet.createRow(rowIdx++);
            cellIdx = 0;
            for (Iterator cells = row.iterator(); cells.hasNext();) {
                HSSFCell hssfCell = hssfRow.createCell(cellIdx++);
                hssfCell.setCellStyle(styleBold2);
                hssfCell.setCellValue((String) cells.next());
            }
        }

        wb.setSheetName(0, sheetName);
        try {
            FileOutputStream outs = new FileOutputStream(outputFile);
            wb.write(outs);
            outs.close();
        } catch (IOException e) {
            throw new HPSFException(e.getMessage());
        }

    }
}
