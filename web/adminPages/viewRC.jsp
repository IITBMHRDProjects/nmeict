<%-- 
    Document   : viewRC
    Created on : 9 Feb, 2015, 10:38:42 AM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
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
<script type="text/javascript">
    $(function() {
        $(".tipTip").tipTip({defaultPosition: "right"});
    });
</script>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
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
<script type="text/javascript">
    $(function() {
        $(".tipTip").tipTip({defaultPosition: "right"});
    });
</script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<!DOCTYPE html>
<script type="text/javascript">
    function updateRC(enc_rc){
        window.open("updateRC.html?rcid="+enc_rc);
    }
    function newRC(){
        window.open("updateRC.html?rcid=newRC");
    }
</script>
<%
    SimpleStringCipher cipher = new SimpleStringCipher();
%>
<s:if test='%{#session.loggedInUser.roleId > 1}'>
    <h1 style="color: #036;font-weight: bold;font-size: 220%;text-align: center;">Manage Remote Centers</h1>
    <br/>
    <s:if test='%{#session.loggedInUser.roleId == 6}'>
        <h4>
            <b>Click the button to create a New Remote center</b>
            <button class="completedButton" style="position: relative; bottom: 10px;" onclick="newRC()">New RC</button>
        </h4>
        <br/><br/>
    </s:if>
        <div>
            <b>Export to Excel</b> <a onclick="create_RCDetails();" style="position:relative;left:20px;top:10px;" title="Export to Excel"><img src="images/savexls.png"/></a>
        </div><br><br>    
    <div style="width: auto;  overflow: scroll;">
        <table class="display1" id="remotecenter" style="font-size: 100%;width:auto;text-wrap:pre-wrap;">
            <thead id = "headers" > 
                <tr>
                    <th>S.No</th>
                    <th>RC ID</th>
                    <th>Remote Center Name</th>
                    <th>RC Coordinator Email</th>
                    <th style="text-align:center;">City</th>
                    <th>State</th>
                    <th >Pin code</th>
                    <th>District</th>
                    <th>Respective Institute</th>
                    <th>Affiliated University</th>
                    <th>Active</th>                 
                    <!--<th>Is RCC Appr oved</th>-->
                    <th>Is Auton omous</th>
                    <th>Acad Cale Start date</th>
                    <th>Logo</th>
                    <s:if test='%{#session.loggedInUser.roleId == 6 || #session.loggedInUser.roleId == 5}'>
                        <th>Update</th>
                    </s:if>
                </tr>
            </thead>
            <tbody align="center" id="remotecenter" >
                <s:iterator value="remoteCenter" status="itStatus">
                    <tr class="gradeU" style="padding:2px 2px">
                        <td style="align:right; white-space: pre-wrap;" id="sno_<s:property value="#itStatus.count" />"><s:property value="#itStatus.count" /></td>
                        <td style="white-space: nowrap;"><s:property value="remoteCenterId"/></td>
                        <td style="padding: 0 0;white-space: pre-wrap;"><s:property value="remoteCenterName"/></td>
                        <td style="padding: 0 0;white-space: nowrap;"><s:property value="rc_coordinator_email"/></td>
                        <td style="padding: 0 0;white-space: pre-wrap;text-align: center;"><s:property value="rc_city" /></td>
                        <td style="padding: 0 0;white-space: pre-wrap;text-align: center;"><s:property value="rc_state" /></td>
                        <td style="padding: 0 0;white-space: nowrap;text-align: center;"><s:property value="pincode" /></td>                     
                        <td style="padding: 0 0;white-space: pre-wrap;text-align: center;"><s:property value="district" /></td>
                        <td style="padding: 0 0;white-space:  pre-wrap;text-align: center;"><s:property value="instituteName" /></td>
                        <td style="padding: 0 0 ;white-space: pre-wrap;text-align: center;"><s:property value="affiliated_university"/></td>

                        <s:if test='%{isactive == 1}'>
                            <td style="padding : 0 0;white-space: nowrap;text-align: center;" >Yes</td>
                        </s:if>
                        <s:else>
                            <s:if test='%{isactive == 0}'><td style="padding: 0 0;white-space: nowrap;text-align: center;">No</td></s:if>
                            <s:else><td style="padding: 0 0;white-space: nowrap;text-align: center;">Prospective</td></s:else>
                        </s:else>
                        <!--<td style="padding: 0 0 ;white-space: nowrap;text-align: center;"><s:property value="rc_status"/></td>-->

                        <td style="padding: 0 0 ;white-space: prewrap;text-align: center"><s:property value="rc_autonomous"/></td>
                        <td style="padding: 0 0 ;white-space: nowrap;alignment-adjust: central"><s:property value="academic_cal"/></td>
                        <td><a href="certificate_templates/logo/<s:property value="remoteCenterId" />.png" target="_blank">logo</a></td>

                        <s:if test='%{(#session.loggedInUser.roleId == 6 || #session.loggedInUser.roleId == 5) }'>
                            <td style="padding:0px 0px;white-space: nowrap;" id="update_<s:property value="#itStatus.count" />">
                                <button class="approvedButton" onclick="updateRC('<s:property value="rc_enc"/>')">Update</button>
                            </td>
                        </s:if>
                    </tr> 
                </s:iterator> 
            </tbody>  
        </table>
    </div>
    <script type="text/javascript">
        /*$(document).ready(function() {
            $('#remotecenter').dataTable({
                //                                                "scrollX": true
            });
        });*/
         $jQuery2(function(){
            $jQuery2('#remotecenter').dataTable({
                // paging: false,
            });
        });
    </script>
    <script>
        function create_RCDetails() {
            var data = "";
            $.ajax({
                url: "pages/DAOCreateExcel_RCDetails.jsp",
                type: "GET",
                data: data,
                dataType: "json",
                success: excel_rcdetailsSuccess,
                error: onError
            });
        }

        function excel_rcdetailsSuccess(data) {
            var url = "Excel_Sheets/" + data + ".xls";
            window.location.assign(url);
        }

        function onError(jqXHR, textStatus, errorThrown) {
            alert("Error : " + textStatus + " " + errorThrown);
        }
    </script>
</s:if>
