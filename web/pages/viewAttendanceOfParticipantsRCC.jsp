<%-- 
    Document   : viewAttendanceOfParticipantsRCC
    Created on : 16 Sep, 2015, 12:36:42 PM
    Author     : Abinaya
--%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
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
    String update_enc = request.getParameter("update");
    String rcid = request.getParameter("rcid");
    // comment added
    String workshopid_enc = request.getParameter("workshopid");
    String date_1 = request.getParameter("date");
    if (date_1.equals("-SIpJewWW2Nr56jHwvqJiw")) {
        date_1 = "";
    }
%>

<script type="text/javascript">
    function downloadPDF(dateofSession){        
        var rcid=document.getElementById("rcid").value;
        var workshopid=document.getElementById("workshopid").value;        
        downloadPDFWSCAttendanceSheet(dateofSession, rcid,workshopid );
    }
    
    function updateAttendance(trid){
        var date_tbl=trid.split("_",1);
        var cells=document.getElementById(trid).getElementsByTagName("td");        
        var participantid=cells[0].innerHTML;
        var session_update=[];        
        for (var ic=3,it= (cells.length);ic<it-1;ic++) {
            var check_box =cells[ic].childNodes.item(0).checked;
            if(check_box == true){var update="Yes";}
            else{var update="No";}            
            session_update.push(update);  
        }       
        var workshopid=document.getElementById("workshopid").value;
        var tr_id=trid.split("_");
        var tr=tr_id[1];
        //alert(document.getElementById("button_"+date_tbl+"_"+tr).innerHTML);
        document.getElementById("button_"+date_tbl+"_"+tr).style.background="green";
        updateSessionOfParticipant1(workshopid,participantid,date_tbl,session_update);
    }   
    function updateAttendance1(date_count){
        var tr_id=date_count.split("_");
        var tr=tr_id[1];
        var date_tbl=tr_id[0];         
        for(var k=1;k<=tr;k++){
            var trid=date_tbl+"_"+k;           
            var cells=document.getElementById(trid).getElementsByTagName("td");        
            var participantid=cells[0].innerHTML;
            var session_update=[];        
            for (var ic=3,it= (cells.length);ic<it-1;ic++) {
                var check_box =cells[ic].childNodes.item(0).checked;
                if(check_box == true){var update="Yes";}
                else{var update="No";}            
                session_update.push(update);  
            }       
            var workshopid=document.getElementById("workshopid").value;
            updateSessionOfParticipant2(workshopid,participantid,date_tbl,session_update);
            document.getElementById("button_"+date_tbl+"_"+k).style.background="green";
        }
        document.getElementById("button_"+date_tbl).style.background="green";
        alert("Updated Successfully");
        //
    }   
    function getAllDetails1(val) {        
        //        var size_1 = document.getElementById("size").value;
        //        // reset all table to visible first
        //        for (var i = 1; i <= size_1; i++) {
        //            var element = document.getElementById("date_of_div_" + i).value;
        //            document.getElementById(element).style.display = "inline";
        //        }
        //        if (val != -1) {
        //            for (var i = 1; i <= size_1; i++) {
        //                var element = document.getElementById("date_of_div_" + i).value;
        //                if (element != val) {
        //                    document.getElementById(element).style.display = "none";
        //                }
        //            }
        //        }
      
        var wid='<%=workshopid_enc%>';        
        var rcid='<%=rcid%>';
        window.location="viewAttendanceOfParticipantsRCC.html?workshopid="+wid+"&rcid="+rcid+"&date="+val;
        
    }  
    
    function checkBox(trid, flag){        
        if(flag == 1){           
            var date_tbl=trid.split("_",1);
            document.getElementById("button_"+trid).style.background="#1e90ff";
            document.getElementById("button_"+date_tbl).style.background="#1e90ff";      
        }
    }
