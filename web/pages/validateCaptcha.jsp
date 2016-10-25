<%-- 
    Document   : validateCaptcha
    Created on : 8 Mar, 2011, 5:40:41 PM
    Author     : rkjangir
--%>

<%@ page import="nl.captcha.Captcha" %>

<% 
    Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
    String answer = request.getParameter("answer");
    if (captcha.isCorrect(answer)) { 
        out.print("true");
     } else {
        out.print("false");
    }
%>