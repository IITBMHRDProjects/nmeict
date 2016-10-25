<%-- 
    Document   : DAOcheckUsername
    Created on : 9 Jan, 2015, 2:41:58 PM
    Author     : asl
--%>

<%@page import="org.project.process.UserProcess"%>
<%
    String username = request.getParameter("username");
    UserProcess uproc = new UserProcess();
        boolean isUsernameAvailable = uproc.isUsernameAvailable(username);
        if(isUsernameAvailable) {
            out.print("true");
        } else {
            out.print("false");
        } 
%>
