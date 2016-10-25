<%-- 
    Document   : coordinatorList
    Created on : 8 Aug, 2014, 5:30:35 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<%
    String callFrom = request.getParameter("callFrom");
%>


<style type="text/css">
    @import "paginate/css/demo_page.css";
    @import "paginate/css/demo_table_jui.css";
    @import "paginate/css/jquery-ui-1.8.4.custom.css";  
</style>
<script type="text/javascript" language="javascript" src="paginate/jquery.js"></script>
<script type="text/javascript" language="javascript" src="paginate/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript" src="paginate/ColVis.js"></script>
<script>
    var $jQuery2 = jQuery.noConflict(true);
</script>
<div class="form_enclosure">
    <s:iterator value="workshopContent">
        <h1><s:property value="workshopname" /></h1>
        <h4 align="center"><s:property value="sponsor"/></h4>
        <br/>
        <s:if test="dateToBeDisplayed == 1">
        <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   
        </s:if><s:else></s:else>
    </s:iterator>
</div>
<% if (callFrom.equals("2")) {%>
<table class="content_container"><tr><td style="text-align:center"><h4 style="color: #003366;width:750px;"><b>List of Coordinators</b></h4></td></tr>
</table>
<% } else {%> 
<table class="content_container"><tr><td style="text-align:center"><h4 style="color: #003366;width:750px;"><b>List of Participating Remote Centers</b></h4></td></tr>
</table>
<%}%>
<table class="display" id="coordinatorDetails" cellpadding="0" cellspacing="0" style="width:available;" >
    <thead>
        <tr>
            <th>S No</th>
            <th>RC ID</th>
            <th>Remote Center</th>
            <th>State</th>
            <% if (callFrom.equals("2")) {%>
            <th>Name</th>
            <th>Contact</th>
            <th>Email</th>   
            <% }%>
        </tr>
    </thead>
    <tbody align="center">
        <s:iterator value="coordinatorList" status="itStatus"> 
            <tr class="gradeU">
                <td><s:property value="#itStatus.count" /></td>
                <td><s:property value="remoteCenter.remoteCenterId" /></td>
                <td style="white-space: pre-wrap;"><s:property value="remoteCenter.remoteCenterName" />, <s:property value="remoteCenter.rc_city" /></td>
                <td style="white-space: pre-wrap;"><s:property value="remoteCenter.rc_state" /></td>
                <% if (callFrom.equals("2")) {%>
                <td style="white-space: pre-wrap;"><s:property value="firstName" /></td> 
                <td><s:property value="mobileNumber" /></td>
                <td><s:property value="email" /></td>
                <% }%>
            </tr>
        </s:iterator> 
    </tbody>    
    <tfoot class="nav">
        <tr class="gradeA">
            <th>Total</th>
            <th>&nbsp;</th>
            <th><s:property value="coordinatorList.size" /></th>
        </tr>
    </tfoot>
</table>
<script type="text/javascript">
    /*$(document).ready(function() {      
        if((<s:property value="coordinatorList.size" />)>=20){var aves1=500;}
        else{var aves1=50+30*(<s:property value="coordinatorList.size" />);}        
        $('#coordinatorDetails').dataTable({           
            "sScrollY": aves1,
            "bJQueryUI": true,
            "bLengthChange": true,
            "sPaginationType": "full_numbers",
            "iDisplayStart": 0,
            "iDisplayLength": 50,
            "iScrollLoadGap": 50,
            "aLengthMenu": [[50, 100, 200, -1], [50, 100, 200, "All"]]
        });
    });*/
    
    $jQuery2(function(){
        if((<s:property value="coordinatorList.size" />)>=20){var aves1=500;}
        else{var aves1=50+30*(<s:property value="coordinatorList.size" />);}
        $jQuery2('#coordinatorDetails').dataTable({           
            "sScrollY": aves1,
            "bJQueryUI": true,
            "bLengthChange": true,
            "sPaginationType": "full_numbers",
            "iDisplayStart": 0,
            "iDisplayLength": 50,
            "iScrollLoadGap": 50,
            "aLengthMenu": [[50, 100, 200, -1], [50, 100, 200, "All"]]
        });
    });
</script>  
