/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextListener;

/**
 *
 * @author mayank
 */
public class DBConnection {

    public static Connection con = null;

    /**
     * Creates a new instance of DBConnection
     */
    public DBConnection() {
    }

    /**
     * Creates a new DBConnection
     */
    public static Connection getDBConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");//load the driver
            try {
                //Get the connection for the specified database 
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbname", "dbuser", "dbpassword");
            } catch (SQLException e) {
                //exception while connecting to the database
                System.out.println(e);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Could not load driver class " + e); 
        }
        return con;
    }

    public synchronized static void closeStatement(Statement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
                stmt = null;
            } catch (SQLException e) {
                System.out.println("Could not close Statement " + e);
            }
        }
    }

    public synchronized static void closePStatement(PreparedStatement pstmt) {
        if (pstmt != null) {
            try {
                pstmt.close();
                pstmt = null;
            } catch (SQLException e) {
                System.out.println("Could not close Prepared Statement " + e);
            }
        }
    }

    public synchronized static void closeResultSet(ResultSet res) {
        if (res != null) {
            try {
                res.close();
                res = null;
            } catch (SQLException e) {
                System.out.println("Could not close ResultSet " + e);
            }
        }
    }

    public static synchronized boolean isClosed(Connection con) {
        boolean isClosed = false;
        try {
            if (con == null || con.isClosed()) {
                isClosed = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isClosed;
    }

    public static void closeDBConnection(Connection con) {
        try {
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            System.out.println("Could not close connection " + e);
        }
    }
}
