<%-- 
    Document   : AddNewHeadDetailsSuccess
    Created on : 7 Apr, 2015, 11:37:00 AM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<body>
    <%
        String result_status = "";
        try {
            result_status = (String) session.getAttribute("result");
            session.removeAttribute("result");
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <% if (result_status.equals("success")) { %>
    <h3>Insert Successful</h3>
    <div class="form_enclosure">
        <p>
            Head Details inserted successfully .
        </p>
    </div>
     
    <% } else if (result_status.equals("error")) { %>
    <h3>Insert Failed</h3>
    <div class="form_enclosure">
        <p style="color: red;">
            Head Details insert failed.
        </p>
    </div>
    <% } else if (result_status.equals("alreadyPresent")) { %>
    <h3>Data Already Exist.</h3>
    <div class="form_enclosure">
        <p style="color: red;">
            Head Details data is already exist.
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
