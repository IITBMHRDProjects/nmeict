<%-- 
    Document   : announcements
    Created on : 5 Aug, 2014, 5:20:21 PM
    Author     : Abinaya
--%>

<%@page import="org.project.process.UtilityProcess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<div class="form_enclosure">
    <h1><s:property value="getText('announcements.heading')"/></h1>
    <h4 align="center"><s:property value="getText('announcements.sponser')"/></h4>
    <br/>
    <div class="form_settings">
        <table class="content_container">
            <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId == 1}'>
            <s:set name="newusId" value="%{#session.loggedInUser.loginId}" />
            <% 
                int id=(Integer)request.getAttribute("newusId");
                UtilityProcess uprocess=new UtilityProcess();
                String res="false";
                  res=uprocess.checkParticipantExistInRelevantWorkshop(5000021, id);
                 if(res.toLowerCase() == "true"){
              %>
              <td>
              <b>Effective Teaching Workshop on Computer Programming- TEST </b> <a href="workshopContent.html?workshopid=L_82TaprCnaWTf6HZvhILw">(details)</a>
              </td>
              <% } %>
        </s:if>
            <s:iterator value="announcements">
                <tr> 
                    <td>
                        <b><s:property value="announcement"/></b> <a style="padding-left: 20px;" href="<s:property value="link"/>" ><s:property value="getText('announcements.details')"/></a>
                    </td>
                </tr>   
            </s:iterator>
        </table>
    </div>
</div>
