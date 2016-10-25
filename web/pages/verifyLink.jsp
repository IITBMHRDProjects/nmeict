<%-- 
    Document   : verifyLink
    Created on : 11 Nov, 2014, 1:08:34 PM
    Author     : asl
--%>
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

   <!-- <h3>Email Verification for Account Creation Completion</h3>-->
   <h3>Get an email verification</h3>
    <div class="headmessage">To get an Email Verification link,  type your full email address registered with 'Project Name'. Field marked with <sup><img src="images/star.png"></sup> are mandatory </div>
    <div class="form_enclosure">        
        <form id="accessaccountForm" name="accessaccountForm" class="accessaccountForm" action="doVerifyLink.html" method="post" onsubmit="return validateAccessAccountForm();">   
            <div class="form_settings">
                <div class="form_box"> <br/>
                    <p><span>E-mail <sup><img src="images/star.png"></sup></span><input type="text" id="email" name="email" value="" class="tipTip" title="<s:property value="getText('login.username')"/>" onblur="checkUserEmail()"/>
                        <label id="emailError" class="errormsg"><s:property value="getText('emailError')"/></label>
                        <label id="emailAvaliable" class="errormsg"></label>
                        <label id="emailnotAvaliable" class="errormsg"><s:property value="getText('emailnotAvaliable')"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('emailError').get(0)"/></label>
                        <label class="errorLabel"><s:property value="fieldErrors.get('emailNotAvailableError').get(0)"/></label>
                    </p><br/><br/>
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
                    <div style="margin-top:5px;"><input style="margin-right: 15px;" class="submit" type="submit" name="submit" value="Submit" /><input style="margin-left: 5px;" type="reset" class="submit" name="reset" value="Reset" onclick="resetAccessAccountForm();" /></div>
                </div>  
            </div>
        </form>
    </div>
</body>

