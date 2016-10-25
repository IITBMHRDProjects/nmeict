<%-- 
    Document   : uploadAttendancebyWSCSuccess
    Created on : 19 Aug, 2015, 2:54:33 PM
    Author     : dipesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String result_status = "";
    try {
        result_status = (String) session.getAttribute("result");
         session.removeAttribute("result");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<body>
    <% if (result_status.equals("success")) { %>
    <h3>Upload Successful</h3>
    <div class="form_enclosure">
        <p>
            Your Attendance successfully uploaded.
        </p>
         <p>To view uploaded scanned copy of attendance sheet <a href="viewAttendanceOfParticipants.html?workshopid=<s:property value="workshopid_enc"/>&rcid=<s:property value="rcid_enc"/>&date=-SIpJewWW2Nr56jHwvqJiw">Click Here</a></p>
    </div>
     
    <% } else if (result_status.equals("error")) { %>
    <h3>Upload Failed</h3>
    <div class="form_enclosure">
        <p style="color: red;">
            Failed in Uploading Attendance.
        </p>
    </div>
    <% } else if(result_status.equals("uploadfailed")){ %>
      <h3>Upload Failed</h3>
    <div class="form_enclosure">
        <p style="color: red;">
            Failed in Storing Attendance.
        </p>
    </div>
    <% } else {%>
      <h3>Error</h3>
    <div class="form_enclosure">
        <p>
            Enable to execute your request.
        </p>
    </div>
    <% } %>
</body>

