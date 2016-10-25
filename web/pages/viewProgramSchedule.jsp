<%-- 
    Document   : viewProgramSchedule
    Created on : 2 Jul, 2015, 4:18:57 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<!--<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>

<div class="form_enclosure">
    <s:iterator value="workshopContent">
        <h1><s:property value="workshopname" /></h1>
        <h4 align="center"><s:property value="sponsor"/></h4>
        <br/>
        <s:if test="dateToBeDisplayed == 1">
        <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   
        </s:if><s:else></s:else>
    </s:iterator>
</div>

<br/>
<s:if test='%{schtest.size != 0}'>
    <table class="content_container"><tr><td style="text-align:center"><p style="color: #003366;width:750px;font-size: 120%"><b>Programme Schedule</b></p></td></tr></table>
    <p><b>click <a href="<s:property value="schedule_path"/>">here</a> to download/print the programme schedule</b></p>

    <table class="display1" id="dispatchdetail1"  cellpadding="0" cellspacing="0" style="font-size: 90%;width:770px;">
        <thead> 
            <tr>
                <th style="text-align:center;display:none;border-bottom:2.5px solid #F1BA63;border-right:2.5px solid #F1BA63 ">S No</th>           
                <th style="text-align:center;border-bottom:2.5px solid #F1BA63;;border-right:2.5px solid #F1BA63">Date</th>            
                <th style="text-align:center;border-bottom:2.5px solid #F1BA63;;border-right:2.5px solid #F1BA63">Time Slot</th>
                <th style="text-align:center;border-bottom:2.5px solid #F1BA63;">Topic</th> 

            </tr>
        </thead>
        <tbody align="center" >
            <s:iterator value="schtest" status="itStatus">
                <s:set value="dateOfSession" var="schtest_date"/>
                <s:set value="numberOfSessions" var="noOfSessions_var"/>
                <s:set value="1" var="temp"/>
                <s:iterator value="schedule" status="itStatus2">           
                    <s:if test='%{#schtest_date == dateOfSession}'>                
                        <tr class="gradeU">                         
                            <td rowspan="1" style="display:none;"><s:property value="#itStatus2.count" /></td>               
                            <s:if test='%{#temp == 1}'>
                                <td style="vertical-align: center;text-align: center;border-bottom:2.5px solid #F1BA63;border-right:2.5px solid #F1BA63; border-top:1px solid #F1BA63" rowspan="<s:property value="noOfSessions_var"/>"><s:property value="date_string"/> </td>
                                <s:set var="temp" value="%{#temp+1}"/>
                            </s:if>
                            <s:else><s:set var="temp" value="%{#temp+1}"/>
                            </s:else>
                            <s:set var="sessions_no" value="#noOfSessions_var"/>
                            <s:set var="temp_no" value="#temp"/> 
                            <s:if test='%{(#temp_no-1) == #sessions_no}'>
                                <td style="text-align:center;border-bottom:2.5px solid #F1BA63;border-right:1px solid #F1BA63; border-top:1px solid #F1BA63" rowspan="1"><s:property value="time_from"/> - <s:property value="time_to"/></td>
                                <td style="white-space: pre-wrap;border-bottom:2.5px solid #F1BA63; border-top:1px solid #F1BA63" rowspan="1"><s:property value="comments"/></td>
                            </s:if>
                            <s:else>
                                <td style="text-align:center;border-right:1px solid #F1BA63; border-top:1px solid #F1BA63" rowspan="1"><s:property value="time_from"/> - <s:property value="time_to"/></td>
                                <td style="white-space: pre-wrap; border-top:1px solid #F1BA63" rowspan="1"><s:property value="comments"/></td>
                            </s:else>
                        </s:if>
                    </tr>
                </s:iterator>        
            </s:iterator>
        </tbody>    
    </table>
</s:if>
<s:else><p><b>There are no details to be displayed</b></p></s:else>
<%--Old table

<table class="display" id="dispatchdetail"  cellpadding="0" cellspacing="0" style="width:available;">
    <thead> 
        <tr>
            <th style="text-align:center;display:none;">S No</th>
            <th style="text-align:center;">Date</th>            
            <th style="text-align:center;">Time Slot</th>
            <th style="text-align:center;">Schedule / Topic</th>           
        </tr>
    </thead>
    <tbody align="center" >
        <s:iterator value="schedule" status="itStatus">
            <tr class="gradeU">
                <td style="display:none;"><s:property value="#itStatus.count" /></td>
                <td style="text-align:center;"><s:property value="date_string"/></td>
                <td style="text-align:center;"><s:property value="time_from"/> - <s:property value="time_to"/></td>
                <td style="white-space: pre-wrap;"><s:property value="comments"/></td>

            </tr>
        </s:iterator>
    </tbody>          
</table>
<script type="text/javascript">
    $(document).ready(function() {      
        if((<s:property value="schedule.size" />)>=20){var aves1=500;}
        else{var aves1=50+30*(<s:property value="schedule.size" />);}        
        $('#dispatchdetail').dataTable({           
            "sScrollY": aves1,
            "bJQueryUI": true,
            "bLengthChange": true,
            "sPaginationType": "full_numbers",
            "iDisplayStart": 0,
            "iDisplayLength": 50,
            "iScrollLoadGap": 50,
            "aLengthMenu": [[50, 100, 200, -1], [50, 100, 200, "All"]]
        });
    });
</script>  --%>


