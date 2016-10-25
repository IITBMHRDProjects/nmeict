<%-- 
    Document   : workshopAttendedReport
    Created on : 17 Nov, 2015, 12:22:18 PM
    Author     : dipesh
--%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<% String criteria_type = null;
    try {
        criteria_type = ServletActionContext.getRequest().getParameter("val");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<body>
    <input type="hidden" id="hcriteria" value="<%= criteria_type%>"/>
    <div style="margin-left: 40%;">
        <div style="padding-left: 20px;">
            <p><span style="font-size: 15px;">Select By :</span>
                <select id="groupbycr" onchange="onWorkshopAttendCriteriaChange(this.value)">
                    <option value="-1">-- select the type--</option>
                    <option value="participant">Participant Wise</option>
                    <option value="institute">Institute Wise</option>
                    <option value="facultyperinstitue">Faculty-Per Institute</option>
                </select>
            </p>
        </div>
        <%--<div style="display: inline;">
            <p>Export to Excel <a onclick="create_ExcelReports();" style="position:relative;left:20px;top:1px;" title="Export to Excel"><img src="images/savexls.png"/></a></p>
        </div>--%>
        <div style="padding-left: 20px;">Export Excel <a class="btn btn-success" id="btnExport"><img src="images/savexls.png"/></a></div><br><br>
    </div>
    <div style=" margin-left: 20%;  width: 800px;">
        <div id="participantdata" style="display: none;">
            <input type="hidden" id="htotal" value="<s:property value="totalsize"/>"/>
            <div>
            </div>
            <% int sr_no = 0, sr_no1 = 0;%>
            <table id="mytable" class="table" style="margin-left: 20%;">
                <thead id="tablehead" name="tablehead">
                    <tr>
                        <th>Sr.No</th>
                        <th id="wid">Person Id</th>
                        <th>Name</th>
                        <th>Gender</th>
                        <th>Number of Workshops Attended</th>
                    </tr>
                </thead>
                <tbody id="mytablebody"  name="tablebody">
                    <s:iterator value="participantwisedata" status="userStatus">
                        <tr id="session_">
                            <td><%= ++sr_no%></td>
                            <%-- <% if (sr_no == 10000) {%>
                     <input type="text" id="lastRow" value="<s:property value="per_user_id"/>"/>
                     <% }%>--%>
                            <td><s:property value="per_user_id"/></td>
                            <td><s:property value="name"/></td>
                            <td><s:property value="gender"/></td>
                            <td><s:property value="no_of_workshop_attend"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>
        </div> </div>
    <div id="institutedata" style="display: none;">
        <table id="mytable1" class="table">
            <thead id="tablehead" name="tablehead">
                <tr>
                    <th>Sr.No</th>
                    <th id="wid">Institute Id</th>
                    <th>Institute Name</th>
                    <th>Number of Workshops Attended</th>
                </tr>
            </thead>
            <tbody id="mytablebody"  name="tablebody">
                <s:iterator value="institutewisedata" status="userStatus">
                    <tr id="session_">
                        <td><%= ++sr_no1%></td>
                        <td><s:property value="idInstitute"/></td>
                        <td><s:property value="instituteName"/></td>
                        <td><s:property value="no_of_workshop_attend"/></td>
                    </tr>
                </s:iterator>
            </tbody>
        </table>
    </div>
    <% int countInsti = 0;%>
    <div id="dvData" style="display: none;">
        <table id="instituteReport" class="table">
            <thead id="tablehead" name="tablehead">
                <tr>
                    <th>Sr.No</th>
                    <th id="wid">Institute Id</th>
                    <th>Institute Name</th>
                    <th>Number of Workshops Attended</th>
                </tr>
            </thead>
            <tbody id="mytablebody"  name="tablebody">
                <s:iterator value="institutewisedata" status="userStatus">
                    <tr id="session_">
                        <td><%= ++countInsti%></td>
                        <td><s:property value="idInstitute"/></td>
                        <td><s:property value="instituteName"/></td>
                        <td><s:property value="no_of_workshop_attend"/></td>
                    </tr>
                </s:iterator>
            </tbody>
        </table>
    </div> 
    <script type="text/javascript">
        /*$(document).ready(function () {
            $('#mytable').dataTable({
                // paging: false,
                //searching: false 
                iDisplayLength: 25,
                "order": []
            });
        });*/
        
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
        function onWorkshopAttendCriteriaChange(val){
            if(val !='-1'){
                if(val == 'participant'){
                    window.location.href = "workshopAttended.html?val="+val+"&range=1"+"","directories=no,height=100,width=100,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,top=0,location=no";
                }else if(val == 'institute'){
                    window.location.href = "workshopAttended.html?val="+val+"","directories=no,height=100,width=100,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,top=0,location=no";
                }else if(val =="facultyperinstitue"){
                    window.open("showWorkshopsIndex.html?update=RA9aOhNM3DNZ8LueVt9JR70h5LE8IW8IhzOwm6ffqPw");
                }
            }else if(val == '-1'){
                document.getElementById("participantdata").style.display="none";
                document.getElementById("institutedata").style.display="none";
            }
        }
    </script>
    <script>
        /* function createRange(){
            alert('called')
            var select_range=document.getElementById("groupbyrange");
            var total_count=document.getElementById("htotal").value;
            var roundNum=(total_count / 10000);
            var digit = (''+roundNum)[0];
            var totalRecords=parseInt(digit)+1;
            for(var i=1; i <= totalRecords; i++){
                var optn = document.createElement("OPTION");
                if(i == 1){
                    optn.text ="0 - 10000";
                    optn.value = i;
                }else{
                    var j=i;
                    optn.text = ((--j)*10000)+" - "+((i)*10000);
                    optn.value = i;
                }
                select_range.options.add(optn);
            }
        }
        alert(roundNum+" "+totalRecords)*/
    </script>
    <script>
        var valhidden=document.getElementById("hcriteria").value.trim();
        if(valhidden !='' || valhidden !=null){
            if(valhidden == 'participant'){
                document.getElementById("participantdata").style.display="inline"; 
                document.getElementById("groupbycr").value="participant";
                //createRange();
            }else if(valhidden == 'institute'){
                document.getElementById("institutedata").style.display="inline";
                document.getElementById("groupbycr").value="institute";
            }else if(valhidden =='none'){
                document.getElementById("participantdata").style.display="none";
                document.getElementById("institutedata").style.display="none";
                document.getElementById("groupbycr").value="-1";
            }
        }
        //alert(document.getElementById("htotal").value)
    </script>
    <script>
        /*function onWorkshopAttendRangeChange(range){
            var range2=document.getElementById("lastRow").value;
            var val='participant';
            window.location.href = "workshopAttended.html?val="+val+"&range="+range+"","directories=no,height=100,width=100,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,top=0,location=no";
        }*/
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
        /*function create_ExcelReports(){
            var valhidden=document.getElementById("hcriteria").value.trim();
            var wid;
            
            if(valhidden !='' || valhidden !=null){
                if(valhidden == 'participant'){
                    wid=0;
                    // createFacultyExcelSheetReport(valhidden,wid);
                    var fileName ='ParticiantReport'; 
                    var blobURL = tableToExcel('mytable', 'test_table');
                    $(this).attr('download',fileName+'.xls')
                    $(this).attr('href',blobURL);
                    // tableToExcel('mytable', 'W3C Example Table');
                }else if(valhidden == 'institute'){
                    //wid=0;
                    var fileName ='InstituteReport'; 
                    var blobURL = tableToExcel('instituteReport', 'test_table');
                    $(this).attr('download',fileName+'.xls')
                    $(this).attr('href',blobURL);
                    alert('called 1');
                    // tableToExcel('instituteReport', 'W3C Example Table');
                    // createFacultyExcelSheetReport(valhidden,wid);
                }else{
                }
            }
        }*/
    
        /*function createFacultyExcelSheetReport(type,wid) {
            var data = "type=" + type+"&wid="+wid;
            $.ajax({
                url: "pages/DAOCreateExcel_FacultyReports.jsp",
                type: "GET",
                data: data,
                dataType: "json",
                success: excel_FacultyExcelSheetReport,
                error: onError
            });
        }

        function excel_FacultyExcelSheetReport(data) {
            var url = "Excel_Sheets/" + data + ".xls";
            window.location.assign(url);
        }
        
        function onError(jqXHR, textStatus) {
            alert("Error : " + textStatus);
        }*/
    </script>
    <script>
        $("#btnExport").click(function (e) {
            var valhidden=document.getElementById("hcriteria").value.trim();
            if(valhidden !='' || valhidden !=null){
                if(valhidden == 'participant'){
                    var fileName ='ParticiantReport'; 
                    var blobURL = tableToExcel('mytable', 'test_table');
                    $(this).attr('download',fileName+'.xls')
                    $(this).attr('href',blobURL);
                }else if(valhidden == 'institute'){
                    var fileName ='InstituteReport'; 
                    var blobURL = tableToExcel('instituteReport', 'test_table');
                    $(this).attr('download',fileName+'.xls')
                    $(this).attr('href',blobURL);
                }else{
                }
            }
        });
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
    <script>
        function exportExcel_WorkshopAttendedReport(){
            //tableToExcel('instituteReport', 'W3C Example Table');
        }
    </script>
</body>

