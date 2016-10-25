<%-- 
    Document   : DAO_checkIfEmailExist
    Created on : 24 Aug, 2016, 3:30:53 PM
    Author     : dipesh
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UserProcess"%>
<%
    String email = request.getParameter("email");
    UserProcess uproc = new UserProcess();
    int flag=0;
        String isEmailAvailable = uproc.checkIfEmailExist(email);
        System.out.println(isEmailAvailable);
        if(isEmailAvailable.equals("notexistinlogin")) {
            flag=1;
        } else {
            flag=0;
        }
    Gson gson = new Gson();
    gson.toJson(flag);
    out.print(gson.toJson(flag));     
%>
