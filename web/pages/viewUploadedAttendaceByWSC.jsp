<%-- 
    Document   : viewUploadedAttendaceByWSC
    Created on : 2 Dec, 2015, 11:47:39 AM
    Author     : dipesh
--%>

<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script>
    var $jQuery1 = $.noConflict(true);
</script>
<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script language="JavaScript" src="js/jquery.tipTip.minified.js"></script>       
<script>
    var $jQuery2 = jQuery.noConflict(true);
</script>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <body>
        <s:iterator value="workshopContent">
            <input id="lms_moodle" type="hidden" value="<s:property value="lms_moodle"/>"/>
            <input id="lms_iitbx" type="hidden" value="<s:property value="lms_iitbx"/>"/>
            <input id="moodle_coursename" type="hidden" value="<s:property value="moodle_coursename"/>"/>
            <input id="iitbx_coursename" type="hidden" value="<s:property value="iitbx_coursename"/>"/>
            <h1 style="color: #036;font-weight: bold;font-size: 220%;text-align: center;"><s:property value="workshopname" /></h1>
            <h4 align="center"><s:property value="sponsor"/></h4>
            <br/>
            <input id="workshopid" value="<s:property value="workshopid"/>" type="hidden"/>
            <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4> 
            <h4 style="color: #FF4500;font-weight: bold;text-align: center;">View Uploaded Attendance Sheet</h4>
        </s:iterator> 
        <% int srno = 0;%>
        <div style="padding: 10px;">
            <br><br>
            <table id="mytable" class="table">
                <thead id="tablehead" name="tablehead">
                    <tr>
                        <td>Sr. No.</td>
                        <td style="width: 200px; text-align: center;">Date</td>
                        <td>Attendance Files</td>
                    </tr>
                </thead>
                <tbody id="mytablebody"  name="tablebody">
                    <s:iterator value="details" status="userStatus">
                        <tr>
                            <td><%= ++srno%></td>
                            <td><s:property value="upload_date"/></td>
                            <td><a href="AttendancePDF/<s:property value="upload_fileName"/>" target="_blank">Attendance<%= srno%></a></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>
        </div>
    </body>
    <script>
        $jQuery2(function(){
            $jQuery2('#mytable').dataTable({
                // paging: false,
                //searching: false 
                // iDisplayLength: 50,
                // "order": []
            });
        });
    </script>
</html>
