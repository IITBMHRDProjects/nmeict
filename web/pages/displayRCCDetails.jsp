<%-- 
    Document   : displayRCCDetails
    Created on : 4 Aug, 2015, 4:13:24 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<s:iterator value="rccDetails">
    <h3>Remote Center Capacity Details</h3><br/>

    <div class="form_enclosure">
        <div  class="form_box"> 

            <h1><s:property value="workshopContent[0].workshopname" /></h1>
            <h4 align="center"><s:property value="workshopContent[0].sponsor"/></h4>
            <br/>
            <h4 align="center"><b><s:property  value="workshopContent[0].startdate"/> to <s:property value="workshopContent[0].enddate"/></b></h4>   
            <br/>                      
            <input type="hidden" id="cc" name="cc" value="<s:property value="workshopContent[0].categorycode"/>"/>


            <p style="font-size: 120%;"><span style="color:#474686;">Available seats : <b> <s:property escape="false" value="available_seats"/> </b></span>
                <input type="text" readonly value="" style="display:none;"/>
            </p>
            <p style="font-size: 120%;"><span style="color:#474686;">Available Accommodation : <b> <s:property escape="false" value="available_accomo"/></b></span>
                <input type="text" readonly value="" style="display:none;"/>
            </p>
            <s:if test='%{workshopContent[0].categorycode == 7}'>
                <p style="font-size: 120%; display: inline;"><span style="color:#474686;">Accommodation Cost Per Day <b> Rs. <s:property escape="false" value="acco_cost"/></b></span>
                    <input type="text" readonly value="" style="display:none;"/>
                </p><br><br>
                <p style="font-size: 120%; display: inline;"> <span style="color:#474686;">Food Cost Per Day <b> Rs. <s:property escape="false" value="food_cost"/></b></span>
                    <input type="text" readonly value="" style="display:none;"/>
                </p>
            </s:if>               
        </div>
    </div>
</s:iterator>