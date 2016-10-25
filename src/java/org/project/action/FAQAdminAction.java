/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.project.bean.StatusMatrix;
import org.project.utilities.DBConnection;

/**
 *
 * @author Abinaya
 */
public class FAQAdminAction extends ActionSupport {

    Connection con;
    PreparedStatement pstmt2;
    ResultSet res2;
    private ArrayList<StatusMatrix> statusMatrix;

    public String execute() {
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                statusMatrix = new ArrayList<StatusMatrix>();

                pstmt2 = con.prepareStatement("select * from status_matrix");
                res2 = pstmt2.executeQuery();

                while (res2.next()) {
                    StatusMatrix sm = new StatusMatrix();
                    sm.setInitialStatus(res2.getString("InitialStatus"));
                    sm.setIfDisplayRegistered(res2.getString("Registered"));
                    sm.setIfDisplayInvalid(res2.getString("Invalid"));
                    sm.setIfDisplayApproved(res2.getString("Approved"));
                    sm.setIfDisplayConfirmed(res2.getString("Confirmed"));
                    sm.setIfDisplayCompleted(res2.getString("Completed"));
                    sm.setIfDisplayCancelled(res2.getString("Cancelled"));
                    statusMatrix.add(sm);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res2);
            DBConnection.closePStatement(pstmt2);
            DBConnection.closeDBConnection(con);
        }
        return SUCCESS;
    }

    /**
     * @return the statusMatrix
     */
    public ArrayList<StatusMatrix> getStatusMatrix() {
        return statusMatrix;
    }

    /**
     * @param statusMatrix the statusMatrix to set
     */
    public void setStatusMatrix(ArrayList<StatusMatrix> statusMatrix) {
        this.statusMatrix = statusMatrix;
    }
}