</script>

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
    <div class="form_settings">  
        <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8 }">
            <table class="content_container1" style="font-size: 110%;display:none;">
                <tr><td style="white-space: nowrap;padding: 0px;">Remote Center:</td><td style="white-space: nowrap;padding: 5px;"><select class="displayselect" id="rcid" name="remotecenter" onchange="changeRC('<%=update_enc%>', '<s:property value="workshopid_encrypted"/>', this.value);" >
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
        <s:if test="%{categorycode == 4 || categorycode == 6}">
            <input type="hidden" id="rcid" value="all">
        </s:if>
        <input type="hidden" id="cc" value="<s:property value="categorycode"/>"/>
        <br/><br/>
        <s:if test='%{schedule2.size != 0}'>
            <div style="padding: 0px; padding-right: 2px; border:none;background:#EDEDED;">
                <b style="font-size: 110%;float:right;">Export Consolidated Attendance Sheet &nbsp;<input type="button" style="background: #474686; color: white; width: 100px;height:25px; border: none; padding: 2px; border-radius: 8px;font-size: 95%;font-weight: bold;" value="Export" onclick="exportToExcelAllDate('<%= workshopid_enc%>','<%= rcid%>');"/></b>
            </div><br>
            <div class="form_settings">            
                <center>
                    <!--<p align="left" style="font-size: 120%;position: relative; left:10px"><b>Please click on a date</b></p>-->
                    <table class="content_container1" style="font-size: 110%;width: auto;">                
                        <tr ><td colspan="<s:property value="schedule2.size"/>" style="white-space: nowrap;padding: 0px;border:none;background:#EDEDED;padding-left: 20px;font-size: 110%;"><b>Please click on a date</b></td></tr>
                        <tr>

                            <s:iterator value="schedule2" status="itStatus"> 
                                <td style="white-space: nowrap;padding: 0px;border:none;background:#EDEDED;padding-left: 10px;">
                                    <s:set value="dateOfSession" var="d2"/>
                                    <%String d2 = (request.getAttribute("d2")).toString();%>
                                    <s:if test='%{time_slot == 1}'>
                                        <%
                                            if (d2.equals(date_1)) {%> 
                                        <!--<button type="button" style="width:auto;background-color: #4281a4;padding:2px 5px 3px 5px;" class="approvedButton" value="<s:property value="dateOfSession"/>" onclick="getAllDetails1(this.value)" ><s:property value="date_string"/></button>-->

                                        <s:if test='%{ifUpdatedByWSC == 1}'>
                                            <button type="button" style="width:auto;border-style: solid; border-color:#1F3010; border-width: 3px; " class="confirmedButton1" value="<s:property value="dateOfSession"/>" onclick="getAllDetails1(this.value)" ><s:property value="date_string"/></button>
                                        </s:if><s:else>
                                            <button type="button" style="width:auto;padding:2px 5px 3px 5px;border-style: solid; border-color:#1F3010; border-width: 3px; " class="approvedButton" value="<s:property value="dateOfSession"/>" onclick="getAllDetails1(this.value)" ><s:property value="date_string"/></button>
                                        </s:else>

                                        <% } else {%>
                                        <s:if test='%{ifUpdatedByWSC == 1}'>
                                            <button type="button" style="width:auto;" class="confirmedButton1" value="<s:property value="dateOfSession"/>" onclick="getAllDetails1(this.value)" ><s:property value="date_string"/></button>
                                        </s:if><s:else>
                                            <button type="button" style="width:auto;padding:2px 5px 3px 5px;" class="approvedButton" value="<s:property value="dateOfSession"/>" onclick="getAllDetails1(this.value)" ><s:property value="date_string"/></button>
                                        </s:else>
                                        <%}%>
                                    </s:if>
                                    <s:else>
                                        <%if (d2.equals(date_1)) {%> 
                                        <!--<button type="button" style="width:auto;background-color: #4281a4;padding:2px 5px 3px 5px;" class="approvedButton" value="<s:property value="dateOfSession"/>" onclick="getAllDetails1(this.value)" ><s:property value="date_string"/></button>-->

                                        <s:if test='%{ifUpdatedByWSC == 1}'>
                                            <button type="button" style="width:auto;background: #7F9A65 ;color:#fff;padding:2px 5px 3px 5px;border-style: solid; border-color:#1F3010; border-width: 3px;  " class="disabledButton" value="<s:property value="dateOfSession"/>" onclick="getAllDetails1(this.value)"><s:property value="date_string"/></button>
                                        </s:if><s:else>
                                            <button type="button" style="width:auto;background: #A0A0A0 ;color:#fff;padding:2px 5px 3px 5px;border-style: solid; border-color:#1F3010; border-width: 3px;  " class="disabledButton" value="<s:property value="dateOfSession"/>" onclick="getAllDetails1(this.value)"><s:property value="date_string"/></button>
                                        </s:else>

                                        <% } else {%>
                                        <s:if test='%{ifUpdatedByWSC == 1}'>
                                            <button type="button" style="width:auto;background: #7F9A65 ;color:#fff;padding:2px 5px 3px 5px; " class="disabledButton" value="<s:property value="dateOfSession"/>" onclick="getAllDetails1(this.value)"><s:property value="date_string"/></button>
                                        </s:if><s:else>
                                            <button type="button" style="width:auto;background: #A0A0A0 ;color:#fff;padding:2px 5px 3px 5px; " class="disabledButton" value="<s:property value="dateOfSession"/>" onclick="getAllDetails1(this.value)"><s:property value="date_string"/></button>
                                        </s:else><%}%>
                                    </s:else>
                                </td>
                            </s:iterator>
                        </tr>    
                    </table> 
                </center>           
            </div>
        </s:if><s:else>
            <center><h4><b> There are no details to be displayed.</b> </h4></center>
        </s:else>
    </div>
    <div id="pageContent">
        <div style="text-align: right; margin-right: 20px;">
            <s:set var="workshop"><s:property value="workshopid"/></s:set>
            <s:set var="rc_id"><s:property value="rcid_present"/></s:set>
            <%String workshopid = "", rc_id = "";
                try {
                    workshopid = request.getAttribute("workshop").toString();
                    rc_id = request.getAttribute("rc_id").toString();
                    workshopid = cipher.encrypt(workshopid);
                    rc_id = cipher.encrypt(rc_id);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>           
        </div>    
        <input type="hidden" id="date_of_page_before" value="<%=date_1%>"/>
        <input type="hidden" id="size" value="<s:property value="schedule1.size"/>"/>
        <s:iterator value="schedule1" status="itStatus">       
            <input type="hidden" id="date_of_div_<s:property value="#itStatus.count"/>" value="<s:property value="dateOfSession"/>"/>
            <div id="<s:property value="dateOfSession"/>">
                <h4 align="center"><b><s:property value="date_string"/></b></h4>
                <%--<p><a onclick="downloadPDF('<s:property value="dateOfSession"/>')"><b style="color:#474686;">Click here to download pdf of attendance sheet</b></a></p>--%>


                <table class="content_container1" style="font-size: 110%;display: none;">
                    <tr>
                        <td style="padding: 0px;border:none;background:#EDEDED;">
                            <a href="downloadAttendanceSheet.html?date=<s:property value="dateOfSession"/>&rcid=<s:property value="rcid_present"/>&workshopid=<s:property value="workshopid"/>" target="_blank"><b style="color:#474686;font-size: 110%;float:left;">Click here to download pdf of attendance sheet</b></a>
                        </td>
                        <s:if test="%{checkUpload == 1}">
                            <td style="padding: 0px;border:none;background:#EDEDED;">
                                <b style="font-size: 110%;float:right;"> Upload the Scanned Attendance Sheet Here <input type="button" style="background: #474686; color: white; width: 100px;height:25px; border: none; padding: 2px; border-radius: 8px;font-size: 95%;font-weight: bold;" value="Upload" onclick="upload_attendance('<%= workshopid%>','<%= rc_id%>','<%=date_1%>')"/></b>
                            </td>
                        </s:if>
                    </tr>
                </table>
                <table class="display1" id="schedule_<s:property value="dateOfSession"/>" style="word-spacing: normal;width:770px;margin-left: 20%;" cellspacing="0" align="center">
                    <thead id="headers">
                        <tr>
                            <td colspan="3" style="border-right:2px solid #333333;text-align: center;"><b>Participant Info</b></td>
                            <s:set var="no_of_session1" value="%{numberOfSessions}"/>
                            <% String no_of_sessions1 = (String) (request.getAttribute("no_of_session1"));%>
                            <td style="border-right:2px solid #333333;text-align: center;" colspan="<%=no_of_sessions1%>"><b>Sessions</b></td> 
                            <%--<s:if test='%{#session.loggedInUser.roleId >= 1}'>--%>

                            <%--</s:if>--%>
                        </tr>
                        <tr s>
                            <td style="font-weight: bold;border-bottom: 2px solid #333333;">Enrollment ID</td>
                            <td style="font-weight: bold;border-bottom: 2px solid #333333;">Name</td>
                            <td style="font-weight: bold;border-bottom: 2px solid #333333;">Email</td>
                            <s:set var="no_of_session" value="%{numberOfSessions}"/>
                            <% String no_of_sessions = (String) (request.getAttribute("no_of_session"));
                                for (int i = 1; i <= Integer.parseInt(no_of_sessions); i++) {
                            %>
                            <td style="text-align: center;font-weight: bold;border-bottom: 2px solid #333333;"><%=i%></td> 
                            <% }%>
                            <%--<s:if test='%{#session.loggedInUser.roleId >= 1}'>--%>
                            <%--</s:if>--%>
                        </tr>
                    </thead>

                    <tbody>
                        <s:iterator value="as" status="itStatus2">
                            <tr id="<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count"/>" >
                                <td><s:property value="participantid"/></td>
                                <td><s:property value="participantDetail.firstName"/> <s:property value="participantDetail.lastName"/></td>
                                <!--<td>test@test.com</td>-->
                                <td><s:property value="participantDetail.email"/></td>
                                <s:iterator value="isPresent" status="itStatus1">
                                    <s:set var="ifPresent" value="isPresent[#itStatus1.count-1]"/>                        
                                    <%--<s:if test='%{ifAttendanceCanBeUpdated == 1}'>
                                        <s:if test="%{isPresent[#itStatus1.count-1] == 'Yes'}">
                                            <td style="text-align: center;"><input type="checkbox" checked="checked" onchange="checkBox('<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count" />','<s:property value="ifAttendanceCanBeUpdated" />');"/></td>
                                            </s:if>
                                            <s:else>
                                            <td style="text-align: center;"><input type="checkbox" onchange="checkBox('<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count" />','<s:property value="ifAttendanceCanBeUpdated" />');"/></td>
                                            </s:else>  
                                        </s:if>
                                        <s:else> --%>
                                    <s:if test="%{isPresent[#itStatus1.count-1] == 'Yes'}">
                                        <td style="text-align: center;color:#006600;font-weight: bold;">P</td>
                                    </s:if>
                                    <s:else>
                                        <td style="text-align: center;color: #FF0000;font-weight: bold;">A</td>
                                    </s:else> 
                                    <%--  </s:else>--%>
                                </s:iterator>
                                <%--<s:if test='%{#session.loggedInUser.roleId >= 1}'>--%>

                                <%--</s:if>--%>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table> 
                <br/><br/>                
            </div>
            <script type="text/javascript">
                $(document).ready(function() {               
                    $('#schedule_<s:property value="dateOfSession"/>').dataTable({
                        // "scrollX": true,                
                        "iDisplayLength": 25,
                        "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
                        "order":[]
                    });
                });              
            </script>
        </s:iterator> 
    </div>
    <script>
        function upload_attendance(workshopid, rcid, date){
            date= date.trim();
            //alert(date)
            if(date == ""){
                alert('Please Select Date') 
            }else{
                window.open("uploadAttendacebyWSC.html?workshopid="+workshopid+"&rcid="+rcid+"&date="+date+"","directories=no,height=100,width=100,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,top=0,location=no");
            }
        }
        
    </script> 
    <script>
        function exportToExcelAllDate(wid,rcid){
            var data = "workshopid="+wid+"&rcid="+rcid;
            $.ajax({
                url: "pages/DAOCreateExcel_AttendanceDetailsWithAllDates.jsp",
                type: "GET",
                data: data,
                dataType: "json",
                success: excel_notregisterdatasuccess,
                error: onError
            });
        }

        function excel_notregisterdatasuccess(data) {
            var url = "Excel_Sheets/" + data;
            window.location.assign(url);
        }

        function onError(jqXHR, textStatus, errorThrown) {
            alert("Error : " + textStatus + " " + errorThrown);
        }
    </script>
</s:iterator>
<script>
    $(document).ready(function() {
        $("#settingoptions").hide();
        $("#showmore").click(function(e) {
            var x=e.pageX;
            var tmpx=x-200;
            $("#settingoptions").css({left: tmpx});
            $("#settingoptions").slideToggle();
        });
    });
</script>
