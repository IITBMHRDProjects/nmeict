<%-- 
    Document   : paymentDetailsForATeam
    Created on : 18 Jan, 2016, 5:58:49 PM
    Author     : dipesh
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<style>
    /* #paydeatils{
         width: 60%;
         padding: 5px;
         overflow-x: auto;
         white-space: nowrap;
     }*/

    .payheading{
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
        width : 740px;
        font-style: normal;
        font-family: fantasy;
        padding-left: 12px;
        padding-bottom: 2px;
    }
</style>
<% String enc_wid = "", workshopid="";
    try {
        enc_wid = ServletActionContext.getRequest().getParameter("workshopid");
        SimpleStringCipher cipher = new SimpleStringCipher();
         workshopid= cipher.decrypt(enc_wid);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<body>
    <s:iterator value="workshopcontent">
        <h2 class="payheading" style="margin-left: 10px;">Payment Details Of Participants for <s:property value="workshopname"/></h2>
    <label style="font-size: 16px; margin-left: 10px;"><b>Export Excel</b> </label><a onclick="create_PaymentDetailsOfParticipants('<%= workshopid %>');" style="position:relative;left:20px;top:10px;" title="Export to Excel"><img src="images/savexls.png"/></a>
    </s:iterator>
    <br><br><div id="paydetails" style="width: 99%; overflow: scroll; margin-left: 10px;">
        <% int sr_no = 0, sr_no1 = 0;%>
        <table id="mytable" class="table" style="">
            <thead id="tablehead" name="tablehead">
                <tr>
                    <th>Sr.No</th>
                    <th>Participant Id</th>
                    <th>Participant Name</th>
                    <th>Email</th>
                    <th>RC Id</th>
                    <th>Request Id</th>
                    <th>Status</th>
                    <th>Amount</th>
                    <th>Trans Id</th>
                    <th>Ref No</th>
                    <th>Trans Date</th>
                    <th>Trans Time</th>
                    <th>Recon Date</th>
                    <th>Recon Time</th>
                    <th>Prov Id</th>
                    <th>Message</th>
                </tr>
            </thead>
            <tbody id="mytablebody"  name="tablebody">
                <s:iterator value="participants" status="userStatus">
                    <tr id="session_">
                        <td><%= ++sr_no%></td>
                        <td><s:property value="userId"/></td>
                        <td><s:property value="name"/></td>
                        <td><s:property value="email"/></td>
                        <td><s:property value="rcid"/> : <s:property value="rcname"/> ,<s:property value="city"/></td>
                        <td><s:property value="reqId"/></td>
                        <td><s:if test='%{status.equals("S")}'>Successful</s:if><s:else>Failure</s:else></td>
                        <td><s:property value="totalAmt"/></td>
                        <td><s:property value="transId"/></td>
                        <td><s:property value="refNo"/></td>
                        <td><s:property value="transDate"/></td>
                        <td><s:property value="transTime"/></td>
                        <td><s:property value="reconDate"/></td>
                        <td><s:property value="reconTime"/></td>
                        <td><s:property value="provId"/></td>
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
<script>
    function create_PaymentDetailsOfParticipants(type) {
        var data = "type=" + type;
        $.ajax({
            url: "pages/DAOCreateExcel_PaymentDetailsOfParticipants.jsp",
            type: "GET",
            data: data,
            dataType: "json",
            success: excel_paymentdetailsofparticipants,
            error: onError
        });
    }

    function excel_paymentdetailsofparticipants(data) {
        var url = "Excel_Sheets/" + data + ".xls";
        window.location.assign(url);
    }
        
    function onError(jqXHR, textStatus, errorThrown) {
        alert("Error : " + textStatus + " " + errorThrown);
    }
</script>
</html>
