<%-- 
    Document   : stateWiseSummary
    Created on : 3 Jun, 2015, 3:19:29 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" href="css/datepicker-jquery-ui.css">
<script src="js/datepicker-jquery-ui.js"></script>
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
    });
</script><script>
    $(function () {
        $("#datepicker1").datepicker({dateFormat: 'dd-mm-yy'});
        $("#datepicker2").datepicker({dateFormat: 'dd-mm-yy'});
    });

</script>

<body>
    <s:if test='%{#session.loggedInUser.roleId > 1}'>
        <div  style="padding: 5px;" class="summary">
            <div style="text-align: center; margin-top:  0px;">
                <div style="padding-left: 15px; padding-right: 15px; text-align: center;"><h3 id="heading_name">State Wise Summary Report</h3></div>
                <p><span style="font-size: 15px;">Group By Criteria :</span>
                    <select id="groupbycr" onchange="onStateCriteriaChange(this.value)">
                        <option value="-1">-- select the type--</option>
                        <option value="gender">Gender-Wise</option>
                        <option value="experience">Experience-Wise</option>
                        <option value="qualification">Qualification-Wise</option>
                        <!--<option value="geographical">Geographical-Wise</option>-->
                        <option value="all">All</option>
                    </select>

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size: 15px;">Start Year(MM/dd/YYYY):<sup><img src="images/star.png"></sup></span>
                    <!--<select id="startyear" name="">
                        <option value="-1">Select Date</option>
                    </select>-->
                    <input type="date" style="width: 100px; background: white; border: none;"  id="datepicker1" name="content.startdatereg"   >
                    &nbsp;&nbsp;
                    <span style="font-size: 15px;">End Year(MM/dd/YYYY) :<sup><img src="images/star.png"></sup></span>
                    <input type="text" style="width: 100px; background: white; border: none;"  id="datepicker2" name="content.startdatereg"  >
                    <!--<select id="endyear" name="">
                        <option value="-1">Select Date</option>
                    </select>-->
                    &nbsp;&nbsp;
                    <input id="sbutton"  type="button" value="search" onclick="callForDate()"/>

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <!--Export Excel <a onclick="create_StateSummaryReport();" style="position:relative;left:20px;top:10px;" title="Export to Excel"><img src="images/savexls.png"/></a>-->
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
                            <th colspan="1" style="text-align: center;  background: #E8E8E8;"></th>
                            <th colspan="4" style="text-align: center;  background: #E0E0E0; font-size: 15px;">Summary</th>
                            <th colspan="3" style="text-align: center;  background: #D8D8D8; font-size: 15px;">Gender</th>
                            <th colspan="4" style="text-align: center;  background: #D0D0D0; font-size: 15px;">Experience</th>
                            <th colspan="5" style="text-align: center;  background: #C8C8C8; font-size: 15px;">Qualification</th>
                            <!--<th colspan="2" style="text-align: center;  background: #C0C0C0;"></th>-->
                        </tr>
                        <tr>
                            <th id="wid" style="background: #E8E8E8;">State</th>
                            <th style="text-align: center;  background: #E0E0E0; ">No of Remote Center</th>
                            <th style="text-align: center;  background: #E0E0E0;">No of Workshops</th>
                            <th style="text-align: center;  background: #E0E0E0;">No of Institute </th>
                            <th style="text-align: center;  background: #E0E0E0;">No of Participants</th>
                            <th style="text-align: center;  background: #D8D8D8;">M</th>
                            <th style="text-align: center;  background: #D8D8D8;">F</th>
                            <th style="text-align: center;  background: #D8D8D8;">Other</th>
                            <th style="text-align: center;  background: #D0D0D0;">< 2</th>
                            <th style="text-align: center;  background: #D0D0D0;">2 - 10</th>
                            <th style="text-align: center;  background: #D0D0D0;"> > 10</th>
                            <th style="text-align: center;  background: #D0D0D0;">Unknown</th>
                            <th style="text-align: center;  background: #C8C8C8;">Doctorate</th>
                            <th style="text-align: center;  background: #C8C8C8;">Postgraduate</th>
                            <th style="text-align: center;  background: #C8C8C8;">Graduate</th>
                            <th style="text-align: center;  background: #C8C8C8;">Diploma</th>
                            <th style="text-align: center;  background: #C8C8C8;">Others</th>
                            <!--<th style="text-align: center;  background: #C0C0C0;">Total</th>-->
                        </tr>
                    </thead>
                    <tbody id="mytable" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td style=" background: #E8E8E8;"><s:property value="state"/></td>
                                <td style="text-align: center;  background: #E0E0E0;"><s:property value="rcid"/></td>
                                <td style="text-align: center;  background: #E0E0E0;"><s:property value="workshopid"/></td>
                                <td style="text-align: center;  background: #E0E0E0;"><s:property value="instituteid"/></td>
                                <td style="text-align: center;  background: #E0E0E0;"><s:property value="participantid"/></td>
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
                                <!--<td style="text-align: center;  background: #C0C0C0;"><s:property value="total"/></td>-->
                            </tr>
                        </s:iterator>
                    </tbody>
                </table><br><p></p><br>
            </div>
            <div id="typegender" style="overflow: scroll; overflow-y: hidden; display: none;width:auto;">
                <table id="mytable1" class="display1" style="word-spacing: normal;width:770px;margin-left: 20%;" cellspacing="0" align="center">
                    <thead id="tablehead" name="tablehead" >
                        <tr>
                            <th id="wid">State</th>
                            <th style="text-align: center;">Male</th>
                            <th style="text-align: center;">Female</th>
                            <th style="text-align: center;">Unknown Gender</th>
                            <th style="text-align: center;">Total</th>
                        </tr>
                    </thead>
                    <tbody id="mytable1" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td><s:property value="state"/></td>
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
                            <th id="wid">State</th>
                            <th style="text-align: center;">Experience Less Than 2</th>
                            <th style="text-align: center;">Experience in 2 to 10</th>
                            <th style="text-align: center;">Experience Greater than 10</th>
                            <th style="text-align: center;">Unknown Experience</th>
                            <th style="text-align: center;">Total</th>
                        </tr>
                    </thead>
                    <tbody id="mytable2" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td><s:property value="state"/></td>
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
                            <th id="wid">State</th>
                            <th style="text-align: center;">Doctorate</th>
                            <th style="text-align: center;">Postgraduate</th>
                            <th style="text-align: center;">Graduate</th>
                            <th style="text-align: center;">Diploma</th>
                            <th style="text-align: center;">Others</th>
                            <th style="text-align: center;">Total</th>
                        </tr>
                    </thead>
                    <tbody id="mytable3" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td><s:property value="state"/></td>
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
            <div id="typegeographical" style="overflow: scroll; overflow-y: hidden; display: none;">
                <table id="mytable5" class="table">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th id="wid">State</th>
                            <th style="text-align: center;">No of Remote Center</th>
                            <th style="text-align: center;">No of Workshops</th>
                            <th style="text-align: center;">No of Institute</th>
                            <th style="text-align: center;">No of Participants</th>
                        </tr>
                    </thead>
                    <tbody id="mytable5" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td><s:property value="state"/></td>
                                <td style="text-align: center;"><s:property value="rcid"/></td>
                                <td style="text-align: center;"><s:property value="workshopid"/></td>
                                <td style="text-align: center;"><s:property value="instituteid"/></td>
                                <td style="text-align: center;"><s:property value="participantid"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table><br><p></p><br>
            </div><br><br>
        </div>
        <div style="display:none"> 
            <table id="qualification_list" >
                <thead >
                    <tr>
                        <th >State</th>
                        <th >Doctorate</th>
                        <th >Postgraduate</th>
                        <th >Graduate</th>
                        <th >Diploma</th>
                        <th >Others</th>
                        <th >Total</th>
                    </tr>
                </thead>
                <tbody >
                    <s:iterator value="summary">
                        <tr>
                            <td><s:property value="state"/></td>
                            <td ><s:property value="doctorate"/></td>
                            <td ><s:property value="postgraduate"/></td>
                            <td ><s:property value="graduate"/></td>
                            <td ><s:property value="diploma"/></td>
                            <td ><s:property value="others"/></td>
                            <td ><s:property value="total"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
                <table id="exp_list" >
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th >State</th>
                            <th >Experience Less Than 2</th>
                            <th >Experience in 2 to 10</th>
                            <th >Experience Greater than 10</th>
                            <th >Unknown Experience</th>
                            <th >Total</th>
                        </tr>
                    </thead>
                    <tbody id="mytable2" name="tablebody">
                        <s:iterator value="summary">
                            <tr>
                                <td><s:property value="state"/></td>
                                <td ><s:property value="experience_lessthan2"/></td>
                                <td ><s:property value="experience_2to10"/></td>
                                <td ><s:property value="experience_greaterthan10"/></td>
                                <td ><s:property value="unknown_experience"/></td>
                                <td ><s:property value="total"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
                <table id="gender_list" >
                    <thead  >
                        <tr>
                            <th >State</th>
                            <th >Male</th>
                            <th >Female</th>
                            <th >Unknown Gender</th>
                            <th >Total</th>
                        </tr>
                    </thead>
                    <tbody >
                        <s:iterator value="summary">
                            <tr>
                                <td><s:property value="state"/></td>
                                <td ><s:property value="male"/></td>
                                <td ><s:property value="female"/></td>
                                <td ><s:property value="other_gender"/></td>
                                <td ><s:property value="total"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
                <table id="all_list" >
                    <thead >
                        <tr>
                            <th colspan="1" style="text-align: center;  background: #E8E8E8;"></th>
                            <th colspan="4" style="text-align: center;  background: #E0E0E0; font-size: 15px;">Summary</th>
                            <th colspan="3" style="text-align: center;  background: #D8D8D8; font-size: 15px;">Gender</th>
                            <th colspan="4" style="text-align: center;  background: #D0D0D0; font-size: 15px;">Experience</th>
                            <th colspan="5" style="text-align: center;  background: #C8C8C8; font-size: 15px;">Qualification</th>
                        </tr>
                        <tr>
                            <th  style="background: #E8E8E8;">State</th>
                            <th >No of Remote Center</th>
                            <th >No of Workshops</th>
                            <th >No of Institute </th>
                            <th >No of Participants</th>
                            <th >M</th>
                            <th >F</th>
                            <th >Other</th>
                            <th >< 2</th>
                            <th >2 - 10</th>
                            <th > > 10</th>
                            <th >Unknown</th>
                            <th >Doctorate</th>
                            <th >Postgraduate</th>
                            <th >Graduate</th>
                            <th >Diploma</th>
                            <th >Others</th>
                        </tr>
                    </thead>
                    <tbody >
                        <s:iterator value="summary">
                            <tr>
                                <td ><s:property value="state"/></td>
                                <td ><s:property value="rcid"/></td>
                                <td ><s:property value="workshopid"/></td>
                                <td ><s:property value="instituteid"/></td>
                                <td ><s:property value="participantid"/></td>
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
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
        </div>
    </s:if>
    <script type="text/javascript">
        /* $(document).ready(function() {
         $('#mytable').dataTable({
         // paging: false,
         //searching: false                                                                                             "scrollX": true
         });
         });*/
