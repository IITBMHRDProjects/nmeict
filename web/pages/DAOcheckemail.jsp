<%-- 
    Document   : DAOcheckemail
    Created on : 25 Aug, 2014, 3:08:54 PM
    Author     : mayank
--%>

<%@page import="org.project.process.UserProcess"%>
<%
    String email = request.getParameter("email");
    UserProcess uproc = new UserProcess();
        boolean isEmailAvailable = uproc.isEmailAvailable(email);
        if(isEmailAvailable) {
            out.print("true");
        } else {
            out.print("false");
        }
%>