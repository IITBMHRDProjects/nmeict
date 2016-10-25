<%-- 
    Document   : UpdateRCCSuccess
    Created on : 14 Oct, 2014, 3:32:40 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
    /*$(document).ready(function() {
     setTimeout(function() {
     $("#update_success").fadeOut().empty();
     }, 10000);
     });*/
</script>
<body>
    <% if (updt_result.equals("update success")) {%>
    <h3>Successfully Updated</h3>

    <div class="form_enclosure">
        <div style="padding-bottom: 10px;">
            <div id="update_success" style=""><br><font color="green">Successfully Updated Data</font><br> </div>
        </div>
        <div style="padding: 20px;">
            <a href="manageRCCapacity.html?workshopid=none&state=0">Click Here to See Changes</a>
        </div>
    </div>

    <% } else if (updt_result.equals("no update")) {%>
    <h3>Update Failed.</h3>
    <div class="form_enclosure">
        <div style="padding-bottom: 10px;">
            <div id="update_success" style=""><br><font color="red">No updated data</font><br> </div>
        </div>
        <div style="padding: 20px;">
            <a href="manageRCCapacity.html?workshopid=none&state=0">Click Here to See Changes</a>
        </div>
    </div>
    <% } else if (updt_result.equals("already use")) {%>
    <h3>The link is obselete.</h3>
    <div class="form_enclosure">
        <div style="padding-bottom: 10px;">
            Dear User,<br>
            <div id="update_success" style=""><br>The Remote Center Capacity Information is already present.
                <br> Please mail to 'supportemail' to update the Capacity.</div>
        </div>
    </div>

    <% } else if (updt_result.equals("user inserted")) {%>
    <h3>Successfully Added Remote Center Capacity Information</h3> 
    <div class="form_enclosure">
        Dear Coordinator,
        <div style="padding-bottom: 10px;">
            <div id="update_success" style=""><br><font color="green">The Remote Center Capacity information is added successfully .
                To update your Remote center seating capacity, please send an email to senderemail .</font><br> </div>
        </div>
        </div>

    <% } else if (updt_result.equals("user failed")) {%>
    <h3>Failed..</h3> 
    <div class="form_enclosure">
        <div style="padding-bottom: 10px;">
            <div id="update_success" style=""><br><font color="red">Data not inserted for Remote Center.</font><br>
                Please contact at  'support email' .</div>
        </div>
    </div>
    <% }%>


</body>
