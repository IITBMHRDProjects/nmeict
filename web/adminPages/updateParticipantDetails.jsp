<%-- 
    Document   : updateParticipantDetails
    Created on : 1 Sep, 2014, 11:01:06 AM
    Author     : asl
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

<!--css added for the pagination and table css-->
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script language="JavaScript" src="js/jquery.tipTip.minified.js"></script>       
<script type="text/javascript">
    $(function() {
        $(".tipTip").tipTip({defaultPosition: "right"});
    }); 
</script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript">    
    function changeTest(workshopid,status){
        var rcid = document.getElementById('rcid').value;
        fetchParticipantDetails1(rcid,workshopid,status);
        fetchParticipantCount(rcid,workshopid,status);
    }       
    function checkStatus(workshopid,status){
        rcid=document.getElementById('rcid').value;    
        fetchParticipantDetails1(rcid,workshopid,status);
        fetchParticipantCount(rcid,workshopid,status);
    }
    function checkStatus1(workshopid,status){
        var rcid="all";
        fetchParticipantDetails1(rcid,workshopid,status);
        fetchParticipantCount(rcid,workshopid,status);
    }        
</script>

<%
    SimpleStringCipher cipher = new SimpleStringCipher();
    String all_encrypted = cipher.encrypt("all");
    String registered_encrypted = cipher.encrypt("Request Registered");
    String invalid_encrypted = cipher.encrypt("Registration Invalid");
    String verified_encrypted = cipher.encrypt("Request Verified");
    String approved_encrypted = cipher.encrypt("Request Approved");
    String waitlist_encrypted = cipher.encrypt("Waitlisted");
    String cancelled_encrypted = cipher.encrypt("Cancelled");
    String confirmed_encrypted = cipher.encrypt("Confirmed");
    String encry_workshopid="";
