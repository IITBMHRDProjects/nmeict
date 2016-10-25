<%-- 
    Document   : DAOSetPageContent
    Created on : 5 Mar, 2015, 5:54:31 PM
    Author     : asl
--%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="org.project.process.UtilityProcess"%>
<%
  String val="";
  String content="";
  ArrayList<Content> contents = null;
  try{
      val=request.getParameter("contenttype");
  }catch(Exception e){
     val="";
  }
  
  if(!val.trim().equals("")){
     UtilityProcess upro=new UtilityProcess();
     contents= new ArrayList<Content>();
     contents=upro.getPage_Content(val);
     Gson gson = new Gson();
     gson.toJson(contents);
     out.print(gson.toJson(contents));
     
  }else{
     Gson gson = new Gson();
     gson.toJson(content);
     out.print(content);
  }
%>
