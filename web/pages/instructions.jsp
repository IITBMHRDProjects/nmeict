<%-- 
    Document   : instructions
    Created on : 4 Aug, 2015, 1:24:24 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:iterator value="workshopContent">
    <h3>INSTRUCTIONS</h3><br/>
    <div class="form_enclosure">
        <div  class="form_box">   
            <h1><s:property value="workshopname" /> </h1>
            <s:if test="dateToBeDisplayed == 1">
            <h4 align="center" style="color: #003366;"><s:property  value="startdate"/> to <s:property value="enddate"/></h4>
            </s:if><s:else></s:else>
            <br/><h2>Instructions to be followed for enrolling in the workshop</h2>
            <div>
                <p id="details_introduction" ><s:property escape="false" value="instructions"/></p>
            </div>
        </div>
    </div>
</s:iterator>