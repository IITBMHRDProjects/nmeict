<%-- 
    Document   : changeMailContentSuccess
    Created on : 13 Mar, 2015, 3:45:26 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<body>
    <%
        String msg = "";
        try {
            msg = (String) session.getAttribute("result");
        } catch (Exception e) {
            msg = "";
        }

        if (msg.equals("fail")) {
    %>
    <div class="form_enclosure">
        <div style="padding-bottom: 10px;">
            <div id="update_success" style=""><br><font color="red">Update Failed</font><br> </div>
        </div>
        <div style="padding: 20px;">
            <a href="changeMailContent.html">Click Here to Go Back</a>
        </div>
    </div>
    <% } else if (msg.equals("success")) { %>
    <div class="form_enclosure">
        <div style="padding-bottom: 10px;">
            <div id="update_success" style=""><br><font color="green">Successfully Updated</font><br> </div>
        </div>
        <div style="padding: 20px;">
            <a href="changeMailContent.html">Click Here to Go Back</a>
        </div>
    </div>
    <% }%>
</body>
