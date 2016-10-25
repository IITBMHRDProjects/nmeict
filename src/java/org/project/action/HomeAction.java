/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.UserDashboard;
import org.project.bean.WorkshopContent;
import org.project.process.UserProcess;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author Abinaya
 */
public class HomeAction extends ActionSupport {

    private int isWorkshopCoordinator = 0;
    private ArrayList<WorkshopContent> wc;
    private ArrayList<WorkshopContent> wc1;
    private int rc_coordinator = 0;
    private ArrayList<WorkshopContent> wc2;
    private ArrayList<WorkshopContent> wc3;
    private int rcid = 0;
    private String rcid_enc;
    private ArrayList<UserDashboard> dashboard;
    private ArrayList<UserDashboard> refund_claims;
    private int rcid_wsc = 0;
    private String rcid_enc_wsc;
    private int if_atleast_one_cc7 = 0;
    private ArrayList<WorkshopContent> wc1_rcc;
    private int ifSubscribed = 0;

    @Override
    public String execute() {

        try {
            /*
             * Getting user session object
             */
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            UserProcess uproc = new UserProcess();
            UtilityProcess process = new UtilityProcess();
            if (person == null) {
                return Utility.SUCCESS;
            } else {
                // set Dashboard
                dashboard = uproc.getDashBoardInfo(person.getLoginName());
                refund_claims = uproc.getRefundClaimsInfo(person.getLoginName());

                ifSubscribed = uproc.ifSubscribedUser(person.getLoginName());

                if (person.getRoleId() == 1) {
                    // get latest workshops and if person is a coordinator of that particular workshop.
                    String period = "60 day";
                    wc1 = (process.listWorkshopsConducted(period));
                    wc = new ArrayList<WorkshopContent>();
                    for (int i = 0; i < wc1.size(); i++) {
                        if (wc1.get(i).getCategorycode() != 3 && wc1.get(i).getCategorycode() != 4 && wc1.get(i).getRespectiveCoWorkshopid() != 0 && wc1.get(i).getWorkshopExpiry() == 1 && wc1.get(i).getWithout_RC() == 0) {
                            if (wc1.get(i).getIfResCoorWorkshopIsComplete() == 1) {
                                int result = process.ifExistInRelevantCoordinatorWorkshop(wc1.get(i).getWorkshopid(), person.getLoginId());
                                if (result > 0) {
                                    ArrayList<WorkshopContent> wc3 = new ArrayList<WorkshopContent>();
                                    wc3 = process.listWorkshopContent(Integer.toString(wc1.get(i).getWorkshopid()));
                                    // if (wc3.get(0).getIfCanDisplayWCCDashboard() == 1) {
                                    wc.add(wc3.get(0));
                                    isWorkshopCoordinator++;
                                    // }
                                    rcid_wsc = result;
                                    SimpleStringCipher cipher = new SimpleStringCipher();
                                    rcid_enc_wsc = cipher.encrypt(Integer.toString(rcid_wsc));
                                }
                            }
                        }
                    }
                    // check if rc of latest workshops
                    wc2 = new ArrayList<WorkshopContent>();
                    for (int i = 0; i < wc1.size(); i++) {
                        if (wc1.get(i).getCategorycode() != 3 && wc1.get(i).getCategorycode() != 4 && wc1.get(i).getRespectiveCoWorkshopid() != 0 && wc1.get(i).getWorkshopExpiry() == 1) {
                            if (wc1.get(i).getIfResCoorWorkshopIsComplete() == 1) {
                                int result = process.ifExistInRelevantRCC(wc1.get(i).getRespectiveCoWorkshopid(), person.getLoginName());
                                if (result > 0) {
                                    if (wc1.get(i).getCategorycode() == 7) {
                                        if_atleast_one_cc7++;
                                    }
                                    rcid = result;
                                    wc2.add(process.listWorkshopContent(Integer.toString(wc1.get(i).getWorkshopid())).get(0));
                                    rc_coordinator++;
                                    SimpleStringCipher cipher = new SimpleStringCipher();
                                    rcid_enc = cipher.encrypt(Integer.toString(rcid));
                                }
                            }
                        }
                    }

                    // set for Manage RCC
                    wc3 = new ArrayList<WorkshopContent>();
                    for (int i = 0; i < wc1.size(); i++) {
                        if (wc1.get(i).getIfResCoorWorkshopIsComplete() == 1) {
                            if (wc1.get(i).getCategorycode() != 3 && wc1.get(i).getCategorycode() != 4 && wc1.get(i).getRespectiveCoWorkshopid() != 0 && wc1.get(i).getWorkshopExpiry() == 1) {
                                int result = process.ifExistInRelevantRCC(wc1.get(i).getRespectiveCoWorkshopid(), person.getLoginName());
                                if (result > 0) {
                                    rcid = result;
                                    int result1 = process.checkRemoteCenterCapacity(wc1.get(i).getWorkshopid(), rcid);
                                    SimpleStringCipher cipher = new SimpleStringCipher();
                                    rcid_enc = cipher.encrypt(Integer.toString(rcid));
                                    String enc_workshopid = wc1.get(i).getWorkshopid_encrypted();
                                    if (result1 != 1) {
                                        wc1.get(i).setRccUrl("updateRCCapacity.html?workshopid=" + enc_workshopid + "&rcid=" + rcid_enc + "&avseats=&avaccomo=");
                                        wc3.add(wc1.get(i));
                                        rc_coordinator++;
                                    } else {
                                        // set the url with already filled data. or just a view page with non editable fields
                                        wc1.get(i).setRccUrl("displayRCCDetails.html?workshopid=" + enc_workshopid + "&rcid=" + rcid_enc);
                                        wc3.add(wc1.get(i));
                                        rc_coordinator++;
                                    }

                                }
                            }
                        }
                    }

                    //View Participant RCC
                    wc1_rcc = new ArrayList<WorkshopContent>();
                    for (int i = 0; i < wc1.size(); i++) {
                        // added to show only if the confirmed WSC exist for a specific workshop
                        // check -- 
                        int result = process.ifExistInRelevantRCC(wc1.get(i).getRespectiveCoWorkshopid(), person.getLoginName());
                        if (result > 0) {
                            if (wc1.get(i).getIfResCoorWorkshopIsComplete() == 1) {
                                ArrayList<WorkshopContent> new_wc = new ArrayList<WorkshopContent>();
                                if ((wc1.get(i).getCategorycode() == 5 || wc1.get(i).getCategorycode() == 7 || wc1.get(i).getCategorycode() == 8) & wc1.get(i).getWorkshopExpiry() == 1) {
                                    new_wc = process.listWorkshopContent(Integer.toString(wc1.get(i).getWorkshopid()));
                                    new_wc.get(0).setWorkshopExpiry(wc1.get(i).getWorkshopExpiry());

                                    wc1_rcc.add(new_wc.get(0));
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Utility.SUCCESS;
    }

    public int getIsWorkshopCoordinator() {
        return isWorkshopCoordinator;
    }

    public void setIsWorkshopCoordinator(int isWorkshopCoordinator) {
        this.isWorkshopCoordinator = isWorkshopCoordinator;
    }

    public ArrayList<WorkshopContent> getWc() {
        return wc;
    }

    public void setWc(ArrayList<WorkshopContent> wc) {
        this.wc = wc;
    }

    public ArrayList<WorkshopContent> getWc1() {
        return wc1;
    }

    public void setWc1(ArrayList<WorkshopContent> wc1) {
        this.wc1 = wc1;
    }

    /**
     * @return the rc_coordinator
     */
    public int getRc_coordinator() {
        return rc_coordinator;
    }

    /**
     * @param rc_coordinator the rc_coordinator to set
     */
    public void setRc_coordinator(int rc_coordinator) {
        this.rc_coordinator = rc_coordinator;
    }

    public ArrayList<WorkshopContent> getWc2() {
        return wc2;
    }

    public void setWc2(ArrayList<WorkshopContent> wc2) {
        this.wc2 = wc2;
    }

    /**
     * @return the rcid
     */
    public int getRcid() {
        return rcid;
    }

    /**
     * @param rcid the rcid to set
     */
    public void setRcid(int rcid) {
        this.rcid = rcid;
    }

    /**
     * @return the rcid_enc
     */
    public String getRcid_enc() {
        return rcid_enc;
    }

    /**
     * @param rcid_enc the rcid_enc to set
     */
    public void setRcid_enc(String rcid_enc) {
        this.rcid_enc = rcid_enc;
    }

    /**
     * @return the wc3
     */
    public ArrayList<WorkshopContent> getWc3() {
        return wc3;
    }

    /**
     * @param wc3 the wc3 to set
     */
    public void setWc3(ArrayList<WorkshopContent> wc3) {
        this.wc3 = wc3;
    }

    /**
     * @return the dashboard
     */
    public ArrayList<UserDashboard> getDashboard() {
        return dashboard;
    }

    /**
     * @param dashboard the dashboard to set
     */
    public void setDashboard(ArrayList<UserDashboard> dashboard) {
        this.dashboard = dashboard;
    }

    /**
     * @return the rcid_wsc
     */
    public int getRcid_wsc() {
        return rcid_wsc;
    }

    /**
     * @param rcid_wsc the rcid_wsc to set
     */
    public void setRcid_wsc(int rcid_wsc) {
        this.rcid_wsc = rcid_wsc;
    }

    /**
     * @return the rcid_enc_esc
     */
    public String getRcid_enc_wsc() {
        return rcid_enc_wsc;
    }

    /**
     * @param rcid_enc_wsc the rcid_enc_esc to set
     */
    public void setRcid_enc_wsc(String rcid_enc_wsc) {
        this.rcid_enc_wsc = rcid_enc_wsc;
    }

    /**
     * @return the if_atleast_one_cc7
     */
    public int getIf_atleast_one_cc7() {
        return if_atleast_one_cc7;
    }

    /**
     * @param if_atleast_one_cc7 the if_atleast_one_cc7 to set
     */
    public void setIf_atleast_one_cc7(int if_atleast_one_cc7) {
        this.if_atleast_one_cc7 = if_atleast_one_cc7;
    }

    /**
     * @return the wc1_rcc
     */
    public ArrayList<WorkshopContent> getWc1_rcc() {
        return wc1_rcc;
    }

    /**
     * @param wc1_rcc the wc1_rcc to set
     */
    public void setWc1_rcc(ArrayList<WorkshopContent> wc1_rcc) {
        this.wc1_rcc = wc1_rcc;
    }

    /**
     * @return the ifSubscribed
     */
    public int getIfSubscribed() {
        return ifSubscribed;
    }

    /**
     * @param ifSubscribed the ifSubscribed to set
     */
    public void setIfSubscribed(int ifSubscribed) {
        this.ifSubscribed = ifSubscribed;
    }

    /**
     * @return the refund_claims
     */
    public ArrayList<UserDashboard> getRefund_claims() {
        return refund_claims;
    }

    /**
     * @param refund_claims the refund_claims to set
     */
    public void setRefund_claims(ArrayList<UserDashboard> refund_claims) {
        this.refund_claims = refund_claims;
    }
}
