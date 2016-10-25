<%-- 
    Document   : viewLoginButNotRegister
    Created on : 16 Jul, 2015, 11:16:59 AM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<script type="text/javascript" src="js/modernizr-1.5.min.js"></script>   
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.easing-sooper.js"></script>
<script type="text/javascript" src="js/jquery.sooperfish.js"></script>
<script type="text/javascript" src="js/project_common.js"></script>
<script type="text/javascript" src="js/jquery.tipTip.minified.js"></script>
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
<style>
    h3{
        background: #f6e6b4; /* Old browsers */
        background: -moz-linear-gradient(top, #f6e6b4 0%, #ed9017 84%); /* FF3.6+ */
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f6e6b4), color-stop(84%,#ed9017)); /* Chrome,Safari4+ */
        background: -webkit-linear-gradient(top, #f6e6b4 0%,#ed9017 84%); /* Chrome10+,Safari5.1+ */
        background: -o-linear-gradient(top, #f6e6b4 0%,#ed9017 84%); /* Opera 11.10+ */
        background: -ms-linear-gradient(top, #f6e6b4 0%,#ed9017 84%); /* IE10+ */
        background: linear-gradient(to bottom, #f6e6b4 0%,#ed9017 84%); /* W3C */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f6e6b4', endColorstr='#ed9017',GradientType=0 ); /* IE6-9 */
        border : 2px solid #fda968;
        border-radius: 10px;
        /*width : 740px;*/
        font-style: normal;
        font-family: fantasy;
        /*padding-left: 30%;*/
        /*padding-bottom: 2px;*/
        text-align: center;
    }
</style>
<body>
    <s:if test='%{#session.loggedInUser.roleId > 1}'>
        <div style="text-align: center; margin-left: 20%; margin-right: 20%;">
            <h3>Signed Up But Not Registered in Any Workshop</h3>
        </div>
        <label style="padding: 20px;"> Export Excel</label> <a onclick="create_loginButNotReg();" style="" title="Export to Excel"><img src="images/savexls.png"/></a>

        <div style="padding: 20px;">
            <table id="mytable" class="table">
                <thead id="tablehead" name="tablehead">
                    <tr>
                        <th id="wid" style="background: #E8E8E8;">Sr No</th>
                        <th style=" background: #E8E8E8;">Email</th>
                        <th id="wid" style="background: #E8E8E8;">Name</th>
                        <th id="wid" style="background: #E8E8E8;">Institute ID</th>
                        <th id="wid" style="background: #E8E8E8;">Institute</th>
                    </tr>
                </thead>
                <tbody id="mytable" name="tablebody">
                    <s:iterator value="notregdata" status="itStatus">
                        <tr>
                            <td style=" background: #E8E8E8;"><s:property value="#itStatus.count" /></td>
                            <td style=" background: #E8E8E8;"><s:property value="email"/></td>
                            <td style=" background: #E8E8E8;"><s:property value="firstName"/> <s:property value="lastName"/></td>
                            <td style=" background: #E8E8E8;"><s:property value="institute.instituteId"/></td>
                            <td style=" background: #E8E8E8;"><s:property value="institute.instituteName"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>
        </div>
    </s:if>
    <script type="text/javascript">
        /*$(document).ready(function() {
         $('#mytable').dataTable({
         // paging: false,
         //searching: false                                                                                             "scrollX": true
         });
         });*/

        $jQuery2(function() {
            $jQuery2('#mytable').dataTable({
                // paging: false,
                //searching: false    
            });
        });
    </script>
    <script>
        function create_loginButNotReg() {
            var data = "";
            $.ajax({
                url: "pages/DAOCreateExcel_loginButNotRegister.jsp",
                type: "GET",
                data: data,
                dataType: "json",
                success: excel_notregisterdatasuccess,
                error: onError
            });
        }

        function excel_notregisterdatasuccess(data) {
            var url = "Excel_Sheets/" + data + ".xls";
            window.location.assign(url);
        }

        function onError(jqXHR, textStatus, errorThrown) {
            alert("Error : " + textStatus + " " + errorThrown);
        }
    </script>
</body>

