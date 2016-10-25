<%-- 
    Document   : workshopsIndex
    Created on : 1 Sep, 2014, 10:55:18 AM
    Author     : Abinaya
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
    SimpleStringCipher cipher = new SimpleStringCipher();
    String update = (request.getParameter("update"));
    String rcid = cipher.encrypt("all");
    String rcid_main = cipher.encrypt("1001");
    String status = cipher.encrypt("all");
    String test = cipher.encrypt("view");
    String decrypt_update = cipher.decrypt(update);
    String status_confirmed = cipher.encrypt("Confirmed");
    String state = cipher.encrypt("21"); /* default set to maharashtra*/
%>
<body>
    <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId != 1}'>
        <h3>Workshops Index</h3>

        <div class="form_enclosure">    
            <table class="content_container1">
                <thead>
                    <tr>
                        <td>Workshop Id</td>
                        <td>Workshop Name</td>
                        <td>Details</td>
                    </tr>
                </thead>
                <tbody>
                    <s:iterator value="workshopContents">
                        <s:if test="%{workshopExpiry == 1}">
                            <tr>     
                                <% if (decrypt_update.equals("auto_link")) {
                                %>      

                                <s:if test="%{categorycode == 4 && respectiveCoWorkshopid !=0}">                                   
                                    <td><s:property value="workshopid"/></td>
                                    <td><s:property value="workshopname"/></td>
                                    <td><a href="generateMoodleLink.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&type=coordinator">Click here to generate links</a></td>
                                </s:if><s:else>                                    
                                </s:else>
                                <% } else if (decrypt_update.equals("attendance")) {

                                %>
                                <s:if test="%{categorycode ==5 || categorycode == 7 || categorycode ==4 || categorycode == 8}">
                                    <td><s:property value="workshopid"/></td>
                                    <td><s:property value="workshopname"/></td>
                                    <td><a href="programScheduleAdmin.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid%>">Click Here</a></td>
                                </s:if>
                                <% } else {
                                    if (decrypt_update.equals("certificate")) {
                                %>
                                <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
                                    <td><s:property value="workshopid"/></td>
                                    <td><s:property value="workshopname"/></td>
                                    <s:if test="%{certificateGroupRC == 1}">
                                        <td><a href="viewRCForCertificates.html?update=<%=test%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid%>&status=<%=status%>">Click Here</a></td>
                                    </s:if>
                                        <s:if test="%{without_RC == 1}"><td><a href="viewInstitutesForCertificates.html?update=<%=test%>&workshopid=<s:property value="workshopid_encrypted"/>&ins=<%=rcid%>&status=<%=status%>">Click Here</a></td></s:if>

                                </s:if>
                                <%
                                } else {
                                    if (decrypt_update.equals("attendance1")) {
                                %>
                                <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
                                    <td><s:property value="workshopid"/></td>
                                    <td><s:property value="workshopname"/></td>
                                    <td><a href="viewAttendanceDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_main%>">Click Here</a></td>
                                </s:if>
                                <% } else if (decrypt_update.equals("viewattendance")) {%>
                                <s:if test="%{categorycode ==5 || categorycode == 7 || categorycode == 8}">
                                    <td><s:property value="workshopid"/></td>
                                    <td><s:property value="workshopname"/></td>
                                    <td><a href="participantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid%>&status=<%=status_confirmed%>">Click Here</a></td>
                                </s:if>
                                <% } else if (decrypt_update.equals("paymentdetails")) {%>
                                <s:if test="%{categorycode ==5 || categorycode == 7 || categorycode == 8}">
                                    <td><s:property value="workshopid"/></td>
                                    <td><s:property value="workshopname"/></td>
                                    <td><a href="paymentDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid%>&status=<%=status_confirmed%>">Click Here</a></td>
                                </s:if>
                                <% } else {%>
                                <td><s:property value="workshopid"/></td>
                                <td><s:property value="workshopname"/></td>
                                <s:if test="%{categorycode ==4 || categorycode == 6}">                          
                                    <% if (decrypt_update.equals("status") || decrypt_update.equals("view") || decrypt_update.equals("updateReg")) {%>
                                    <td><a href="participantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid%>&status=<%=status%>">Click Here</a></td>
                                    <%} else {
                                        if (decrypt_update.equals("details")) {%>
                                    <td><a href="updateParticipantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid%>&status=<%=status%>">Click Here</a></td>
                                    <% } else if (decrypt_update.equals("auto_link")) {
                                    %>
                                    <td><a href="generateMoodleLink.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&type=coordinator">Click here to generate links</a></td>
                                    <%
                                            }
                                        }%>
                                </s:if>
                                <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}" >
                                    <% if (decrypt_update.equals("status") || decrypt_update.equals("view") || decrypt_update.equals("updateReg")) {%>
                                    <s:if test="%{categorycode == 8 && without_RC == 1}">
                                    <td><a href="participantDetailsSW.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&state=<%=state%>&status=<%=status%>">Click Here</a></td>    
                                    </s:if><s:else>
                                    <td><a href="participantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_main%>&status=<%=status%>">Click Here</a></td>
                                    </s:else>  
                                    <%} else {
                                        if (decrypt_update.equals("details")) {%>
                                    <td><a href="updateParticipantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_main%>&status=<%=status%>">Click Here</a></td>
                                    <% } else if (decrypt_update.equals("auto_link")) {
                                    %>
                                    <td><a href="generateMoodleLink.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&type=main">Click here to generate links</a></td>

                                    <% }
                                        }%>
                                </s:if>
                                <%}
                                        }
                                    }
                                %>

                            </tr>
                        </s:if>
                    </s:iterator>

                </tbody> 
            </table>
        </div>
    </s:if>
    <s:else>
    </s:else>
</body>

