<%-- 
    Document   : workshopParticipantSummary
    Created on : 21 Apr, 2015, 3:30:07 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script language="JavaScript" src="js/jquery.tipTip.minified.js"></script>       

<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script src="js/datepicker-jquery-ui.js"></script>
<link rel="stylesheet" href="css/datepicker-jquery-ui.css">

<script>
    $(function () {
    $("#datepicker1").datepicker({dateFormat: 'dd-mm-yy'});
    $("#datepicker2").datepicker({dateFormat: 'dd-mm-yy'});
    });</script>
<!DOCTYPE html>
<style>
    .summary h3 {
        /**background-color: #e0981a;**/
        background: #f6e6b4; /* Old browsers */
        background: -moz-linear-gradient(top, #f6e6b4 0%, #ed9017 84%); /* FF3.6+ */
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f6e6b4), color-stop(84%,#ed9017)); /* Chrome,Safari4+ */
        background: -webkit-linear-gradient(top, #f6e6b4 0%,#ed9017 84%); /* Chrome10+,Safari5.1+ */
        background: -o-linear-gradient(top, #f6e6b4 0%,#ed9017 84%); /* Opera 11.10+ */
        background: -ms-linear-gradient(top, #f6e6b4 0%,#ed9017 84%); /* IE10+ */
        background: linear-gradient(to bottom, #f6e6b4 0%,#ed9017 84%); /* W3C */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f6e6b4', endColorstr='#ed9017',GradientType=0 ); /* IE6-9 */
        border : 2px solid #fda968;
        border-radius: 10px;
        width : 100%;
        font-style: normal;
        font-family: fantasy;
        padding-left: 12px;
        padding-bottom: 2px;
        /*width : 740px;*/


    }
</style>
<%
    String start_date = request.getParameter("sd");
    String end_date = request.getParameter("ed");
    if (start_date.equals(null) || start_date.equals("none")) {
        start_date = "";
    }
    if (end_date.equals(null) || end_date.equals("none")) {
        end_date = "";
    }
%>
<script>
    $(function () {
    document.getElementById("datepicker1").value = "<%=start_date%>";
    document.getElementById("datepicker2").value = "<%=end_date%>";
    });</script>
<body>
    <s:if test='%{#session.loggedInUser.roleId > 1}'>
        <div  style="padding: 5px;" class="summary">
            <div style="padding-left: 15px; padding-right: 15px; text-align: center;"><h3 id="heading_name">Workshop Diversity Report </h3></div>

            <div style="text-align: center; margin-top:  0px;">

                <p><span style="font-size: 15px;">Group By Criteria :</span>
                    <select id="groupbycr" class="displayselect" onchange="onParticipantCriteriaChange(this.value)">
                        <option value="-1">-- select the type--</option>
                        <option  value="gender">Gender-Wise</option>
                        <option  value="experience">Experience-Wise</option>
                        <option  value="qualification">Qualification-Wise</option>
                        <!--<option  value="state_city">State-City-Wise</option>-->
                        <option  value="geographical">Geographical-Wise</option>
                        <option  value="all">All</option>
                    </select>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size: 15px;">Start Year(MM/dd/YYYY):<sup><img src="images/star.png"></sup></span>
                    <!--<select id="startyear" name="">
                        <option value="-1">Select Date</option>
                    </select>-->
                    <input type="date" style="width: 100px; background: white; border: none;"  id="datepicker1" name="content.startdatereg" onblur="">
                    &nbsp;&nbsp;
                    <span style="font-size: 15px;">End Year(MM/dd/YYYY) :<sup><img src="images/star.png"></sup></span>
                    <input type="text" style="width: 100px; background: white; border: none;"  id="datepicker2" name="content.startdatereg" onblur="">
                    <!--<select id="endyear" name="">
                        <option value="-1">Select Date</option>
                    </select>-->
                    &nbsp;&nbsp;
                    <input id="sbutton"  type="button" value="search" onclick="callForDate()/*serach_yearwies1()*/"/>

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <!--Export Excel <a onclick="create_ParticipantSummaryReport();" style="position:relative;left:20px;top:10px;" title="Export to Excel"><img src="images/savexls.png"/></a>-->   
                <div style="padding-left: 20px;">Export Excel <a class="btn btn-success" id="btnExport"><img src="images/savexls.png"/></a></div><br><br>

                </p>
            </div>
            <!-- <h4 style="color: black;"> <b>Click on the image to export details of the Participant Summary Report</b> 
                     <a onclick="create_ParticipantSummaryReport();" style="position:relative;left:20px;top:10px;" title="Export to Excel"><img src="images/savexls.png"/></a>
                 </h4>-->
            <div id="typeall" style="overflow: scroll; overflow-y: hidden;">
                <table id="mytable" class="display1">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th colspan="2" style="text-align: center;  background: #E8E8E8;"></th>
                            <th colspan="4" style="text-align: center;  background: #E0E0E0; font-size: 15px;">Geographical Diversity</th>
                            <th colspan="3" style="text-align: center;  background: #D8D8D8; font-size: 15px;">Gender</th>
                            <th colspan="4" style="text-align: center;  background: #D0D0D0; font-size: 15px;">Experience (in years)</th>
                            <th colspan="5" style="text-align: center;  background: #C8C8C8; font-size: 15px;">Qualification</th>
                            <th colspan="2" style="text-align: center;  background: #C0C0C0;"></th>
                        </tr>
                        <tr>
                            <td style="display: none;">S No</td>
                            <th id="wid" style="background: #E8E8E8;">Workshop ID</th>
                            <th style=" background: #E8E8E8;">Workshop Name</th>
                            <th style="text-align: center;  background: #E0E0E0; ">No of Remote Center</th>
                            <th style="text-align: center;  background: #E0E0E0;">No of Inst itute </th>
                            <th style="text-align: center;  background: #E0E0E0;">City</th>
                            <th style="text-align: center;  background: #E0E0E0;">State</th>
                            <th style="text-align: center;  background: #D8D8D8;">M</th>
                            <th style="text-align: center;  background: #D8D8D8;">F</th>
                            <th style="text-align: center;  background: #D8D8D8;">other </th>
                            <th style="text-align: center;  background: #D0D0D0;">< 2</th>
                            <th style="text-align: center;  background: #D0D0D0;">2-10</th>
                            <th style="text-align: center;  background: #D0D0D0;">>10</th>
                            <th style="text-align: center;  background: #D0D0D0;">Unk nown </th>
                            <th style="text-align: center;  background: #C8C8C8;">Doc torate</th>
                            <th style="text-align: center;  background: #C8C8C8;">Post grad.</th>
                            <th style="text-align: center;  background: #C8C8C8;">Grad.</th>
                            <th style="text-align: center;  background: #C8C8C8;">Dip.</th>
                            <th style="text-align: center;  background: #C8C8C8;">Other</th>
                            <th style="text-align: center;  background: #C0C0C0;">Total Partici pants</th>
                        </tr>
                    </thead>
                    <tbody id="mytablebody" name="tablebody">
                        <s:iterator value="summary">
                            <tr id="session_">
                                <td style="display: none;">S No</td>
                                <td style=" background: #E8E8E8;"><s:property value="workshopid"/></td>
                                <td style=" background: #E8E8E8;"><s:property value="workshopname"/></td>
                                <td style="text-align: center;  background: #E0E0E0;"><s:property value="rcid"/></td>
                                <td style="text-align: center;  background: #E0E0E0;"><s:property value="instituteid"/></td>
                                <td style="text-align: center;  background: #E0E0E0;"><s:property value="city"/></td>
                                <td style="text-align: center;  background: #E0E0E0;"><s:property value="state"/></td>
                                <td style="text-align: center;  background: #D8D8D8;"><s:property value="male"/></td>
                                <td style="text-align: center;  background: #D8D8D8;"><s:property value="female"/></td>
                                <td style="text-align: center;  background: #D8D8D8;"><s:property value="other_gender"/></td>
                                <td style="text-align: center;  background: #D0D0D0;"><s:property value="experience_lessthan2"/></td>
                                <td style="text-align: center;  background: #D0D0D0;"><s:property value="experience_2to10"/></td>
                                <td style="text-align: center;  background: #D0D0D0;"><s:property value="experience_greaterthan10"/></td>
                                <td style="text-align: center;  background: #D0D0D0;"><s:property value="unknown_experience"/></td>
                                <td style="text-align: center;  background: #C8C8C8;"><s:property value="doctorate"/></td>
                                <td style="text-align: center;  background: #C8C8C8;"><s:property value="postgraduate"/></td>
                                <td style="text-align: center;  background: #C8C8C8;"><s:property value="graduate"/></td>
                                <td style="text-align: center;  background: #C8C8C8;"><s:property value="diploma"/></td>
                                <td style="text-align: center;  background: #C8C8C8;"><s:property value="others"/></td>
                                <td style="text-align: center;  background: #C0C0C0;"><s:property value="total"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table><br><p></p><br>
            </div>
            <div id="typegender" style="overflow: scroll; overflow-y: hidden; display: none;">
                <table id="mytable1" class="display1" style="word-spacing: normal;width:770px;margin-left: 20%;" cellspacing="0" align="center">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th style="display: none;">S No</th>
                            <th id="wid">Workshop ID</th>
                            <th>Workshop Name</th>
                            <th style="text-align: center;">Male</th>
                            <th style="text-align: center;">Female</th>
                            <th style="text-align: center;">Other</th>
                            <th style="text-align: center;">Total Participants</th>
                        </tr>
                    </thead>
                    <tbody id="mytable1" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td style="display: none;">S No</td>
                                <td><s:property value="workshopid"/></td>
                                <td><s:property value="workshopname"/></td>
                                <td style="text-align: center;"><s:property value="male"/></td>
                                <td style="text-align: center;"><s:property value="female"/></td>
                                <td style="text-align: center;"><s:property value="other_gender"/></td>
                                <td style="text-align: center;"><s:property value="total"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table><br><p></p><br>
            </div>
            <div id="typeexperience" style="overflow: scroll; overflow-y: hidden; display: none;">
                <table id="mytable2" class="display1" style="word-spacing: normal;width:770px;margin-left: 20%;" cellspacing="0" align="center">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th style="display: none;">S No</th>
                            <th id="wid">Workshop ID</th>
                            <th>Workshop Name</th>
                            <th style="text-align: center;">Less Than 2</th>
                            <th style="text-align: center;">2 to 10</th>
                            <th style="text-align: center;">Greater than 10</th>
                            <th style="text-align: center;">Unknown </th>
                            <th style="text-align: center;">Total Participants</th>
                        </tr>
                    </thead>
                    <tbody id="mytable2" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td style="display: none;">S No</td>
                                <td><s:property value="workshopid"/></td>
                                <td><s:property value="workshopname"/></td>
                                <td style="text-align: center;"><s:property value="experience_lessthan2"/></td>
                                <td style="text-align: center;"><s:property value="experience_2to10"/></td>
                                <td style="text-align: center;"><s:property value="experience_greaterthan10"/></td>
                                <td style="text-align: center;"><s:property value="unknown_experience"/></td>
                                <td style="text-align: center;"><s:property value="total"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table><br><p></p><br>
            </div>
            <div id="typequalification" style="overflow: scroll; overflow-y: hidden; display: none;">
                <table id="mytable3" class="display1" style="word-spacing: normal;width:770px;margin-left: 20%;" cellspacing="0" align="center">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th style="display: none;">S No</th>
                            <th id="wid">Workshop ID</th>
                            <th>Workshop Name</th>
                            <th style="text-align: center;">Doctorate</th>
                            <th style="text-align: center;">Postgraduate</th>
                            <th style="text-align: center;">Graduate</th>
                            <th style="text-align: center;">Diploma</th>
                            <th style="text-align: center;">Others</th>
                            <th style="text-align: center;">Total Participants</th>
                        </tr>
                    </thead>
                    <tbody id="mytable3" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td style="display: none;">S No</td>
                                <td><s:property value="workshopid"/></td>
                                <td><s:property value="workshopname"/></td>
                                <td style="text-align: center;"><s:property value="doctorate"/></td>
                                <td style="text-align: center;"><s:property value="postgraduate"/></td>
                                <td style="text-align: center;"><s:property value="graduate"/></td>
                                <td style="text-align: center;"><s:property value="diploma"/></td>
                                <td style="text-align: center;"><s:property value="others"/></td>
                                <td style="text-align: center;"><s:property value="total"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table><br><p></p><br>
            </div>
            <div id="typestatecity" style="overflow: scroll; overflow-y: hidden; display: none;">
                <table id="mytable4" class="display1" style="word-spacing: normal;width:770px;margin-left: 20%;" cellspacing="0" align="center">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th style="display: none;">S No</th>
                            <th id="wid">Workshop ID</th>
                            <th>Workshop Name</th>
                            <th style="text-align: center;">City</th>
                            <th style="text-align: center;">State</th>
                        </tr>
                    </thead>
                    <tbody id="mytable4" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td style="display: none;">S No</td>
                                <td><s:property value="workshopid"/></td>
                                <td><s:property value="workshopname"/></td>
                                <td style="text-align: center;"><s:property value="city"/></td>
                                <td style="text-align: center;"><s:property value="state"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table><br><p></p><br>
            </div>
            <div id="typegeographical" style="overflow: scroll; overflow-y: hidden; display: none;">
                <table id="mytable5" class="display1" style="word-spacing: normal;width:770px;margin-left: 20%;" cellspacing="0" align="center">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th style="display: none;">S No</th>
                            <th id="wid">Workshop ID</th>
                            <th>Workshop Name</th>
                            <th style="text-align: center;">No of Remote Center</th>
                            <th style="text-align: center;">No of Institute </th>
                            <th style="text-align: center;">No of City</th>
                            <th style="text-align: center;">No of State</th>
                            <th style="text-align: center;">Total Participants</th>
                        </tr>
                    </thead>
                    <tbody id="mytable5" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td style="display: none;">S No</td>
                                <td><s:property value="workshopid"/></td>
                                <td><s:property value="workshopname"/></td>
                                <td style="text-align: center;"><s:property value="rcid"/></td>
                                <td style="text-align: center;"><s:property value="instituteid"/></td>
                                <td style="text-align: center;"><s:property value="city"/></td>
                                <td style="text-align: center;"><s:property value="state"/></td>
                                <td style="text-align: center;"><s:property value="total"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table><br><p></p><br>
            </div><br><br>
        </div>
        <div style="display:none">             
            <table id="all_list" >
                <thead id="tablehead" name="tablehead">
                    <tr>
                        <th colspan="2" style="text-align: center;  background: #E8E8E8;"></th>
                        <th colspan="4" style="text-align: center;  background: #E0E0E0; font-size: 15px;">Geographical Diversity</th>
                        <th colspan="3" style="text-align: center;  background: #D8D8D8; font-size: 15px;">Gender</th>
                        <th colspan="4" style="text-align: center;  background: #D0D0D0; font-size: 15px;">Experience (in years)</th>
                        <th colspan="5" style="text-align: center;  background: #C8C8C8; font-size: 15px;">Qualification</th>
                        <th colspan="2" ></th>
                    </tr>
                    <tr>
                        <!--<td >S No</td>-->
                        <th  style="background: #E8E8E8;">Workshop ID</th>
                        <th >Workshop Name</th>
                        <th style="text-align: center;  background: #E0E0E0; ">No of Remote Center</th>
                        <th >No of Inst itute </th>
                        <th >City</th>
                        <th >State</th>
                        <th >M</th>
                        <th >F</th>
                        <th >other </th>
                        <th >< 2</th>
                        <th >2-10</th>
                        <th >>10</th>
                        <th >Unk nown </th>
                        <th >Doc torate</th>
                        <th >Post grad.</th>
                        <th >Grad.</th>
                        <th >Dip.</th>
                        <th >Other</th>
                        <th >Total Partici pants</th>
                    </tr>
                </thead>
                <tbody>
                    <s:iterator value="summary">
                        <tr id="session_">
                            <!--<td >S No</td>-->
                            <td ><s:property value="workshopid"/></td>
                            <td ><s:property value="workshopname"/></td>
                            <td ><s:property value="rcid"/></td>
                            <td ><s:property value="instituteid"/></td>
                            <td ><s:property value="city"/></td>
                            <td ><s:property value="state"/></td>
                            <td ><s:property value="male"/></td>
                            <td ><s:property value="female"/></td>
                            <td ><s:property value="other_gender"/></td>
                            <td ><s:property value="experience_lessthan2"/></td>
                            <td ><s:property value="experience_2to10"/></td>
                            <td ><s:property value="experience_greaterthan10"/></td>
                            <td ><s:property value="unknown_experience"/></td>
                            <td ><s:property value="doctorate"/></td>
                            <td ><s:property value="postgraduate"/></td>
                            <td ><s:property value="graduate"/></td>
                            <td ><s:property value="diploma"/></td>
                            <td ><s:property value="others"/></td>
                            <td ><s:property value="total"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table><br><p></p><br>
            <table id="gender_list">
                <thead >
                    <tr>
                        <!--<th >S No</th>-->
                        <th >Workshop ID</th>
                        <th>Workshop Name</th>
                        <th >Male</th>
                        <th >Female</th>
                        <th >Other</th>
                        <th >Total Participants</th>
                    </tr>
                </thead>
                <tbody>
                    <s:iterator value="summary">
                        <tr>
                            <!--<td >S No</td>-->
                            <td><s:property value="workshopid"/></td>
                            <td><s:property value="workshopname"/></td>
                            <td ><s:property value="male"/></td>
                            <td ><s:property value="female"/></td>
                            <td ><s:property value="other_gender"/></td>
                            <td ><s:property value="total"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>
            <table id="exp_list" >
                <thead>
                    <tr>
                        <!--<th >S No</th>-->
                        <th >Workshop ID</th>
                        <th>Workshop Name</th>
                        <th >Less Than 2</th>
                        <th >2 to 10</th>
                        <th >Greater than 10</th>
                        <th >Unknown </th>
                        <th >Total Participants</th>
                    </tr>
                </thead>
                <tbody >
                    <s:iterator value="summary">
                        <tr>
                            <!--<td >S No</td>-->
                            <td><s:property value="workshopid"/></td>
                            <td><s:property value="workshopname"/></td>
                            <td ><s:property value="experience_lessthan2"/></td>
                            <td ><s:property value="experience_2to10"/></td>
                            <td ><s:property value="experience_greaterthan10"/></td>
                            <td ><s:property value="unknown_experience"/></td>
                            <td ><s:property value="total"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>
            <table id="qualification_list">
                <thead >
                    <tr>
                        <!--<th >S No</th>-->
                        <th >Workshop ID</th>
                        <th>Workshop Name</th>
                        <th >Doctorate</th>
                        <th >Postgraduate</th>
                        <th >Graduate</th>
                        <th >Diploma</th>
                        <th >Others</th>
                        <th >Total Participants</th>
                    </tr>
                </thead>
                <tbody >
                    <s:iterator value="summary">
                        <tr>
                            <!--<td >S No</td>-->
                            <td><s:property value="workshopid"/></td>
                            <td><s:property value="workshopname"/></td>
                            <td ><s:property value="doctorate"/></td>
                            <td ><s:property value="postgraduate"/></td>
                            <td ><s:property value="graduate"/></td>
                            <td ><s:property value="diploma"/></td>
                            <td ><s:property value="others"/></td>
                            <td ><s:property value="total"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table><br><p></p><br>
            <table id="city_list" >
                <thead >
                    <tr>
                        <!--<th >S No</th>-->
                        <th >Workshop ID</th>
                        <th>Workshop Name</th>
                        <th >City</th>
                        <th >State</th>
                    </tr>
                </thead>
                <tbody >
                    <s:iterator value="summary">
                        <tr>
                            <!--<td >S No</td>-->
                            <td><s:property value="workshopid"/></td>
                            <td><s:property value="workshopname"/></td>
                            <td ><s:property value="city"/></td>
                            <td ><s:property value="state"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table><br><p></p><br>
            <table id="geo_list" >
                <thead >
                    <tr>
                        <!--<th >S No</th>-->
                        <th >Workshop ID</th>
                        <th>Workshop Name</th>
                        <th >No of Remote Center</th>
                        <th >No of Institute </th>
                        <th >No of City</th>
                        <th >No of State</th>
                        <th >Total Participants</th>
                    </tr>
                </thead>
                <tbody >
                    <s:iterator value="summary">
                        <tr>
                            <!--<td >S No</td>-->
                            <td><s:property value="workshopid"/></td>
                            <td><s:property value="workshopname"/></td>
                            <td ><s:property value="rcid"/></td>
                            <td ><s:property value="instituteid"/></td>
                            <td ><s:property value="city"/></td>
                            <td ><s:property value="state"/></td>
                            <td ><s:property value="total"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>
        </div>
    </s:if>
    <script type="text/javascript">
        $(document).ready(function () {
        $('.display1').dataTable({
        // "scrollX": true,                
        "iDisplayLength": 25,
                "aLengthMenu": [[25, 50, 100, - 1], [25, 50, 100, "All"]],
                "order": []
        });
        });
    </script>
    <script>
        function serach_yearwies1() {
        var ndate = document.getElementById("datepicker1").value;
        var ndate2 = document.getElementById("datepicker2").value;
        if (!(ndate == "" || ndate2 == "")) {
        var dt = new Date(ndate);
        var dtend = new Date(ndate2);
        var Tab;
        var selectVal = document.getElementById("groupbycr").value;
        if (selectVal == 'all' || selectVal == '-1') {
        Tab = document.getElementById("mytablebody");
        } else {
        // Tab = document.getElementById("mytablebody");
        }
        var size1 = Tab.rows.length;
        var j = 0;
        for (var i = 0; i < size1; i++) {
        j++;
        var id1 = "session_" + j;
        var session_no =
                Tab.rows[i].cells[2].innerHTML;
        var enddate = Tab.rows[i].cells[3].innerHTML;
        /* var sdate=Date(session_no).toDateString();*/

        var res1 = session_no.split(" ");
        var dt2 = new Date(session_no)
                if (!((dt2 >= dt) && (dt2 <= dtend))) {
        Tab.rows[i].style.display = "none";
        } else {
        Tab.rows[i].style.display = "";
        }

        var startyr = 2013;
        var endyr = 2015;
        }
        } else {
        var Tab;
        /*var selectVal = document.getElementById("groupbycr").value;
         if (selectVal == 'summary') {
         Tab = document.getElementById("mytablebody1");
         } else {
         Tab = document.getElementById("mytablebody");
         }
         var size1 = Tab.rows.length;
         for (var i = 0; i < size1; i++) {
         Tab.rows[i].style.display = "";
         }*/
        }

        }

    </script>
    <script>
        function callForDate() {
        var start_date = document.getElementById("datepicker1").value;
        var end_date = document.getElementById("datepicker2").value;
//            if (start_date != '' || end_date != '') {
        window.open("workshopSummary.html?sd=" + start_date + "&ed=" + end_date + "", "_self");
//            }
        //$("#datepicker1").datepicker("hide");
        }
        $(document).ready(function () {
        $("#settingoptions").hide();
        $("#showmore").click(function (e) {
        var x = e.pageX;
        var tmpx = x - 200;
        $("#settingoptions").css({left: tmpx});
        $("#settingoptions").slideToggle();
        });
        });
    </script>  
    <script>
        // on click of export excel button           
        $("#btnExport").click(function (e) {
        var valhidden = document.getElementById("groupbycr").value.trim();
        if (valhidden != '' && valhidden != null && valhidden != '-1') {
        if (valhidden == 'gender') {
        var fileName = 'GenderWorkshopSummary';
        var blobURL = tableToExcel('gender_list', 'test_table');
        $(this).attr('download', fileName + '.xls');
        $(this).attr('href', blobURL);
        }
        if (valhidden == 'experience') {
        var fileName = 'ExperienceWorkshopSummary';
        var blobURL = tableToExcel('exp_list', 'test_table');
        $(this).attr('download', fileName + '.xls');
        $(this).attr('href', blobURL);
        }
        if (valhidden == 'qualification') {
        var fileName = 'QualificationWorkshopSummary';
        var blobURL = tableToExcel('qualification_list', 'test_table');
        $(this).attr('download', fileName + '.xls');
        $(this).attr('href', blobURL);
        }
        if (valhidden == 'geographical') {
        var fileName = 'GeographicalWorkshopSummary';
        var blobURL = tableToExcel('geo_list', 'test_table');
        $(this).attr('download', fileName + '.xls');
        $(this).attr('href', blobURL);
        }
        if (valhidden == 'all') {
        var fileName = 'AllWorkshopSummary';
        var blobURL = tableToExcel('all_list', 'test_table');
        $(this).attr('download', fileName + '.xls');
        $(this).attr('href', blobURL);
        }
        } else {
        alert("Select the criteria");
        }
        });
        // export to excel code
                </script>
    <script>
                var tableToExcel = (function() {
                        var uri = 'data:application/vnd.ms-excel;base64;filename=exportData.xlsx,'
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
         var blob = new Blob([format(template, ctx)]);
         var blobURL = window.URL.createObjectURL(blob);
         return blobURL;
         // window.location.href = uri + base64(format(template, ctx))
     }
 })()
    </script>
</body>
