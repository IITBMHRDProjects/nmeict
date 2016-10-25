<%-- 
    Document   : layoutAdmin
    Created on : 1 Sep, 2014, 12:17:06 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <tiles:insertAttribute name="head" flush="false"/>
    <body>
        <div id="main">
            <div>                
                <tiles:insertAttribute name="header"/>
            </div>
            <div id="site_content" style="width: auto">   
                <tiles:insertAttribute name="body"/>
            </div>
        </div>
    </body>
</html>
