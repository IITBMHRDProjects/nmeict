<%-- 
    Document   : privateWorkshopRegistration
    Created on : 22 Jun, 2015, 10:20:45 AM
    Author     : Abinaya
--%>
<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
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

    /**
     * java code for getting content from database
     */
    String page_content = "";
    ArrayList<Content> contents = null;
    Content data = new Content();
    UtilityProcess process = new UtilityProcess();
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">       
    <meta name="description" content="website description" />
    <meta name="keywords" content="website keywords, website keywords" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title>'Project Name' | Update Profile</title>
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="stylesheet" href="css/tipTip.css"/>
    <link rel="stylesheet" href="css/css3-buttons.css"/>
    <!-- modernizr enables HTML5 elements and feature detects -->
    <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>   
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/jquery.easing-sooper.js"></script>
    <script type="text/javascript" src="js/jquery.sooperfish.js"></script>
    <script type="text/javascript" src="js/project_common.js"></script>
    <script type="text/javascript" src="js/jquery.tipTip.minified.js"></script>
    <script type="text/javascript" src="js/ajaxedit.js"></script>
    <script type="text/javascript" src="js/ajaxcaptcha.js"></script>
    <script type="text/javascript" src="js/ajaxscript.js"></script>
    <script type="text/javascript" src="validation/validate.js"></script>
    <script type="text/javascript">
        $(function() {
            $(".tipTip").tipTip({defaultPosition: "right"});
        });
        function funCE(){          
            var email = document.getElementById("email").value.toLowerCase();
            var cemail = document.getElementById("cemail").value.toLowerCase();
            if (email == cemail) {
                document.getElementById("cerror").style.display = "none";
                document.getElementById("cemail").style.border='';
            } else
            {
                document.getElementById("cemail").style.border="1px solid red";
                document.getElementById("cerror").style.display='inline';      
            }
        }
        
        function onlyNumbers(evt)
        {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
        
        function ValidateAlpha(evt)
        {
            var keyCode = (evt.which) ? evt.which : event.keyCode
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32)
                return false;
        
            return true;
        }
        
        function changeHeadAddress(){
            var headaddress=document.getElementById('instituteAddress').value;
            if(!registrationForm.sameAsInstituteAddress.checked==true){
                document.getElementById('headAddress').value= "";
            } else       
                document.getElementById('headAddress').value=headaddress;
        }
        
        function changeState() {
            var stateID = document.getElementById('stateInstitute').value;
            if (stateID != -1) {
                fetchCity(stateID);
            }else {
                document.getElementById('stateInstitute').value = "-1";
            }
        }
        
        function changeCity(userid) {
            var cityID = document.getElementById('cityInstitute').value;
            if (cityID != -1) {
                // fetchInstitute(cityID);
                fetchPartcipantInstitute(cityID,userid);
                resetInstituteDetails();
            }else {
                document.getElementById('cityInstitute').value = "-1";
            }
        }
        
        function toggleField() {
            var collegename =  document.getElementById('institute').value;
            var o = document.getElementById('other');
            if(collegename == 'other') {
                o.style.display = 'inline';
                // added by dipesh
                document.getElementById("other").value="";
                document.getElementById("instituteAddress").value="";
                document.getElementById("pincodeInstitute").value="";
                document.getElementById("instituteAddress").readOnly=false;
                document.getElementById("pincodeInstitute").readOnly=false;
                document.getElementById("headName").value="";
                document.getElementById("headEmail").value="";
                document.getElementById("headPhone").value="";
                document.getElementById("headAddress").value="";
                document.getElementById("headTitle").value="-1";
                document.getElementById("headDesignation").value="-1";
               
                document.getElementById("headName").readOnly=false;
                document.getElementById("headEmail").readOnly=false;
                document.getElementById("headPhone").readOnly=false;
                document.getElementById("headAddress").readOnly=false;
                document.getElementById("headTitle").disabled=false;
                document.getElementById("headDesignation").disabled=false;
                
            }else if(collegename == '-1'){
                document.getElementById("instituteAddress").value="";
                document.getElementById("pincodeInstitute").value="";
                document.getElementById("instituteAddress").readOnly=false;
                document.getElementById("pincodeInstitute").readOnly=false;
            } else {
                var streamId = document.getElementById("discipline").value;
                if(streamId == -1){
                    alert("please select Discipline");
                }else if(streamId != -1){
                    fetchInstituteHeadDetails(collegename,streamId);
                }
                o.style.display = 'none';
                fetchInstituteDetails(collegename); 
            }
        }
        
        function ChangeInstituteHead(streamid){
            var instituteid=document.getElementById("institute").value;
            if(instituteid != '-1' && streamid != '-1'){
                fetchInstituteHeadDetails(instituteid,streamid);
            }else{
            }
        }
        
        function setHtitleValue(val){
            document.getElementById("hidden_headtitle").value=val;
        }
        
        function setHdesginationValue(val){
            document.getElementById("hidden_headdesignation").value=val;
        }
        
        function changeState1(userid) {
            var stateID = document.getElementById('personState').value;
            if (stateID != -1) {
                // personCity(stateID);
                personCity1(stateID, userid); 
                // fetchCity1(stateID);
            } else {
                document.getElementById('stateInstitute').value = "-1";
            }
        }
        
        function setHyearofBirthvalue(val){
            document.getElementById("hidden_yearofbirth").value=val;
        }
        
        function changeCity1() {
            var cityID = document.getElementById('personCity').value;
            if (cityID == -2) {
                document.getElementById("hiddenCityFlag").value = 1;
                document.getElementById('otherPcity').style.display = "inline";
            } else if (cityID != -2) {
                document.getElementById("hiddenCityFlag").value = 0;
                document.getElementById('otherPcity').style.display = "none";
            }
        }
        
        function changeStateRC() {
            var stateID = document.getElementById('state').value;
            document.getElementById("stateID").value=stateID;          
            var categorycode=document.getElementById('categorycode').value;
            var workshopid=document.getElementById('workshopid').value;
            
            //reset already existing values
            document.getElementById("acco1").checked=false;
            document.getElementById("acco2").checked=false;
            document.getElementById("acco2").disabled=false;
            document.getElementById("acco1").disabled=false;
            
            if (stateID != -1) {     
                fetchRC(workshopid,stateID);
                document.getElementById("rcid").value="";
            }else {                
                resetWRForm_ExceptPermissionLetter();
            }
        }
        function openRCCapacity(){
            var state=document.getElementById('stateID').value;
            var workshopid_enc=document.getElementById('workshopid_enc').value;
            if(state == 0 || state == -1){
                alert("Please Select a State");
            }else{
                window.open("viewRCCapacity.html?workshopid="+workshopid_enc+"&state="+state+"&callFrom=1");
            }
        }
        function setRCID(){
            var rcid=document.getElementById('remotecenter').value;
            document.getElementById('rcid').value=rcid;
            var workshopid=document.getElementById('workshopid').value;
            var categorycode=document.getElementById('categorycode').value;
            
            //reset already existing values
            document.getElementById("acco1").checked=false;
            document.getElementById("acco2").checked=false;
            document.getElementById("acco2").disabled=false;
            document.getElementById("acco1").disabled=false;
            
            if(categorycode != 4 && categorycode != 6){
                fetchAccommodation(rcid,workshopid);}
        }
        
        function funPCE(){ 
            var password = document.getElementById("password").value.toLowerCase();
            var cpassword = document.getElementById("cpassword").value.toLowerCase();
            if (password == cpassword) {
                document.getElementById("cpassworderror").style.display = "none";
                document.getElementById("cpassword").style.border="";
            } else
            {
                document.getElementById("cpassword").style.border="1px solid red";
                document.getElementById("cpassworderror").style.display='inline';      
            }           
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('ul.sf-menu').sooperfish();
            $('.top').click(function() {
                $('html, body').animate({scrollTop: 0}, 'fast');
                return false;
            });
            $("#settingoptions").hide();
            $("#showmore").click(function() {
                $("#settingoptions").slideToggle();
            });
                
            $(document).bind('click', function(e) {
                $("#settingoptions").hide();
            });
        });
    </script>      
