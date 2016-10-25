<%-- 
    Document   : faq
    Created on : 25 Aug, 2014, 7:08:15 PM
    Author     : mayank
--%>

<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<body> 
    <!-- Message Error -->
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <!-- End Message Error -->
    <% String faqcontent = "";
        ArrayList<Content> contents = null;
        Content data = new Content();
        UtilityProcess process = new UtilityProcess();
        try {
            contents = new ArrayList<Content>();
            contents = process.getPage_Content("FAQ");
            for (int k = 0; k < contents.size(); k++) {
                data = (org.project.bean.Content) contents.get(k);
                faqcontent = (String) data.getContent();
            }
        } catch (Exception e) {
            faqcontent = "";
        }
    %>
    <% if (!faqcontent.trim().equals("")) {%>
    <s:set var="content"><%= faqcontent%></s:set>
    <s:property escape="false" value="content"/>
    <% } else { %>
    <h3>Frequently Asked Questions</h3>
    <div class="form_enclosure">        
        <form id="tobefilled" class="" action="">   
            <div class="form_settings">
               FAQs
            </div>
        </form>
    </div>
    <% }%>
</body>
