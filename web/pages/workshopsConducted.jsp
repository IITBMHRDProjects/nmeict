<%-- 
    Document   : workshopsConductedList
    Created on : 5 Aug, 2014, 5:23:12 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>

<style type="text/css">
    @import "paginate/css/demo_page.css";
    @import "paginate/css/demo_table_jui.css";
    @import "paginate/css/jquery-ui-1.8.4.custom.css";  
</style>
<!--<script type="text/javascript" language="javascript" src="paginate/jquery.js"></script>-->
<script type="text/javascript" language="javascript" src="paginate/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript" src="paginate/ColVis.js"></script>
<h3>Workshops Statistics</h3>
<table class="content_container2">
    <s:iterator value="workshopCount">
        <tr><td>Total Workshops Conducted : <s:property value="totalWorkshops"/></td></tr>
        <tr><td><a href="workshopsConducted.html#coordinatorWorkshops" class="td_table">Total Coordinator Workshops Conducted : <s:property value="coordinatorWorkshops"/></a></td></tr>
        <tr><td><a href="workshopsConducted.html#mainWorkshops" class="td_table">Total Main Workshops Conducted : <s:property value="mainWorkshops"/></a></td></tr>
        <tr><td><a href="workshopsConducted.html#SSMWorkshops" class="td_table">Total Self Sustained Main Workshops Conducted : <s:property value="SSMWorkshops"/></a></td></tr>
    </s:iterator>
</table>
<div class="headmessage1">
    *Click on the 'Workshop Name' to see the content and participants of the workshop.<br/>
    *Click 'Download' to download the materials
</div>
<h3><a class="h3_a" name="coordinatorWorkshops">Coordinators Workshops</a></h3>
<%
    int iteratorvariable1 = 0;
    int iteratorvariable2 = 0;
    int iteratorvariable3 = 0;
%>
<div class="form_enclosure">
    <table class="content_container1">
        <thead><tr>
                <td>S No</td>
                <td>Workshop Title</td>
                <td>Teacher</td>
                <td>Start Date</td>
                <td>End Date</td>
                <td>Downloads </td>
                <td>Status </td>
            </tr></thead><tbody>
            <s:iterator value="workshopContents">
                <s:if test="%{categorycode == 4}">
                    <s:if test='%{dateToBeDisplayed == 1}'>
                        <%iteratorvariable1++;%>               
                        <tr>
                            <td><%=iteratorvariable1%></td>
                            <td><a href="<s:property value="eventdetailspagepath"/>" style="color: #003366"><s:property value="workshopname"/></a></td>
                            <td><s:property escape="false" value="teachingfaculty"/></td>
                            <td><s:property value="startdate"/></td>
                            <td><s:property value="enddate"/></td>
                            <%-- <td><a href="<s:property value="resourcepath"/>"><s:property value="coursewarestatus"/></a> </td> --%>
                            <s:if test="%{coursewarestatus == 'Available Soon'}">
                                <td><s:property value="coursewarestatus"/></td>
                            </s:if>
                            <s:else>
                                <%-- <td><a href="<s:property value="resourcepath"/>"><s:property value="coursewarestatus"/></a> </td> --%>
                                <td>                                   
                                    <a href="videoDownloads.html?workshopid=<s:property value="workshopid_encrypted"/>" target="_blank"><s:property value="coursewarestatus"/></a> 
                                </td>
                            </s:else>
                            <td><s:if test="%{workshopCompleted == 1}">Completed</s:if><s:else><s:property value="eventstatus"/></s:else></td>
                            </tr>
                    </s:if><s:else></s:else>
                </s:if>
            </s:iterator>
        </tbody>
    </table>
