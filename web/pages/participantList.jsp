<%-- 
    Document   : participantList
    Created on : 19 Jun, 2014, 10:31:08 AM
    Author     : Abinaya
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
<% String callFrom = request.getParameter("callFrom");%>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<script type="text/javascript">
    function changeTest(workshopid, status) {
        var rcid = document.getElementById('rcid').value;
        //        fetchParticipantDetails(rcid,workshopid,status);
        //        fetchParticipantCount(rcid,workshopid,status);
        window.location.href = "participantList.html?workshopid=" + workshopid + "&status=" + status + "&rcid=" + rcid + "&callFrom=" +<%=callFrom%>;
    }
    function checkStatus(workshopid, status) {
        rcid = document.getElementById("rcid").value;
        var cc = document.getElementById("cc").value;
        fetchParticipantDetails(rcid, workshopid, status);
        fetchParticipantCount(rcid, workshopid, status);
    }
    function checkStatus1(workshopid, status) {
        var rcid = "all";
        fetchParticipantDetails(rcid, workshopid, status);
        fetchParticipantCount(rcid, workshopid, status);
    }
    function checkStatus3(workshopid, status) {
        rcid = document.getElementById("rcid").value;
        var cc = document.getElementById("cc").value;
        fetchParticipantDetails3(rcid, workshopid, status);
        fetchParticipantCount(rcid, workshopid, status);
    }
    function change() {
        alert(document.getElementById('statusConf').value);
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
    String accepted_encrypted = cipher.encrypt("Accepted");
    String completed_encrypted = cipher.encrypt("Completed");
%>
<div class="form_enclosure">
    <s:iterator value="workshopContent">
        <h1><s:property value="workshopname" /></h1>
        <h4 align="center"><s:property value="sponsor"/></h4>
        <br/>
        <s:if test="dateToBeDisplayed == 1">
            <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   
        </s:if><s:else></s:else>
            <div class="form_settings">              
            <s:if test="%{categorycode == 5 || categorycode == 7 || (categorycode == 8 && without_RC == 0) }">
                <div id="hideTable">
                    <table class="content_container" >
                        <tr><td>Remote Center:</td><td><select class="displayselect" id="rcid" name="remotecenter" onchange="changeTest('<s:property value="workshopid_encrypted"/>', '<s:property value="status_encrypted"/>');" >
                                    <option value="<%=all_encrypted%>">All</option>
                                    <s:iterator value="remoteCenters">
                                        <s:if test="%{remoteCenterId == rcid_present}" >
                                            <option value="<s:property value="enc_RC"/>" selected="true"><s:property value="remoteCenterId"/> -- <s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                        </s:if>
                                        <s:else>
                                            <option value="<s:property value="enc_RC"/>"><s:property value="remoteCenterId"/> -- <s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                        </s:else>
                                    </s:iterator>
                                </select>
                            </td></tr>
                        <tr><td colspan="2" style="text-align: center"><h4 style="color: #003366;position: relative;bottom: 5px;">Contact details of the workshop coordinators&nbsp;<a href="coordinatorList.html?workshopid=<s:property value="workshopid_encrypted"/>&callFrom=2" target="_blank"><img style="position: relative;top:5px;" id="plus_minus" src="images/click_here.png"></a></h4></td></tr>
                    </table>
                </div>
                <table hidden class="content_container"><tr><td style="text-align:center"><p><h4 style="color: #003366;position: relative;bottom: 5px;">Contact details of the workshop coordinators&nbsp;<a href="coordinatorList.html?workshopid=<s:property value="workshopid_encrypted"/>" target="_blank"><img style="position: relative;top:5px;" id="plus_minus" src="images/click_here.png"></a></h4></td></tr>
                </table>

                <% if (callFrom.equals("2")) {%>
                <script>document.getElementById("hideTable").style.display = "none";
                    document.getElementById("myElement").onclick = function() {
                        location.reload();
                    }
                </script>

                <% }%>

            </s:if>
            <s:if test="%{categorycode == 4}">
                <input type="hidden" id="rcid" value="<%=all_encrypted%>">
            </s:if>
            <s:if test="%{categorycode == 5}">
                <input type="hidden" id="cc" value="5"/>
            </s:if>
            <s:if test="%{categorycode == 4}">
                <input type="hidden" id="cc" value="4"/>
            </s:if>
            <s:if test="%{categorycode == 7}">
                <input type="hidden" id="cc" value="7"/>
            </s:if>
            <s:if test="%{categorycode == 8}">
                <input type="hidden" id="cc" value="8"/>
            </s:if>
        </div>
    </div>
    <s:iterator value="countOfParticipants">
        <script>
            var statusAlljs =<s:property value="totalParticipants"/>;
            var statusConfirmedjs =<s:property value="confirmedParticipants"/>;
        </script>
        <input type="hidden" id="statusConf" value="<s:property value="confirmedParticipants"/>"/>
        <s:if test='%{categorycode == 7}'>
            <div style="margin-left: 80px;width: 740px;_margin-left:130px;padding:7px;display:inline-block;">
                <div id="AllParticipants" class="all tipTip" style="width: 100px;display:none;" title="Click to see all participants of all status."><a href="javascript:void(0);"  onclick="checkStatus1('<s:property value="workshopid_encrypted"/>', '<%=all_encrypted%>');" id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a> </div>
                <div class="gap20">&nbsp;</div>
                <div id="WaitlistedParticipants" class="waitlisted tipTip" style="width: 100px; position: relative;left:255px;display: inline;" title="This status means participant has been accepted for the workshop"><a href="javascript:void(0);"  onclick="checkStatus3('<s:property value="workshopid_encrypted"/>', '<%=accepted_encrypted%>');" id="statusWaitlisted">Accepted (<s:property value="acceptedParticipants"/>)</a> </div>
                <div class="hbar" style="height:12px;margin-left:60px;width:105px;_width: 105px;margin-top: 0px;padding-top:0px;position: relative;left:200px;top:5px;">&nbsp;</div>
                <div class="bottomarrow" style="position:relative;left:185px;top:22px;display: inline;">&nbsp;</div>
                <div style="background-size: 40px 20px;background-position: center;width:80px;position: relative;left:80px;display: none;" class="rightarrow">&nbsp;</div>
                <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                <div class="toparrow" style="position:relative;left:150px;bottom:3px; display: inline;">&nbsp;</div>
                <div class="gap50">&nbsp;</div><div class="gap40">&nbsp;</div>
                <div class="bottomarrow" style="position:relative;left:30px;display: none;">&nbsp;</div>
                <div class="clear">&nbsp;</div>
                <div id="AllParticipants" class="all tipTip" style="position: relative;left:35px;" title="Click to see all participants of all status."><a href="javascript:void(0);" id="myElement" onclick="checkStatus3('<s:property value="workshopid_encrypted"/>', '<%=all_encrypted%>');" id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a></div>
                <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                <div id="RegisteredParticipants" class="requestregistered tipTip" style="position: relative;left:30px;color: white" title="This status means paticipant has registered for the workshop"><a href="javascript:void(0);" onclick="checkStatus3('<s:property value="workshopid_encrypted"/>', '<%=registered_encrypted%>');" id="statusRegistered">Registered (<s:property value="registeredParticipants"/>)</a></div>
                <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                <div id="ApprovedParticipants" class="requestapproved tipTip" style="position: relative;left:30px;" title="This status means participant has been provisionally selected."><a href="javascript:void(0);" onclick="checkStatus3('<s:property value="workshopid_encrypted"/>', '<%=approved_encrypted%>');" id="statusApproved"><s:if test='%{categorycode == 7}'>Verified</s:if><s:else>In-Process</s:else>(<s:property value="approvedParticipants"/>)</a></div>
                    <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div class="confirmed tipTip" style="width:100px;position: relative;left:35px" title="This status means participant has confirmed his/her selection and logged in to moodle."><a href="javascript:void(0);" onclick="checkStatus3('<s:property value="workshopid_encrypted"/>', '<%=confirmed_encrypted%>');" id="statusConfirmed">Confirmed (<script>document.writeln(statusConfirmedjs)</script>)</a></div>
                <div id="ConfirmedParticipants" class="clear">&nbsp;</div>
                <div  class="vbar" style="height:40px;width:80px;_width:85px;margin-left: 10px;">&nbsp;</div><div class="blank">&nbsp;</div>
                <div class="vbar" style="height:40px;width:120px;_width:140px;position: relative;right:27px">&nbsp;</div><div class="blank">&nbsp;</div>
                <div class="vbar" style="height:40px;width:60px;_width:100px;position: relative;right:15px">&nbsp;</div><div class="blank">&nbsp;</div>
                <div class="vbar" style="height:40px;width:50px;_width:70px;margin-left: 30px;">&nbsp;</div><div class="blank">&nbsp;</div>
                <div class="hbar" style="height:12px;margin-left:60px;width:490px;_width: 450px;margin-top: 0px;padding-top:0px;">&nbsp;</div>
                <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                <div class="vbar" style="position:relative;left: 35px;">&nbsp;</div>
                <div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div>                    
                <div style="position: relative;left:25px;" class="vbar">&nbsp;</div>
                <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div><div class="gap10">&nbsp;</div>
                <div id="InvalidParticipants" class="registrationinvalid tipTip" style="width: 100px;margin-left: 57px;position: relative;top:3px" title="This status means participant's registration is invalid. The permission letter format is wrong."><a href="javascript:void(0);" onclick="checkStatus3('<s:property value="workshopid_encrypted"/>', '<%=invalid_encrypted%>');" id="statusInvalid">Invalid (<s:property value="invalidParticipants"/>)</a></div>
                <div class="gap100">&nbsp;</div>  
                <div id="CancelledParticipants" class="cancelled tipTip" style="width: 100px;position: relative;right:145px;top:3px" title="This status means participant has been cancelled"><a href="javascript:void(0);" onclick="checkStatus3('<s:property value="workshopid_encrypted"/>', '<%=cancelled_encrypted%>');" id="statusCancelled">Cancelled (<s:property value="cancelledParticipants"/>)</a></div>
                <%--<div class="gap100">&nbsp;</div> --%>
                <div id="CompletedParticipants" class="completed tipTip" style="width: 100px;position: relative;" title="This status means participant has recived certificate"><a href="javascript:void(0);" onclick="checkStatus3('<s:property value="workshopid_encrypted"/>', '<%=completed_encrypted%>');"  id="statusCompleted">Completed (<s:property value="completedParticipants"/>)</a></div>
                <div class="clear">&nbsp;</div><br/>
                <div align="center" style="padding-right: 180px;color:red;font-size:12px;">Click on any status above to view list of participant of that status.</div>
            </div>
        </s:if>
        <s:else>
            <div style="margin-left: 80px;width: 740px;_margin-left:130px;padding:7px;display:inline-block;">
                <div id="AllParticipants" class="all tipTip" style="width: 100px;display:none;" title="Click to see all participants of all status."><a href="javascript:void(0);"  onclick="checkStatus1('<s:property value="workshopid_encrypted"/>', '<%=all_encrypted%>');" id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a> </div>
                <div class="gap20">&nbsp;</div>
                <div id="WaitlistedParticipants" class="waitlisted tipTip" style="width: 100px; position: relative;left:80px;display: none;" title="This status means participant has been waitlisted for the workshop as the seating capacity of the selected remote center is full"><a href="javascript:void(0);"  onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=waitlist_encrypted%>');" id="statusWaitlisted">Waitlisted (<s:property value="waitlistedParticipants"/>)</a> </div>
                <div style="background-size: 40px 20px;background-position: center;width:80px;position: relative;left:80px;display: none;" class="rightarrow">&nbsp;</div>
                <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                <div class="toparrow" style="position:relative;right:25px; display: none;">&nbsp;</div>
                <div class="gap50">&nbsp;</div><div class="gap40">&nbsp;</div>
                <div class="bottomarrow" style="position:relative;left:30px;display: none;">&nbsp;</div>
                <div class="clear">&nbsp;</div>
                <div id="AllParticipants" class="all tipTip" style="position: relative;left:35px;" title="Click to see all participants of all status."><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=all_encrypted%>');" id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a></div>
                <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                <div id="RegisteredParticipants" class="requestregistered tipTip" style="position: relative;left:30px;color: white" title="This status means paticipant has registered for the workshop"><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=registered_encrypted%>');" id="statusRegistered">Registered (<s:property value="registeredParticipants"/>)</a></div>
                <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                <div id="ApprovedParticipants" class="requestapproved tipTip" style="position: relative;left:30px;" title="This status means participant has been provisionally selected."><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=approved_encrypted%>');" id="statusApproved"><s:if test='%{categorycode == 7}'>Verified</s:if><s:else>In-Process</s:else>(<s:property value="approvedParticipants"/>)</a></div>
                    <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div class="confirmed tipTip" style="width:100px;position: relative;left:35px" title="This status means participant has confirmed his/her selection and logged in to moodle."><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=confirmed_encrypted%>');" id="statusConfirmed">Confirmed (<script>document.writeln(statusConfirmedjs)</script>)</a></div>
                <div id="ConfirmedParticipants" class="clear">&nbsp;</div>
                <div  class="vbar" style="height:40px;width:80px;_width:85px;margin-left: 10px;">&nbsp;</div><div class="blank">&nbsp;</div>
                <div class="vbar" style="height:40px;width:120px;_width:140px;position: relative;right:27px">&nbsp;</div><div class="blank">&nbsp;</div>
                <div class="vbar" style="height:40px;width:60px;_width:100px;position: relative;right:15px">&nbsp;</div><div class="blank">&nbsp;</div>
                <div class="vbar" style="height:40px;width:50px;_width:70px;margin-left: 30px;">&nbsp;</div><div class="blank">&nbsp;</div>
                <div class="hbar" style="height:12px;margin-left:60px;width:490px;_width: 450px;margin-top: 0px;padding-top:0px;">&nbsp;</div>
                <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                <div class="vbar" style="position:relative;left: 35px;">&nbsp;</div>
                <div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div>                    
                <div style="position: relative;left:25px;" class="vbar">&nbsp;</div>
                <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div><div class="gap10">&nbsp;</div>
                <div id="InvalidParticipants" class="registrationinvalid tipTip" style="width: 100px;margin-left: 57px;position: relative;top:3px" title="This status means participant's registration is invalid. The permission letter format is wrong."><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=invalid_encrypted%>');" id="statusInvalid">Invalid (<s:property value="invalidParticipants"/>)</a></div>
                <div class="gap100">&nbsp;</div>  
                <div id="CancelledParticipants" class="cancelled tipTip" style="width: 100px;position: relative;right:145px;top:3px" title="This status means participant has been cancelled"><a href="javascript:void(0);" onclick="checkStatus('<s:property value="workshopid_encrypted"/>', '<%=cancelled_encrypted%>');" id="statusCancelled">Cancelled (<s:property value="cancelledParticipants"/>)</a></div>
                <div id="CompletedParticipants" class="completed tipTip" style="width: 100px;position: relative;" title="This status means participant has recived certificate"><a href="javascript:void(0);" onclick="checkStatus3('<s:property value="workshopid_encrypted"/>', '<%=completed_encrypted%>');"  id="statusCompleted">Completed (<s:property value="completedParticipants"/>)</a></div>
                <div class="clear">&nbsp;</div><br/>
                <div align="center" style="padding-right: 180px;color:red;font-size:12px;">Click on any status above to view list of participant of that status.</div>
            </div></s:else>
    </s:iterator>
</s:iterator>
<!--
<table class="content_container"><tr><td style="text-align:center"><h4 style="color: #003366;width:750px;"><b>List of Selected Participants</b></h4></td></tr>
</table>-->
<br/><h3 width="750px">List of Participants</h3><br/>
<table class="display1" id="dispatchdetail"  cellpadding="0" cellspacing="0" style="font-size: 90%;width:770px;">
    <thead> 
        <tr>
            <th>S.No</th>
            <th>Enroll No</th>
            <th>Name</th>
            <th>Designation</th>
                <s:iterator value="workshopContent">
                    <s:if test="%{without_RC == 0}">
                    <th>RC ID</th>
                    </s:if>

                <s:if test="%{categorycode == 4 && respectiveCoWorkshopid == 0}">
                    <th>Remote Center</th>
                    </s:if>
                    <s:if test="%{categorycode == 4 && respectiveCoWorkshopid != 0}">
                    <th>Institute</th>
                    </s:if>
                    <s:if test="%{categorycode == 5 || categorycode == 7 || (categorycode == 8 && without_RC == 0)}">  
                    <th>Remote Center</th>
                    <th>Institute</th>
                    </s:if>
                </s:iterator>
            <th>State</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody align="center" >
        <s:iterator value="participantdetails" status="itStatus">
            <tr class="gradeU">
                <td><s:property value="#itStatus.count" /></td>
                <td><s:property value="registrationDetails.participantid" /></td>
                <td><s:property value="firstName" /> <s:property value="lastName" /></td>
                <td> <s:if test="designation.designationName.length() > 0"><s:property value="designation.designationName" /></s:if><s:else>NA</s:else></td>

                <s:iterator value="workshopContent">
                    <s:if test="%{without_RC == 0}">
                        <td><s:property value="remoteCenter.remoteCenterId"/></td>
                    </s:if>
                    <s:if test="%{categorycode == 4 && respectiveCoWorkshopid == 0}"> 
                        <td><s:property value="remoteCenter.remoteCenterName"/>, <s:property value="remoteCenter.rc_city"/></td>
                    </s:if>
                    <s:if test="%{categorycode == 4 && respectiveCoWorkshopid != 0}">
                        <td><s:property value="remoteCenter.remoteCenterName"/></td>
                    </s:if>
                    <s:if test="%{categorycode == 5 || categorycode == 7 || (categorycode == 8 && without_RC == 0)}">
                        <td><s:property value="remoteCenter.remoteCenterName"/></td>
                        <td><s:if test="institute.instituteName.length() > 0"><s:property value="institute.instituteName"/></s:if><s:else>NA</s:else></td>
                    </s:if>
                    <td><s:property value="remoteCenter.rc_state" /></td>
                    <td><s:if test='%{registrationDetails.status.equals("Request Approved")}'><s:if test='%{categorycode == 7}'>Verified</s:if><s:else>In-Process</s:else></s:if><s:else><s:property value="registrationDetails.status" /></s:else></td>
                </s:iterator> </tr>
            </s:iterator>
    </tbody>    
</table>
<script type="text/javascript">
    $(document).ready(function() {
        $('#dispatchdetail').dataTable({
            //                        "scrollX": true
        });
    });
</script>
<script>
    $(document).ready(function() {
        $("#settingoptions").hide();
        $("#showmore").click(function(e) {
            var x = e.pageX;
            var tmpx = x - 200;
            $("#settingoptions").css({left: tmpx});
            $("#settingoptions").slideToggle();
        });
    });
</script>