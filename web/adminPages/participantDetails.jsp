<%-- 
    Document   : participantDetails
    Created on : 1 Sep, 2014, 11:01:06 AM
    Author     : Abinaya
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
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
    String completed_encrypted = cipher.encrypt("Completed");
    String update_enc = request.getParameter("update");
    String update = cipher.decrypt(update_enc);
    String workshopid_enc = request.getParameter("workshopid");
    String rcid_enc = request.getParameter("rcid");
    String contextPath = ServletActionContext.getServletContext().getRealPath("");
    String accepted_encrypted = cipher.encrypt("Accepted");
    String rcid_value = cipher.decrypt(rcid_enc);

%>

<s:if test='%{#session.loggedInUser.roleId > 1}'>
    <style>
        #mask{
            position: absolute;
            background-color: #000;
            z-index: 9000;
            display: none;
        }

        #boxes .window{
            position: fixed;
            height: 415px;
            width: 640px;
            z-index: 9999;
            /*padding: 20px;*/
            border: 3px solid orange;
            display: none;
            /*background: #3d2c10;*/
            background: #1e90ff;

        }

        #boxes #dialog {
            height: 409px;
            width: 675px;
        }

        #top{
            /*color: olive;*/
            color: white;
            /*background: #3d2c10;*/
            background: #1e90ff;
            font-size: 20px;
            margin-left: 10px;
        }

        #dialog .close{
            position: absolute;
            top: 0;
            right: 0;
            text-align: right;
            text-decoration: none;
            /*color: olive;*/
            color: white;
            margin-right: 10px;

        }

        #dialog1 .close{
            position: absolute;
            top: 0;
            right: 0;
            text-align: right;
            text-decoration: none;
            /*color: olive;*/
            color: white;
            margin-right: 10px;

        }

        #inwindow{
            margin-top: 0;
            /*background: wheat;*/ 
            height: 355px;
            border-top:  5px solid #1d1b6d;
            overflow: scroll;
            background: whitesmoke;
        }

        #invalid_list{
            margin-left: 20px;
            font-size: 14px;
            padding: 5px;
        }
        #other_div{
            margin-left: 20px;
        }
        #sendM{
            margin-left: 150px;
            background: #000;
            color: white;
            font-size: 15px;
            padding: 5px;
        }
    </style>
    <div>
        <div id="boxes">
            <div id="dialog" class="window">
                <p id="top">Registration Invalid Reasons  
                    <a href="#" class="close">Close</a>
                </p>
                <div id="inwindow">
                    <div id="invalid_list">
                    </div>
                    <input type="hidden" id="res_code" value=""/>
                    <input type="hidden" id="hide_userdata" value=""/>
                    <div id="other_div">
                        <br><label id=""><b>Other Reasons :</b></label><br><br>
                        <textarea rows="5" cols="50" id="other_msg" maxlength="250"></textarea><br>
                    </div><br>
                    <input id="sendM" type="button" value="Send Mail"  onclick="submitdata();"/><br><br>
                </div>
            </div>
            <div id="mask"></div>
        </div>

        <div id="boxes">
            <input type="hidden" id="pid_refund_reason" value=""/>
            <input type="hidden" id="workshopid_refund_reason" value=""/>
            <input type="hidden" id="updatedBy_refund_reason" value=""/>
            <input type="hidden" id="email_refund_reason" value=""/>
            <input type="hidden" id="refund_type" value=""/>
            <input type="hidden" id="workshopName" value="<s:property value='workshopContent[0].workshopname'/>"/>
            <div id="dialog1" class="window">
                <p id="top">Refund Details  
                    <a href="#" class="close">Close</a>
                </p>
                <div id="inwindow"> 
                    <div id="other_div">
                        <br><label id=""><b>Enter Details here:</b></label><br><br>
                        <textarea rows="5" cols="50" id="refund_reason" maxlength="250"></textarea><br>
                    </div><br>
                    <input id="sendM" type="button" value="Submit"  onclick="initiateRefund1();"/><br><br>
                </div>
            </div>
            <div id="mask"></div>
        </div>

        <s:iterator value="workshopContent">
            <input id="lms_moodle" type="hidden" value="<s:property value="lms_moodle"/>"/>
            <input id="lms_iitbx" type="hidden" value="<s:property value="lms_iitbx"/>"/>
            <input id="moodle_coursename" type="hidden" value="<s:property value="moodle_coursename"/>"/>
            <input id="iitbx_coursename" type="hidden" value="<s:property value="iitbx_coursename"/>"/>
            <h1 style="color: #036;font-weight: bold;font-size: 220%;text-align: center;"><s:property value="workshopname" /></h1>
            <h4 align="center"><s:property value="sponsor"/></h4>
            <br/><input type="hidden" id="without_RC" value="<s:property value="without_RC"/>">
            <br/><input type="hidden" id="rc_payment_if_required" value="<s:property value="payment_at_rc"/>">
            <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   
            <h4 style="color: black;"> <b>Click on the image to export details of the participants</b> <a onclick="createExcel(<s:property value="workshopid"/>,<s:property value="categorycode"/>, '<%=rcid_value%>', <s:property value="respectiveCoWorkshopid"/>)" style="position:relative;left:20px;top:10px;" title="Export to Excel">
                    <img src="images/savexls.png"/>
                </a></h4>
            <div class="form_settings">  
                <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
                    <table class="content_container1" style="font-size: 110%;">
                        <tr>
                            <td style="white-space: nowrap;padding: 0px;">Remote Center:</td><td style="white-space: nowrap;padding: 5px;"><select class="displayselect" id="rcid" name="remotecenter" onchange="changeTest('<%=update_enc%>', '<s:property value="workshopid_encrypted"/>', '<s:property value="status_encrypted"/>');" >
                                    <option value="<%=all_encrypted%>">All</option>
                                    <s:iterator value="remoteCenters">
                                        <s:if test="%{remoteCenterId == rcid_present}" >
                                            <option value="<s:property value="enc_RC"/>" selected="true"><s:property value="remoteCenterId"/>--<s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                        </s:if>
                                        <s:else>
                                            <option value="<s:property value="enc_RC"/>"><s:property value="remoteCenterId"/>--<s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                        </s:else>
                                    </s:iterator>                                             
                                </select>
                            </td>
                            <% if (update.equals("status")) {%>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap;padding: 0px;">View Remote Center Seating/Accommodation Provisionally Booked</td>
                            <td><input type="button" style="background: black;color: white; width: 100px;height:30px; border-radius: 7px;" onclick="viewSeats('<s:property value="workshopid_encrypted"/>')" value="View Seats"/></td></tr>

                        <s:if test="%{categorycode == 7 && #session.loggedInUser.roleId == 5}">
                            <tr> 
                                <td>Auto Enroll Accepted Participants to Moodle</td>
                                <td><input type="button" style="background: black;color: white; width: 100px;height:30px; border-radius: 7px;" onclick="autoEnrollAcceptedParticipants('<s:property value="workshopid"/>', '<%=contextPath%>')" value="Auto Enroll"/></td></tr>
                            </tr>
                        </s:if>
                        <s:if test="%{categorycode == 8 && payment_at_rc == 1  && #session.loggedInUser.roleId == 5}">
                            <tr> 
                                <td>Auto Enroll Accepted Participants to Moodle</td>
                                <td><input type="button" style="background: black;color: white; width: 100px;height:30px; border-radius: 7px;" onclick="autoEnrollAcceptedParticipants('<s:property value="workshopid"/>', '<%=contextPath%>')" value="Auto Enroll"/></td></tr>
                            </tr>
                        </s:if>    
                        <s:if test="%{(categorycode == 7 || categorycode == 5) && #session.loggedInUser.roleId == 5}">
                            <tr> 
                                <td>Auto Enroll RCC to Moodle</td>
                                <td><input type="button" style="background: black;color: white; width: 100px;height:30px; border-radius: 7px;" onclick="autoEnrollRCC('<s:property value="workshopid"/>', '<%=contextPath%>')" value="Auto Enroll RCC"/></td></tr>
                            </tr>
                        </s:if>  
                        <% }%></table>  
                    </s:if>
                    <s:if test="%{categorycode == 4}">
                    <input type="hidden" id="rcid" value="all">
                </s:if>
                <input type="hidden" id="cc" value="<s:property value="categorycode"/>"/>
            </div>
            <s:iterator value="countOfParticipants">
                <% if (update.equals("viewattendance")) {%>

                <% } else {%>
                <script>
                    var statusAlljs =<s:property value="totalParticipants"/>;
                    var statusConfirmedjs =<s:property value="confirmedParticipants"/>;
                </script>
                <input type="hidden" id="statusConf" value="<s:property value="confirmedParticipants"/>"/>
                <s:if test='%{categorycode == 7 }'>
                    <div style="margin-left: 80px;width: 740px;_margin-left:130px;padding:7px;display:inline-block;position: relative;left:150px;">
                        <div id="AllParticipants" class="all tipTip" style="width: 100px; display:none;" title="Click to see all participants of all status."><a href="javascript:void(0);"  onclick="checkStatus1('<s:property value="workshopid_encrypted"/>', '<%=all_encrypted%>');" id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a> </div>
                        <div class="gap20">&nbsp;</div>
                        <div id="WaitlistedParticipants" class="waitlisted tipTip" style="width: 100px; position: relative;left:255px; display: inline;" title="This status means participant has been accepted for the workshop"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=accepted_encrypted%>"   id="statusWaitlisted">Accepted (<s:property value="acceptedParticipants"/>)</a> </div>
                        <div class="hbar" style="height:12px;margin-left:60px;width:105px;_width: 105px;margin-top: 0px;padding-top:0px;position: relative;left:200px;top:5px;">&nbsp;</div>
                        <div class="bottomarrow" style="position:relative;left:185px;top:22px;display: inline;">&nbsp;</div>
                        <div style="background-size: 40px 20px;background-position: center;width:80px;position: relative;left:80px; display: none;" class="rightarrow">&nbsp;</div>
                        <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                        <div class="toparrow" style="position:relative;left:150px;bottom:3px;  display: inline;">&nbsp;</div>
                        <div class="gap50">&nbsp;</div><div class="gap40">&nbsp;</div>
                        <div class="bottomarrow" style="position:relative;left:30px; display: none;">&nbsp;</div>
                        <div class="clear">&nbsp;</div>
                        <div id="AllParticipants" class="all tipTip" style="position: relative;left:35px;" title="Click to see all participants of all status."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&status=<%=all_encrypted%>&rcid=<%=rcid_enc%>"  id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a></div>
                        <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div id="RegisteredParticipants" class="requestregistered tipTip" style="position: relative;left:30px;" title="This status means paticipant has registered for the workshop"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=registered_encrypted%>"  id="statusRegistered">Registered (<s:property value="registeredParticipants"/>)</a></div>
                        <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div id="ApprovedParticipants" style="position: relative;left:30px;" class="requestapproved tipTip" title="This status means participant has been provisionally selected."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=approved_encrypted%>"  id="statusApproved"><!--Verified--> In Process(<s:property value="approvedParticipants"/>)</a></div>
                        <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div class="confirmed tipTip" style="width:100px;position: relative;left:35px" title="This status means participant has confirmed his/her selection and logged in to moodle."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=confirmed_encrypted%>"  id="statusConfirmed">Confirmed (<script>document.writeln(statusConfirmedjs)</script>)</a></div>
                        <div id="ConfirmedParticipants" class="clear">&nbsp;</div>
                        <div  class="vbar" style="height:40px;width:80px;_width:85px;margin-left: 10px;">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="vbar" style="height:40px;width:120px;_width:140px;position: relative;right:27px">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="vbar" style="height:40px;width:60px;_width:100px;position: relative;right:15px">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="vbar" style="height:40px;width:50px;_width:70px;margin-left: 30px;">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="hbar" style="height:12px;margin-left:60px;width:490px;_width: 450px;margin-top: 0px;padding-top:0px;">&nbsp;</div>
                        <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                        <div class="doublearrow" style="position:relative;right:20px;">&nbsp;</div>
                        <div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div>                    
                        <div style="" class="bottomarrow">&nbsp;</div>
                        <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div><div class="gap10">&nbsp;</div>
                        <div id="InvalidParticipants" class="registrationinvalid tipTip" style="width: 100px" title="This status means participant's registration is invalid. The permission letter format is wrong."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=invalid_encrypted%>" id="statusInvalid">Invalid (<s:property value="invalidParticipants"/>)</a></div>
                        <div class="gap100">&nbsp;</div>  
                        <div id="CancelledParticipants" class="cancelled tipTip" style="width: 100px" title="This status means participant has been cancelled"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=cancelled_encrypted%>"  id="statusCancelled">Cancelled (<s:property value="cancelledParticipants"/>)</a></div>
                        <div class="gap100">&nbsp;</div> 
                        <div id="CompletedParticipants" class="completed tipTip" style="width: 100px" title="This status means participant has completed the course and assignments"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=completed_encrypted%>"  id="statusCancelled">Completed (<s:property value="completedParticipants"/>)</a></div>

                        <div class="clear">&nbsp;</div><br/>
                        <div align="center" style="padding-right: 180px;color:red;font-size:12px;">Click on any status above to view list of participant of that status.</div>
                    </div>
                </s:if>
                <s:elseif test='%{categorycode == 8 && payment_at_rc == 1}'>
                    <div style="margin-left: 80px;width: 740px;_margin-left:130px;padding:7px;display:inline-block;position: relative;left:150px;">
                        <div id="AllParticipants" class="all tipTip" style="width: 100px; display:none;" title="Click to see all participants of all status."><a href="javascript:void(0);"  onclick="checkStatus1('<s:property value="workshopid_encrypted"/>', '<%=all_encrypted%>');" id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a> </div>
                        <div class="gap20">&nbsp;</div>
                        <div id="WaitlistedParticipants" class="waitlisted tipTip" style="width: 100px; position: relative;left:255px; display: inline;" title="This status means participant has been accepted for the workshop"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=accepted_encrypted%>"   id="statusWaitlisted">Accepted (<s:property value="acceptedParticipants"/>)</a> </div>
                        <div class="hbar" style="height:12px;margin-left:60px;width:105px;_width: 105px;margin-top: 0px;padding-top:0px;position: relative;left:200px;top:5px;">&nbsp;</div>
                        <div class="bottomarrow" style="position:relative;left:185px;top:22px;display: inline;">&nbsp;</div>
                        <div style="background-size: 40px 20px;background-position: center;width:80px;position: relative;left:80px; display: none;" class="rightarrow">&nbsp;</div>
                        <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                        <div class="toparrow" style="position:relative;left:150px;bottom:3px;  display: inline;">&nbsp;</div>
                        <div class="gap50">&nbsp;</div><div class="gap40">&nbsp;</div>
                        <div class="bottomarrow" style="position:relative;left:30px; display: none;">&nbsp;</div>
                        <div class="clear">&nbsp;</div>
                        <div id="AllParticipants" class="all tipTip" style="position: relative;left:35px;" title="Click to see all participants of all status."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&status=<%=all_encrypted%>&rcid=<%=rcid_enc%>"  id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a></div>
                        <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div id="RegisteredParticipants" class="requestregistered tipTip" style="position: relative;left:30px;" title="This status means paticipant has registered for the workshop"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=registered_encrypted%>"  id="statusRegistered">Registered (<s:property value="registeredParticipants"/>)</a></div>
                        <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div id="ApprovedParticipants" style="position: relative;left:30px;" class="requestapproved tipTip" title="This status means participant has been provisionally selected."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=approved_encrypted%>"  id="statusApproved"><!--Verified--> In Process(<s:property value="approvedParticipants"/>)</a></div>
                        <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div class="confirmed tipTip" style="width:100px;position: relative;left:35px" title="This status means participant has confirmed his/her selection and logged in to moodle."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=confirmed_encrypted%>"  id="statusConfirmed">Confirmed (<script>document.writeln(statusConfirmedjs)</script>)</a></div>
                        <div id="ConfirmedParticipants" class="clear">&nbsp;</div>
                        <div  class="vbar" style="height:40px;width:80px;_width:85px;margin-left: 10px;">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="vbar" style="height:40px;width:120px;_width:140px;position: relative;right:27px">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="vbar" style="height:40px;width:60px;_width:100px;position: relative;right:15px">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="vbar" style="height:40px;width:50px;_width:70px;margin-left: 30px;">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="hbar" style="height:12px;margin-left:60px;width:490px;_width: 450px;margin-top: 0px;padding-top:0px;">&nbsp;</div>
                        <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                        <div class="doublearrow" style="position:relative;right:20px;">&nbsp;</div>
                        <div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div>                    
                        <div style="" class="bottomarrow">&nbsp;</div>
                        <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div><div class="gap10">&nbsp;</div>
                        <div id="InvalidParticipants" class="registrationinvalid tipTip" style="width: 100px" title="This status means participant's registration is invalid. The permission letter format is wrong."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=invalid_encrypted%>" id="statusInvalid">Invalid (<s:property value="invalidParticipants"/>)</a></div>
                        <div class="gap100">&nbsp;</div>  
                        <div id="CancelledParticipants" class="cancelled tipTip" style="width: 100px" title="This status means participant has been cancelled"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=cancelled_encrypted%>"  id="statusCancelled">Cancelled (<s:property value="cancelledParticipants"/>)</a></div>
                        <div class="gap100">&nbsp;</div> 
                        <div id="CompletedParticipants" class="completed tipTip" style="width: 100px" title="This status means participant has completed the course and assignments"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=completed_encrypted%>"  id="statusCancelled">Completed (<s:property value="completedParticipants"/>)</a></div>

                        <div class="clear">&nbsp;</div><br/>
                        <div align="center" style="padding-right: 180px;color:red;font-size:12px;">Click on any status above to view list of participant of that status.</div>
                    </div>
                </s:elseif>
                <s:else>
                    <div style="margin-left: 80px;width: 740px;_margin-left:130px;padding:7px;display:inline-block;position: relative;left:150px;">
                        <div id="AllParticipants" class="all tipTip" style="width: 100px; display:none;" title="Click to see all participants of all status."><a href="javascript:void(0);"  onclick="checkStatus1('<s:property value="workshopid_encrypted"/>', '<%=all_encrypted%>');" id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a> </div>
                        <div class="gap20">&nbsp;</div>
                        <div id="WaitlistedParticipants" class="waitlisted tipTip" style="width: 100px; position: relative;left:80px; display: none;" title="This status means participant has been waitlisted for the workshop as the seating capacity of the selected remote center is full"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=waitlist_encrypted%>"   id="statusWaitlisted">Waitlisted (<s:property value="waitlistedParticipants"/>)</a> </div>
                        <div style="background-size: 40px 20px;background-position: center;width:80px;position: relative;left:80px; display: none;" class="rightarrow">&nbsp;</div>
                        <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                        <div class="toparrow" style="position:relative;right:25px;  display: none;">&nbsp;</div>
                        <div class="gap50">&nbsp;</div><div class="gap40">&nbsp;</div>
                        <div class="bottomarrow" style="position:relative;left:30px; display: none;">&nbsp;</div>
                        <div class="clear">&nbsp;</div>
                        <div id="AllParticipants" class="all tipTip" style="position: relative;left:35px;" title="Click to see all participants of all status."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&status=<%=all_encrypted%>&rcid=<%=rcid_enc%>"  id="statusAll">All (<script>document.writeln(statusAlljs)</script>)</a></div>
                        <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div id="RegisteredParticipants" class="requestregistered tipTip" style="position: relative;left:30px;" title="This status means paticipant has registered for the workshop"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=registered_encrypted%>"  id="statusRegistered">Registered (<s:property value="registeredParticipants"/>)</a></div>
                        <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div id="ApprovedParticipants" style="position: relative;left:30px;" class="requestapproved tipTip" title="This status means participant has been provisionally selected."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=approved_encrypted%>"  id="statusApproved">In Process (<s:property value="approvedParticipants"/>)</a></div>
                        <div class="rightarrow" style="position: relative;left:35px;">&nbsp;</div>
                        <div class="confirmed tipTip" style="width:100px;position: relative;left:35px" title="This status means participant has confirmed his/her selection and logged in to moodle."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=confirmed_encrypted%>"  id="statusConfirmed">Confirmed (<script>document.writeln(statusConfirmedjs)</script>)</a></div>
                        <div id="ConfirmedParticipants" class="clear">&nbsp;</div>
                        <div  class="vbar" style="height:40px;width:80px;_width:85px;margin-left: 10px;">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="vbar" style="height:40px;width:120px;_width:140px;position: relative;right:27px">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="vbar" style="height:40px;width:60px;_width:100px;position: relative;right:15px">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="vbar" style="height:40px;width:50px;_width:70px;margin-left: 30px;">&nbsp;</div><div class="blank">&nbsp;</div>
                        <div class="hbar" style="height:12px;margin-left:60px;width:490px;_width: 450px;margin-top: 0px;padding-top:0px;">&nbsp;</div>
                        <div class="clear">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div> <div class="gap10">&nbsp;</div>
                        <div class="doublearrow" style="position:relative;right:20px;">&nbsp;</div>
                        <div class="gap100">&nbsp;</div> <div class="gap50">&nbsp;</div>                    
                        <div style="" class="bottomarrow">&nbsp;</div>
                        <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div> <div class="gap100">&nbsp;</div><div class="gap100">&nbsp;</div><div class="gap10">&nbsp;</div>
                        <div id="InvalidParticipants" class="registrationinvalid tipTip" style="width: 100px" title="This status means participant's registration is invalid. The permission letter format is wrong."><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=invalid_encrypted%>" id="statusInvalid">Invalid (<s:property value="invalidParticipants"/>)</a></div>
                        <div class="gap100">&nbsp;</div>  
                        <div id="CancelledParticipants" class="cancelled tipTip" style="width: 100px" title="This status means participant has been cancelled"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=cancelled_encrypted%>"  id="statusCancelled">Cancelled (<s:property value="cancelledParticipants"/>)</a></div>
                        <div class="gap100">&nbsp;</div> 
                        <div id="CompletedParticipants" class="completed tipTip" style="width: 100px" title="This status means participant has completed the course and assignments"><a href="participantDetails.html?update=<%=update_enc%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_enc%>&status=<%=completed_encrypted%>"  id="statusCancelled">Completed (<s:property value="completedParticipants"/>)</a></div>

                        <div class="clear">&nbsp;</div><br/>
                        <div align="center" style="padding-right: 180px;color:red;font-size:12px;">Click on any status above to view list of participant of that status.</div>
                    </div></s:else>
                <% }%>
            </s:iterator>
            <%--
                encry_workshopid = (String) request.getAttribute("workshopid_encrypted");
                encry_workshopid = cipher.decrypt(encry_workshopid);
            --%>
        </s:iterator>
    </div>


    <!--    <table class="content_container"><tr><td><h4 style="color: #003366;width:900px;text-align: center;position: relative;left:50px;"><b>List of Selected Participants</b></h4></td></tr>
        </table>-->
    <!--<br/><h3 class="adminh3">List of Participants</h3><br/>-->
    <%-- <input type="button" value="Reload Page" onClick="window.location.reload()" style="float: right; margin-right: 60px; font-weight: bold;"><br><br> --%>
    <div style="position: relative;left:150px;">
        <br/>
        <p style="font-weight: bold;font-size: 120%;position: relative;left:200px;">Check or Un-check boxes to view/hide fields</p>
        <p style="font-weight: bold;font-size: 120%">
            <s:iterator value="workshopContent">                
                <input type="checkbox" id="desgination_check" onclick="checkDesignationBox(<s:property value="categorycode"/>);"> Designation &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" id="experience_check" onclick="checkExperienceBox(<s:property value="categorycode"/>);"> Experience &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" id="qualification_check" onclick="checkQualificationBox(<s:property value="categorycode"/>);"> Qualification &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" id="regtime_check" onclick="checkRegtimeBox(<s:property value="categorycode"/>);"> Registration Date &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" id="stream_check" onclick="checkStreamBox(<s:property value="categorycode"/>);"> Stream &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" id="participantid_check" onclick="changeDisplays(1);"> Participant Id</p>
            </s:iterator>
        <br/>
    </div>
    <div style="width: auto; overflow-x: scroll; height: auto;">
        <table class="display1" id="participantDetail1" style="word-spacing: normal;text-wrap: avoid;">
            <thead id = "headers" > 
                <tr>
                    <th>S.No</th>
                    <th style="display: none;">P ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>RC ID</th>
                    <th>Remote Center Name</th>
                        <s:iterator value="workshopContent">
                            <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
                            <th>Institute Name</th>
                            </s:if>
                        </s:iterator>
                    <th >State</th>
                    <th>Mobile Number</th>

                    <th  style="display: none;">Designation</th>
                    <th  style="display: none;">Qual</th>
                    <th  style="display: none;">Exp</th>
                    <th  style="display: none;">Reg Date</th>
                    <th  style="display: none;">Stream</th>

                    <th>Acco</th>
                    <th>ID</th>
                    <th>Letter</th>
                    <th>Status</th>
                        <s:iterator value="workshopContent">
                            <s:if test="%{categorycode == 8}">
                                <% if (update.equals("status")) {%>
                            <th>Eligible for Certificate</th>
                                <% }%>
                            </s:if>
                        </s:iterator>
                        <% if (update.equals("status") || update.equals("updateReg")) {%>
                        <s:if test='%{#session.loggedInUser.roleId != 2}'>
                        <th>Update</th></s:if>
                        <%}%>
                        <% if (update.equals("viewattendance")) {%>
                        <s:if test='%{#session.loggedInUser.roleId != 2}'>
                        <th>Attendance</th></s:if>
                        <% }%>
                        <s:iterator value="workshopContent">
                            <s:if test="%{categorycode == 8}">
                            <th>Payment Details</th>
                                <% if (update.equals("updateReg")) {%>
                            <th>Eligible for Certificate</th>
                                <% }%>
                            </s:if>
                        </s:iterator>
                </tr>
            </thead>
            <tbody align="center" id="participantDetailsBody1" >
                <s:iterator value="participantdetails" status="itStatus">
                    <tr class="gradeU">
                        <td style="align:right" id="sno_<s:property value="#itStatus.count" />"><s:property value="#itStatus.count" /></td>

                        <td id="pid_<s:property value="#itStatus.count" />" style="display: none;"><s:property value="registrationDetails.participantid" /></td>

                        <td id="name_<s:property value="#itStatus.count" />"><s:property value="firstName" /> <s:property value="lastName" /></td>
                        <td id="email_<s:property value="#itStatus.count" />"><s:property value="email" /></td>
                        <td id="remotecenterId_<s:property value="#itStatus.count" />"><s:property value="remoteCenter.remoteCenterId"/></td>
                        <td id="remotecenterName_<s:property value="#itStatus.count" />"><s:property value="remoteCenter.remoteCenterName"/></td>
                        <s:iterator value="workshopContent">
                            <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
                                <td id="instituteName_<s:property value="#itStatus.count" />"><s:if test="institute.instituteName.length() > 0"><s:property value="institute.instituteName"/></s:if><s:else>NA</s:else></td>
                            </s:if>
                        </s:iterator>                     
                        <td id="remotecenterState_<s:property value="#itStatus.count" />"><s:property value="remoteCenter.rc_state" /></td>
                        <%--<td id="regtime"><s:property value="registrationDetails.regtime" /></td>--%>
                        <td id="mobile_<s:property value="#itStatus.count" />"><s:property value="mobileNumber" /></td>

                        <td id="designation_<s:property value="#itStatus.count" />" style="display: none;"><s:if test="designation.designationName.length() > 0"><s:property value="designation.designationName" /></s:if><s:else>NA</s:else></td>
                        <td id="qualification_<s:property value="#itStatus.count" />" style="display: none;"><s:property value="qualification.qualification" /></td>
                        <td id="experience_<s:property value="#itStatus.count" />" style="display: none;"><s:if test="experience.length() > 0"><s:property value="experience" /></s:if><s:else>NA</s:else></td>
                        <td id="regtime_<s:property value="#itStatus.count" />" style="display: none;"><s:property value="registrationDetails.regtime" /></td>
                        <td id="stream_<s:property value="#itStatus.count" />" style="display: none;"><s:property value="stream.streamName" /></td>


                        <td id="aaommodation_<s:property value="#itStatus.tegory ount" />"><s:property value="registrationDetails.accomodation" /></td>
                        <td id="id_<s:property value="#itStatus.count" />"><s:iterator value="workshopContent"><s:if test="%{categorycode == 8}"><s:if test='%{facultyStatus.equals("0")}'>NA</s:if><s:else><a href="UserImages/<s:property value="image" />" target="_blank">ID</a></s:else></s:if><s:else><a href="UserImages/<s:property value="image" />" target="_blank">ID</a></s:else></s:iterator></td> 
                        <td id="letter_<s:property value="#itStatus.count" />"><s:iterator value="workshopContent"><s:if test="%{categorycode == 8}"><s:if test="%{registrationDetails.letter == ''}">NA</s:if><s:else><a href="Permission_Letter/<s:property value="registrationDetails.letter" />" target="_blank">letter</a></s:else></s:if><s:else><a href="Permission_Letter/<s:property value="registrationDetails.letter" />" target="_blank">letter</a></s:else></s:iterator></td>
                        <td id="<s:property value="#itStatus.count"/>"><s:if test='%{ (registrationDetails.status.equals("Registration Invalid") || registrationDetails.status.equals("Cancelled")) &&  (#session.loggedInUser.roleId == 5 || #session.loggedInUser.roleId == 3)}'><p onclick="showReasons('${registrationDetails.participantid}', 'Registration Invalid');">${registrationDetails.status}</p></s:if><s:else><s:property value="registrationDetails.status" /></s:else></td>
                            <s:iterator value="workshopContent">
                                <s:if test="%{categorycode == 8}">
                                    <% if (update.equals("status")) {%>
                                <td id="isfaculty_<s:property value="#itStatus.count"/>"><s:if test='%{registrationDetails.isEligibleForCertificate.equals("yes")}'><s:if test='%{(registrationDetails.status.equals("Confirmed")) || (registrationDetails.status.equals("Completed")) || (registrationDetails.status.equals("Request Approved"))}'><input type="checkbox" name="faculty_<s:property value="#itStatus.count"/>" id="faculty_<s:property value="#itStatus.count"/>" checked="true" disabled="true"></s:if><s:else><input type="checkbox" name="faculty_<s:property value="#itStatus.count"/>" id="faculty_<s:property value="#itStatus.count"/>" checked="true"></s:else></s:if><s:else><s:if test='%{(registrationDetails.status.equals("Confirmed")) || (registrationDetails.status.equals("Completed")) || (registrationDetails.status.equals("Request Approved"))}'><input type="checkbox" name="faculty_<s:property value="#itStatus.count"/>" id="faculty_<s:property value="#itStatus.count"/>" disabled="true"></s:if> <s:else><input type="checkbox" name="faculty_<s:property value="#itStatus.count"/>" id="faculty_<s:property value="#itStatus.count"/>"></s:else></s:else></td>
                                    <% }%>

                            </s:if>
                        </s:iterator>
                        <% if (update.equals("status")) {%>
                        <s:if test='%{#session.loggedInUser.roleId != 2}'><s:if test="%{(registrationDetails.payment.equals('refunded') ||  registrationDetails.payment.equals('refund initiated'))}"><td>Not available for update</td></s:if><s:else>
                                <td style="position: relative; padding: 0 0 0 0;" id="update_<s:property value="#itStatus.count" />"><s:if test='%{statusMatrix.ifDisplayApproved == "Y"}'><s:iterator value="workshopContent"><s:if test="%{categorycode == 8}"><s:if test="%{(registrationDetails.payment.equals('paid') ||  registrationDetails.payment.equals('reconciled'))}"><button class="approvedButton" onclick="changeStatus(<s:property value="#itStatus.count" />,<s:property value="registrationDetails.participantid" />, 'Request Approved', '<s:property value="email" />', '<%=contextPath%>')">Approve</button></s:if></s:if><s:else><button class="approvedButton" onclick="changeStatus(<s:property value="#itStatus.count" />,<s:property value="registrationDetails.participantid" />, 'Request Approved', '<s:property value="email" />', '<%=contextPath%>')">Approve</button></s:else></s:iterator></s:if><s:if test='%{statusMatrix.ifDisplayInvalid == "Y"}'><button name="modal2" class="invalidButton" onclick="changeStatus(<s:property value="#itStatus.count" />,<s:property value="registrationDetails.participantid" />, 'Registration Invalid', '<s:property value="email" />', '<%=contextPath%>')">Invalid</button></s:if><s:if test='%{#session.loggedInUser.roleId == 5}'><s:if test='%{statusMatrix.ifDisplayConfirmed == "Y"}'><button class="confirmedButton" onclick="changeStatus(<s:property value="#itStatus.count" />,<s:property value="registrationDetails.participantid" />, 'Confirmed', '<s:property value="email" />', '<%=contextPath%>')">Confirm</button></s:if><s:if test='%{statusMatrix.ifDisplayCancelled == "Y"}'><button class="cancelledButton" onclick="confirmchangeStatus(<s:property value="#itStatus.count" />,<s:property value="registrationDetails.participantid" />, 'Cancelled', '<s:property value="email" />', '<%=contextPath%>')">Cancel</button></s:if><s:if test='%{statusMatrix.ifDisplayCompleted == "Y"}'><button class="completedButton" onclick="changeStatus(<s:property value="#itStatus.count" />,<s:property value="registrationDetails.participantid" />, 'Completed', '<s:property value="email" />', '<%=contextPath%>')">Completed</button></s:if></s:if></td></s:else></s:if>
                        <% }
                            if (update.equals("updateReg")) {%>
                        <s:if test='%{#session.loggedInUser.roleId != 2}'>
                            <td style="padding:5px 10px;" id="update_<s:property value="#itStatus.count" />">
                                <button class="approvedButton" onclick="updateReg('<s:property value="email_enc" />', '<%=workshopid_enc%>')">Update</button>
                            </td>
                        </s:if>
                        <%}%>
                        <%  if (update.equals("viewattendance")) {%>
                        <s:if test='%{#session.loggedInUser.roleId != 2}'>
                            <s:set  var="var_pa" value="%{registrationDetails.participantid}"/>
                            <s:set  var="f_name" value="%{firstName+' '+lastName}"/>
                            <s:set  var="rc_en" value="%{remoteCenter.remoteCenterId+' : '+remoteCenter.remoteCenterName}"/>
                            <% String pa_enc = (String) request.getAttribute("var_pa");
                                pa_enc = cipher.encrypt(pa_enc);
                                String name = (String) request.getAttribute("f_name");
                                String rc = (String) request.getAttribute("rc_en");
                                try {
                                    name = cipher.encrypt(name);
                                    rc = cipher.encrypt(rc);
                                } catch (Exception e) {
                                }


                            %>

                            <td style="padding:5px 10px;" id="update_<s:property value="#itStatus.count" />">
                                <button class="approvedButton" onclick="viewAttend('<s:property value="email_enc" />', '<%=workshopid_enc%>', '<%=pa_enc%>', '<%=name%>', '<%=rc%>')">view</button>
                            </td>
                        </s:if>
                        <% }%>
                        <s:iterator value="workshopContent">
                            <s:if test="%{categorycode == 8}">
                                <td style="text-align: center;" id="payment_<s:property value="#itStatus.count" />"><br/><s:if test="registrationDetails.getPayment() == 'not paid' "><p><s:property value="registrationDetails.payment" /></p></s:if><s:if test="registrationDetails.getPayment() == 'reconciled'"><p style="color: #1E90FF;"><b> received</b></p></s:if><s:if test="registrationDetails.getPayment() == 'paid'"><p style="color:green;"><s:property value="registrationDetails.payment" /></p></s:if><s:if test="registrationDetails.getPayment() == 'refund initiated'"><p style="color:blueviolet; " onclick="showReasons('${registrationDetails.participantid}', '${registrationDetails.payment}');"><s:property value="registrationDetails.payment" /> </p><s:if test='%{#session.loggedInUser.roleId == 8}'><button class="refundedButton" onclick="refund('<s:property value="registrationDetails.participantid" />', '<s:property value="workshopid" />', '<s:property value="#session.loggedInUser.loginId"/>', '<s:property value="email"/>')">Refunded??</button></s:if></s:if><s:if test="%{#session.loggedInUser.roleId == 5 && registrationDetails.status == 'Cancelled' && registrationDetails.payment == 'reconciled' }"><button class="refundButton" onclick="initiateRefund('<s:property value="registrationDetails.participantid" />', '<s:property value="workshopid" />', '<s:property value="#session.loggedInUser.loginId"/>', '<s:property value="email"/>')">Refund</button></s:if><s:if test="registrationDetails.getPayment() == 'refunded' "><p style="color:purple; " onclick="showReasons('${registrationDetails.participantid}', '${registrationDetails.payment}');"><s:property value="registrationDetails.payment" /> </p></s:if></td>
                                        <% if (update.equals("updateReg")) {%>
                                <td id="isEligibleForCertificate_<s:property value="#itStatus.count"/>"><s:if test='%{registrationDetails.isEligibleForCertificate.equals("yes")}'><input type="checkbox" name="is_eligible_certificate_<s:property value="#itStatus.count"/>" id="is_eligible_certificate_<s:property value="#itStatus.count"/>" checked="true" onclick="updateCertificateStatus('<s:property value="registrationDetails.participantid" />', '<s:property value="#itStatus.count"/>', '<s:property value="email" />')"></s:if> <s:else><input type="checkbox" name="is_eligible_certificate_<s:property value="#itStatus.count"/>" id="is_eligible_certificate_<s:property value="#itStatus.count"/>" onclick="updateCertificateStatus('<s:property value="registrationDetails.participantid" />', '<s:property value="#itStatus.count"/>', '<s:property value="email" />')"> </s:else> <p id="saveStatus_<s:property value="#itStatus.count"/>" style="display: none;" value=""></p></td>
                                    <%}%>    

                            </s:if>
                        </s:iterator>
                    </tr> 
                </s:iterator> 
            </tbody>  
        </table>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#participantDetail1').dataTable({
                // "scrollX": true,                             "iDisplayLength": 25,
                "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]]
            });
        });
    </script>
</s:if>
<script>
    $('.window .close').click(function(e) {
        e.preventDefault();
        $('#mask, .window').hide();
    });

    $('#mask').click(function() {
        $(this).hide();
        $('.window').hide();
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
<script>
    document.getElementById("desgination_check").checked = false;
    document.getElementById("experience_check").checked = false;
    document.getElementById("qualification_check").checked = false;
    document.getElementById("regtime_check").checked = false;
    document.getElementById("stream_check").checked = false;
    document.getElementById("participantid_check").checked = false;
</script>
</body>