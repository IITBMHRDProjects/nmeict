<%-- 
    Document   : layout
    Created on : 26 Jun, 2014, 7:46:11 PM
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
            <div id="site_content">   
                <tiles:insertAttribute name="sidebar" />
                <div class="content"><tiles:insertAttribute name="body"/></div>       
            </div>
            <div>
                <tiles:insertAttribute name="footer" flush="false"/>
            </div>
        </div>
    </body>
</html>
