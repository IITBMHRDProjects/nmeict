<%-- 
    Document   : viewInstitute
    Created on : 11 Feb, 2015, 3:50:33 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">       
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title>'Project Name' | Empowerment of Students & Teachers through Synchronous and Asynchronous Instruction</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" href="css/tipTip.css"/>
<link rel="stylesheet" href="css/css3-buttons.css"/>
<!-- modernizr enables HTML5 elements and feature detects -->
<script type="text/javascript" src="js/modernizr-1.5.min.js"></script>   
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.easing-sooper.js"></script>
<script type="text/javascript" src="js/jquery.sooperfish.js"></script>
<script type="text/javascript" src="js/project_common.js"></script>
<script type="text/javascript" src="js/jquery.tipTip.minified.js"></script>
<script>
    var $jQuery1 = $.noConflict(true);
</script>
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
<body>

    <s:if test='%{#session.loggedInUser.roleId > 1}'>
        <p style="text-align: center; font-size: 30px; color: #00336D;">Manage Institute</p>
        <br><br>
        <h4 style="color: black;"> <b>Click on the image to export details of the Institute</b> 
            <a onclick="create_Excel();" style="position:relative;left:20px;top:10px;" title="Export to Excel"><img src="images/savexls.png"/></a>
            </h4>
        <div style="text-align: center; font-size: 18px;">
            <p><span>Select Type of Institute </span> &nbsp;&nbsp;
                <select id="selectInstitute" onchange="ChangeInstituteType(this.value)">
                    <option value="type">Select Type</option>
                    <option value="1">Active</option>
                    <option value="0">In Active</option>
                    <option value="-1">Not Approved</option>
                </select>
            </p>
        </div>
        <br><br>
        <s:hidden id="roletypeid" name="roleid" value="%{#session.loggedInUser.roleId}"/>
        <div style="  margin-left: 5%; margin-right: 5%; padding: 10px; padding-bottom: 50px; overflow: auto; overflow-y: hidden;">
            <div id="resultData" style="text-align: center;">
                <table id="mytable" style="font-size: 90%;width:770px;text-wrap:normal; margin-left: 15%;" class="table">
                    <thead id="tablehead">   
                        <tr>
                            <th>S.No</th>
                            <th>Institute ID</th>
                            <th>Institute Name</th>
                            <th>City</th>
                            <th>State</th>
                            <th>Pin code</th>
                            <th>Address</th>
                            <th>Active Status</th>
                            <s:if test='%{#session.loggedInUser.roleId == 3}'>
                            
                            </s:if>
                            <s:else>
                            <th>Update</th>
                            </s:else>
                            <th>Head Details</th>
                        </tr>
                    </thead>
                    <tbody id="mytable" name="tablebody">

                    </tbody>
                </table>
            </div>
        </div> 
    </s:if>
    <script type="text/javascript">
        /* $(document).ready(function() {
         $('#mytable').dataTable({
         paging: false,
         searching: false                                                                                             "scrollX": true
         });
         });*/
    </script>
</body>
