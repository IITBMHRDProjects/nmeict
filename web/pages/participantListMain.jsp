<%-- 
    Document   : participantListMain
    Created on : 18 Aug, 2014, 8:37:06 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:iterator value="workshopContent" >
    <h3>Participant Details</h3><br/>
    <div class="form_enclosure">
        <div  class="form_box">   
            <h1><s:property value="workshopname" /> </h1>
            <h4 align="center" style="color: #003366;">Participant List</h4>
            <table class="content_container1">
                <thead> <tr><td>S No</td><td>Name</td><td>Institute</td></tr></thead>
                <s:iterator value="participantList_main" status="itStatus">
                    <tr>
                        <td><s:property value="#itStatus.count" /></td>
                        <td><s:property value="firstName" /> <s:property value="lastName" /></td>
                        <td><s:property value="institute.instituteName"/></td>
                    </tr>
                </s:iterator>
            </table>
        </div>
    </div>
</s:iterator>