//        $jQuery2(function () {
//            $jQuery2('#mytable').dataTable({
//                // paging: false,
//                //searching: false 
//            });
//        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.display1').dataTable({
                // "scrollX": true,                
                "iDisplayLength": 25,
                "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
                "order": []
            });
        });
    </script>
    <script>
        function callForDate() {
            var start_date = document.getElementById("datepicker1").value;
            var end_date = document.getElementById("datepicker2").value;
//            if (start_date != '' || end_date != '') {
//                alert(start_date + " ssds " + end_date);
            window.open("statewiseSummary.html?sd=" + start_date + "&ed=" + end_date + "", "_self");
//            }
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
                    var fileName = 'GenderReportStateWise';
                    var blobURL = tableToExcel('gender_list', 'test_table');
                    $(this).attr('download', fileName + '.xls');
                    $(this).attr('href', blobURL);
                }
                if (valhidden == 'experience') {
                    var fileName = 'ExperienceReportStateWise';
                    var blobURL = tableToExcel('exp_list', 'test_table');
                    $(this).attr('download', fileName + '.xls');
                    $(this).attr('href', blobURL);
                }
                if (valhidden == 'qualification') {
                    var fileName = 'QualificationReportStateWise';
                    var blobURL = tableToExcel('qualification_list', 'test_table');
                    $(this).attr('download', fileName + '.xls');
                    $(this).attr('href', blobURL);
                }
                if (valhidden == 'all') {
                    var fileName = 'AllReportStateWise';
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
                , format =function(s, c) {
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

