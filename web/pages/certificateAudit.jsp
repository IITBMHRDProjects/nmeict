<%-- 
    Document   : certificateAudit
    Created on : 4 Nov, 2015, 1:02:52 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<h1 style="color: #036;font-weight: bold;font-size: 220%;text-align: center;">Ceritificate Audit</h1>
<center>
    <table id="mytable" style="/*font-size: 90%;width:770px;text-wrap:normal; margin-left: 15%;*/" class="table">
        <thead id="tablehead">   
            <tr>
                <th>S.No</th>
                <th>Workshop ID</th>
                <th>RC ID</th>
                <th>Participants</th>                
                <th>Time</th>
                <th>Updated by</th> 
            </tr>
        </thead>
        <tbody id="mytable">

            <s:iterator value="certificateAudit" status="itStatus">
                <tr>
                    <td><s:property value="#itStatus.count" /></td>
                    <td><s:property value="workshopid"/></td>
                    <td><s:property value="rcid"/></td>
                    <td><s:property value="participants"/></td>    
                    <td><s:property value="time"/></td> 
                    <td><s:property value="updated_by"/></td> 
                </s:iterator> 
            </tr>
        </tbody>
    </table>
</center>
<script type="text/javascript">
    $(document).ready(function () {
        $('#mytable').dataTable({
            //  paging: false,
            //   searching: false                                                                                             "scrollX": true
        });
    });
</script>