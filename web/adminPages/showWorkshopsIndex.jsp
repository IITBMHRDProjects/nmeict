<%-- 
    Document   : showWorkshopsIndex
    Created on : 27 Nov, 2015, 3:14:21 PM
    Author     : dipesh
--%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
    SimpleStringCipher cipher = new SimpleStringCipher();
    String update = (request.getParameter("update"));
    String rcid=cipher.encrypt("all");
    String rcid_main = cipher.encrypt("1001");
    String status = cipher.encrypt("all");
    String decrypt_update=cipher.decrypt(update);
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
                        <td> Details</td>
                    </tr>
                </thead>
                <tbody>
                    <s:iterator value="workshopContents">
                        <s:if test="%{workshopExpiry == 1}">
                            <tr>
                                <td><s:property value="workshopid"/></td>
                                <td><s:property value="workshopname"/></td>
                                <s:if test="%{categorycode ==4 || categorycode == 6}">
                                    <% if(decrypt_update.equals("status") || decrypt_update.equals("view")){ %>
                                <td><a href="participantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid%>&status=<%=status%>">Click Here for Details</a></td>
                                <%} else if(decrypt_update.equals("details")){ %>
                                <td><a href="updateParticipantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid%>&status=<%=status%>">Click Here for Details</a></td>
                                <% } else if(decrypt_update.equals("listworkshop")){ %>
                                <td><a href="participantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid%>&status=<%=status%>">Click Here for Details</a></td>
                                <% } else if(decrypt_update.equals("listworkshopreport")){ %>
                                <td><a href="faculyOfInstituteReport.html?workshopid=<s:property value="workshopid_encrypted"/>">Click Here for Details</a></td>
                                <% } %>
                                </s:if>
                                <s:if test="%{categorycode == 5 || categorycode == 7|| categorycode == 8}" >
                                <% if(decrypt_update.equals("status") || decrypt_update.equals("view")){ %>
                                <td><a href="participantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_main%>&status=<%=status%>">Click Here for Details</a></td>
                                <%} else if(decrypt_update.equals("details")){ %>
                                <td><a href="updateParticipantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_main%>&status=<%=status%>">Click Here for Details</a></td>
                                <% } else if(decrypt_update.equals("listworkshop")){ %>
                                <td><a href="participantDetails.html?update=<%=update%>&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<%=rcid_main%>&status=<%=status%>">Click Here for Details</a></td>
                                <% } else if(decrypt_update.equals("listworkshopreport")){ %>
                                <td><a href="faculyOfInstituteReport.html?workshopid=<s:property value="workshopid_encrypted"/>">Click Here for Details</a></td>
                                <% } %>
                                </s:if>
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
