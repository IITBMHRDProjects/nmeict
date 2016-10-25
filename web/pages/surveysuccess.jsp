<%-- 
    Document   : surveysuccess
    Created on : 23 Apr, 2015, 3:18:37 PM
    Author     : asl
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
    <h3>Submission Successful</h3>
    <div class="form_enclosure">
        <p>
            Thank you for submitting your response for the Blended MOOCs from IIT Bombay .
        </p>
    </div>

    <% } else {
        if (result_status.equals("error")) { %>
    <h3>Submission Failed</h3>
    <div class="form_enclosure">
        <p style="color: red;">
            Failed in Saving the Details
        </p>
    </div>
    <% } else
        if (result_status.equals("rc_already_present")) { %>
    <h3>Already Fill the Survey Details</h3>
    <div class="form_enclosure">
        <p>Dear User,</p>
        <p style="color: red;">
            Your Institute has already submitted  the response form  for the Blended MOOCs from IIT Bombay .
        </p>
    </div>
    <% } else {%>
    <h3>Error</h3>
    <div class="form_enclosure">
        <p>
            Enable to execute your request.
        </p>
    </div>
    <% }

        }%>
</body>

