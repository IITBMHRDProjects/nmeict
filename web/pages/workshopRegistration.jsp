<%-- 
    Document   : workshopRegistration
    Created on : 12 Jun, 2014, 4:26:24 PM
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
    function showRCFN(value) {
        if (value == 1) {
            //display the rc select and reset values
            document.getElementById("display_rc_data").style.display = "inline";
            document.getElementById("state").value = "-1";
            $("#remotecenter").html("");
            var option = "<option value=\"-1\">--Select a Remote Center--</option>";
            $("#remotecenter").append(option);
            document.getElementById("rcid").value = "";

        }
        if (value == 0) {
            //display the rc select and reset values
            document.getElementById("display_rc_data").style.display = "none";
            document.getElementById("state").value = "21";
            document.getElementById("rcid").value = "10000";
            $("#remotecenter").html("");
            var option = "<option value=\"-1\">--Select a Remote Center--</option>";
            option += "<option selected value=\"10000\">Indian Institute of Technology, Bombay</option>";
            $("#remotecenter").append(option);
        }
    }
</script>
<%
    /**
     * java code for getting content from database
     */
    String page_content = "";
    ArrayList<Content> contents = null;
    Content data = new Content();
    UtilityProcess process = new UtilityProcess();
%>
<body>
    <style>
        #mask{
            position: absolute;
            background-color: #000;
            z-index: 9000;
            display: none;
        }

        #boxes .window{
            position: fixed;
            height: 415px;
            width: 640px;
            z-index: 9999;
            /*padding: 20px;*/
            border: 1px solid orange;
            display: none;
            /*background: #3d2c10;*/
            /*background: #1e90ff;*/
            background: #57626A;

        }

        #boxes #dialog {
            /*height: 409px;
            width: 675px;*/
            height: 469px;
            width: 675px;
        }

        #top{
            /*color: olive;*/
            color: white;
            /*background: #1e90ff;*/
            background: #57626A;
            font-size: 20px;
            margin-left: 10px;
        }

        #dialog .close{
            position: absolute;
            top: 0;
            right: 0;
            text-align: right;
            text-decoration: none;
            /*color: olive;*/
            color: white;
            margin-right: 10px;

        }

        #inwindow{
            margin-top: 0;
            /*background: wheat;*/ 
            /*height: 355px;*/
            height: 405px;
            border-top:  5px solid #1d1b6d;
            overflow: scroll;
            /*background: whitesmoke;*/
            background: #FBFBFB;
        }

        #invalid_list{
            margin-left: 20px;
            font-size: 14px;
            padding: 5px;
        }
        #other_div{
            margin-left: 20px;
        }
        #sendM{
            margin-left: 150px;
            background: #000;
            color: white;
            font-size: 15px;
            padding: 5px;
        }
    </style>
    <div id="boxes">
        <div id="dialog" class="window">
            <p id="top">Authorization 
                <a href="#" class="close">Close</a>
            </p>
            <div id="inwindow">
                <div style="text-align: center; ">
                    <b>Indian Institute of Technology Bombay<br>
                        Welcome to IITBombayX [Extension online educational services]
                        <br><br>Authorization for releasing your contribution in open source</b>
                </div>
                <div>
                    <div style="padding: 10px;">
                        <span><b>Preamble</b></span><br><br> 
                        <p style="text-align: justify;">In most of our educational services, which involve digital content, we promote release of such content in Open Source. This is also the mandate of National Mission on Education through Information Communication Technology (NME-ICT), which funds many of our training programmes and workshops for teachers. In this Open Source knowledge initiative, we record lectures, interaction with participants, text documents, discussions, assignments and the like by participants, in suitable digital format. This content is released in Open Source under the Creative Commons license, CC BY-SA 4.0, with an objective to encourage actual adoption of these contents and the teaching methodology developed in each subject. 
                            <br/><br/>As a participant, you are required to agree to release content submitted or contributed by you in this manner, by consenting to the following authorization. In the registration/enrolment form which you fill, a ‘tick’ on the statement, “I have read ‘Authorization Document’, and agree 
                            to release the content in Open Source”, will be considered as your agreement for such release.
                        </p><br>
                        <span><b>Authorization</b></span><br><br>
                        <p style="text-align: justify;"> I do not have any objection if my interactions with instructors and participants, and   any material produced or contributed by me during the course work, is recorded and released in Open Source on CDs, DVDs, websites, and in printed form or the like. I understand that I continue to hold the authorship of the content created by me. I assure that to the best of my knowledge, I have not violated copyright of any other copyright owner.</p><br>
                        <span><b>Creative Commons License</b></span> &nbsp;&nbsp;<img src="images/common-license.png" width="120"><br>
                        <div style="padding: 10px;">
                            <div style="margin-bottom: 2px; text-align: center;"><b>Attribution-Share Alike 4.0 International (CC BY-SA 4.0)</b></div>
                            <div style="margin-bottom: 2px;">This is a human-readable summary of (and not a substitute for) the license.</div>
                            <div style="margin-bottom: 2px;"><b>You are free to:</b></div>
                            <div style="margin-bottom: 2px;"><b>Share</b> — copy and redistribute the material in any medium or format</div>
                            <div style="margin-bottom: 2px;"><b>Adapt</b> — remix, transform, and build upon the material for any purpose, even commercially.</div>
                            <div style="margin-bottom: 2px;">The licensor cannot revoke these freedoms as long as you follow the license terms.</div>
                            <div style="margin-bottom: 2px;"><b>Under the following terms:</b></div>
                            <div style="margin-bottom: 2px;">Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. 
                            </div>
                            <div style="margin-bottom: 2px;"><b>Share Alike</b> — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.</div>
                            <div style="margin-bottom: 2px;"><b>No additional restrictions</b> — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.</div>
                            <div style="margin-bottom: 2px;"><b>Notices:</b></div>
                            <div style="margin-bottom: 2px;">You do not have to comply with the license for elements of the material in the public domain or where your use is permitted by an applicable exception or limitation.
                            </div>
                            <div style="margin-bottom: 2px;">No warranties are given. The license may not give you all of the permissions necessary for your intended use. For example, other rights such as publicity, privacy, or moral rights may limit how you use the material.</div>
                        </div>
                    </div>    
                </div>
            </div>
        </div>
        <div id="mask"></div>
    </div>
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <s:if test='%{ifWSC > 0 || ifRCC > 0 || ifRCC1 > 0}'>
        <p> <b>You cannot register for this workshop as a participant</b></p>
    </s:if>
    <s:else>
        <s:if test="%{workshopContent[0].categorycode != 8 && facultyStatus == 0}">
            <p style="color: #FF4500;"> You cannot register for this workshop as a participant.<br/>This workshop is only for users who are employed as a faculty in any educational institution. <br/>
            </p>
        </s:if><s:else>
            <s:if test="participant.isAlreadyRegistered==1" >
                <%
                    /**
                     * content part getting from database for success
                     */
                    try {
                        contents = new ArrayList<Content>();
                        contents = process.getPage_Content("already_register_participant");
                        for (int k = 0; k < contents.size(); k++) {
                            data = (org.project.bean.Content) contents.get(k);
                            page_content = (String) data.getContent();
                        }
                    } catch (Exception e) {
                        page_content = "";
                    }
                    String part1 = "", part2 = "";
                    /*
                     * use in split function
                     */

                    try {
                        String string = page_content;
                        /*
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
                <%--<s:set var="content"><%= page_content%></s:set>
                <s:property escape="false" value="content"/>--%>

                <% } else {%>
                <h3>You are Already Registered!</h3>
                <div class="form_enclosure">
                    <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>
                    <p style="color: green">You have registered for this workshop in this site.
                    </p>
                    <%--<p>Please check your status by clicking <a href="<s:property value="workshopContent.link_participantList"/>" target="_blank" style="color: black;"><b>Here.</b></a></p>--%>
                    <p><b>Regards,<br/>The  Team</b></p>
                </div>
                <% }%>
            </s:if>
            <s:else>
                <s:if test="%{notValidParticipant == 0}">
                    <%
                        /**
                         * content part getting from database for success
                         */
                        try {
                            contents = new ArrayList<Content>();
                            contents = process.getPage_Content("not_valid_participant");
                            for (int k = 0; k < contents.size(); k++) {
                                data = (org.project.bean.Content) contents.get(k);
                                page_content = (String) data.getContent();
                            }
                        } catch (Exception e) {
                            page_content = "";
                        }
                        String part3 = "", part4 = "";
                        /*
                         * use in split function
                         */

                        try {
                            String string1 = page_content;
                            /*
                             * storing content to variable string
                             */

                            String[] parts1 = string1.split("@name");
                            part3 = parts1[0]; // splited first string before contain @name
                            part4 = parts1[1]; // splited second string after contain @name
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                    <% if (!page_content.trim().equals("")) {%>
                    <%=part3%><s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>
                    <%=part4%>
                    <%--<s:set var="content"><%= page_content%></s:set>
                    <s:property escape="false" value="content"/>--%>

                    <% } else {%>
                    <h3>Not Eligible to Register for the Workshop</h3>
                    <div class="form_enclosure">
                        <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>
                        <p style="color: red">You are not eligible to register for this workshop.
                        </p>                
                    </div>
                    <% }%>
                </s:if>
                <s:else>
                    <s:if test="%{ifusernameupdated == 0}">
                        <%
                            /**
                             * content part getting from database for success
                             */
                            try {
                                contents = new ArrayList<Content>();
                                contents = process.getPage_Content("profile_update_popup");
                                for (int k = 0; k < contents.size(); k++) {
                                    data = (org.project.bean.Content) contents.get(k);
                                    page_content = (String) data.getContent();
                                }
                            } catch (Exception e) {
                                page_content = "";
                            }
                            String part5 = "", part6 = "";
                            /*
                             * use in split function
                             */

                            try {
                                String string2 = page_content;
                                /*
                                 * storing content to variable string
                                 */

                                String[] parts2 = string2.split("@name");
                                part5 = parts2[0]; // splited first string before contain @name
                                part6 = parts2[1]; // splited second string after contain @name
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                        <% if (!page_content.trim().equals("")) {%>
                        <%=part5%><s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>
                        <%=part6%>
                        <%--<s:set var="content"><%= page_content%></s:set>
                        <s:property escape="false" value="content"/>--%>

                        <% } else {%>
                        <h3>Profile Not Updated</h3>
                        <div class="form_enclosure">
                            <p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>
                            <p style="color: red">You have not updated the profile.
                            </p>
                            <p>Please edit your profile before registering for this workshop. </p>
                            <p>To update your profile go to settings and edit profile OR <a href="updateProfile.html"><b>click here to update</b></a></p>

                        </div>
                        <% }%>
                    </s:if>
                    <s:else>        <s:iterator value="workshopContent">
                            <h3>Form for Enrollment to the Workshop</h3>
                            <div class="headmessage">Field marked with * are mandatory </div>
                            <div class="form_enclosure">        
                                <h1><s:property value="workshopname" /></h1>
                                <h4 align="center">National Mission on Education through ICT (MHRD, Govt. of India)</h4>
                                <br/>
                                <s:if test="dateToBeDisplayed == 1">
                                    <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>    
                                </s:if><s:else></s:else>
                                    <form action="doRegisterForWorkshop.html" enctype="multipart/form-data" method="post" onsubmit="return validateWRForm(this);">

                                        <p style="display:none"><input type="hidden" id="categorycode" name="workshopContent.categorycode" value="<s:property value="categorycode"/>"></p>
                                    <p style="display:none"><input type="hidden" id="workshopid" name="workshopContent.workshopid" value="<s:property value="workshopid"/>"></p>
                                    <p style="display:none"><input type="hidden" id="workshopname" name="workshopContent.workshopname" value="<s:property value="workshopname"/>"></p>
                                    <p style="display:none"><input type="hidden" id="accommodation" name="workshopContent.accommodation" value="<s:property value="accommodation"/>"></p>
                                    <p style="display:none"><input type="hidden" id="permission_ifreq" name="workshopContent.permissionIfRequired" value="<s:property value="permissionIfRequired"/>"></p>
                                    <p style="display: none"><input type="hidden" id="resCoWorkshopid" name="workshopContent.respectiveCoWorkshopid" value="<s:property value="respectiveCoWorkshopid"/>"></p>
                                    <p style="display: none;"><input type="hidden" id="facultyStatus" name="facultyStatus" value="<s:property value="facultyStatus"/>"/></p>
                                    <p style="display: none;"><input type="hidden" id="without_RC" name="workshopContent.without_RC" value="<s:property value="without_RC"/>"/></p>

                                    <div class="form_settings">
                                        <div class="form_box">
                                            <h2><b>Personal Details</b></h2><br/>
                                            <p><span>Name</span>
                                                <input type="text" readonly="true" style="font-size: 110%;" value="<s:property value="participant1.name"/>"/>
                                            </p>
                                            <s:if test="%{facultyStatus == 1 || facultyStatus == 0}">
                                                <p><span>Institute / Organization</span>
                                                    <textarea  readonly="true"><s:property value="participant1.institute.instituteName"/></textarea>
                                                    <label id="instituteError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.instituteError')"/></label>
                                                    <input type="hidden" id="ins_name_hidden" value="<s:property value="participant1.institute.instituteName"/>"/>
                                                </p>
                                                <p><b>NOTE : If your personal details are not correct, please make sure you edit the profile before registering for the workshop.</b></p>
                                            </s:if>
                                            <s:else>
                                                <label style="display:none;" id="instituteError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.instituteError')"/></label>
                                                <input type="hidden" id="ins_name_hidden" value=""/>
                                            </s:else>
                                        </div>
                                        <s:if test="%{permissionIfRequired == 1}">
                                            <s:if test="%{categorycode == 8}">
                                                <s:if test="facultyStatus == 1">
                                                    <div class="form_box">
                                                        <h2><b>Do you want  Certificate</b></h2><br/>
                                                        <p style="font-size: 14px; color: purple;">Note: Only employed faculty teaching in educational institute are eligible both for  and IITBX honour code certificate. Others will be eligible for only IITBX honour code certificate. Selecting the Yes option for the  certificate does not imply that you will be eligible for the Certificate. 
                                                            <br/>
                                                        </p><p style="font-weight: bold;">  The certificate will be awarded, only after successful completion of the criteria prescribed for the STTP. </p>
                                                        <br><p style="display:none;">Are you faculty : <input type="checkbox" checked="true" id="facultycheck" onclick="showFacultyCertCheck()"/>
                                                            <%--<p id="facultyCCheck" style="display: none;">Do you want  Certificate : <input type="checkbox" id="facultyCertcheck" onclick="showPerLetter()"/></p>--%>
                                                        <div class="radiobutton">
                                                            <p id="facultyCCheck" style="display: inline;">Do you want  Certificate :&nbsp;&nbsp;&nbsp;&nbsp;
                                                                <input type="radio" id="facultyCertCheckYes" name="facultyCertcheck" style="  width: 13px;height: 13px;padding:0 0 0 0; " value="1" onclick="showPerLetter1()"/>&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                                                <input type="radio" id="facultyCertCheckNo" name="facultyCertcheck" style="  width: 13px;height: 13px;padding:0 0 0 0; " value="0" onclick="showPerLetter1()"/>&nbsp;&nbsp;&nbsp; No
                                                                <label id="facultyCertCheckError" class="errormsg"><s:property value="getText('registrationPage.facultyStatusCheckEmpty')" /></label>
                                                            </p></div>
                                                        <input type="hidden" id="pletterReqFlag" name="pletterReqFlag" value="0"/>
                                                        </p></div>
                                                    <div id="perletter" class="form_box" style="display: none;">
                                                        <h2><b>Permission Letter</b></h2><br/>
                                                        <p>Please note that the scan copy of the Permission Letter should be less than 250 KB. Only jpeg/jpg format is accepted.
                                                            If you have any problem in registration of your candidature please contact on 022-25764987.
                                                            If you have any problem in uploading of Permission Letter then please email us at senderemail with subject as "Problem in Permission Letter upload".</p>
                                                        <br><p>
                                                            <span>Permission Letter <sup><img src="images/star.png"></sup></span>
                                                            <input type="file" id="permissionLetter"  name="permissionLetter"/>
                                                            <label id="permissionLetterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.permissionLetterError')"/></label>
                                                            <label class="errorLabel"><s:property value="fieldErrors.get('permissionLetterError').get(0)"/></label>
                                                        </p>
                                                    </div>
                                                </s:if><s:else>
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
                                            </s:if><s:else>
                                                <div class="form_box"><h2><b>Permission Letter</b></h2><br/>
                                                    <p>Please note that the scan copy of the Permission Letter should be less than 250 KB. Only jpeg/jpg format is accepted.
                                                        If you have any problem in registration of your candidature please contact on 022-25764987.
                                                        If you have any problem in uploading of Permission Letter then please email us at senderemail with subject as "Problem in Permission Letter upload".</p>
                                                    <br><p>
                                                        <span>Permission Letter <sup><img src="images/star.png"></sup></span>
                                                        <input type="file" id="permissionLetter"  name="permissionLetter"/>
                                                        <label id="permissionLetterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.permissionLetterError')"/></label>
                                                        <label class="errorLabel"><s:property value="fieldErrors.get('permissionLetterError').get(0)"/></label>
                                                    </p>
                                                </div> 
                                            </s:else>
                                        </s:if>
                                        <s:else>
                                            <input type="hidden"  id="permissionLetter"  name="permissionLetter"/>
                                            <label style="display: none;"id="permissionLetterError"  class="errormsg"></label>
                                        </s:else>
                                        <s:if test='%{without_RC == 0}'>
                                            <div class="form_box">
                                                <h2><b>Remote Center Details</b></h2><br/>
                                                <s:if test="%{categorycode == 4 && respectiveCoWorkshopid != 0}">
                                                    <p>
                                                        <span>Is your institute a remote center of IIT Bombay <sup><img src="images/star.png"></sup></span>
                                                        <span class="s"  style="width: 270px; font-size: 90%">
                                                            <input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="ifrc1" type="radio" name="participant.if_institute_is_rc" value="1" onclick="showRCFN(this.value);"/>&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <input style="  width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="ifrc2"  name="participant.if_institute_is_rc" value="0" onclick="showRCFN(this.value);" />&nbsp;&nbsp;&nbsp; No
                                                        </span>
                                                        <span id="ifrcError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('workshopRegistrationForm.ifrcError')" /></span>
                                                        <label class="errorLabel"><s:property value="fieldErrors.get('genderError').get(0)"/></label><br/>
                                                    </p>
                                                    <br/><br/>
                                                    <div id="display_rc_data" style="display: none;"><p>
                                                            <span>Select State <sup><img src="images/star.png"></sup></span>
                                                            <select id="state" name="state" onchange="changeState();">
                                                                <option value="-1">--Select State--</option>
                                                                <s:iterator value="stateList" >
                                                                    <s:if test='%{stateId == 21}'>
                                                                        <option selected value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                                                    </s:if>
                                                                    <s:else>
                                                                        <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                                                    </s:else>
                                                                </s:iterator>
                                                            </select>
                                                            <label id="stateError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.stateError')"/></label>
                                                        </p><br/>
                                                        <input type="hidden" id="stateID" value="0" >
                                                        <input type="hidden" id="workshopid_enc" value="<s:property value="workshopid_encrypted"/>">
                                                        <s:if test="%{categorycode == 5}">                               
                                                            <p><a onclick="openRCCapacity();" style="cursor: pointer;">Please Click Here for the information about Remote Center</a></p><br>
                                                        </s:if>                                
                                                        <p>
                                                            <span>Select Remote Center <sup><img src="images/star.png"></sup></span>
                                                            <select id="remotecenter"  onchange="setRCID();">                                                                                       
                                                                <option value="-1">--Select a Remote Center--</option>
                                                                <s:iterator value="rc_static" >    
                                                                    <s:if test='%{remoteCenterId == 10000}'>  
                                                                        <option selected value="<s:property value="remoteCenterId"/>"><s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                                                    </s:if>
                                                                    <s:else>
                                                                        <option value="<s:property value="remoteCenterId"/>"><s:property value="remoteCenterName"/>, <s:property value="rc_city"/></option>
                                                                    </s:else>
                                                                </s:iterator> 
                                                            </select>
                                                            <label id="remotecenterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.remotecenterError')"/></label>
                                                        </p>
                                                        <br/>                            
                                                        <p>
                                                            <span>Remote Center ID <sup><img src="images/star.png"></sup></span>
                                                            <input type="text" id="rcid" name="participant.rcid" value="10000" class="tipTip" readonly title="<s:property value="getText('form.rcid')"/>"/>                        
                                                            <label id="remotecenterIdError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.remotecenteridError')"/></label>
                                                            <label class="errorLabel"><s:property value="fieldErrors.get('cemailError').get(0)"/></label>
                                                        </p><br/> 
                                                    </div>
                                                </s:if>
                                                <s:else>
                                                    <span id="ifrcError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('workshopRegistrationForm.ifrcError')" /></span>
                                                    <br/><br/>
                                                    <p>
                                                        <span>Select State <sup><img src="images/star.png"></sup></span>
                                                        <select id="state" name="state" onchange="changeState();">
                                                            <option value="-1">--Select State--</option>
                                                            <s:iterator value="stateList" >
                                                                <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                                            </s:iterator>
                                                        </select>
                                                        <label id="stateError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.stateError')"/></label>
                                                    </p><br/>
                                                    <input type="hidden" id="stateID" value="0" >
                                                    <input type="hidden" id="workshopid_enc" value="<s:property value="workshopid_encrypted"/>">
                                                    <s:if test="%{categorycode == 5 || categorycode == 8}">                               
                                                        <p><a onclick="openRCCapacity();" style="cursor: pointer;">Please Click Here for the information about Remote Center</a></p><br>
                                                    </s:if>  
                                                    <s:if test="%{categorycode == 7 }">                               
                                                        <p><a onclick="openRCCapacity();" style="cursor: pointer;">Click here to know the Availability, Cost of Accommodation & Food at Remote Centers</a></p><br>
                                                    </s:if>  
                                                    <p>
                                                        <span>Select Remote Center <sup><img src="images/star.png"></sup></span>
                                                        <select id="remotecenter"  onchange="setRCID();">
                                                            <option value="-1">--Select a Remote Center--</option>                                
                                                        </select>
                                                        <label id="remotecenterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.remotecenterError')"/></label>
                                                    </p>
                                                    <br/>                            
                                                    <p>
                                                        <span>Remote Center ID <sup><img src="images/star.png"></sup></span>
                                                        <input type="text" id="rcid" name="participant.rcid" value="" class="tipTip" readonly title="<s:property value="getText('form.rcid')"/>"/>                        
                                                        <label id="remotecenterIdError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.remotecenteridError')"/></label>
                                                        <label class="errorLabel"><s:property value="fieldErrors.get('cemailError').get(0)"/></label>
                                                    </p><br/> 
                                                </s:else>
                                                <div>
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
                                                                    <input style="  width: 13px;height: 13px;padding:0 0 0 0; " id="acco1" type="radio" name="participant.accomodation" value="1" />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <input style="  width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="acco2" name="participant.accomodation" value="0" />&nbsp;&nbsp;&nbsp; No
                                                                </span>
                                                                <span id="accomodationError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('workshopRegistrationForm.accomodationError')" /></span>
                                                                <label class="errorLabel"><s:property value="fieldErrors.get('genderError').get(0)"/></label><br/>
                                                            </p>
                                                        </div>
                                                    </s:else>
                                                </div>
                                            </div>
                                        </s:if>
                                        <s:else>
                                            <input type="hidden" id="rcid" name="participant.rcid" value="10000"/>  
                                        </s:else>
                                        <div class="form_box">
                                            <s:if test="%{categorycode == 8 }">
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
                                            <p><input class="checkbox" type="checkbox" id="termsAndConditions1" name="termsAndConditions1" value="1" />
                                                <b>I have read <a onclick="showAuthorization();">"Authorization Document"</a> and agree to release the content in open source.</b>
                                                <label id="termsError1" class="errormsg"><s:property value="getText('registrationPage.termsAndConditionsError')" /></label>
                                                <label class="errorLabel"><s:property value="fieldErrors.get('termAndConditionsError').get(0)"/></label>
                                            </p>
                                            <br/><br/><br/><input type="hidden" name="hiddenfee" value="<s:property value="feeAmount"/>"/>
                                            <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" /><input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="resetWRForm();"/></p>
                                        </div>
                                    </div>
                                </form>         
                            </div>
                        </s:iterator>
                    </s:else> 
                </s:else>
            </s:else>
        </s:else></s:else>
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

        function showPerLetter1() {
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

    <script>
        function call_modelBox2() {
            // div id which will be used in cover the all screen
            var id = "#dialog";
            //Get the screen height and width
            var maskheight = $(document).height();
            var maskwidth = $(window).width();
            //Set height and width to mask to fill up the whole screen
            //  $('#mask').css({'width': maskwidth, 'height': maskheight});
            //transition effect   
            //   $('#mask').fadeIn(1000);
            //   $('#mask').fadeTo('slow', 0.8);
            //Get the window height and width
            var winH = $(window).height();
            var winW = $(window).width();
            //Set the popup window to center
            $(id).css('top', winH / 2 - $(id).height() / 2);
            $(id).css('left', winW / 2 - $(id).width() / 2);
            //connecting to database and retrieve data
            //fetclistlookups();
            //transition effect
            //  $(id).fadeIn(2000);
            $(id).fadeIn(100);
            // $('#dialog').hide();
            $("#other_msg").val("");
            // });

            //if close button is clicked
            $('.window .close').click(function(e) {
                // alert("close");
                e.preventDefault();
                //  $('#mask, .window').hide();
            });

            $('#mask').click(function() {
                $(this).hide();
                $('.window').hide();
            });
        }
    </script>
    <script>
        $('.window .close').click(function(e) {
            e.preventDefault();
            $('#mask, .window').hide();
        });

        $('#mask').click(function() {
            $(this).hide();
            $('.window').hide();
        });
    </script>
    <script>
        function showAuthorization() {
            call_modelBox2();
        }
    </script>
</body>
