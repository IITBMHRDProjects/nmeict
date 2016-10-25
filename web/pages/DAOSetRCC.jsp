<%-- 
    Document   : DAOSetRCC
    Created on : 29 Sep, 2014, 1:07:18 PM
    Author     : dipesh
--%>

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
    /*ArrayList<RemotecenterCapacity> remoterCenterCapacity = new ArrayList<RemotecenterCapacity>();
     UtilityProcess process = new UtilityProcess();
      remoterCenterCapacity = process.rccDetails(Integer.parseInt(workshopid));
       
    Gson gson = new Gson();
    gson.toJson(remoterCenterCapacity);
     System.out.println("generating data");
     out.print(gson.toJson(remoterCenterCapacity));
      System.out.println("generating data2");*/
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            @import "paginate/css/demo_page.css";
            @import "paginate/css/demo_table_jui.css";
            @import "paginate/css/jquery-ui-1.8.4.custom.css";  
        </style>
        <style>
            #a_button{
                text-decoration: none;
            }
            #ubutton{
                 /*border-radius: 10px;*/
                 /*background: #162638;*/
                 /*color: white;*/
            }
        </style>
    </head>
    <body>
        <div id="hor-minimalist-a" align='center' style="text-align: center; width: 97%;">
            <label style="font: 50px; color: #28343b;"><b> Remote Center Capacity Details </b></label>
        </div>
        <table class="content_container" style= "width: 100%" id="rounded-corner" align="center" >
            <thead>
                <tr>
                    <th>Sr. no</th>
                    <th class="sortable-text" scope="col">Remote Center Id</th>
                    <th class="sortable-text">Remote Center Name</th>
                    <th class="sortable-text">Available Seats</th>
                    <th class="sortable-text">Available Accomodation</th>
                    <th class="ordinarytext">Update</th>
                </tr>
            </thead>
            <tbody>
                <% int k = 1;%>
                <s:iterator value="remoterCenterCapacity">
                    <tr>
                        <td><%=k%></td>
                        <td><s:property value="rcid"/></td>
                        <td><s:property value="remotecentername"/></td>
                        <td><s:property value="available_seats"/></td>
                        <td><s:property value="available_accomo"/></td>
                        <td>
                            <a id="a_button" href="updateRCCapacity.html?workshopid=<%=workshopid%>&rcid=<s:property value="rcid"/>&avseats=<s:property value="available_seats"/>&avaccomo=<s:property value="available_accomo"/>"><input id="ubutton" type="button" value="Update" /></a>  
                        </td>
                    </tr> 
                    <% k++;%>
                </s:iterator>
            </tbody>
        </table>    
    </body>
</html>