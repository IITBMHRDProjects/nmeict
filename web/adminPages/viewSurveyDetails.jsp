<%-- 
    Document   : viewSurveyDetails
    Created on : 23 Apr, 2015, 5:24:17 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
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
<script type="text/javascript">
    $(function() {
        $(".tipTip").tipTip({defaultPosition: "right"});
    });
</script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<body>
     <s:if test='%{#session.loggedInUser.roleId > 1}'>
    <div style="text-align: center; font-size: 20px;">
    <h1>Survey Details</h1>
    </div>
    <div id="typestatus" style="padding: 15px;">
                <table id="mytable" class="table">
                    <thead id="tablehead" name="tablehead">
                        <tr>
                            <th>Email</th>
                            <th>Remote Center Id</th>
                            <th>Remote Center </th>
                            <th>Answer 1</th>
                            <th>Answer 2</th>
                            <th>Answer 3</th>
                            <th>Answer 4</th>
                            <th>Comments</th>
                        </tr>
                    </thead>
                    <tbody id="mytable" name="tablebody">
                        <s:iterator value="surveyform">
                            <tr>
                                <td><s:property value="email"/></td>
                                <td><s:property value="remotecenter.remoteCenterId"/></td>
                                 <td><s:property value="remotecenter.remoteCenterName"/></td>
                                <td><s:property value="field1"/></td>
                                <td ><s:property value="field2"/></td>
                                <td ><s:property value="field3"/></td>
                                <td><s:property value="field4"/></td>
                                <td><s:property value="comments"/></td>
                             </tr>
                        </s:iterator>
                    </tbody>
                </table>
            </div>
            <br>
     </s:if>
      <script type="text/javascript">
        $(document).ready(function() {
            $('#mytable').dataTable({
                // paging: false,
                //searching: false                                                                                             "scrollX": true
            });
        });


    </script>       
</body>

