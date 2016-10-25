/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import java.sql.Connection;

/**
 *
 * @author mayank
 */
class DataBase implements Runnable {
    private Connection con;
    @Override
    public void run() {
        
        con = DBConnection.getDBConnection();
        DBConnection.closeDBConnection(con);
    }
    
}

public class DataBaseTest {
    public static void main(String args[]) {
        
    }
}
