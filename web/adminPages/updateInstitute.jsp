<%-- 
    Document   : updateInstitute
    Created on : 23 Feb, 2015, 3:19:24 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>

<body>
    <div>
        <h3>Institute Details</h3>
        <div class="form_settings">
            <div class="form_box">
                <form action="doupdateInstitute.html" method="post" onsubmit="return validateInstituteDetails()">
                    <p><span>Institute ID  <sup><img src="images/star.png"></sup></span>
                        <input type="text" id="instituteid" name="institute.instituteId" value="${institute.instituteId}" class="tipTip" title="" disabled="true" />  
                        <label id="instituteIdError"  class="errormsg"><s:property value="getText('form.instituteIdError')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('instituteidError').get(0)"/></label>   
                        <s:set var="institute_id"><s:property value="institute.getInstituteId()"/></s:set>
                        <s:hidden name="idInstitute" id="hidden_instituteId" value="%{institute_id}"/>
                    </p><br/>
                    <p><span>Institute Name  <sup><img src="images/star.png"></sup></span>
                        <input type="text" id="instituteName" name="institute.instituteName" value="${institute.instituteName}" class="tipTip" title="<s:property value="getText('instituteUpdate.validInstituteName')"/>"/>  
                        <label id="instituteNameError"  class="errormsg"><s:property value="getText('instituteUpdate.iname')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('instituteNameError').get(0)"/></label>
                    </p><br/>
                    <p><span>State <sup><img src="images/star.png"></sup></span>
                        <select id="instituteState" class="displayselect" name="institute.state.stateId" onchange="changeState()">
                            <option value="-1">--Select the state--</option>
                            <s:iterator var="stateList" value="stateList">
                                <s:if test="#stateList.stateId == institute.getState().getStateId()">
                                    <option selected value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                        <label id="instituteStateError" class="errormsg"><s:property value="getText('InstituteUpdate.State')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('instituteStateError').get(0)"/></label>
                    </p><br/>
                    <p><span>City <sup><img src="images/star.png"></sup></span>
                        <select id="cityInstitute" class="displayselect" name="institute.city.cityId">
                            <option value="-1">--Select the city--</option>                               
                            <s:iterator var="cityList" value="cityList">
                                <s:if test="#cityList.cityId == institute.getCity().getCityId()">
                                    <option selected value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                        <label id="instituteCityError" class="errormsg"><s:property value="getText('registrationPage.personCityError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('perCityError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.instituteAddress')"/> <sup><img src="images/star.png"></sup></span><textarea rows="5" id="instituteAddress" cols="50" name="institute.instituteAddress" maxlength="230" class="tipTip" title="<s:property value="getText('form.addresschange')"/>"><s:text name="%{institute.instituteAddress}"/></textarea>
                        <label id="instituteAddressError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('instituteAddressError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.institutePincode')"/> <sup><img src="images/star.png"></sup></span>
                                <s:if test="institute.getPincode() == 0">
                            <input type="text" id="institutepincode" name="institute.pincode" value="" maxlength="6" onkeypress="return onlyNumbers(event);" class="tipTip" title="Should be 6 digits"/>
                        </s:if><s:else>
                            <input type="text" id="institutepincode" name="institute.pincode" value="${institute.pincode}" maxlength="6" onkeypress="return onlyNumbers(event);" class="tipTip" title="Should be 6 digits"/>
                        </s:else>
                        <label id="institutePincodeError" class="errormsg" style="float:right;bottom: 20px;"><s:property value="getText('registrationPage.pincodeEmptyError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('institutePincodeError').get(0)"/></label>
                    </p><br/><br/>
                    <p><span>Active Status <sup><img src="images/star.png"></sup></span>
                                <s:if test="institute.getIsActive() == 1">
                            Active&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive1" type="radio" name="institute.isActive" value="1" onclick="sethiddenVal(this.value)" checked/>   &nbsp;&nbsp;&nbsp;
                            <s:hidden id="typeActive" name="typeActive" value="check"/>
                        </s:if>
                        <s:else>
                            Active&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive1" type="radio" name="institute.isActive" value="1" onclick="sethiddenVal(this.value)" />   &nbsp;&nbsp;&nbsp;
                            <s:hidden id="typeActive" name="typeActive" value="uncheck"/>
                        </s:else>
                        <s:if test="institute.getIsActive() == 0">
                            In Active&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive0" type="radio" name="institute.isActive" value="0" onclick="sethiddenVal(this.value)" checked/>   &nbsp;&nbsp;&nbsp;
                            <s:hidden id="typeNotActive" name="typeNotActive" value="check"/>
                        </s:if>
                        <s:else>
                            In Active&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive0" type="radio" name="institute.isActive" value="0" onclick="sethiddenVal(this.value)" />   &nbsp;&nbsp;&nbsp;
                            <s:hidden id="typeNotActive" name="typeNotActive" value="uncheck"/>
                        </s:else>
                        <s:if test="institute.getIsActive() == -1">
                            Not Approved&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive" type="radio" name="institute.isActive" value="-1" onclick="sethiddenVal(this.value)" checked/>   &nbsp;&nbsp;&nbsp;
                            <s:hidden id="typeNotApproved" name="typeNotApproved" value="check"/>
                        </s:if>
                        <s:else>
                            Not Approved&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive-1" type="radio" name="institute.isActive" value="-1" onclick="sethiddenVal(this.value)" />   &nbsp;
                            <s:hidden id="typeNotApproved" name="typeNotApproved" value="uncheck"/>
                        </s:else>
                        <label id="instituteIsActiveError" class="errormsg"><s:property value="getText('instituteUpdate.activeType')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('instituteisActiveError').get(0)"/></label>
                    </p><br/>
                    <p style="text-align: center;">
                        <input type="submit" style="position: relative; width: 75px; background: black; color: white; cursor: pointer" value="Submit"/>
                        <input type="button" style="position: relative; width: 75px; background: black; color: white; cursor: pointer" value="Reset" onclick="resetinstituteAll()"/>
                    </p>
                </form>
            </div>
        </div>
    </div>
</body>

