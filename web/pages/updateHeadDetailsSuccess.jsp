<%-- 
    Document   : updateHeadDetailsSuccess
    Created on : 6 Apr, 2015, 7:08:40 AM
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
    <h3>Update Successful</h3>
    <div class="form_enclosure">
        <p>
            Head Details successfully updated.
        </p>
    </div>
     
    <% } else if (result_status.equals("error")) { %>
    <h3>Update Failed</h3>
    <div class="form_enclosure">
        <p style="color: red;">
            Head Details updated failed.
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

