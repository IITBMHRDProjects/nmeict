<%-- 
    Document   : viewAttendanceWT
    Created on : 5 Aug, 2015, 3:07:07 AM
    Author     : asl
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!-- modernizr enables HTML5 elements and feature detects -->
<script type="text/javascript" src="js/modernizr-1.5.min.js"></script>   
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.easing-sooper.js"></script>
<script type="text/javascript" src="js/jquery.sooperfish.js"></script>
<script type="text/javascript" src="js/project_common.js"></script>
<script type="text/javascript" src="js/jquery.tipTip.minified.js"></script>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>

<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script language="JavaScript" src="js/jquery.tipTip.minified.js"></script>       
<script>
    var $jQuery2 = jQuery.noConflict(true);
</script>
<script type="text/javascript">
    $(function() {
        $(".tipTip").tipTip({defaultPosition: "right"});
    });
</script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<!DOCTYPE html>

<% String email = "", name = "", rc = "";
    try {
        email = ServletActionContext.getRequest().getParameter("email");
        rc = ServletActionContext.getRequest().getParameter("rc");
        name = ServletActionContext.getRequest().getParameter("name");
        SimpleStringCipher cipher = new SimpleStringCipher();
        email = cipher.decrypt(email);
        name = cipher.decrypt(name);
        rc = cipher.decrypt(rc);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<body>
    <s:if test='%{#session.loggedInUser.roleId > 1}'>
        <div style="text-align: center;">
            <h3 style="color: #036;font-weight: bold;font-size: 220%;text-align: center; ">Attendance Details</h3>
        </div>
        <div style="padding-left: 30%;">
            <table>
                <tr>
                    <td><span style="font-weight: bold;font-size: 120%;"><b>Name</b>: </span></td>
                    <td><span style="font-size: 120%;"><%= name%></span></td>
                </tr>
                <tr>

                    <td><span style="font-weight: bold;font-size: 120%;"><b> Email</b> : </span></td>
                    <td><span style="font-size: 120%;"><%= email%></span></td>

                </tr>
                <tr>
                    <td><span style="font-weight: bold;font-size: 120%;"><b> Remote Center</b> : </span></td>
                    <td><span style="font-size: 120%;"><%= rc%></span></td>
                </tr>
            </table>

        </div>
        <div style="padding-left: 30%;">
            <span style="font-weight: bold;font-size: 120%;"><b>Total number of sessions </b>: </span>
            <% int total = 0;%>
            <s:iterator value="attendance">
                <s:set var="nos" value="%{numberOfSessions}"/>
                <%
                    String tot = (String) request.getAttribute("nos");
                    total = total + Integer.parseInt(tot);
                %>
            </s:iterator>
            <span style="font-size: 120%;"><%=total%></span>
            <br>
            <span style="font-weight: bold;font-size: 120%;"><b>Total number of sessions attended </b>: </span>
            <% int total2 = 0;%>
            <s:iterator value="attendance">
                <s:set var="nos" value="%{sessionAttend}"/>
                <%
                    String tot2 = (String) request.getAttribute("nos");
                    total2 = total2 + Integer.parseInt(tot2);
                %>
            </s:iterator>
            <span style="font-size: 120%;"><%=total2%></span>
            <br>
        </div>
            <br><br>
        <div style="padding-left: 30%; width: 40%;">
            <div style="overflow-x: scroll;">
            <table id="mytable" class="table" style="">
                <thead id="tablehead" name="tablehead">
                    <tr>
                        <th>Day</th>
                        <th>No. of Session</th>
                        <th>Session Attended</th>
                    </tr>
                </thead>
                <tbody id="mytablebody1" name="tablebody">
                    <s:iterator value="attendance" status="userStatus">
                        <tr>
                            <td style="text-align: center;"><s:property value="date_string"/></td>
                            <td style="text-align: center;"><s:property value="numberOfSessions"/></td>
                            <td style="text-align: center;"><s:property value="sessionAttend"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>
                <br><br><br><br>
            </div>
        </div>  
    </s:if>
    <script type="text/javascript">
        /*$(document).ready(function() {
        $('#mytable').dataTable({
            // paging: false,
            //searching: false 
            iDisplayLength: 50,
            "order": []
        });
    });*/
        $jQuery2(function(){
            $jQuery2('#mytable').dataTable({
                // paging: false,
                //searching: false 
                iDisplayLength: 50,
                "order": []
            });
        });
    
        $(document).ready(function() {
            // alert('Row index: ' + table.row().length);

        });



    </script>
</body>