</head>

<body onload="checkZero()">  
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
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
            String part1 = "", part2 = "";  /*use in split function*/
            try {
                String string = page_content; /* storing content to variable string*/
                String[] parts = string.split("@name");
                part1 = parts[0]; // splited first string before contain @name
                part2 = parts[1]; // splited second string after contain @name
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <% if (!page_content.trim().equals("")) {%>
        <%=part1%><s:property value="person.firstName"/> <s:property value="person.lastName"/>
        <%=part2%>
        <%--<s:set var="content"><%= page_content%></s:set>
        <s:property escape="false" value="content"/>--%>

        <% } else {%>
        <h3>You are Already Registered!</h3>
        <div class="form_enclosure">
            <p><b>Dear <s:property value="person.firstName"/> <s:property value="person.lastName"/>,</b></p>
            <p style="color: green">You have registered for this workshop in this site.
            </p>
            <%--<p>Please check your status by clicking <a href="<s:property value="workshopContent.link_participantList"/>" target="_blank" style="color: black;"><b>Here.</b></a></p>--%>
            <p><b>Regards,<br/>The  Team</b></p>
        </div>
        <% }%>
    </s:if>
    <s:else>
        <s:iterator value="workshopContent">
            <s:if test="workshopExpiry == 1">
                <h3>Registration is closed</h3>
                <div class="form_enclosure">
                    <p><b>Dear <s:property value="person.firstName"/> <s:property value="person.lastName"/>,</b></p>
                    <p style="">The registration for this workshop is Closed.
                    </p>
                    <%--<p>Please check your status by clicking <a href="<s:property value="workshopContent.link_participantList"/>" target="_blank" style="color: black;"><b>Here.</b></a></p>--%>
                    <p><b>Regards,<br/>The  Team</b></p>
                </div>
            </s:if>
            <s:else>
                <s:if test="eventstatus == 'Registration will start soon'">
                    <h3>Registration will start soon</h3>
                    <div class="form_enclosure">
                        <p><b>Dear <s:property value="person.firstName"/> <s:property value="person.lastName"/>,</b></p>
                        <p style="">The registration for this workshop will start soon.
                        </p>
                        <%--<p>Please check your status by clicking <a href="<s:property value="workshopContent.link_participantList"/>" target="_blank" style="color: black;"><b>Here.</b></a></p>--%>
                        <p><b>Regards,<br/>The  Team</b></p>
                    </div>
                </s:if>
                <s:else>
                    <h3>Form for Enrollment to the Workshop</h3>
                    <div class="headmessage">Field marked with * are mandatory </div>
                    <div class="form_enclosure">        
                        <h1><s:property value="workshopname" /></h1>
                        <h4 align="center">National Mission on Education through ICT (MHRD, Govt. of India)</h4>
                        <br/>
                        <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>    
                    </div>
                    <div class="form_enclosure"> 
                        <form id="registrationForm" action="registerParticipantOnInvite.html"  method="post" enctype="multipart/form-data" onsubmit="return validateProfilePage1(this);">

                            <p style="display:none"><input type="hidden" id="categorycode" name="workshopContent.categorycode" value="<s:property value="categorycode"/>"></p>
                            <p style="display:none"><input type="hidden" id="workshopid" name="workshopContent.workshopid" value="<s:property value="workshopid"/>"></p>
                            <p style="display:none"><input type="hidden" id="workshopname" name="workshopContent.workshopname" value="<s:property value="workshopname"/>"></p>
                            <p style="display:none"><input type="hidden" id="accommodation" name="workshopContent.accommodation" value="<s:property value="accommodation"/>"></p>
                            <p style="display:none"><input type="hidden" id="permission_ifreq" name="workshopContent.permissionIfRequired" value="<s:property value="permissionIfRequired"/>"></p>
                            <p style="display: none"><input type="hidden" id="resCoWorkshopid" name="workshopContent.respectiveCoWorkshopid" value="<s:property value="respectiveCoWorkshopid"/>"></p>

                            <p style="display:none"><input type="hidden" id="isNewUser" name="isNewUser" value="${isNewUser}"/></p>
                            <p style="display:none"><input type="hidden" id="notInLogin" name="notInLogin" value="${notInLogin}"/></p>
                            <p style="display:none;"><input type="text" id="idContext" name="idContext" value="${if_id_exist_1}"/></p>

                            <div class="form_settings">    
                                <div class="form_box">
                                    <h2><s:property value="getText('registrationPage.loginDetails')"/></h2><br/>
                                    <p><span><s:property value="getText('registrationPage.email')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="email" name="person.email" value="${person.email}" maxlength="50" class="tipTip" title="<s:property value="getText('form.email')"/>" readonly/>
                                        <label id="emailError" class="errormsg"><s:property value="getText('registrationPage.emailerror')"/></label>
                                        <label class="errorLabel"><s:property value="fieldErrors.get('emailError').get(0)"/></label>
                                    </p><br/>  

                                    <s:if test="(isNewUser == 1) || (notInLogin == 1)">
                                        <p><span><s:property value="getText('registrationPage.password')"/> <sup><img src="images/star.png"></sup></span><input type="password" id="password" name="person.password" value="" maxlength="15" class="tipTip" title="<s:property value="getText('form.password')"/>"/>
                                            <label id="passwordError" class="errormsg"><s:property value="getText('registrationPage.passworderror')"/></label>
                                            <label class="errorLabel"><s:property value="fieldErrors.get('passwordError').get(0)"/></label>
                                        </p><br/>
                                        <p><span><s:property value="getText('registrationPage.cpassword')"/> <sup><img src="images/star.png"></sup></span><input id="cpassword" type="password" name="confirmPassword" value="" maxlength="15" onPaste='return false' class="tipTip" title="<s:property value="getText('form.cpassword')"/>" onblur="funPCE()"/>
                                            <label id="cpassworderror" class="errormsg"><s:property value="getText('registrationPage.cpasswordError')" /></label>
                                            <label class="errorLabel"><s:property value="fieldErrors.get('cpasswordError').get(0)"/></label>
                                        </p><br/>
                                    </s:if>

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
                                    <p><span><s:property value="getText('registrationPage.firstName')"/> <sup><img src="images/star.png"></sup></span><input type="text" id="firstName" name="person.firstName" maxlength="15" value="${person.firstName}" class="tipTip" title="<s:property value="getText('form.name')"/>" />
                                        <label id="firstNameError" class="errormsg"><s:property value="getText('registrationPage.fnameIsEmpty')" /></label>
                                        <label class="errorLabel"><s:property value="fieldErrors.get('firstNameError').get(0)"/></label>
                                    </p><br/>
                                    <p><span><s:property value="getText('registrationPage.lastName')"/> </span><input type="text" id="lastName" name="person.lastName" maxlength="15" value="${person.lastName}"  />
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
                                    <div style="text-align: center;">
                                        <%--<input type="text" name="h_photoPath" id="photoPath" value="${person.image}"/><br>--%>

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

                                        <span>Institute Photo ID Card [only jpg/jpeg file,max 250 kb]<sup><img src="images/star.png"></sup></span>
                                        <input type="file" id="photo"  name="PersonPhoto"/>
                                        <label id="photoError"  class="errormsg"><s:property value="getText('registrationPage.photoError')"/></label>

                                        <%--<label id="person_photo" class="errorLabel"><s:property value="fieldErrors.get('photoError').get(0)"/></label>--%>
                                        <label id="person_photo" class="errorLabel" style="color: black;display: inline;font-weight: bold">${person.image}</label> 
                                    </p><br>

                                </div>
                                        <input type="hidden" id="permissionletter_flag" value="<s:property value="permissionIfRequired"/>"/> 
                                <s:if test="%{(permissionIfRequired == 1) || (permissionIfRequired == 3)}">
                                    <div class="form_box">
                                        <h2><b>Permission Letter</b></h2><br/>
                                        <p>Please note that the scan copy of the Permission Letter should be less than 250 KB. Only jpeg/jpg format is accepted.
                                            If you have any problem in registration of your candidature please contact on 022-25764987.
                                            If you have any problem in uploading of Permission Letter then please email us at senderemail with subject as "Problem in Permission Letter upload"</p>
                                        <p>
                                            <span>Permission Letter <sup><img src="images/star.png"></sup></span>
                                            <input type="file" id="permissionLetter"  name="permissionLetter"/>
                                            <label id="permissionLetterError"  class="errormsg"><s:property value="getText('workshopRegistrationForm.permissionLetterError')"/></label>
                                            <label class="errorLabel"><s:property value="fieldErrors.get('permissionLetterError').get(0)"/></label>
                                        </p>
                                    </div>
                                </s:if>
                                <s:else>
                                    <input type="hidden"  id="permissionLetter"  name="permissionLetter"/>
                                    <label style="display: none;"id="permissionLetterError"  class="errormsg"></label>
                                </s:else>
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
                                                <select id="state" name="state" onchange="changeStateRC();">
                                                    <option value="-1">--Select State--</option>
                                                    <s:iterator value="stateList" >
                                                        <s:if test='%{stateId == rcid.rc_state}'>
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
                                                <p><a onclick="openRCCapacity();" style="cursor: pointer;">Please Click Here to Check the Availability</a></p><br>
                                            </s:if>                                
                                            <p>
                                                <span>Select Remote Center <sup><img src="images/star.png"></sup></span>
                                                <select id="remotecenter"  onchange="setRCID();">                                                                                       
                                                    <option value="-1">--Select a Remote Center--</option>
                                                    <s:iterator value="rc_static" >    
                                                        <s:if test='%{remoteCenterId == rcid.remoteCenterId}'>  
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
                                            <select id="state" name="state" onchange="changeStateRC();">                                       
                                                <option value="-1">--Select State--</option>
                                                <s:iterator value="stateList" >
                                                    <s:if test='%{stateId == rcid.rc_state}'>
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
                                            <p><a onclick="openRCCapacity();" style="cursor: pointer;">Please Click Here to Check the Availability</a></p><br>
                                        </s:if>                                
                                        <p>
                                            <span>Select Remote Center <sup><img src="images/star.png"></sup></span>
                                            <select id="remotecenter"  onchange="setRCID();">
                                                <option value="-1">--Select a Remote Center--</option>   
                                                <s:iterator value="rc_static" >    
                                                    <s:if test='%{remoteCenterId == rcid.remoteCenterId}'>  
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
                                            <input type="text" id="rcid" name="participant.rcid" value="${rcid.remoteCenterId}" class="tipTip" readonly title="<s:property value="getText('form.rcid')"/>"/>                        
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
                                    <h2><s:property value="getText('registrationPage.instituteDetails')"/></h2><br/>
                                    <p><span><s:property value="getText('registrationPage.instituteState')"/> <sup><img src="images/star.png"></sup></span>
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
                                    </p><br/>

                                    <p><span><s:property value="getText('registrationPage.instituteCity')"/> <sup><img src="images/star.png"></sup></span>
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
                                    </p><br/>

                                    <p><span><s:property value="getText('registrationPage.institute')"/> <sup><img src="images/star.png"></sup></span>
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
                                <div class="form_box"> 
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
                                <ol>
                                    <li>All information provided by me is correct and to the best of my knowledge</li>
                                    <li>In case my bonafide is later detected to be wrong, I understand that I will
                                        not be given certificate of participation, or if given, the same will be withdrawn.
                                        In such case, I accept that I will be liable to refund the expenditure incurred on me for participating in this workshop </li>
                                </ol>
                                <p><input style="position: relative;left:70px;" class="submit" type="submit" name="submit" value="Submit" />
                                    <!--<input style="position: relative; right:75px"  class="submit" type="reset" name="reset" value="Reset" onclick="resetProfileForm();"/></p>--> 
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
                    </div>
                    <!--</div>-->
                </s:else>
            </s:else>
        </s:iterator>
    </s:else>
</body>
