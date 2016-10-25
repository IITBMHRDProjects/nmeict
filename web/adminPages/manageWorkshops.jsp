<%-- 
    Document   : manageWorkshops
    Created on : 28 Aug, 2014, 4:11:25 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<body>
    <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId != 1}'>
        <s:if test="hasActionErrors()">
            <div class="msg msg-error">
                <s:actionerror/>
                <a href="javascript:void(0);" class="close">close</a>
            </div>
        </s:if>
        <h3>Manage Workshops</h3>
        <div class="headmessage">
            All fields marked with * are mandatory.
        </div>
        <div class="form_enclosure">
            <div class="form_settings">
                <form id="manageWorkshopForm" action="doManageWorkshop.html"  method="post" enctype="multipart/form-data" onsubmit="return validateWorkshopForm(this);">
                    <div class="form_box">
                        <h2>Workshop Contents</h2><br/>
                        <p><span>Select Workshop  <sup><img src="images/star.png"></sup></span>
                            <select id="selectWorkshop" name="" onchange="reportWorkshop(this.value);">
                                <option value="selectWorkshop">select workshop</option>
                                <s:iterator value="recentWorkshops">
                                    <option value="<s:property value="workshopid"/>"><s:property value="workshopname"/>  -- <s:property value="workshopid"/></option>
                                </s:iterator>
                                <option value="newWorkshop">Enter a new Workshop</option>
                            </select><input type="button" style="width: 50px; background: black; color: white;position: relative;left:20px;" value="New" onclick="reportWorkshop('newWorkshop')"/>
                        </p><br/>
                        <p id="newWorkshopName"  style="display: none;"><span>Workshop Name  <sup><img src="images/star.png"></sup></span><input type="text" id="workshopName" name="content.workshopname"/>
                            <label id="workshopNameError" class="errormsg"><s:property value="getText('workshopManagementForm.workshopNameError')"/></label>
                            <br/></p>
                        <p style="display: none;"><input type="text" id="isNew" name="content.isNew" value="false"/>
                            <br/></p>
                        <br/>
                        <p>
                            <span>Sponsor  <sup><img src="images/star.png"></sup></span>
                            <input type="text" id="sponsor" name="content.sponsor"/>
                            <label id="sponsorError" class="errormsg"><s:property value="getText('workshopManagementForm.sponsorError')"/></label>
                        </p>
                        <br/>
                        <div class="radiobutton"><p><span>Category Code  <sup><img src="images/star.png"></sup></span>
                                <span class="s"  style="width: 270px; font-size: 90%;top:7px; "> 
                                    Coordinator&nbsp;&nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0;position: relative;top:3px;font-size:90%; " type="radio" id="categorycode1" name="content.categorycode" value="4"  onclick="reportCCode(this.value);"/> 
                                    Funded Main&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="categorycode2" type="radio" name="content.categorycode" value="5" onclick="reportCCode(this.value);"/><br/>
                                    On Invite&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="categorycode3" type="radio" name="content.categorycode" value="6" onclick="reportCCode(this.value);"/>
                                    &nbsp;&nbsp;&nbsp;Self-Sustained Main &nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="categorycode4" type="radio" name="content.categorycode" value="7" onclick="reportCCode(this.value);"/><br>
                                    Self-Sustained PM &nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="categorycode5" type="radio" name="content.categorycode" value="8" onclick="reportCCode(this.value);"/>

                                </span>
                                <label id="categoryError" class="errormsg"><s:property value="getText('workshopManagementForm.categoryError')"/></label>
                                <br/><br/>
                        </div><br/><br/><br/>
                        <p>
                            <span>Workshop id  <sup><img src="images/star.png"></sup></span>
                            <input disabled="true" id="workshopid"  type="text" />
                            <label id="workshopidError" class="errormsg"><s:property value="getText('workshopManagementForm.workshopidError')"/></label>
                        </p><br/>                       
                        <p style="display: none"><span>Workshop id</span><input hidden id="workshopid1" name="content.workshopid"  type="text" />
                        </p>
                        <div class="radiobutton" style="display:none;" id="resMWToBeCreated"><p><span>Main Workshop Category Code  <sup><img src="images/star.png"></sup></span>
                                <span class="s"  style="width: 270px; font-size: 100%;top:7px; "> 
                                    Main&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="maincc1" type="radio" name="content.maincc" value="5" />
                                    &nbsp;&nbsp;&nbsp;Self-Sustained Main &nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="maincc2" type="radio" name="content.maincc" value="7"/><br/>
                                    Self-Sustained PM &nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="maincc3" type="radio" name="content.maincc" value="8"/><br/>

                                </span>
                                <label id="mainccError" class="errormsg"><s:property value="getText('workshopManagementForm.categoryError')"/></label>

                            <br/><br/><br/></div>

                        <p id="resCoWorkshopid" style="">
                            <span>Related Workshop ID <sup><img src="images/star.png"></sup></span>
                            <input name="content.respectiveCoWorkshopid" id="resCoWorkshopidInput"  type="text"  class="tipTip" title="It should be either Coordinators workshop id or Main workshop id"/>
                            <label id="resCoWorkshopidError" class="errormsg"><s:property value="getText('workshopManagementForm.resCoWorkshopidError')"/></label>
                            <br/><br/></p>
                        <br/>
                        <div id="without_rc_div" style="display:none;">  
                            <!--without_RC to be inserted here-->
                            <div class="radiobutton"><p><span>Workshop without face to face/ Without Remote center <sup><img src="images/star.png"></sup></span>
                                    <span class="s"  style="width: 270px;  font-size: 100%;"> 
                                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="without_RC1" name="content.without_RC" value="0" onclick="show_paymentRC()"/>&nbsp;&nbsp; With RC &nbsp;&nbsp;
                                        <input style="  width: 13px; height: 13px;padding:0 0 0 0;" id="without_RC2" type="radio" name="content.without_RC" value="1" onclick="show_paymentRC()"/>&nbsp;&nbsp;Without RC<br/></span>                
