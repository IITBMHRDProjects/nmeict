<%-- 
    Document   : viewSummery
    Created on : 10 Apr, 2015, 11:35:12 AM
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
<script language="JavaScript" src="js/jquery.tipTip.minified.js"></script>       
<script src="js/datepicker-jquery-ui.js"></script>
<link rel="stylesheet" href="css/datepicker-jquery-ui.css">
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
    });</script><script>
        $(function () {
        $("#datepicker1").datepicker({dateFormat: 'dd-mm-yy'});
        $("#datepicker2").datepicker({dateFormat: 'dd-mm-yy'});
        });</script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
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

    }
</style>
<body>
    <s:if test='%{#session.loggedInUser.roleId > 1}'>
        <div  style="padding: 10px;" class="summary">
            <div style="padding-left: 15px; padding-right: 15px; text-align: center;"><h3>Workshop Status Summary Report</h3></div>
            <div style="padding-left: 20px;">
                <p >
                    <span style="font-size: 15px;display:none;">Group By Criteria :</span>
                    <select style="display:none;" id="groupbycr" onchange="onCriteriaChange(this.value)">
                        <option value="-1">-- select the type--</option>
                        <option value="summary">Summary</option>
                        <option value="status">Status</option>
                    </select>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size: 15px;">Start Year(MM/dd/YYYY):<sup><img src="images/star.png"></sup></span>
                    <!--<select id="startyear" name="">
                        <option value="-1">Select Date</option>
                    </select>-->
                    <input type="date" style="width: 100px; background: white; border: none;"  id="datepicker1" name="content.startdatereg">
                    &nbsp;&nbsp;
                    <span style="font-size: 15px;">End Year(MM/dd/YYYY) :<sup><img src="images/star.png"></sup></span>
                    <input type="text" style="width: 100px; background: white; border: none;"  id="datepicker2" name="content.startdatereg">
                    <!--<select id="endyear" name="">
                        <option value="-1">Select Date</option>
                    </select>-->
                    &nbsp;&nbsp;
                    <input id="sbutton"  type="button" value="search" onclick="search_yearwise()"/>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <!--Export Excel <a onclick="create_SummaryExcel_New();" style="position:relative;left:20px;top:1px;" title="Export to Excel"><img src="images/savexls.png"/></a>-->
                    Export Excel <a class="btn btn-success" id="btnExport"><img src="images/savexls.png"/></a>
                </p>
            </div>
            <!--<h4 style="color: black;"> Click on the image to export details of the Summary Report 
                <a onclick="create_SummaryExcel();" style="position:relative;left:20px;top:1px;" title="Export to Excel"><img src="images/savexls.png"/></a>
            </h4>-->

            <div id="typestatus">
                <table id="mytable" class="display1" >                    
                    <thead id="tablehead" name="tablehead">  
                        <tr>
                            <th style="background-color: #EEEEEE;text-align: center;border-right: 1px solid black;border-top: 1px solid black;" colspan="4">Workshop Details</th>   
                            <th style="background-color: #EEEEEE;text-align: center;border-right: 1px solid black;border-top: 1px solid black;" colspan="4">Participants Registered but not attended</th>   
                            <th style="background-color: #EEEEEE;text-align: center;border-right: 1px solid black;border-top: 1px solid black;" colspan="2">Participants Attended</th>  
                            <th style="background-color: #EEEEEE;text-align: center;border-top: 1px solid black;border-bottom: 1px solid #EEEEEE;" >Total </th>
                        </tr>
                        <tr>
                            <th style="display:none;">Sno</th>
                            <th id="wid">WorkshopId</th>
                            <th>Workshop Name</th>
                            <th>Start Date</th>
                            <th style="border-right: 1px solid black;">End Date</th>
                            <th>Approved</th>
                            <th>Cancelled</th>
                            <th>Invalid</th>
                            <th style="border-right: 1px solid black;">Registered</th>
                            <th style="white-space: pre-wrap;">Certificate Not Issued</th>
                            <th style="white-space: pre-wrap;border-right: 1px solid black;">Certificate Issued</th>  
                            <th style="">Registrations</th>
                        </tr>
                    </thead>
                    <tbody id="mytablebody"  name="tablebody">
                        <s:iterator value="summary" status="userStatus">
                            <tr id="session_">
                                <td style="display:none;">Sno</td>
                                <td style="text-align: center;"><s:property value="workshopid"/></td>
                                <td><s:property value="workshopname"/></td>
                                <td><s:property value="startdate"/></td>
                                <td><s:property value="enddate"/></td>
                                <td style="text-align: center;"><s:property value="approved"/></td>
                                <td style="text-align: center;"><s:property value="cancelled"/></td>
                                <td style="text-align: center;"><s:property value="invalid"/></td>
                                <td style="text-align: center;"><s:property value="registered"/></td>
                                <td style="text-align: center;"><s:property value="confirmed"/></td>
                                <td style="text-align: center;"><s:property value="certified"/></td>       
                                <td style="text-align: center;"><s:property value="total"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
            </div>
            <div id="typesummary" style="padding: 15px; display: none;">
                <table id="mytable1" class="display1" style="word-spacing: normal;width:1024px;margin-left: 10%;" cellspacing="0" align="center">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th style="background-color: #EEEEEE;text-align: center;border-right: 1px solid black;border-top: 1px solid black;" colspan="4">Workshop Details</th>   
                            <th style="background-color: #EEEEEE;text-align: center;border-right: 1px solid black;border-top: 1px solid black;border-bottom: 1px solid #EEEEEE;" >Total </th>
                            <th style="background-color: #EEEEEE;text-align: center;border-top: 1px solid black;" colspan="2">Participants Attended</th>  
                        </tr>
                        <tr>
                            <th>Workshop ID</th>
                            <th>Workshop Name</th>
                            <th>Start Date</th>
                            <th style="border-right: 1px solid black;">End Date</th>
                            <th style="border-right: 1px solid black;">Registrations</th>
                            <th>Certificate Not Issued </th>
                            <th>Certificate Issued </th>

                        </tr>
                    </thead>
                    <tbody id="mytablebody1" name="tablebody">
                        <s:iterator value="summary" status="userStatus">
                            <tr id="session_">
                                <td><s:property value="workshopid"/></td>
                                <td><s:property value="workshopname"/></td>
                                <td><s:property value="startdate"/></td>
                                <td><s:property value="enddate"/></td>
                                <td style="text-align: center;"><s:property value="total"/></td>
                                <td style="text-align: center;"><s:property value="confirmed"/></td>
                                <td style="text-align: center;"><s:property value="certified"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
            </div>

        </div>


        <div style="display:none;">
            <table id="all_export" >                    
                <thead id="tablehead" name="tablehead">  
                    <tr>
                        <th style="background-color: #EEEEEE;text-align: center;border-right: 1px solid black;border-top: 1px solid black;" colspan="4">Workshop Details</th>   
                        <th style="background-color: #EEEEEE;text-align: center;border-right: 1px solid black;border-top: 1px solid black;" colspan="4">Participants Registered but not attended</th>   
                        <th style="background-color: #EEEEEE;text-align: center;border-right: 1px solid black;border-top: 1px solid black;" colspan="2">Participants Attended</th>  
                        <th style="background-color: #EEEEEE;text-align: center;border-top: 1px solid black;border-bottom: 1px solid #EEEEEE;" >Total </th>
                    </tr>
                    <tr>
                        <th id="wid">WorkshopId</th>
                        <th>Workshop Name</th>
                        <th>Start Date</th>
                        <th style="border-right: 1px solid black;">End Date</th>
                        <th>Approved</th>
                        <th>Cancelled</th>
                        <th>Invalid</th>
                        <th style="border-right: 1px solid black;">Registered</th>
                        <th style="white-space: pre-wrap;">Certificate Not Issued</th>
                        <th style="white-space: pre-wrap;border-right: 1px solid black;">Certificate Issued</th>  
                        <th style="">Registrations</th>
                    </tr>
                </thead>
                <tbody >
                    <s:iterator value="summary" status="userStatus">
                        <tr id="session_">
                            <td style="text-align: center;"><s:property value="workshopid"/></td>
                            <td><s:property value="workshopname"/></td>
                            <td><s:property value="startdate"/></td>
                            <td><s:property value="enddate"/></td>
                            <td style="text-align: center;"><s:property value="approved"/></td>
                            <td style="text-align: center;"><s:property value="cancelled"/></td>
                            <td style="text-align: center;"><s:property value="invalid"/></td>
                            <td style="text-align: center;"><s:property value="registered"/></td>
                            <td style="text-align: center;"><s:property value="confirmed"/></td>
                            <td style="text-align: center;"><s:property value="certified"/></td>       
                            <td style="text-align: center;"><s:property value="total"/></td>
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
    <script type="text/javascript">
        $("#btnExport").click(function (e) {
        var fileName = 'StatusSummary';
        var blobURL = tableToExcel('all_export', 'test_table');
        $(this).attr('download', fileName + '.xls');
        $(this).attr('href', blobURL);
        });
        /* $(document).ready(function () {
         $('#mytable').dataTable({
         // paging: false,
         //searching: false 
         iDisplayLength: 50,
         "order": []
         });
         });
         $(document).ready(function () {
         alert('called')
         //alert('Row index: ' + table.row().length);
         
         });*/



    </script>
    <script>

        function search_yearwise() {
        var start_date = document.getElementById("datepicker1").value;
        var end_date = document.getElementById("datepicker2").value;
        window.open("viewSummary.html?sd=" + start_date + "&ed=" + end_date + "", "_self");
        }

        function serach_yearwies() {
        var ndate = document.getElementById("datepicker1").value;
        var ndate2 = document.getElementById("datepicker2").value;
        if (!(ndate == "" || ndate2 == "")) {
        var dt = new Date(ndate);
        var dtend = new Date(ndate2);
        var Tab;
        var selectVal = document.getElementById("groupbycr").value;
        if (selectVal == 'summary') {
        Tab = document.getElementById("mytablebody1");
        } else {
        Tab = document.getElementById("mytablebody");
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
        var selectVal = document.getElementById("groupbycr").value;
        if (selectVal == 'summary') {
        Tab = document.getElementById("mytablebody1");
        } else {
        Tab = document.getElementById("mytablebody");
        }
        var size1 = Tab.rows.length;
        for (var i = 0; i < size1; i++) {
        Tab.rows[i].style.display = "";
        }
        }

        }

//script for logout conflict
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

