<%-- 
    Document   : viewCompletedParticipantsSW
    Created on : Aug 30, 2016, 3:04:01 PM
    Author     : abinaya
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
<script type="text/javascript">
    $(function () {
        $(".tipTip").tipTip({defaultPosition: "right"});
    });

    function changeTest(update, workshopid, status) {
        var rcid = document.getElementById('rcid').value;
        window.location.href = "viewCompletedParticipantsIW.html?update=" + update + "&workshopid=" + workshopid + "&status=" + status + "&ins=" + rcid;
    }

    function generateCertificate1(workshopid, contextPath) {
        var rcid = document.getElementById('rcid').value;
        generateCertificate(workshopid, rcid, contextPath);
    }
</script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<!DOCTYPE html>
<%
    SimpleStringCipher cipher = new SimpleStringCipher();
    String all_encrypted = cipher.encrypt("all");    
    String update_enc = request.getParameter("update");
    String workshopid_enc = request.getParameter("workshopid");
    String ins_enc = request.getParameter("ins");
    String contextPath = ServletActionContext.getServletContext().getRealPath("");
    String ins_value = cipher.decrypt(ins_enc);

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

        <div class="form_settings">         
            <s:if test="without_RC == 1">                
                <table class="content_container1" style="font-size:100%;">
                    <tr><td>Institute:</td><td><select class="displayselect" id="rcid" name="remotecenter" onchange="changeTest('<%=update_enc%>', '<s:property value="workshopid_encrypted"/>', '<s:property value="status_encrypted"/>');" >
                                <!--<option value="<%=all_encrypted%>">All</option>-->
                                <s:iterator value="institute_list">
                                    <s:if test="%{remoteCenterId == state_present}" >
                                        <option value="<s:property value="enc_RC"/>" selected="true"><s:property value="remoteCenterName"/></option>
                                    </s:if>
                                    <s:else>
                                        <option value="<s:property value="enc_RC"/>"><s:property value="remoteCenterName"/></option>
                                    </s:else>
                                </s:iterator>                                             
                            </select>
                        </td></tr>                    
                        <s:if test="state_present != 0  && participantdetails.size > 0">
                        <tr><td>Dispatch Slip:</td>
                            <td><a style="font-size: 120%;color:#5958A8" href="DispatchSlips/dispatchSlip_<s:property value="workshopid"/>_<s:property value="state_present"/>.pdf">Click here to download</a></td>
                        </tr>
                        <tr><td>Click to Generate Certificates:</td>
                            <td><input type="button" style="background: #474686; color: white; width: 100px;height:25px; border: none; padding: 2px; border-radius: 8px;font-size: 95%;font-weight: bold;" value="Generate" onclick="generateCertificate1('<s:property value="workshopid"/>', '<%=contextPath%>');"/></td>
                        </tr>                        
                        <s:if test="if_certificate_generated > 0">
                            <tr id=""><td>Download Certificates for RC (Combined):</td>
                                <td><a style="font-size: 120%;color:#5958A8" href="certificate_templates/certificates/certificate_<s:property value="workshopid"/>_<s:property value="state_present"/>.pdf">Click here to download</a></td>
                            </tr>
                        </s:if>
                        <s:if test="if_certificate_generated > 0">
                            <tr id=""><td>Download Certificates for RC (zip file):</td>
                                <td><a style="font-size: 120%;color:#5958A8" href="certificate_templates/certificates/<%=cipher.decrypt(workshopid_enc)%>_<%=ins_value%>.zip">Click here to download</a></td>
                            </tr>
                        </s:if>    
                    </s:if>
                </table>

            </s:if><s:else>
                <input type="hidden" id="rcid" value="all">
            </s:else>
            <%-- <s:if test="certificateGroupInstitute == 1">
                 <table class="content_container1">
                     <tr><td>Institute:</td><td><select class="displayselect" id="rcid" name="remotecenter" onchange="changeTest('<%=update_enc%>', '<s:property value="workshopid_encrypted"/>', '<s:property value="status_encrypted"/>');" >
                                 <option value="<%=all_encrypted%>">All</option>
                                 <s:iterator value="rc_institute">
                                     <s:if test="%{remoteCenterId == rcid_present}" >
                                         <option value="<s:property value="enc_RC"/>" selected="true"><s:property value="remoteCenterId"/>--<s:property value="remoteCenterName"/></option>
                                     </s:if>
                                     <s:else>
                                         <option value="<s:property value="enc_RC"/>"><s:property value="remoteCenterId"/>--<s:property value="remoteCenterName"/></option>
                                     </s:else>
                                 </s:iterator>                                             
                             </select>
                         </td></tr>
                 </table>  
             </s:if><s:else>
                 <input type="hidden" id="rcid" value="all">
             </s:else> --%>


            <input type="hidden" id="cc" value="<s:property value="categorycode"/>"/>
        </div>

        <table class="display1" id="participantDetail1" style="word-spacing: normal;text-wrap: avoid;">
            <thead id = "headers" > 
                <tr>
                    <th>S.No</th>
                    <th>P ID</th>
                    <th>Name</th>
                    <th>Email</th>
                        <s:iterator value="workshopContent">
                            <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
                            <th>Institute Name</th>
                            </s:if>
                        </s:iterator>
                    <th >State</th>

                    <th>Certificate</th>
                    <th>Status</th>
                       
                </tr>
            </thead>
            <tbody align="center" id="participantDetailsBody1" >
                <s:iterator value="participantdetails" status="itStatus">
                    <tr class="gradeU">
                        <td style="align:right" id="sno_<s:property value="#itStatus.count" />"><s:property value="#itStatus.count" /></td>

                        <td id="pid_<s:property value="#itStatus.count" />" style=""><s:property value="registrationDetails.participantid" /></td>

                        <td id="name_<s:property value="#itStatus.count" />"><s:property value="firstName" /> <s:property value="lastName" /></td>
                        <td id="email_<s:property value="#itStatus.count" />"><s:property value="email" /></td>
                        <s:iterator value="workshopContent">
                            <s:if test="%{categorycode == 5 || categorycode == 7 || categorycode == 8}">
                                <td id="instituteName_<s:property value="#itStatus.count" />"><s:property value="institute.instituteName"/></td>
                            </s:if>
                        </s:iterator>                     
                        <td id="remotecenterState_<s:property value="#itStatus.count" />"><s:property value="remoteCenter.rc_state" /></td>
                        <%--<td id="regtime"><s:property value="registrationDetails.regtime" /></td>--%>
                        <!--<td id="id_<s:property value="#itStatus.count" />"><a href="UserImages/<s:property value="image" />" target="_blank">Dispatch Slip</a></td>-->

                        <s:if test="if_certificate_generated > 0">
                            <td id="letter_<s:property value="#itStatus.count" />"><a href="certificate_templates/certificates/<%=cipher.decrypt(workshopid_enc)%>_<%=ins_value%>/certificate_<%=ins_value%>_<s:property value="registrationDetails.participantid" />.pdf" target="_blank">Certificate</a></td>
                        </s:if>
                        <s:else>
                            <td>Not Generated</td>
                        </s:else>
                        <td id="<s:property value="#itStatus.count"/>"><s:property value="registrationDetails.status" /></td>
                       
                    </tr> 
                </s:iterator> 
            </tbody>  
        </table>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#participantDetail1').dataTable({
                    //                                                "scrollX": true
                });
            });
        </script>

    </s:iterator>
</div>
<center>
    <div id="loader" style="display:none;"><h4><b>Loading..please wait</b></h4></div>
</center>

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
