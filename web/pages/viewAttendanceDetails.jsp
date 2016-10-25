<%-- 
    Document   : viewAttendanceDetails
    Created on : 7 Jul, 2015, 10:11:45 AM
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
<script>
    var $jQuery2 = jQuery.noConflict(true);
</script>
<%
    SimpleStringCipher cipher = new SimpleStringCipher();
    String all_encrypted = cipher.encrypt("all");
    String update_enc = request.getParameter("update");
%>

<script type="text/javascript">
    function updateAttendance(trid) {
        var date_tbl = trid.split("_", 1);
        var cells = document.getElementById(trid).getElementsByTagName("td");
        var participantid = cells[0].innerHTML;
        var session_update = [];
        for (var ic = 3, it = (cells.length); ic < it - 2; ic++) {
            var check_box = cells[ic].childNodes.item(0).checked;
            if (check_box == true) {
                var update = "Yes";
            }
            else {
                var update = "No";
            }
            session_update.push(update);
        }
        var workshopid = document.getElementById("workshopid").value;
        // set temp trid for updating attended sessions of participant
        document.getElementById("trid_temp").value = trid;

        updateSessionOfParticipant(workshopid, participantid, date_tbl, session_update);
        document.getElementById("button_" + trid).style.background = "green";
    }
    function updateAttendedSessions(trid, sessionAttended) {
        alert("inside this.. update");
        document.getElementById(trid + "_sessionAttended").innerHTML = (sessionAttended);
    }

    function changeRC(update, workshopid, rcid) {
        //        if (rcid != "wZFlr-khrFxEMgeJzFwgvg") {
        window.location.href = "viewAttendanceDetails.html?update=" + update + "&workshopid=" + workshopid + "&rcid=" + rcid;
        //        }
    }

    function checkBox(trid) {
        var date_tbl = trid.split("_", 1);
        document.getElementById("button_" + trid).style.background = "#1e90ff";
        document.getElementById("button_" + date_tbl).style.background = "#1e90ff";

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
    <br> 
    <div style="padding: 10px; font-size: 14px;">
        Consolidated Attendance-Export to Excel : <select id="exportSelect"  onchange="exportExcelChange(this.value)">
            <option value="-1">--Please select an option--</option>
            <option value="consolidate">--One RC with all date--</option>
            <option value="allrcwise">--All RC with specific date--</option>
        </select>
    </div>
    <div style="padding: 10px; font-size: 14px;display: none;">
        Click here for Consolidated Attendance in Excel Sheet<input style="" type="button" onclick="tableToExcel('testTable', 'W3C Example Table')" value="Export to Excel"> 
    </div>
    <div style="padding: 10px; font-size: 14px;display: none;">
        Click Here for All Remote Center Wise Attendance <input type="button" value="Click" onclick="AllRcWiseAttendace('<s:property value="workshopid"/>');"/>
    </div>
    <div class="form_settings">  
        <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
            <table class="content_container1" style="font-size: 110%;">
                <tr><td style="white-space: nowrap;padding: 0px;">Remote Center:</td><td style="white-space: nowrap;padding: 5px;"><select class="displayselect" id="rcid" name="remotecenter" onchange="changeRC('<%=update_enc%>', '<s:property value="workshopid_encrypted"/>', this.value);" >
                            <option value="<%=all_encrypted%>">Select</option>
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
    </div>
    <div class="form_settings">
        <table class="content_container1" style="font-size: 110%;">
            <tr>
                <td style="white-space: nowrap;padding: 0px;">Select Date :</td>
                <td style="white-space: nowrap;padding: 5px;">
                    <select id="dateSelect" name="" onchange="getAllDetails1(this.value);
                            dateSelectForRcWise(this.value);">
                        <option selected value="-1">select Date</option>               
                        <s:iterator value="schedule1" status="itStatus">                   
                            <option  value="<s:property value="dateOfSession"/>"><s:property value="date_string"/></option>
                        </s:iterator>
                    </select>
                </td>
            </tr>
        </table>
    </div>
    <input type="hidden" id="trid_temp" value="">
    <input type="hidden" id="size" value="<s:property value="schedule1.size"/>"/>
    <s:iterator value="schedule1" status="itStatus">       
        <input type="hidden" id="date_of_div_<s:property value="#itStatus.count"/>" value="<s:property value="dateOfSession"/>"/>
        <div id="<s:property value="dateOfSession"/>">
            <h4 align="center"><b><s:property value="date_string"/></b></h4>
            <table class="display1" id="schedule_<s:property value="dateOfSession"/>" style="word-spacing: normal;width:770px;margin-left: 15%;" cellspacing="0" align="center">
                <thead id="headers">
                    <tr>
                        <td colspan="3" style="border-right:2px solid black;text-align: center;"><b>Participant Info</b></td>
                        <s:set var="no_of_session1" value="%{numberOfSessions}"/>
                        <% String no_of_sessions1 = (String) (request.getAttribute("no_of_session1"));%>
                        <td style="border-right:2px solid black;text-align: center;" colspan="<%=no_of_sessions1%>"><b>Sessions</b></td> 
                        <%--<s:if test='%{#session.loggedInUser.roleId > 2}'>--%>
                        <s:if test='%{#session.loggedInUser.roleId > 4}'>
                            <td style="width:110px;text-align: center;"><b>Update</b></td>
                        </s:if>
                        <td>Attendance Details</td>

                        <%--</s:if>--%>
                    </tr>
                    <tr>
                        <td>P ID</td>
                        <td>Name </td>
                        <td >P email</td>

                        <s:set var="no_of_session" value="%{numberOfSessions}"/>
                        <% String no_of_sessions = (String) (request.getAttribute("no_of_session"));
                            for (int i = 1; i <= Integer.parseInt(no_of_sessions); i++) {
                        %>
                        <td style="text-align: center;"><%=i%></td> 
                        <% }%>
                        <%--<s:if test='%{#session.loggedInUser.roleId > 2}'>--%>

                        <s:if test='%{#session.loggedInUser.roleId > 4}'> 
                            <td></td>
                        </s:if> 
                        <td>Sessions Attended / Total Sessions</td>

                        <%--</s:if>--%>
                    </tr>
                </thead>

                <tbody>
                    <s:iterator value="as" status="itStatus2">
                        <%--<s:if test='#session.loggedInUser.roleId > 4'>--%>
                        <tr id="<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count"/>" >
                            <td><s:property value="participantid"/></td>
                            <td><s:property value="participantDetail.firstName"/> <s:property value="participantDetail.lastName"/></td>
                            <td><s:property value="participantDetail.email"/></td>
                            <s:iterator value="isPresent" status="itStatus1">
                                <s:set var="ifPresent" value="isPresent[#itStatus1.count-1]"/>                        
                                <s:if test="%{isPresent[#itStatus1.count-1] == 'Yes'}">
                                    <td style="text-align: center;"><input type="checkbox" checked="checked" onchange="checkBox('<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count" />');"/></td>
                                    </s:if>
                                    <s:else>
                                    <td style="text-align: center;"><input type="checkbox" onchange="checkBox('<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count" />');"/></td>
                                    </s:else>   
                                </s:iterator>
                                <%--<s:if test='%{#session.loggedInUser.roleId > 2}'>--%>
                                <s:if test='%{#session.loggedInUser.roleId > 4}'>
                                <td style="padding:5px 10px;" id="update_<s:property value="#itStatus.count" />">
                                    <button style="position: relative;bottom:5px;" id="button_<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count" />" class="approvedButton" onclick="updateAttendance('<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count"/>')">Update</button>
                                </td>
                            </s:if>
                            <td style="text-align: center;" ><span id="<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count"/>_sessionAttended"><s:property value="sessionAttended"/></span> / <s:property value="numberOfSessions"/></td>
                            <%--</s:if>--%>
                        </tr>
                        <%-- </s:if>
                          <s:else>
                               <tr id="<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count"/>" >
                                   <td><s:property value="participantid"/></td>
                                   <td><s:property value="participantDetail.firstName"/> <s:property value="participantDetail.lastName"/></td>
                                   <td><s:property value="participantDetail.email"/></td>
                                   <s:iterator value="isPresent" status="itStatus1">
                                       <s:set var="ifPresent" value="isPresent[#itStatus1.count-1]"/>                        
                                       <s:if test="%{isPresent[#itStatus1.count-1] == 'Yes'}">
                                           <td style="text-align: center;">P</td>
                                       </s:if>
                                       <s:else>
                                           <td style="text-align: center; color: red;">A</td>
                                       </s:else>   
                                   </s:iterator>--%>
                        <%--<s:if test='%{#session.loggedInUser.roleId > 2}'>--%> <%--</s:if>--%>
                        <%--  <td style="text-align: center;"><span  id="<s:property value="dateOfSession"/>_<s:property value="#itStatus2.count"/>_sessionAttended"><s:property value="sessionAttended"/></span> / <s:property value="numberOfSessions"/></td>
                     </tr>
                 </s:else> --%>
                    </s:iterator>
                </tbody>

                <%-- <thead id = "headers">
                    <tr>
                        <td colspan="2" style="border-right:2px solid black;">Participant Info</td>
                        <s:iterator value="schedule1">    
                            <s:set var="no_of_session1" value="%{numberOfSessions}"/>
                            <% String no_of_sessions1 = (String) (request.getAttribute("no_of_session1"));%>
                            <td style="border-right:2px solid black;" colspan="<%=no_of_sessions1%>"><s:property value="date_string"/></td> 
                        </s:iterator>  
                    </tr>
                    <tr>
                        <td>P ID</td>
                        <td >P email</td>
                        <s:iterator value="schedule1"> 
                            <s:set var="no_of_session" value="%{numberOfSessions}"/>
                            <% String no_of_sessions = (String) (request.getAttribute("no_of_session"));
                                for (int i = 1; i <= Integer.parseInt(no_of_sessions); i++) {
                            %>
                            <td><%=i%></td> 
                            <% }%>
                        </s:iterator>  
                    </tr>
                </thead>
                <tbody id="schedule1body">  
                    <s:iterator value="sheet">
                        <tr>
                            <td><s:property value="participantid"/></td>
                            <td>email@email.com</td>
                            <s:iterator value="isPresent" status="itStatus">
                                <s:set var="ifPresent" value="isPresent[#itStatus.count-1]"/>                        
                                <s:if test="%{isPresent[#itStatus.count-1] == 'Yes'}">
                                    <td><input type="checkbox" checked/></td>
                                </s:if>
                                <s:else>
                                     <td><input type="checkbox"/></td>
                                </s:else>
                            </s:iterator>
                        </tr>
                    </s:iterator>
                </tbody> --%>
            </table>        
            <br/><br/> <br/><br/> </div>
        <script type="text/javascript">
            /*$(document).ready(function() {
             $('#schedule_<s:property value="dateOfSession"/>').dataTable({
             // "scrollX": true,                
             "iDisplayLength": 25,
             "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
             "order": []
             });
             });*/

            $jQuery2(function() {
                $jQuery2('#schedule_<s:property value="dateOfSession"/>').dataTable({
                "iDisplayLength": 25,
                        "aLengthMenu": [[25, 50, 100, - 1], [25, 50, 100, "All"]],
                        "order": []
            });
            });
                    function getAllDetails1(val) {
                        var size_1 = document.getElementById("size").value;
                        // reset all table to visible first
                        for (var i = 1; i <= size_1; i++) {
                            var element = document.getElementById("date_of_div_" + i).value;
                            document.getElementById(element).style.display = "inline";
                        }
                        if (val != -1) {
                            for (var i = 1; i <= size_1; i++) {
                                var element = document.getElementById("date_of_div_" + i).value;
                                if (element != val) {
                                    document.getElementById(element).style.display = "none";
                                }
                            }
                        }
                    }
        </script>
    </s:iterator> 
    <br/>
    <s:set var="colspan4" value="(sheet[0].totalSessions)"/>
    <s:set var="rc_id" value="(sheet[0].rcid)"/>
    <s:set var="rc_name" value="(sheet[0].participantDetail.remoteCenter.remoteCenterName)"/>
    <s:set var="rc_city" value="(sheet[0].participantDetail.remoteCenter.rc_city)"/>
    <%int colspan_td = 0;
        String rc_id1 = "";
        String rc_name1 = "", rc_city1 = "";
        try {
            colspan_td = Integer.parseInt((request.getAttribute("colspan4")).toString()) + 6;
            rc_id1 = (String) request.getAttribute("rc_id");
            rc_name1 = (String) request.getAttribute("rc_name");
            rc_city1 = (String) request.getAttribute("rc_city");
        } catch (Exception e) {
        }

    %>
    <div id="dvData" style="display: none;">
        <table id="testTable" summary="Code page support in different versions of MS Windows." rules="groups" frame="hsides" border="2">
            <thead id = "headers">
                <tr><td colspan="<%=colspan_td%>" style="text-align:center; font-size: 15px;"><b>Attendance Details for <%= rc_id1%>--<%=rc_name1%>, <%=rc_city1%></b></td></tr>
                <tr>                    
                    <td colspan="3" style="border-right:2px solid black; font-size: 13px;"><b>Participant Info</b></td>
                    <s:iterator value="schedule1">    
                        <s:set var="no_of_session1" value="%{numberOfSessions}"/>
                        <% String no_of_sessions5 = (String) (request.getAttribute("no_of_session1"));%>
                        <td style="border-right:2px solid black; font-size: 13px;" colspan="<%=no_of_sessions5%>"><b><s:property value="date_string"/></b></td> 
                            </s:iterator> 
                    <td colspan="2" style="font-size: 13px;"> <b>Summary</b></td>    
                </tr> 
                <tr>
                    <td style="font-size: 12px;"><b>P ID</b></td>
                    <td style="font-size: 12px;"><b>Name</b></td>
                    <td style="font-size: 12px;"><b>P email</b></td>
                    <s:iterator value="schedule1"> 
                        <s:set var="no_of_session" value="%{numberOfSessions}"/>
                        <% String no_of_sessions_5 = (String) (request.getAttribute("no_of_session"));
                            for (int i = 1; i <= Integer.parseInt(no_of_sessions_5); i++) {
                        %>
                        <td style="font-size: 12px;"><b>S <%=i%></b></td> 
                        <% }%>
                    </s:iterator> 
                    <td style="font-size: 12px;"><b>Total sessions attended</b></td>
                    <td style="font-size: 12px;"><b>Total number of sessions</b></td>
                </tr>
            </thead>
            <tbody id="schedule1body">  
                <s:iterator value="sheet">
                    <tr>
                        <td><s:property value="participantid"/></td>
                        <td><s:property value="participantDetail.firstName"/> <s:property value="participantDetail.lastName"/></td>
                        <td><s:property value="participantDetail.email"/></td>
                        <s:iterator value="isPresent" status="itStatus">
                            <s:set var="ifPresent" value="isPresent[#itStatus.count-1]"/>                        
                            <s:if test="%{isPresent[#itStatus.count-1] == 'Yes'}">
                                <td>P</td>
                            </s:if>
                            <s:else>
                                <td>A</td>
                            </s:else>
                        </s:iterator>
                        <td><s:property value="sessionAttended"/></td> 
                        <td><s:property value="totalSessions"/></td>
                    </tr>
                </s:iterator>
            </tbody>
        </table>
    </div>
    <%-- new code--%>
    <div style="">
        <table id="consolidated1" class="display1" style="display: none;">

        </table>
    </div>
    <%-- end here --%>
    <script>
        $("#btnExport").click(function(e) {
            window.open('data:application/vnd.ms-excel,' + $('#dvData').html());
            e.preventDefault();
        });
                </script>
    <script>
                var tableToExcel = (function() {
                        var uri = 'data:application/vnd.ms-excel;base64,'
                , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
                        , base64 = function(s) {
                        return window.btoa(unescape(encodeURIComponent(s)))
              }
   , format = function(s, c) {
                return s.replace(/{(\w+)}/g, function(m, p) {
                    return c[p];
                })
            }
            return function(table, name) {
                if (!table.nodeType)
                    table = document.getElementById(table)
                var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
                ctx.readonly="true";
                window.location.href = uri + base64(format(template, ctx))
            }
        })()
    </script>
    <script>
                                function AllRcWiseAttendace(workshopid){
                                var date = document.getElementById("dateSelect").value;
                                        if (date == - 1){
                                alert('please select the date');
                                } else{
                                fetchAllRcWiseAttendance(workshopid, 'all', date)
                                }
                                }

                        function fetchAllRcWiseAttendance(workshopid, rcid, date) {
                        var data = "workshopid=" + workshopid + "&rcid=" + rcid + "&date=" + date;
                                $.ajax({
                                url: "pages/DAOgetAllRcWiseAttendace.jsp",
                                        type: "GET",
                                        data: data,
                                        dataType: "json",
                                        success: setAllRcWiseAttendance,
                                        error: onError
                                });
                        }

                        function onError(jqXHR, textStatus) {
                        alert("Error : " + textStatus);
                        }

                        function setAllRcWiseAttendance(data){
                        $('#consolidated1').html("");
                                var noOfSessions = data[0].numberOfSessions;
                                var head_colspan = noOfSessions + 7;
                                var thead = "<thead><tr><td colspan=\"" + head_colspan + "\"><b>Attendance Sheet For the Day : " + data[0].date_string + "</b></td></tr>"
                                thead += "<tr>"
                                + "<td colspan=\"2\" ><b> Remote Center  Info </b></td>"
                                + "<td colspan=\"3\" ><b> Participant Info </b></td>"
                                + "<td colspan=\"" + noOfSessions + "\" ><b> sessions </b></td>"
                                + "<td colspan=\"2\" ><b> Summary </b></td>"
                                + "</tr>"
                                thead += "<tr>"
                                + "<td><b>RCID</b></td>"
                                + "<td><b>RC NAME</b></td>"
                                + "<td><b>Participant ID</b></td>"
                                + "<td><b>NAME</b></td>"
                                + "<td><b>Email</b></td>"
                                for (var j = 1; j <= noOfSessions; j++){
                        thead += "<td><b>" + (j) + "</b></td>"
                        }
                        thead += "<td><b>Total sessions attended</b></td>"
                                + "<td><b>Total number of sessions</b></td>"
                                thead += "</tr></thead>";
                                thead += "<tbody>"
                                var tr = "";
                                var as = data[0].as;
                                for (var i = 0; i < as.length; i++) {
                        tr += "<tr>"
                                + "<td>" + as[i].participantDetail.remoteCenter["remoteCenterId"] + "</td>"
                                + "<td>" + as[i].participantDetail.remoteCenter["remoteCenterName"] + "</td>"
                                + "<td>" + as[i].participantid + "</td>"
                                + "<td>" + as[i].participantDetail["firstName"] + "  " + as[i].participantDetail["lastName"] + "</td>"
                                + "<td>" + as[i].participantDetail["email"] + "</td>"
                                for (var k = 0; k < noOfSessions; k++){
                        if (as[i].isPresent[k] == "Yes"){
                        tr += "<td>P</td>"
                        } else{
                        tr += "<td>A</td>"
                        }
                        }
                        tr += "<td>" + as[i].sessionAttended + "</td>"
                                + "<td>" + noOfSessions + "</td>"
                                tr += "</tr>";
                        }
                        var tbodyend = "</tbody>"
                                $("#consolidated1").append(thead);
                                $("#consolidated1").append(tr);
                                $("#consolidated1").append(tbodyend);
                                tableToExcel('consolidated1', 'test');
                        }
    </script>
    <script>
                        function exportExcelChange(value){
                        if (value == - 1){
                        alert('please select any option')
                        } else if (value == 'consolidate'){
                        tableToExcel('testTable', 'W3C Example Table');
                        } else if (value == 'allrcwise'){
                        var wid = document.getElementById("workshopid").value
                                AllRcWiseAttendace(wid);
                        }
                        }

                        function dateSelectForRcWise(val){
                        var exptoexcl = document.getElementById("exportSelect").value;
                                if (val != - 1){
                        if (exptoexcl == 'allrcwise'){
                        var wid = document.getElementById("workshopid").value
                                AllRcWiseAttendace(wid);
                        }
                        }
                        }
    </script>
</s:iterator>
