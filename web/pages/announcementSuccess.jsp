<%-- 
    Document   : announcementSuccess
    Created on : 9 Oct, 2014, 1:54:39 PM
    Author     : asl
--%>

<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
   session = ServletActionContext.getRequest().getSession();
   String message="";
   try{
    message=(String)session.getAttribute("message");
   }catch(NullPointerException ex){ex.printStackTrace();}
    session.removeAttribute("message");
    //if(message.equals(null) || message.length()==0){
    //   message = "";
   // }
%>
<body>
     <div>
        <%=message%><br>
     </div><br><br>
    <div class="form_enclosure"> 
    <div style="padding: 20px;">
        Click Here to go Back  <a href="adminHome.html">Admin Home</a><br><br>
        Click Here to go Back  <a href="manageAnnouncements.html">Manage Announcement</a>
    </div>
    </div>
</body>

