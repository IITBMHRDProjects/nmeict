<%-- 
    Document   : updateHeadDetails
    Created on : 31 Mar, 2015, 11:26:14 AM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<body onload="checkZero1()">
    <% String id = request.getParameter("instituteid");%>
    <div>
        <h3>Update Institute Head Details</h3>
        <div class="form_settings">
            <div class="form_box">
                <form action="doupdateHeadDetails.html" method="post" onsubmit="return validateHeadDetails('update')">
                    <br><p><span>Institute ID  <sup><img src="images/star.png"></sup></span>
                        <input type="text" id="instituteid" name="headdetails.instituteId" value="<%= id%>" class="tipTip" title="" disabled="true" />  
                        <label id="instituteIdError"  class="errormsg"><s:property value="getText('form.instituteIdError')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('instituteidError').get(0)"/></label>   
                        <s:set var="institute_id"><%= id%></s:set>
                        <s:hidden name="idInstitute" id="hidden_instituteId" value="%{institute_id}"/>
                    </p><br/>
                    <br><p><span>Stream  <sup><img src="images/star.png"></sup></span>
                        <input type="text" id="stream" name="head_details.stream" value="${head_details.stream.streamName}" class="tipTip" title="" disabled="true" />  
                        <label id="streamError"  class="errormsg"><s:property value="getText('form.instituteIdError')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('instituteidError').get(0)"/></label>
                        <s:set var="stream"><s:property value="head_details.getStream().getStreamId()"/></s:set>
                        <s:hidden name="streamId" id="hidden_streamId" value="%{stream}"/>
                    </p><br/>
                    <p><span>Head Name  <sup><img src="images/star.png"></sup></span>
                        <input type="text" id="HeadName" name="head_details.name" value="${head_details.name}" class="tipTip" title="<s:property value="getText('form.name')"/>"/>  
                        <label id="HeadNameError"  class="errormsg"><s:property value="getText('HeadUpdate.hname')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headNameError').get(0)"/></label>
                    </p><br/>
                    <p><span>Head Email  <sup><img src="images/star.png"></sup></span>
                        <input type="text" id="HeadEmail" name="head_details.email" value="${head_details.email}" class="tipTip" title="<s:property value="getText('form.email')"/>"/>  
                        <label id="HeadEmailError"  class="errormsg"><s:property value="getText('HeadUpdate.hemail')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headEmailError').get(0)"/></label>
                    </p><br/>
                    <p><span>Head Title <sup><img src="images/star.png"></sup></span>
                        <select id="head_title_id" class="displayselect" name="head_details.headtitle.headTitleId" onchange="">
                            <option value="-1">--Select the title--</option>
                            <s:iterator var="head_title" value="head_title">
                                <s:if test="#head_title.headTitleId == head_details.getHeadtitle().getHeadTitleId()">
                                    <option selected value="<s:property value="headTitleId"/>"><s:property value="headTitleName"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="headTitleId"/>"><s:property value="headTitleName"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                        <label id="HeadTitleError" class="errormsg"><s:property value="getText('HeadUpdate.htitle')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headTitleError').get(0)"/></label>
                    </p><br/>
                    <p><span>Head Designation <sup><img src="images/star.png"></sup></span>
                        <select id="head_designation_id" class="displayselect" name="head_details.headdesignation.headDesignationId" onchange="">
                            <option value="-1">--Select the designation--</option>
                            <s:iterator var="head_designation" value="head_designation">
                                <s:if test="#head_designation.headDesignationId == head_details.getHeaddesignation().getHeadDesignationId()">
                                    <option selected value="<s:property value="headDesignationId"/>"><s:property value="headDesignationName"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="headDesignationId"/>"><s:property value="headDesignationName"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                        <label id="HeadDesignationError" class="errormsg"><s:property value="getText('HeadUpdate.hdesignation')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headDesignationError').get(0)"/></label>
                    </p><br/>
                    <p><span>Head Address <sup><img src="images/star.png"></sup></span><textarea rows="5" id="headAddress" cols="50" name="head_details.headaddress" maxlength="230" class="tipTip" title="<s:property value="getText('form.addresschange')"/>"><s:text name="%{head_details.headaddress}"/></textarea>
                        <label id="HeadAddressError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headAddressError').get(0)"/></label>
                    </p><br/>
                    <p><span>Head Contact <sup><img src="images/star.png"></sup></span>
                        <s:if test="head_details.getHeadphone() == 0">
                            <input type="text" id="headphone" name="head_details.headphone" value="${head_details.headphone}" maxlength="12" onkeypress="return onlyNumbers(event);" class="tipTip" title="<s:property value="getText('form.phone')"/>"/>
                        </s:if><s:else>
                            <input type="text" id="headphone" name="head_details.headphone" value="${head_details.headphone}" maxlength="12" onkeypress="return onlyNumbers(event);" class="tipTip" title="<s:property value="getText('form.phone')"/>"/>
                        </s:else>
                        <label id="HeadPhoneError" class="errormsg" style="float:right;bottom: 20px;"><s:property value="getText('registrationPage.phoneIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headPhoneNumberError').get(0)"/></label>
                    </p><br/><br/>
                    <p><span>Active Status <sup><img src="images/star.png"></sup></span>
                                <s:if test="head_details.getIsActive() == 1">
                            Active&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive1" type="radio" name="head_details.isActive" value="1" onclick="sethiddenVal(this.value)" checked/>   &nbsp;&nbsp;&nbsp;
                            <s:hidden id="typeActive" name="typeActive" value="check"/>
                        </s:if>
                        <s:else>
                            Active&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive1" type="radio" name="head_details.isActive" value="1" onclick="sethiddenVal(this.value)" />   &nbsp;&nbsp;&nbsp;
                            <s:hidden id="typeActive" name="typeActive" value="uncheck"/>
                        </s:else>
                        <s:if test="head_details.getIsActive() == 0">
                            In Active&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive0" type="radio" name="head_details.isActive" value="0" onclick="sethiddenVal(this.value)" checked/>   &nbsp;&nbsp;&nbsp;
                            <s:hidden id="typeNotActive" name="typeNotActive" value="check"/>
                        </s:if>
                        <s:else>
                            In Active&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive0" type="radio" name="head_details.isActive" value="0" onclick="sethiddenVal(this.value)" />   &nbsp;&nbsp;&nbsp;
                            <s:hidden id="typeNotActive" name="typeNotActive" value="uncheck"/>
                        </s:else>
                        <s:if test="head_details.getIsActive() == -1">
                            Not Approved&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive" type="radio" name="head_details.isActive" value="-1" onclick="sethiddenVal(this.value)" checked/>   &nbsp;&nbsp;&nbsp;
                            <s:hidden id="typeNotApproved" name="typeNotApproved" value="check"/>
                        </s:if>
                        <s:else>
                            Not Approved&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="isActive-1" type="radio" name="head_details.isActive" value="-1" onclick="sethiddenVal(this.value)" />   &nbsp;
                            <s:hidden id="typeNotApproved" name="typeNotApproved" value="uncheck"/>
                        </s:else>
                        <label id="HeadIsActiveError" class="errormsg"><s:property value="getText('instituteUpdate.activeType')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headisActiveError').get(0)"/></label>
                    </p><br/>
                    <p style="text-align: center;">
                        <input type="submit" style="font: 100% 'Droid Sans', arial; border: 0; width: 99px;  height:  33px; padding: 2px 0 3px 0; cursor: pointer; background: #222; color: #FFF;border-radius: 7px 7px 7px 7px;-moz-border-radius: 7px 7px 7px 7px;-webkit-border: 7px 7px 7px 7px;" value="Submit"/>
                        <input type="button" style="font: 100% 'Droid Sans', arial; border: 0; width: 99px;  height:  33px; padding: 2px 0 3px 0; cursor: pointer; background: #222; color: #FFF;border-radius: 7px 7px 7px 7px;-moz-border-radius: 7px 7px 7px 7px;-webkit-border: 7px 7px 7px 7px;" value="Reset" onclick="resetAllHead()"/>
                    </p>
                </form>
            </div>
        </div>
    </div> 
</body>

