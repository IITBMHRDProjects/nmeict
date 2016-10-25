<%-- 
    Document   : addNewRCCSuccess
    Created on : 20 Jan, 2015, 2:28:21 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<body>
    <%  if (updt_result.equals("already use")) {%>
    <h3>The link is obselete.</h3>
    <div class="form_enclosure">
        <div style="padding-bottom: 10px;">
            Dear User,<br>
            <div id="update_success" style=""><br>The Remote Center Capacity Information is already present.
            </div>
        </div>
    </div>

    <% } else if (updt_result.equals("user inserted")) {%>
    <h3>Successfully Inserted Remote Center Capacity Information</h3> 
    <div class="form_enclosure">
        <div style="padding-bottom: 10px;">
            <div id="update_success" style=""><br><font color="green">Successfully Inserted the Data.</font><br> </div>
        </div>
    </div>

    <% } else if (updt_result.equals("user failed")) { %>
    <h3>Failed..</h3> 
    <div class="form_enclosure">
        <div style="padding-bottom: 10px;">
            <div id="update_success" style=""><br><font color="red">Data not inserted for Remote Center.</font>
            </div>
        </div>
    </div>
    <% } %><br>
     <div style="float: left; margin-top: 10px; padding: 5px;">
            <a href="manageRCCapacity.html?workshopid=none&state=0" style="text-decoration: none;" ><input type="button" style="background: black;color: white; width: 150px; border-radius: 10px;" value="Go Back"/></a>
        </div>
</body>

