<%-- 
    Document   : header
    Created on : 5 Jun, 2014, 3:36:36 PM
    Author     : asl
--%>

<%@page import="org.project.process.UserProcess"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>

<%
    UserProcess uproc = new UserProcess();
    //tracing the ip address of every user who visit the website.
    //getting the VisitorIpAddress from the session
    String ipAddress = (String) session.getAttribute("VisitorIpAddress");

    if (ipAddress == null) { //checking whether ipAddress is null or not
        //if null then
        ipAddress = request.getHeader("X-FORWARDED-FOR"); //checking for proxy
        if (ipAddress == null) { //if not proxy
            ipAddress = request.getRemoteAddr(); //getting the client ip address
        }
        session.setAttribute("VisitorIpAddress", ipAddress);
        int visitorId = uproc.trackVisitor(ipAddress);
        session.setAttribute("visitorId", new Integer(visitorId));
    }
%>
<header>         
    <div id="logo">         
        <s:if test="#session.loggedInUser != null">
            <div id="login-display">
                <span class="loggedIn">Welcome, <s:property value="#session.loggedInUser.firstName"/> |</span>
                <span id="showmore" class="settings">&nbsp;</span>
            </div>
            <div id="settingoptions">
                <span id="profile"><a href="updateProfile.html">Edit Profile</a></span>
                <span id="changePass"><a href="changePass.html">Change Password</a></span>
                <span id="logout"><a href="logout.html">Logout</a></span>
            </div>   
        </s:if>
        <s:else>
            <div id="login-display">
                <a style="color: white" href="login.html">Login</a> 
            </div>
        </s:else>
    </div>
    <nav>
        <div id="menu_container">
            <ul class="sf-menu" id="nav">
                <li><a href="home.html">Home</a></li>
                <li><a href="About_Us.html">About Us</a></li>
                <li><a href="announcements.html">Announcements</a></li> 
                 
                 <li><a href="faq.html">FAQ</a></li>
                 <!--<li><a href="gallery.html">Gallery</a></li>-->
                 <li><a href="downloads.html">Downloads</a></li>                 
                 <li><a href="workshopsConducted.html">Workshops Conducted</a></li>
                 <!--<li><a href="team.html">Team</a></li>-->
                <li><a href="contactus.html">Contact Us</a></li>
            </ul>
        </div>
    </nav>
</header>   