<!--                                    <label id="coursewarestatusError" class="errormsg"><s:property value="getText('workshopManagementForm.coursewareError')"/></label>-->
                            </div>
                            <br/><br/><br/>
                        </div>
                        <div id="payment_div" style="display:none;">
                            <div class="radiobutton"><p><span>Payment Modes to be enabled</span>
                                    <span class="s"  style="width: 270px; font-size: 100%;top:7px;"> 
                                        At Remote center&nbsp;&nbsp;&nbsp;&nbsp; <input style=" width: 13px;height: 13px; padding:0 0 0 0;position: relative;top:3px;font-size:90%; " type="checkbox" id="payment_mode_1" name="content.payment_at_rc" value="1"  /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
                                        Organisation's Payment gateway&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="payment_mode_2" type="checkbox" name="content.payment_at_iitb" value="1" checked /><br/></span>
                            </div>
                            <br/><br/> 
                            <p>
                                <span>Fee Amount (Only for SSM - Org Payment gateway )<sup><img src="images/star.png"></sup></span>
                                <input type="text" id="feeAmount" name="content.feeAmount" onkeypress="return onlyNumbers1(event);" onblur="CheckDecimal(this.value);" title="<s:property value="getText('form.feeAmount')"/>"/>
                                <label id="feeAmountError" class="errormsg"><s:property value="getText('workshopManagementForm.feeAmountError')"/></label>
                                <input type="hidden" name="content.ccpay" id="ccpay" value="0"/>
                            </p>
                            <br/>  <br/> 
                        </div>  

                        <div id="withdrawal_div" style="display:none;">  
                            <!--without_RC to be inserted here-->
                            <div class="radiobutton"><p><span>Should withdraw button to be displayed in participant's dashboard? <sup><img src="images/star.png"></sup></span>
                                    <span class="s"  style="width: 270px;  font-size: 100%;"> 
                                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="withdraw1" name="content.withdrawal_flag" value="1" onclick="show_paymentRC()"/>&nbsp;&nbsp; Yes &nbsp;&nbsp;
                                        <input style="  width: 13px; height: 13px;padding:0 0 0 0;" id="withdraw2" type="radio" name="content.withdrawal_flag" value="0" onclick="show_paymentRC()" checked />&nbsp;&nbsp; No <br/></span>                
                            </div>
                            <br/><br/><br/>
                        </div>
                    </div>
                    <div class="form_box">
                        <h2>Course content</h2>
                        <p>
                            <span>Course Coordinator  <sup><img src="images/star.png"></sup></span>
                            <input type="text" id="author" name="content.author"/>                     
                            <label id="authorError" class="errormsg"><s:property value="getText('workshopManagementForm.authorError')"/></label>
                        </p>
                        <br/>
                        <p><span>Introduction  <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="introduction" name="content.introduction"></textarea>
                            <label id="introductionError" class="errormsg"><s:property value="getText('workshopManagementForm.introductionError')"/></label>
                        </p>
                        <br/>
                        <p>
                            <span>Course Content  <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="objectives" name="content.objectives"></textarea>
                            <label id="objectivesError" class="errormsg"><s:property value="getText('workshopManagementForm.objectivesError')"/></label>
                        </p>
                        <br/>

                        <p>
                            <span>Teaching Faculty  <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="teachingfaculty" name="content.teachingfaculty"></textarea>
                            <label id="teachingfacultyError" class="errormsg"><s:property value="getText('workshopManagementForm.teachingFacultyError')"/></label>
                        </p>
                        <br/>
                        <p>
                            <span>Who should Attend  <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="whoshouldattend" name="content.whoshouldattend"></textarea>
                            <label id="whoshouldattendError" class="errormsg"><s:property value="getText('workshopManagementForm.whoshdattendError')"/></label>
                        </p>
                        <br/>
                        <p>
                            <span>Duration and Venue  <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="durationvenue" name="content.durationvenue"></textarea>
                            <label id="durationvenueError" class="errormsg"><s:property value="getText('workshopManagementForm.durationVenueError')"/></label>
                        </p>
                        <br/>
                        <p>
                            <span>Criteria for Certification <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="certificateCriteria" name="content.certificateCriteria"></textarea>
                            <label id="certificateCriteriaError" class="errormsg"><s:property value="getText('workshopManagementForm.certificateCriteriaError')"/></label>
                        </p>
                        <br/>

                        <p>
                            <span>Course Fee  <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="coursefee" name="content.coursefee"></textarea>
                            <label id="coursefeeError" class="errormsg"><s:property value="getText('workshopManagementForm.courseFeeError')"/></label>
                        </p>                                              
                        <p>
                            <span>How to Apply  <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="howtoapply" name="content.howtoapply"></textarea>
                            <label id="howtoapplyError" class="errormsg"><s:property value="getText('workshopManagementForm.howtoapplyError')"/></label>
                        </p>
                        <br/>
                        <p>
                            <span>Accommodation  <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="accomodation" name="content.accomodation"></textarea>
                            <label id="accomodationError" class="errormsg"><s:property value="getText('workshopManagementForm.accommodationError')"/></label>
                        </p>
                        <br/>
                        <p>
                            <span>Note  <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="note" name="content.note"></textarea>
                            <label id="noteError" class="errormsg"><s:property value="getText('workshopManagementForm.noteError')"/></label>
                        </p>
                        <br/>


                        <p>
                            <span>Address for communication <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="contact" name="content.contact"></textarea>
                            <label id="contactError" class="errormsg"><s:property value="getText('workshopManagementForm.contactError')"/></label>
                        </p>
                        <br/> 
                        <p><span>Instructions  <sup><img src="images/star.png"></sup></span>
                            <textarea rows="5" cols="50" id="instructions" name="content.instructions"></textarea>
                            <label id="instructionsError" class="errormsg"><s:property value="getText('workshopManagementForm.instructionError')"/></label>
                        </p>
                        <br/>
                    </div>
                    <div class="form_box">
                        <h2>Important Dates and status</h2>
                        <p>
                            <span>Registration Start Date  <sup><img src="images/star.png"></sup></span>
                            <input type="text" readonly id="datepicker1" name="content.startdatereg">
                            <label id="regstartdateError" class="errormsg"><s:property value="getText('workshopManagementForm.regStartDateError')"/></label>
                        </p>
                        <br/>
                        <p>
                            <span>Registration End Date  <sup><img src="images/star.png"></sup></span>
                            <input type="text" readonly id="datepicker2" name="content.lastdatereg" onblur="">
                            <label id="reglastdateError" class="errormsg"><s:property value="getText('workshopManagementForm.regLastDateError')"/></label>
                        </p>
                        <br/>
                        <p>
                            <span>Workshop Start Date  <sup><img src="images/star.png"></sup></span>
                            <input type="text" readonly id="datepicker3" name="content.startdate">
                            <label id="startdateError" class="errormsg"><s:property value="getText('workshopManagementForm.startDateError')"/></label>
                        </p>
                        <br/>
                        <p>
                            <span>Workshop End Date  <sup><img src="images/star.png"></sup></span>
                            <input type="text" readonly id="datepicker4" name="content.enddate" onblur="">
                            <label id="enddateError" class="errormsg"><s:property value="getText('workshopManagementForm.endDateError')"/></label>
                        </p>
                        <br/>
                        <p style="display: inline;">
                            <span>Date to be displayed </span> 
                            <input style="width: 25px; height: 25px;" type="checkbox" id="dateToBeDisplayed" onclick="dateDisplayChange()" checked="true"/>
                            <label style="color:#474686; font-size: 90%;">Un-check if the workshop date on announcement page is not to be displayed.</label>
                            <input type="hidden" name="content.dateToBeDisplayed" id="dateDisplay" value="1"/>
                        </p><br/>
                        <div class="radiobutton" style="display: none;"><p><span>Status</span>
                                <span class="s"  style="width: 270px; font-size: 100%;top:7px; " name="content.eventstatus"> 
                                    Forthcoming&nbsp;&nbsp;&nbsp <input style=" width: 13px;height: 13px; padding:0 0 0 0;position: relative;top:3px; " type="radio" id="eventstatus" name="content.eventstatus" value="Forthcoming" /> &nbsp;&nbsp;&nbsp;&nbsp;
                                    Ongoing&nbsp;&nbsp<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;" id="eventstatus" type="radio" name="content.eventstatus" value="Ongoing" />&nbsp;&nbsp;
                                    Future&nbsp;&nbsp;&nbsp;&nbsp;<input style=" width: 13px;height: 13px;padding:0 0 0 0; position: relative;top:3px;" type="radio" id="eventstatus" name="content.eventstatus" value="Future" /> &nbsp;&nbsp;&nbsp;&nbsp;
                                    <br/>
                                    Completed &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;" type="radio" id="eventstatus" name="content.eventstatus" value="Completed" />&nbsp;&nbsp;&nbsp;
                                    Registration Closed  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style=" width: 13px;height: 13px;padding:0 0 0 0;position: relative;top:3px; " type="radio" id="eventstatus" name="content.eventstatus" value="Registration Closed" /><br/>
                                </span>

                        </div><br/><br/>
                        <div class="radiobutton"><p><span>Course-ware availability  <sup><img src="images/star.png"></sup></span>
                                <span class="s"  style="width: 270px;  font-size: 90%;"> 
                                    <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="coursewarestatus1" name="content.coursewarestatus" value="Available Soon" />&nbsp;&nbsp; Available Soon&nbsp;&nbsp;
                                    <input style="  width: 13px; height: 13px;padding:0 0 0 0;" id="coursewarestatus2" type="radio" name="content.coursewarestatus" value="View/Download" />&nbsp;&nbsp;View/Download<br/></span>                
                                <label id="coursewarestatusError" class="errormsg"><s:property value="getText('workshopManagementForm.coursewareError')"/></label>
                        </div>
                    </div>
                    <div class="form_box">
                        <h2>Important Files</h2>
                        <p style="display: none">
                            <span>Ceritficate  <sup><img src="images/star.png"></sup></span>
                            <input type="text" id="certificatepath" name="content.certificatepath" value="certificate"/>
                            <label id="certificatepathError" class="errormsg"><s:property value="getText('workshopManagementForm.certificatePathError')"/></label>
                        </p>
                        <p>
                            <span>Certificate <br/> (upload a xhtml)</span>
                            <input type="file" id="certificate" name="certificate" title="Please upload a xhtml file"/>
                            <label id="certificate" class="errormsg" style="color: black;display: inline;font-weight: bold"></label>
                        </p>
                        <br/>
                        <div class="radiobutton"><p><span>Certificate Grouping Criteria</span>
                                <span class="s"  style="width: 270px; font-size: 100%;top:7px;"> 
                                    State Wise&nbsp;&nbsp;&nbsp;&nbsp; <input style=" width: 13px;height: 13px; padding:0 0 0 0;position: relative;top:3px;font-size:90%; " type="checkbox" id="certificategroup1" name="content.certificateGroupInstitute" value="1"  /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
                                    Remote-Center Wise&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="certificategroup2" type="checkbox" name="content.certificateGroupRC" value="1" checked /><br/></span>
                                <label id="certificateGroupError" class="errormsg"><s:property value="getText('workshopManagementForm.certificateGroupError')"/></label>
                        </div>
                        <br/>
                        <p>
                            <span>Permission Letter <br/> (upload a pdf) </span>
                            <input type="file" id="permissionLetter"  name="permissionLetter" title="Please upload a pdf file"/>
                            <label id="permissionLetterPath" class="errormsg" style="color: black;display: inline;font-weight: bold"></label>
                        </p>
                        <br/>
                        <p>
                            <span>Brochure <br/> (upload a pdf)  </span>
                            <input type="file" id="brochure" name="brochure" title="Please upload a pdf file" />
                            <label id="brochurePath" class="errormsg" style="color: black;display: inline;font-weight: bold"></label>
                        </p>
                        <br/>
                        <p>
                            <span>Eligibility <br/> (upload a pdf)</span>
                            <input type="file" id="eligibility" name="eligibility" title="Please upload a pdf file"/>
                            <label id="eligibilityPath" class="errormsg" style="color: black;display: inline;font-weight: bold"></label>
                        </p>
                        <br/>
                        <p>
                            <span>Registration Success Mail <br/> (upload a html)</span>
                            <input type="file" id="mailcontent" name="mailcontent" title="Please upload a html file"/>
                            <label id="mailcontentPath" class="errormsg" style="color: black;display: inline;font-weight: bold"></label>
                        </p>
                        <br/>
                        <p>
                            <span>Programme Schedule <br/> (upload a pdf) </span>
                            <input type="file" id="programmeSchedule"  name="programmeSchedule" title="Please upload a pdf file"/>
                            <label id="programmeScheduleError" class="errormsg" style="color: black;display: inline;font-weight: bold"></label>
                        </p>
                        <br/>
                        <p>
                            <span>Resource Path</span>
                            <input type="text" id="resourcepath" name="content.resourcepath"/>
                            <label id="resourcepathError" class="errormsg"><s:property value="getText('workshopManagementForm.resourcepathError')"/></label>
                        </p>
                        <br/>
                        <p>
                            <span>Announcement Name  <sup><img src="images/star.png"></sup></span>
                            <input type="text" id="announcement" name="content.announcement"/>
                            <label id="announcementError" class="errormsg"><s:property value="getText('workshopManagementForm.announcementError')"/></label>
                        </p>

                    </div>
                    <div class="form_box" >
                        <h2>Information Regarding Permission Letter and Accommodation</h2>
                        <br/>
                        <div class="radiobutton"><p><span>Accommodation</span>
                                <span class="s"  style="width: 270px; font-size: 90%;top:7px;"> 
                                    Available&nbsp;&nbsp;&nbsp;&nbsp; <input style=" width: 13px;height: 13px; padding:0 0 0 0;position: relative;top:3px;font-size:90%; " type="radio" id="accommodation1" name="content.accommodation" value="1" checked /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    Not Available&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="accommodation2" type="radio" name="content.accommodation" value="0" /><br/></span>
                                <label id="accommodationError" class="errormsg"><s:property value="getText('workshopManagementForm.accommodationError')"/></label>
                        </div><br/>
                        <p><span>Select if permission letter is required <sup><img src="images/star.png"></sup></span>
                            <select id="permissionIfRequired" name="content.permissionIfRequired" >
                                <option value="-1">--select--</option>
                                <option value="0">Not required</option>
                                <option value="1" selected="true">Permission Letter Required</option>
                                <option value="2">College ID required</option>
                                <option value="3">Both can be uploaded</option>
                            </select>
                            <label id="permissionIfRequiredError" class="errormsg"><s:property value="getText('workshopManagementForm.permissionIfRequiredError')"/></label>
                        </p><br/><br/>
                        <div class="radiobutton"><p><span>Learning Management System</span>
                                <span class="s"  style="width: 270px; font-size: 100%;top:7px;"> 
                                    Moodle&nbsp;&nbsp;&nbsp;&nbsp; <input style=" width: 13px;height: 13px; padding:0 0 0 0;position: relative;top:3px;font-size:90%; " type="checkbox" id="lms1" name="content.lms_moodle" value="1" checked /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    IITBx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="  width: 13px; height: 13px;padding:0 0 0 0;position: relative;top:3px;font-size:90%;" id="lms2" type="checkbox" name="content.lms_iitbx" value="1" /><br/></span>
                                <label id="lmsError" class="errormsg"><s:property value="getText('workshopManagementForm.lmsError')"/></label>
                        </div><br/>
                        <p>
                            <span>Moodle Course-name  </span>
                            <input  id="moodle_coursename" name="content.moodle_coursename"  type="text" class="tipTip" title="Should be same as workshop name" />
                        </p><br/>
                        <p>
                            <span>IITBx Course-name  </span>
                            <input  id="iitbx_coursename" name="content.iitbx_coursename" type="text" />
                        </p><br/>
                        <br/><br/>

                        <p>
                            <input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" />
                            <input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="resetWorkshopManageform();"/>
                        </p>
                    </div>

                </form>
            </div>
        </div>
    </s:if>
    <script>
        function onlyNumbers1(evt)
        {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                return false;

            return true;
        }
    </script>
    <script>
        function CheckDecimal(inputtxt)
        {
            document.getElementById("feeAmountError").style.display = "none";
            if (inputtxt.split('.').length > 2) {
                document.getElementById("feeAmountError").style.display = "inline";
            }
        }
    </script>
</body>