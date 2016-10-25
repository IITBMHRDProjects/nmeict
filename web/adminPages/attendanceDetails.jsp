<%-- 
    Document   : attendanceDetails
    Created on : 18 May, 2015, 11:47:02 AM
    Author     : Abinaya
--%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>

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

    String rcid_value = cipher.decrypt(rcid_enc);

%>
<html>
    <head>   
        <link rel="stylesheet" href="css/datepicker-jquery-ui.css">
        <script src="js/datepicker-jquery-ui.js"></script>
        <link rel="stylesheet" href="css/jquery.timepicker.css">
        <script src="js/jquery.timepicker.js"></script>

        <script type="text/javascript">
            $(document).ready(function() {
                $('#schedule1').dataTable({
                    // "scrollX": true,                
                    "iDisplayLength": 25,
                    "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
                    "order":[]
                });
            });                        
        </script>
        <script type="text/javascript">
            function showSession1(){                
                callShowSession1();               
            }           
            function deleteComment(rowid){               
                
                var idSession=document.getElementById("id_"+rowid).innerHTML;
                
                // check if next row is a different date, else dont delete
                
                var date1=document.getElementById("date_"+rowid).innerHTML;
                
                var nextRow= ++rowid;
               
                var table=document.getElementById("schedule1body");
                var size=table.rows.length;   
                
                document.getElementById("row_del").value=rowid;
                deleteSessionComment(idSession); 
                
                //                if(nextRow <=size)
                //                {
                //                    var date2=document.getElementById("date_"+nextRow).innerHTML;
                //                    
                //                    if(date1==date2){
                //                        alert("Please delete the last session of the day");
                //                    } else
                //                    {                       
                //                        document.getElementById("row_del").value=rowid;
                //                        deleteSessionComment(idSession); 
                //                    }
                //                }
                //                else
                //                {
                //                    document.getElementById("row_del").value=rowid;
                //                    deleteSessionComment(idSession); 
                //                } 
            }
            
            function changeCommentContent(rowid){
                alert("inside change");
                var val=document.getElementById("comment_"+rowid).value;
                alert(val);
            }
            function updateComment(rowid){                
                var comment_val=document.getElementById("comment_"+rowid).value;
                // var time_slot=document.getElementById("time_"+rowid).value;                
                var idSession=document.getElementById("id_"+rowid).innerHTML;
                var isActive1=document.getElementById("active3_"+rowid).checked;
                // var isActive2=document.getElementById("active4_"+rowid).checked;
                if(isActive1 == 1)
                    var isActive=1;
                if(isActive1 == 0)
                    var isActive=0;                
                var time_slot_from=document.getElementById("xxx_"+rowid).value;
                var time_slot_to=document.getElementById("yyy_"+rowid).value; 
                var update_till=document.getElementById("zzz_"+rowid).value; 
                updateSessionComment(comment_val,idSession,time_slot_from,time_slot_to,isActive, update_till);
            }
            
            function generateAttendance(workshopid){ 
                var no_of_participants=document.getElementById("participantsize").value;
                if(no_of_participants > 0){
                    generateAttendanceSheet(workshopid);
                }else{
                    alert("There are no Confirmed Participants");
                }
            }
            
            function newSession(){               
                // div id which will be used in cover the all screen
                var id = "#dialog";
                //Get the screen height and width
                var maskheight = $(document).height();
                var maskwidth = $(window).width();
                //Set height and width to mask to fill up the whole screen
                $('#mask').css({'width': maskwidth, 'height': maskheight});
                //transition effect   
                $('#mask').fadeIn(1000);
                $('#mask').fadeTo('slow', 0.8);
                //Get the window height and width
                var winH = $(window).height();
                var winW = $(window).width();
                //Set the popup window to center
                $(id).css('top', winH / 2 - $(id).height() / 2);
                $(id).css('left', winW / 2 - $(id).width() / 2);
                //connecting to database and retrieve data
                //                fetclistlookups();
                //transition effect
                $(id).fadeIn(2000);
                // $('#dialog').hide();
                $("#other_msg").val("");
                // });

                //if close button is clicked
                $('.window .close').click(function(e) {
                    // alert("close");
                    e.preventDefault();
                    $('#mask, .window').hide();
                });

                $('#mask').click(function() {
                    $(this).hide();
                    $('.window').hide();
                });
            }
            
            $(function() {
                $( "#datepicker1" ).datepicker({ dateFormat: 'dd-mm-yy' }); 
                
                $( "#datepickerA" ).datepicker({ dateFormat: 'dd-mm-yy' }); 
                $( "#timepicker1" ).timepicker({scrollbar: true,interval :5, minHour: 8,maxHour: 20, timeFormat: 'HH:mm '});  
                $( "#timepicker2" ).timepicker({scrollbar: true,interval :5,  minHour: 8,maxHour: 20, timeFormat: 'HH:mm '});
                var size_sch=document.getElementById("size_sch").value;
                if(size_sch > 0){                 
                    for(var i=1;i<=size_sch;i++){
                        $( "#xxx_"+i ).timepicker({scrollbar: true,interval :5, minHour: 8,maxHour: 20 , timeFormat: 'HH:mm '});
                        $( "#yyy_"+i ).timepicker({scrollbar: true,interval :5, minHour: 8,maxHour: 20 , timeFormat: 'HH:mm '});
                        $( "#zzz_"+i ).datepicker({ dateFormat: 'yy-mm-dd'});                        
                    }
                }
            });
            
            function submitdata() {
                var dateOfSession= document.getElementById("datepicker1").value;
                if(dateOfSession=="" || dateOfSession == null){
                    alert("Please select a date");return false;
                } else{
                    var comment=document.getElementById("comment").value;
                    var time_slot=document.getElementById("time_slot").value;
                    // time slot from - to
                    var time_slot_from=document.getElementById("timepicker1").value;
                    var time_slot_to=document.getElementById("timepicker2").value;
                    var workshopid=document.getElementById("workshopid").value;
                    var isActive1=document.getElementById("active1").checked;
                    var isActive2=document.getElementById("active2").checked;
                    var update_till=document.getElementById("datepickerA").value;
                    if(isActive1 == 1)
                        var isActive=1;
                    if(isActive2 == 1)
                        var isActive =0;                  
                    insertNewSession(dateOfSession,comment,workshopid, time_slot_from,time_slot_to, isActive, update_till);
                }
            }
        </script>
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
                border: 3px solid #0d3a0d;
                display: none;
                /*background: #3d2c10;*/
                background: #0d3a0d;

            }

            #boxes #dialog {
                height: 409px;
                width: 675px;
            }

            #top{
                /*color: olive;*/
                color: white;
                /*background: #3d2c10;*/
                background: #0d3a0d;
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
                /*border-top:  5px solid #1d1b6d;*/
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
    </head>
    <body>
        <%--<s:if test='%{#session.loggedInUser.roleId > 1}'>--%>


        <s:iterator value="workshopContent">
            <h1 style="color: #FF4500;font-weight: bold;font-size: 220%;text-align: center;">Attendance Details</h1>
            <input id="lms_moodle" type="hidden" value="<s:property value="lms_moodle"/>"/>
            <input id="lms_iitbx" type="hidden" value="<s:property value="lms_iitbx"/>"/>
            <input id="moodle_coursename" type="hidden" value="<s:property value="moodle_coursename"/>"/>
            <input id="iitbx_coursename" type="hidden" value="<s:property value="iitbx_coursename"/>"/>
            <h1 style="color: #036;font-weight: bold;font-size: 220%;text-align: center;"><s:property value="workshopname" /></h1>
            <h4 align="center"><s:property value="sponsor"/></h4>
            <br/>
            <input id="workshopid" value="<s:property value="workshopid"/>" type="hidden"/>
            <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   

            <input type="hidden" value="${participantdetails.size()}" id="participantsize"/>
            <s:if test='%{ifAttendanceSheetCreated == 0 && ifAttendanceCanBeCreated == 1}'>
                <h4 id="generateAttendanceButton">
                    <b>Click the button to generate Attendance </b>
                    <button class="completedButton" style="position: relative; bottom: 10px;" onclick="generateAttendance(<s:property value="workshopid"/>)">Generate</button>
                </h4><br/><br/>
            </s:if>

            <input style="display:none;" id="size_sch" value="<s:property value="schedule.size()"/>"/>
            <s:if test='%{schedule.size > 0}'> 
                <div id="scheduleTable">
                    <h4>
                        <b>Click the button to create a New Session</b>
                        <button class="completedButton" style="position: relative; bottom: 10px;" onclick="newSession()">New</button>
                    </h4><br/><br/>
                    <div id="boxes">
                        <div id="dialog" class="window">
                            <p id="top">New Session  
                                <a href="#" class="close">Close</a>
                            </p>
                            <div id="inwindow">
                                <div id="invalid_list">
                                    <p>
                                        <span>Date of Session<sup><img src="images/star.png" /></sup>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                        <input type="text" readonly="true" value="" id="datepicker1"/>
                                    </p>
                                    <p><span>Time - From</span>
                                        <input id="timepicker1" type="text" value=""  readonly="true" class="timepicker"/></p>
                                    <p>
                                    <p><span>Time - To</span>
                                        <input id="timepicker2" type="text" value="" readonly="true" class="timepicker"/></p>
                                    <p style="display:none;">
                                        <span>Time - Slot &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                        <input type="text" id="time_slot" value=""/>
                                    </p>
                                    <p><span>Topic/Schedule&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;</span>
                                        <textarea id="comment" rows="5" cols="50"></textarea>
                                    </p>
                                    <div class="radiobutton">
                                        <span>If attendance counted for the session?</span>
                                        <span class="s"  style="width: 270px; font-size: 90%">
                                            <input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="active1" type="radio" name="isactive1" value="1" checked/>&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input style="  width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="active2" name="isactive1" value="0" />&nbsp;&nbsp;&nbsp; No
                                        </span>
                                    </div>
                                    <p><span>Update Till</span>
                                        <input id="datepickerA" type="text" value="" readonly="true" class="datepicker"/></p>

                                </div>                                
                                <br>
                                <input id="sendM" type="button" value="Submit"  onclick="submitdata();"/><br><br>
                            </div>
                        </div>
                        <div id="mask"></div>
                    </div>                    
                    <h4 style="color: black;"> <b>View Schedule</b> 
                    </h4>

                    <!--<p >click here to view session 1 alone<button onclick="showSession1()">CLICK</button></p>-->
                    <input id="row_to_be_deleted" type="hidden" value="no" />
                    <input id="row_del" type="hidden" value=""/>
                    <table class="display1" id="schedule1" style="word-spacing: normal;width:770px;margin-left: 15%;" cellspacing="0" align="center">
                        <thead id = "headers">
                            <tr>
                                <td style="display:none"><b>session id</b></td>
                                <td style="width:25%;text-align: center"><b>Date</b></td>
                                <td style="width:10%;text-align: center; display: none;"><b>Session Number</b></td>
                                <td style="width:10%;text-align: center;"><b>Time Slot</b></td>                                
                                <td style="width:30%;text-align: center"><b>Topic/Schedule</b></td>
                                <td style="width:10%; text-align: center; "><b>if attendance counted</b></td>
                                <td style="text-align:center;"><b>Update Till</b></td>
                                <td style="width:20%;text-align: center"><b>Update</b></td>
                            </tr>
                        </thead>
                        <tbody id="schedule1body">
                            <s:iterator value="schedule" status="itStatus">
                                <tr id="rowid_<s:property value="#itStatus.count" />">
                                    <td id="id_<s:property value="#itStatus.count" />" style="display: none;padding: 0 0;"><s:property value="idOfParticularSession"/></td>
                                    <td id="date_<s:property value="#itStatus.count" />" style="text-align: center;padding: 0 0;"><s:property value="dateOfSession"/></td>
                                    <td style="display:none;" id="session_<s:property value="#itStatus.count"/>" style="text-align: center;padding: 0 0;" ><s:property value="numberOfSessions"/></td>
                                    <td style="text-align: center;padding: 0 25px;" >
                                        <!--<input id="time_<s:property value="#itStatus.count"/>"  style="border: none;background-color:transparent;padding: 0 0;width:175px;" value="<s:property value="time_slot"/>"><br/>-->
                                        <input style="width:125px;text-align: center;" id="xxx_<s:property value="#itStatus.count"/>" class="timepicker" value="${time_from}"/> to
                                        <input style="width:125px;text-align: center;" id="yyy_<s:property value="#itStatus.count"/>" class="timepicker" value="${time_to}"/>
                                    </td>
                                    <td style="text-align: center;padding: 0 2px;" >
                                        <textarea spellcheck="true" id="comment_<s:property value="#itStatus.count"/>" rows="auto" cols="40" style="border: none;background-color:transparent;padding: 0 0;position: relative;left:20px;"><s:property value="comments"/>
                                        </textarea>   
                                    </td>
                                    <td>
                                        <!--<span class="s"  style="width: 270px; font-size: 90%">-->
                                        <s:if test="%{isActive == 1}"><input type="checkbox" checked="true" id="active3_<s:property value="#itStatus.count"/>" name="act_<s:property value="#itStatus.count"/>"/></s:if>
                                        <s:else><input type="checkbox" id="active3_<s:property value="#itStatus.count"/>" name="act_<s:property value="#itStatus.count"/>"/></s:else>
                                        <!--</span>-->                                           
                                    </td>
                                    <td>
                                        <input style="width:125px;text-align: center;" id="zzz_<s:property value="#itStatus.count"/>" class="datepicker" value="${date_till_1}"/>

                                    </td>
                                    <td style="text-align: center;padding: 0 0;">
                                        <button class="approvedButton" onclick="updateComment('<s:property value="#itStatus.count"/>')">Update</button>
                                        <button class="cancelledButton" onclick="deleteComment('<s:property value="#itStatus.count"/>')">Delete</button>
                                    </td>
                                </tr>
                            </s:iterator>
                        </tbody>
                    </table>
                </div>
            </s:if>
            <s:else>
                <h4 style="color: black;"><b>Create Program Schedule   </b> <a target="_blank" style="color:#5958A8;" href="createProgramAttendance.html?workshopid=<s:property value="workshopid_encrypted"/>">Click Here</a></h4>

                <h4 style="color: black;"> <b>Click on the image to export details of the participants</b> <a onclick="createExcel(<s:property value="workshopid"/>,<s:property value="categorycode"/>, '<%=rcid_value%>', <s:property value="respectiveCoWorkshopid"/>)" style="position:relative;left:20px;top:10px;" title="Export to Excel">
                        <img src="images/savexls.png"/>
                    </a></h4>
                <div class="form_settings">  
                    <s:if test="%{categorycode == 5}">
                        <table class="content_container1" style="font-size: 110%;">
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
                        </table>  
                    </s:if>
                    <input type="hidden" id="cc" value="<s:property value="categorycode"/>"/>
                </div>
            </s:else>          


        </s:iterator>        
        <%--</s:if>--%>
    </body>
</html>
