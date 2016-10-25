/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.misc;

import com.opensymphony.xwork2.ActionSupport;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.project.utilities.DBConnection;

/**
 *
 * @author Abinaya
 */
public class CapitalizeName_PersonTable extends ActionSupport {

    private Connection con;
    private PreparedStatement pstmt, pstmt1;
    private ResultSet res;
    private int result = 0;

    public static void main(String args[]) {
        CapitalizeName_PersonTable cp = new CapitalizeName_PersonTable();
        cp.getAllPersonNames();
    }

    public void getAllPersonNames() {

        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select personid, IFNULL(firstname,'') as firstname, IFNULL(lastname, '') as lastname from person, login where personid=login_id");
                res = pstmt.executeQuery();
                while (res.next()) {
                    String personid = res.getString("personid");
                    String firstname_1 = res.getString("firstname");
                    String lastname_1 = res.getString("lastname");
                    CapitalizeName_PersonTable cp = new CapitalizeName_PersonTable();

                    String fn = "", ln = "";
                    if (firstname_1 != null || firstname_1 != "") {
                        fn = cp.capitalizeString(firstname_1);
                    }
                    if (lastname_1 != null || lastname_1 != "") {
                        ln = cp.capitalizeString(lastname_1);
                    }

                    pstmt1 = con.prepareStatement("update person set firstname=? , lastname=? where personid=?");
                    pstmt1.setString(1, fn);
                    pstmt1.setString(2, ln);
                    pstmt1.setString(3, personid);
                    setResult(getResult() + pstmt1.executeUpdate());
                    System.out.println("Name Successfully updated for " + personid);

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
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

    /**
     * @return the result
     */
    public int getResult() {
        return result;
    }

    /**
     * @param result the result to set
     */
    public void setResult(int result) {
        this.result = result;
    }
}
