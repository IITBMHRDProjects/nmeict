<%-- 
    Document   : DAOSubmitContent
    Created on : 5 Mar, 2015, 5:53:29 PM
    Author     : asl
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%
    String val = "";
    String content = "";
    String userId = "";
    String comments="";
    try {
        val = request.getParameter("page");
        content = request.getParameter("content");
        userId = request.getParameter("userId");
        comments = request.getParameter("comments");
    } catch (Exception e) {
        val = "";
        content = "";
        userId = "";
        comments="";
    }
    if (!val.trim().equals("")) {
        UtilityProcess upro = new UtilityProcess();
        int res = upro.setNew_PageContent(content, val, Integer.parseInt(userId),comments);
        Gson gson = new Gson();
        if (res > 0) {
            out.print(gson.toJson("success"));
        } else {
            out.print(gson.toJson("fail"));
        }

    } else {
        Gson gson = new Gson();
        out.print(gson.toJson("null"));
    }
%>
