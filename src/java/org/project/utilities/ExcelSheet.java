/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import jxl.*;
import jxl.write.*;

/**
 *
 * @author Abinaya
 */
public class ExcelSheet {

    /**
     *
     * @param query
     * @param fileName
     * @return
     */
    public boolean createExcel(String query, String fileName) {

        boolean count = false;
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd = null;
        try {
            con = DBConnection.getDBConnection();
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);
            rsmd = rs.getMetaData();
            String[] headers = new String[rsmd.getColumnCount()];
            for (int i = 0; i < headers.length; i++) {
                headers[i] = rsmd.getColumnName(i + 1);
            }
            excelFilewrite(headers, rs, fileName);
            count = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    public void excelFilewrite(String[] headers, ResultSet rs, String fileName) throws IOException, WriteException, SQLException {
        WritableWorkbook workbook = Workbook.createWorkbook(new File(fileName));
        WritableSheet sheet = workbook.createSheet("First Sheet", 0);

        WritableFont wf = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD);
        WritableCellFormat cf = new WritableCellFormat(wf);
        cf.setWrap(true);


        sheet.addCell(new Label(0, 2, "Sr.No", cf));
        for (int i = 0; i < headers.length; i++) {
            sheet.addCell(new Label(i + 1, 2, headers[i], cf));
        }

        int j = 4, k = 1;
        while (rs.next()) {
            sheet.addCell(new Label(0, j, k++ + ""));
            for (int i = 0; i < headers.length; i++) {
                sheet.addCell(new Label(i + 1, j, rs.getString(i + 1)));
            }
            j++;
        }
        workbook.write();
        workbook.close();
    }
}
