<%-- 
    Document   : downloads
    Created on : 25 Aug, 2014, 7:09:13 PM
    Author     : mayank
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

    <h3>Important Downloads</h3>
    <div class="headmessage">Field marked with * are mandatory </div>
    <div class="form_enclosure">        
        <form id="tobefilled" class="" action="">   
            <div class="form_settings">
                <div class="form_box"> <br/>
                  <div style="margin-left: 145px;"><img src="images/underconstruction.gif" align="center" alt="Page Under Construction" height="310" width="400"></div> 
                </div>  
            </div>
        </form>
    </div>
</body>