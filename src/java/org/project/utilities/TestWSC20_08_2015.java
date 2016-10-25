/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import org.project.bean.Participant;
import org.project.bean.Person;
import org.project.bean.RemoteCenter;

/**
 *
 * @author Abinaya
 */
public class TestWSC20_08_2015 {

    Connection con;
    PreparedStatement pstmt, pstmt1;
    ResultSet res, res1;

    public static void main(String args[]) {
        // insert participants of 5000021 to 700000 and only of RCs in 32100024
        TestWSC20_08_2015 obj = new TestWSC20_08_2015();
        // obj.insertRCC();
        obj.insert();
    }

    public void insert() {
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select distinct(instituteid) as instituteid from accomodation where workshopid=32100025 and participantid IN (select participantid from participant where status='Confirmed')");
                //executing the query
                res = pstmt.executeQuery();
                ArrayList<RemoteCenter> rcA = new ArrayList<RemoteCenter>();
                while (res.next()) {
                    // save all rc in arrayList
                    RemoteCenter rc = new RemoteCenter();
                    rc.setRemoteCenterId(res.getInt("instituteid"));
                    rcA.add(rc);
                }

                pstmt1 = con.prepareStatement("select * from accomodation where workshopid=5000022");
                res1 = pstmt1.executeQuery();
                ArrayList<Participant> pA = new ArrayList<Participant>();
                while (res1.next()) {
                    Participant p = new Participant();
                    p.setParticipantid(res1.getInt("participantid"));
                    pA.add(p);
                }
                System.out.println(rcA.size() + " xxxx " + pA.size());

                //int participantFirst = pA.get(0).getParticipantid();
                //System.out.println(participantFirst);
                int k = 0;
                for (int i = 0; i < rcA.size(); i++) {
                    for (int j = 0; j < 10; j++, k++) {
                        pstmt = con.prepareStatement("update accomodation set instituteid=? where participantid=?");
                        pstmt.setInt(1, rcA.get(i).getRemoteCenterId());
                        pstmt.setInt(2, pA.get(k).getParticipantid());
                        //System.out.println(pstmt);
                        pstmt.executeUpdate();
                    }
                    //System.out.println(i + " updated upto " + participantFirst);
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeResultSet(res1);
            DBConnection.closePStatement(pstmt1);
            DBConnection.closeResultSet(res);
            DBConnection.closePStatement(pstmt);
            DBConnection.closeDBConnection(con);
        }
    }

    public void insertRCC() {
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select distinct(instituteid) as instituteid from accomodation where workshopid=32100025 and participantid IN (select participantid from participant where status='Confirmed')");
                //executing the query
                res = pstmt.executeQuery();
                ArrayList<RemoteCenter> rcA = new ArrayList<RemoteCenter>();
                while (res.next()) {
                    // update RCC table
                    pstmt1 = con.prepareStatement("insert into remotecentercapacity(rcid,workshopid,available_seats,available_accomo,acco_cost,food_cost) values(?,?,?,?,?,?)");
                    pstmt1.setInt(1, res.getInt("instituteid"));
                    pstmt1.setString(2, "5000022");
                    pstmt1.setString(3, "50");
                    pstmt1.setString(4, "30");
                    pstmt1.setString(5, "");
                    pstmt1.setString(6, "");
                    pstmt1.executeUpdate();

                }
                System.out.println("Done");
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

    public void updateParticipantsEmail() {
        try {
            if (con == null || con.isClosed()) {
                con = DBConnection.getDBConnection();
            }
            if (con != null) {
                pstmt = con.prepareStatement("select personid from participant where participantid IN (select participantid from accomodation where workshopid=700000)");
                //executing the query
                res = pstmt.executeQuery();
                while (res.next()) {
                    // update RCC table
                    pstmt1 = con.prepareStatement("update login set login_name=? where login_id=?;update context set email=? where idcontext=?");
                    pstmt1.setString(1, res.getString("personid") + "@test.com");
                    pstmt1.setString(2, res.getString("personid"));
                    pstmt1.setString(3, res.getString("personid") + "@test.com");
                    pstmt1.setString(4, res.getString("personid"));
                    // System.out.println(pstmt1);
                    //pstmt1.execute();
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
}