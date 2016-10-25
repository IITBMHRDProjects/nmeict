<%-- 
    Document   : workshopremark
    Created on : 1 Feb, 2016, 3:07:57 PM
    Author     : dipesh
--%>

<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<body>

    <%
        String status = "";
        try {
            status = request.getParameter("status");
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (status.equals("view")) {

    %>
    <br><br><div id="paydetails" style="width: 99%; overflow: scroll; margin-left: 10px;">
        <% int sr_no = 0;%>
        <table id="mytable" class="table" style="">
            <thead id="tablehead" name="tablehead">
                <tr>
                    <th>Sr.No</th>
                    <th>Workshop Id</th>
                    <th>Workshop Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Remark</th>
                    <th>Last Updated On</th>
                    <th>Update</th>

                </tr>
            </thead>
            <tbody id="mytablebody"  name="tablebody">
                <s:iterator value="workshopsremark" status="userStatus">
                    <tr id="session_">
                        <td><%= ++sr_no%></td>
                        <td><s:property value="workshopid"/></td>
                        <td style="width: 20%;"><s:property value="workshopname"/></td>
                        <td><s:property value="startdate"/></td>
                        <td><s:property value="enddate"/></td>
                        <td style="width: 25%;"><s:property escape="false" value="workshopRemark"/></td>
                        <td><s:property value="lastUpdated"/></td>
                        <td><input type="button" value="Update" style="background: #1E90FF; color: white; width: 80px; border: none; border-radius: 7px; height: 25px;" onclick="updateRemark('<s:property value="workshopid"/>','<s:property escape="false" value="workshopRemark"/>','<s:property value="workshopname"/>');"/></td>
                    </tr>
                </s:iterator>
            </tbody>
        </table>
    </div>
    <% } else if (status.equals("update")) {
        String wid = "0", remark = "", wname = "";
        try {
            wid = request.getParameter("wid");
            remark = request.getParameter("remark");
            remark = StringEscapeUtils.escapeHtml(remark);
            //remark=StringEscapeUtils.escapeJavaScript(remark);
            wname = request.getParameter("wname");
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <div style="text-align: center;">
        <p><h2><b><font style="color: #1a4d8b;"><%=wname%></font></b></h2></p>
    <div id="preview" style="">
        <%= remark%>
    </div><br>
    <p style="font-size: 16px;">Enter/update the feedback/remark here</p>
    <p>
        <textarea id="remark1" rows="6" cols="50" style="border-radius: 5px;" onkeypress="return validateRemark(event);" onkeyup="preview(this.value)"><%= remark%></textarea> 
    </p><br>
    <p>
        <input style="border: none; border-radius: 7px; width: 80px; height: 30px; background: black; color: white;" type="button" onclick="saveRemark('<%= wid%>');" value="Submit"/>
        <label id="remarkError" style="color: red;"></label>
    </p>
</div>
<% }%>
</body>
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
        $('#mytable').dataTable({
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
    function update_workshopRemark(wid,remark) {
        var data = "id=" + wid+"&remark="+remark;
        $.ajax({
            url: "pages/DAOUpdateWorkshopRemark.jsp",
            type: "GET",
            data: data,
            dataType: "json",
            success: setUpdate_WorkshopRemark,
            error: onError
        });
    }
    function setUpdate_WorkshopRemark(data) {
        if (data[1] == 0) {
            alert("Error in Ajax Call");
            // document.getElementById("saveStatus").style.display="inline";
            // document.getElementById("saveStatus").innerHTML="<font color='red'>error</font>";
        } else {
            // document.getElementById("saveStatus").style.display="inline";
            //  document.getElementById("saveStatus").innerHTML="<font color='green'>saved</font>";
            alert("Data Updated Successfully !");
            location.href = "workshopremark.html?status=view";
        }
    }
        
    function onError(jqXHR, textStatus) {
        alert("Error : " + textStatus);
    }
        
    function updateRemark(wid,remark,wname){
        //var remark=document.getElementById("remark_"+i).value;
        if(wid !=''){
            location.href = "workshopremark.html?status=update&wid="+wid+"&remark="+remark+"&wname="+wname;
            
            //update_workshopRemark(wid,remark);
        }
    }
    
    function saveRemark(wid){
        if(wid.length > 4){
            var remark=document.getElementById("remark1").value;
            if(remark.trim() !=""){
                update_workshopRemark(wid,remark);
            }else{
                document.getElementById("remarkError").innerHTML="please enter remark";
            }
        }else{
            document.getElementById("remarkError").innerHTML="invalid workshopid";
        }
    }
    
    function preview(val){
        //alert(val)
        if(val.trim()==""){
            document.getElementById("remarkError").innerHTML="please enter remark";
        }else{
            document.getElementById("remarkError").innerHTML="";
            document.getElementById("preview").innerHTML="";
            val=escapeHtml(val);
            document.getElementById("preview").innerHTML=val;
            document.getElementById("preview").style.color="green";
        }
    }
</script>
<script>
    function validateRemark(evt)
    {
            
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode ==38)
            return false;

        return true;
    }
</script>
<script>
    function escapeHtml(text) {
        'use strict';
        return text.replace(/[\"&<>]/g, function (a) {
            return { '"': '&quot;', '&': '&amp;', '<': '&lt;', '>': '&gt;' }[a];
        });
    }
</script>

