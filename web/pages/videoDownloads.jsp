<%-- 
    Document   : videoDownloads
    Created on : 1 Jan, 2015, 11:42:41 AM
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
<script type="text/javascript" language="javascript" src="paginate/jquery.js"></script>
<script type="text/javascript" language="javascript" src="paginate/jquery.dataTables.js"></script>
<script type="text/javascript" language="javascript" src="paginate/ColVis.js"></script>
<script>

    function changeText(imageid, displayid) {
        var srcTest = document.getElementById(imageid).src;
        if (srcTest.indexOf("plus_button.png") > -1) {
            document.getElementById(displayid).style.display = "inline";
            document.getElementById(imageid).src = "images/minus_button.png";
        } else {
            document.getElementById(displayid).style.display = "none";
            document.getElementById(imageid).src = "images/plus_button.png";
        }
    }
</script>
<%
    int iteratorvariable1 = 0;
    int iteratorvariable2 = 0;
%>
<div class="form_enclosure">
    <s:iterator value="workshopContents">
        <h1><s:property value="workshopname" /></h1>
        <h4 align="center"> <s:property value="sponsor"/></h4>
        <br/>
        <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>    

        <%--        <div class="form_settings">
                    <div class="form_box">
                        <h2>Objective <img id="imgshow2" class="plus_button" src="images/plus_button.png" onclick="changeText('imgshow2','details_objective');"></h2>
                        <div id="details_objective" style="display: none;">
                            <p> <s:property escape="false" value="objectives"/>
                            </p>
                        </div>
                        <h2><a class="h2_a" name="teachingFaculty">Teaching Faculty</a></h2>
                        <p>
                            <s:property escape="false" value="teachingfaculty"/>
                        </p>
                    </div>
                </div>--%>

        <!--to show any extra resources available in database-->      
        <s:if test='%{!extraDownloads.equals("0")}'>
            <div class="form_box"> 
                <br/>
                <p><b>Additional/External Resources</b><br/>                    
                    <s:property escape="false" value="extraDownloads"/>
                </p></div>
            </s:if>

    </s:iterator>
</div>
<s:if test="%{downloads.size != 0}">
    <div class="form_enclosure">
        <table class="content_container1">
            <thead><tr>
                    <td>S No</td>
                    <td>Session</td>
                    <td>Lecture</td>                
                    <td>Click to download</td>                
                </tr>
            </thead><tbody>
                <s:iterator value="downloads">
                    <%iteratorvariable2++;%>               
                    <tr>
                        <td><%=iteratorvariable2%></td>
                        <td><s:property value="session"/></td>
                        <td><a href="<s:property value="path"/>/<s:property value="session"/>/video/<s:property value="video_name"/>" style="color: #003366" target="_blank"><s:property value="video_name"/></a></td>
                        <td><a href="<s:property value="path"/>/<s:property value="session"/>/Download/<s:property value="video_name"/>.zip" style="color: #003366">Download</a></td>
                    </tr> 
                </s:iterator>
            </tbody>
        </table>
    </div>
</s:if>
<script>
    $(document).ready(function () {
        $("#settingoptions").hide();
        $("#showmore").click(function (e) {
            var x = e.pageX;
            var tmpx = x - 200;
            $("#settingoptions").css({left: tmpx});
            $("#settingoptions").slideToggle();
        });
    });
</script>
