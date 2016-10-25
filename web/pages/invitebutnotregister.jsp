<%-- 
    Document   : invitebutnotregister
    Created on : 7 Jul, 2015, 11:09:25 AM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<!-- modernizr enables HTML5 elements and feature detects -->
<!--<script type="text/javascript" src="js/modernizr-1.5.min.js"></script>   -->
<script type="text/javascript" src="js/jquery.js"></script>
<!--<script type="text/javascript" src="js/jquery.easing-sooper.js"></script>-->
<!--<script type="text/javascript" src="js/jquery.sooperfish.js"></script>-->
<!--<script type="text/javascript" src="js/project_common.js"></script>-->
<!--<script type="text/javascript" src="js/jquery.tipTip.minified.js"></script>-->
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
    
    function changeState(userinterfaceid, val){        
        changeState_BMW(userinterfaceid, val);
    }
</script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<body>
    <h1 style="color: #036;font-weight: bold;font-size: 220%;text-align: center;">Participants invited but not registered</h1>
     <s:if test='%{#session.loggedInUser.roleId > 1}'>
        <div>


            Export Excel <a onclick="exportToExcel();" style="position:relative;left:20px;top:1px;" title="Export to Excel"><img src="images/savexls.png"/></a>
        </div><br><br>
        <div style="  /*margin-left: 5%; margin-right: 5%; padding: 10px; padding-bottom: 50px;*/ overflow: auto; overflow-y: hidden;">
            <div id="resultData" style="/*text-align: center;*/">
                <table id="mytable" style="/*font-size: 90%;width:770px;text-wrap:normal; margin-left: 15%;*/" class="table">
                    <thead id="tablehead">   
                        <tr>
                            <th>S.No</th>
                            <th>Email</th>
                            <th>Workshop ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>RC ID</th>
                            <th>Institute Name</th>
                            <s:if test='%{#session.loggedInUser.roleId == 3}'>
                            <th>Status</th>
                            </s:if><s:else>
                            <th>Enable/ Disable</th>
                            </s:else>
                        </tr>
                    </thead>
                    <tbody id="mytable" name="tablebody">
                        <% int j = 0;%>
                        <s:iterator value="persondata">
                            <tr>
                                <td><%= ++j%></td>
                                <td><s:property value="email"/></td>
                                <td><s:property value="per_workshopid"/></td>
                                <td><s:property value="firstName"/></td>
                                <td><s:property value="lastName"/></td>
                                <td><s:property value="remoteCenter.remoteCenterId"/></td>
                                <td><s:property value="institute.instituteName"/></td>
                                <s:if test='%{#session.loggedInUser.roleId == 3}'>
                                    <td><s:if test="%{loginId < 0}">Disabled 
                                    </s:if><s:else>Enabled</s:else></td>
                                </s:if>
                                <s:else>
                                <td><s:if test="%{loginId < 0}"><button class="approvedButton" value="enable" onclick="changeState('<s:property value="loginId"/>',this.value);">Enable</button> 
                                    </s:if><s:else><button class="invalidButton" value="disable" onclick="changeState('<s:property value="loginId"/>',this.value);">Disable</button></s:else></td>
                                </s:else>    
                            </s:iterator>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div> 
    </s:if>
    <script type="text/javascript">
        /* $(document).ready(function() {
            $('#mytable').dataTable({
                //  paging: false,
                //   searching: false                                                                                             "scrollX": true
            });
        });*/
        $jQuery2(function(){
            $jQuery2('#mytable').dataTable({
                // paging: false,
                //searching: false    
            });
        });
    </script>
    <script>
        function exportToExcel() {
            createNotRegisterDataExcelSheet();
            //alert('called')
        }

        function createNotRegisterDataExcelSheet() {
            var data = "";
            $.ajax({
                url: "pages/DAOCreateExcel_NotRegisterData.jsp",
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

