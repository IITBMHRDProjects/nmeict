<%-- 
    Document   : footer
    Created on : 5 Jun, 2014, 3:36:49 PM
    Author     : asl
--%>

<%@page import="org.project.process.UserProcess"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
        int visitorIds =0;
        try{
          visitorIds =(Integer)session.getAttribute("visitorId");
        }catch(Exception e) {
         // e.printStackTrace();
        }
%>
<div id="scroll">
    <a title="Scroll to the top" href="#"><img src="images/top.png" alt="top" /></a>
</div>
<footer>
    <!--<p><img src="images/twitter.png" alt="twitter" />&nbsp;<img src="images/facebook.png" alt="facebook" />&nbsp;<img src="images/rss.png" alt="rss" /></p>-->
   <!-- <p><a href="home.html">Home</a> | <a href="announcements.html">Announcements</a> | <a href="workshopsConducted.html">Workshops Conducted</a> | <a href="team.html">Our Team</a> | <a href="contactus.html">Contact Us</a> | <a href="#"> Site Map</a></p> ---->
   <div align=right><a href="#">Scroll to the Top</a></div> 
   <p>Designed & Developed By Core Software Team, ASL Lab, IIT Bombay © </p>
   <p>Sponsored by Ministry of Human Resources and Development (MHRD), India</p>
    <p>You are visitor number : <b><%=visitorIds%></b></p>             
</footer>


