<%-- 
    Document   : home
    Created on : 26 Jun, 2014, 8:35:38 PM
    Author     : Abinaya
--%>

<%@page import="org.project.bean.Person"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.process.UserProcess"%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags"%>
<!DOCTYPE html>
<%
    SimpleStringCipher cipher = new SimpleStringCipher();
    String status = cipher.encrypt("status");
    String details = cipher.encrypt("details");
    String view = cipher.encrypt("view");
    String updateReg = cipher.encrypt("updateReg");
    String auto_link = cipher.encrypt("auto_link");
    String certificate = cipher.encrypt("certificate");
    String attendance = cipher.encrypt("attendance");
    String attendance1 = cipher.encrypt("attendance1");
    String all = cipher.encrypt("all");
    String viewattendance = cipher.encrypt("viewattendance");
    String paymentdetails = cipher.encrypt("paymentdetails");
    String none = cipher.encrypt("none");
%>
<html>
    <head>
        <script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <script>

            function changeText(imageid, displayid) {
                var srcTest = document.getElementById(imageid).src;
                if (srcTest.indexOf("plus_button.png") > -1) {
                    document.getElementById(displayid).style.display = "block";
                    document.getElementById(imageid).src = "images/minus_button.png";
                } else {
                    document.getElementById(displayid).style.display = "none";
                    document.getElementById(imageid).src = "images/plus_button.png";
                }
            }

            function initiate_refund(participantid, workshopid, updatedBy, email, workshopName) {
                //alert('here ' +pid + " dsf d"+wid + " dzf "+lid + "df sf "+email + " sds "+wname);

                var refund_type = "initiate";
                var reasons = "self withdrawal from FDP and claimed refund";
                initiateRefundOfParticipant(participantid, workshopid, reasons, updatedBy, email, workshopName, refund_type);
            }
            function showReasons(participantid, status) {
                showReasons1(participantid, status);
            }
        </script>
    </head>
    <body>
        <s:if test="hasActionErrors()">
            <div class="msg msg-ok">
                <s:actionerror/>
                <a href="javascript:void(0);" class="close">close</a>
            </div>
        </s:if>
        <s:if test="#session.loggedInUser == null">
            <div class="form_settings">
                <div class="form_box"> <br/> 
                    
                    <p><img  src="images/triangle_animated.gif"><a style=""  href="signup.html"><b>Sign Up </b></a><img src="images/triangle_animated.gif"></p>
                    <!--<p><img  src="images/triangle_animated.gif"><a style=""  href="accessaccount.html?tmp=ARlink"><b>Sign up for Already Registered User</b></a><img src="images/triangle_animated.gif"> (If you have registered for any past workshops of 'Project Name' )</p>-->
                    <p><img  src="images/triangle_animated.gif"><a style=""  href="login.html"><b>Login</b></a><img src="images/triangle_animated.gif"> (If you have already signed up.)</p>
                    <!--<p><img  src="images/triangle_animated.gif"><a style=""  href="announcements.html"><b>Click here for FDP registration</b></a><img src="images/triangle_animated.gif"></p>-->
                    <br>
                </div>
            </div>
        </s:if>        
        <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId >= 1}'>
            <s:if test='#session.loggedInUser.facultyStatus =="1"'>
                <s:if test='#session.loggedInUser.image == ""'>
                    <p style="color: red"><img src="images/triangle_animated.gif"> Please update your photo identity card in the Edit Profile Page <a href="updateProfile.html"/>(Click Here)</a><img src="images/triangle_animated.gif"></p>
                    </s:if></s:if>
                <s:if test='%{!dashboard.isEmpty()}'>
            <div class="form_box">
                <br/>
                <p align="center"><b style="color: #474686;">Workshops Attended</b><img id="imgshow4" style="display:none;" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow4', 'dashboard1');"></p>  
                <div id="dashboard1" style="display:inline;">
                    <table class="content_container">
                        <tr style="color: #474686;"><td><b>S No</b></td>
                            <td><b>Workshop Name</b></td>
                            <td><b>Date</b></td>
                            <td><b>Schedule</b></td>
                            <td><b>Status</b></td>
                            <%-- <s:iterator value="dashboard" status="itcount">
                                 <s:if test='%{workshops.categorycode == 7}'>
                                     <s:if test='%{#itcount.count <= 1}'>--%>
                            <%--<td><b>Payment Status</b></td>
                            <td><b>Amount (Rs.)</b></td>--%>
                            <td><b>More Details</b><%--<b>Transaction Details</b>--%></td>
                            <%--        </s:if>
                                </s:if>
                            </s:iterator>--%>
                        </tr>

                        <s:iterator value="dashboard" status="itStatus">
                            <%--<p><s:property value="workshops.workshopExpiry"/> <s:property value="registrationDetails.payment"/></p>--%>
                            <tr>
                                <td><s:property value="#itStatus.count" /></td>
                                <td><s:property value="workshops.workshopname"/></td>
                                <td style="white-space: nowrap;">
                                    <s:if test="workshops.dateToBeDisplayed == 1">
                                        <s:property value="workshops.startdate"/>
                                    </s:if><s:else>NA</s:else>
                                    </td>
                                    <td>
                                    <s:if test="workshops.dateToBeDisplayed == 1">
                                        <a href="${schedule_url}">Click Here</a>
                                    </s:if><s:else>NA</s:else>
                                    </td>
                                <s:if test='%{workshops.categorycode == 8}'>
                                    <%
                                        int checkFeePaid = 0, checkDetailsAvail = 0;
                                        try {
                                            String pid = (String) request.getAttribute("registrationDetails.participantid");
                                            UtilityProcess uprocess = new UtilityProcess();
                                            checkFeePaid = uprocess.check_paymentAlreadyMade(pid);
                                            checkDetailsAvail = uprocess.check_paymentDetailsExist(pid);
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    %>
                                    <%
                                        Date date = new Date();
                                        String modifiedDate = new SimpleDateFormat("yyyy-MM-dd").format(date);
                                        String orgnldate = (String) request.getAttribute("registrationDetails.checksDate");
                                        String ssdate = "";
                                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                        Date convertedCurrentDate = sdf.parse("2016-01-01");
                                        String payWorkshopStart = sdf.format(convertedCurrentDate);
                                        try {
                                            ssdate = (String) request.getAttribute("workshops.startdatereg");
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    %>
                                    <td>
                                        <s:set var="currdate"><%=modifiedDate%></s:set>
                                        <s:if test='%{workshops.categorycode == 8 && workshops.payment_at_rc == 1 && registrationDetails.status.equals("Request Approved")}'><p style="white-space: pre-wrap;font-size: 80%;">Verified. Please Contact Remote Center Coordinator (<emp style="color:blue;"><s:property value="registrationDetails.rcc_email"/></emp>) for Payment Details.</p></s:if> <s:property value="registrationDetails.status"/>
                                & <% if (checkFeePaid != 1) {%><% if (ssdate.compareTo(payWorkshopStart) >= 0) {%><s:if test='%{registrationDetails.payment.equals("reconciled")}'>received</s:if><s:else><s:property value="registrationDetails.payment"/></s:else><% } else { %>NA<% } %> <s:if test='%{registrationDetails.payment.equals("not paid")}'><% if (modifiedDate.compareTo(orgnldate) > 0) {%> <% } else {%><br><a style="text-decoration: none;" href="processPayment?appid=10113&pid=<s:property value="registrationDetails.participantid"/>&amt=<s:property value="paymentgateway.totalAmt"/>&name=<s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>&workshopid=<s:property value="workshops.workshopid"/>&msg=Payment for <s:property value="workshops.workshopname"/>"><input style="background: #1c9212; color: white; width: 80px; height: 25px; border-radius: 5px; font-size: 14px; border-color: #1c9212;" type="button" value="Pay Now"/></a><% }%></s:if><% } else {%>paid<% }%>
                                <s:if test='%{registrationDetails.payment.equals("reconciled") && workshops.workshopExpiry == 0 && workshops.withdrawal_flag == 1}'><button style="background-color: #ffb499;" onclick="initiate_refund('<s:property value="registrationDetails.participantid"/>', '<s:property value="workshops.workshopid"/>', '<s:property value="person.loginId"/>', '<s:property value="person.loginName"/>', '<s:property value="workshops.workshopname"/>');" title="Click here to withdraw from fdp and claim refund">Withdraw</button></s:if>
                                    </td>
                                    <td><s:if test='%{workshops.categorycode == 8}'><% if (ssdate.compareTo(payWorkshopStart) >= 0) {%><% if (checkDetailsAvail > 0) {%><a href="showPaymentDetails.html?workshopid=<s:property value="workshops.workshopid"/>&pid=<s:property value="registrationDetails.participantid"/>">Click here</a><% }%><% } else { %>NA<% }%></s:if></td>
                            </s:if><s:else>
                                <td style="white-space: pre-wrap;"><s:if test='%{workshops.categorycode == 7 && registrationDetails.status.equals("Request Approved")}'><p style="white-space: pre-wrap;font-size: 80%;">Verified. Please Contact Remote Center Coordinator (<emp style="color:blue;"><s:property value="registrationDetails.rcc_email"/></emp>) for Payment Details.</p></s:if><s:else><s:property value="registrationDetails.status"/></s:else></td>
                                    <td>NA</td>
                            </s:else>
                            </tr>   
                        </s:iterator>                    
                    </table>
                </div>
            </div>   
        </s:if>   
        <s:if test='%{!refund_claims.isEmpty()}'>
            <div class="form_box">
                <br/>
                <p align="center"><b style="color: #474686;">Refund Claims</b><img id="imgshow9" style="display:none;" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow9', 'refund_claims1');"></p>  
                <div id="refund_claims1" style="display:inline;">
                    <table class="content_container">
                        <tr style="color: #474686;">
                            <td><b>S No</b></td>
                            <td><b>Workshop Name</b></td>
                            <td><b>Date</b></td>                            
                            <td><b>Status</b></td>                            
                            <td><b>More Details</b></td>                            
                        </tr>
                        <s:iterator value="refund_claims" status="itStatus">
                            <tr>
                                <td><s:property value="#itStatus.count" /></td>
                                <td><s:property value="workshops.workshopname"/></td>
                                <td style="white-space: nowrap;"><s:if test="workshops.dateToBeDisplayed == 1"><s:property value="workshops.startdate"/></s:if><s:else>NA</s:else></td>                                    
                                <td><s:property value="registrationDetails.status"/></td>
                                <td><br/><p style="color:blueviolet; " onclick="showReasons('${registrationDetails.participantid}', '${registrationDetails.payment}');"><s:property value="registrationDetails.payment"/></p></td>                              
                            </tr>   
                        </s:iterator>                    
                    </table>
                </div>
            </div>   
        </s:if>   
        <s:if test="%{!wc.isEmpty()}">
            <div class="form_box" style="display:inline;">
                <p align="center"><b>Workshop Coordinator's Interface</b></p>  
                <br/>
                <p align=""><b style="color: #474686;">Manage Attendance and View Workshop Schedule</b> <img id="imgshow5" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow5', 'attendance1');"></p>  
                <div id="attendance1" style="display:inline;">
                    <table class="content_container">
                        <tr style="color: #474686;"><td><b>S No</b></td>
                            <td><b>Workshop Name</b></td>
                            <td><b>Date</b></td>
                            <td><b>Schedule</b></td>
                            <td><b>Attendance</b></td>  
                            <s:iterator value="wc" status="itStatus">
                            <tr>
                                <td><s:property value="#itStatus.count" /></td>
                                <td><s:property value="workshopname"/></td>
                                <td style="white-space: nowrap;"><s:property value="startdate"/></td>
                                <td><a target="_blank" href="viewProgramSchedule.html?workshopid=<s:property value="workshopid_encrypted"/>">Click Here</a></td>
                                <td><s:if test='%{ifCanDisplayWCCDashboard == 1}'> <a target="_blank" href="viewAttendanceOfParticipants.html?workshopid=<s:property value="workshopid_encrypted"/>&rcid=<s:property value="rcid_enc_wsc"/>&date=<%=none%>">Details</a></s:if><s:else>Will be available soon</s:else></td>                               
                                </tr>   
                        </s:iterator>                    
                    </table>
                </div>
            </div>   
        </s:if>
        <s:if test="%{!wc2.isEmpty()}">
            <div class="form_box">
                <p align="center"><b>Remote Center Coordinator's Interface</b>  </p>  
                <br/>
                <p align=""><b style="color: #474686;">Manage Remote Center Capacity</b><img id="imgshow7" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow7', 'managercc1');"></p>  
                <div id="managercc1" style="display:none;">
                    <table class="content_container">
                        <tr style="color: #474686;"><td><b>S No</b></td>
                            <td><b>Workshop Name</b></td>
                            <td><b>Date</b></td>
                            <td><b>Details</b></td>                            
                            <s:iterator value="wc3" status="itStatus">
                            <tr>
                                <td><s:property value="#itStatus.count"/></td>
                                <td><s:property value="workshopname"/></td>
                                <td style="white-space: nowrap;"><s:property value="startdate"/></td>
                                <td><a href="<s:property value="rccUrl"/>">Manage</a></td>                                
                            </tr>                   
                        </s:iterator>                    
                    </table>
                </div>                    
                <s:if test="%{if_atleast_one_cc7 > 0}">
                    <p align=""><b style="color: #474686;display:inline;">Manage Participants</b> <img id="imgshow6" style="display:inline;" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow6', 'managepart1');"></p>  
                    <div id="managepart1" style="display: none;">
                        <table class="content_container">
                            <tr style="color: #474686;"><td><b>S No</b></td>
                                <td><b>Workshop Name</b></td>
                                <td><b>Date</b></td>                                    
                                <td><b>Details</b></td>    
                                <% int count = 0;%>
                                <s:iterator value="wc2" status="itStatus">                                    
                                    <s:if test="%{categorycode == 7}">
                                        <% count++;%>
                                        <s:set var="count1"><%=count%></s:set>                               
                                        <tr>
                                            <td><s:property value="#count1"/></td>
                                        <td><s:property value="workshopname"/></td>
                                        <td style="white-space: nowrap;"><s:property value="startdate"/> to <s:property value="enddate"/></td>
                                        <td>
                                            <s:if test="workshopCompleted == 1">NA</s:if>
                                            <s:else>
                                                <a target="_blank" href="manageParticipantsRCC.html?workshopid=<s:property value="workshopid_encrypted"/>&rcid=<s:property value="rcid_enc"/>">Manage</a>
                                            </s:else>
                                        </td>
                                    </tr> 
                                </s:if>
                                <s:if test='%{categorycode == 8 && payment_at_rc == 1}'>
                                    <% count++;%>
                                    <s:set var="count1"><%=count%></s:set>                               
                                        <tr>
                                            <td><s:property value="#count1"/></td>
                                        <td><s:property value="workshopname"/></td>
                                        <td style="white-space: nowrap;"><s:property value="startdate"/> to <s:property value="enddate"/></td>
                                        <td>
                                            <s:if test="workshopCompleted == 1">NA</s:if>
                                            <s:else>
                                                <a target="_blank" href="manageParticipantsRCC.html?workshopid=<s:property value="workshopid_encrypted"/>&rcid=<s:property value="rcid_enc"/>">Manage</a>
                                            </s:else>
                                        </td>
                                    </tr> 
                                </s:if>    
                            </s:iterator>                    
                        </table>
                    </div>
                </s:if>                
                <p align=""><b style="color: #474686;display:inline;">View Participants' Details, Workshop Schedule and Attendance Details</b><img id="imgshow8" style="display:inline;" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow8', 'viewpart1');"></p>  
                <div id="viewpart1" style="display:none;">
                    <table class="content_container">
                        <tr style="color: #474686;"><td><b>S No</b></td>
                            <td><b>Workshop Name</b></td>
                            <td><b>Date</b></td>
                            <td><b>Schedule</b></td>
                            <td style="padding-right: 0px;"><b>Participant Details</b></td>  
                            <td style="padding-right: 0px;"><b>Attendance Details</b></td>  
                            <% int count2 = 0;%>
                            <s:iterator value="wc1_rcc" status="itStatus">                                   
                                <s:if test="%{(categorycode == 5 || categorycode == 7 || categorycode == 8  ) && workshopExpiry == 1}">
                                    <% count2++;%>
                                    <s:set var="count3"><%=count2%></s:set>   
                                    <tr>
                                        <td><s:property value="#count3"/></td>
                                    <td><s:property value="workshopname"/></td>
                                    <td style="white-space: nowrap;"><s:property value="startdate"/></td>
                                    <td><a target="_blank" href="viewProgramSchedule.html?workshopid=<s:property value="workshopid_encrypted"/>">Click Here</a></td>
                                    <td style="padding-right: 0px;"><a target="_blank" href="participantListRCC.html?workshopid=<s:property value="workshopid_encrypted"/>&rcid=<s:property value="rcid_enc"/>&status=<%=all%>&callFrom=2">View</a></td>                                
                                    <td style="padding-right: 0px;"><s:if test='%{ifCanDisplayWCCDashboard == 1}'> <a target="_blank" href="viewAttendanceOfParticipantsRCC.html?workshopid=<s:property value="workshopid_encrypted"/>&rcid=<s:property value="rcid_enc"/>&date=<%=none%>">Details</a></s:if><s:else>Will be available soon</s:else></td>                               
                                    </tr> 
                            </s:if>
                        </s:iterator>                    
                    </table>
                </div>
            </div>   
        </s:if>
    </s:if> 
    <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId != 1 && #session.loggedInUser.roleId <= 1000}'>
        <div class="form_box">
            <br/>
            <p align="center"><b>Administrator Interface</b>  </p>      

            <p><b style="color: #474686;">Programme Administration</b> <img id="imgshow1" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow1', 'programmeadmin');"></p> 
            <div id="programmeadmin" style="display: none;">
                <table class="content_container" >
                    <s:if test='%{#session.loggedInUser.roleId == 6}'>
                        <!--<tr id=""><td>Auto Confirm Registered Participants &nbsp;&nbsp;&nbsp; <a href="workshopsIndex.html?update=<%=auto_link%>" style="">Click Here</a></td></tr>-->

                        <tr id=""><td>Create New Attendance Entry for Participant &nbsp;&nbsp;&nbsp; <a href="createAttendanceNewParticipant.html" style="">Click Here</a></td></tr>

                    </s:if>
                    <s:if test='%{#session.loggedInUser.roleId == 5}'>
                        <tr id=""><td>Manage  Workshops&nbsp;&nbsp;&nbsp;<a href="manageWorkshops.html" style="">Click Here</a></td></tr>
                        <tr id=""><td>Manage Announcements&nbsp;&nbsp;&nbsp;   <a href="manageAnnouncements.html" style="">Click Here</a></td></tr>
                        <tr id=""><td>Nominated WSC&nbsp;&nbsp;&nbsp;   <a href="nominatedWSC.html" style="" target="_blank">Click Here</a></td></tr>
                        <tr id=""><td>Workshop list with special remarks&nbsp;&nbsp;&nbsp;<a href="workshopremark.html?status=view" style="">Click Here</a></td></tr>
                    </s:if>
                    <s:if test='%{ (#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 5) }'>
                        <tr id=""><td>Update Status of Participants&nbsp;&nbsp;&nbsp;  <a href="workshopsIndex.html?update=<%=status%>" style="">Click Here</a></td></tr>
                        <tr id=""><td>Manage Certificates&nbsp;&nbsp;&nbsp;<a href="workshopsIndex.html?update=<%=certificate%>" style="">Click Here</a></td></tr>
                    </s:if>
                    <s:if test='%{ (#session.loggedInUser.roleId == 6) || (#session.loggedInUser.roleId == 5) }'>
                        <tr id=""><td>Certificate Audit &nbsp;&nbsp;&nbsp; <a href="certificateAudit.html" style="" target="_blank">Click Here</a></td></tr>
                    </s:if>
                    <s:if test='%{ (#session.loggedInUser.roleId == 4) || (#session.loggedInUser.roleId == 5) }'>
                        <tr id=""><td>Update Registration of Participants&nbsp;&nbsp;&nbsp;  <a href="workshopsIndex.html?update=<%=updateReg%>" style="">Click Here</a></td></tr>
                    </s:if>
                    <s:if test='%{ (#session.loggedInUser.roleId == 4) || (#session.loggedInUser.roleId == 5) }'>
                        <%-- <tr><td>Update Details of Participants &nbsp;&nbsp;&nbsp; <a href="workshopsIndex.html?update=<%=details%>">Click Here</a></td></tr>
                        --%> </s:if>

                    <s:if test='%{(#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 5)}'>
                        <s:if test='%{(#session.loggedInUser.roleId == 3)}'>
                            <tr id=""><td>View Remote Center Capacity  &nbsp;&nbsp;&nbsp; <a href="manageRCCapacity.html?workshopid=none&state=0" style="">Click Here</a></td></tr>
                        </s:if><s:else>
                            <tr id=""><td>Manage Remote Center Capacity  &nbsp;&nbsp;&nbsp; <a href="manageRCCapacity.html?workshopid=none&state=0" style="">Click Here</a></td></tr>
                        </s:else>
                    </s:if>
                    <s:if test='%{ (#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 5) }'>
                        <s:if test='%{(#session.loggedInUser.roleId == 3)}'>
                            <tr id=""><td>View Schedule &nbsp;&nbsp;&nbsp;  <a href="workshopsIndex.html?update=<%=attendance%>" style="">Click Here</a></td></tr>
                        </s:if><s:else>
                            <tr id=""><td>Manage Schedule &nbsp;&nbsp;&nbsp;  <a href="workshopsIndex.html?update=<%=attendance%>" style="">Click Here</a></td></tr>
                        </s:else>
                        <tr id=""><td>Manage Attendance &nbsp;&nbsp;&nbsp;  <a href="workshopsIndex.html?update=<%=attendance1%>" style="">Click Here</a></td></tr>
                        <s:if test='%{ (#session.loggedInUser.roleId == 5) }'>
                            <%--<tr id=""><td>View Attendance &nbsp;&nbsp;&nbsp;  <a href="workshopsIndex.html?update=<%=viewattendance%>" style="">Click Here</a></td></tr>--%> 
                        </s:if>
                        <tr id=""><td>View Uploaded Attendance &nbsp;&nbsp;&nbsp;  <a href="viewUploadedAttendance.html" style="">Click Here</a></td></tr>
                        <!--<tr id=""><td>View Certificate Details&nbsp;&nbsp;&nbsp;<a href="workshopsIndex.html?update=<%=certificate%>" style="">Click Here</a></td></tr>-->
                    </s:if>
                    <tr><td>View Participant Details&nbsp;&nbsp;&nbsp;<a href="viewWorkshopsIndex.html?update=<%=view%>" style="">Click Here</a></td></tr>
                    <s:if test='%{#session.loggedInUser.roleId == 8}'>
                        <tr id=""><td>Payment Details &nbsp;&nbsp;&nbsp; <a href="displayPayIndex.html?update=<%= paymentdetails%>" style="">Click Here</a></td></tr>
                    </s:if>
                </table>
            </div>

            <s:if test='%{(#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 5) || (#session.loggedInUser.roleId == 6)}'>
                <p><b style="color: #474686;">Website Administration</b> <img id="imgshow2" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow2', 'websiteadmin');"></p>
                </s:if>
            <div id="websiteadmin" style="display: none;">
                <table class="content_container" >
                    <s:if test='%{(#session.loggedInUser.roleId == 6) || (#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 5)}'>
                        <s:if test='%{(#session.loggedInUser.roleId == 3)}'>
                            <tr id=""><td>View Remote Centers  &nbsp;&nbsp;&nbsp; <a href="viewRC.html?rcid=<%=all%>" style="">Click Here</a></td></tr>
                        </s:if><s:else>
                            <tr id=""><td>Manage Remote Centers  &nbsp;&nbsp;&nbsp; <a href="viewRC.html?rcid=<%=all%>" style="">Click Here</a></td></tr>
                        </s:else>
                    </s:if>
                    <s:if test='%{#session.loggedInUser.roleId == 5}'>
                        <tr id=""><td>Update User Role&nbsp;&nbsp;&nbsp; <a href="userTypeUpdate.html" style="">Click Here</a></td></tr>
                        <tr id=""><td>Manage Configuration Tables <a href="viewConfigTables.html" style="">Click Here</a></td></tr>
                        <tr id=""><td>Manage Cities &nbsp;&nbsp;&nbsp; <a href="viewCity.html" style="">Click Here</a></td></tr>
                        <tr id=""><td>Change Page Content &nbsp;&nbsp;&nbsp;<a href="changePageContent.html" style="">Click here</a></td></tr>
                        <tr id=""><td>Change Mail Content &nbsp;&nbsp;&nbsp;<a href="changeMailContent.html" style="">Click here</a></td></tr>
                    </s:if>
                    <s:if test='%{(#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 6) || (#session.loggedInUser.roleId == 5)}'>
                        <s:if test='%{(#session.loggedInUser.roleId == 3)}'>
                            <tr id=""><td>View Institute and Head of the Institute &nbsp;&nbsp;&nbsp; <a href="viewInstitute.html?rcid=<%=all%>" style="">Click Here</a></td></tr>
                        </s:if><s:else>
                            <tr id=""><td>Manage Institute and Head of the Institute &nbsp;&nbsp;&nbsp; <a href="viewInstitute.html?rcid=<%=all%>" style="">Click Here</a></td></tr>
                        </s:else>                     
                    </s:if> 
                    <s:if test='%{(#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 5)}'>
                        <%-- <tr id=""><td>Change Page Content &nbsp;&nbsp;&nbsp;<a href="changePageContent.html" style="">Click here</a></td></tr>--%>
                    </s:if>    
                    <s:if test='%{(#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 5)}'>
                        <%-- <tr id=""><td>Change Mail Content &nbsp;&nbsp;&nbsp;<a href="changeMailContent.html" style="">Click here</a></td></tr> --%>
                        <tr id=""><td>Invite Users for Registration &nbsp;&nbsp;&nbsp;<a href="readexdata.html" style="" target="_blank">Click here</a></td></tr>
                        <tr id=""><td>Participants Invited But not Registered &nbsp;&nbsp;&nbsp;<a href="invitenotreg.html" style="" target="_blank">Click here</a></td></tr>
                        <tr id=""><td>Signed Up But Not Registered in Any Workshop &nbsp;&nbsp;&nbsp;<a href="loginNotReg.html" style="" target="_blank">Click here</a></td></tr>
                        <%-- <tr id=""><td>Send Survey Form to Participant &nbsp;&nbsp;&nbsp;<a href="sendSurvey.html" style="">Click here</a></td></tr>
                        <tr id=""><td>Survey Form &nbsp;&nbsp;&nbsp;<a href="survey.html" style="">Click here</a></td></tr>--%>
                    </s:if> 
                </table>
            </div>
            <s:if test='%{(#session.loggedInUser.roleId == 3) || (#session.loggedInUser.roleId == 5) || (#session.loggedInUser.roleId == 6)}'>
                <p><b style="color: #474686;">Reports</b> <img id="imgshow3" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow3', 'reports');"></p>
                <div id="reports" style="display: none;">
                    <table class="content_container" >
                        <tr id="" ><td>Workshop Status Summary Report &nbsp;&nbsp;&nbsp;<a href="viewSummary.html?sd=none&ed=none" style="" target="_blank">Click here</a></td></tr>
                        <tr id="" ><td>Workshop Diversity Report &nbsp;&nbsp;&nbsp;<a href="workshopSummary.html?sd=none&ed=none" style="" target="_blank">Click here</a></td></tr> 
                        <tr id="" ><td>Remote Center wise Summary Report &nbsp;&nbsp;&nbsp;<a href="rcwiseSummary.html?sd=none&ed=none" style="" target="_blank">Click here</a></td></tr> 
                        <tr id="" ><td>State wise Summary Report &nbsp;&nbsp;&nbsp;<a href="statewiseSummary.html?sd=none&ed=none" style="" target="_blank">Click here</a></td></tr>
                        <tr id="" ><td>Total Workshops Attended by Participants/Institute &nbsp;&nbsp;&nbsp;<a href="workshopAttended.html?val=none" style="" target="_blank">Click here</a></td></tr>
                        <%--<tr id="" ><td>view Survey Details &nbsp;&nbsp;&nbsp;<a href="viewSurveyDetails.html" style="">Click here</a></td></tr>--%>
                    </table>
                </div>
            </s:if>
            <p><a href="faqAdmin.html" target="_blank"><b style="color: #474686;">FAQs</b></a></p>

        </div>
    </s:if>        
    <%--
    <!--        <table>
         <tr><td>View Survey &nbsp;&nbsp;&nbsp;<a href="viewSurvey.html" style="">Click here</a></td></tr>
     </table>--%>
    <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId >= 1000}'>
        <div class="form_settings">
            <div class="form_box"> <br/> 
                <p><b>Update Attendance of Workshops <a href="home.html" style="">Click Here</a></b></p>
                <br>
                <br>
            </div>
        </div>
    </s:if>
    <% String homecontent = "";
        ArrayList<Content> contents = null;
        Content data = new Content();
        UtilityProcess process = new UtilityProcess();
        try {
            contents = new ArrayList<Content>();
            contents = process.getPage_Content("home");
            for (int k = 0; k < contents.size(); k++) {
                data = (org.project.bean.Content) contents.get(k);
                homecontent = (String) data.getContent();
            }
        } catch (Exception e) {
            homecontent = "";
        }
    %>
    <% if (!homecontent.trim().equals("")) {%>
    <s:set var="content"><%= homecontent%></s:set>
    <s:property escape="false" value="content"/>
    <% } else {%>
    <h1>Project Name </h1>

    <p>Content of home page...</p>
    <% }%>
  

</body>
</html>
