<%-- 
    Document   : showPaymentDetails
    Created on : 29 Jan, 2016, 11:26:33 AM
    Author     : dipesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<!DOCTYPE html>
  <body>
         <br><br><div id="paydetails" style="width: 99%; overflow: scroll; margin-left: 10px;">
        <% int sr_no = 0, sr_no1 = 0;%>
        <table id="mytable" class="table" style="">
            <thead id="tablehead" name="tablehead">
                <tr>
                    <th>Sr.No</th>
                    <th>Participant Id</th>
                    <th>Request Id</th>
                    <th>Status</th>
                    <th>Amount</th>
                    <th>Trans Id</th>
                    <th>Ref No</th>
                    <th>Trans Date</th>
                    <th>Message</th>
                </tr>
            </thead>
            <tbody id="mytablebody"  name="tablebody">
                <s:iterator value="participants1" status="userStatus">
                    <tr id="session_">
                        <td><%= ++sr_no%></td>
                        <td><s:property value="userId"/></td>
                        <td><s:property value="reqId"/></td>
                        <td><% String status_val=(String)request.getAttribute("status"); if(status_val.toLowerCase().equals("s")){ %>Successful<% } else if(status_val.toLowerCase().equals("f")){ %>Failed<% } %><%--<s:property value="status"/>--%></td>
                        <td><s:property value="totalAmt"/></td>
                        <td><s:property value="transId"/></td>
                        <td><s:property value="refNo"/></td>
                        <td><% String status=(String)request.getAttribute("status"); if(status.toLowerCase().equals("s") || status.toLowerCase().equals("f")){ %><%String date=(String)request.getAttribute("transDate"); %><% String[] parts = date.split(" ");%><%= parts[0]  %> <s:property value="transTime"/>  <%}else{%> <s:property value="transDate"/> <% } %></td>
                        <td><s:property value="msg"/></td>
                    </tr>
                </s:iterator>
            </tbody>
        </table>
    </div>
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
    

