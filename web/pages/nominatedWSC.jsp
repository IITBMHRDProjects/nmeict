<%-- 
    Document   : nominatedWSC
    Created on : 1 Oct, 2015, 12:06:41 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>

<link rel="stylesheet" href="css/datepicker-jquery-ui.css">
<script src="js/datepicker-jquery-ui.js"></script>

<body>
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <s:if test="hasActionMessages()">
        <div class="msg msg-ok">
            <s:actionmessage/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <h1 style="color: #036;font-weight: bold;font-size: 220%;text-align: center;">Nominated WSC</h1>
    <b>Click to Add a New Nomination </b><button class="completedButton" style="position: relative; bottom:10px;" onclick="newNomination();">New</button>

<center>
    <table id="mytable" style="/*font-size: 90%;width:770px;text-wrap:normal; margin-left: 15%;*/" class="table">
        <thead id="tablehead">   
            <tr>
                <th>S.No</th>
                <th>Workshop ID</th>
                <th>RC ID</th>
                <th>Coordinator Email</th>                
                <th>Nominee's Name</th>
                <th>Active Till</th>                
                <th>Update</th>
            </tr>
        </thead>
        <tbody id="mytable">

            <s:iterator value="nominations" status="itStatus">
                <tr>
                    <td><s:property value="#itStatus.count" /></td>
                    <td><s:property value="wc.workshopid"/></td>
                    <td><s:property value="rc.remoteCenterId"/></td>
                    <td><s:property value="cooridnator_email"/></td>                    
                    <td><s:property value="nominee_email"/></td>   
                    <s:if test='expiry == 1'> 
                        <td><s:property value="active_till"/></td>
                        <td>Workshop Completed</td></s:if>
                    <s:else>
                        <td><input class="datepicker" id="active_<s:property value="#itStatus.count"/>" value="<s:property value="active_till"/>" onclick="calldp();"/></td>    
                        <td><button class="approvedButton" value="Update" onclick="updateWSCNominee('<s:property value="id"/>', '<s:property value="#itStatus.count" />');">Update</button> 
                        </td></s:else>
                </s:iterator>
            </tr>
        </tbody>
    </table>
</center>
<script type="text/javascript">
        $(document).ready(function() {
            $('#mytable').dataTable({
                //  paging: false,
                //   searching: false                                                                                             "scrollX": true
            });
        });

        function newNomination() {
            window.open("nominateWSC.html", "_self");
        }
        //    $(function() {
        //        $( ".datepicker" ).datepicker({ dateFormat: 'dd-mm-yy' });           
        //    });

        function calldp() {
            $(".datepicker").datepicker({dateFormat: 'dd-mm-yy'});
        }
        function updateWSCNominee(id, count) {
            var active_till = document.getElementById("active_" + count).value;
            updateNominatedWSC(id, active_till);
        }
</script>
<script>
    $(document).ready(function() {
        $("#settingoptions").hide();
        $("#showmore").click(function(e) {
            var x = e.pageX;
            var tmpx = x - 200;
            $("#settingoptions").css({left: tmpx});
            $("#settingoptions").slideToggle();
        });
    });
</script>
</body>