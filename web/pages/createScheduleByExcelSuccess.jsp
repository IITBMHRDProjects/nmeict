<%-- 
    Document   : createScheduleByExcelSuccess
    Created on : 30 Nov, 2015, 12:55:14 PM
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
    <% if (result_status.equals("success")) {%>
    <h3>Upload Successful</h3>
    <div class="form_enclosure">
        <p>
            Program Schedule successfully uploaded.
        </p>
    </div>

    <% } else if (result_status.equals("error")) {%>
    <h3>Upload Failed</h3>
    <div class="form_enclosure">
        <p style="">
            <span style="color: red;">Failed</span> in Uploading Program Schedule.
        </p>
        <p>
        <table><tr>
                <td>Row Number</td>
                <td>Error Message</td>
            </tr>
            <s:iterator value="resultOutput">
                <tr>
                    <td><s:property value="row_num"/></td>
                    <td style="color: red;"><s:property value="validate_error"/></td>
                </tr>
            </s:iterator>
        </table>
    </p>
</div>
<% } else if (result_status.equals("uploadfailed")) {%>
<h3>Upload Failed</h3>
<div class="form_enclosure">
    <p style="color: red;">
        Failed in Uploading.
    </p>
</div>
<% } else {%>
<h3>Error</h3>
<div class="form_enclosure">
    <p>
        Enable to execute your request.
    </p>
</div>
<% }%>
</body>

