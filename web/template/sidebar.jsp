<%-- 
    Document   : sidebar
    Created on : 5 Jun, 2014, 4:08:59 PM
    Author     : asl
--%>

<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags"%>
<!DOCTYPE html>
<%  UtilityProcess process = new UtilityProcess();
    Content data = new Content();
%>
<div id="sidebar_container">
    <div class="sidebar">
       <h3>News</h3>
        <%
            String news = "";
            ArrayList<Content> news_contents = null;
            try {
                news_contents = new ArrayList<Content>();
                news_contents = process.getPage_Content("latestnews");
                for (int j = 0; j < news_contents.size(); j++) {
                    data = (org.project.bean.Content) news_contents.get(j);
                    news = (String) data.getContent();
                }
            } catch (Exception e) {
                news = "";
            }
            if (!news.trim().equals("")) {
        %>
        <s:set var="latestnews"><%= news%></s:set>
        <s:property escape="false"  value="latestnews"/>
        <% } else if (news.equals("")) { %>
        <p>News to be updated in sidebar</p>
               <% } %>
    </div>
    <div class="sidebar">
        <h3>Important Links</h3>
        <%
            String importantlinks = "";
            ArrayList<Content> implinks_contents = null;
            try {
                implinks_contents = new ArrayList<Content>();
                implinks_contents = process.getPage_Content("importantlinks");
                for (int k = 0; k < implinks_contents.size(); k++) {
                    data = (org.project.bean.Content) implinks_contents.get(k);
                    importantlinks = (String) data.getContent();
                }
            } catch (Exception e) {
                importantlinks = "";
            }
        %>
        <% if (!importantlinks.trim().equals("")) {%>
        <s:set var="importantlinks"><%= importantlinks%></s:set>
        <s:property escape="false" value="importantlinks"/>
        <s:if test='%{#session.loggedInUser != null}'>
            <s:if test="ifSubscribed == 0">
                <li>
                    <a href="subscribe.html?ide=<s:property value="#session.loggedInUser.loginName"/>">Subscribe to newsletters</a>
                </li>
            </s:if>
        </s:if> 
        <s:else>
            <a href="subscribeHere.html">Subscribe to newsletters</a>
        </s:else>
        <% } else { %>
        <ul>
            <li>Important links list</li> 
        </ul>
        <s:if test='%{#session.loggedInUser != null}'>
            <s:if test="ifSubscribed == 0">
                <li>
                    <a href="subscribe.html?ide=<s:property value="#session.loggedInUser.loginName"/>">Subscribe to newsletters</a>
                </li>
            </s:if>
        </s:if> 
        <s:else>
            <a href="subscribeHere.html">Subscribe to newsletters</a>
        </s:else>
        <% }%>
    </div>
</div>          
