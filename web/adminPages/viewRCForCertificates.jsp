<%-- 
    Document   : viewRCForCertificates
    Created on : 9 Apr, 2015, 10:47:50 AM
    Author     : Abinaya
--%>

<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>

<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script language="JavaScript" src="js/jquery.tipTip.minified.js"></script>    
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<!DOCTYPE html>
<%
    SimpleStringCipher cipher = new SimpleStringCipher();
    String all_encrypted = cipher.encrypt("all");
    String update_enc = request.getParameter("update");
    String update = cipher.decrypt(update_enc);
    String workshopid_enc = request.getParameter("workshopid");
    String rcid_enc = request.getParameter("rcid");
    String contextPath = ServletActionContext.getServletContext().getRealPath("");

    String rcid_value = cipher.decrypt(rcid_enc);
%>
<div>
    <s:iterator value="workshopContent">
        <input id="lms_moodle" type="hidden" value="<s:property value="lms_moodle"/>"/>
        <input id="lms_iitbx" type="hidden" value="<s:property value="lms_iitbx"/>"/>
        <input id="moodle_coursename" type="hidden" value="<s:property value="moodle_coursename"/>"/>
        <input id="iitbx_coursename" type="hidden" value="<s:property value="iitbx_coursename"/>"/>
        <h1 style="color: #036;font-weight: bold;font-size: 220%;text-align: center;"><s:property value="workshopname" /></h1>
        <h4 align="center"><s:property value="sponsor"/></h4>
        <br/>
        <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>   


        <div style="font-size: 14px; margin-left: 10px; color: #1a7327"><b style="color: #003366;">Total certificates generated :
                <% int total = 0;%>
                <s:iterator value="remoteCenters" status="itStatus">
                    <%
                        try {
                            String val = (String) request.getAttribute("certiGeneratedCount");
                            total = total + Integer.parseInt(val);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </s:iterator>
                <%= total%></b>
                <p style="text-align: right; margin-right: 100px;"><input type="button" style="padding: 5px; border: none; font-weight: bold; border-radius: 7px; color: white; background: #55a6c1;" value="Generate All" onclick="generateAll('<s:property value="workshopid" />','<%= contextPath%>');"/>
                <br><span style="color: #003366;">Remote center completed : <label id="genrateCount"></label> </span>
            </p>
            <center><p><label id="processRes"></label></p></center>
        </div><br><br>
        <center>
            <% String allrc = "";%>
            <table class="display1" id="participantDetail1" style="position: relative;">
                <thead id = "headers" > 
                    <tr>
                        <th>S.No</th>
                        <th>Remote Center ID</th>
                        <th>Remote Center Name</th>
                        <th>Click for Dispatch Slip and Certificates</th>
                        <th>Certificate Status</th>
                        <th>Generated Date</th>
                        <th>Certificate Count</th>
                        <th>Participant Count</th>
                    </tr>
                </thead>
                <tbody align="center" id="participantDetailsBody1" >
                    <s:iterator value="remoteCenters" status="itStatus">
                        <tr class="gradeU">
                            <td style="align:right" id="sno_<s:property value="#itStatus.count" />"><s:property value="#itStatus.count" /></td>
                            <td><s:property value="remoteCenterId" /></td><% allrc = allrc + ',' + String.valueOf(request.getAttribute("enc_RC"));%>
                            <td><s:property value="remoteCenterName"/>, <s:property value="rc_city"/></td>
                            <td><a target="_blank" href="viewCompletedParticipants.html?update=jyNep1PeDrBDkvNDY0dXSg&workshopid=<s:property value="workshopid_encrypted"/>&rcid=<s:property value="enc_RC"/>">Click Here</a></td>
                            <td><s:if test='%{isAlreadyCertiGen.equals("yes")}'><font style="color: green">Generated </font></s:if><s:else>Not generated</s:else></td>             
                            <td><s:property value="generateTime"/></td> 
                            <td><s:property value="certiGeneratedCount"/></td>
                            <td><s:property value="participantCount"/></td>
                        </tr> 
                    </s:iterator> 
                </tbody>  
            </table></center>
        <input type="hidden" id="allrcid" value="<%=allrc%>"/>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#participantDetail1').dataTable({
                    //                                                "scrollX": true
                });
            });
        </script>
    </s:iterator>
    <script>
        $(document).ready(function() {
            $("#settingoptions").hide();
            $("#showmore").click(function(e) {
                var x=e.pageX;
                var tmpx=x-200;
                $("#settingoptions").css({left: tmpx});
                $("#settingoptions").slideToggle();
            });
        });
    </script>
    <script>
        // This function generates certificates for all the remote centers at a time. 
        // It checks if the remote center has participant and if the certificate is already generated for the participant.
        //  If the certificate is already generated, this function will not generate certificate for that participant.
        function generateAll(workshopid,contextPath){
            var rcdata=document.getElementById("allrcid").value;
            var rcids=rcdata.split(",");
           // for(var j=1; j<=4; j++){
            for(var j=1; j< rcids.length; j++){
                 document.getElementById("processRes").innerHTML="processing...";
                generateCertificateForAll(workshopid, rcids[j], contextPath)
                
              }
        }
    </script>
    <script>
        function generateCertificateForAll(workshopid, rcid, context) {
            $('#loader').show();
            var data = "workshopid=" + workshopid + "&rcid=" + rcid + "&context=" + context;
            $.ajax({
                url: "pages/DAOGenerateCertificateForAll.jsp",
                type: "GET",
                data: data,
                dataType: "json",
                async: false ,
                success: setGenerateCertificateForAll,
                error: onError
            });
        }

        function setGenerateCertificateForAll(data) {
            $('#loader').hide();
            var countval=document.getElementById("genrateCount").innerHTML;
            var nanRes= isNaN(parseInt(countval));
            var count=0;
            if(nanRes ==true){
                count=0;
            }else{
                count=parseInt(countval);
            }
             if (data > 0) {
                var count2=parseInt(data);
                document.getElementById("genrateCount").innerHTML=(count+count2);
                document.getElementById("processRes").innerHTML="";
                document.getElementById("processRes").innerHTML="completed ";
                //alert("Certificate Generated Successfully");
               // location.reload();
            } else {
                document.getElementById("processRes").innerHTML="completed";
               // alert("No participant to generate certificate");
            }
        }

        function onError(jqXHR, textStatus) {
            alert("Error : " + textStatus);
        }
    </script>