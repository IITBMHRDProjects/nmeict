<%-- 
    Document   : paymentSuccess
    Created on : 12 Jan, 2016, 5:35:17 PM
    Author     : dipesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <body>
    <s:if test="resultMsg == 'validurl'">
        <s:if test="statusVal == 'statusvalid'">
            <h3>Your transaction is successful</h3>
            <div class="form_enclosure">
                <div>
                    <p style="text-align: center;"><b>Your transaction has been completed successfully </b></p><br> 
                    Following are the details of your transaction:<br>
                    <table style="">
                        <tr>
                            <td style="padding: 10px;">Bank Transaction Ref. Number :</td>
                            <td><s:property value="paymentgateway.getRefNo()"/></td>
                        </tr>
                        <tr>
                            <td style="padding: 10px;">Unique Request id :</td>
                            <td><s:property value="paymentgateway.getReqId()"/></td>
                        </tr>
                        <tr>
                            <td style="padding: 10px;">Total Amount(Rs.) :</td>
                            <td><s:property value="paymentgateway.getTotalAmt()"/></td>
                        </tr>
                        <tr>
                            <td style="padding: 10px;">Transaction Date :</td>
                            <td><s:property value="paymentgateway.getTransDate()"/></td>
                        </tr>
                        <tr>
                            <td style="padding: 10px;">Payment Status :</td>
                            <td>Success</td>
                        </tr>
                    </table>
                    </div>
            </div>
        </s:if>
        <s:if test="statusVal == 'statusnotvalid'">
            <h3>Your transaction failed</h3>
            <div class="form_enclosure">
                <div>
                    <p style="text-align: center;"><b>Your transaction has been failed. </b></p><br>
                    Following are the details of your transaction:<br>
                    <table>
                        <tr>
                            <td style="padding: 10px;">Bank Transaction Ref. Number :</td>
                            <td><s:property value="paymentgateway.getRefNo()"/></td>
                        </tr>
                        <tr>
                            <td style="padding: 10px;">Unique Request id :</td>
                            <td><s:property value="paymentgateway.getReqId()"/></td>
                        </tr>
                        <tr>
                            <td style="padding: 10px;">Total Amount :</td>
                            <td><s:property value="paymentgateway.getTotalAmt()"/></td>
                        </tr>
                        <tr>
                            <td style="padding: 10px;">Transaction Date :</td>
                            <td><s:property value="paymentgateway.getTransDate()"/></td>
                        </tr>
                        <tr>
                            <td style="padding: 10px;"> Message :</td>
                            <td><s:property value="paymentgateway.getMsg()"/></td>
                        </tr>
                    </table>
                   </div>
                <p>
                    <% String appid="10113"; %>
                    Please try again, <a style="text-decoration: none;" href="processPayment?appid=<%= appid %>&pid=<s:property value="paymentgateway.userId"/>&amt=<s:property value="paymentgateway.totalAmt"/>&name=<s:property value="paymentg1.name"/>&workshopid=<s:property value="paymentg1.workshopid"/>&msg=<s:property value="paymentg1.purpose"/>"><input style="background: #1c9212; color: white; width: 100px; height: 30px; border-radius: 10px; font-size: 16px;" type="button" value="Pay Now"></a> 
                </p>
            </div>
        </s:if>
    </s:if>
    <s:if test="resultMsg == 'notvalidurl'">
        <h3>Invalid Url</h3>
        <div class="form_enclosure">
            <p>
                Request from invalid url.
            </p>
        </div>
    </s:if>
    <%--<s:if test="{(resultMsg == null)}">--%>
    <s:if test="resultMsg == 'none'">
        <h3>Error</h3>
        <div class="form_enclosure">
            <p>
                Unable to execute query..
            </p>
        </div>
    </s:if>
</body>
</html>

