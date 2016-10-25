<%-- 
    Document   : manageRCCapacity
    Created on : 28 Aug, 2014, 4:12:27 PM
    Author     : Abinaya
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<%
    String updt_result = "";
    try {
        updt_result = (String) session.getAttribute("update_result");
    } catch (NullPointerException ex) {
        ex.printStackTrace();
    } finally {
        session.removeAttribute("update_result");
    }
    if (updt_result == null) {
        updt_result = "";
    }
%>
<script>
    $(document).ready(function() {
        setTimeout(function() {
            $("#update_success").fadeOut().empty();
        }, 10000);
    });

</script>
<script type="text/javascript" src="js/jquery.js"></script>
<script>
    var $jQuery1 = $.noConflict(true);
</script>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script>
    var $jQuery2 = jQuery.noConflict(true);
</script>
<style type="text/css">
    @import "paginate/css/demo_page.css";
    @import "paginate/css/demo_table_jui.css";
    @import "paginate/css/jquery-ui-1.8.4.custom.css";  
</style>
<body>
    <%
        String workshopid = request.getParameter("workshopid");
        SimpleStringCipher cipher = new SimpleStringCipher();
    %>
    <input type="hidden" id="widHidden" value="<%=workshopid%>"/>
    <h2 style="color: #036;font-weight: bold;font-size: 220%;text-align: center;">Manage Remote Center Capacity</h2>
    <noscript><font color="black">Please Enable Your Browser Javascript for Better Functionality.</font></noscript><br><br>
    <s:if test='%{#session.loggedInUser.roleId > 1}'>
        <div style="float: right; margin-top: 10px; padding: 5px; padding-bottom: 15px;display:none;">
            <a href="adminHome.html" style="text-decoration: none;" ><input type="button" style="background: black;color: white; width: 150px; border-radius: 10px;" value="Back to Admin Page"/></a>
        </div>
        <div style="width: auto; margin-bottom: 30px; border: solid 1px black; padding: 10px;">
            <label><b>Select  Workshop ID :</b></label>
            <select id="workshopid" onchange="ChangeWorkshopId(this.value)">
                <option value="-1">select workshopId</option>
                <s:iterator value="workshopContentAll">
                    <s:if test='%{without_RC == 0}'>
                        <%--   <option value="<s:property value="workshopid"/>"><s:property value="workshopid"/></option> --%>
                        <option value="<s:property value="workshopid_encrypted"/>"><s:property value="workshopid"/> -- <s:property value="workshopname" /></option>
                    </s:if></s:iterator>
                </select>
            </div><br>
            <div id="loadMessage" style="display: none;"><p><b>These will take some time. please wait...</b></p></div>
            <br>
            <div style="">
            <% if (updt_result != "" || updt_result != null) {%>
            <div id="update_success" style="float: left;"><br><font color="green"><%= updt_result%></font><br>
            </div>
            <% }%>
        </div>
        <%
            if (!workshopid.equals("none")) {
                String workshopid_dec = cipher.decrypt(workshopid);
        %>
        <s:if test='%{#session.loggedInUser.roleId == 5}'> 
            <div style="padding: 5px;">  
                <table class="" style="font-weight: bold;font-size: 120%">
                    <tr><td>Click on the button below to send mails for Remote Center Coordinators of <br/>
                            the workshop for filling the remote center capacity.</td>
                        <td><input type="button" style="background: black;color: white; width: 100px;height:30px; border-radius: 7px;" value="Send Mail" onclick="sendMailToRCC('<%=workshopid_dec%>')"/>
                        </td></tr>
                    <tr><td>Add New Remote Center Capacity</td>
                        <td><input type="button" style="background: black;color: white; width: 100px;height:30px; border-radius: 7px;" onclick="addNewRcc('<%=workshopid%>')" value="Add New"/></td></tr>
                    <tr><td>Auto Enroll Workshop Coordinators to Moodle</td>
                        <td><input type="button" style="background: black;color: white; width: 100px;height:30px; border-radius: 7px;" onclick="autoEnrollCoordinators('<%=workshopid_dec%>')" value="Auto Enroll"/></td></tr>
                    <tr><td>View Remote Center Seating/Accommodation Provisionally Booked</td>
                        <td><input type="button" style="background: black;color: white; width: 100px;height:30px; border-radius: 7px;" onclick="viewSeats('<%=workshopid%>')" value="View Seats"/></td></tr>
                </table>  
            </div>              
        </s:if>
        <div id="hor-minimalist-a" align='center' style="text-align: center; width: 97%;display:none;">
            <label style="font: 50px; color: #28343b;"><b> Remote Center Capacity Details </b></label>
        </div>
        <div style="width: auto;  overflow: scroll;">
            <table class="display1"  id="participantDetail1" align="center" >
                <thead id = "headers">
                    <tr>
                        <th style="text-align: center;">Sr. no</th>
                        <th class="sortable-text" style="text-align: center;" scope="col">Remote Center Id</th>
                        <th class="sortable-text" style="text-align: center;">Remote Center Name</th>
                        <th class="sortable-text" style="text-align: center;">Maximum Seats Available</th>
                        <th class="sortable-text" style="text-align: center;">Maximum Accommodation Available</th>
                            <s:iterator value="workshopContent">
                                <s:if test='%{categorycode == 7}'>
                                <th class="sortable-text" style="text-align: center;">Accommodation Cost per day</th>
                                <th class="sortable-text" style="text-align: center;">Food Cost per day</th>
                                    <s:if test='%{#session.loggedInUser.roleId == 5}'>
                                    <th class="ordinarytext" style="text-align: center;">Edit</th>
                                    </s:if>
                                </s:if><s:else>
                                    <s:if test='%{#session.loggedInUser.roleId == 5}'>
                                    <th class="ordinarytext" style="text-align: center;">Edit</th>
                                    </s:if>
                                </s:else>
                            </s:iterator>                       
                    </tr>
                </thead>
                <tbody>
                    <% int k = 1;%>
                    <s:iterator value="remoterCenterCapacity">
                        <tr>
                            <td style="text-align: center;"><%=k%></td>
                            <td style="text-align: center;"><s:property value="rcid"/></td>
                            <td><s:property value="remotecentername"/></td>
                            <td style="text-align: center;"><s:property value="available_seats"/></td>
                            <td style="text-align: center;"><s:property value="available_accomo"/></td>
                            <s:iterator value="workshopContent">
                                <s:if test='%{categorycode == 7}'>
                                    <td style="text-align: center;"><s:property value="acco_cost"/></td>
                                    <td style="text-align: center;"><s:property value="food_cost"/></td>
                                    <s:if test='%{#session.loggedInUser.roleId == 5}'>
                                        <td style="text-align: center;position:relative;">
                                            <!--<a id="a_button" href="updateRCCapacity.html?workshopid=<%=workshopid%>&rcid=<s:property value="rcid_enc"/>&avseats=<s:property value="available_seats"/>&avaccomo=<s:property value="available_accomo"/>"><input id="ubutton" type="button" value="Update" /></a>-->  
                                            <input style="background: #1e90ff; border-radius: 10px; padding: 2px; padding-left: 15px; padding-right: 15px; color: white;" type="button" value="update" onclick="openRCUpdate('<%=workshopid%>', '<s:property value="rcid_enc"/>', '<s:property value="available_seats"/>', '<s:property value="available_accomo"/>', '<s:property value="acco_cost"/>', '<s:property value="food_cost"/>');"/>
                                            <input style="margin-top: 5px; background: #1e90ff; border-radius: 10px; padding: 2px; padding-left: 15px; padding-right: 15px; color: white;"  type="button" value="delete" onclick="deleteRCCapacity('<%=workshopid%>', '<s:property value="rcid_enc"/>', '<s:property value="available_seats"/>', '<s:property value="available_accomo"/>', '<s:property value="%{#session.loggedInUser.loginId}"/>');"/>
                                        </td>
                                    </s:if>
                                </s:if>
                                <s:else>
                                    <s:if test='%{#session.loggedInUser.roleId == 5}'>
                                        <td style="text-align: center;">
                                            <!--<a id="a_button" href="updateRCCapacity.html?workshopid=<%=workshopid%>&rcid=<s:property value="rcid_enc"/>&avseats=<s:property value="available_seats"/>&avaccomo=<s:property value="available_accomo"/>"><input id="ubutton" type="button" value="Update" /></a>-->  
                                            <input style="background: #1e90ff; border-radius: 10px; padding: 2px; padding-left: 15px; padding-right: 15px; color: white;position:relative;right:60px;" type="button" value="update" onclick="openRCUpdate('<%=workshopid%>', '<s:property value="rcid_enc"/>', '<s:property value="available_seats"/>', '<s:property value="available_accomo"/>', '<s:property value="acco_cost"/>', '<s:property value="food_cost"/>');"/>
                                            <input style="margin-top: 5px; background: #1e90ff; border-radius: 10px; padding: 2px; padding-left: 15px; padding-right: 15px; color: white;position:relative;right:60px;"  type="button" value="delete" onclick="deleteRCCapacity('<%=workshopid%>', '<s:property value="rcid_enc"/>', '<s:property value="available_seats"/>', '<s:property value="available_accomo"/>', '<s:property value="%{#session.loggedInUser.loginId}"/>');"/>
                                        </td>
                                    </s:if>
                                </s:else>
                            </s:iterator>
                        </tr> 
                        <% k++;%>
                    </s:iterator>
                </tbody>
            </table>
        </div> 
        <% }%>
        <div id="RCCData" style=""> 
        </div>
    </s:if>
    <script>
        var hiddenId = document.getElementById("widHidden").value;
        var listWorkshops = document.getElementById("workshopid");
        if (hiddenId != 'none') {
            for (var i = 0; i < listWorkshops.length; i++)
            {
                if (listWorkshops.options[i].value == hiddenId)
                {
                    listWorkshops.options[i].selected = true;
                }
                else
                {
                    listWorkshops.options[i].selected = false;
                }
            }
        }
    </script>
    <script>
        $jQuery2(function() {
            $jQuery2('#participantDetail1').dataTable({
                "iDisplayLength": 25,
                "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
                "order": []
            });
        });
    </script>
</body>
