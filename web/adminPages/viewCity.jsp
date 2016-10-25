<%-- 
    Document   : viewCity
    Created on : 24 Feb, 2015, 2:43:09 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<script type="text/javascript" src="js/jquery.js"></script>
<script>
    var $jQuery1 = $.noConflict(true);
</script>
<script type="text/javascript" src="validation/validate.js"></script>
<script type="text/javascript" src="js/ajaxedit.js"></script>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>

<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script>
    var $jQuery2 = jQuery.noConflict(true);
</script>
<script type="text/javascript">
    function loadConfigTable(){
        var category=document.getElementById("category").value;
        fetchConfigDetails(category);
    }
    function updateCity(id){
        window.open("updateCity.html?id="+id);
    }
    function newRC(){
        window.open("updateCity.html?id=newCity");
    }
</script>
<body> 

    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>

    <h3>City</h3>
    <br/>
    <h4>
        <b>Click the button to create a New City</b>
        <button class="completedButton" style="position: relative; bottom: 10px;" onclick="newRC()">New</button>
    </h4>
    <br/><br/>

    <table class="display1" id="configtable1"  cellpadding="0" cellspacing="0" style="font-size: 90%;width:770px;">

        <thead id = "headers" > 
            <tr>
                <th>S.No</th>                
                <th>City</th>
                <th>State</th>
                <th>Is Active</th>                               
                <s:if test='%{#session.loggedInUser.roleId == "5"}'>
                    <th>Update</th>
                </s:if>               
            </tr>
        </thead>
        <tbody align="center" id="configtableBody1" >            
            <s:iterator value="city" status="itStatus">
                <tr class="gradeU">
                    <td><s:property value="#itStatus.count" /></td>
                    <td><s:property value="cityName"/></td>
                    <td><s:property value="state.stateName"/></td>
                    <td><s:property value="isActive"/></td>
                    <s:if test='%{#session.loggedInUser.roleId == "5"}'>
                        <td style="padding:0px 0px;white-space: nowrap;" />
                            <button class="approvedButton" onclick="updateCity('<s:property value="cityId"/>')">Update</button>
                        </td>
                    </s:if>        
                </tr>
            </s:iterator>            
        </tbody>  
    </table>
    <script type="text/javascript">
        /*$(document).ready(function() {
            $('#configtable1').dataTable({
                //                                                "scrollX": true
            });
        });*/
          $jQuery2(function(){
            $jQuery2('#configtable1').dataTable({
                // paging: false,
            });
        });
    </script>
</body>