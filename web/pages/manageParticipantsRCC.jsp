<%-- 
    Document   : manageParticipantsRCC
    Created on : 21 Jul, 2015, 11:14:00 AM
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
    String workshopid_enc = request.getParameter("workshopid");
    String rcid_enc = request.getParameter("rcid");
    String contextPath = ServletActionContext.getServletContext().getRealPath("");

    String rcid_value = cipher.decrypt(rcid_enc);

%>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script language="JavaScript" src="js/jquery.tipTip.minified.js"></script>       
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script>
    var $jQuery2 = jQuery.noConflict(true);
</script>
<s:if test='%{#session.loggedInUser.roleId >= 1}'>
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
    <div id="boxes">
        <div id="dialog" class="window">
            <p id="top">Registration Reject Reasons  
                <a href="#" class="close">Close</a>
            </p>
            <div id="inwindow">
                <div id="invalid_list">
                </div>
                <input type="hidden" id="res_code" value=""/>
                <input type="hidden" id="hide_userdata" value=""/>
                <div id="other_div">
                    <br><label id=""><b>Please Specify Reasons :</b></label><br><br>
                    <textarea rows="5" cols="50" id="other_msg" maxlength="250"></textarea><br>
                </div><br>
                <input id="sendM" type="button" value="Submit"  onclick="submitdata1()"/><br><br>
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
        <br/>
        <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   
        <h4 style="color: black;display:none;"> <b>Click on the image to export details of the participants</b> <a onclick="createExcel(<s:property value="workshopid"/>,<s:property value="categorycode"/>, '<%=rcid_value%>', <s:property value="respectiveCoWorkshopid"/>)" style="position:relative;left:20px;top:10px;" title="Export to Excel">
                <img src="images/savexls.png"/>
            </a></h4>
        <div class="form_settings">  
            <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
                <table class="content_container1" style="font-size: 110%;display:none;">
                    <tr><td style="white-space: nowrap;padding: 0px;">Remote Center:</td><td style="white-space: nowrap;padding: 5px;"><select class="displayselect" id="rcid" name="remotecenter" onchange="changeTest('<%=update_enc%>', '<s:property value="workshopid_encrypted"/>', '<s:property value="status_encrypted"/>');" >
                                <option value="<%=all_encrypted%>">All</option>
                                <s:iterator value="remoteCenters">
                                    <s:if test="%{remoteCenterId == rcid_present}" >
                                        <option value="<s:property value="enc_RC"/>" selected="true"><s:property value="remoteCenterId"/>--<s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="enc_RC"/>"><s:property value="remoteCenterId"/>--<s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                    </s:else>
                                </s:iterator>                                             
                            </select></td>

                    </tr><tr><td style="white-space: nowrap;padding: 0px;">View Remote Center Seating/Accommodation Provisionally Booked</td>
                        <td><input type="button" style="background: black;color: white; width: 100px;height:30px; border-radius: 7px;" onclick="viewSeats('<s:property value="workshopid_encrypted"/>')" value="View Seats"/></td></tr>
                </table>  
            </s:if>
            <s:if test="%{categorycode == 4}">
                <input type="hidden" id="rcid" value="all">
            </s:if>
            <input type="hidden" id="cc" value="<s:property value="categorycode"/>"/>
        </div>        
    </s:iterator>
    <div style="position: relative;left:150px;display:none;">
        <br/>
        <p style="font-weight: bold;font-size: 120%;position: relative;left:200px;">Check or Un-check boxes to view/hide fields</p>
        <p style="font-weight: bold;font-size: 120%">
            <s:iterator value="workshopContent">                
                <input type="checkbox" id="desgination_check" onclick="checkDesignationBox(<s:property value="categorycode"/>);"> Designation &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" id="experience_check" onclick="checkExperienceBox(<s:property value="categorycode"/>);"> Experience &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" id="qualification_check" onclick="checkQualificationBox(<s:property value="categorycode"/>);"> Qualification &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" id="regtime_check" onclick="checkRegtimeBox(<s:property value="categorycode"/>);"> Registration Time &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" id="stream_check" onclick="checkStreamBox(<s:property value="categorycode"/>);"> Stream &nbsp;&nbsp;&nbsp;&nbsp;
                <input type="checkbox" id="participantid_check" onclick="changeDisplays(1);"> Participant Id</p>
            </s:iterator>
        <br/>
    </div>
    <br/><br/>

    <s:if test='%{participantdetails.size > 0}'>
        <table class="display1" id="participantDetail1" style="word-spacing: normal;text-wrap: avoid;">
            <thead id = "headers" > 
                <tr>
                    <th>S.No</th>
                    <th style="display: none;">P ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th style="text-align: center;">Update</th>
                </tr>
            </thead>
            <tbody align="center" id="participantDetailsBody11" >
                <s:iterator value="participantdetails" status="itStatus">
                    <tr class="gradeU" id="tr_<s:property value="#itStatus.count" />">
                        <td style="align:right" id="sno_<s:property value="#itStatus.count" />"><s:property value="#itStatus.count" /></td>

                        <td id="pid_<s:property value="#itStatus.count" />" style="display: none;"><s:property value="registrationDetails.participantid" /></td>

                        <td id="name_<s:property value="#itStatus.count" />"><s:property value="firstName" /> <s:property value="lastName" /></td>
                        <%--<td id="email_<s:property value="#itStatus.count" />">test@test.com</td>--%>
                        <td id="email_<s:property value="#itStatus.count" />"><s:property value="email" /></td> 

                        <s:if test='%{#session.loggedInUser.roleId >= 1}'>
                            <td style="position: relative; padding: 0 0 0 0;alignment-adjust: central;" id="update_<s:property value="#itStatus.count" />">
                                <button class="confirmedButton" style="position: relative;left:60px;" onclick="changeStatus(<s:property value="#itStatus.count" />,<s:property value="registrationDetails.participantid" />, 'Accepted', '<s:property value="email" />', '<%=contextPath%>')">Accept</button> <br>
                                <button class="cancelledButton" style="position: relative;left:60px;" onclick="changeStatus1(<s:property value="#itStatus.count" />,<s:property value="registrationDetails.participantid" />, 'Registration Invalid', '<s:property value="email" />', '<%=contextPath%>')">Reject</button>
                            </td>
                        </s:if>
                    </tr> 
                </s:iterator> 
            </tbody>  
        </table>
        <script type="text/javascript">
            /* $(document).ready(function() {
             $('#participantDetail1').dataTable({
             // "scrollX": true,                
             "iDisplayLength": 25,
             "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]]
             });
             });*/
            $jQuery2(function () {
                $jQuery2('#participantDetail1').dataTable({
                    // "scrollX": true,                
                    "iDisplayLength": 25,
                    "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]]
                });
            });
        </script>
    </s:if>
    <s:else>
        <h4> There are no participants to display.</h4>   
    </s:else>
    <script>
        $('.window .close').click(function (e) {
            e.preventDefault();
            $('#mask, .window').hide();
        });

        $('#mask').click(function () {
            $(this).hide();
            $('.window').hide();
        });
    </script> 
    <script>
        function changeStatus1(i, participantid, status, email, context) {
            document.getElementById("hide_userdata").value = i + "*" + participantid + "*" + status + "*" + email + "*" + context;
            call_modalBox();
        }

        function changeStatus(i, participantid, status, email, context)
        {   // for participants to be enrolled in moodle
            var lms_moodle = 1;
            var cc = document.getElementById("cc").value;
            changeParticipantStatus(i, participantid, status, email, context, cc, lms_moodle);


        }

        function call_modalBox() {
            // div id which will be used in cover the all screen
            var id = "#dialog";
            //Get the screen height and width
            var maskheight = $(document).height();
            var maskwidth = $(window).width();
            //Set height and width to mask to fill up the whole screen
            //  $('#mask').css({'width': maskwidth, 'height': maskheight});
            //transition effect   
            //   $('#mask').fadeIn(1000);
            //   $('#mask').fadeTo('slow', 0.8);
            //Get the window height and width
            var winH = $(window).height();
            var winW = $(window).width();
            //Set the popup window to center
            $(id).css('top', winH / 2 - $(id).height() / 2);
            $(id).css('left', winW / 2 - $(id).width() / 2);
            //connecting to database and retrieve data
            //fetclistlookups();
            //transition effect
            //  $(id).fadeIn(2000);
            $(id).fadeIn(100);
            // $('#dialog').hide();
            $("#other_msg").val("");
            // });

            //if close button is clicked
            $('.window .close').click(function (e) {
                // alert("close");
                e.preventDefault();
                //  $('#mask, .window').hide();
            });

            $('#mask').click(function () {
                $(this).hide();
                $('.window').hide();
            });
        }

        function submitdata1() {
            var newdata = document.getElementById("hide_userdata").value.split("*");
            var istatus = newdata[0];
            var participantid = newdata[1];
            var status = newdata[2];
            var email = newdata[3];
            var context = newdata[4];
            var txtid = document.getElementById('other_msg').value.trim();
            if (txtid == '') {
                alert('please enter a Reason')
            } else if (txtid != '') {
                var cc = document.getElementById("cc").value;
                changeStatusForRejectParticipant(istatus, participantid, status, email, context, cc, txtid);
                // alert('perform next');
            }
        }

        function changeStatusForRejectParticipant(i, participantid, status, email, context, cc, code) {
            var data = "tem1=" + i + "&tem2=" + participantid + "&tem3=" + email + "&tem4=" + context + "&tem5=" + status + "&tem6=" + code;
            $.ajax({
                url: "pages/DAOChangeStatusReject.jsp",
                type: "GET",
                data: data,
                dataType: "json",
                success: setChangedStatusReject,
                error: onError
            });
        }

        function setChangedStatusReject(data) {
            if (data == "notupdated") {
                alert("Error. Please try again later.");
            } else {
                alert('Mail has been sent');
                location.reload();
                //document.getElementById(data[0]).innerHTML = data[1];
            }
        }

        function onError(jqXHR, textStatus) {
            alert("Error : " + textStatus);
        }
    </script>
</s:if>
