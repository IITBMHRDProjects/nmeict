<%-- 
    Document   : createAttendanceNewParticipant
    Created on : 14 Oct, 2015, 2:17:11 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript" language="javascript" src="validation/validate.js"></script>

<script>
    var isnumber=/^0|[1-9]\d*$/;
    function validate(){
        var ret=0;
        var workshopid=document.getElementById("workshopid").value;
        var participantid=document.getElementById("participantid").value;
        
        resetBorderAndError();
        
        if(workshopid == "" || workshopid == null){
            borderRedError("workshopid");
            document.getElementById("workshopNameError").style.display="inline";
            ret++;
        }
        if(participantid == "" || participantid == null){
            borderRedError("participantid");            
            document.getElementById("participantidError").style.display="inline";
            ret++;
        }
        if(isNaN(workshopid)){
            borderRedError("workshopid");
            document.getElementById("workshopNameError").style.display = "inline";
            ret++; 
        }
        if(isNaN(participantid)){
            borderRedError("participantid");
            document.getElementById("participantidError").style.display = "inline";
            ret++; 
        }
        if(ret > 0){
            return false;
        }else{
            return true;
        }
    }
    
    function resetfn(){
        resetBorderAndError();
        document.getElementById("workshopid").value="";
        document.getElementById("participantid").value="";
    }
    
    function resetBorderAndError(){
       
        document.getElementById("workshopid").style.border="";
        document.getElementById("participantid").style.border="";
        document.getElementById("workshopNameError").style.display="none";
        document.getElementById("participantidError").style.display="none"; 
    }
    
    function borderRedError(id) {
        document.getElementById(id).style.border = '1px solid red';
    }
</script>
<body>
    <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId != 1}'>
        <s:if test="hasActionErrors()">
            <div class="msg msg-error">
                <s:actionerror/>
                <a href="javascript:void(0);" class="close">close</a>
            </div>
        </s:if>
        <s:if test="hasActionMessages()">
            <div class="msg msg-ok">
                <s:actionmessage/>
                <a href="javascript:void(0);" class="close">close</a>
            </div>
        </s:if>
        <h3>Insert Attendance of New Participant</h3>
        <div class="form_enclosure">
            <div class="form_settings">
                <form id="manageWorkshopForm" action="insertNewParticipantASheet.html"  method="post" enctype="multipart/form-data" onsubmit="return validate();">
                    <div class="form_box">
                        <br/> <p>
                            <span>Workshop id  <sup><img src="images/star.png"></sup></span>
                            <input type="text" id="workshopid" name="content.workshopid" value=""/>
                            <label id="workshopNameError" class="errormsg"><s:property value="getText('workshopManagementForm.workshopNameError')"/></label>
                        </p><br/>
                        <p>
                            <span>Participant id  <sup><img src="images/star.png"></sup></span>
                            <input type="text" id="participantid" name="participantCount" value=""/>
                            <label id="participantidError" class="errormsg"><s:property value="getText('participantidError')"/></label>
                        </p><br/> 
                        <p style="color: #0063dc;">Make sure that the participant has been Confirmed for the respective workshop. Check is not added.</p>
                        <br/><br/>
                        <p>
                            <input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" />
                            <input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="resetfn();"/>
                        </p>
                    </div>
                </form>
            </div>
        </div> 
    </s:if>
</body>
