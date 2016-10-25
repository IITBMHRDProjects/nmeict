<%-- 
    Document   : DAOGetPersonByEmail
    Created on : 1 Oct, 2015, 3:33:21 PM
    Author     : Abinaya
--%>

<%@page import="org.project.bean.Person"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.process.UserProcess"%>
<%@page contentType="text/json" pageEncoding="UTF-8"%>
<%
    UserProcess process = new UserProcess();
    String email = request.getParameter("email");
    Person person = process.getPerson(email);
    Gson gson = new Gson();
    gson.toJson(person);
    if(person.getLoginName() == null || person.getLoginName() ==""){
    person.setLoginName("undefined");
    }
    out.print(gson.toJson(person));
%>
