<%-- 
    Document   : userTypeUpdate
    Created on : 16 Feb, 2015, 12:03:25 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript" src="validation/validate.js"></script>
<script type="text/javascript" src="js/ajaxedit.js"></script>
<script type="text/javascript">
    function checkEmail(){
        var email=document.getElementById("email").value;
        if(email == "" || email == null){
            alert("Please enter a valid email");
        } else{
            ifEmailExist(email);
        }        
    }
    
    function validateForm(formc){
        var val=0;
        var email=formc.email.value;
        
        if(email == "" || email == null){
            document.getElementById("emailError").style.display="inline";
            val++;
        }
        else{ 
            checkEmail(email);
        }
        
        var isEmailExists=document.getElementById("ifEmailExists").value;
        if(isEmailExists == 0){
            val++;
        }
        var role=formc.role.value;
        if(role == "-1"){
            document.getElementById("roleError").style.display="inline";
            val++;
        }
        if(val >0){
            return false;
        } else {
            return true;
        }
    }
</script>
<body>     
    <h3>Update User Type</h3>
    <div class="headmessage">Field marked with <sup><img src="images/star.png"></sup> are mandatory </div>    
    <div class="form_enclosure"> 
        <div class="form_settings">
            <form action="douserTypeUpdate.html"  method="post" onsubmit="return validateForm(this);">
                <div class="form_box">
                    <br/><br/>
                    <input type="hidden" id="ifEmailExists" value="0"/>
                    <p><span>E-mail of the user <sup><img src="images/star.png"></sup></span><input type="text" id="email" name="person_role.email"  maxlength="50" class="tipTip" title="<s:property value="getText('form.email')"/>" value="" onblur="checkEmail();" />
                        <label id="emailError" class="errormsg"><s:property value="getText('registrationPage.emailerror')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headEmailError').get(0)"/></label>
                    </p><br/>
                    <span>Select Role <sup><img src="images/star.png"></sup>
                    </span>
                    <select id="role" name="person_role.roleId" >
                        <option value="-1">--Select Role--</option>
                        <s:iterator var="lookups" value="lookups" >   
                            <option value="<s:property value="code"/>"><s:property value="description"/></option>
                        </s:iterator>
                    </select>
                    <label id="roleError"  class="errormsg"><s:property value="getText('form.roleError')"/></label>
                    <br/><br/>
                    <p><input style="position: relative;left: 50px" class="submit" type="submit" name="submit" value="Update" />
                    </p>
                </div>
            </form>
        </div>
    </div>
</body>