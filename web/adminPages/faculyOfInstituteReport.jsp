<%-- 
    Document   : faculyOfInstituteReport
    Created on : 27 Nov, 2015, 4:24:27 PM
    Author     : dipesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% int sr_no = 0;%>
        <div style="margin-left: 30%;">
            <h3><b>Total No. of participants from each institute attended the Workshop</b></h3>
        </div>
        <%--<div>Export Excel <input id="btnExport" type="button" value="Click Here" onclick="exportExcel_FacultyReport()"/></div>--%>
        <div style="text-align: center;">Export Excel <a class="btn btn-success" id="btnExport"><img src="images/savexls.png"/></a></div><br><br>
        <div style=" margin-left: 20%;  width: 800px;">
            <div id="institutedata" style="">
                <table id="mytable1" class="table">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th>Sr.No</th>
                            <th id="wid">Institute Id</th>
                            <th>Institute Name</th>
                            <th>Number of Faculty Attended</th>
                        </tr>
                    </thead>
                    <tbody id="mytablebody"  name="tablebody">
                        <s:iterator value="institutewisedata" status="userStatus">
                            <tr id="session_">
                                <td><%= ++sr_no%></td>
                                <td><s:property value="idInstitute"/></td>
                                <td><s:property value="instituteName"/></td>
                                <td><s:property value="no_of_workshop_attend"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
            </div>
        </div>
        <div>
            <% int countData = 0;%>
            <div id="dvData" style="display: none;">
                <table id="facultyReport" class="table">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th>Sr.No</th>
                            <th id="wid">Institute Id</th>
                            <th>Institute Name</th>
                            <th>Number of Faculty Attended</th>
                        </tr>
                    </thead>
                    <tbody id="mytablebody"  name="tablebody">
                        <s:iterator value="institutewisedata" status="userStatus">
                            <tr id="session_">
                                <td><%= ++countData%></td>
                                <td><s:property value="idInstitute"/></td>
                                <td><s:property value="instituteName"/></td>
                                <td><s:property value="no_of_workshop_attend"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
    <script>
        $(document).ready(function () {
            $('#mytable1').dataTable({
                // paging: false,
                //searching: false 
                iDisplayLength: 50,
                "order": []
            });
        });
    </script>
    <script>
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
        $("#btnExport").click(function (e) {
            //window.open('data:application/vnd.ms-excel;filename=exportData.xlsx;,' + encodeURIComponent($('#dvData').html()));
            //e.preventDefault();
            var todaysDate ='FaculyOfInstituteReport'; 
            var blobURL = tableToExcel('facultyReport', 'test_table');
            $(this).attr('download',todaysDate+'.xls')
            $(this).attr('href',blobURL);
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
                var blob = new Blob([format(template, ctx)]);
                var blobURL = window.URL.createObjectURL(blob);
                return blobURL;
                //window.location.href = uri + base64(format(template, ctx))
            }
        })()
    </script>
    <script>
        function exportExcel_FacultyReport(){
            // tableToExcel('facultyReport', 'W3C Example Table');
        }
    </script>
</html>
