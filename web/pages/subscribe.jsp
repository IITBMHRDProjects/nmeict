<%-- 
    Document   : subscribe
    Created on : 24 Feb, 2016, 10:21:37 AM
    Author     : abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<h3>Request for  subscription</h3>
<div>
    <s:if test='hasActionMessages()'>
        <table  style="width: 725px;border-radius: 7px 7px 7px 7px;border:1px solid #222222;">
            <tr>
                <td style="background-color: #EEE;color: #474692;"> <p style="color: black">Dear User, <br/>
                    <div class="errorDiv" style="color:black;font-weight: normal;"><s:actionmessage/></div></p>
                </td>
            </tr>
        </table>
    </s:if>
    <s:if test="hasActionErrors()">
        <table  style="width: 725px;border-radius: 7px 7px 7px 7px;border:1px solid #222222;">
            <tr>
                <td style="background-color: #EEE;color: #474692;"> <p style="color: black">Dear User, </p>
                    <div class="errorDiv" style="color:black;font-weight: normal;">
                        <s:actionerror/>
                    </div>
                    <p style="color: black;margin-left: 5px;"> Please sign up <a href="signup.html"/>Here</a> to subscribe to our mailing list.</p>
                </td>
            </tr>
        </table>       
    </s:if>
</div>