/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.project.action;

import com.opensymphony.xwork2.ActionSupport;
import java.io.DataInputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.project.bean.Participant;
import org.project.bean.PaymentGateway;
import org.project.bean.Person;
import org.project.bean.WorkshopContent;
import org.project.process.UtilityProcess;
import org.project.utilities.ParticipantStatusUtility;
import org.project.utilities.SimpleStringCipher;
import org.project.utilities.Utility;

/**
 *
 * @author dipesh
 */
public class PaymentAction extends ActionSupport {

    private String resultMsg = "none";
    private PaymentGateway paymentgateway;
    private PaymentGateway paymentg1;
    private ArrayList<PaymentGateway> participants;
    String parm1, url, constanturl = "path/onlinepay";
    String reqType, reqId, userId, totalAmt, transId, refNo, status, transDate, transTime, provId, msg;
    private String dataError, statusVal;
    private static final String OPS_ACK_URL = "http://path/onlinepay/OnlinePayAckServlet?transId=";
    private ArrayList<WorkshopContent> workshopcontent;
    private ArrayList<PaymentGateway> participants1;
    private ArrayList<WorkshopContent> workshopsremark;

    public String paymentSuccess() {
        try {
            url = ServletActionContext.getRequest().getHeader("referer");
            System.out.println(url);
            try{
                HttpSession session = ServletActionContext.getRequest().getSession();
                Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
                //System.out.println(person.getEmail());
            }catch(Exception e){e.printStackTrace();}
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String paymentFailure() {
        try {
            url = ServletActionContext.getRequest().getHeader("referer");
            if (url.contains(constanturl)) {
                resultMsg = "validurl";
            } else {
                resultMsg = "notvalidurl";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String getAllParticipantPaymentDetails() {
        try {
            String enc_workshopid = ServletActionContext.getRequest().getParameter("workshopid");
            SimpleStringCipher cipher = new SimpleStringCipher();
            String workshopid = cipher.decrypt(enc_workshopid);
            UtilityProcess process1 = new UtilityProcess();
            participants = process1.getParticipantsPaymentDetails(workshopid);
            setWorkshopcontent(process1.listWorkshopContent(workshopid));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String getPaymentDetailsOfParticipant() {
        try {
            String workshopid = ServletActionContext.getRequest().getParameter("workshopid");
            String participantid = ServletActionContext.getRequest().getParameter("pid");
            //  SimpleStringCipher cipher = new SimpleStringCipher();
            // String workshopid = cipher.decrypt(enc_workshopid);
            UtilityProcess process1 = new UtilityProcess();
            participants1 = process1.getTransactionDetailsOfParticipant(workshopid, participantid);
            setWorkshopcontent(process1.listWorkshopContent(workshopid));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String getWorkhshopsWithRemarks() {
        try {
            HttpSession session = ServletActionContext.getRequest().getSession();
            Person person = (Person) session.getAttribute(Utility.USER_HANDLE);
            UtilityProcess process = new UtilityProcess();
            if (person != null) {
                String period = "90 day";
                Date date = new Date();
                Date may12009 = new GregorianCalendar(2009, 05, 01).getTime();
                long diff = date.getTime() - may12009.getTime();
                period = Long.toString(diff / (1000 * 60 * 60 * 24)) + " day";
                workshopsremark = process.listWorkshopsWithRemark(period);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public Map<String, String> splitStringToList(String input) {
        StringTokenizer tokenizer = new StringTokenizer(input, "&");
        Map<String, String> opList = new HashMap<String, String>();
        String nextToken = null;
        String[] keyVal = new String[2];
        while (tokenizer.hasMoreTokens()) {
            nextToken = tokenizer.nextToken().trim();
            if (nextToken != null) {
                keyVal = nextToken.split("=");
                opList.put(keyVal[0], keyVal[1]);
            }
        }
        return opList;
    }

    private void acknowledgeOPS(String urlTosend) {
        HttpURLConnection con = null;
        try {
            DataInputStream di = null;
            URL url = new URL(urlTosend);
            System.setProperty("http.nonProxyHosts", "localhost|127.0.0.1|*path|10.*.*.*");
            con = (HttpURLConnection) url.openConnection();
            DataInputStream inStream = new DataInputStream(con.getInputStream());
            con.connect();
        } catch (Exception ex) {
            System.out.println("Exception cought:\n" + ex.toString());
            ex.printStackTrace();
        } finally {
            con.disconnect();
        }
    }

    /**
     * @return the resultMsg
     */
    public String getResultMsg() {
        return resultMsg;
    }

    /**
     * @param resultMsg the resultMsg to set
     */
    public void setResultMsg(String resultMsg) {
        this.resultMsg = resultMsg;
    }

    /**
     * @return the paymentgateway
     */
    public PaymentGateway getPaymentgateway() {
        return paymentgateway;
    }

    /**
     * @param paymentgateway the paymentgateway to set
     */
    public void setPaymentgateway(PaymentGateway paymentgateway) {
        this.paymentgateway = paymentgateway;
    }

    /**
     * @return the dataError
     */
    public String getDataError() {
        return dataError;
    }

    /**
     * @param dataError the dataError to set
     */
    public void setDataError(String dataError) {
        this.dataError = dataError;
    }

    /**
     * @return the statusVal
     */
    public String getStatusVal() {
        return statusVal;
    }

    /**
     * @param statusVal the statusVal to set
     */
    public void setStatusVal(String statusVal) {
        this.statusVal = statusVal;
    }

    /**
     * @return the paymentg1
     */
    public PaymentGateway getPaymentg1() {
        return paymentg1;
    }

    /**
     * @param paymentg1 the paymentg1 to set
     */
    public void setPaymentg1(PaymentGateway paymentg1) {
        this.paymentg1 = paymentg1;
    }

    /**
     * @return the participants
     */
    public ArrayList<PaymentGateway> getParticipants() {
        return participants;
    }

    /**
     * @param participants the participants to set
     */
    public void setParticipants(ArrayList<PaymentGateway> participants) {
        this.participants = participants;
    }

    /**
     * @return the workshopcontent
     */
    public ArrayList<WorkshopContent> getWorkshopcontent() {
        return workshopcontent;
    }

    /**
     * @param workshopcontent the workshopcontent to set
     */
    public void setWorkshopcontent(ArrayList<WorkshopContent> workshopcontent) {
        this.workshopcontent = workshopcontent;
    }

    /**
     * @return the participants1
     */
    public ArrayList<PaymentGateway> getParticipants1() {
        return participants1;
    }

    /**
     * @param participants1 the participants1 to set
     */
    public void setParticipants1(ArrayList<PaymentGateway> participants1) {
        this.participants1 = participants1;
    }

    /**
     * @return the workshopsremark
     */
    public ArrayList<WorkshopContent> getWorkshopsremark() {
        return workshopsremark;
    }

    /**
     * @param workshopsremark the workshopsremark to set
     */
    public void setWorkshopsremark(ArrayList<WorkshopContent> workshopsremark) {
        this.workshopsremark = workshopsremark;
    }
}
