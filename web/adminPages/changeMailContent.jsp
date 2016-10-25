<%-- 
    Document   : changeMailContent
    Created on : 13 Mar, 2015, 3:35:08 PM
    Author     : asl
--%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s"  uri="/struts-tags"%>
<body>
    <div>
        <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId != 1}'>
            <table>
                <tr>
                    <th>SR No.</th>
                    <th>File Name</th>
                    <th>Link</th>
                    <th>Upload</th>

                </tr>
                <tr>
                    <td>1</td>
                    <td>ForgotPassword_mail.html<br> (Forgot password)</td>
                    <td> <a href="ForgotPassword_mail.html" target="_blank" download>Download</a></td>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(1)">
                                <s:hidden name="mail_filename" value="ForgotPassword_mail.html"/>
                                <p><spnan><input type="file" id="mailContent1" name="mailContent"></spnan><br><label id="cotentFileError1" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>cancelled.html<br>(Participant status cancelled)</td>
                    <td><a href="cancelled.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(2)">
                                <s:hidden name="mail_filename" value="cancelled.html" />
                                <p><spnan><input type="file" id="mailContent2" name="mailContent"></spnan><br><label id="cotentFileError2" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>emailconfirm_mail.html<br>(Update profile)</td>
                    <td><a href="emailconfirm.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(3)">
                                <s:hidden name="mail_filename" value="emailconfirm_mail.html" />
                                <p><spnan><input type="file" id="mailContent3" name="mailContent"></spnan><br><label id="cotentFileError3" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>passwordChange_Mail.html<br>(Password change)</td>
                    <td><a href="passwordChange_Mail.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(4)">
                                <s:hidden name="mail_filename" value="passwordChange_Mail.html" />
                                <p><spnan><input type="file" id="mailContent4" name="mailContent"></spnan><br><label id="cotentFileError4" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>query_mail.html<br>(Query-email to user)</td>
                    <td><a href="query_mail.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(5)">
                                <s:hidden name="mail_filename" value="query_mail.html" />
                                <p><spnan><input type="file" id="mailContent5" name="mailContent"></spnan><br><label id="cotentFileError5" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>queryinitiated_mail.html<br>(Query initiated mail)</td>
                    <td><a href="queryinitiated_mail.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(6)">
                                <s:hidden name="mail_filename" value="queryinitiated_mail.html" />
                                <p><spnan><input type="file" id="mailContent6" name="mailContent"></spnan><br><label id="cotentFileError6" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>7</td>
                    <td>registration_invalid.html<br>(Participant registration status invalid)</td>
                    <td><a href="registration_invalid.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(7)">
                                <s:hidden name="mail_filename" value="registration_invalid.html" />
                                <p><spnan><input type="file" id="mailContent7" name="mailContent"></spnan><br><label id="cotentFileError7" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>8</td>
                    <td>remotecenter_capacity.html<br>(Update remote center capacity)</td>
                    <td><a href="remotecenter_capacity.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(8)">
                                <s:hidden name="mail_filename" value="remotecenter_capacity.html" />
                                <p><spnan><input type="file" id="mailContent8" name="mailContent"></spnan><br><label id="cotentFileError8" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>9</td>
                    <td>request_approved.html<br>(Participant registration status approved)</td>
                    <td><a href="request_approved.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(9)">
                                <s:hidden name="mail_filename" value="request_approved.html" />
                                <p><spnan><input type="file" id="mailContent9" name="mailContent"></spnan><br><label id="cotentFileError9" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>10</td>
                    <td>signup_mail.html</td>
                    <td><a href="signup_mail.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(10)">
                                <s:hidden name="mail_filename" value="signup_mail.html" />
                                <p><spnan><input type="file" id="mailContent10" name="mailContent"></spnan><br><label id="cotentFileError10" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>11</td>
                    <td>tempPasswordForExistUser.html<br>(Create password for existing user)</td>
                    <td><a href="tempPasswordForExistUser.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(11)">
                                <s:hidden name="mail_filename" value="tempPasswordForExistUser.html" />
                                <p><spnan><input type="file" id="mailContent11" name="mailContent"></spnan><br><label id="cotentFileError11" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>12</td>
                    <td>update_participant_byadmin.html<br>(Update details of participant by admin)</td>
                    <td><a href="update_participant_byadmin.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(12)">
                                <s:hidden name="mail_filename" value="update_participant_byadmin.html" />
                                <p><spnan><input type="file" id="mailContent12" name="mailContent"></spnan><br><label id="cotentFileError12" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>13</td>
                    <td>update_registration_success.html<br>(Update workshop registration success)</td>
                    <td><a href="update_registration_success.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(13)">
                                <s:hidden name="mail_filename" value="update_registration_success.html" />
                                <p><spnan><input type="file" id="mailContent13" name="mailContent"></spnan><br><label id="cotentFileError13" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>14</td>
                    <td>welcome_mail.html</td>
                    <td><a href="welcome_mail.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(14)">
                                <s:hidden name="mail_filename" value="welcome_mail.html" />
                                <p><spnan><input type="file" id="mailContent14" name="mailContent"></spnan><br><label id="cotentFileError14" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>15</td>
                    <td>dispatch_slip.html<br>(Dispatch slip for certificate module)</td>
                    <td><a href="dispatch_slip.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(15)">
                                <s:hidden name="mail_filename" value="dispatch_slip.html" />
                                <p><spnan><input type="file" id="mailContent15" name="mailContent"></spnan><br><label id="cotentFileError15" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>16</td>
                    <td>registration_reject.html<br>(Participant registration rejected by RCC)</td>
                    <td><a href="registration_reject.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(16)">
                                <s:hidden name="mail_filename" value="registration_reject.html" />
                                <p><spnan><input type="file" id="mailContent16" name="mailContent"></spnan><br><label id="cotentFileError16" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>17</td>
                    <td>Verified_Mail_SelfSustained.html<br>(Participant registration status verified for SSM)</td>
                    <td><a href="Verified_Mail_SelfSustained.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(17)">
                                <s:hidden name="mail_filename" value="Verified_Mail_SelfSustained.html" />
                                <p><spnan><input type="file" id="mailContent17" name="mailContent"></spnan><br><label id="cotentFileError17" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>18</td>
                    <td>countOfOngoingRegistrations.html<br>(On going workshop registration details)</td>
                    <td><a href="countOfOngoingRegistrations.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(18)">
                                <s:hidden name="mail_filename" value="countOfOngoingRegistrations.html" />
                                <p><spnan><input type="file" id="mailContent18" name="mailContent"></spnan><br><label id="cotentFileError18" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>19</td>
                    <td>nominateWSC.html<br>(Nominate for workshop coordinator)</td>
                    <td><a href="nominateWSC_mail.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(19)">
                                <s:hidden name="mail_filename" value="nominateWSC.html" />
                                <p><spnan><input type="file" id="mailContent19" name="mailContent"></spnan><br><label id="cotentFileError19" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
                 <tr>
                    <td>20</td>
                    <td>attendanceForParticipants.html <br> (Absent mail for participants)</td>
                    <td><a href="attendanceForParticipants.html" target="_blank" download>download</a>
                    <td>
                        <div>
                            <form action="doChangeMailContent.html" method="post" enctype="multipart/form-data" onsubmit="return validateContent(20)">
                                <s:hidden name="mail_filename" value="attendanceForParticipants.html" />
                                <p><spnan><input type="file" id="mailContent20" name="mailContent"></spnan><br><label id="cotentFileError20" style="display: none; color: red;"></label></p>
                            <p style="text-align: center;"><input type="submit" style="padding: 2px; border-radius: 10px; width: 100px; background: black; color: white;" value="submit"/></p>
                            </form> 
                        </div>
                    </td>
                </tr>
            </table>
        </s:if>
    </div>
    <script>
        function validateContent(id) {
            var value = 0;
            var inputid="mailContent"+id;
            var error="cotentFileError"+id;
            var mailcontent = document.getElementById(inputid).value;
            if (!(mailcontent == "" || mailcontent == null)) {
                var val = validateContentFile(mailcontent)
                if (val == false) {
                    document.getElementById(error).innerHTML = "";
                    document.getElementById(error).style.display = "inline";
                    document.getElementById(error).innerHTML = "only upload html file";
                    value++;
                 }else{
                     document.getElementById(error).style.display = "none";
                     document.getElementById(error).value = ""; 
                 }
            } else {
                document.getElementById(error).style.display = "inline";
                document.getElementById(error).innerHTML = "No file is Selected";
                value++;
            }
            
            if(value > 0){
               return false;
            }else{
                return true;
            }
        }

        function validateContentFile(content)
        {
            var result = false;
            var filext = (getExt(content)).toLowerCase();
            result = ((content != null) && (content != "") && (filext == "html"));
            return result;
        }

        function getExt(filename) {
            var dot_pos = filename.lastIndexOf(".");
            if (dot_pos == -1)
                return "";
            return filename.substr(dot_pos + 1).toLowerCase();
        }
        
        function clearError(){
            document.getElementById("cotentFileError1").style.display = "none";
            document.getElementById("cotentFileError1").value = "";
            document.getElementById("cotentFileError2").style.display = "none";
            document.getElementById("cotentFileError2").value = "";
        }
    </script>
</body>
