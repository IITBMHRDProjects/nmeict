<%-- 
    Document   : Capacity
    Created on : 29 Sep, 2014, 3:41:13 PM
    Author     : asl
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
    SimpleStringCipher cipher = new SimpleStringCipher();
    String rcid, workshopid, avaseats, avaccom;
    String rcid_enc = request.getParameter("rcid");
    String workshopid_enc = request.getParameter("workshopid");
    workshopid = cipher.decrypt(workshopid_enc);
    rcid = cipher.decrypt(rcid_enc);
    avaseats = request.getParameter("avseats");
    avaccom = request.getParameter("avaccomo");
    String acco_cost = "", food_cost = "";
    if (rcid.equals(null)) {
        rcid = "";
    }
    if (workshopid.equals(null)) {
        workshopid = "";
    }
    if (avaseats.equals(null)) {
        avaseats = "";
    }
    if (avaccom.equals(null)) {
        avaseats = "";
    }
%>
<!DOCTYPE html>    
<s:if test='%{#session.loggedInUser.roleId == 5}'>
    <%
        acco_cost = request.getParameter("acco_cost");
        food_cost = request.getParameter("food_cost");
    %>
</s:if>
<body><noscript><font color="black">Please Enable Your Browser Javascript for Better Functionality.</font><br/><br/></noscript>
    <div><div style="width:750px;"><h3>Update Remote Center Capacity Details.</h3></div>
        <div class="form_enclosure">
            <div class="form_settings">
                <div class="form_box">
                    <form action="doUpdateRCCapacity.html" method="post" onsubmit="return validateRCCDetails()">
                        <s:iterator value="wc">
                            <h1><s:property value="workshopname" /></h1>
                            <h4 align="center"><s:property value="sponsor"/></h4>
                            <br/>
                            <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   
                            <br/>                      
                            <input type="hidden" id="cc" name="cc" value="<s:property value="categorycode"/>"/>
                            <h2>Details of Remote Center</h2>
                            <p style="display:none;">
                                <span><s:property value="getText('capacity.workshopid')"/></span>
                                <input type="text" id="workshopid" name="rcc.workshopid" value="<%= workshopid%>" disabled="true"/>
                                <label id="widBlank" class="errormsg"><s:property value="getText('capacity.widBlank')"/></label>
                                <label id="widError"></label>
                            </p><br/>
                            <p>
                                <span><s:property value="getText('capacity.rcid')"/></span> 
                                <input type="text" id="rcid" name="rcc.rcid" value="<%= rcid%>" disabled="true"/>
                                <label id="rcidBlank" class="errormsg"><s:property value="getText('capacity.rcidBlank')"/></label>
                                <label id="rcidError"></label>
                            </p><br/>
                            <p>
                                <span><s:property value="getText('capacity.avaseats')"/></span>
                                <input type="text" id="avaseats" name="rcc.s_available_seats" value="<%= avaseats%>" onkeypress="return isNumberKey1(event)" maxlength="10"/>
                                <label id="aseatsBlank" class="errormsg"><s:property value="getText('capacity.aseatsBlank')"/></label>
                                <label id="avaseatsError"></label>
                            </p><br/>
                            <p>
                                <span><s:property value="getText('capacity.avaccom')"/></span>
                                <input type="text" id="avaccom" name="rcc.s_available_accomo" value="<%= avaccom%>" onkeypress="return isNumberKey1(event)" maxlength="10"/>
                                <label id="accomBlank" class="errormsg"><s:property value="getText('capacity.accomBlank')"/></label>
                                <label id="avaccomError"></label>
                            </p><br/>
                            <s:if test='%{categorycode == 7}'>
                                <p style="display: inline;"> <span style="white-space: pre-wrap;">Approximate Accommodation Cost per day Rs. : </span>
                                    <input type="text" id="acco_cost" name="rcc.acco_cost" value="<%=acco_cost%>" onkeypress="return isNumberKey1(event)" maxlength="10"/>
                                    <label id="acco_costBlank" class="errormsg"><s:property value="getText('capacity.accoBlank')"/></label>
                                    <label id="acco_costError"></label></p><br/>
                                <p style="display: inline;"><br/><br/>
                                    <span style="white-space: pre-wrap;">Approximate Food Cost per day Rs. : </span>
                                    <input type="text" id="food_cost" name="rcc.food_cost" value="<%=food_cost%>" onkeypress="return isNumberKey1(event)" maxlength="10"/>
                                    <label id="food_costBlank" class="errormsg"><s:property value="getText('capacity.foodBlank')"/></label>
                                    <label id="food_costError"></label>
                                </p><br/><br/>
                                <p style="display: none;"><img  src="images/triangle_animated.gif"><font style="font-size: 12px;"><b>Rs.1000/- participation fee is mandatory for entire workshop. Payment of Food and Boarding is optional for the participant.</b></font><img  src="images/triangle_animated.gif"></p>
                                </s:if>
                            <br/>
                            <p style="text-align: center;">
                                <input type="submit" style="position: relative; width: 75px; background: black; color: white; cursor: pointer" value="Submit"/>
                                <input type="button" style="position: relative; width: 75px; background: black; color: white; cursor: pointer" value="Reset" onclick="resetAll()"/>
                            </p>
                            <%-- Here we setting the value of workshopid,rcid in hidden field.
                                 as input field is disable then name/value pair is not submited in form 
                                 hence we use hidden field to get/set the value in action class
                            --%>
                            <s:set var="w_id"><%= workshopid%></s:set>
                            <s:set var="rc_id"><%= rcid%></s:set>
                            <s:hidden name="h_workshopid" value="%{w_id}"/>
                            <s:hidden name="h_rcid" value="%{rc_id}"/>
                        </form>
                    </s:iterator>
                </div>
            </div>
        </div>
    </div>
    <div>

    </div>

</body>

