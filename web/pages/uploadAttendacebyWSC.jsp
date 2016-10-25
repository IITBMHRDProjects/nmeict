<%-- 
    Document   : uploadAttendacebyWSC
    Created on : 18 Aug, 2015, 4:27:49 PM
    Author     : dipesh
--%>

<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<%
    String workshopid = ServletActionContext.getRequest().getParameter("workshopid");
    String rcid = ServletActionContext.getRequest().getParameter("rcid");
    String date = ServletActionContext.getRequest().getParameter("date");

%>
<body>
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <form id="uploadAttendaceFile" action="douploadAttendacebyWSC.html"  method="post" enctype="multipart/form-data" onsubmit="return validateFileSubmit();">
        <s:set var="wid"><%= workshopid%></s:set>
        <s:set var="rcid"><%= rcid%></s:set>
        <s:set var="date"><%= date%></s:set>
        <s:hidden name="up_wid" value="%{wid}"/>
        <s:hidden name="up_rcid" value="%{rcid}"/>
        <s:hidden name="up_date" value="%{date}"/>
        <div class="form_settings">
            <h3>Upload Attendance</h3>
            <div class="form_box">
                <p><span>Choose File  <sup><img src="images/star.png"></sup> </span>
                    <input type="file" id="upload_attendace_byWSC"  name="upload_attenadance"/><br>
                    
                    <label id="uploadError" class="errormsg">Please Upload only pdf file(less than 2 MB)</label>
                    <label id="upError" class="uploadErrorLabel" style="color: red;"><s:property value="fieldErrors.get('uploadError').get(0)"/></label>
                </p>
                <p style="font-size: 90%; color: #0063dc">upload <b>.pdf</b> file only ( less than 2 MB )</p>
                <br>
                <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" />
                    <input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="ResetFileSubmit();"/></p>
            </div>
        </div>
    </form>
    <script>
        function validateFileSubmit(){
            document.getElementById("uploadError").style.display = "";
            document.getElementById("upError").innerHTML="";
            var value=0;
            var upload_att=document.getElementById("upload_attendace_byWSC").value; 
            if (!(upload_att == "" || upload_att == null)) { 
                var size = document.getElementById("upload_attendace_byWSC").files[0].size;
                var val = validateLetter1(upload_att);
                var val1 = checkFileSize1(size, (1024 * 1024 * 2));
                if (val == false || val1 == false) {
                    // borderRedError("upload_attendace_byWSC");
                    document.getElementById("uploadError").style.display = "inline";
                    value++;
                }
             }
            
            if(upload_att == "" || upload_att == null){
                document.getElementById("uploadError").style.display = "inline";
                value++;
            }
            
           
            
            if(value > 0){
                return false;
            }
        }  
        
        function validateLetter1(letter, size)
        {
            var result = false;
            var filext = (getExt1(letter)).toLowerCase();
            result = ((letter != null) && (letter != "") && (filext == "pdf"));
            return result;
        }
        function getExt1(filename) {
            var dot_pos = filename.lastIndexOf(".");
            if (dot_pos == -1)
                return "";
            return filename.substr(dot_pos + 1).toLowerCase();
        }
        function checkFileSize1(size, requiredSize) {
            var result = false;
            if (size != 0 && size < requiredSize) {
                result = true;
            }
            return result;
        }
        
        function ResetFileSubmit(){
            document.getElementById("uploadError").style.display = "";
            document.getElementById("upError").innerHTML="";
            document.getElementById("upload_attendace_byWSC").value="";
        }
    </script>
</body>

