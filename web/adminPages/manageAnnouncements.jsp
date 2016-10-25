<%-- 
    Document   : manageAnnouncements
    Created on : 28 Aug, 2014, 4:11:37 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<link rel="stylesheet" href="css/datepicker-jquery-ui.css">
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/datepicker-jquery-ui.js"></script>
<script>
   // var $jQuery2 = jQuery.noConflict(true);
</script>
<script>
    $(function() {
        $("#datepicker1").datepicker({dateFormat: 'dd-mm-yy'});
        $("#datepicker2").datepicker({dateFormat: 'dd-mm-yy'});
    });
    
    /*$jQuery2(function() {
        $jQuery2("#datepicker1").datepicker({dateFormat: 'dd-mm-yy'});
        $jQuery2("#datepicker2").datepicker({dateFormat: 'dd-mm-yy'});
    });*/
</script>
<style>
    .errmsgtype3{  
        position: relative; 
        left:205px;
        width: 250px; 
        height:5px;
        text-align: left;
        font: 70% 'Droid Sans', arial; 
        color: #E41B17;
        /*    padding-bottom: 5px;*/ 
    }
</style>
<body>
    <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId != 1}'>
    <div>
        <div style="margin-bottom: 30px;"><h3>Announcement Details.</h3></div>
        <noscript><font color="black">Please Enable Your Browser Javascript for Better Functionality.</font></noscript> &nbsp;&nbsp;
        <!--<a href="adminHome.html" style="text-decoration: none;" ><input type="button" style="background: black;color: white; width: 150px; border-radius: 10px; float: right;" value="Back to Admin Page"/></a><br><br>-->
        <div class="form_enclosure">
            <div class="form_settings">
                <div class="form_box">
                    <form action="domanageAnnouncements.html" method="post" onsubmit="return validateAnnouncementForm()">
                        <p><s:hidden id="announcementid" name="announcementid" value=""/></p>
                        <span><s:property value="getText('Announcement.selectAnnouncement')"/></span>
                        <select name="s_Announcement" id="announcement"  onchange="changeAnnouncement()">
                            <option value="-1">Select Announcement</option>
                            <s:iterator value="announcements">
                                <option value="<s:property value="announcementid"/>"><s:property value="announcement"/></option>
                            </s:iterator>
                            <option value="-2">Enter New Announcement</option>
                        </select>&nbsp;&nbsp;<input type="button" style="width: 50px; background: black; color: white;" value="New" onclick="createNewAnnoucement()"/><br> 
                        <input style="margin-left: 200px; margin-top: 5px; display: none;" type="text" name="announcement.announcement" id="announcementText" />
                        <label id="announcement_blankerr" class="errormsg"><s:property value="getText('announcement.blankerr')"/></label>
                        <p class="errmsgtype3"><s:property value="fieldErrors.get('Announcement').get(0)"/></p>
                        <br>
                        <p>
                            <span><s:property value="getText('Announcement.Link')"/></span> 
                            <input style="" name="announcement.link" id="link" type="text"/>
                            <label id="link_blankerr" class="errormsg"><s:property value="getText('link.blankerr')"/></label>
                        <p class="errmsgtype3"><s:property value="fieldErrors.get('Link').get(0)"/></p>
                        </p><br>
                        <p>
                            <span><s:property value="getText('Announcement.startdate')"/></span>
                            <input type="text" id="datepicker1" name="startdate" readonly />
                            <label id="startdate_blankerr" class="errormsg"><s:property value="getText('startdate.blankerr')"/></label>
                        <p class="errmsgtype3"><s:property value="fieldErrors.get('StartDate').get(0)"/></p>
                        </p><br>
                        <p>
                            <span><s:property value="getText('Announcement.enddate')"/></span>
                            <input type="text" id="datepicker2" name="enddate" onchange="" readonly  />
                            <label id="enddate_blankerr" class="errormsg"><s:property value="getText('enddate.blankerr')"/></label>
                        <p class="errmsgtype3"><s:property value="fieldErrors.get('EndDate').get(0)"/></p>
                        </p><br>
                        <p>
                            <span><s:property value="getText('Announcement.location')"/></span>
                            <s:property value="getText('Alocation.inhouse')"/>   <input type="radio" style="width: 13px;height: 13px; padding:0 0 0 0;" name="location" id="locationih" class="tipTip" title="<s:property value=""/>" value="inhouse" disabled> &nbsp;&nbsp;&nbsp;
                            <s:property value="getText('Alocation.outhouse')"/>  <input type="radio" style="width: 13px;height: 13px; padding:0 0 0 0;" name="location" id="locationoh" class="tipTip" title="<s:property value=""/>" value="outhouse" disabled>
                            <s:hidden name="radio_location" id="radio_location" value=""/> 
                            <label id="location_blankerr" class="errormsg"><s:property value="getText('location.blankerr')"/></label>
                        <p class="errmsgtype3"><s:property value="fieldErrors.get('Location').get(0)"/></p>
                        <br>
                        <p>
                           <span><s:property value="getText('Announcement.visible')"/></span>
                           Yes <input type="radio" style="width: 13px;height: 13px; padding:0 0 0 0;" id="visibleY" name="announcement.visible" value="Y"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           No  <input type="radio" style="width: 13px;height: 13px; padding:0 0 0 0;" id="visibleN" name="announcement.visible" value="N"/>
                          <label id="visible_blankerr" class="errormsg"><s:property value="getText('visible.blankerr')"/></label>
                          <p class="errmsgtype3"><s:property value="fieldErrors.get('Visible').get(0)"/></p>
                        </p>
                        <p>
                            <input type="submit" style="margin-left: 200px; width: 100px; background: black; color: white;" value="Submit" onclick=""/>
                            <input type="button" style="width: 100px; background: black; color: white;" value="Reset" onclick="resetAll()"/>
                        </p><br>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </s:if>
</body>
<script>
    $(document).ready(function() {
        var selectValue = document.getElementById("announcement").value;
        if (selectValue == 'New') {
            document.getElementById("announcementText").style.display = "inline";
        } else if (selectValue != -1 || selectValue != '-1') {
            document.getElementById("announcementText").style.display = "inline";
        }
    });
</script>
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

