<%-- 
    Document   : sendSurveySuccess
    Created on : 12 May, 2015, 3:03:18 AM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

   <%
    String result_status = "";
    try {
        result_status = (String) session.getAttribute("mailResult");
        session.removeAttribute("mailResult");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<body>
    <% if (result_status.equals("success")) { %>
    <h3>Successful</h3>
    <div class="form_enclosure">
        <p>
            Mail Send Successfully 
        </p>
    </div>
     
    <% } else if (result_status.equals("error")) { %>
    <h3> Failed</h3>
    <div class="form_enclosure">
        <p style="color: red;">
            Failed in Sending Mails
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

