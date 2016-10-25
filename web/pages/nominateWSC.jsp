<%-- 
    Document   : nominateWSC
    Created on : 1 Oct, 2015, 12:30:13 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<link rel="stylesheet" href="css/datepicker-jquery-ui.css">
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/datepicker-jquery-ui.js"></script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<script type="text/javascript" language="JavaScript" src="validation/validate.js"></script>

<script>
    $(function() {
        $("#datepicker1").datepicker({dateFormat: 'dd-mm-yy'});
    });

    function reportWorkshop(workshopid) {

        var stateID = "all";
        fetchRC_1(workshopid, stateID);
        document.getElementById("wsc_email").value = "";
    }

    function reportRC(rcid) {
        var workshopid = document.getElementById("workshopid").value;
        if (workshopid != "selectWorkshop" && rcid != "-1") {
            fetchWSCEmail(workshopid, rcid);
        }
    }
    function reportNominee(nominee_email) {
        if (nominee_email == "" || nominee_email == null) {
        } else {
            var original_wsc = document.getElementById("wsc_email").value;

            if (original_wsc == nominee_email) {
                document.getElementById("nominee_email_msg").innerHTML = "The nominated WSC is same as the original WSC";
                document.getElementById("nominee_email_msg").style.display = "inline";
                document.getElementById("nominee_email_msg").style.color = "red";
                document.getElementById("isNomineeEmailValid").value = "0";
//                document.getElementById("nominee_email").value = "";
            } else {
                var rcid = document.getElementById("remotecenter").value;
                var workshopid = document.getElementById("workshopid").value;
                if (workshopid == "selectWorkshop") {
                    document.getElementById("wcError").style.display = "inline";
                }
                if (rcid == -1) {
                    document.getElementById("rcError").style.display = "inline";
                }
                if (!(rcid == -1 || workshopid == "selectWorkshop")) {
                    checkIfCanBeWSC(nominee_email, workshopid, rcid);
                } else {
                    document.getElementById("nominee_email").value = "";
                }

            }
        }
    }
</script>

<body>
    <div class="form_enclosure">
        <form id="manageWorkshopForm" action="doNominate.html"  method="post" enctype="multipart/form-data" onsubmit="return validateWSCNominateForm();">

            <div class="form_settings">
                <p><span>Select Workshop  <sup><img src="images/star.png"></sup></span>
                    <select id="workshopid" name="nomination.wc.workshopid" onchange="reportWorkshop(this.value);">
                        <option value="selectWorkshop">Select Workshop</option>
                        <s:iterator value="workshopContent">
                            <s:if test='%{without_RC == 0}'>
                                <option value="<s:property value="workshopid"/>"><s:property value="workshopid"/> - <s:property value="workshopname"/></option>
                            </s:if>
                        </s:iterator>
                        </select>
                        <label id="wcError" class="errormsg"><s:property value="getText('nominationWSC.workshopidError')"/></label>
                </p><br/>
                <p>
                    <span>Remote Center  <sup><img src="images/star.png"></sup></span>
                    <select id="remotecenter" name="nomination.rc.remoteCenterId" onchange="reportRC(this.value);">
                        <option value="-1">--Select a Remote Center--</option>                    
                    </select>
                    <label id="rcError" class="errormsg"><s:property value="getText('nominationWSC.rcError')"/></label>
                </p><br/>
                <p id="ifCanBeNominated_msg" style="display: none;color: red;">Cannot Nominate WSC, a nominee already exist for this remote center.<br/></p>
                <input type="hidden" id="ifCanBeNominated" value="1"/>
                <p>
                    <span>Workshop Coordinator's Email  <sup><img src="images/star.png"></sup></span>
                    <input type="text" id="wsc_email" readonly name="nomination.cooridnator_email"/>
                    <label id="wscError" class="errormsg"><s:property value="getText('nominationWSC.wscError')"/></label>
                </p><br/><br/>
                <p>
                    <span>Nominee's Email  <sup><img src="images/star.png"></sup></span>
                    <input type="text" id="nominee_email" name="nomination.nominee_email" onblur="reportNominee(this.value)"/>
                    <label id="nominee_Error" class="errormsg"><s:property value="getText('nominationWSC.nominee_Error')"/></label>
                </p>
                <p id="nominee_email_msg" style="display: none;"><br/></p>
                <input type="hidden" id="isNomineeEmailValid" value="0"/>
                <br/> 
                <p>
                    <span>Active Till Date  <sup><img src="images/star.png"></sup></span>
                    <input type="text" readonly id="datepicker1" name="nomination.active_till">
                    <label id="activeDateError" class="errormsg"><s:property value="getText('nominationWSC.active_Error')"/></label>
                </p>
                <br/><br/>

                <p>
                    <input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" />
                    <input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="resetWSCNominateForm();"/>
                </p>
            </div>
        </form>
    </div>
    <script>
        $(document).ready(function() {
            $("#settingoptions").hide();
            $("#showmore").click(function(e) {
                var x = e.pageX;
                var tmpx = x - 200;
                $("#settingoptions").css({left: tmpx});
                $("#settingoptions").slideToggle();
            });
        });
    </script>            
</body>