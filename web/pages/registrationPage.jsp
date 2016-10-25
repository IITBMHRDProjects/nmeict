<%-- 
    Document   : registrationPage
    Created on : 11 Jun, 2014, 3:07:34 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<script type="text/javascript" src="validation/validate.js"></script>
<body>  
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <h3>Register Here</h3> 
    <div class="headmessage">
        If you are a faculty & interested in participating  workshops conducted by IIT Bombay then kindly Sign up here.<br>
        Field marked with <sup><img src="images/star.png"></sup> are mandatory </div>    
    <div class="form_enclosure">   
        <form id="registrationForm" action="doregister.html"  method="post" enctype="multipart/form-data" onsubmit="return validateRegistrationForm(this);">
            <div class="form_settings">    
                <div class="form_box">
                    <h2><s:property value="getText('registrationPage.loginDetails')"/></h2><br/>
                    <p><span><s:property value="getText('registrationPage.email')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="email" name="person.email" value="" maxlength="50" class="tipTip" title="<s:property value="getText('form.email')"/>" onblur="checkEmailExist(this.value)"/>
                        <label id="emailError" class="errormsg"><s:property value="getText('registrationPage.emailerror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('emailError').get(0)"/></label>
                    </p><br/>
                    <p id="showEmailMsg" style="display: none;">
                        Your email id already exists in our database <a href="accessaccount.html?tmp=ARlink">click here</a> to set password
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.cemail')"/> <sup><img src="images/star.png"></sup></span><input id="cemail" type="text" name="confirmEmail" value="" maxlength="50" onPaste='return false' class="tipTip" title="<s:property value="getText('form.cemail')"/>" onblur="funCE()"/>
                        <label id="cerror" class="errormsg"><s:property value="getText('registrationPage.cemailerror')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('cemailError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.password')"/> <sup><img src="images/star.png"></sup></span><input type="password" id="password" name="person.password" value="" maxlength="15" class="tipTip" title="<s:property value="getText('form.password')"/>"/>
                        <label id="passwordError" class="errormsg"><s:property value="getText('registrationPage.passworderror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('passwordError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.cpassword')"/> <sup><img src="images/star.png"></sup></span><input id="cpassword" type="password" name="confirmPassword" value="" maxlength="15" onPaste='return false' class="tipTip" title="<s:property value="getText('form.cpassword')"/>" onblur="funPCE()"/>
                        <label id="cpassworderror" class="errormsg"><s:property value="getText('registrationPage.cpasswordError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('cpasswordError').get(0)"/></label>
                    </p><br/>
                    <%-- username code commented.
                    <p><span><s:property value="getText('registrationPage.username')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="username" name="person.username" value="" maxlength="30" class="tipTip" title="<s:property value="getText('form.username')"/>" onblur="checkUserName();"/>
                       <label id="usernameError" class="errormsg"><s:property value="getText('registrationPage.usernameerror')"/></label>
                       <label class="errorLabel"><s:property value="fieldErrors.get('userNameError').get(0)"/></label>
                       <label id="usernameAvaliable" class="errormsg"><s:property value="getText('error.usernameAvaliable')"/></label>
                       <label id="usernamenotAvaliable" class="errormsg"><s:property value="getText('emailnotAvaliable')"/></label>
                   </p><br/>--%>
                </div>                
                <div class="form_box">
                    <h2><s:property value="getText('registrationPage.personalDetails')"/></h2><br/>

                    <p><span><s:property value="getText('registrationPage.yourTitle')"/> <sup><img src="images/star.png"></sup></span>
                        <select id="title" class="displayselect" name="person.Title.titleId">
                            <option value="-1">--Select your title--</option>
                            <s:iterator value="titles">
                                <option value="<s:property value="titleId"/>"><s:property value="titleName"/></option>
                            </s:iterator>
                        </select>
                        <label id="titleError" class="errormsg"><s:property value="getText('registrationPage.titleError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('titleError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.firstName')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="firstName" name="person.firstName" maxlength="30" value="" class="tipTip" title="<s:property value="getText('form.name')"/>" onblur="convertValue(this.value, 'firstName');"/>
                        <label id="firstNameError" class="errormsg"><s:property value="getText('registrationPage.fnameIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('firstNameError').get(0)"/></label>
                    </p><br/>
                    <%-- title tool tip of lastname commented 
                        title="<s:property value="getText('form.lastname')"/>" --%>
                    <p><span><s:property value="getText('registrationPage.lastName')"/> </span><input type="text" id="lastName" name="person.lastName" maxlength="30" value=""  onblur="convertValue(this.value, 'lastName');"/>
                        <label id="lastNameError" class="errormsg"><s:property value="getText('registrationPage.lnameIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('lastNameError').get(0)"/></label>
                    </p><br/>

                    <p id="showName" style="color: #4746A1;display:none"><br/></p>

                    <%--  aadharid and year of birth commented 
                    <p><span><s:property value="getText('registrationPage.aadharid')"/></span><input type="text" id="aadharid" name="person.aadharId" maxlength="12" value="" onkeypress="return onlyNumbers(event);" class="tipTip" title="<s:property value="getText('form.aadharid')"/>" />
                        <label id="aadharidError" class="errormsg"><s:property value="getText('registrationPage.aadharidCheck')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('adharIdError').get(0)"/></label>
                    </p><br/><br>
                    <p><span><s:property value="getText('registrationPage.yearofbirth')"/><sup><img src="images/star.png"></sup></span>
                        <select id="yearofbirth" name="person.yearofbirth">
                            <option value="-1">Select Year</option>
                            <s:iterator var="counter" begin="1940" end="1997">
                                <option value="<s:property value="top" />"><s:property value="top" /></option>
                            </s:iterator>
                        </select>
                        <label id="yearofbirthError" class="errormsg"><s:property value="getText('registrationPage.yearofbirthEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('perYearofBirth').get(0)"/></label>
                    </p><br/><br>
                    --%>
                    <p><span><s:property value="getText('registrationPage.yourQualification')"/> <sup><img src="images/star.png"></sup></span>
                        <select id="qualification" class="displayselect" name="person.qualification.qualification">
                            <option value="-1">--Select your qualification--</option>
                            <s:iterator value="qualifications">
                                <option value="<s:property value="qualification"/>"><s:property value="qualification"/></option>
                            </s:iterator>
                        </select>
                        <label id="qualificationError" class="errormsg"><s:property value="getText('registrationPage.qualificationError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('qualificationError').get(0)"/></label>
                    </p><br/>



                    <p><span><s:property value="getText('registrationPage.yourDiscipline')"/> <sup><img src="images/star.png"></sup></span>
                        <select id="discipline" class="displayselect" name="person.Stream.streamId" onchange="ChangeInstituteHead(this.value)">
                            <option value="-1">--Select your discipline--</option>
                            <s:iterator value="streams">
                                <option value="<s:property value="streamId"/>"><s:property value="streamName"/></option>
                            </s:iterator>
                        </select>
                        <label id="disciplineError" class="errormsg"><s:property value="getText('registrationPage.disciplineError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('streamError').get(0)"/></label>
                    </p><br/>

                    <div class="radiobutton"><p><span><s:property value="getText('registrationPage.gender')"/> <sup><img src="images/star.png"></sup></span><span class="s"  style="width: 270px; font-size: 90%">
                                <input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="gender" type="radio" name="person.gender" value="M" />&nbsp;&nbsp;&nbsp;&nbsp; Male   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input style="  width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="gender" name="person.gender" value="F" />&nbsp;&nbsp;&nbsp; Female<br/>
                                <span id="genderError" class="errormsg" style="left: 300px;bottom: 15px;"><s:property value="getText('registrationPage.genderError')" /></span>
                                <label class="errorLabel"><s:property value="fieldErrors.get('genderError').get(0)"/></label><br/></p>
                    </div><br/>




                </div>
                <div class="form_box">
                    <h2><s:property value="getText('registrationPage.contactDetails')"/></h2><br/> 
                    <p><span><s:property value="getText('registrationPage.homeAddress')"/> <sup><img src="images/star.png"></sup></span><textarea rows="5" cols="50" id="homeAddress" name="person.address" maxlength="150" class="tipTip" title="<s:property value="getText('form.address')"/>"></textarea>
                        <label id="homeAddressError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('addressError').get(0)"/></label>
                    </p><br/>

                    <p><span><s:property value="getText('registrationPage.personState')"/> <sup><img src="images/star.png"></sup></span>
                        <select id="personState" class="displayselect" name="person.stateId" onchange="changeState1();">
                            <option value="-1">--Select the state--</option>
                            <s:iterator value="states">
                                <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                            </s:iterator>
                        </select>
                        <label id="personStateError" class="errormsg"><s:property value="getText('registrationPage.personStateError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('perStateError').get(0)"/></label>
                    </p><br/>

                    <p><span><s:property value="getText('registrationPage.personCity')"/> <sup><img src="images/star.png"></sup></span>

                        <select id="personCity" class="displayselect" name="person.cityId" onchange="changeCity1();">

                            <option value="-1">--Select the city--</option>
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
                    <p style="display:none;"><span><s:property value="getText('registrationPage.homeCity')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="cityHome" name="person.City.cityName" value="" maxlength="15" class="tipTip" title="<s:property value="getText('form.city')"/>"/>
                        <label id="homeCityError" class="errormsg"><s:property value="getText('registrationPage.cityIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('cityError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.homePincode')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="pincodeHome" name="person.pincode" value="" maxlength="6" class="tipTip" onkeypress="return onlyNumbers(event);" title="Should be 6 digits"/>
                        <label id="homePincodeError" class="errormsg"><s:property value="getText('registrationPage.pincodeEmptyError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('pincodeError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.mobile')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="mobile" name="person.mobileNumber" value="" maxlength="11" class="tipTip" onkeypress="return onlyNumbers(event);" title="<s:property value="getText('form.mobile')"/>"/>
                        <label id="mobileError" class="errormsg"><s:property value="getText('registrationPage.mobileEmptyError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('mobileNumberError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.homePhone')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="phoneHome" name="person.phoneNumber" value="" maxlength="12" class="tipTip" onkeypress="return onlyNumbers(event);" onblur="checkPhoneNumber()" title="<s:property value="getText('form.phone')"/>"/>
                        <label id="homePhoneError" class="errormsg"><s:property value="getText('registrationPage.phoneIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('phoneNumberError').get(0)"/></label>
                        <label id="sameNumberError" class="errormsg" style="left: 200px;"><s:property value="getText('registrationPage.sameNumberError')" /></label>
                    </p><br/>
                </div>
                <div class="form_box">
                    <br><br>
                    <%--<p><b>Are you employed as faculty :</b> <input type="checkbox" id="facultyStCheck" name="facultyStatusCheck" onclick="showInstituteDetails();"/></p><br>--%>
                    <div class="radiobutton">
                        <p style="display: inline;"><b>Are you employed as faculty :<sup><img src="images/star.png"></sup></b>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" id="facultyStCheckYes" name="facultyStatusCheck" style="  width: 13px;height: 13px;padding:0 0 0 0; " value="1" onclick="showInstituteDetails11();"/>&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            <input type="radio" id="facultyStCheckNo" name="facultyStatusCheck" style="  width: 13px;height: 13px;padding:0 0 0 0; " value="0" onclick="showInstituteDetails11();"/>&nbsp;&nbsp;&nbsp; No
                            <label id="facultyStatusCheckError" class="errormsg"><s:property value="getText('registrationPage.facultyStatusCheckEmpty')" /></label>
                        </p></div>
                    <input type="hidden" id="facultyStatus" name="person.facultyStatus" value="0"/>
                </div> 
                <s:if test='person.facultyStatus.equals("1")'>
                    <div id="formDetails" style="display: inline;" class="form_box">
                    </s:if><s:else>
                        <div id="formDetails" style="display: none;" class="form_box">
                        </s:else> 
                        <h2>Other Details</h2><br/>
                        <p id="formPhoto" style="">
                            <span id="photoidheading">Institute Photo ID Card [only jpg/jpeg file,max 250 kb]<sup><img src="images/star.png"></sup></span>
                            <input type="file" id="photo"  name="photo"/>
                            <label id="photoError"  class="errormsg"><s:property value="getText('registrationPage.photoError')"/></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('photoError').get(0)"/></label> 
                        </p><br><br>
                        <p id="formDesignation" style=""><span><s:property value="getText('registrationPage.yourDesignation')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="designation" class="displayselect" name="person.Designation.designationId">
                                <option value="-1">--Select your designation--</option>
                                <s:iterator value="designations">
                                    <option value="<s:property value="designationId"/>"><s:property value="designationName"/></option>
                                </s:iterator>
                            </select>
                            <label id="designationError" class="errormsg"><s:property value="getText('registrationPage.designationError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('designationError').get(0)"/></label><br/><br/>
                        </p>
                        <div id="formExperience" style="" class="radiobutton"><p><span><s:property value="getText('registrationPage.experience')"/> <sup><img src="images/star.png"></sup></span>
                                <span class="s"  style="width: 270px; font-size:90%"> 
                                    <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="experience" name="person.experience" value="0-2 years" />&nbsp;&nbsp;&nbsp;&nbsp;0-2 years &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input style="  width: 13px; height: 13px;padding:0 0 0 0;" id="experience" type="radio" name="person.experience" value="2-5 years" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2-5 years<br/>
                                    <input style=" width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="experience" name="person.experience" value="5-10 years" />&nbsp;&nbsp;&nbsp;&nbsp;5-10 years &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                                    <input style="  width: 13px; height: 13px;padding:0 0 0 0;" type="radio" id="experience" name="person.experience" value=">10 years" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>10 years</span>
                                <label id="experienceError" class="errormsg"><s:property value="getText('registrationPage.experienceError')" /></label>
                                <label class="errorLabel"><s:property value="fieldErrors.get('experienceError').get(0)"/></label></p><br/><br/>
                        </div> <br>
                    </div>
                    <s:if test='person.facultyStatus.equals("1")'>    
                        <div id="formInstitute" style="display: inline;" class="form_box">
                        </s:if><s:else>
                            <div id="formInstitute" style="display: none;" class="form_box">
                            </s:else>
                            <h2 id="instituteheader"><s:property value="getText('registrationPage.instituteDetails')"/></h2><br/>
                            <p><span id="instateheading"><s:property value="getText('registrationPage.instituteState')"/> <sup><img src="images/star.png"></sup></span>
                                <select id="stateInstitute" class="displayselect" name="person.Institute.State.stateId" onchange="changeState();">
                                    <option value="-1">--Select the state--</option>
                                    <s:iterator value="states">
                                        <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                    </s:iterator>
                                </select>
                                <label id="stateInstituteError" class="errormsg"><s:property value="getText('registrationPage.stateInstituteError')" /></label>
                                <label class="errorLabel"><s:property value="fieldErrors.get('instituteStateError').get(0)"/></label>
                            </p><br/><br/>

                            <p><span id="incityheading"><s:property value="getText('registrationPage.instituteCity')"/> <sup><img src="images/star.png"></sup></span>

                                <select id="cityInstitute" class="displayselect" name="person.Institute.City.cityId" onchange="changeCity();">

                                    <option value="-1">--Select the city--</option>
                                </select>
                                <label id="cityInstituteError" class="errormsg"><s:property value="getText('registrationPage.cityInstituteError')" /></label>
                                <label class="errorLabel"><s:property value="fieldErrors.get('instituteCityError').get(0)"/></label>
                            </p><br/><br/>

                            <p><span id="instituteheading"><s:property value="getText('registrationPage.institute')"/> <sup><img src="images/star.png"></sup></span>
                                <select id="institute" name="person.Institute.instituteId" onchange="toggleField();">
                                    <option value="-1">--Select your institute--</option>
                                </select>
                                <label id="instituteError" class="errormsg"><s:property value="getText('registrationPage.instituteError')" /></label>
                                <label class="errorLabel"><s:property value="fieldErrors.get('instituteError').get(0)"/></label>
                            </p><br/>
                            <p id="other" style="display:none;"><span><s:property value="getText('registrationPage.instituteOther')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="otherlabel" name="otherInstitute" value="" maxlength="70" class="tipTip" title="<s:property value="getText('form.othercollege')"/>"/>
                                <label id="otherInstituteError" class="errormsg"><s:property value="getText('registrationPage.otherInstituteError')" /></label>
                                <label class="errorLabel"><s:property value="fieldErrors.get('otherInstituteError').get(0)"/></label>
                                <br/><br/>
                            </p>
                            <p><span><s:property value="getText('registrationPage.instituteAddress')"/> <sup><img src="images/star.png"></sup></span><textarea rows="5" id="instituteAddress" cols="50" name="person.institute.instituteAddress" maxlength="150" class="tipTip" title="<s:property value="getText('form.address')"/>" ></textarea>
                                <label id="instituteAddressError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                                <label class="errorLabel"><s:property value="fieldErrors.get('instituteAddressError').get(0)"/></label>
                            </p><br/>
                            <p><span><s:property value="getText('registrationPage.institutePincode')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="pincodeInstitute" name="person.institute.pincode" value="" maxlength="6" onkeypress="return onlyNumbers(event);" class="tipTip" title="Should be 6 digits"/>
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
                                        <option value="-1">--Select the title--</option>\
                                        <s:iterator value="headTitles">
                                            <option value="<s:property value="headTitleId"/>"><s:property value="headTitleName"/></option>
                                        </s:iterator>
                                    </select>
                                    <label id="headTitleError" class="errormsg"><s:property value="getText('registrationPage.titleError')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('headTitleError').get(0)"/></label>
                                    <s:hidden id="hidden_headtitle" name="person.institute.headTitle.H_headTitleId" value=""/>
                                </p><br/>
                                <p><span>Name <sup><img src="images/star.png"></sup></span><input type="text" id="headName" name="person.Institute.headName" value="" maxlength="30" class="tipTip" title="<s:property value="getText('form.name')"/>"/>
                                    <label id="headNameError" class="errormsg"><s:property value="getText('registrationPage.headNameIsEmpty')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('headNameError').get(0)"/></label>
                                </p><br/>
                                <p><span>Head Designation <sup><img src="images/star.png"></sup></span>
                                    <select id="headDesignation" class="displayselect" name="person.Institute.HeadDesignation.headDesignationId" onchange="setHdesginationValue(this.value);">
                                        <option value="-1">--Select the designation--</option>
                                        <s:iterator value="headDesignations">
                                            <option value="<s:property value="headDesignationId"/>"><s:property value="headDesignationName"/></option>
                                        </s:iterator>
                                    </select>
                                    <label id="headDesignationError" class="errormsg"><s:property value="getText('registrationPage.headDesignationError')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('headDesignationError').get(0)"/></label>
                                    <s:hidden id="hidden_headdesignation" name="person.institute.HeadDesignation.H_headDesignationId" value=""/>
                                </p><br/>
                                <p><span>e-mail <sup><img src="images/star.png"></sup></span><input type="text" id="headEmail" name="person.institute.headEmail" value="" maxlength="50" class="tipTip" title="<s:property value="getText('form.email')"/>" />
                                    <label id="headEmailError" class="errormsg"><s:property value="getText('registrationPage.emailerror')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('headEmailError').get(0)"/></label>
                                </p><br/>
                                <p><span>Phone <sup><img src="images/star.png"></sup></span><input type="text" id="headPhone" name="person.institute.headContact" value="" maxlength="12" class="tipTip" onkeypress="return onlyNumbers(event);" title="<s:property value="getText('form.phone')"/>"/>
                                    <label id="headPhoneError" class="errormsg"><s:property value="getText('registrationPage.phoneIsEmpty')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('headPhoneNumberError').get(0)"/></label>
                                </p><br/>
                                <p><span>Check if same as Institute Address</span><input class="checkbox" id="sameAsInstituteAddress" type="checkbox" name="name" onclick="changeHeadAddress();" />
                                </p><br/><br/>
                                <p><span>Address <sup><img src="images/star.png"></sup></span><textarea rows="5" cols="50" id="headAddress" name="person.institute.headAddress" maxlength="150" class="tipTip" title="<s:property value="getText('form.address')"/>"></textarea>
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
                            <div >
                                <p><input class="checkbox" type="checkbox" id="termsAndConditions" name="termsAndConditions" value="1" />
                                    <b>Note that clicking here amounts to self declaration of the following:</b>
                                    <label id="termsError" class="errormsg"><s:property value="getText('registrationPage.termsAndConditionsError')" /></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('termAndConditionsError').get(0)"/></label>
                                </p>
                                <div id="noteForUser">
                                    <ul style="position: relative;left:15px;width:680px;"><li>All the information provided by me is correct and to the best of my knowledge.</li>
                                    </ul>  
                                </div>
                                <div id="noteForFaculty" style="display: none;">
                                    <ul style="position: relative;left:15px;width:680px;"><li>All the information provided by me is correct and to the best of my knowledge.</li>
                                        <li id="note2" style="text-align: justify;">In case the letter of my bonafides,is later detected to be wrong, I understand that I will
                                            not be given  certificate of participation, or if given, the same will be withdrawn.
                                            In such case, I accept that I will be liable to refund the expenditure incurred on me for participating in this workshop.</li>
                                    </ul>
                                </div>
                              </div>
                            <p><input style="position: relative;right: 50px" class="submit" type="submit" id="submit" name="submit" value="Submit" />
                                <input style="position: relative; right:75px"  class="submit" type="reset" id="reset" name="reset" value="Reset" onclick="resetRegistrationForm();"/></p>
                        </div>       
                        </form> 
                    </div> 
                            <script>
                                document.getElementById("facultyStCheckYes").checked=false;
                                document.getElementById("facultyStCheckNo").checked=false;
                            </script>        
                    </body>
