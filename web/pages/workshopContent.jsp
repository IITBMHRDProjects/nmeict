<%-- 
    Document   : workshopContent
    Created on : 5 Aug, 2014, 5:22:29 PM
    Author     : Abinaya
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>   
<div class="form_enclosure">
    <s:iterator value="workshopContent">
        <h1><s:property value="workshopname" /></h1>
        <h4 align="center"> <s:property value="sponsor"/></h4>
        <br/>
        <s:if test="dateToBeDisplayed == 1">
            <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>    
        </s:if><s:else></s:else>
            <div class="form_settings">

                <table class="content_container">
                    <tr><td align="center"><a style="" href="workshopContent.html?workshopid=<s:property value="workshopid_encrypted"/>#content">Course Content</a> </td>
                    <td align="center"><a style="" href="workshopContent.html?workshopid=<s:property value="workshopid_encrypted"/>#teachingFaculty">Teaching Faculty</a></td>
                    <td align="center" ><a style="" href='workshopContent.html?workshopid=<s:property value="workshopid_encrypted"/>#whoToAttend'>Who Should Attend</a></td>
                </tr>
                <tr>     
                    <td align="center"><a style="" href="workshopContent.html?workshopid=<s:property value="workshopid_encrypted"/>#durationAndVenue">Duration and Venue</a></td>
                    <td align="center"><a style="" href='workshopContent.html?workshopid=<s:property value="workshopid_encrypted"/>#certificateCriteria'>Criteria for Certification</a></td>
                    <td align="center"><a style="" href='workshopContent.html?workshopid=<s:property value="workshopid_encrypted"/>#courseFee'>Course Fee</a></td>
                </tr>
                <tr>
                    <td align="center"><a style="" href='workshopContent.html?workshopid=<s:property value="workshopid_encrypted"/>#howToApply'>How to Apply</a></td>
                    <td align="center"><a style="" href='workshopContent.html?workshopid=<s:property value="workshopid_encrypted"/>#accommodation'>Accommodation</a></td>
                    <td align="center"><a style="" href='workshopContent.html?workshopid=<s:property value="workshopid_encrypted"/>#note'>Note</a></td>
                </tr>                
                <tr>
                    <td align="center" colspan="3"><a style="" href='workshopContent.html?workshopid=<s:property value="workshopid_encrypted"/>#addressForCommunication'>Address For Communication </a></td>

                </tr>
            </table>

            <table class="content_container">
                <s:if test="%{permissionIfRequired == 1}">
                    <tr><td><p>click <a style="" href="<s:property value="permissionLetter"/>">here</a> to download the permission letter format</p></td></tr>
                </s:if>
                <tr><td><p>click <a style="" href="<s:property value="brochurepath"/>">here</a> to download the brochure</p></td></tr>
                <tr><td><p><b><a href="contactus.html" target="_blank" style="color:black;">Help-line Contacts</a></b></p></td></tr>
                <tr><td><p><b><a name="instructions" href="instructions.html?workshopid=<s:property value="workshopid_encrypted"/>" target="_blank" style="color:black;">Instructions for Enrolling in the workshop</a></b>
                            <s:if test="%{categorycode == 5 || categorycode == 7 || (categorycode == 8 && without_RC == 0)}">
                                <a target="_blank" style="float:right; color: black;font-weight: bold;" href="coordinatorList.html?workshopid=<s:property value="workshopid_encrypted"/>&callFrom=1">Participating Remote Centers</a>
                        </s:if></td></tr>
            </table>


            <s:if test='%{ifWSC > 0 || ifRCC > 0 || ifRCC1 > 0 || #session.loggedInUser.roleId == 5 || #session.loggedInUser.roleId == 3 || #session.loggedInUser.roleId == 6 || #session.loggedInUser.roleId == 2}'>
                <p> <b style="color:red;font-weight: normal;">You cannot register for this workshop as a participant</b> 
                    <img style="float:right;" src="images/triangle_animated.gif"><a href="<s:property value="link_participantList"/>&callFrom=1" target="_blank" style="float: right;color:black">List of participants</a></b><img style="float: right" src="images/triangle_animated.gif">
                </p>
            </s:if><s:else>
                <s:if test="%{categorycode != 8 && facultyStatus == 0 && #session.loggedInUser != null}">
                    <p style="color: #FF4500;"> You cannot register for this workshop as a participant.<br/>This workshop is only for users who are employed as a faculty in any educational institution. <br/>
                        <br/>  <img style="float:right;" src="images/triangle_animated.gif"><a href="<s:property value="link_participantList"/>&callFrom=1" target="_blank" style="float: right;color:black">List of participants</a></b><img style="float: right" src="images/triangle_animated.gif">
                    </p>
                </s:if><s:else>
                    <table class="content_container">
                        <tr><td><p><b><img style="float: left" src="images/triangle_animated.gif">
                                        <s:if test="participant.isAlreadyRegistered == 1"><p style="float:left;color:black;">You are Already Registered</p></s:if>
                                        <s:else>
                                            <a href="<s:property value="link"/>" style="float:left;color:black;"><s:property value="eventstatus"/></a></s:else>
                                            <img style="float:right;" src="images/triangle_animated.gif">
                                            <img style="float:left" src="images/triangle_animated.gif"><a href="<s:property value="link_participantList"/>&callFrom=1" target="_blank" style="float: right;color:black">List of participants</a></b><img style="float: right" src="images/triangle_animated.gif">
                                </p></td></tr>
                    </table>
                    <s:if test="%{ categorycode == 5 || (categorycode == 4 && respectiveCoWorkshopid == 0) || categorycode == 7 || categorycode == 8}">           
                        <s:if test="participant.isAlreadyRegistered == 1 && participant.isNotValidForUpdate == 0 && workshopExpiry == 0">  
                            <table class="content_container">
                                <tr>
                                    <td>
                                        <p><img style="float: left" src="images/triangle_animated.gif">
                                        <p style="float:left;color:black;"><a href="<s:property value="link_updateRegistration"/>" target="_blank" style="float: right;color:black"><b>Update Your Registration Here</b></a></p>
                                        <img style="" src="images/triangle_animated.gif"></p>
                                    </td>
                                </tr>
                            </table>
                        </s:if> 
                        <s:if test="participant.isAlreadyRegistered == 1 && participant.status =='Registration Invalid' && participant.isNotValidForUpdate == 0 && lessThanStartDate == 0 && workshopExpiry == 1">  
                            <table class="content_container">
                                <tr>
                                    <td>
                                        <p><img style="float: left" src="images/triangle_animated.gif">
                                        <p style="float:left;color:black;"><a href="<s:property value="link_updateRegistration"/>" target="_blank" style="float: right;color:black"><b>Update Your Registration Here</b></a></p>
                                        <img style="" src="images/triangle_animated.gif"></p>
                                    </td>
                                </tr>
                            </table>
                        </s:if> 
                    </s:if>
                </s:else>   
            </s:else>    
            <div class="form_box"><h2><a class="h2_a" name="introduction">Introduction</a></h2>
                <p>
                    <s:property escape="false" value="introduction"/>
                </p></div>
            <div class="form_box"><h2><a class="h2_a" name="content">Course content</a></h2>
                <p>
                    <s:property escape="false" value="objectives"/>
                </p></div>
            <div class="form_box"><h2><a class="h2_a" name="teachingFaculty">Teaching Faculty</a></h2>
                <p>
                    <s:property escape="false" value="teachingfaculty"/>
                </p></div>
            <div class="form_box"><h2><a class="h2_a" name='whoToAttend'>Who Should Attend</a></h2>
                <p>
                    <s:property escape="false" value="whoshouldattend"/>
                </p></div>
            <div class="form_box"><h2><a class="h2_a" name="durationAndVenue">Duration and Venue</a> </h2>
                <p>
                    <s:property escape="false" value="durationvenue"/>
                </p></div>
            <div class="form_box"><h2><a class="h2_a" name="certificateCriteria">Criteria for Certification</a> </h2>
                <p>
                    <s:property escape="false" value="certificateCriteria"/>
                </p></div>
            <div class="form_box"><h2><a class="h2_a" name='courseFee'>Course Fee</a></h2>
                <p>
                    <s:property escape="false" value="coursefee"/>
                </p></div>
            <div class="form_box"><h2><a class="h2_a" name='howToApply'>How to Apply</a></h2>
                <p>
                    <s:property  escape="false" value="howtoapply"/>
                </p></div>
            <div class="form_box"><h2><a class="h2_a" name='accommodation'>Accommodation</a></h2>
                <p>
                    <s:property escape="false" value="accomodation"/>
                </p></div>
            <div class="form_box"><h2><a class="h2_a" name='note'>Note</a></h2>
                <p>
                    <s:property escape="false" value="note"/>
                </p></div>
            <div class="form_box"><h2><a class="h2_a" name='addressForCommunication'>Address For Communication</a></h2>
                <p>
                    <s:property escape="false" value="contact"/>
                </p></div>        
        </div>
    </s:iterator>
</div>
