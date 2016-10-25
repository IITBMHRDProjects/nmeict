<%-- 
    Document   : survey
    Created on : 2 Jan, 2015, 3:16:59 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<body> 
    <%
        String actionerror = "";
        try {
            actionerror = (String) session.getAttribute("ActionError");
            session.removeAttribute("ActionError");
        } catch (Exception e) {
            actionerror = "false";
            e.printStackTrace();
        }
        if (actionerror == "false" || actionerror == null) {
        } else {
    %>

    <div class="msg msg-error">
        <p style="color: red; font-size: 15px">You are already Filled the Survey Form.</p>
        <a href="javascript:void(0);" class="close">close</a>
    </div>
    <% }%>
    <%
        String rc_result = "";
        try {
            rc_result = (String) session.getAttribute("rc_exist1");
            session.removeAttribute("rc_exist1");
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <% if (rc_result.equals("yes")) { %>
    <h3>Already Fill the Survey Details</h3>
    <div class="form_enclosure">
        <p>Your Institute has already submitted  the response form  for the Blended MOOCs from IIT Bombay .</p>
    </div>
    <% } else if (rc_result.equals("no")) { %>
    <h3>Form for Enrollment to the Workshop</h3>
    <div class="headmessage">Field marked with * are mandatory </div>
    <div class="form_enclosure"> 
        <h1 align="center">Response for the proposed engagement in the Blended MOOCs from IIT Bombay</h1>
        <form action="dosurvey.html"  method="post" enctype="multipart/form-data" onsubmit="return validateServey1()">
            <div class="form_settings">
                <div class="form_box">
                    <h2>[For Remote Centres of  project, which are autonomous Institutes/ Deemed Universities, and which agree to use the model for one or more of the courses being offered in the coming academic year]</h2><br/>
                    <p><span>State <sup><img src="images/star.png"></sup></span><input type="text" id="state" name="" value="${person.institute.state.stateName}" maxlength="50" class="tipTip" title="" readonly=""/>
                        <label id="stateError" class="errormsg"><s:property value="getText('registrationPage.emailerror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('emailError').get(0)"/></label>
                    </p><br/>
                    <br/> 
                    <p><span>Remote Center <sup><img src="images/star.png"></sup></span><input type="text" id="rcname" name="" value="${person.institute.instituteName}" maxlength="50" class="tipTip" title="" readonly=""/>
                        <label id="rcError" class="errormsg"><s:property value="getText('registrationPage.emailerror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('emailError').get(0)"/></label>
                    </p><br/>
                    <br/> 
                    <p><span>Remote Center Id <sup><img src="images/star.png"></sup></span><input type="text" id="rcid" name="rcid" value="${person.institute.instituteId}" maxlength="50" class="tipTip" title="" readonly=""/>
                        <label id="rcidError" class="errormsg"><s:property value="getText('registrationPage.emailerror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('emailError').get(0)"/></label>
                    </p><br/>
                    <br/>  

                    <p>
                        Would you like to participate in this Blended MOOC offering ? &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.YesNofield" id="radioY" value="yes" onclick="displayQustion(this.value);"> Yes
                        &nbsp;&nbsp;&nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.YesNofield" id="radioN" value="no" onclick="displayQustion(this.value);"> No
                        <label id="yesnoError" style="color: red;"></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesnoError').get(0)"/></label>
                    </p>


                    <%--
                    <div class="">
                        <P>ques.1 : Test MCQ Question<br>
                            <input style=" width: 13px;height: 13px; padding:0 0 0 0; margin-left: 20px;" type="radio" id="checkbox1" name="surveyform.field1" value="A"> A &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="checkbox2" name="surveyform.field1" value="B"> B &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <br><input style=" width: 13px;height: 13px; padding:0 0 0 0; margin-left: 20px; " type="radio" id="checkbox3" name="surveyform.field1" value="C"> C &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="checkbox4" name="surveyform.field1" value="D"> D &nbsp;
                            <label id="checkboxError" style="color: red;"></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('checkboxError').get(0)"/></label>
                        </P>
                    </div><br>
                    <div>
                        <P>ques.1 : Test select Question
                            &nbsp;&nbsp; <select  id="select1" name="surveyform.field2">
                                <option value="-1">Select Option</option>
                                <option value="Volvo">Volvo</option>
                                <option value="Saab">Saab</option>
                                <option value="Mercedes">Mercedes</option>
                                <option value="Audi">Audi</option>
                                <option value="abc">abc</option>
                                <option value="pqr">pqr</option>
                                <option value="xyz">xyz</option>
                                <option value="mno">mno</option>
                                <option value="pje">pje</option>
                                <option value="asd">asd</option>
                            </select>
                            <label id="selectError" style="color: red;"></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('selectError').get(0)"/></label>
                        </p>
                    </div><br>
                    <div>
                        <p>ques.1 : Test textbox Question
                            <input type="text" name="surveyform.field3" style="margin-left: 205px;" id="textbox1" value=""/>
                            <label id="txtboxError" style="color: red;"></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('txtboxError').get(0)"/></label>
                        </p>
                    </div><br><br>
                    <div>
                        <p>
                            ques.1 : Test Yes/No Question&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.field4" id="radioY" value="yes" onclick="displayQustion(this.value);"> Yes
                            &nbsp;&nbsp;&nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.field4" id="radioN" value="no" onclick="displayQustion(this.value);"> No
                            <label id="yesnoError" style="color: red;"></label>
                            <label class="errorLabel"><s:property value="fieldErrors.get('yesnoError').get(0)"/></label>
                        </p>
                    </div><br>
                    <div id="newQustion" style="display: none">
                        <P>ques.5 : Test MCQ Question<br>
                            <input style=" width: 13px;height: 13px; padding:0 0 0 0; margin-left: 20px;" type="radio" id="qust5_ans1" name="surveyform.field5" value="1"> A &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="qust5_ans2" name="surveyform.field5" value="2"> B &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <br><input style=" width: 13px;height: 13px; padding:0 0 0 0; margin-left: 20px; " type="radio" id="qust5_ans3" name="surveyform.field5" value="3"> C &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" id="qust5_ans4" name="surveyform.field5" value="4"> D &nbsp;
                            <label id="question5Error" style="color: red;"></label>

                        </P>
                    </div><br>
                    <p><span> Comments <sup></sup></span><textarea rows="5" cols="50" id="comments" name="surveyform.comments" maxlength="150" class="tipTip" title="<s:property value="getText('form.address')"/>"></textarea>
                        <label id="comtentsError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('comtentsError').get(0)"/></label>
                    </p><br/>
                        <br/><br/>
                    --%>

                    <%--<input style="position: relative;right: 50px"  class="submit" type="submit" value="Submit"/>
                    <input style="position: relative;right: 75px"  class="submit" type="button" value="Reset" onclick="validateServey()"/><br>--%>

                </div>
                <div class="form_box" id="askedYesPart" style="display: none; padding: 10px;">
                    <p><b></b></p>
                    <p>

                    </p><br>
                    <p>
                        1. Information about our semester schedules [Please include duration from beginning of the classes, till end of all examinations].<br>
                    </p> 
                    <p style="padding: 10px;">
                        Year 1, Semester 1<br>
                        Begins : 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_1" id="radioY" value="A" onclick=""> June 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_1" id="radioY" value="B" onclick="">July 
                        &nbsp;&nbsp<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_1" id="radioY" value="C" onclick="">August 
                        &nbsp;&nbsp<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_1" id="radioY" value="D" onclick="">Other
                        <label id="yesPart1_1Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart1_1Error').get(0)"/></label>
                        <br>
                        Ends    : 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_2" id="radioY" value="A" onclick=""> November 
                        &nbsp;&nbsp<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_2" id="radioY" value="B" onclick=""> December 
                        &nbsp;&nbsp<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_2" id="radioY" value="C" onclick=""> January 
                        &nbsp;&nbsp<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_2" id="radioY" value="D" onclick=""> Other
                        <label id="yesPart1_2Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart1_2Error').get(0)"/></label>
                        <br><br>
                        Year 1, Semester 2<br>
                        Begins : 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_3" id="radioY" value="A" onclick=""> January 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_3" id="radioY" value="B" onclick=""> February 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_3" id="radioY" value="C" onclick=""> Other<br>
                        <label id="yesPart1_3Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart1_3Error').get(0)"/></label>
                        <br>Ends    : 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_4" id="radioY" value="A" onclick=""> April 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_4" id="radioY" value="B" onclick=""> May 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_4" id="radioY" value="C" onclick=""> June 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_4" id="radioY" value="D" onclick=""> Other
                        <label id="yesPart1_4Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart1_4Error').get(0)"/></label>
                        <br><br>
                        Subsequent years, Semester 1<br>
                        Begins : 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_5" id="radioY" value="A" onclick=""> June 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_5" id="radioY" value="B" onclick=""> July 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_5" id="radioY" value="C" onclick=""> August
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_5" id="radioY" value="D" onclick=""> Other<br>
                        <label id="yesPart1_5Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart1_5Error').get(0)"/></label>
                        <br>Ends    : 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_6" id="radioY" value="A" onclick=""> November 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_6" id="radioY" value="B" onclick=""> December 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_6" id="radioY" value="C" onclick=""> January 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_6" id="radioY" value="D" onclick=""> Other
                        <label id="yesPart1_6Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart1_6Error').get(0)"/></label>
                        <br><br>
                        Subsequent years, Semester 2<br>
                        Begins : 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_7" id="radioY" value="A" onclick=""> January 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_7" id="radioY" value="B" onclick=""> February 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_7" id="radioY" value="C" onclick=""> Other
                        <label id="yesPart1_7Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart1_7Error').get(0)"/></label>
                        <br>Ends    : 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_8" id="radioY" value="A" onclick=""> April 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_8" id="radioY" value="B" onclick=""> May 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_8" id="radioY" value="C" onclick=""> June 
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ1_8" id="radioY" value="D" onclick=""> Other
                        <label id="yesPart1_8Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart1_8Error').get(0)"/></label>
                    </p><br>
                    <p>
                        2. For each of the three subjects, for which the blended MOOCs are currently offered, kindly provide information related to corresponding offerings in your Institute. This includes information about when the subjects are taught, number of students taking the subject in a semester, numbers of teachers involved in teaching that subject, and the estimated overlap between the topics covered in MOOCs and the topic covered in your institute.
                    </p>
                    <p style="padding: 10px;">
                        <b>Introduction to Programming.</b><br>
                        (a) Semester in which the subject is taught<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_1" id="radioY" value="A" onclick=""> Sem I 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_1" id="radioY" value="B" onclick=""> Sem II 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_1" id="radioY" value="C" onclick=""> both semesters 
                        <label id="yesPart2_1_1Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_1_1Error').get(0)"/></label>
                        <br>
                        (b) Total number of students learning that subject in one or more semester (If it is offered in both semesters, please indicate the larger number)<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_2" id="radioY" value="A" onclick=""> 50 to 100 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_2" id="radioY" value="B" onclick=""> 100 to 300 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_2" id="radioY" value="C" onclick=""> 300 to 500 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_2" id="radioY" value="D" onclick=""> more than 500
                        <label id="yesPart2_1_2Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_1_2Error').get(0)"/></label>
                        <br>
                        (c) Number of teachers involved in independently teaching the subject to one or  more batches<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_3" id="radioY" value="A" onclick=""> one 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_3" id="radioY" value="B" onclick=""> two to five 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_3" id="radioY" value="C" onclick=""> more than five 
                        <label id="yesPart2_1_3Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_1_3Error').get(0)"/></label>
                        <br>
                        (d) Estimated overlap between the topics covered in MOOC offering from IIT Bombay, and the topics covered in your institute<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_4" id="radioY" value="A" onclick=""> less than 25% 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_4" id="radioY" value="B" onclick=""> 25% to 50% 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_4" id="radioY" value="C" onclick=""> 50% to 75% 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_1_4" id="radioY" value="D" onclick=""> 75% to 100%
                        <label id="yesPart2_1_4Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_1_4Error').get(0)"/></label>
                        <br><br>
                        <b>Thermodynamics.</b><br>
                        (a) Semester in which the subject is taught<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_1" id="radioY" value="A" onclick=""> Sem I 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_1" id="radioY" value="B" onclick=""> Sem II 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_1" id="radioY" value="C" onclick=""> both semesters 
                        <label id="yesPart2_2_1Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_2_1Error').get(0)"/></label>
                        <br>
                        (b) Total number of students learning that subject in one or more semester (If it is offered in both semesters, please indicate the larger number)<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_2" id="radioY" value="A" onclick=""> 50 to 100 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_2" id="radioY" value="B" onclick=""> 100 to 300 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_2" id="radioY" value="C" onclick=""> 300 to 500 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_2" id="radioY" value="D" onclick=""> more than 500
                        <label id="yesPart2_2_2Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_2_2Error').get(0)"/></label>
                        <br>
                        (c) Number of teachers involved in independently teaching the subject to one or  more batches<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_3" id="radioY" value="A" onclick=""> one 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_3" id="radioY" value="B" onclick=""> two to five 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_3" id="radioY" value="C" onclick=""> more than five 
                        <label id="yesPart2_2_3Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_2_3Error').get(0)"/></label>
                        <br>
                        (d) Estimated overlap between the topics covered in MOOC offering from IIT Bombay, and the topics covered in your institute<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_4" id="radioY" value="A" onclick=""> less than 25% 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_4" id="radioY" value="B" onclick=""> 25% to 50% 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_4" id="radioY" value="C" onclick=""> 50% to 75% 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_2_4" id="radioY" value="D" onclick=""> 75% to 100%
                        <label id="yesPart2_2_4Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_2_4Error').get(0)"/></label>
                        <br><br>
                        <b>Signals and Systems.</b><br>
                        (a) Semester in which the subject is taught<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_1" id="radioY" value="A" onclick=""> Sem I 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_1" id="radioY" value="B" onclick=""> Sem II 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_1" id="radioY" value="C" onclick=""> both semesters 
                        <label id="yesPart2_3_1Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_3_1Error').get(0)"/></label>
                        <br>
                        (b) Total number of students learning that subject in one or more semester (If it is offered in both semesters, please indicate the larger number)<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_2" id="radioY" value="A" onclick=""> 50 to 100 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_2" id="radioY" value="B" onclick=""> 100 to 300 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_2" id="radioY" value="C" onclick=""> 300 to 500 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_2" id="radioY" value="D" onclick=""> more than 500
                        <label id="yesPart2_3_2Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_3_2Error').get(0)"/></label>
                        <br>
                        (c) Number of teachers involved in independently teaching the subject to one or  more batches<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_3" id="radioY" value="A" onclick=""> one 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_3" id="radioY" value="B" onclick=""> two to five 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_3" id="radioY" value="C" onclick=""> more than five 
                        <label id="yesPart2_3_3Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_3_3Error').get(0)"/></label>
                        <br>
                        (d) Estimated overlap between the topics covered in MOOC offering from IIT Bombay, and the topics covered in your institute<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_4" id="radioY" value="A" onclick=""> less than 25% 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_4" id="radioY" value="B" onclick=""> 25% to 50% 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_4" id="radioY" value="C" onclick=""> 50% to 75% 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ2_3_4" id="radioY" value="D" onclick=""> 75% to 100%
                        <label id="yesPart2_3_4Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPart2_3_4Error').get(0)"/></label>  
                        <br><br>
                    </p><br>
                    <p>
                        3. Tentatively, in our final grade/marks, we propose to assign following weight to the online  examination(s) of MOOCs offering. This is subject to internal approvals
                    </p>
                    <p style="padding: 5px;">
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ3" id="radioY" value="A" onclick=""> less than 20%
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ3" id="radioY" value="B" onclick=""> 20% to 40% 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ3" id="radioY" value="C" onclick=""> 40% to 60%
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ3" id="radioY" value="D" onclick=""> 60% to 80%
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ3" id="radioY" value="E" onclick=""> greater than 80%<br>
                        <label id="yesPartQ3Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPartQ3Error').get(0)"/></label>
                    </p><br><br>
                    <p>
                        4. It is proposed that for the benefit of teachers teaching the chosen subjects in your Institute, a  workshop will be conducted spanning the entire duration of four or more months. Fortnightly interactive sessions will be conducted by IIT faculty with the faculty from participating institution teaching that subject. Students studying these subjects may be permitted to participate in these interactive sessions. It is expected that each Institute will provide A-VIEW facility for use at scheduled hours. Please comment on the Participation of your teachers and students of the chosen subjects, in the proposed  workshops.
                    </p>
                    <p style="padding: 5px;">
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ4" id="radioY" value="A" onclick=""> Only our teachers will participate in these workshop sessions<br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ4" id="radioY" value="B" onclick=""> We wish to permit our students to participate in all sessions <br>
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ4" id="radioY" value="C" onclick=""> We wish to permit our students to participate in some selected sessions
                        <br><label id="yesPartQ4Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPartQ4Error').get(0)"/></label>
                    </p><br><br>
                    <p>
                        5. After due deliberations and clarifications in the proposal in the proposed meeting on June 6, we will be able to obtain the necessary clearance for the scheme from our concerned academic bodies in the following time frame
                    </p>
                    <p style="padding: 5px;">
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ5" id="radioY" value="A" onclick=""> June 2015
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ5" id="radioY" value="B" onclick=""> July 2015 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ5" id="radioY" value="C" onclick=""> It may take longer, we can participate only from II Semester 
                        <br><label id="yesPartQ5Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPartQ5Error').get(0)"/></label>
                    </p><br>

                    <p>
                        6. What is the internet bandwidth available of your institution?
                    </p>
                    <p style="padding: 5px;">
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ7" id="radioY" value="A" onclick="">  Less than 1 Mbps
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ7" id="radioY" value="B" onclick=""> 4 Mbps 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ7" id="radioY" value="C" onclick=""> More than 4 Mbps 
                        <br><label id="yesPartQ7Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPartQ7Error').get(0)"/></label>
                    </p><br><br>


                    <p>
                        7. In case your institute decides to supervise some of the MOOCs Online
                        assessments, can this bandwidth be made available exclusively to those
                        participating students during the assessment hours?
                    </p>
                    <p style="padding: 5px;">
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ8" id="radioY" value="A" onclick="">  Yes
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ8" id="radioY" value="B" onclick=""> No 
                        <br><label id="yesPartQ8Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPartQ8Error').get(0)"/></label>
                    </p><br><br>


                    <p>
                        8. How many computers, connected to the internet, can be made available
                        at a time, in one or more labs , for such supervised online
                        examinations ?
                    </p>
                    <p style="padding: 5px;">
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ9" id="radioY" value="A" onclick="">  Less than 100
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ9" id="radioY" value="B" onclick=""> 100-200 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ9" id="radioY" value="C" onclick=""> 200-500
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.yesPartQ9" id="radioY" value="D" onclick=""> More than 500 
                        <br><label id="yesPartQ9Error" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('yesPartQ9Error').get(0)"/></label>
                    </p><br><br>

                    <p>
                        9. Name and email-id of the representative who will attend the meeting at IIT Bombay on 6th June 2015. Kindly note that (a) either the head of the institution, or an empowered senior academic faculty (e.g. Dean) should be nominated to facilitate concrete decision making.
                    </p>
                    <p>
                    <p><span>Email <sup><img src="images/star.png"></sup></span><input type="text" id="email" name="surveyform.email" value="" maxlength="50" class="tipTip" title="<s:property value="getText('form.email')"/>"/>
                        <label id="emailError" class="errormsg"><s:property value="getText('registrationPage.emailerror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('emailError').get(0)"/></label>
                    </p><br/>
                    <p><span>Name <sup><img src="images/star.png"></sup></span><input type="text" id="pname" name="surveyform.name" value="" maxlength="50" class="tipTip" title="<s:property value="getText('form.email')"/>"/>
                        <label id="nameError" class="errormsg">Please enter proper Name</label>
                        <label class="nameLabel"><s:property value="fieldErrors.get('emailError').get(0)"/></label>
                    </p><br>
                     <p>
                         <span>Designation </span><input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.designation" id="radioY" value="Head of Institution" onclick="">  Head of Institution
                         &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.designation" id="radioY" value="Deputy Director or Equivalent" onclick=""> Deputy Director or Equivalent<br>   
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.designation" id="radioY" value="Dean or Equivalent" onclick=""> Dean or Equivalent 
                        &nbsp;&nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.designation" id="radioY" value="other" onclick=""> other 
                        <br><label id="designationError" style="color: red; display: none;">Please Select Any Option</label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('designationError').get(0)"/></label>
                    </p><br>
                    Kindly note that we will be able to reimburse only economy class air travel (preferably by Air India, as per GFR), and provide local hospitality.
                    <br/>
                    </p>
                </div> 
                <div class="form_box" id="askedNoPart" style="display: none; padding: 10px;">
                    In case your Institute is not able to participate in this blended MOOCs program, kindly select the most appropriate clause from the following, as applicable :<br><br> 
                    &nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.noPartQ1" id="sf_nopart1" value="A" onclick="removePDF()"> We believe that regular teaching cannot be supplemented by online learning.<br><br>
                    &nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.noPartQ1" id="sf_nopart2" value="B" onclick="removePDF()"> Online learning may be a useful complement, but we are unable to alter our marking scheme to factor MOOC marks in our evaluation.<br><br>
                    &nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.noPartQ1" id="sf_nopart3" value="C" onclick="removePDF()"> Online learning is useful and we have the autonomy to accommodate MOOC marks in our evaluation. However, we are not yet geared up to embrace this approach.<br><br>
                    &nbsp;<input style=" width: 13px;height: 13px; padding:0 0 0 0; " type="radio" name="surveyform.noPartQ1" id="sf_nopart4" value="D" onclick="displayPDF()"> We have enclosed a pdf document outlining reasons for our inability to join the blended MOOCs model at this juncture.<br>
                    <label id="noPartError" style="color: red; display: none;">Please Select Any Option</label>
                    <label class="errorLabel"><s:property value="fieldErrors.get('noPartError').get(0)"/></label><br><br>
                    <br>
                    <p id="browsepdf" style="display: none;">
                        <span>Upload pdf here</span>
                        <input type="file" id="surveypdf"  name="surveyPdf"/>
                        <label id="surveypdfError"  class="errormsg">Please Upload Valid pdf</label> 
                    </p><br>
                </div><br>
                <div class="form_box" style="padding: 10px;">
                    <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" /><input style="position: relative; right:75px"  class="submit" type="reset" name="reset" value="Reset" onclick="resetWRForm();"/></p>
                </div>
                <input type="hidden" name="surveyform.workshopid" id="workshopid" value="<s:property value="workshopid"/>"/>
            </div> 

        </form>         
    </div>
    <% }%>
</body>



