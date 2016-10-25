<%-- 
    Document   : DAOCreateExcel_NotRegisterData
    Created on : 8 Jul, 2015, 11:35:05 AM
    Author     : asl
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.utilities.ExcelRead"%>
<%
    String context = getServletContext().getRealPath("/");
    try {
        ExcelRead exr = new ExcelRead();
        int res = exr.setQuery_notRegisterData(context);
        String filename = "";
        Gson gson = new Gson();
        if (res > 0) {
            filename="InviteButNotRegister";
            gson.toJson(filename);
            out.print(gson.toJson(filename));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
