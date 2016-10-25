<%-- 
    Document   : updateRC
    Created on : 9 Feb, 2015, 10:38:57 AM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript" src="validation/validate.js"></script>
<script type="text/javascript" src="js/ajaxedit.js"></script>
<script type="text/javascript">
    function changeState() {
        var stateID = document.getElementById('state').value;
        // clearing pincode and district
        document.getElementById("pincode").value="";
        document.getElementById("district").value="";        
        if (stateID != -1) {
            fetchCity(stateID);
        } else {
            document.getElementById("state").value = "-1";
            var x = document.getElementById("cityInstitute");
            for (var i = x.length; i > 0; i--) {
                x.remove(i);
            }
            document.getElementById("cityInstitute").value="-1";
        }
    }
    
    function fetchIns(){        
        var cityId=document.getElementById("cityInstitute").value;       
        fetchInstitute12(cityId);
    }
</script>
<%
    String rcid = request.getParameter("rcid");
%>
<body> 
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <h3>Remote Center</h3>
    <div class="form_settings">
        <div class="form_box">

            <form action="doUpdateRC.html" enctype="multipart/form-data" method="post" onsubmit="return validateRCForm(this);">
                <br/><br/>
                <p><span>RC ID  <sup><img src="images/star.png"></sup></span>
                            <%if (rcid.equals("newRC")) {
                            %>
                    <input type="text" id="rcid" name="rc_details.remoteCenterId" value="<s:property value='rc_details.remoteCenterId'/>" class="tipTip" title="<s:property value="getText('form.rcidtitle')"/>"/>  
                    <input type="hidden" id="isnewrc" value="1" name="rc_details.isnew"/>
                    <%} else {
                    %>
                    <input disabled type="text" id="rcid" name="rc_details.remoteCenterId" value="<s:property value='rc_details.remoteCenterId'/>"/>  
                    <input  type="hidden"  name="rc_details.remoteCenterId" value="<s:property value='rc_details.remoteCenterId'/>"/>  
                    <input type="hidden" id="isnewrc" value="0" name="rc_details.isnew"/>
                    <%}%>
                    <label id="rcidError"  class="errormsg"><s:property value="getText('form.rcidError')"/></label>
                </p><br/>
                <p><span>Remote Center Name  <sup><img src="images/star.png"></sup></span>
                    <input type="text" id="rc" name="rc_details.remoteCenterName" value="<s:property value='rc_details.remoteCenterName'/>" class="tipTip" title="<s:property value="getText('form.rcnametitle')"/>"/>  
                    <label id="rcError"  class="errormsg"><s:property value="getText('form.rcnameError')"/></label>
                </p><br/>
                <p>
                    <span>Select State  <sup><img src="images/star.png"></sup>
                    </span>
                    <select id="state" name="rc_details.rc_state" onchange="changeState();">
                        <option value="-1">--Select State--</option>
                        <s:iterator var="stateList" value="stateList" >
                            <s:if test="#stateList.stateId ==rc_details.rc_state">
                                <option selected value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                            </s:if>
                            <s:else>
                                <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                            </s:else>
                        </s:iterator>
                    </select> 
                    <label id="stateError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.stateError')"/></label>
                </p><br/>
                <p>
                    <span>Select City  <sup><img src="images/star.png"></sup>
                    </span>
                    <select id="cityInstitute" name="rc_details.rc_city" onchange="fetchIns();">
                        <option value="-1">--Select City--</option>
                        <s:iterator var="cityList" value="cityList" >
                            <s:if test="#cityList.cityId == rc_details.rc_city">
                                <option selected value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                            </s:if>
                            <s:else>
                                <option value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                            </s:else>
                        </s:iterator>
                    </select> 
                    <label id="cityError"  class="errormsg"><s:property value="getText('InstituteUpdate.City')"/></label>
                </p><br/>
                <p><span>Pin code  <sup><img src="images/star.png"></sup></span>
                    <input type="text" id="pincode" name="rc_details.pincode" maxlength="6" value="<s:property value='rc_details.pincode'/>" class="tipTip" title="<s:property value="getText('form.pincode')"/>"/>  
                    <label id="pincodeError"  class="errormsg"><s:property value="getText('instituteUpdate.pincodeError')"/></label>
                </p><br/>
                <p><span>District  <sup><img src="images/star.png"></sup></span>
                    <input type="text" id="district" name="rc_details.district" value="<s:property value='rc_details.district'/>" class="tipTip" title="<s:property value="getText('form.districttitle')"/>"/>  
                    <label id="districtError"  class="errormsg"><s:property value="getText('form.districtError')"/></label>
                </p><br/>
                <p>
                    <span>Select Institute  <sup><img src="images/star.png"></sup>
                    </span>
                    <select id="institute" name="rc_details.res_instituteid">
                        <option value="-1">--Select Institute--</option>
                        <s:iterator var="instituteList" value="instituteList" >
                            <s:if test="#instituteList.instituteId == rc_details.res_instituteid">
                                <option selected value="<s:property value="instituteId"/>"><s:property value="instituteName"/></option>
                            </s:if>
                            <s:else>
                                <option value="<s:property value="instituteId"/>"><s:property value="instituteName"/></option>
                            </s:else>
                        </s:iterator>
                    </select> 
                    <label id="instituteError"  class="errormsg"><s:property value="getText('registrationPage.instituteError')"/></label>
                </p><br/>

                <p>
                    <span>Active/Inactive <sup><img src="images/star.png"></sup></span>
                    <span class="s"  style="width: 270px; font-size: 90%">
                        <s:if test="rc_details.isactive == 1 ">
                            <input  style="width: 13px;height: 13px;padding:0 0 0 0; " id="isActive1" type="radio" name="rc_details.isactive" value="1" checked  />&nbsp;&nbsp;&nbsp;&nbsp; Active   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </s:if>
                        <s:else>                                           
                            <input style="width: 13px;height: 13px;padding:0 0 0 0; " id="isActive1" type="radio" name="rc_details.isactive" value="1" />&nbsp;&nbsp;&nbsp;&nbsp; Active   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </s:else>

                        <s:if test="rc_details.isactive == 0 ">
                            <input  style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="isActive2" name="rc_details.isactive" value="0" checked/>&nbsp;&nbsp;&nbsp; In-Active
                        </s:if>
                        <s:else>                                         
                            <input style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="isActive2" name="rc_details.isactive" value="0" />&nbsp;&nbsp;&nbsp; In-Active
                        </s:else>
                        <br/>
                        <s:if test="rc_details.isactive == -1 ">
                            <input  style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="isActive3" name="rc_details.isactive" value="-1" checked/>&nbsp;&nbsp;&nbsp; Prospective
                        </s:if>
                        <s:else>                                         
                            <input style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="isActive3" name="rc_details.isactive" value="-1" />&nbsp;&nbsp;&nbsp; Prospective
                        </s:else>
                    </span>
                    <span id="isActiveError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('form.isActiveError')" /></span>
                </p><br/><br/>
                <p> <span>Remote Center Coordinator Email  <sup><img src="images/star.png"></sup></span>
                    <input type="text" id="rc_email" name="rc_details.rc_coordinator_email" value="<s:property value="rc_details.rc_coordinator_email"/>" class="tipTip" title="<s:property value="getText('form.email')"/>"/>  
                    <label id="rcemailError"  class="errormsg"><s:property value="getText('emailError')"/></label>
                </p><br/><br/>
                <p style="display:none;">
                    <span>Is RCC Approved?<sup><img src="images/star.png"></sup></span>
                    <span class="s"  style="width: 270px; font-size: 90%">
                        <s:if test="rc_details.rc_status ==  'Yes'">
                            <input  style="width: 13px;height: 13px;padding:0 0 0 0; " id="isStatus1" type="radio" name="rc_details.rc_status" value="Yes" checked  />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </s:if>
                        <s:else>                                           
                            <input style="width: 13px;height: 13px;padding:0 0 0 0; " id="isStatus1" type="radio" name="rc_details.rc_status" value="Yes" />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </s:else>

                        <s:if test="rc_details.rc_status == 'No'">
                            <input  style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="isStatus2" name="rc_details.rc_status" value="No" checked/>&nbsp;&nbsp;&nbsp; No
                        </s:if>
                        <s:else>                                         
                            <input style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="isStatus2" name="rc_details.rc_status" value="No"  checked/>&nbsp;&nbsp;&nbsp; No
                        </s:else>
                    </span>
                    <span id="isStatusError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('form.rc_statusTitleError')" /></span>
                </p>
                <br/><br/>
                <p>
                    <span>Is RC Autonomous?<sup><img src="images/star.png"></sup></span>
                    <span class="s"  style="width: 270px; font-size: 90%">
                        <s:if test="rc_details.rc_autonomous ==  'Yes'">
                            <input  style="width: 13px;height: 13px;padding:0 0 0 0; " id="isStatus3" type="radio" name="rc_details.rc_autonomous" value="Yes" checked  />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </s:if>
                        <s:else>                                           
                            <input style="width: 13px;height: 13px;padding:0 0 0 0; " id="isStatus3" type="radio" name="rc_details.rc_autonomous" value="Yes" />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </s:else>

                        <s:if test="rc_details.rc_autonomous == 'No'">
                            <input  style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="isStatus4" name="rc_details.rc_autonomous" value="No" checked/>&nbsp;&nbsp;&nbsp; No
                        </s:if>
                        <s:else>                                         
                            <input style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="isStatus4" name="rc_details.rc_autonomous" value="No" />&nbsp;&nbsp;&nbsp; No
                        </s:else>
                    </span>
                    <span id="isStatusError1" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('form.rc_statusTitleError1')" /></span>
                </p>
                <br/><br/>

                <p>
                    <span>Academic calendar start date</span>
                    <input type="text" id="academic_cal_startdate"  name="rc_details.academic_cal" value="<s:property value='rc_details.academic_cal'/>" class="tipTip" title="Please enter the academic calendar start date"/> 
                </p><br/>
                <p>
                    <span>Affiliated University</span>
                    <input type="text" id="affiliated_univ"  name="rc_details.affiliated_university" value="<s:property value='rc_details.affiliated_university'/>" class="tipTip" title="Please enter the affiliated university"/> 
                </p><br/>
                <p>
                    <span>RC Logo </span>
                    <input type="file" id="rc_coordinator_signature"  name="rcLogo"/>
                    <label id="signatureError"  class="errormsg"><s:property value="getText('form.signatureError')"/></label>
                </p>

                <br/><br/>
                <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" /><input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="resetRCUpdateForm();"/></p>
            </form>
        </div>
    </div>
</body>