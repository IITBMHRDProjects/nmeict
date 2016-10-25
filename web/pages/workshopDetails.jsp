<%-- 
    Document   : workshopDetails
    Created on : 18 Aug, 2014, 2:46:34 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<script>
   
    function changeText(imageid,displayid){
        var srcTest=document.getElementById(imageid).src;
        if(srcTest.indexOf("plus_button.png") > -1){
            document.getElementById(displayid).style.display="inline";
            document.getElementById(imageid).src="images/minus_button.png";
        }
        else{
            document.getElementById(displayid).style.display="none";
            document.getElementById(imageid).src="images/plus_button.png";
        }
    }
</script>

<s:iterator value="workshopContent" >
    <h3>Workshop Details</h3><br/>
    <div class="form_enclosure">
        <div  class="form_box">   
            <h1><s:property value="workshopname" /> </h1>
            <h4 align="center" style="color: #003366;">This Workshop is conducted by <s:property escape="false" value="author"/> from <s:property  value="startdate"/> to <s:property value="enddate"/></h4>
            <br/><h2>Introduction </h2>
            <div>
                <p id="details_introduction" ><s:property escape="false" value="introduction"/></p>
            </div>
            <h2>Objective <img id="imgshow2" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow2','details_objective');"></h2>
            <div id="details_objective" style="display: none;">
                <p><s:property escape="false" value="objectives"/></p>
            </div>
            <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
                <h2>Participant Details <img id="imgshow3" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow3','details_coordinator');"></h2>
                <div id="details_coordinator" style="display: none;">
                    <table class="content_container1">
                        <thead> <tr><td>S No</td><td>Remote Center</td><td>No of Participants</td></tr></thead>
                        <s:iterator value="participantCenters_main" status="itStatus">
                            <tr>
                                <td><s:property value="#itStatus.count" /></td>
                                <td><s:property value="remoteCenter.remoteCenterName" /></td>
                                <td><a href="<s:property value="registrationDetails.link" />"><b><s:property value="registrationDetails.totalParticipants" /></b></a></td>
                            </tr>
                        </s:iterator>
                    </table>
                </div>
            </s:if>
            <s:if test="%{categorycode == 4}">
                <h2>Coordinator Details <img id="imgshow3" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow3','details_coordinator');"> </h2>
                <div id="details_coordinator" style="display: none;">
                    <table class="content_container1"  style="width:100%;" >
                        <thead><tr><td>S No</td><td>Name</td><td>Remote Center</td></tr></thead>
                        <s:iterator value="participantList" status="itStatus">
                            <tr>
                                <td><s:property value="#itStatus.count" /></td>
                                <td><s:property value="firstName" /> <s:property value="lastName" /></td>
                                <td><s:property value="remoteCenter.remoteCenterName"/>, <s:property value="remoteCenter.rc_city" /></td>
                            </tr>
                        </s:iterator>
                    </table>                    
                </div>

            </s:if> 

        </div>
    </div>
</s:iterator>
