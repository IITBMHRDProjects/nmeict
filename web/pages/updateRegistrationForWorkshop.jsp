<%-- 
    Document   : updateRegistrationForWorkshop
    Created on : 25 Nov, 2014, 11:52:15 AM
    Author     : Abinaya
--%>

<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript">
    var stateID = 0;
</script>
<body> 
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <s:if test="participant.isAlreadyRegistered==1 && participant.isNotValidForUpdate==1" >
        <%
            /**
             * content part getting from database for success
             */
            String page_content = "";
            ArrayList<Content> contents = null;
            Content data = new Content();
            UtilityProcess process = new UtilityProcess();
            try {
                contents = new ArrayList<Content>();
                contents = process.getPage_Content("isNotValidForUpdate_updateRegistration");
                for (int k = 0; k < contents.size(); k++) {
                    data = (org.project.bean.Content) contents.get(k);
                    page_content = (String) data.getContent();
                }
            } catch (Exception e) {
                page_content = "";
            }
            String part1 = "", part2 = "";  /*
             * use in split function
             */

            try {
                String string = page_content; /*
                 * storing content to variable string
                 */

                String[] parts = string.split("@name");
                part1 = parts[0]; // splited first string before contain @name
                part2 = parts[1]; // splited second string after contain @name
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <% if (!page_content.trim().equals("")) {%>
        <%=part1%><s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>
        <%=part2%>
        <% } else {%>
        <h3>Already Registered!</h3>
        <div class="form_enclosure">
            <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>
            <p style="color: green">You have already registered for this workshop in this site.</p>
            <%--<p>Please check your status by clicking <a href="<s:property value="workshopContent.link_participantList"/>" target="_blank" style="color: black;"><b>Here.</b></a></p>--%>
            <p><b>Regards,<br/>The  Team</b></p>
        </div>
        <% }%>    
    </s:if>
    <s:else>
        <s:iterator value="workshopContent">
            <h3>Form for Enrollment to the Workshop</h3>
            <div class="headmessage">Field marked with * are mandatory </div>
            <div class="form_enclosure">        
                <h1><s:property value="workshopname" /></h1>
                <h4 align="center">National Mission on Education through ICT (MHRD, Govt. of India)</h4>
                <br/>
                <s:if test="dateToBeDisplayed == 1">
                    <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>    
                </s:if><s:else></s:else>
                    <!--                
                                    <input type="text" value="<s:property value="participantDetails.remoteCenter.rc_state"/>"/>
                                    <input type="text" value="<s:property value="participantDetails.remoteCenter.remoteCenterId"/>"/>
                                    <input type="text" value="<s:property value="participantDetails.registrationDetails.accomodation.charAt(0).equals('Y')"/>"/>
                -->

                <form action="doUpdateWorkshopRegistraion.html" enctype="multipart/form-data" method="post" onsubmit="return validateWRForm2(this);">
                    <p style="display: none;"><input type="hidden" id="facultyStatus" name="facultyStatus" value="<s:property value="facultyStatus"/>"/></p>
                    <p style="display: none;"><input type="hidden" id="without_RC" name="without_RC" value="<s:property value="without_RC"/>"/></p>
                    <p style="display:none"><input type="hidden" id="categorycode" name="workshopContent.categorycode" value="<s:property value="categorycode"/>"></p>
                    <p style="display:none"><input type="hidden" id="workshopid" name="workshopContent.workshopid" value="<s:property value="workshopid"/>"></p>
                    <p style="display:none"><input type="hidden" id="workshopname" name="workshopContent.workshopname" value="<s:property value="workshopname"/>"></p>

                    <div class="form_settings">
                        <s:if test="%{categorycode == 8 }">
                            <s:if test="facultyStatus == 1">
                                <div class="form_box">
                                    <h2><b>Do you want Certificate</b></h2><br/>
                                    <p style="font-size: 14px; color: purple;">Note: Teaching faculty will be eligible for the ISCT certificate and IITBombayX honour code certificated. Others will only be eligible for IITBombayX honour code certificate.</p>
                                    <p style="display:none;">Are you faculty : <input type="checkbox" checked="true" id="facultycheck" onclick="showFacultyCertCheck()"/></p>
                                    <br><div class="radiobutton">
                                        <p id="facultyCCheck" style="display: inline;">Do you want  Certificate :&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input type="radio" id="facultyCertCheckYes" name="facultyCertcheck" style="  width: 13px;height: 13px;padding:0 0 0 0; " value="1" onclick="showPerLetter2()"/>&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                            <input type="radio" id="facultyCertCheckNo" name="facultyCertcheck" style="  width: 13px;height: 13px;padding:0 0 0 0; " value="0" onclick="showPerLetter2()"/>&nbsp;&nbsp;&nbsp; No
                                            <label id="facultyCertCheckError" class="errormsg"><s:property value="getText('registrationPage.facultyStatusCheckEmpty')" /></label>
                                        </p></div>
                                    <input type="hidden" id="pletterReqFlag" name="pletterReqFlag" value="0"/>
                                    </p></div>
                                <div id="perletter" class="form_box" style="display: none;">
                                    <h2><b>Permission Letter</b></h2><br/>
                                    <p>Please note that the scan copy of the Permission Letter should be less than 250 KB. Only jpeg/jpg format is accepted.
                                        If you have any problem in registration of your candidature please contact on 022-25764987.
                                        If you have any problem in uploading of Permission Letter then please email us at senderemail with subject as "Problem in Permission Letter upload"</p>
                                    <p><br>
                                        <span>Permission Letter <sup><img src="images/star.png"></sup></span>
                                        <input type="file" id="permissionLetter"  name="permissionLetter"/>
                                        <label id="permissionLetterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.permissionLetterError')"/></label>
                                        <label class="errorLabel"><s:property value="fieldErrors.get('permissionLetterError').get(0)"/></label>
                                    </p>
                                </div>
                            </s:if>
                            <s:else>
                                <br><p style="display:none;">Are you faculty : <input type="checkbox" id="facultycheck" onclick="showFacultyCertCheck()"/>
                                    <input type="checkbox" id="facultyCertcheck" onclick="showPerLetter()"/>
                                    <input type="hidden" id="pletterReqFlag" name="pletterReqFlag" value="0"/>
                                </p>
                                <p style="display: none;">
                                    <span>Permission Letter <sup><img src="images/star.png"></sup></span>
                                    <input type="file" id="permissionLetter"  name="permissionLetter"/>
                                    <label id="permissionLetterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.permissionLetterError')"/></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('permissionLetterError').get(0)"/></label>
                                </p>   
                            </s:else>
                        </s:if>
                        <s:else>
                            <div class="form_box">
                                <h2><b>Permission Letter</b></h2><br/>
                                <p>Please note that the scan copy of the Permission Letter should be less than 250 KB. Only jpeg/jpg format is accepted.
                                    If you have any problem in registration of your candidature please contact on 022-25764987.
                                    If you have any problem in uploading of Permission Letter then please email us at senderemail with subject as "Problem in Permission Letter upload"<br/>
                                    <b>NOTE : Please upload your updated Permission letter</b></p>
                                <p>
                                    <span>Permission Letter <sup><img src="images/star.png"></sup></span>
                                    <input type="file" id="permissionLetter"  name="permissionLetter"/>
                                    <label id="permissionLetterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.permissionLetterError')"/></label>
                                    <label class="errorLabel"><s:property value="fieldErrors.get('permissionLetterError').get(0)"/></label>
                                </p>
                            </div>
                        </s:else>
                        <s:if test='%{without_RC == 0}'> 
                            <div class="form_box">
                                <h2><b>Remote Center Details</b></h2><br/>
                                <p>

                                    <s:if test="categorycode == 4">
                                        <span> State <sup><img src="images/star.png"></sup>
                                        </span>
                                        <s:iterator var="stateList" value="stateList" >
                                            <s:if test="#stateList.stateId ==participantDetails.remoteCenter.rc_state">
                                                <input readonly value="<s:property value="stateName"/>"/>          
                                                <input type="hidden" id="state" name="state" value="<s:property value="stateName"/>"/>
                                            </s:if> 
                                        </s:iterator>                                    
                                    </s:if>
                                    <s:else>
                                        <span>Select State <sup><img src="images/star.png"></sup>
                                        </span>
                                        <select id="state" name="state" onchange="changeState();">
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
                                <s:if test="%{categorycode == 5 || categorycode == 8}">                               
                                    <p><a onclick="openRCCapacity();" style="cursor: pointer;">Please Click Here for the information about Remote Center</a></p><br>
                                </s:if>  
                                <s:if test="%{categorycode == 7 }">                               
                                    <p><a onclick="openRCCapacity();" style="cursor: pointer;">Click here to know the Availability, Cost of Accommodation & Food at Remote Centers</a></p><br>
                                </s:if>                                 
                                <p>
                                    <s:if test="categorycode == 4">
                                        <span> Remote Center <sup><img src="images/star.png"></sup>
                                        </span>
                                        <s:iterator var="remotecenterList" value="remotecenterList" >
                                            <s:if test="#remotecenterList.remoteCenterId== participantDetails.remoteCenter.remoteCenterId">      
                                                <input readonly value="<s:property value="remoteCenterName"/>"/>
                                                <input type="hidden" id="remotecenter" value="<s:property value="remoteCenterId"/>"/>

                                            </s:if>
                                        </s:iterator>
                                    </s:if><s:else>
                                        <span>Select Remote Center <sup><img src="images/star.png"></sup></span>
                                        <select id="remotecenter"  onchange="setRCID();">
                                            <option value="-1">--Select a Remote Center--</option> 
                                            <s:iterator var="remotecenterList" value="remotecenterList" >
                                                <s:if test="#remotecenterList.remoteCenterId== participantDetails.remoteCenter.remoteCenterId">      
                                                    <option selected value="<s:property value="remoteCenterId"/>"><s:property value="remoteCenterName"/></option>
                                                </s:if>
                                                <s:else>   
                                                    <option value="<s:property value="remoteCenterId"/>"><s:property value="remoteCenterName"/></option>
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

                                <s:if test="%{accommodation == 0}">
                                    <div class="radiobutton" style="display: none">                               
                                        <p>
                                            <span>Do you want Accommodation <sup><img src="images/star.png"></sup></span>
                                            <span class="s"  style="width: 270px; font-size: 90%">
                                                <input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="acco1" type="radio" name="participant.accomodation" value="1" />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input style="  width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="acco2" checked name="participant.accomodation" value="0" />&nbsp;&nbsp;&nbsp; No
                                            </span>
                                            <span id="accomodationError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('workshopRegistrationForm.accomodationError')" /></span>
                                            <label class="errorLabel"><s:property value="fieldErrors.get('genderError').get(0)"/></label><br/>
                                        </p>
                                    </div>
                                </s:if>
                                <s:else>
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
                                    </div>
                                </s:else>
                            </div>
                        </s:if>
                        <s:else>                            
                            <input type="hidden" id="rcid" name="participant.rcid" value="10000"/>
                        </s:else>

                        <div class="form_box">
                            <br/>
                            <s:if test="%{categorycode == 8}">
                                <br><br><div>
                                    <p style="color: purple;">Fee amount to be paid (Rs.): <s:property value="feeAmount"/> (non refundable)</p>
                                </div> 
                            </s:if>
                            <br/><br/>
                            <p><input class="checkbox" type="checkbox" id="termsAndConditions" name="termsAndConditions" value="1" />
                                <b>Note that clicking here amounts to self declaration of the following:</b>
                                <label id="termsError" class="errormsg"><s:property value="getText('registrationPage.termsAndConditionsError')" /></label>
                                <label class="errorLabel"><s:property value="fieldErrors.get('termAndConditionsError').get(0)"/></label>
                            </p>
                            <s:if test="facultyStatus == 1">
                                <div id="showall">   
                                    <ol>
                                        <li>I have read and understood all the instructions given for the registration to the workshop.</li>
                                        <li>All information provided by me is correct and to the best of my knowledge.</li>
                                        <li style="text-align: justify;">In case the letter of my bonafides,is later detected to be wrong, I understand that I will
                                            not be given  certificate of participation, or if given, the same will be withdrawn.
                                        </li>
                                    </ol>
                                </div>
                                <div id="showonlytwo" style="display: none;">   
                                    <ol>
                                        <li>I have read and understood all the instructions given for the registration to the workshop.</li>
                                        <li>All information provided by me is correct and to the best of my knowledge.</li>
                                    </ol>
                                </div>
                            </s:if>
                            <s:else>
                                <ol>
                                    <li>I have read and understood all the instructions given for the registration to the workshop.</li>
                                    <li>All information provided by me is correct and to the best of my knowledge.</li>
                                </ol> 
                            </s:else>
                            <br/><br/>
                            <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" /><input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="resetWRForm2();"/></p>
                        </div>
                    </div>
                </form>          
            </div>
        </s:iterator>
    </s:else>
    <script>
        function showFacultyCertCheck() {
            var isfacultycheck = document.getElementById("facultycheck").checked;
            if (isfacultycheck == true) {
                document.getElementById("facultyCCheck").style.display = "inline";
            } else {
                document.getElementById("facultyCCheck").style.display = "none";
                document.getElementById("perletter").style.display = "none";
                document.getElementById("facultyCertcheck").checked = false;
            }
        }
        function showPerLetter() {
            var isfacultycheck = document.getElementById("facultycheck").checked;
            var isfacultycertcheck = document.getElementById("facultyCertcheck").checked;
            if (isfacultycheck == true && isfacultycertcheck == true) {
                document.getElementById("perletter").style.display = "inline";
                document.getElementById("pletterReqFlag").value = "1";
            } else {
                document.getElementById("perletter").style.display = "none";
                document.getElementById("pletterReqFlag").value = "0";
            }
        }


        function showPerLetter2() {
            var isfacultycheck = document.getElementById("facultycheck").checked;
            var isfacultycertcheckY = document.getElementById('facultyCertCheckYes').checked;
            var isfacultycertcheckN = document.getElementById('facultyCertCheckNo').checked;
            if (isfacultycheck == true && isfacultycertcheckY == true) {
                document.getElementById("perletter").style.display = "inline";
                document.getElementById("pletterReqFlag").value = "1";
                document.getElementById("showall").style.display = "inline";
                document.getElementById("showonlytwo").style.display = "none";
            } else if (isfacultycheck == true && isfacultycertcheckN == true) {
                document.getElementById("perletter").style.display = "none";
                document.getElementById("pletterReqFlag").value = "0";
                document.getElementById("showonlytwo").style.display = "inline";
                document.getElementById("showall").style.display = "none";
            }
        }
    </script>
</body>
