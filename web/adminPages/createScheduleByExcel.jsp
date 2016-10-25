<%-- 
    Document   : createScheduleByExcel
    Created on : 30 Nov, 2015, 11:40:03 AM
    Author     : dipesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
   <script>
    function oncheckField1() {
         var val = 0;
        document.getElementById("excelreadError").style.display = "none";
        var exfile = document.getElementById("excelread").value;
        if (exfile.trim() == "" || exfile.trim() == null) {
            val++;
            document.getElementById("excelreadError").style.display = "inline";
        } else {
             var resExt=validateLetter1(exfile);
             if(resExt == false){
                 val++;
                 document.getElementById("excelreadError").style.display = "inline";
             }
        }

        if (val > 0) {
            return false;
        }
    }

    function validateLetter1(letter)
    {
        var result = false;
        var filext = (getExt1(letter)).toLowerCase();
        result = ((letter != null) && (letter != "") && (filext == "xls"));
        return result;
    }
    function getExt1(filename) {
        var dot_pos = filename.lastIndexOf(".");
        if (dot_pos == -1)
            return "";
        return filename.substr(dot_pos + 1).toLowerCase();
    }
    
    function onResetButton(){
        document.getElementById("excelreadError").style.display = "none";
        document.getElementById("excelread").value="";
        
    }
</script>

<body>
    <h3>Create Program Schedule By Excel Upload</h3>
    <p>Use the template for uploading <a href="<s:url value="Excel_Sheets/programScheduleByExcel_template.xls"></s:url>" >click here</a></p>
    <p>Workshopid ,Date ,Time Slot (from), Time Slot (to), Attendance Counted fields are mandatory</p>
    <div class="form_enclosure">   
        <form action="docreateScheduleByExcel.html"  method="post" enctype="multipart/form-data" onsubmit="return oncheckField1();">
            <div class="form_settings">    
                <div class="form_box">
                    <p>
                        <span>Upload the File :(.xls)</span><sup><img src="images/star.png"></sup>
                        <input type="file" id="excelread"  name="excelread"/>
                        <label id="excelreadError" class="errormsg">Please choose the file (only in .xls)</label>
                    </p><br>
                    <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" />
                        <input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="onResetButton()"/>
                    </p> 
                </div>
            </div>
        </form>
    </div>
    <br><br>
    <div>
      
    </div>
</body>
<script>
    function disErr(){
        document.getElementById("suberr").style.display="none";
    }
</script>



