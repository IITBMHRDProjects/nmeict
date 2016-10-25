<%-- 
    Document   : viewUploadedAttendance
    Created on : 19 Aug, 2015, 5:12:24 PM
    Author     : dipesh
--%>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script>
     var $jQuery1 = $.noConflict(true);
</script>
<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script language="JavaScript" src="js/jquery.tipTip.minified.js"></script>       
<script>
      var $jQuery2 = jQuery.noConflict(true);
</script>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<body>
    <div class="form_settings">    
        <div class="form_box">
            <p>
                <span>Select Workshop</span> 
                <select id="workshopid" onchange="changeWorkshopName(this.value);">
                    <option value="-1">Select Workshop</option>
                    <s:iterator value="workshopContent">
                        <s:if test="%{categorycode ==5 || categorycode == 7 || categorycode == 8}">
                            <option value="<s:property value="workshopid"/>"><s:property value="workshopname"/></option>
                        </s:if>
                    </s:iterator>
                </select>
            </p><br>
            <p>
                <span>Select Remote Center </span> 
                <select id="remotecenter" onchange="changeRemoteCenterName(this.value)">
                    <option value="-1">Select a Remote Center</option>
                    <option></option>
                </select>
            </p>
        </div>
    </div><br><br>
    <br><br>
    <div style="padding: 10px;">
        <br><br>
        <table id="mytable" class="table">
            <thead id="tablehead" name="tablehead">
                <tr>
                    <td>Sr. No.</td>
                    <td style="width: 200px; text-align: center;">Date</td>
                    <td>Attendance Files</td>
                </tr>
            </thead>
            <tbody id="mytablebody"  name="tablebody">
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        /* $(document).ready(function () {
            $('#mytable').dataTable({
                // paging: false,
                //searching: false 
                iDisplayLength: 50,
                "order": []
            });
        });*/
    </script>
    <script>
        $jQuery2(function(){
            $jQuery2('#mytable').dataTable({
                // paging: false,
                //searching: false 
                // iDisplayLength: 50,
                // "order": []
            });
        });
    </script>
    <script>
        function changeWorkshopName(workshopid){
            fetchRemoteCenterName(workshopid, 'all');
        }
        
        function fetchRemoteCenterName(workshopid, stateID) {
            var data = "workshopid=" + workshopid + "+" + stateID;
            $.ajax({
                url: "pages/DAOSetRC.jsp",
                type: "GET",
                data: data,
                dataType: "json",
                success: setRemoteCenterName,
                error: onError
            });
        }

        function setRemoteCenterName(data) {
            $("#remotecenter").html("");
            var option = "<option value=\"-1\">--Select a Remote Center--</option>";
            for (var i = 0; i < data.length; i++) {
                option += "<option value=\"" + data[i].remoteCenterId + "\">" +data[i].remoteCenterId+"--"+ data[i].remoteCenterName + ", " + data[i].rc_city + "</option>";
            }
            $("#remotecenter").append(option);

        }
        
        function onError(jqXHR, textStatus) {
            alert("Error : " + textStatus);
        }
        
        function changeRemoteCenterName(rcid){
            var wid=document.getElementById("workshopid").value;
            fetchUploadAttendanceByRC(rcid,wid);
        }
        
        function fetchUploadAttendanceByRC(rcid,wid) {
            var data = "rcid=" + rcid+"&workshopid="+wid;
            $.ajax({
                url: "pages/DAOGetUploadAttendanceByRC.jsp",
                type: "GET",
                data: data,
                dataType: "json",
                success: setUploadAttendanceByRC,
                error: onError
            });
        }

        function setUploadAttendanceByRC(data) {
            if(data == null || data ==""){
                $jQuery2('#mytable').dataTable().fnClearTable();
            }else{
                var srno=1;
                $jQuery2('#mytable').dataTable().fnClearTable();
                $jQuery2('#mytable').dataTable().fnDestroy();
                for (var i = 0; i < data.length; i++) {
                    var table = document.getElementsByName("tablebody")[0];
                    //var table = document.getElementsByName("tablebody");
                    var row = document.createElement('tr');
                    var cell1 = document.createElement('td');
                    var cell2 = document.createElement('td');
                    var cell3 = document.createElement('td');
                    cell2.style.textAlign='center';
                    var text1 = document.createTextNode(srno);
                    var text2 = document.createTextNode(data[i].upload_date);
                    var text3 = document.createTextNode('<a href=""/>'+data[i].upload_fileName);
                
                    var a = document.createElement('a');
                    var linkText = document.createTextNode("Attendance"+srno);
                    a.appendChild(linkText);
                    a.title = "Attendance"+srno;
                    a.href = "AttendancePDF/"+data[i].upload_fileName;
                    a.target="_blank";
               
                    cell1.appendChild(text1);
                    cell2.appendChild(text2);
                    cell3.appendChild(a);
              
                    row.appendChild(cell1);
                    row.appendChild(cell2);
                    row.appendChild(cell3);
                
                    table.appendChild(row);
                    srno++;
                }
                $jQuery2(function(){
                    $jQuery2('#mytable').dataTable({
                        // paging: false,
                        //searching: false 
                        // iDisplayLength: 50,
                        // "order": []
                    });
                });
            }
        }
    </script>
</body>

