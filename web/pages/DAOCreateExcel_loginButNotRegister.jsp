<%-- 
    Document   : DAOCreateExcel_loginButNotRegister
    Created on : 16 Jul, 2015, 12:52:15 PM
    Author     : asl
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<% 
   String context = getServletContext().getRealPath("/");
    try {
        UtilityProcess uprocess=new UtilityProcess();
        int res = uprocess.setQuery_loginButNotRegisterData(context);
         String filename = "";
        Gson gson = new Gson();
        if (res > 0) {
            filename="LoginButNotRegister";
            gson.toJson(filename);
            out.print(gson.toJson(filename));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

%>
