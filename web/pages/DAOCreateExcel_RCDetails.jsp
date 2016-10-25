<%-- 
    Document   : DAOCreateExcel_RCDetails
    Created on : 29 Sep, 2015, 12:49:51 PM
    Author     : dipesh
--%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<% 
   String context = getServletContext().getRealPath("/");
    try {
        UtilityProcess uprocess=new UtilityProcess();
        int res = uprocess.setQuery_RCDetailsData(context);
         String filename = "";
        Gson gson = new Gson();
        if (res > 0) {
            filename="RCDetails";
            gson.toJson(filename);
            out.print(gson.toJson(filename));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

%>
