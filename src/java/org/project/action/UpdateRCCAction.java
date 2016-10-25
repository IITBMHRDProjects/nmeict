/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Person;
import org.project.bean.RemoteCenterCapacity;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author asl
 */
public class UpdateRCCAction extends ActionSupport {

    private RemoteCenterCapacity rcc;
    private int h_workshopid;
    private int h_rcid;
    private Person person;
    private ArrayList<WorkshopContent> wc;
    private int cc;

    public String execute() throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        String avaseats1 = getRcc().getS_available_seats();
        String avaccomo1 = getRcc().getS_available_accomo();
        String acco_cost = "", food_cost = "";
        if (cc == 7) {
            acco_cost = getRcc().getAcco_cost();
            food_cost = getRcc().getFood_cost();
        }
        int avaseats = 0, avaccomo = 0;
        int flag = 0;
        try {
            avaseats = Integer.parseInt(avaseats1);
            avaccomo = Integer.parseInt(avaccomo1);
            flag = 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        UtilityProcess process = new UtilityProcess();
        int roleid = 0, userId = 0;
        try {
            setPerson((Person) session.getAttribute(Utility.USER_HANDLE));
            userId = getPerson().getLoginId();
            roleid = getPerson().getRoleId();
        } catch (Exception e) {
        }
        if (roleid > 1) {
            if (h_workshopid == 0 || h_rcid == 0) {
                // session.setAttribute("update_result", "<font color='red'>No data is updated.</font>");
                session.setAttribute("update_result", "no update");
            } else if (h_workshopid != 0 || h_rcid != 0) {
                /* rcc.setWorkshopid(h_workshopid);
                 rcc.setRcid(h_rcid);
                 rcc.setAvailable_accomo(avaccomo);
                 rcc.setAvailable_seats(avaseats);
                 setRcc(rcc);*/
                int update_res = 0;
                try {
                    // update_res = process.updateRemoteCenterCapacity(rcc);
                    update_res = updateRCCCapacity(h_workshopid, h_rcid, avaseats, avaccomo, session, acco_cost, food_cost);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                if (update_res == 1) {
                    session.setAttribute("update_result", "update success");
                } else if (update_res <= 0) {
                    session.setAttribute("update_result", "no update");
                }
            }
        } else if (roleid == 1) {
            int result = 0, flag_res = 0;
            try {
                int checkRes = 2;
                try {
                    checkRes = process.checkRemoteCenterCapacity(h_workshopid, h_rcid);
                } catch (Exception e) {
                }
                if (checkRes == 1) {
                    flag_res = 1;
                } else if (checkRes == 0) {
                    try {
                        result = insertRCCCapacity(h_workshopid, h_rcid, avaseats, avaccomo, session, acco_cost, food_cost);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if (result > 0) {
                        flag_res = 2;
                    } else {
                        flag_res = 3;
                    }
                    flag_res = 2;
                } else if (checkRes == 2) {
                    //error msg no update / insert
                    flag_res = 3;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (flag_res == 1) {
                session.setAttribute("update_result", "already use");
            } else if (flag_res == 2) {
                session.setAttribute("update_result", "user inserted");
            } else if (flag_res == 3) {
                session.setAttribute("update_result", "user failed");
            }
        } else if (roleid == 0) {
            int result = 0, flag_res = 0;
            try {
                int checkRes = 2;
                try {
                    checkRes = process.checkRemoteCenterCapacity(h_workshopid, h_rcid);
                } catch (Exception e) {
                }
                if (checkRes == 1) {
                    flag_res = 1;
                } else if (checkRes == 0) {
                    try {
                        result = insertRCCCapacity(h_workshopid, h_rcid, avaseats, avaccomo, session, acco_cost, food_cost);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if (result > 0) {
                        flag_res = 2;
                    } else {
                        flag_res = 3;
                    }
                } else if (checkRes == 2) {
                    //error msg no update / insert
                    flag_res = 3;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (flag_res == 1) {
                session.setAttribute("update_result", "already use");
            } else if (flag_res == 2) {
                session.setAttribute("update_result", "user inserted");
            } else if (flag_res == 3) {
                session.setAttribute("update_result", "user failed");
            }
        }
        try {
        } catch (Exception e) {
            e.printStackTrace();
        }

        return SUCCESS;
    }

    public int updateRCCCapacity(int workshopid, int rcid, int ava_seats, int ava_acco, HttpSession session, String acco_cost, String food_cost) {
        UtilityProcess process = new UtilityProcess();
        int res = 0;
        rcc.setWorkshopid(h_workshopid);
        rcc.setRcid(h_rcid);
        rcc.setAvailable_accomo(ava_acco);
        rcc.setAvailable_seats(ava_seats);
        rcc.setAcco_cost(acco_cost);
        rcc.setFood_cost(food_cost);
        setRcc(rcc);
        try {
            res = process.updateRemoteCenterCapacity(rcc);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

    public int insertRCCCapacity(int workshopid, int rcid, int ava_seats, int ava_acco, HttpSession session, String acco_cost,String food_cost) {
        UtilityProcess process = new UtilityProcess();
        int update_res = 0;
        if (workshopid == 0 || rcid == 0) {
            session.setAttribute("update_result", "<font color='red'>No data is updated.</font>");
        } else if (workshopid != 0 || rcid != 0) {
            rcc.setWorkshopid(workshopid);
            rcc.setRcid(rcid);
            rcc.setAvailable_accomo(ava_acco);
            rcc.setAvailable_seats(ava_seats);
            rcc.setAcco_cost(acco_cost);
            rcc.setFood_cost(food_cost);
            setRcc(rcc);
            try {
                update_res = process.insertRemoteCenterCapacity(rcc);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return update_res;
    }

    public String getRCC() throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession();
        UtilityProcess process = new UtilityProcess();
        SimpleStringCipher cipher = new SimpleStringCipher();
        String rcid, workshopid, avaseats, avaccom;
        String rcid_enc = ServletActionContext.getRequest().getParameter("rcid");
        String workshopid_enc = ServletActionContext.getRequest().getParameter("workshopid");
        workshopid = cipher.decrypt(workshopid_enc);
        rcid = cipher.decrypt(rcid_enc);
        setWc(process.listWorkshopContent(workshopid));
        return Utility.SUCCESS;
    }

    public void validate() {
    }

    /**
     * @return the rcc
     */
    public RemoteCenterCapacity getRcc() {
        return rcc;
    }

    /**
     * @param rcc the rcc to set
     */
    public void setRcc(RemoteCenterCapacity rcc) {
        this.rcc = rcc;
    }

    /**
     * @return the h_workshopid
     */
    public int getH_workshopid() {
        return h_workshopid;
    }

    /**
     * @param h_workshopid the h_workshopid to set
     */
    public void setH_workshopid(int h_workshopid) {
        this.h_workshopid = h_workshopid;
    }

    /**
     * @return the h_rcid
     */
    public int getH_rcid() {
        return h_rcid;
    }

    /**
     * @param h_rcid the h_rcid to set
     */
    public void setH_rcid(int h_rcid) {
        this.h_rcid = h_rcid;
    }

    /**
     * @return the person
     */
    public Person getPerson() {
        return person;
    }

    /**
     * @param person the person to set
     */
    public void setPerson(Person person) {
        this.person = person;
    }

    /**
     * @return the wc
     */
    public ArrayList<WorkshopContent> getWc() {
        return wc;
    }

    /**
     * @param wc the wc to set
     */
    public void setWc(ArrayList<WorkshopContent> wc) {
        this.wc = wc;
    }

    /**
     * @return the cc
     */
    public int getCc() {
        return cc;
    }

    /**
     * @param cc the cc to set
     */
    public void setCc(int cc) {
        this.cc = cc;
    }
}
