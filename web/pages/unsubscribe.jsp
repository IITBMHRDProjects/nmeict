<%-- 
    Document   : unsubscribe
    Created on : 29 Oct, 2015, 4:58:22 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>

<h3>Request for un-subscription</h3>
<div>
    <s:if test='hasActionMessages()'>
        <table  style="width: 725px;border-radius: 7px 7px 7px 7px;border:1px solid #222222;">
            <tr>
                <td style="background-color: #EEE;color: #474692;"> <p style="">Dear User, <br/>
                        <s:actionmessage/></p>
                </td>
            </tr>
        </table>
    </s:if>
</div>