%>
<body>
    <div>
        <s:iterator value="workshopContent">
            <h1 style="color: #036;font-weight: bold;font-size: 220%;text-align: center;"><s:property value="workshopname" /></h1>
            <h4 align="center"><s:property value="sponsor"/></h4>
            <br/>
            <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   
            <div class="form_settings">           
                <s:if test="%{categorycode == 5}">
                    <table class="content_container1">
                        <tr><td>Remote Center:</td><td><select class="displayselect" id="rcid" name="remotecenter" onchange="changeTest('<s:property value="workshopid_encrypted"/>','<s:property value="status_encrypted"/>');" >
                                    <option value="all">All</option>
                                    <s:iterator value="remoteCenters">
                                        <option value="<s:property value="remoteCenterId"/>"><s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                    </s:iterator>
                                </select>
                            </td></tr>
                    </table>               
                </s:if>
                <s:if test="%{categorycode == 4}">
                    <input type="hidden" id="rcid" value="all">
                </s:if>
            </div>
            <s:iterator value="countOfParticipants">
                <script>
                    var statusAlljs=<s:property value="totalParticipants"/>;
                    var statusConfirmedjs=<s:property value="confirmedParticipants"/>;       
                </script>
                <input type="hidden" id="statusConf" value="<s:property value="confirmedParticipants"/>"/>
                <div style="margin-left: 80px;width: 740px;_margin-left:130px;padding:7px;display:inline-block;position: relative;left:150px;">
                    <div id="AllParticipants" class="all tipTip" style="width: 100px" title="Click to see all participants of all status."><a href="javascript:void(0);"  onclick="checkStatus1('<s:property value="workshopid_encrypted"/>','<%=all_encrypted%>');" id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a> </div>
                    <div class="gap20">&nbsp;</div>
                    <div id="WaitlistedParticipants" class="waitlisted tipTip" style="width: 100px" title="This status means participant has been waitlisted for the workshop as the seating capacity of the selected remote center is full"><a href="javascript:void(0);"  onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=waitlist_encrypted%>');" id="statusWaitlisted">Waitlisted (<s:property value="waitlistedParticipants"/>)</a> </div>
                    <div style="background-size: 40px 20px;background-position: center;width:80px;" class="rightarrow">&nbsp;</div>
                    <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                    <div class="toparrow" style="position:relative;left:3px;">&nbsp;</div>
                    <div class="gap50">&nbsp;</div><div class="gap40">&nbsp;</div>
                    <div class="bottomarrow" style="position:relative;left:45px;">&nbsp;</div>
                    <div class="clear">&nbsp;</div>
                    <div id="RegisteredParticipants" class="requestregistered tipTip" title="This status means paticipant has registered but not verified his/her email."><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=registered_encrypted%>');" id="statusRegistered">Registered (<s:property value="registeredParticipants"/>)</a></div>
                    <div class="rightarrow">&nbsp;</div>
                    <div id="VerifiedParticipants" class="requestverified tipTip" title="This status means participant has verified his/her email."><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=verified_encrypted%>');" id="statusVerified">Verified (<s:property value="verifiedParticipants"/>)</a></div>
                    <div class="rightarrow">&nbsp;</div>
                    <div id="ApprovedParticipants" class="requestapproved tipTip" title="This status means participant has been provisionally selected."><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=approved_encrypted%>');" id="statusApproved">Approved (<s:property value="approvedParticipants"/>)</a></div>
                    <div class="rightarrow">&nbsp;</div>
                    <div class="confirmed tipTip" style="width:100px" title="This status means participant has confirmed his/her selection and logged in to moodle."><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=confirmed_encrypted%>');" id="statusConfirmed">Confirmed (<script>document.writeln(statusConfirmedjs)</script>)</a></div>
                    <div id="ConfirmedParticipants" class="clear">&nbsp;</div>
                    <div  class="vbar" style="height:40px;width:80px;_width:85px;margin-left: 10px;">&nbsp;</div><div class="blank">&nbsp;</div>
                    <div class="vbar" style="height:40px;width:120px;_width:140px;">&nbsp;</div><div class="blank">&nbsp;</div>
                    <div class="vbar" style="height:40px;width:60px;_width:100px;">&nbsp;</div><div class="blank">&nbsp;</div>
                    <div class="vbar" style="height:40px;width:50px;_width:70px;margin-left: 30px;">&nbsp;</div><div class="blank">&nbsp;</div>
                    <div class="hbar" style="height:12px;margin-left:60px;width:490px;_width: 450px;margin-top: 0px;padding-top:0px;">&nbsp;</div>
                    <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                    <div class="doublearrow" style="position:relative;right:20px;">&nbsp;</div>
                    <div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div>                    
                    <div style="" class="bottomarrow">&nbsp;</div>
                    <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div><div class="gap10">&nbsp;</div>
                    <div id="InvalidParticipants" class="registrationinvalid tipTip" style="width: 100px" title="This status means participant's registration is invalid. The permission letter format is wrong."><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=invalid_encrypted%>');" id="statusInvalid">Invalid (<s:property value="invalidParticipants"/>)</a></div>
                    <div class="gap100">&nbsp;</div>  
                    <div id="CancelledParticipants" class="cancelled tipTip" style="width: 100px" title="This status means participant has been cancelled"><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=cancelled_encrypted%>');" id="statusCancelled">Cancelled (<s:property value="cancelledParticipants"/>)</a></div>
                    <div class="clear">&nbsp;</div><br/>
                    <div align="center" style="padding-right: 180px;color:red;font-size:12px;">Click on any status above to view list of participant of that status.</div>
                </div>
            </s:iterator>
               <% 
                encry_workshopid =(String) request.getAttribute("workshopid_encrypted");
                //System.out.println("before ency "+encry_workshopid);
                encry_workshopid = cipher.decrypt(encry_workshopid);
                //System.out.println("after ency "+encry_workshopid);
               %>
               
        </s:iterator>
    </div>


    <!--    <table class="content_container"><tr><td><h4 style="color: #003366;width:900px;text-align: center;position: relative;left:50px;"><b>List of Selected Participants</b></h4></td></tr>
        </table>-->
    <!--<br/><h3 class="adminh3">List of Participants</h3><br/>-->   
    <table class="display1" id="participantDetail1" style="word-spacing: normal;text-wrap: avoid;">
        <thead id = "headers" > 
            <tr>
                <th>S.No</th>
                <th>Name</th>
                <th>Email</th>
                <th>RC ID</th>
                <th>Remote Center Name</th>
                <s:iterator value="workshopContent">
                    <s:if test="%{categorycode == 5}">
                        <th>Institute Name</th>
                    </s:if>
                </s:iterator>
                <th >State</th>
                <th>Mobile Number</th>
                <th>Acco</th>
                <th>Letter</th>
                <th>Status</th>
                <th>Update</th>
            </tr>
        </thead>
        <tbody align="center" id="participantDetailsBody1" >
            <s:iterator value="participantdetails" status="itStatus">
                <tr class="gradeU">
                    <td style="align:right" id="sno"><s:property value="#itStatus.count" /></td>
                    <td id="name"><s:property value="firstName" /> <s:property value="lastName" /></td>
                    <td id="email"><s:property value="email" /></td>
                    <td id="remotecenterId"><s:property value="remoteCenter.remoteCenterId"/></td>
                    <td id="remotecenterName"><s:property value="remoteCenter.remoteCenterName"/></td>
                    <s:iterator value="workshopContent">
                        <s:if test="%{categorycode == 5}">
                            <td id="instituteName"><s:property value="institute.instituteName"/></td>
                        </s:if>
                    </s:iterator>                     
                    <td id="remotecenterState"><s:property value="remoteCenter.rc_state" /></td>
                    <!--<td id="regtime"><s:property value="registrationDetails.regtime" /></td>-->
                    <td id="mobile"><s:property value="mobileNumber" /></td>
                    <td id="accommodation"><s:property value="registrationDetails.accomodation" /></td>
                    <td id="letter"><a href="<s:url value=""/>Permission_Letter/<s:property value="registrationDetails.letter" />"><s:property value="registrationDetails.letter" /></a></td>
                    <td id="participantStatus"><s:property value="registrationDetails.status" /></td>
                    <td>
                        <a href="updateDetails.html?email=<s:property value="email" />&workshopid=<%= encry_workshopid %>"><input type="button" value="update"></a>
                    </td>
                </tr> 
            </s:iterator> 
        </tbody>  
    </table>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#participantDetail1').dataTable( {
//                                "scrollX": true
            } );
        } );
    </script>
    
</body>
