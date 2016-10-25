<%-- 
    Document   : viewRemoteCenterCapacity
    Created on : 17 Nov, 2014, 12:05:05 PM
    Author     : Abinaya
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<style type="text/css">
    @import "paginate/css/demo_page.css";
    @import "paginate/css/demo_table_jui.css";
    @import "paginate/css/jquery-ui-1.8.4.custom.css";  
</style>
<script type="text/javascript" language="javascript" src="paginate/jquery.js"></script>
<script type="text/javascript" language="javascript" src="paginate/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript" src="paginate/ColVis.js"></script>

<%
    String callFrom = request.getParameter("callFrom");
%>

<%if (callFrom.equals("1")) {%><br/><h3 style="position: relative;right:5px;width:720px;">Remote Center Capacity List</h3><br/>
<div class="form_enclosure">
    <s:iterator value="workshopContent">
        <h1><s:property value="workshopname" /></h1>
        <h4 align="center"><s:property value="sponsor"/></h4>
        <br/>
        <s:if test="dateToBeDisplayed == 1">
        <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   
        </s:if><s:else></s:else>
    </s:iterator>
    <s:if test='%{workshopContent[0].categorycode == 7}'>
        <p><img  src="images/triangle_animated.gif"><font style="font-size: 13px;"><b>Rs.1000/- participation fee is mandatory for entire workshop. Payment of Food and Boarding is optional for the participant.</b></font><img  src="images/triangle_animated.gif"></p>
        </s:if>
        <s:if test="%{remoterCenterCapacity.size() > 0}">
        <table class="content_container1" >
            <thead><tr>
                    <td>S No</td>
                    <td>Remote Center ID</td>
                    <td>Remote Center Name</td>
                    <td>Total Available Seats</td>
                    <td>Total Available Accomm odation</td>
                    <td>Seats Provisi onally Booked</td>
                    <td>Accomm odation Provisi onally Booked</td>
                    <td>Seats Remain ing</td>
                    <s:if test='%{workshopContent[0].categorycode == 7}'>                        
                        <td>Cost of Accomm odation per day (Rs.)</td> 
                        <td>Cost of Food per day (Rs.)</td>           
                    </s:if>
                </tr>
            </thead>
            <tbody>       
                <s:iterator value="remoterCenterCapacity" status="itStatus">
                    <tr class="gradeU">
                        <td><s:property value="#itStatus.count" /></td>
                        <td><s:property value="rcid"/></td>
                        <td><s:property value="remotecentername"/></td>
                        <td><s:property value="available_seats"/></td>
                        <td><s:property value="available_accomo"/></td>
                        <td><s:property value="seats_booked"/></td>
                        <td><s:property value="accomo_booked"/></td>
                        <td><s:property value="seats_remaining"/></td>
                        <s:if test='%{workshopContent[0].categorycode == 7}'>
                            <td><s:property value="acco_cost"/></td>                           
                            <td><s:property value="food_cost"/></td>
                        </s:if>
                    </tr> 
                </s:iterator>
            </tbody>         
        </table>   
    </s:if>
    <s:else>
        <p align="center"><b> There are no Remote Centers to show. </b></p>
    </s:else></div>
    <%} else {%>
<div class="form_enclosure">
    <s:iterator value="workshopContent">
        <h1><s:property value="workshopname" /></h1>
        <h4 align="center"><s:property value="sponsor"/></h4>
        <br/>
        <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   
    </s:iterator>
</div>
<table class="content_container"><tr><td style="text-align:center"><h4 style="color: #003366;width:725px;"><b>Remote Center Capacity List</b></h4></td></tr>
</table>
<s:if test="%{remoterCenterCapacity.size() > 0}">
    <table id="dispatchdetail" class="display1" cellpadding="0" cellspacing="0" style="font-size: 90%;">
        <thead>
            <tr style="text-align: center;">
                <td>S No</td>
                <td>Remote Center ID</td>
                <td>Remote Center Name</td>
                <td>State</td>
                <td>Total Available Seats</td>
                <td>Total Available Accomm odation</td>
                <td>Seats Provisi onally Booked</td>
                <td>Accomm odation Provisi onally Booked</td>
                <td>Seats Remaining</td>
                <s:if test='%{workshopContent.getIndex(0).getCategorycode == 7}'>
                    <td>Food Cost per day</td>
                    <td>Accomm odation Cost per day</td>
                </s:if>
            </tr>
        </thead>
        <tbody>       
            <s:iterator value="remoterCenterCapacity" status="itStatus">
                <tr class="gradeU" >
                    <td style="text-align: center;"><s:property value="#itStatus.count" /></td>
                    <td style="text-align: center;"><s:property value="rcid"/></td>
                    <td style="text-align: left;"><s:property value="remotecentername"/></td>
                    <td style="text-align: center;"><s:property value="state"/></td>
                    <td style="text-align: center;"><s:property value="available_seats"/></td>
                    <td style="text-align: center;"><s:property value="available_accomo"/></td>
                    <td style="text-align: center;"><s:property value="seats_booked"/></td>
                    <td style="text-align: center;"><s:property value="accomo_booked"/></td>
                    <td style="text-align: center;"><s:property value="seats_remaining"/></td>
                </tr> 
            </s:iterator>
        </tbody> 
        <tfoot class="nav" >
            <tr class="gradeA">
                <th>Total</th>
                <th>&nbsp;</th>
                <th><s:property value="remoterCenterCapacity.size" /></th>
            </tr>
        </tfoot>
    </table>
</s:if>
<s:else>
    <p align="center"><b> There are no Remote Centers to show. </b></p>
</s:else>
<% }%>
<script type="text/javascript">
    $(document).ready(function() {      
        if((<s:property value="remoterCenterCapacity.size" />)>=20){var aves1=500;}
        else{var aves1=50+30*(<s:property value="remoterCenterCapacity.size" />);}        
        $('#dispatchdetail').dataTable({           
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
<script>
    $(document).ready(function() {
        $("#settingoptions").hide();
        $("#showmore").click(function(e) {
            var x=e.pageX;
            var tmpx=x-200;
            $("#settingoptions").css({left: tmpx});
            $("#settingoptions").slideToggle();
        });
    });
</script>
