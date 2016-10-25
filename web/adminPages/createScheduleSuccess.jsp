<%-- 
    Document   : createScheduleSuccess
    Created on : 28 May, 2015, 11:38:07 AM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s"  uri="/struts-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <s:if test="hasActionErrors()">
            <div class="msg msg-ok">
                <s:actionerror/>
                <a href="javascript:void(0);" class="close">close</a>
            </div>
        </s:if>
        <s:else>
            <h3>Program Schedule Insertion Successful</h3>
            <div class="form_enclosure">
                <br/><p><b>Dear <s:property value="#session.loggedInUser.firstName"/> <s:property value="#session.loggedInUser.lastName"/>,</b></p>    
                <p>You have successfully created the schedule for the Short Term Training Programme(STTP).</p>   
                
                <p>To go back to the workshop index</p>
                <p>Click Here ----> <a href="workshopsIndex.html?update=K3pARn62eTIVm3aNGwP3YQ">View Workshop Index</a></p>

                <p>To go back to the home page of the administrator interface </p>
                <p>Click here ---> <a href="home.html">HOME</a></p>
            </div>
        </s:else>
    </body>
</html>
