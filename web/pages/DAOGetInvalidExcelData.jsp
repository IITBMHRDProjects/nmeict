<%-- 
    Document   : DAOGetInvalidExcelData
    Created on : 26 Jun, 2015, 3:46:14 PM
    Author     : asl
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.utilities.ExcelRead"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.project.bean.Person"%>
<%
    try {
        String upid = request.getParameter("fileid");
        Person person;
        ArrayList<Person> personsdata = new ArrayList<Person>();
        ExcelRead exr = new ExcelRead();
        personsdata = exr.gelAllInvalidRecords(Integer.parseInt(upid));
        Gson gson = new Gson();
        gson.toJson(personsdata);
        out.print(gson.toJson(personsdata));
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
