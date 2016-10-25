<%-- 
    Document   : updateDetailsSW
    Created on : 18 Oct, 2014, 2:25:57 PM
    Author     : asl
--%>

<%@page import="org.project.bean.Person"%>
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
<h3>Edit Profile</h3>
<div class="headmessage">Field marked with <sup><img src="images/star.png"></sup> are mandatory </div>    

<div class="form_enclosure">
    <font style="color: blue; font-size: 12px;"> Last Updated on <s:property value="person.last_login1"/></font>
    <s:iterator value="workshopContent">
        <h1><s:property value="workshopname" /></h1>
        <h4 align="center">National Mission on Education through ICT (MHRD, Govt. of India)</h4>
        <br/>
        <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>    
        <%--doupdateProfile.html --%>
        <form id="registrationForm" action="doupdateParticipantDetailsSW.html"  method="post" enctype="multipart/form-data" onsubmit="return validateEditDetailsPageSW(this);">
            <input type="hidden" name="facultyStatus" id="facultyStatus" value="<s:property value="facultyStatus"/>"/>
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
                </div> 
                <s:if test="(categorycode == 8 &&  permissionIfRequired== 1)">
                    <input type="hidden" id="pletterreq" name="pletterreq" value="1">
                    <div class="form_box">
                        <h2><b>Permission Letter</b></h2><br/>
                        <span>Permission Letter</span>
                        <input type="file" id="permissionLetter"  name="permissionLetter"/>
                        <label id="permissionLetterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.permissionLetterError')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('permissionLetterError').get(0)"/></label>
                    </div>
                </s:if>
                <s:else>
                    <input type="hidden" id="pletterreq" name="pletterreq" value="0">
                    <div class="form_box" style="display:none;">
                        <h2><b>Permission Letter</b></h2><br/>
                        <span>Permission Letter</span>
                        <input type="file" id="permissionLetter"  name="permissionLetter"/>
                        <label id="permissionLetterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.permissionLetterError')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('permissionLetterError').get(0)"/></label>
                    </div>
                </s:else>
                <div class="form_box" style="display: none;">
                    <h2><b>Remote Center Details</b></h2><br/>
                    <p>

                    <s:if test="categorycode == 4">
                        <span> State <sup><img src="images/star.png"></sup>
                        </span>
                        <s:iterator var="stateList" value="stateList" >
                            <s:if test="#stateList.stateId ==participantDetails.remoteCenter.rc_state">
                                <input readonly value="<s:property value="stateName"/>"/>          
                            </s:if>                                           
                        </s:iterator>                                    
                    </s:if>
                    <s:else>
                        <span>Select State <sup><img src="images/star.png"></sup>
                        </span>
                        <select id="state" name="state" onchange="changeState1();">
                            <option value="-1">--Select State--</option>
                            <s:iterator var="stateList" value="stateList" >
                                <s:if test="#stateList.stateId ==participantDetails.remoteCenter.rc_state">
                                    <option selected value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                    </s:else>                                      
                    <label id="stateError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.stateError')"/></label>
                    </p><br/>

                    <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
                        <s:iterator var="stateList" value="stateList" >
                            <s:if test="#stateList.stateId ==participantDetails.remoteCenter.rc_state">
                                <input type="hidden" id="stateID" value="<s:property value="stateId"/>" >
                            </s:if>
                        </s:iterator>
                    </s:if>

                    <input type="hidden" id="workshopid_enc" value="<s:property value="workshopid_encrypted"/>">
                           <%--  <s:if test="%{categorycode == 5}">                               
                                 <p><a onclick="openRCCapacity();" style="cursor: pointer;">Please Click Here to Check the Availability</a></p><br>
                             </s:if>   --%>                             
                           <p>
                    <s:if test="categorycode == 4">
                        <span> Remote Center <sup><img src="images/star.png"></sup>
                        </span>
                        <s:iterator var="remotecenterList" value="remotecenterList" >
                            <s:if test="#remotecenterList.remoteCenterId== participantDetails.remoteCenter.remoteCenterId">      
                                <input readonly value="<s:property value="remoteCenterName"/>, <s:property value="rc_city"/>"/>
                            </s:if>
                        </s:iterator>
                    </s:if><s:else>
                        <span>Select Remote Center <sup><img src="images/star.png"></sup></span>
                        <select id="remotecenter"  onchange="setRCID();">
                            <option value="-1">--Select a Remote Center--</option> 
                            <s:iterator var="remotecenterList" value="remotecenterList" >
                                <s:if test="#remotecenterList.remoteCenterId== participantDetails.remoteCenter.remoteCenterId">      
                                    <option selected value="<s:property value="remoteCenterId"/>"><s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                </s:if>
                                <s:else>   
                                    <option value="<s:property value="remoteCenterId"/>"><s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                </s:else>
                            </s:iterator>
                        </select></s:else>
                    <label id="remotecenterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.remotecenterError')"/></label>
                    </p>
                    <s:iterator var="remotecenterList" value="remotecenterList" >
                        <s:if test="#remotecenterList.remoteCenterId== participantDetails.remoteCenter.remoteCenterId">      
                            <input type="hidden" id="rc_original" value="<s:property value="remoteCenterId"/>"/>
                        </s:if>
                    </s:iterator>
                    <br/>                            
                    <p>
                    <s:if test="categorycode == 4">
                        <span> Remote Center ID<sup><img src="images/star.png"></sup>
                        </span>
                        <input readonly id="rcid" name="participant.rcid" value="<s:property value="participantDetails.remoteCenter.remoteCenterId"/>"/>

                    </s:if>
                    <s:else>
                        <span>Remote Center ID <sup><img src="images/star.png"></sup></span>
                        <input type="text" id="rcid" name="participant.rcid" value="<s:property value="participantDetails.remoteCenter.remoteCenterId"/>" class="tipTip" readonly title="<s:property value="getText('form.rcid')"/>"/>                        
                        <label id="remotecenterIdError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.remotecenteridError')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('cemailError').get(0)"/></label>
                    </s:else>
                    </p><br/> 
                    <input type="hidden" id="acco_original" value="<s:property value="participantDetails.registrationDetails.accomodation"/>"/>
                           <input type="hidden" id="acco_if_available" value="<s:property value="acco_available"/>"/>
                           <div class="radiobutton">
                        <p>
                            <span>Do you want Accommodation <sup><img src="images/star.png"></sup></span>
                            <span class="s"  style="width: 270px; font-size: 90%">
                                <s:if test="participantDetails.registrationDetails.accomodation.charAt(0).equals('Y') ">
                                    <input  style="width: 13px;height: 13px;padding:0 0 0 0; " id="acco1" type="radio" name="participant.accomodation" value="1" checked  />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </s:if>
                                <s:else>                                           
                                    <input style="width: 13px;height: 13px;padding:0 0 0 0; " id="acco1" type="radio" name="participant.accomodation" value="1" />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </s:else>
                                <s:if test="acco_available == 0 && participantDetails.registrationDetails.accomodation.charAt(0).equals('N')">
                                    <script>document.getElementById("acco1").disabled = true;</script>
                                </s:if>
                                <s:if test="participantDetails.registrationDetails.accomodation.charAt(0).equals('N') ">
                                    <input  style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="acco2" name="participant.accomodation" value="0" checked/>&nbsp;&nbsp;&nbsp; No
                                </s:if>
                                <s:else>                                         
                                    <input style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="acco2" name="participant.accomodation" value="0" />&nbsp;&nbsp;&nbsp; No
                                </s:else>
                            </span>
                            <span id="accomodationError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('workshopRegistrationForm.accomodationError')" /></span>
                            <label class="errorLabel"><s:property value="fieldErrors.get('genderError').get(0)"/></label><br/>
                        </p> 

                        <p style="display:none"><input type="text" id="categorycode" name="workshopcontent.categorycode" value="<s:property value="categorycode"/>"></p>
                        <p style="display:none"><input type="text" id="workshopid" name="workshopcontent.workshopid" value="<s:property value="workshopid"/>"></p>
                        <p style="display:none"><input type="text" id="workshopname" name="workshopcontent.workshopname" value="<s:property value="workshopname"/>"></p>


                        </s:iterator>
                    </div></div>
                <div class="form_box">
                    <h2> Personal Details of Participant</h2><br/>

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
                    <p><span><s:property value="getText('registrationPage.firstName')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="firstName" name="person.firstName" maxlength="30" value="${person.firstName}" class="tipTip" title="<s:property value="getText('form.name')"/>" />
                                                                                                                                                 <label id="firstNameError" class="errormsg"><s:property value="getText('registrationPage.fnameIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('firstNameError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.lastName')"/> </span><input type="text" id="lastName" name="person.lastName" maxlength="30" value="${person.lastName}"  />
                        <label id="lastNameError" class="errormsg"><s:property value="getText('registrationPage.lnameIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('lastNameError').get(0)"/></label>
                    </p><br/>
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
                    <s:if test="!(facultyStatus == 0)">
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
                            <label class="errorLabel"><s:property value="fieldErrors.get('designationError').get(0)"/></label>
                        </p><br/>
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
                        </div> 
                        <br/>        
                    </s:if>
                    <s:if test="(facultyStatus == 0)">
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
                            <label class="errorLabel"><s:property value="fieldErrors.get('designationError').get(0)"/></label>
                        </p><br/>
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
                        </div> 
                        <br/>        
                    </s:if>

                    <div class="radiobutton"><p><span><s:property value="getText('registrationPage.gender')"/> <sup><img src="images/star.png"></sup></span><span class="s"  style="width: 270px; ">
                                <s:if test="person.getGender().charAt(0).equals('M')">
                                    male&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="gender" type="radio" name="person.gender" value="M" checked/>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </s:if>
                                <s:else>
                                    male&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="gender" type="radio" name="person.gender" value="M" />   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </s:else>
                                <s:if test="person.getGender().charAt(0).equals('F')">
                                    female&nbsp;&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="gender" name="person.gender" checked value="F" /><br/>
                                </s:if>
                                <s:else>
                                    female&nbsp;&nbsp;&nbsp;<input style="  width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="gender" name="person.gender"  value="F" /><br/>
                                </s:else></span>
                            <span id="genderError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('registrationPage.genderError')" /></span>
                            <label class="errorLabel"><s:property value="fieldErrors.get('genderError').get(0)"/></label><br/></p>

                        <s:if test="!(facultyStatus == 0)">  
                            <div style="text-align: center;">
                                <%--<input type="text" name="h_photoPath" id="photoPath" value="${person.image}"/><br>--%>
                                <img src="UserImages/photo_<s:property value="userid"/>.jpg" height="150" width="150" >
                                     <br></div>                            
                            <div>
                                <span style="position: relative;bottom: 100px;">User Image:</span>                         
                            </div>
                        </s:if>
                    </div><br/>                            
                </div>
                <div class="form_box">
                    <h2>Contact Details of Participant</h2><br/> 
                    <p><span><s:property value="getText('registrationPage.homeAddress')"/> <sup><img src="images/star.png"></sup></span><textarea rows="5" cols="50" id="homeAddress" name="person.address"  maxlength="150" class="tipTip" title="<s:property value="getText('form.address')"/>"><s:text name="%{person.address}"/></textarea>
                        <label id="homeAddressError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('addressError').get(0)"/></label>
                    </p><br/>
                    <p>
                        <span><s:property value="getText('registrationPage.homeCity')"/> <sup><img src="images/star.png"></sup></span>
                        <input type="text" id="cityHome" name="person.City.cityName" value="${person.city.cityName}" maxlength="15" class="tipTip" onKeyPress="return ValidateAlpha(event);" title="<s:property value="getText('form.city')"/>"/>
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
                    <p><span><s:property value="getText('registrationPage.homePhone')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="phoneHome" name="person.phoneNumber" value="${person.phoneNumber}" maxlength="12" class="tipTip" onkeypress="return onlyNumbers(event);" title="<s:property value="getText('form.phone')"/>"/>
                                                                                                                                                 <label id="homePhoneError" class="errormsg"><s:property value="getText('registrationPage.phoneIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('phoneNumberError').get(0)"/></label>
                    </p><br/>
                </div>
                <s:if test="!(facultyStatus == 0)">  
                    <div class="form_box">
                        <h2>Institute Details of Participant</h2><br/>
                        <p><span><s:property value="getText('registrationPage.instituteState')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="stateInstitute" class="displayselect" name="person.Institute.State.stateId" onchange="changeState();">
                                <option value="-1">--Select the state--</option>
                                <s:iterator var="states" value="states">
                                    <s:if test="#states.stateId == participantDetails.getInstitute().getState().getStateId()">
                                        <option selected value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                            <label id="stateInstituteError" class="errormsg"><s:property value="getText('registrationPage.stateInstituteError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('instituteStateError').get(0)"/></label>
                        </p><br/>

                        <p><span><s:property value="getText('registrationPage.instituteCity')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="cityInstitute" class="displayselect" name="person.Institute.City.cityId" onchange="changeCity();">
                                <option value="-1">--Select the city--</option>
                                <s:iterator var="cities" value="cities">
                                    <s:if test="#cities.cityId == participantDetails.getInstitute().getCity().getCityId()">
                                        <option selected value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                            <label id="cityInstituteError" class="errormsg"><s:property value="getText('registrationPage.cityInstituteError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('instituteCityError').get(0)"/></label>
                        </p><br/>

                        <p><span><s:property value="getText('registrationPage.institute')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="institute" name="person.Institute.instituteId" onchange="toggleField();">
                                <option value="-1">--Select your institute--</option>
                                <s:iterator var="institutes" value="institutes">
                                    <s:if test="#institutes.instituteId == participantDetails.getInstitute().getInstituteId()">
                                        <option selected value="<s:property value="instituteId"/>"><s:property value="instituteName"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="instituteId"/>"><s:property value="instituteName"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                            <label id="instituteError" class="errormsg"><s:property value="getText('registrationPage.instituteError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('instituteError').get(0)"/></label>
                        </p><br/>
                        <p id="other" style="display:none;"><span><s:property value="getText('registrationPage.instituteOther')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="otherlabel" name="otherInstitute" value="" maxlength="70" class="tipTip" title="<s:property value="getText('form.othercollege')"/>"/>
                                                                                                                                                                                           <label id="otherInstituteError" class="errormsg"><s:property value="getText('registrationPage.otherInstituteError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('otherInstituteError').get(0)"/></label>
                            <br/><br/>
                        </p>
                        <p style="display:none;"><span><s:property value="getText('registrationPage.instituteAddress')"/> <sup><img src="images/star.png"></sup></span><textarea rows="5" id="instituteAddress" cols="50" name="person.institute.instituteAddress" maxlength="150" class="tipTip" title="<s:property value="getText('form.address')"/>"><s:text name="%{person.institute.instituteAddress}"/></textarea>
                            <label id="instituteAddressError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('instituteAddressError').get(0)"/></label>
                        </p><br/>
                        <p style="display:none;"><span><s:property value="getText('registrationPage.institutePincode')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="pincodeInstitute" name="person.institute.pincode" value="${person.institute.pincode}" maxlength="6" onkeypress="return onlyNumbers(event);" class="tipTip" title="Should be 6 digits"/>
                            <label id="institutePincodeError" class="errormsg" style="float:right;bottom: 20px;"><s:property value="getText('registrationPage.pincodeEmptyError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('institutePincodeError').get(0)"/></label>
                        </p><br/>
                    </div>
                </s:if>  
                <s:elseif test="(facultyStatus == 0)">
                    <div class="form_box" style="display:inline;">
                        <h2>Institute Details of Participant</h2><br/>
                        <p><span><s:property value="getText('registrationPage.instituteState')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="stateInstitute" class="displayselect" name="person.Institute.State.stateId" onchange="changeState();">
                                <option value="-1">--Select the state--</option>
                                <s:iterator var="states" value="states">
                                    <s:if test="#states.stateId == participantDetails.getInstitute().getState().getStateId()">
                                        <option selected value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                            <label id="stateInstituteError" class="errormsg"><s:property value="getText('registrationPage.stateInstituteError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('instituteStateError').get(0)"/></label>
                        </p><br/>
                        <p><span><s:property value="getText('registrationPage.instituteCity')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="cityInstitute" class="displayselect" name="person.Institute.City.cityId" onchange="changeCity();">
                                <option value="-1">--Select the city--</option>
                                <s:iterator var="cities" value="cities">
                                    <s:if test="#cities.cityId == participantDetails.getInstitute().getCity().getCityId()">
                                        <option selected value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="cityId"/>"><s:property value="cityName"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                            <label id="cityInstituteError" class="errormsg"><s:property value="getText('registrationPage.cityInstituteError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('instituteCityError').get(0)"/></label>
                        </p><br/>

                        <p><span><s:property value="getText('registrationPage.institute')"/> <sup><img src="images/star.png"></sup></span>
                            <select id="institute" name="person.Institute.instituteId" onchange="toggleField();">
                                <option value="-1">--Select the institute--</option>
                                <s:iterator var="institutes" value="institutes">
                                    <s:if test="#institutes.instituteId == participantDetails.getInstitute().getInstituteId()">
                                        <option selected value="<s:property value="instituteId"/>"><s:property value="instituteName"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="instituteId"/>"><s:property value="instituteName"/></option>
                                    </s:else>
                                </s:iterator>
                            </select>
                            <label id="instituteError" class="errormsg"><s:property value="getText('registrationPage.instituteError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('instituteError').get(0)"/></label>
                        </p><br/>
                        <p id="other" style="display:none;"><span><s:property value="getText('registrationPage.instituteOther')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="otherlabel" name="otherInstitute" value="" maxlength="70" class="tipTip" title="<s:property value="getText('form.othercollege')"/>"/>
                                                                                                                                                                                           <label id="otherInstituteError" class="errormsg"><s:property value="getText('registrationPage.otherInstituteError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('otherInstituteError').get(0)"/></label>
                            <br/><br/>
                        </p>
                        <p style="display:none;"><span><s:property value="getText('registrationPage.instituteAddress')"/> <sup><img src="images/star.png"></sup></span><textarea rows="5" id="instituteAddress" cols="50" name="person.institute.instituteAddress" maxlength="150" class="tipTip" title="<s:property value="getText('form.address')"/>"><s:text name="%{person.institute.instituteAddress}"/></textarea>
                            <label id="instituteAddressError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('instituteAddressError').get(0)"/></label>
                        </p><br/>
                        <p style="display:none;"><span><s:property value="getText('registrationPage.institutePincode')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="pincodeInstitute" name="person.institute.pincode" value="${person.institute.pincode}" maxlength="6" onkeypress="return onlyNumbers(event);" class="tipTip" title="Should be 6 digits"/>
                            <label id="institutePincodeError" class="errormsg" style="float:right;bottom: 20px;"><s:property value="getText('registrationPage.pincodeEmptyError')" /></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('institutePincodeError').get(0)"/></label>
                        </p><br/>
                    </div>
                </s:elseif>





                <%-- Fields not required --%>
                <div class="form_box" style="display:none;"> 
                    <h2>Details of Head of the Institute of Participant</h2><br/>

                    <p><span>Title <sup><img src="images/star.png"></sup></span>
                        <select id="headTitle" class="displayselect" name="person.institute.headTitle.headTitleId" onchange="setHtitleValue(this.value);">
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
                        <!--<input type="hidden" id="hidden_headtitle" name="person.institute.headTitle.headTitleId" value="<s:property value="headTitleId"/>"/>-->
                        <label id="headTitleError" class="errormsg"><s:property value="getText('registrationPage.titleError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headTitleError').get(0)"/></label>
                    </p><br/>
                    <p><span>Name <sup><img src="images/star.png"></sup></span><input type="text" id="headName" name="person.Institute.headName" value="${person.headInstitute.headName}" maxlength="30" class="tipTip" title="<s:property value="getText('form.name')"/>"/>
                                                                                          <label id="headNameError" class="errormsg"><s:property value="getText('registrationPage.headNameIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headNameError').get(0)"/></label>
                    </p><br/>
                    <p><span>Head Designation <sup><img src="images/star.png"></sup></span>
                        <select id="headDesignation" class="displayselect" name="person.Institute.HeadDesignation.headDesignationId">
                            <option value="-1">--Select the designation--</option>
                            <s:iterator var="headDesignations" value="headDesignations">
                                <s:if test="#headDesignations.headDesignationId == person.getHeadInstitute().getHeadDesignation().getHeadDesignationId()">
                                    <option selected value="<s:property value="headDesignationId"/>"><s:property value="headDesignationName"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="headDesignationId"/>"><s:property value="headDesignationName"/></option>
                                </s:else>
                            </s:iterator>
                        </select>
                        <label id="headDesignationError" class="errormsg"><s:property value="getText('registrationPage.headDesignationError')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('headDesignationError').get(0)"/></label>
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
                <p><input style="position: relative;left: 50px" class="submit" type="submit" name="submit" value="Update" />
                    <!--<input style="position: relative; right:75px"  class="submit" type="reset" name="reset" value="Reset" onclick="resetProfileForm();"/>-->
                </p>
            </div>       
        </form> 
</div>
<script>
    function validateEditDetailsPageSW(wrform) {
        var result = true;
        var value = 0;
        //getting form values
        var facultyStatus = document.getElementById("facultyStatus").value;
        var email = alltrim(document.getElementById("email").value.toLowerCase());
        //var cemail = alltrim(document.getElementById("cemail").value.toLowerCase());
        var title = alltrim(document.getElementById("title").value);
        var firstName = alltrim(document.getElementById("firstName").value);
        var lastName = alltrim(document.getElementById("lastName").value);
        var qualification = alltrim(document.getElementById("qualification").value);
        if (facultyStatus == 1 || facultyStatus == 0) {
            var designation = alltrim(document.getElementById("designation").value);
            var experience = $('input[id=experience]:checked').val();
            var stateInstitute = alltrim(document.getElementById("stateInstitute").value);
            var cityInstitute = alltrim(document.getElementById("cityInstitute").value);
            var institute = alltrim(document.getElementById("institute").value);
            document.getElementById('designationError').style.display = "none";
            document.getElementById('experienceError').style.display = "none";

        }
        var discipline = alltrim(document.getElementById("discipline").value);
        var instituteAddress = alltrim(document.getElementById("instituteAddress").value);
        var pincodeInstitute = alltrim(document.getElementById("pincodeInstitute").value);
        var homeAddress = alltrim(document.getElementById("homeAddress").value);
        var cityHome = alltrim(document.getElementById("cityHome").value);
        var pincodeHome = alltrim(document.getElementById("pincodeHome").value);
        var mobile = alltrim(document.getElementById("mobile").value);
        var phoneHome = alltrim(document.getElementById("phoneHome").value);
        var headTitle = alltrim(document.getElementById("headTitle").value);
        var headName = alltrim(document.getElementById("headName").value);
        var headDesignation = alltrim(document.getElementById("headDesignation").value);
        var headEmail = alltrim(document.getElementById("headEmail").value);
        var headPhone = alltrim(document.getElementById("headPhone").value);
        var headAddress = alltrim(document.getElementById("headAddress").value);
        var gender = $('input[id=gender]:checked').val();
        //clearing the previous errors
        document.getElementById("emailError").style.display = "none";
        //document.getElementById("cerror").style.display = "none";
        document.getElementById("titleError").style.display = "none";
        document.getElementById("firstNameError").style.display = "none";
        document.getElementById('lastNameError').style.display = "none";
        document.getElementById('qualificationError').style.display = "none";
        document.getElementById('disciplineError').style.display = "none";
        document.getElementById('genderError').style.display = "none";
        document.getElementById('stateInstituteError').style.display = "none";
        document.getElementById('cityInstituteError').style.display = "none";
        document.getElementById('instituteError').style.display = "none";
        document.getElementById('instituteAddressError').style.display = "none";
        document.getElementById('institutePincodeError').style.display = "none";
        document.getElementById('homeAddressError').style.display = "none";
        document.getElementById('homeCityError').style.display = "none";
        document.getElementById('homePincodeError').style.display = "none";
        document.getElementById('mobileError').style.display = "none";
        document.getElementById('homePhoneError').style.display = "none";
        document.getElementById('headTitleError').style.display = "none";
        document.getElementById('headNameError').style.display = "none";
        document.getElementById('headDesignationError').style.display = "none";
        document.getElementById('headEmailError').style.display = "none";
        document.getElementById('headPhoneError').style.display = "none";
        document.getElementById('headAddressError').style.display = "none";
        //resetting the border for the previous messages. 
        document.getElementById("email").style.border = "";
        //document.getElementById("cemail").style.border = "";
        document.getElementById("title").style.border = "";
        document.getElementById("firstName").style.border = "";
        document.getElementById("lastName").style.border = "";
        document.getElementById("qualification").style.border = "";
        document.getElementById("designation").style.border = "";
        document.getElementById("discipline").style.border = "";
        document.getElementById("stateInstitute").style.border = "";
        document.getElementById("cityInstitute").style.border = "";
        document.getElementById("institute").style.border = "";
        document.getElementById("instituteAddress").style.border = "";
        document.getElementById("pincodeInstitute").style.border = "";
        document.getElementById("homeAddress").style.border = "";
        document.getElementById("cityHome").style.border = "";
        document.getElementById("pincodeHome").style.border = "";
        document.getElementById("mobile").style.border = "";
        document.getElementById("phoneHome").style.border = "";
        document.getElementById("headTitle").style.border = "";
        document.getElementById("headName").style.border = "";
        document.getElementById("headDesignation").style.border = "";
        document.getElementById("headEmail").style.border = "";
        document.getElementById("headPhone").style.border = "";
        document.getElementById("headAddress").style.border = "";
        //validations starts
        if ((email) == "" || !emailValidator(email)) {
            borderRedError("email");
            document.getElementById("emailError").style.display = "inline";
            value++;
        }
        if (title == -1) {
            borderRedError("title");
            document.getElementById("titleError").style.display = "inline";
            value++;
        }
        if (!isStringInRange(firstName, 2, 30) || !validateLastName(firstName)) {
            borderRedError("firstName");
            document.getElementById("firstNameError").style.display = "inline";
            value++;
        }
        if(lastName.length > 0 ){
            if (!isStringInRange(lastName, 1, 30) || !validateLastName(lastName)) {
                borderRedError("lastName");
                document.getElementById('lastNameError').style.display = "inline";
                value++;
            }
        }
        if (qualification == -1) {
            borderRedError("qualification");
            document.getElementById('qualificationError').style.display = "inline";
            value++;
        }
        if (facultyStatus == 1 || facultyStatus == 0) {
            if (designation == -1) {
                borderRedError("designation");
                document.getElementById('designationError').style.display = "inline";
                value++;
            }
            if (experience == null || experience == "")
            {
                document.getElementById('experienceError').style.display = "inline";
                value++;
            }
            if (institute == -1 || institute == 0) {
                borderRedError("institute");
                document.getElementById('instituteError').style.display = "inline";
                value++;
            }
        }

        if (discipline == -1) {
            borderRedError("discipline");
            document.getElementById('disciplineError').style.display = "inline";
            value++;
        }

        if (gender == null || gender == "")
        {
            document.getElementById('genderError').style.display = "inline";
            value++;
        }
        if (stateInstitute == -1) {
            borderRedError("stateInstitute");
            document.getElementById('stateInstituteError').style.display = "inline";
            value++;
        }
        if (cityInstitute == -1) {
            borderRedError("cityInstitute");
            document.getElementById('cityInstituteError').style.display = "inline";
            value++;
        }


        //    if (!isStringInRange(instituteAddress, 5, 150) || !remarkValidator(instituteAddress)) {
        //        borderRedError("instituteAddress");
        //        document.getElementById('instituteAddressError').style.display = "inline";
        //        value++;
        //    }
        //
        //    if (!pincodeInstitute.match(pincoderegex)) {
        //        borderRedError("pincodeInstitute");
        //        document.getElementById('institutePincodeError').style.display = "inline";
        //        value++;
        //    }
        if (!isStringInRange(homeAddress, 5, 150) || !remarkValidator(homeAddress)) {
            borderRedError("homeAddress");
            document.getElementById('homeAddressError').style.display = "inline";
            value++;
        }

        if (!validateCityHome(cityHome, 3, 30)) {
            borderRedError("cityHome");
            document.getElementById('homeCityError').style.display = "inline";
            value++;
        }
        if (!pincodeHome.match(pincoderegex)) {
            borderRedError("pincodeHome");
            document.getElementById('homePincodeError').style.display = "inline";
            value++;
        }
        if (!validateMobilenumber(mobile)) {
            borderRedError("mobile");
            document.getElementById('mobileError').style.display = "inline";
            value++;
        }
        if (!phoneHome.match(phoneregex)) {
            borderRedError("phoneHome");
            document.getElementById('homePhoneError').style.display = "inline";
            value++;
        }
        //    if (headTitle == -1) {
        //        borderRedError("headTitle");
        //        document.getElementById('headTitleError').style.display = "inline";
        //        value++;
        //    }
        //    if (!isStringInRange(headName, 2, 50) || !isAlphabet(headName)) {
        //        borderRedError("headName");
        //        document.getElementById("headNameError").style.display = "inline";
        //        value++;
        //    }
        //    if (!isStringInRange(headName, 2, 50) || !validateLastName(headName)) {
        //        borderRedError("headName");
        //        document.getElementById("headNameError").style.display = "inline";
        //        value++;
        //    }
        //    if (headDesignation == -1) {
        //        borderRedError("headDesignation");
        //        document.getElementById('headDesignationError').style.display = "inline";
        //        value++;
        //    }
        //    if (alltrim(headEmail) == "" || !emailValidator(headEmail)) {
        //        borderRedError("headEmail");
        //        document.getElementById("headEmailError").style.display = "inline";
        //        value++;
        //    }
        //    if (!headPhone.match(phoneregex)) {
        //        borderRedError("headPhone");
        //        document.getElementById('headPhoneError').style.display = "inline";
        //        value++;
        //    }
        //    if (!isStringInRange(headAddress, 5, 175) || !remarkValidator(headAddress)) {
        //        borderRedError("headAddress");
        //        document.getElementById('headAddressError').style.display = "inline";
        //        value++;
        //    }

        //    clearWRFormErrorsAndBorder();
        document.getElementById("state").style.border = "";
        //document.getElementById("remotecenter").style.border = "";
        //document.getElementById("rcid").style.border = "";
        document.getElementById("permissionLetter").style.border = "";
        document.getElementById("stateError").style.display = "";
        //document.getElementById("remotecenterError").style.display = "";
        //document.getElementById("remotecenterIdError").style.display = "";
        //document.getElementById("accomodationError").style.display = "";
        document.getElementById("permissionLetterError").style.display = "";

        var state = document.getElementById("state").value;
       // var rc = document.getElementById("remotecenter").value;
       // var rcid = document.getElementById("rcid").value;
       // var acc1 = document.getElementById("acco1").checked;
       // var acc2 = document.getElementById("acco2").checked;
        var permissionLetter = wrform.permissionLetter.value;

        if (state == "" || state == null || state == "-1")
        {
            borderRedError("state");
            document.getElementById('stateError').style.display = "inline";
            value++;
        }
       /* if (rc == "" || rc == null || rc == "-1") {

            borderRedError("remotecenter");
            document.getElementById("remotecenterError").style.display = "inline";
            value++;
        }*/
        /*if (rcid == "" || rcid == null) {

            borderRedError("rcid");
            document.getElementById("remotecenterIdError").style.display = "inline";
            value++;
        }*/
        /*if (!(acc1 || acc2))
        {
            document.getElementById("accomodationError").style.display = "inline";
            value++;
        }*/
        if (!(permissionLetter == "" || permissionLetter == null)) {
            var size = wrform.permissionLetter.files[0].size;
            var val = validateLetter(permissionLetter);
            var val1 = checkFileSize(size, 262144);
            if (val == false || val1 == false) {
                borderRedError("permissionLetter");
                document.getElementById("permissionLetterError").style.display = "inline";
                value++;
            }
        }
        
        if (value > 0) {
            return false;
        }
        return result;
    }
</script>            
</body>