</div><br/><br/><br/>
<table class="content_container_mak" style="width: 750px;" ><tr><td><a class="h3_a" name="mainWorkshops">Main Workshops</a></td></tr>
</table>
<div class="form_enclosure">
    <table class="content_container1">
        <thead><tr>
                <td>S No</td>
                <td>Workshop Title</td>
                <td>Teacher</td>
                <td>Start Date</td>
                <td>End Date</td>
                <td>Downloads </td>
                <td>Status </td>
            </tr>
        </thead><tbody>
            <s:iterator value="workshopContents">
                <s:if test="%{categorycode == 5}">
                    <s:if test='%{dateToBeDisplayed == 1}'>
                        <%iteratorvariable2++;%>               
                        <tr>
                            <td><%=iteratorvariable2%></td>
                            <td><a href="<s:property value="eventdetailspagepath"/>" style="color: #003366"><s:property value="workshopname"/></a></td>
                            <td><s:property escape="false" value="teachingfaculty"/></td>
                            <td><s:property value="startdate"/></td>
                            <td><s:property value="enddate"/></td>
                            <s:if test="%{coursewarestatus == 'Available Soon'}">
                                <td><s:property value="coursewarestatus"/></td>
                            </s:if>
                            <s:else>                            
                                <s:if test="%{(workshopid == 5000017 || workshopid == 5000018)}">
                                    <td>                                   
                                        <a href="videoDownloads.html?workshopid=<s:property value="workshopid_encrypted"/>" target="_blank"><s:property value="coursewarestatus"/></a> 
                                    </td>
                                </s:if>
                                <s:else>
                                    <%-- <td><a href="<s:property value="resourcepath"/>"><s:property value="coursewarestatus"/></a> </td> --%>
                                    <td>                                   
                                        <a href="videoDownloads.html?workshopid=<s:property value="workshopid_encrypted"/>" target="_blank"><s:property value="coursewarestatus"/></a> 
                                    </td>
                                </s:else>
                            </s:else>
                            <%--    <td><a href="<s:property value="resourcepath"/>"><s:property value="coursewarestatus"/></a> </td> --%>
                            <td><s:if test="%{workshopCompleted == 1}">Completed</s:if><s:else><s:property value="eventstatus"/></s:else></td>
                            </tr>
                    </s:if><s:else></s:else>
                </s:if>
            </s:iterator>
        </tbody>
    </table>
</div>
<table class="content_container_mak" style="width: 750px;" ><tr><td><a class="h3_a" name="SSMWorkshops">Self Sustained Main Workshops</a></td></tr>
</table>
<div class="form_enclosure">
    <table class="content_container1">
        <thead><tr>
                <td>S No</td>
                <td>Workshop Title</td>
                <td>Teacher</td>
                <td>Start Date</td>
                <td>End Date</td>
                <td>Downloads </td>
                <td>Status </td>
            </tr>
        </thead><tbody>
            <s:iterator value="workshopContents">
                <s:if test="%{categorycode == 7 || categorycode == 8}">
                    <s:if test='%{dateToBeDisplayed == 1}'>
                        <%iteratorvariable3++;%>               
                        <tr>
                            <td><%=iteratorvariable3%></td>
                            <td><a href="<s:property value="eventdetailspagepath"/>" style="color: #003366"><s:property value="workshopname"/></a></td>
                            <td><s:property escape="false" value="teachingfaculty"/></td>
                            <td><s:property value="startdate"/></td>
                            <td><s:property value="enddate"/></td>
                            <s:if test="%{coursewarestatus == 'Available Soon'}">
                                <td><s:property value="coursewarestatus"/></td>
                            </s:if>
                            <s:else>                            
                                <s:if test="%{(workshopid == 5000017 || workshopid == 5000018)}">
                                    <td>                                   
                                        <a href="videoDownloads.html?workshopid=<s:property value="workshopid_encrypted"/>" target="_blank"><s:property value="coursewarestatus"/></a> 
                                    </td>
                                </s:if>
                                <s:else>
                                    <%-- <td><a href="<s:property value="resourcepath"/>"><s:property value="coursewarestatus"/></a> </td> --%>
                                    <td>                                   
                                        <a href="videoDownloads.html?workshopid=<s:property value="workshopid_encrypted"/>" target="_blank"><s:property value="coursewarestatus"/></a> 
                                    </td>
                                </s:else>
                            </s:else>
                            <%--    <td><a href="<s:property value="resourcepath"/>"><s:property value="coursewarestatus"/></a> </td> --%>
                            <td><s:if test="%{workshopCompleted == 1}">Completed</s:if><s:else><s:property value="eventstatus"/></s:else></td>
                            </tr>
                    </s:if><s:else></s:else>
                </s:if>
            </s:iterator>
        </tbody>
    </table>
</div>
