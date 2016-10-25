<%-- 
    Document   : contactus
    Created on : 18 Aug, 2014, 10:52:34 AM
    Author     : mayank
--%>

<%@page import="org.project.process.UtilityProcess"%>
<%@page import="org.project.bean.Content"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<body>  
    <!-- Message Error -->
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <!-- End Message Error -->
    <%
        Content data = new Content();
        UtilityProcess process = new UtilityProcess();
    %>
    <h3>Contact Us</h3>
    <div class="headmessage">Feel free to contact us for any query. We are happy to help you !</div>
    <div class="form_enclosure">        
        <form name="contactUsForm" id="contactUsForm" class="contactUsForm" action="docontactus.html" method="post" onsubmit="return validateContactPage(this);" >   
            <div class="form_settings">
                <div class="form_box">
                    <h2><s:property value="getText('contactUsPage.ContactInformation')"/></h2><br/>

                    <% String content_part1 = "";
                        ArrayList<Content> contents = null;
                        try {
                            contents = new ArrayList<Content>();
                            contents = process.getPage_Content("contactus_part1");
                            for (int k = 0; k < contents.size(); k++) {
                                data = (org.project.bean.Content) contents.get(k);
                                content_part1 = (String) data.getContent();
                            }
                        } catch (Exception e) {
                            content_part1 = "";
                        }
                    %>
                    <% if (!content_part1.trim().equals("")) {%>
                    <s:set var="content"><%= content_part1%></s:set>
                    <s:property escape="false" value="content"/>
                    <% } else { %>
                    <div>
                       Contact us division
                    </div>
                    <% }%>
                    <div style="clear: both;padding-top:15px; margin-bottom:5px;"></div>
                    <hr><br/>
                    <div class="pi"> header</div>
                    <div style="padding-top:15px;">
                        <div style="float: left; width: 40%">

                            <% String content_part2 = "";
                                ArrayList<Content> contents2 = null;
                                try {
                                    contents2 = new ArrayList<Content>();
                                    contents2 = process.getPage_Content("contactus_part2");
                                    for (int k = 0; k < contents.size(); k++) {
                                        data = (org.project.bean.Content) contents2.get(k);
                                        content_part2 = (String) data.getContent();
                                    }
                                } catch (Exception e) {
                                    content_part2 = "";
                                }
                            %>
                            <% if (!content_part2.trim().equals("")) {%>
                            <s:set var="content"><%= content_part2%></s:set>
                            <s:property escape="false" value="content"/>
                            <% } else { %>
                            <div> Contact data
                            </div>
                            <% }%>
                        </div>

                        <div style="float: right; width: 50%; ">
                            <table style="float:right; border-radius:7px;margin-top:0px;background-color:white;">
                                <tr class="column">
                               </tr>
                            </table>
                        </div>
                        <div style="clear: both;">&nbsp;</div>
                    </div>
                </div>
                <div class="form_box">
                    <h2><s:property value="getText('contactUsPage.ContactTeam')"/></h2><br/>
                    <p><span><s:property value="getText('contactUsPage.Name')"/></span><input type="text" id="name" name="contactName" maxlength="40" value="" class="tipTip" title="<s:property value="getText('contactUsPage.name')"/>" />
                        <label id="nameError" class="errormsg"><s:property value="getText('registrationPage.fnameIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('nameError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('registrationPage.email')"/></span><input type="text" id="email" name="contactEmail" value="" maxlength="50" class="tipTip" title="<s:property value="getText('form.email')"/>"/>
                        <label id="emailError" class="errormsg"><s:property value="getText('registrationPage.emailerror')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('emailError').get(0)"/></label>
                    </p><br/>
                    <p><span><s:property value="getText('contactUsPage.message')"/></span><textarea rows="5" cols="50" id="message" name="message" maxlength="200" class="tipTip" title="<s:property value="getText('form.address')"/>"></textarea>
                        <label id="messageError" class="errormsg"><s:property value="getText('registrationPage.addressIsEmpty')" /></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('messageError').get(0)"/></label>
                    </p><br/><br/>
                    <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" />
                        <input style="position: relative; right:75px"  class="submit" type="reset" name="reset" value="Reset" onclick="resetContactUsPage();"/>
                    </p>
                </div>  
            </div>
        </form>
    </div> 
    

</body>
