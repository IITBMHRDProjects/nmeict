<%-- 
    Document   : updateRCSuccess
    Created on : 10 Feb, 2015, 3:44:52 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="hasActionErrors()">
    <div class="msg msg-error">
        <s:actionerror/>
        <a href="javascript:void(0);" class="close">close</a>
    </div>
    <div class="form_enclosure">
        <p>To go back to the manage remote center interface</p>
        <p>Click Here ----> <a href="viewRC.html?rcid=wZFlr-khrFxEMgeJzFwgvg">Manage Remote Center</a></p>
        <p>To go back to the home page of the administrator interface </p>
        <p>click here ---> <a href="adminHome.html">ADMIN HOME</a></p>
    </div>
</s:if><s:else>
    <h3>Remote Center Details Updated Successfully</h3>
    <div class="form_enclosure">
        <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>        
        <p>You have updated the remote center details successfully.</p> 
        <p>To go back to the manage remote center interface</p>
        <p>Click Here ----> <a href="viewRC.html?rcid=wZFlr-khrFxEMgeJzFwgvg">Manage Remote Center</a></p>
        <p>To go back to the home page of the administrator interface </p>
        <p>click here ---> <a href="adminHome.html">ADMIN HOME</a></p>
    </div>
</s:else>