<%-- 
    Document   : viewConfigTables
    Created on : 18 Feb, 2015, 10:41:50 AM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<script type="text/javascript" src="validation/validate.js"></script>
<script type="text/javascript" src="js/ajaxedit.js"></script>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>

<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>

<script type="text/javascript">
    function loadConfigTable(){
        var category=document.getElementById("category").value;
        fetchConfigDetails(category);
    }
    function updateConfigfn(id){
        window.open("updateConfigDetails.html?id="+id);
    }
    function newRC(){
        window.open("updateConfigDetails.html?id=newConfig");
    }
</script>
<body> 

    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>

    <h3>Configuration Tables</h3>
    <br/>
    <h4>
        <b>Click the button to create a New Config Data</b>
        <button class="completedButton" style="position: relative; bottom: 10px;" onclick="newRC()">New</button>
    </h4>
    <br/><br/>
    <div class="form_box">  <br/>      
        <span>Select Config Table <sup><img src="images/star.png"></sup>
        </span>
        <select id="category" name="lookups.category" onchange="loadConfigTable();">
            <option value="-1">--Select Configuration Table--</option>
            <s:iterator var="lookups" value="lookups" >  
                <option value="<s:property value="category"/>"><s:property value="category"/></option>
            </s:iterator>
        </select>
    </div><br/><br/>
    <p>
        <br/>
    </p>
    <!--<table class="display1" id="configtable1" style="word-spacing: normal;text-wrap: avoid;display: none;">-->
    <table class="display1" id="configtable1"  cellpadding="0" cellspacing="0" style="font-size: 90%;width:770px;">

        <thead id = "headers" > 
            <tr>
                <th>S.No</th>                
                <th>Category</th>
                <th>Code</th>
                <th>Description</th>
                <th>Comments</th>
                <th >Is Active</th>                
                <s:if test='%{#session.loggedInUser.roleId == "5"}'>
                    <th>Update</th>
                </s:if>               
            </tr>
        </thead>
        <tbody align="center" id="configtableBody1" >            

        </tbody>  
    </table>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#configtable1').dataTable({
                //                                                "scrollX": true
            });
        });
    </script>
    <script>
        $(document).ready(function() {
            $("#settingoptions").hide();
            $("#showmore").click(function(e) {
                var x=e.pageX;
                var tmpx=x-200;
                $("#settingoptions").css({left: tmpx});
                $("#settingoptions").slideToggle();
            });
        });
    </script>
</body>