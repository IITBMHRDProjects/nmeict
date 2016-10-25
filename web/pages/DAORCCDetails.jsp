<%-- 
    Document   : DAOSetRCC
    Created on : 29 Sep, 2014, 1:07:18 PM
    Author     : dipesh
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="org.project.bean.RemoteCenterCapacity"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<%
    String workshopid = request.getParameter("workshopid");
    SimpleStringCipher cipher = new SimpleStringCipher();
    String workshopid_dec = cipher.decrypt(workshopid);
    /*
     * ArrayList<RemotecenterCapacity> remoterCenterCapacity = new
     * ArrayList<RemotecenterCapacity>(); UtilityProcess process = new
     * UtilityProcess(); remoterCenterCapacity =
     * process.rccDetails(Integer.parseInt(workshopid));
     *
     * Gson gson = new Gson(); gson.toJson(remoterCenterCapacity);
     * System.out.println("generating data");
     * out.print(gson.toJson(remoterCenterCapacity));
     * System.out.println("generating data2");
     */

%>

<html>
    <head>       
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>      
        <style>
            #a_button{
                text-decoration: none;
            }
            #ubutton{
                /* border-radius: 10px;
                 background: #162638;
                 color: white; */
            }
        </style>  


        <!--css added for the pagination and table css-->
        <script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>

    </head>
    <body>
        <%-- Code added by Abinaya for sending the mails to remote center coordinators
        for filling the remotecenter capacity --%>
        <s:if test='%{#session.loggedInUser.roleId > 1}'>        
            <s:if test='%{#session.loggedInUser.roleId == 5}'> 
                <div>  
                    <table class="content_container" style="font-weight: bold;font-size: 120%">
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
            <br/><br/>
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
                                                <input style="background: #1e90ff; border-radius: 10px; padding: 2px; padding-left: 15px; padding-right: 15px; color: white;" type="button" value="update" onclick="openRCUpdate('<%=workshopid%>', '<s:property value="rcid_enc"/>', '<s:property value="available_seats"/>', '<s:property value="available_accomo"/>', '<s:property value="acco_cost"/>','<s:property value="food_cost"/>');"/>
                                                <input style="margin-top: 5px; background: #1e90ff; border-radius: 10px; padding: 2px; padding-left: 15px; padding-right: 15px; color: white;"  type="button" value="delete" onclick="deleteRCCapacity('<%=workshopid%>', '<s:property value="rcid_enc"/>', '<s:property value="available_seats"/>', '<s:property value="available_accomo"/>', '<s:property value="%{#session.loggedInUser.loginId}"/>');"/>
                                            </td>
                                        </s:if>
                                    </s:if>
                                    <s:else>
                                        <s:if test='%{#session.loggedInUser.roleId == 5}'>
                                            <td style="text-align: center;">
                                                <!--<a id="a_button" href="updateRCCapacity.html?workshopid=<%=workshopid%>&rcid=<s:property value="rcid_enc"/>&avseats=<s:property value="available_seats"/>&avaccomo=<s:property value="available_accomo"/>"><input id="ubutton" type="button" value="Update" /></a>-->  
                                                <input style="background: #1e90ff; border-radius: 10px; padding: 2px; padding-left: 15px; padding-right: 15px; color: white;position:relative;right:60px;" type="button" value="update" onclick="openRCUpdate('<%=workshopid%>', '<s:property value="rcid_enc"/>', '<s:property value="available_seats"/>', '<s:property value="available_accomo"/>', '<s:property value="acco_cost"/>','<s:property value="food_cost"/>');"/>
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
        </s:if>     
    </body>
</html>