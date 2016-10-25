<%-- 
    Document   : updateProfile
    Created on : Oct 10, 2014, 10:59:47 AM
    Author     : mayank
--%>

<%@page import="org.project.bean.Person"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<script type="text/javascript" src="validation/validate.js"></script>
<%
    String updateUser = "";
    try {
        updateUser = request.getParameter("tmpl");
    } catch (Exception e) {
        updateUser = "";
        e.printStackTrace();
    }
    if (updateUser == null) {
        updateUser = "";
    }
%>
<body onload="checkZero()">  
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <p>Last updated on  <s:property value="person.last_login1"/></p>
    <h3>Edit Profile</h3>
    <div class="headmessage">Field marked with <sup><img src="images/star.png"></sup> are mandatory </div>    
    <div class="form_enclosure"> 
        <% if (updateUser.equals("uprl")) {%>
        <form id="registrationForm" action="doupdateProfile1.html"  method="post" enctype="multipart/form-data" onsubmit="return validateProfilePage(this);">
            <% } else {%>
            <form id="registrationForm" action="doupdateProfile.html"  method="post" enctype="multipart/form-data" onsubmit="return validateProfilePage(this);">
                <% }%>
                <div class="form_settings">    
                    <div class="form_box">
                        <h2><s:property value="getText('registrationPage.loginDetails')"/></h2><br/>
                        <p><span><s:property value="getText('registrationPage.email')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="email" name="person.email" value="${person.loginName}" maxlength="50" class="tipTip" title="<s:property value="getText('form.email')"/>" readonly/>
                            <label id="emailError" class="errormsg"><s:property value="getText('registrationPage.emailerror')"/></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('emailError').get(0)"/></label>
                        </p><br/>
                        <%--
                        <p><span><s:property value="getText('registrationPage.cemail')"/> <sup><img src="images/star.png"></sup></span><input id="cemail" type="text" name="confirmEmail" value="${person.loginName}" maxlength="50" class="tipTip" title="<s:property value="getText('form.cemail')"/>" onblur="funCE()"/>
                            <label id="cerror" class="errormsg"><s:property value="getText('registrationPage.cemailerror')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('cemailError').get(0)"/></label>
                        </p><br/>
                        --%>
                        <%-- username commented
                        <p><span><s:property value="getText('registrationPage.username')"/> <sup><img src="images/star.png"></sup></span>
                            <s:if test="person.getUsername().trim().length() !=0"><input type="text" id="username" name="person.username" value="${person.username}" maxlength="30" class="tipTip" title="<s:property value="getText('form.username')"/>" readonly/></s:if>
                            <s:else>
                                <input type="text" id="username" name="person.username" value="${person.username}" maxlength="30" class="tipTip" title="<s:property value="getText('form.username')"/>" onblur="checkUserName();"/>
                            </s:else>
                            <label id="usernameError" class="errormsg"><s:property value="getText('registrationPage.usernameerror')"/></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('userNameError').get(0)"/></label>
                            <label id="usernameAvaliable" class="errormsg"><s:property value="getText('error.usernameAvaliable')"/></label>
                            <label id="usernamenotAvaliable" class="errormsg"><s:property value="getText('emailnotAvaliable')"/></label>
                        </p><br/>
                        --%>
                    </div>                
                    <div class="form_box">
                        <h2><s:property value="getText('registrationPage.personalDetails')"/></h2><br/>

                        <p><span><s:property value="getText('registrationPage.yourTitle')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="title" class="displayselect" name="person.Title.titleId">
                                <option value="-1">--Select your title--</option>
                                <s:iterator var="titles" value="titles">
                                    <s:if test="#titles.titleId == person.getTitle().getTitleId()">
                                        <option selected value="<s:property value="titleId"/>"><s:property value="titleName"/></option>
                                    </s:if>    
                                    <s:else>
                                        <option value="<s:property value="titleId"/>"><s:property value="titleName"/></option>
                                    </s:else> 
                                </s:iterator>
                            </select>
                            <label id="titleError" class="errormsg"><s:property value="getText('registrationPage.titleError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('titleError').get(0)"/></label>
                        </p><br/>
                        <p><span><s:property value="getText('registrationPage.firstName')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="firstName" name="person.firstName" maxlength="15" value="${person.firstName}" class="tipTip" title="<s:property value="getText('form.name')"/>" onblur="convertValue(this.value, 'firstName');"/>
                            <label id="firstNameError" class="errormsg"><s:property value="getText('registrationPage.fnameIsEmpty')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('firstNameError').get(0)"/></label>
                        </p><br/>
                        <%-- title="<s:property value="getText('form.name')"/>" --%>
                        <p><span><s:property value="getText('registrationPage.lastName')"/> </span><input type="text" id="lastName" name="person.lastName" maxlength="15" value="${person.lastName}"  onblur="convertValue(this.value, 'lastName');"/>
                            <label id="lastNameError" class="errormsg"><s:property value="getText('registrationPage.lnameIsEmpty')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('lastNameError').get(0)"/></label>
                        </p><br/>

                        <p id="showName" style="color: #4746A1;display:none"><br/></p>

                        <%-- aadhar id and year of birth commented
                        <p><span><s:property value="getText('registrationPage.aadharid')"/> </span>
                            <s:if test="person.getUsername().trim().length() !=0">
                                <input type="text" id="aadharid" name="person.aadharId" maxlength="12" value="${person.aadharId}" onkeypress="return onlyNumbers(event);" class="tipTip" title="<s:property value="getText('form.aadharid')"/>" readonly/>
                            </s:if>
                            <s:else>
                                <input type="text" id="aadharid" name="person.aadharId" maxlength="12" value="${person.aadharId}" onkeypress="return onlyNumbers(event);" class="tipTip" title="<s:property value="getText('form.aadharid')"/>" />
                            </s:else>
                            <label id="aadharidError" class="errormsg"><s:property value="getText('registrationPage.aadharidCheck')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('adharIdError').get(0)"/></label>
                        </p><br/><br/>
                        <p><span><s:property value="getText('registrationPage.yearofbirth')"/><sup><img src="images/star.png"></sup> </span>
                                    <s:if test="person.getUsername().trim().length() !=0">
                                <select id="yearofbirth" name="person.yearofbirth" disabled="true" onchange="setHyearofBirthvalue(this.value);">
                                    <option value="-1">Select Year</option>
                                    <s:iterator var="counter" begin="1940" end="1997">
                                        <option value="<s:property value="top" />"><s:property value="top" /></option>
                                    </s:iterator>
                                </select>
                            </s:if>
                            <s:else>
                                <select id="yearofbirth" name="person.yearofbirth" onchange="setHyearofBirthvalue(this.value);">
                                    <option value="-1">Select Year</option>
                                    <s:iterator var="counter" begin="1940" end="1997">
                                        <option value="<s:property value="top" />"><s:property value="top" /></option>
                                    </s:iterator>
                                </select>
                            </s:else>
                            <label id="yearofbirthError" class="errormsg"><s:property value="getText('registrationPage.yearofbirthEmpty')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('perYearofBirth').get(0)"/></label>
                            <s:hidden id="hidden_yearofbirth" name="person.hiddenYearOfBirth" value=""/>
                        </p><br/><br/>
                        --%>
                        <p><span><s:property value="getText('registrationPage.yourQualification')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="qualification" class="displayselect" name="person.qualification.qualification">
                                <option value="-1">--Select your qualification--</option>
                                <s:iterator var="qualifications" value="qualifications">
                                    <s:if test="#qualifications.qualification == person.getQualification().getQualification()">
                                        <option selected value="<s:property value="qualification"/>"><s:property value="qualification"/></option>
                                    </s:if>    
                                    <s:else>
                                        <option value="<s:property value="qualification"/>"><s:property value="qualification"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                            <label id="qualificationError" class="errormsg"><s:property value="getText('registrationPage.qualificationError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('qualificationError').get(0)"/></label>
                        </p><br/>

                        <%-- <p><span><s:property value="getText('registrationPage.yourDesignation')"/> <sup><img src="images/star.png"></sup></span>
                             <select id="designation" class="displayselect" name="person.Designation.designationId">
                                 <option value="-1">--Select your designation--</option>
                                 <s:iterator var="designations" value="designations">
                                     <s:if test="#designations.designationId == person.getDesignation().getDesignationId()">
                                         <option selected value="<s:property value="designationId"/>"><s:property value="designationName"/></option>
                                     </s:if>
                                     <s:else>
                                         <option value="<s:property value="designationId"/>"><s:property value="designationName"/></option>
                                     </s:else>
                                 </s:iterator>
                             </select>
                             <label id="designationError" class="errormsg"><s:property value="getText('registrationPage.designationError')" /></label>
                             <label class="errorLabel"><s:property value="fieldErrors.get('designationError').get(0)"/></label>
                         </p><br/>--%>

                        <p><span><s:property value="getText('registrationPage.yourDiscipline')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="discipline" class="displayselect" name="person.Stream.streamId" onchange="ChangeInstituteHead(this.value)">
                                <option value="-1">--Select your discipline--</option>
                                <s:iterator var="streams" value="streams">
                                    <s:if test="#streams.streamId == person.getStream().getStreamId()">
                                        <option selected value="<s:property value="streamId"/>"><s:property value="streamName"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="streamId"/>"><s:property value="streamName"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                            <label id="disciplineError" class="errormsg"><s:property value="getText('registrationPage.disciplineError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('streamError').get(0)"/></label>
                        </p><br/>
                        <%-- <div class="radiobutton"><p><span><s:property value="getText('registrationPage.experience')"/> <sup><img src="images/star.png"></sup></span>
                                 <span class="s"  style="width: 270px; ">
                                     <s:if test="person.getExperience() == '0-2 years'">
                                         0-2 years&nbsp;&nbsp;&nbsp;&nbsp; <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="experience" name="person.experience" checked value="0-2 years" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                     </s:if>
                                     <s:else>
                                         0-2 years&nbsp;&nbsp;&nbsp;&nbsp; <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="experience" name="person.experience" value="0-2 years" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                     </s:else>
                                     <s:if test="person.getExperience() == '2-5 years'">
                                         2-5 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;" id="experience" type="radio" name="person.experience" checked value="2-5 years" /><br/>
                                     </s:if>
                                     <s:else>
                                         2-5 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;" id="experience" type="radio" name="person.experience" value="2-5 years" /><br/>
                                     </s:else>
                                     <s:if test="person.getExperience() == '5-10 years'">  
                                         5-10 years&nbsp;&nbsp;&nbsp;<input style=" width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="experience" name="person.experience" checked value="5-10 years" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                     </s:if>
                                     <s:else>
                                         5-10 years&nbsp;&nbsp;&nbsp;<input style=" width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="experience" name="person.experience" value="5-10 years" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                     </s:else>
                                     <s:if test="person.getExperience() == '>10 years'"> 
                                         >10 years&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;" type="radio" id="experience" name="person.experience" checked value=">10 years" />
                                     </s:if>
                                     <s:else>
                                         >10 years&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;" type="radio" id="experience" name="person.experience" value=">10 years" /></span>
                                     </s:else>
                                 <label id="experienceError" class="errormsg"><s:property value="getText('registrationPage.experienceError')" /></label>
                                 <label class="errorLabel"><s:property value="fieldErrors.get('experienceError').get(0)"/></label></p>
                         </div><br/>--%>                          
                        <div class="radiobutton"><p><span><s:property value="getText('registrationPage.gender')"/> <sup><img src="images/star.png"></sup></span><span class="s"  style="width: 270px; ">
                                        <s:if test="person.getGender().charAt(0).equals('M')">
                                        Male&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="gender" type="radio" name="person.gender" value="M" checked/>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </s:if>
                                    <s:else>
                                        Male&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="gender" type="radio" name="person.gender" value="M" />   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </s:else>
                                    <s:if test="person.getGender().charAt(0).equals('F')">
                                        Female&nbsp;&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="gender" name="person.gender" checked value="F" /><br/>
                                    </s:if>
                                    <s:else>
                                        Female&nbsp;&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="gender" name="person.gender"  value="F" /><br/>
                                    </s:else></span>
                                <span id="genderError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('registrationPage.genderError')" /></span>
                                <label class="errorLabel"><s:property value="fieldErrors.get('genderError').get(0)"/></label><br/></p>
                        </div>  
                        <%-- <div style="text-align: center;">
                             <s:if test="photo_exist == true">
                                 <input type="hidden" name="h_photoPath" id="photoPath" value="${person.image}"/><br>
                                  <img src="UserImages/${person.image}" height="150" width="150">
                             </s:if>
                             <s:else> 
                                 <input type="hidden" name="h_photoPath" id="photoPath" value=""/><br>
                                 <img src="images/empty_person.jpg" height="150" width="150" >
                             </s:else>
                             <br></div><br>
                          <p>

                            <span>Institute Photo ID Card [only jpg/jpeg file,max 250 kb]<sup><img src="images/star.png"></sup></span>
                            <input type="file" id="photo"  name="PersonPhoto"/>
                            <label id="photoError"  class="errormsg"><s:property value="getText('registrationPage.photoError')"/></label>
                            <label id="person_photo" class="errorLabel" style="color: black;display: inline;font-weight: bold">${person.image}</label> 
                        </p><br>--%>

                    </div>
                    <div class="form_box">
                        <h2><s:property value="getText('registrationPage.contactDetails')"/></h2><br/> 
                        <p><span><s:property value="getText('registrationPage.homeAddress')"/> <sup><img src="images/star.png"></sup></span><textarea rows="5" cols="50" id="homeAddress" name="person.address"  maxlength="150" class="tipTip" title="<s:property value="getText('form.address')"/>"><s:text name="%{person.address}"/></textarea>
                            <label id="homeAddressError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('addressError').get(0)"/></label>
                        </p><br/>

                        <p><span><s:property value="getText('registrationPage.personState')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="personState" class="displayselect" name="person.stateId" onchange="changeState1('${person.loginId}');">
                                <option value="-1">--Select the state--</option>
                                <s:iterator var="states" value="states">
                                    <s:if test="#states.stateId == person.getStateId()">
                                        <option selected value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                            <label id="personStateError" class="errormsg"><s:property value="getText('registrationPage.personStateError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('perStateError').get(0)"/></label>
                        </p><br/>
                        <p><span><s:property value="getText('registrationPage.personCity')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="personCity" class="displayselect" name="person.cityId" onchange="changeCity1();">
                                <option value="-1">--Select the city--</option>                               
                                <s:iterator var="personcities" value="personcities">
                                    <s:if test="#personcities.cityId == person.cityId">
                                        <option selected value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                            <label id="personCityError" class="errormsg"><s:property value="getText('registrationPage.personCityError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('perCityError').get(0)"/></label>
                        </p><br/>
                        <p id="otherPcity" style="display:none;"><span><s:property value="getText('registrationPage.cityOther')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="otherCity" name="person.otherCity" value="" maxlength="70" class="tipTip" title="<s:property value="getText('form.otherCity')"/>"/>
                            <input type="hidden" id="hiddenCityFlag" value="0"/>
                        </p>
                        <label id="otherCityError" class="errormsg"><s:property value="getText('registrationPage.otherCityError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('otherInstituteError').get(0)"/></label>
                        <br>
                        <p style="display: none;"><span><s:property value="getText('registrationPage.homeCity')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="cityHome" name="person.City.cityName" value="${person.city.cityName}" maxlength="15" class="tipTip"  title="<s:property value="getText('form.city')"/>"/>
                            <label id="homeCityError" class="errormsg"><s:property value="getText('registrationPage.cityIsEmpty')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('cityError').get(0)"/></label>
                        </p><br/>
                        <p><span><s:property value="getText('registrationPage.homePincode')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="pincodeHome" name="person.pincode" value="${person.pincode}" maxlength="6" class="tipTip" onkeypress="return onlyNumbers(event);" title="Should be 6 digits"/>
                            <label id="homePincodeError" class="errormsg"><s:property value="getText('registrationPage.pincodeEmptyError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('pincodeError').get(0)"/></label>
                        </p><br/>
                        <p><span><s:property value="getText('registrationPage.mobile')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="mobile" name="person.mobileNumber" value="${person.mobileNumber}" maxlength="11" class="tipTip" onkeypress="return onlyNumbers(event);" title="<s:property value="getText('form.mobile')"/>"/>
                            <label id="mobileError" class="errormsg"><s:property value="getText('registrationPage.mobileEmptyError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('mobileNumberError').get(0)"/></label>
                        </p><br/>
                        <p><span><s:property value="getText('registrationPage.homePhone')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="phoneHome" name="person.phoneNumber" value="${person.phoneNumber}" maxlength="12" class="tipTip" onkeypress="return onlyNumbers(event);" onblur="checkPhoneNumber()" title="<s:property value="getText('form.phone')"/>"/>
                            <label id="homePhoneError" class="errormsg"><s:property value="getText('registrationPage.phoneIsEmpty')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('phoneNumberError').get(0)"/></label>
                            <label id="sameNumberError" class="errormsg" style="left: 200px;"><s:property value="getText('registrationPage.sameNumberError')" />
                        </p><br/>
                    </div>
                    <div class="form_box">
                        <br><br>
                        <s:if test='person.facultyStatus.equals("1")'>
                            <%--<p><b>Are you employed as faculty :</b> <input type="checkbox" id="facultyStCheck" name="facultyStatusCheck" onclick="showInstituteDetails1();" checked="true"/></p><br>--%>
                            <div class="radiobutton">
                                <p style="display: inline;"><b>Are you employed as faculty :</b><sup><img src="images/star.png"></sup>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="radio" id="facultyStCheckYes" name="facultyStatusCheck" style="  width: 13px;height: 13px;padding:0 0 0 0; " value="1" checked="true" onclick="showInstituteDetails12();"/>&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                    <input type="radio" id="facultyStCheckNo" name="facultyStatusCheck" style="  width: 13px;height: 13px;padding:0 0 0 0; " value="0" onclick="showInstituteDetails12();"/>&nbsp;&nbsp;&nbsp; No
                                </p></div>
                            <input type="hidden" id="facultyStatus" name="person.facultyStatus" value="1"/>
                        </s:if><s:else>
                            <%--<p><b>Are you employed as faculty :</b> <input type="checkbox" id="facultyStCheck" name="facultyStatusCheck" onclick="showInstituteDetails1();"/></p><br>--%>
                            <div class="radiobutton">
                                <p style="display: inline;"><b>Are you employed as faculty :</b><sup><img src="images/star.png"></sup>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="radio" id="facultyStCheckYes" name="facultyStatusCheck" style="  width: 13px;height: 13px;padding:0 0 0 0; " value="1" onclick="showInstituteDetails12();"/>&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                    <input type="radio" id="facultyStCheckNo" name="facultyStatusCheck" style="  width: 13px;height: 13px;padding:0 0 0 0; " value="0" checked="true" onclick="showInstituteDetails12();"/>&nbsp;&nbsp;&nbsp; No
                                </p></div>
                            <input type="hidden" id="facultyStatus" name="person.facultyStatus" value="0"/>
                        </s:else>
                    </div> 
                    <s:if test='person.facultyStatus.equals("1")'>
                        <div id="formDetails" style="display: inline;" class="form_box">
                        </s:if><s:else>
                            <div id="formDetails" style="display: inline;" class="form_box">
                            </s:else> 
                            <h2>Other Details</h2><br/>
                            <div style="text-align: center;">
                                <s:if test="photo_exist == true">
                                    <input type="hidden" name="h_photoPath" id="photoPath" value="${person.image}"/><br>
                                    <%--<img src="${ServletActionContext.getServletContext().getRealPath("")}UserImages/${person.image}" height="150" width="150">--%>
                                    <img src="UserImages/${person.image}" height="150" width="150">
                                </s:if>
                                <s:else> 
                                    <input type="hidden" name="h_photoPath" id="photoPath" value=""/><br>
                                    <img src="images/empty_person.jpg" height="150" width="150" >
                                </s:else>

                                <br></div><br>
                            <p>

                                <span id="photoidheading">Institute Photo ID Card [only jpg/jpeg file,max 250 kb]<sup><img src="images/star.png"></sup></span>
                                <input type="file" id="photo"  name="PersonPhoto"/>
                                <label id="photoError"  class="errormsg"><s:property value="getText('registrationPage.photoError')"/></label>
                                <label id="person_photo1" class="errorLabel"><s:property value="fieldErrors.get('photoError').get(0)"/></label>
                                <label id="person_photo" class="errorLabel" style="color: black;display: inline;font-weight: bold">${person.image}</label><br><br> 
                            </p><br>
                            <p><span><s:property value="getText('registrationPage.yourDesignation')"/> <sup><img src="images/star.png"></sup></span>
                                <select id="designation" class="displayselect" name="person.Designation.designationId">
                                    <option value="-1">--Select your designation--</option>
                                    <s:iterator var="designations" value="designations">
                                        <s:if test="#designations.designationId == person.getDesignation().getDesignationId()">
                                            <option selected value="<s:property value="designationId"/>"><s:property value="designationName"/></option>
                                        </s:if>
                                        <s:else>
                                            <option value="<s:property value="designationId"/>"><s:property value="designationName"/></option>
                                        </s:else>
                                    </s:iterator>
                                </select>
                                <label id="designationError" class="errormsg"><s:property value="getText('registrationPage.designationError')" /></label>
                                <label class="errorLabel"><s:property value="fieldErrors.get('designationError').get(0)"/></label><br><br>
                            </p>
                            <div class="radiobutton"><p><span><s:property value="getText('registrationPage.experience')"/> <sup><img src="images/star.png"></sup></span>
                                    <span class="s"  style="width: 270px; ">
                                        <s:if test="person.getExperience() == '0-2 years'">
                                            0-2 years&nbsp;&nbsp;&nbsp;&nbsp; <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="experience" name="person.experience" checked value="0-2 years" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </s:if>
                                        <s:else>
                                            0-2 years&nbsp;&nbsp;&nbsp;&nbsp; <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="experience" name="person.experience" value="0-2 years" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </s:else>
                                        <s:if test="person.getExperience() == '2-5 years'">
                                            2-5 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;" id="experience" type="radio" name="person.experience" checked value="2-5 years" /><br/>
                                        </s:if>
                                        <s:else>
                                            2-5 years&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;" id="experience" type="radio" name="person.experience" value="2-5 years" /><br/>
                                        </s:else>
                                        <s:if test="person.getExperience() == '5-10 years'">  
                                            5-10 years&nbsp;&nbsp;&nbsp;<input style=" width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="experience" name="person.experience" checked value="5-10 years" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                        </s:if>
                                        <s:else>
                                            5-10 years&nbsp;&nbsp;&nbsp;<input style=" width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="experience" name="person.experience" value="5-10 years" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                        </s:else>
                                        <s:if test="person.getExperience() == '>10 years'"> 
                                            >10 years&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;" type="radio" id="experience" name="person.experience" checked value=">10 years" />
                                        </s:if>
                                        <s:else>
                                            >10 years&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;" type="radio" id="experience" name="person.experience" value=">10 years" /></span>
                                        </s:else>
                                    <label id="experienceError" class="errormsg"><s:property value="getText('registrationPage.experienceError')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('experienceError').get(0)"/></label></p>
                            </div><br/> 
                        </div>
                        <s:if test='person.facultyStatus.equals("1")'>    
                            <div id="formInstitute" style="display: inline;" class="form_box">
                            </s:if><s:else>    
                                <div id="formInstitute" style="display: inline;" class="form_box">
                                </s:else>
                                <h2 id="instituteheader"><s:property value="getText('registrationPage.instituteDetails')"/></h2><br/>
                                <p><span id="instateheading"><s:property value="getText('registrationPage.instituteState')"/> <sup><img src="images/star.png"></sup></span>
                                    <select id="stateInstitute" class="displayselect" name="person.Institute.State.stateId" onchange="changeState();">
                                        <option value="-1">--Select the state--</option>
                                        <s:iterator var="states" value="states">
                                            <s:if test="#states.stateId == person.getInstitute().getState().getStateId()">
                                                <option selected value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                            </s:if>
                                            <s:else>
                                                <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                            </s:else>
                                        </s:iterator>
                                    </select>
                                    <label id="stateInstituteError" class="errormsg"><s:property value="getText('registrationPage.stateInstituteError')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('instituteStateError').get(0)"/></label>
                                </p><br/><br>

                                <p><span id="incityheading"><s:property value="getText('registrationPage.instituteCity')"/> <sup><img src="images/star.png"></sup></span>
                                    <select id="cityInstitute" class="displayselect" name="person.Institute.City.cityId" onchange="changeCity('${person.loginId}');">
                                        <option value="-1">--Select the city--</option>
                                        <s:iterator var="cities" value="cities">
                                            <s:if test="#cities.cityId == person.getInstitute().getCity().getCityId()">
                                                <option selected value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                                            </s:if>
                                            <s:else>
                                                <option value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                                            </s:else>
                                        </s:iterator>
                                    </select>
                                    <label id="cityInstituteError" class="errormsg"><s:property value="getText('registrationPage.cityInstituteError')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('instituteCityError').get(0)"/></label>
                                </p><br/><br>

                                <p><span id="instituteheading"><s:property value="getText('registrationPage.institute')"/> <sup><img src="images/star.png"></sup></span>
                                    <select id="institute" name="person.Institute.instituteId" onchange="toggleField();">
                                        <option value="-1">--Select your institute--</option>
                                        <s:iterator var="institutes" value="institutes">
                                            <s:if test="#institutes.instituteId == person.getInstitute().getInstituteId()">
                                                <option selected value="<s:property value="instituteId"/>"><s:property value="instituteName"/></option>
                                            </s:if>
                                            <s:else>
                                                <option value="<s:property value="instituteId"/>"><s:property value="instituteName"/></option>
                                            </s:else>
                                        </s:iterator>
                                        <option value="other">Other</option>
                                    </select>
                                    <label id="instituteError" class="errormsg"><s:property value="getText('registrationPage.instituteError')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('instituteError').get(0)"/></label>
                                </p><br/>
                                <p id="other" style="display:none;"><span><s:property value="getText('registrationPage.instituteOther')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="otherlabel" name="otherInstitute" value="" maxlength="70" class="tipTip" title="<s:property value="getText('form.othercollege')"/>"/>
                                    <label id="otherInstituteError" class="errormsg"><s:property value="getText('registrationPage.otherInstituteError')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('otherInstituteError').get(0)"/></label>
                                    <br/><br/>
                                </p>
                                <p><span><s:property value="getText('registrationPage.instituteAddress')"/> <sup><img src="images/star.png"></sup></span><textarea rows="5" id="instituteAddress" cols="50" name="person.institute.instituteAddress" maxlength="150" class="tipTip" title="<s:property value="getText('form.address')"/>"><s:text name="%{person.institute.instituteAddress}"/></textarea>
                                    <label id="instituteAddressError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('instituteAddressError').get(0)"/></label>
                                </p><br/>
                                <p><span><s:property value="getText('registrationPage.institutePincode')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="pincodeInstitute" name="person.institute.pincode" value="${person.institute.pincode}" maxlength="6" onkeypress="return onlyNumbers(event);" class="tipTip" title="Should be 6 digits"/>
                                    <label id="institutePincodeError" class="errormsg" style="float:right;bottom: 20px;"><s:property value="getText('registrationPage.pincodeEmptyError')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('institutePincodeError').get(0)"/></label>
                                </p><br/>
                            </div>
                            <s:if test='person.facultyStatus.equals("1")'>    
                                <div id="formHeadOfInstitute" style="display: inline;" class="form_box">
                                </s:if><s:else>
                                    <div id="formHeadOfInstitute" style="display: none;" class="form_box">
                                    </s:else>
                                    <h2><s:property value="getText('registrationPage.headDetails')"/></h2><br/>

                                    <p><span>Title <sup><img src="images/star.png"></sup></span><select id="headTitle" class="displayselect" name="person.institute.headTitle.headTitleId" onchange="setHtitleValue(this.value);">
                                            <option value="-1">--Select the title--</option>
                                            <s:iterator var="headTitles" value="headTitles">
                                                <s:if test="#headTitles.headTitleId == person.getHeadInstitute().getHeadTitle().getHeadTitleId()">
                                                    <option selected value="<s:property value="headTitleId"/>"><s:property value="headTitleName"/></option>
                                                </s:if>
                                                <s:else>
                                                    <option value="<s:property value="headTitleId"/>"><s:property value="headTitleName"/></option>
                                                </s:else>
                                            </s:iterator>
                                        </select>
                                        <label id="headTitleError" class="errormsg"><s:property value="getText('registrationPage.titleError')" /></label>
                                        <label class="errorLabel"><s:property value="fieldErrors.get('headTitleError').get(0)"/></label>
                                        <s:hidden id="hidden_headtitle" name="person.institute.headTitle.H_headTitleId" value=""/>
                                    </p><br/>
                                    <p><span>Name <sup><img src="images/star.png"></sup></span><input type="text" id="headName" name="person.Institute.headName" value="${person.headInstitute.headName}" maxlength="30" class="tipTip" title="<s:property value="getText('form.name')"/>"/>
                                        <label id="headNameError" class="errormsg"><s:property value="getText('registrationPage.headNameIsEmpty')" /></label>
                                        <label class="errorLabel"><s:property value="fieldErrors.get('headNameError').get(0)"/></label>
                                    </p><br/>
                                    <p><span>Head Designation <sup><img src="images/star.png"></sup></span>
                                        <select id="headDesignation" class="displayselect" name="person.Institute.HeadDesignation.headDesignationId" onchange="setHdesginationValue(this.value);">
                                            <option value="-1">--Select the designation--</option>
                                            <s:iterator var="headDesignations" value="headDesignations">
                                                <s:if test="#headDesignations.headDesignationId == person.getHeadInstitute().getHeadDesignation().getHeadDesignationId()">
                                                    <option selected value="<s:property value="headDesignationId"/>"><s:property value="headDesignationName"/></option>
                                                </s:if>
                                                <s:else>
                                                    <option  value="<s:property value="headDesignationId"/>"><s:property value="headDesignationName"/></option>
                                                </s:else>
                                            </s:iterator>
                                        </select>
                                        <label id="headDesignationError" class="errormsg"><s:property value="getText('registrationPage.headDesignationError')" /></label>
                                        <label class="errorLabel"><s:property value="fieldErrors.get('headDesignationError').get(0)"/></label>
                                        <s:hidden id="hidden_headdesignation" name="person.institute.HeadDesignation.H_headDesignationId" value=""/>
                                    </p><br/>
                                    <p><span>e-mail <sup><img src="images/star.png"></sup></span><input type="text" id="headEmail" name="person.institute.headEmail" value="${person.headInstitute.headEmail}" maxlength="50" class="tipTip" title="<s:property value="getText('form.email')"/>" />
                                        <label id="headEmailError" class="errormsg"><s:property value="getText('registrationPage.emailerror')" /></label>
                                        <label class="errorLabel"><s:property value="fieldErrors.get('headEmailError').get(0)"/></label>
                                    </p><br/>
                                    <p><span>Phone <sup><img src="images/star.png"></sup></span><input type="text" id="headPhone" name="person.institute.headContact" value="${person.headInstitute.headContact}" maxlength="12" class="tipTip" onkeypress="return onlyNumbers(event);" title="<s:property value="getText('form.phone')"/>"/>
                                        <label id="headPhoneError" class="errormsg"><s:property value="getText('registrationPage.phoneIsEmpty')" /></label>
                                        <label class="errorLabel"><s:property value="fieldErrors.get('headPhoneNumberError').get(0)"/></label>
                                    </p><br/>
                                    <p><span>Check if same as Institute Address</span><input class="checkbox" id="sameAsInstituteAddress" type="checkbox" name="name" onclick="changeHeadAddress();" />
                                    </p><br/><br/>
                                    <p><span>Address <sup><img src="images/star.png"></sup></span><textarea rows="5" cols="50" id="headAddress" name="person.institute.headAddress" maxlength="150" class="tipTip" title="<s:property value="getText('form.address')"/>"><s:text name="%{person.getHeadInstitute().getHeadAddress()}"/></textarea>
                                        <label id="headAddressError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                                        <label class="errorLabel"><s:property value="fieldErrors.get('headAddressError').get(0)"/></label>
                                    </p><br/>
                                </div>
                                <div class="form_box"> 
                                    <h2><s:property value="getText('registrationPage.verifyHumanity')"/></h2><br/>
                                    <div id="captchaDiv" class="captcha">
                                        <div>
                                            <img id="imgCaptcha" src="captchaImage"  alt="Captcha image" width="206" height="50">
                                        </div>
                                    </div>
                                    <p><span>Type the code shown <sup><img src="images/star.png"></sup></span>
                                        <input id="captchaText" style="width:135px;" type="text" name="captchaText" class="tipTip" title="<s:property value="getText('captchaInfo')"/>"  onblur="checkCaptcha()"/>
                                        <img id="reCaptchaImg" style="display:none;" onclick="changeImage();" src="images/refresh.png" alt="" width="22" height="22">
                                        <a id="reCaptchaLink" style="display:none;" href="javascript:onclick=changeImage();">Try a new code</a>
                                        <label id="captchaError" class="errormsg"><s:property value="getText('captchaError')"/></label>
                                        <input type="hidden" value="0" id="capCheck" />
                                        <label class="errorLabel"><s:property value="fieldErrors.get('captchaError').get(0)"/></label>
                                        <noscript>
                                        <a id="reCaptchaLink"  href=""><img id="reCaptchaImg" src="images/refresh.png" alt="" width="22" height="22">Try a new code</a>
                                        </noscript>
                                    </p>
                                    <h6 class="captchaMsg" style="margin-left: 200px;">Letters are case-sensitive</h6>
                                    <script type="text/javascript">
                                        document.getElementById('reCaptchaImg').style.display = "inline";
                                        document.getElementById('reCaptchaLink').style.display = "inline";
                                    </script>
                                </div>
                                <p><input class="checkbox" type="checkbox" id="termsAndConditions" name="termsAndConditions" value="1" />
                                    Please note that clicking here amounts to self declaration of the following:
                                    <label id="termsError" class="errormsg"><s:property value="getText('registrationPage.termsAndConditionsError')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('termAndConditionsError').get(0)"/></label>
                                </p>
                                <s:if test='person.facultyStatus.equals("1")'>
                                    <div id="noteForUser" style="display: none;">
                                    </s:if><s:else><div id="noteForUser"></s:else>    
                                            <ul style="position: relative;left:15px;width:680px;">
                                                <li>All the information provided by me is correct and to the best of my knowledge</li>
                                            </ul>
                                        </div>
                                    <s:if test='person.facultyStatus.equals("1")'>
                                        <div id="noteForFaculty">
                                        </s:if><s:else><div id="noteForFaculty" style="display: none;"></s:else>    
                                                <ul style="position: relative;left:15px;width:680px;">
                                                    <li>All the information provided by me is correct and to the best of my knowledge</li>
                                                    <li>In case the letter of my bonafides,is later detected to be wrong, I understand that I will
                                                        not be given  certificate of participation, or if given, the same will be withdrawn.
                                                        In such case, I accept that I will be liable to refund the expenditure incurred on me for participating in this workshop </li>
                                                </ul>
                                            </div>                                        
                                        <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Update" />
                                            <input style="position: relative; right:75px"  class="submit" type="reset" name="reset" value="Reset" onclick="resetProfileForm();"/></p> 
                                    </div>       
                                    </form> 
                                    <script>
                                        var insti_add = document.getElementById("instituteAddress").value;
                                        var insti_pcode = document.getElementById("pincodeInstitute").value;
                                        if (insti_add.length == 0 || insti_add == null) {
                                            document.getElementById("instituteAddress").readOnly = false;
                                        } else {
                                            document.getElementById("instituteAddress").readOnly = true;
                                        }

                                        if (insti_pcode == 0 || insti_pcode.length < 6 || insti_pcode == null) {
                                            document.getElementById("pincodeInstitute").readOnly = false;
                                        } else {
                                            document.getElementById("pincodeInstitute").readOnly = true;
                                        }

                                        var hname = document.getElementById("headName").value;
                                        var hemail = document.getElementById("headEmail").value;
                                        var hphone = document.getElementById("headPhone").value;
                                        var haddress = document.getElementById("headAddress").value;
                                        var htitle = document.getElementById("headTitle").value;
                                        var hdesig = document.getElementById("headDesignation").value;
                                        if (hname == '' || hname == null) {
                                            document.getElementById("headName").readOnly = false;
                                        } else {
                                            document.getElementById("headName").readOnly = true;
                                        }
                                        if (hemail == '' || hemail == null) {
                                            document.getElementById("headEmail").readOnly = false;
                                        } else {
                                            document.getElementById("headEmail").readOnly = true;
                                        }
                                        if (hphone == '' || hphone == null) {
                                            document.getElementById("headPhone").readOnly = false;
                                        } else {
                                            document.getElementById("headPhone").readOnly = true;
                                        }
                                        if (haddress == '' || haddress == null) {
                                            document.getElementById("headAddress").readOnly = false;
                                        } else {
                                            document.getElementById("headAddress").readOnly = true;
                                        }
                                        if (htitle == '-1' || htitle == null) {
                                            document.getElementById("headTitle").disabled = false;
                                        } else {
                                            document.getElementById("headTitle").disabled = true;
                                        }
                                        if (hdesig == '-1' || hdesig == null) {
                                            document.getElementById("headDesignation").disabled = false;
                                        } else {
                                            document.getElementById("headDesignation").disabled = true;
                                        }

                                        document.getElementById("hidden_headtitle").value = htitle;
                                        document.getElementById("hidden_headdesignation").value = hdesig;

                                        $("#yearofbirth").val("<s:property value="person.getYearofbirth()"/>");
                                        document.getElementById("hidden_yearofbirth").value =<s:property value="person.getYearofbirth()"/>;
                                    </script>
                                    <script>
                                        var isfaculty= document.getElementById("facultyStatus").value;
                                        if(isfaculty == 0){
                                            // set head details fields to empty
                                            document.getElementById("headName").value = "";
                                            document.getElementById("headEmail").value = "";
                                            document.getElementById("headPhone").value = "";
                                            document.getElementById("headAddress").value = "";
                                            document.getElementById("headTitle").value = '-1';
                                            document.getElementById("headDesignation").value = '-1';
                                            // allow to edit
                                            document.getElementById("headName").readOnly = false;
                                            document.getElementById("headPhone").readOnly = false;
                                            document.getElementById("headEmail").readOnly = false;
                                            document.getElementById("headAddress").readOnly = false;
                                            document.getElementById("headTitle").disabled = false;
                                            document.getElementById("headDesignation").disabled = false;
                                        }
                                        if(isfaculty == 1){
                                            document.getElementById("formHeadOfInstitute").style.display="inline";
                                            document.getElementById('facultyStCheckYes').checked= true;
                                            document.getElementById("photoidheading").innerHTML="Institute Photo ID Card [only jpg/jpeg file,max 250 kb]<sup><img src='images/star.png'></sup>";
                                            document.getElementById("instituteheader").innerHTML="Your Institute Details";
                                            document.getElementById("instateheading").innerHTML="Select State of Institute<sup><img src='images/star.png'></sup>";
                                            document.getElementById("incityheading").innerHTML="Select City of Institute<sup><img src='images/star.png'></sup>";
                                            document.getElementById("instituteheading").innerHTML="Select your Institute<sup><img src='images/star.png'></sup>";
                                        }else if(isfaculty == 0){
                                            
                                            document.getElementById('facultyStCheckNo').checked=true;
                                            document.getElementById("photoidheading").innerHTML="Institute/Organization Photo ID Card [only jpg/jpeg file,max 250 kb]<sup><img src='images/star.png'></sup>";
                                            document.getElementById("instituteheader").innerHTML="Your Institute/Organization Details";
                                            document.getElementById("instateheading").innerHTML="Select State of Institute/Organization<sup><img src='images/star.png'></sup>";
                                            document.getElementById("incityheading").innerHTML="Select City of Institute/Organization<sup><img src='images/star.png'></sup>";
                                            document.getElementById("instituteheading").innerHTML="Select your Institute/Organization<sup><img src='images/star.png'></sup>";
                                   }
                                    </script>
                                </div> 
                                </body>
