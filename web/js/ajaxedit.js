/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

// ajax function

function getXMLObject() { //XML Object
    var xmlHttp = false;
    try {
        xmlHttp = new ActiveXObject("Msxml2.XMLHTTP") //For old Microsoft Browers
    } catch (e) {
        try {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP") // For Microsoft IE 6.0+
        } catch (e2) {
            xmlHttp = false; // No browser accepts the XMLHTTP Object then false
        }
    }
    if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
        xmlHttp = new XMLHttpRequest(); // For Mozilla, opera Browers
    }
    return xmlHttp; //Mandatory statement returning the ajax object created
}

var xmlhttp = new getXMLObject(); //xmlhttp holds the ajax object

function trimstr(s) {
    return s.replace(/^\s+|\s+$/g, '');
}


function fetchCity(stateId) {
    var data = "state=" + stateId;
    $.ajax({
        url: "pages/DAOSetCity.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setCities,
        error: onError
    });
}

function setCities(data) {
    $("#cityInstitute").html("");
    var option = "<option value=\"-1\">--Select the city--</option>";
    for (var i = 0; i < data.length; i++) {
        option += "<option value=\"" + data[i].cityId + "\">" + data[i].cityName + "</option>";
    }
    $("#cityInstitute").append(option);
}

function fetchInstitute(cityId) {
    var data = "city=" + cityId;
    $.ajax({
        url: "pages/DAOSetInstitute.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setInstitutes,
        error: onError
    });
}

function setInstitutes(data) {
    $("#institute").html("");
    var option = "<option value=\"-1\">--Select the institute--</option>";
    for (var i = 0; i < data.length; i++) {
        option += "<option value=\"" + data[i].instituteId + "\">" + data[i].instituteName + "</option>";
    }
    option += "<option value=\"other\">Other</option>";
    $("#institute").append(option);

}

function fetchParticipantDetails(rcid, workshopid, status) {
    var data = "rcid=" + rcid + "+" + workshopid + "+" + status + "+" + 0;
    $.ajax({
        url: "pages/DAOSetParticipantDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setParticipantDetails,
        error: onError
    });
}

function setParticipantDetails(data) {
    var table = $("#dispatchdetail").dataTable();
    table.fnClearTable();
    var j = 0;
    for (var i = 0; i < data.length; i++) {
        if (data[i].institute["instituteName"] != "cc4")
        {
            j++;
            table.fnAddData([
                j,
                data[i].registrationDetails["participantid"],
                data[i].firstName + " " + data[i].lastName,
                data[i].designation["designationName"],
                data[i].remoteCenter["remoteCenterId"],
                data[i].remoteCenter["remoteCenterName"],
                data[i].institute["instituteName"],
                data[i].remoteCenter["rc_state"],
                data[i].registrationDetails["status"]
            ]);
        } else {
            j++;
            table.fnAddData([
                j,
                data[i].registrationDetails["participantid"],
                data[i].firstName + " " + data[i].lastName,
                data[i].designation["designationName"],
                data[i].remoteCenter["remoteCenterId"],
                data[i].remoteCenter["remoteCenterName"],
                data[i].remoteCenter["rc_state"],
                data[i].registrationDetails["status"]
            ]);
        }
    }
}

function fetchParticipantCount(rcid, workshopid, status) {
    var data = "rcid=" + rcid + "+" + workshopid + "+" + status + "+" + 1;
    $.ajax({
        url: "pages/DAOSetParticipantDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setParticipantCount,
        error: onError
    });
}

function setParticipantCount(data) {
    for (var i = 0; i < data.length; i++) {
        document.getElementById('statusAll').innerHTML = "All (" + data[i].totalParticipants + ")";
        document.getElementById("statusRegistered").innerHTML = "Registered (" + data[i].registeredParticipants + ")";
        document.getElementById("statusVerified").innerHTML = "Verified (" + data[i].verifiedParticipants + ")";
        document.getElementById("statusApproved").innerHTML = "Approved (" + data[i].approvedParticipants + ")";
        document.getElementById("statusConfirmed").innerHTML = "Confirmed (" + data[i].confirmedParticipants + ")";
        document.getElementById("statusWaitlisted").innerHTML = "Waitlisted (" + data[i].waitlistedParticipants + ")";
        document.getElementById("statusCancelled").innerHTML = "Cancelled (" + data[i].cancelledParticipants + ")";
        document.getElementById("statusInvalid").innerHTML = "Invalid (" + data[i].invalidParticipants + ")";
    }
}

function fetchParticipantDetails1(rcid, workshopid, status) {
    var data = "rcid=" + rcid + "+" + workshopid + "+" + status + "+" + 0;
    $.ajax({
        url: "pages/DAOSetParticipantDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setParticipantDetails1,
        error: onError
    });
}

function setParticipantDetails1(data) {
    var dataTbl = $('#participantDetail1').dataTable();
    //    dataTbl.clear();
    var size = dataTbl.rows().length;
    var j = 0;
    for (var i = 0; i < data.length; i++) {
        j++;
        var participantid = data[i].registrationDetails["participantid"];
        document.getElementById("sno_" + j).value = j;
        document.getElementById("name_" + j).value = data[i].firstName + " " + data[i].lastName;
        document.getElementById("email_" + j).value = data[i].email;
        document.getElementById("remotecenterId_" + j).value = data[i].remoteCenter["remoteCenterId"];
        document.getElementById("remotecenterName_" + j).value = data[i].remoteCenter["remoteCenterName"];
        document.getElementById("remotecenterState_" + j).value = data[i].remoteCenter["rc_state"];
        document.getElementById("mobile_" + j).value = data[i].mobileNumber;
        document.getElementById("accommodation_" + j).value = data[i].registrationDetails["accomodation"];
        document.getElementById("letter_" + j).value = data[i].registrationDetails["letter"];
        document.getElementById(+j).value = data[i].registrationDetails["status"];
    }

}
function onError(jqXHR, textStatus) {
    alert("Error : " + textStatus);
}

function fetchWorkshopid(categorycode) {
    if (categorycode == 5) {
        document.getElementById("resCoWorkshopid").style.display = "inline";
    } else {
        document.getElementById("resCoWorkshopid").style.display = "inline";
    }
    var data = "categorycode=" + categorycode;
    $.ajax({
        url: "pages/DAOGetWorkshopid.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setWorkshopid,
        error: onError
    });
}
function setWorkshopid(data) {
    document.getElementById("workshopid").value = data;
    document.getElementById("workshopid1").value = data;
}

function fetchWorkshopDetails(workshopid) {
    var data = "workshopid=" + workshopid;
    $.ajax({
        url: "pages/DAOGetWorkshopDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setWorkshopDetails,
        error: onError
    });
}
function setWorkshopDetails(data) {
    for (var i = 0; i < data.length; i++) {
        document.getElementById("workshopName").value = data[i].workshopname;
        document.getElementById("sponsor").value = data[i].sponsor;
        //check the respective radio button of category code
        document.getElementById("withdrawal_div").style.display = "none";
        if (data[i].categorycode == 4) {
            document.getElementById("categorycode1").checked = true;
            document.getElementById("resCoWorkshopid").style.display = "inline";
            document.getElementById("resCoWorkshopidInput").value = data[i].respectiveCoWorkshopid;
        }
        if (data[i].categorycode == 5) {
            document.getElementById("categorycode2").checked = true;
            document.getElementById("resCoWorkshopid").style.display = "inline";
            document.getElementById("resCoWorkshopidInput").value = data[i].respectiveCoWorkshopid;
        }
        if (data[i].categorycode == 6) {
            document.getElementById("categorycode3").checked = true;
            document.getElementById("resCoWorkshopid").style.display = "inline";
            document.getElementById("resCoWorkshopidInput").value = data[i].respectiveCoWorkshopid;
        }
        if (data[i].categorycode == 7) {
            document.getElementById("categorycode4").checked = true;
            document.getElementById("resCoWorkshopid").style.display = "inline";
            document.getElementById("resCoWorkshopidInput").value = data[i].respectiveCoWorkshopid;
        }
        if (data[i].categorycode == 8) {
            document.getElementById("categorycode5").checked = true;
            document.getElementById("resCoWorkshopid").style.display = "inline";
            document.getElementById("resCoWorkshopidInput").value = data[i].respectiveCoWorkshopid;
            document.getElementById("feeAmount").value = data[i].feeAmount;
        }

        if (data[i].without_RC == 1) {
            document.getElementById("without_RC1").checked = false;
            document.getElementById("without_RC2").checked = true;
        } else {
            document.getElementById("without_RC1").checked = true;
            document.getElementById("without_RC2").checked = false;
        }

        if (data[i].payment_at_rc) {
            document.getElementById("payment_mode_1").checked = true;
        } else {
            document.getElementById("payment_mode_1").checked = false;
        }

        if (data[i].categorycode == 7) {
            document.getElementById("payment_mode_1").checked = true;
            document.getElementById("payment_div").style.display = "none";
            document.getElementById("without_rc_div").style.display = "none";
            document.getElementById("withdrawal_div").style.display = "none";
        }


        if (data[i].payment_at_iitb) {
            document.getElementById("payment_mode_2").checked = true;
        } else {
            document.getElementById("payment_mode_2").checked = false;
        }

        if (data[i].categorycode == 8) {
            document.getElementById("payment_mode_2").checked = true;
            document.getElementById("payment_div").style.display = "inline";
            document.getElementById("withdrawal_div").style.display = "inline";
            document.getElementById("without_rc_div").style.display = "inline";
            // extra validations
            if (data[i].without_RC == 1) {
                document.getElementById("payment_mode_1").disabled = true;
                document.getElementById("certificategroup2").checked = false;
                document.getElementById("certificategroup2").disabled = true;

                document.getElementById("accommodation2").checked = true;
                document.getElementById("accommodation2").disabled = true;
                document.getElementById("accommodation1").disabled = true;
            }
            if (data[i].withdrawal_flag == 1) {
                document.getElementById("withdraw1").checked = true;
                document.getElementById("withdraw2").checked = false;
            }
            else {
                document.getElementById("withdraw1").checked = false;
                document.getElementById("withdraw2").checked = true;
            }

        }

        if (data[i].categorycode == 4 || data[i].categorycode == 5 || data[i].categorycode == 6) {
            document.getElementById("payment_div").style.display = "none";
            document.getElementById("without_rc_div").style.display = "none";
        }

        document.getElementById("ccpay").value = data[i].categorycode;
        document.getElementById("categorycode1").disabled = true;
        document.getElementById("categorycode3").disabled = true;
        document.getElementById("categorycode2").disabled = true;
        document.getElementById("categorycode4").disabled = true;
        document.getElementById("categorycode5").disabled = true;

        document.getElementById("workshopid").value = data[i].workshopid;
        document.getElementById("workshopid1").value = data[i].workshopid;
        document.getElementById("author").value = data[i].author;
        document.getElementById("durationvenue").value = data[i].durationvenue;
        document.getElementById("coursefee").value = data[i].coursefee;
        document.getElementById("introduction").value = data[i].introduction;
        document.getElementById("objectives").value = data[i].objectives;
        document.getElementById("teachingfaculty").value = data[i].teachingfaculty;
        document.getElementById("whoshouldattend").value = data[i].whoshouldattend;
        document.getElementById("note").value = data[i].note;
        document.getElementById("accomodation").value = data[i].accomodation;
        document.getElementById("howtoapply").value = data[i].howtoapply;
        document.getElementById("contact").value = data[i].contact;
        document.getElementById("instructions").value = data[i].instructions;
        document.getElementById("certificateCriteria").value = data[i].certificateCriteria;
        document.getElementById("datepicker1").value = data[i].startdatereg;
        document.getElementById("datepicker2").value = data[i].lastdatereg;
        document.getElementById("datepicker3").value = data[i].startdate1;
        document.getElementById("datepicker4").value = data[i].enddate1;
        //check the respective radio button of courseware status
        if (data[i].coursewarestatus == "Available Soon")
            document.getElementById("coursewarestatus1").checked = true;
        else
            document.getElementById("coursewarestatus2").checked = true;
        document.getElementById("certificatepath").value = data[i].certificatepath;
        document.getElementById("resourcepath").value = data[i].resourcepath;
        document.getElementById("announcement").value = data[i].announcement;

        //setting file path
        document.getElementById("permissionLetterPath").innerHTML = data[i].permissionLetter;
        document.getElementById("brochurePath").innerHTML = data[i].brochurepath;
        document.getElementById("eligibilityPath").innerHTML = data[i].eligibility;
        document.getElementById("mailcontentPath").innerHTML = data[i].mailcontentpath;

        if (data[i].accommodation == 1) {
            document.getElementById("accommodation1").checked = true;
        } else {
            document.getElementById("accommodation2").checked = true;
        }

        document.getElementById("permissionIfRequired").value = data[i].permissionIfRequired;

        if (data[i].lms_moodle == "1")
            document.getElementById("lms1").checked = true;
        if (data[i].lms_iitbx == "1")
            document.getElementById("lms2").checked = true;
        if (!(data[i].moodle_coursename == "undefined"))
        {
            document.getElementById("moodle_coursename").value = data[i].moodle_coursename;
        }
        if (!(data[i].iitbx_coursename == "undefined"))
        {
            document.getElementById("iitbx_coursename").value = data[i].iitbx_coursename;
        }
        document.getElementById("certificategroup2").checked = false;
        document.getElementById("certificategroup1").checked = false;

        if (data[i].certificateGroupRC == "1")
            document.getElementById("certificategroup2").checked = true;
        if (data[i].certificateGroupInstitute == "1")
            document.getElementById("certificategroup1").checked = true;
        if (data[i].dateToBeDisplayed == 1) {
            document.getElementById("dateToBeDisplayed").checked = true;
            document.getElementById("dateDisplay").value = "1";
        } else {
            document.getElementById("dateToBeDisplayed").checked = false;
            document.getElementById("dateDisplay").value = "0";
        }

    }
}


function fetchAnnouncementDetails(announcement) {
    var data = "a_data=" + announcement;
    $.ajax({
        url: "pages/DAOSetAnnouncement.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setAnnouncementDetails,
        error: onError
    });
}

function setAnnouncementDetails(data) {
    for (var i = 0; i < data.length; i++) {
        document.getElementById("announcementText").style.display = "inline";
        document.getElementById("announcementText").value = data[i].announcement;
        document.getElementById("link").value = data[i].link;
        document.getElementById("datepicker1").value = data[i].startdate;
        document.getElementById("datepicker2").value = data[i].enddate;
        var location = data[i].location;
        var announcementid = data[i].announcementid;
        document.getElementById("announcementid").value = announcementid;
        if (location == 'inhouse') {
            document.getElementById("locationih").checked = true;
            $("#link").prop('readonly', true);
            document.getElementById("radio_location").value = "inhouse";
        } else if (location == 'outhouse') {
            document.getElementById("locationoh").checked = true;
            $("#link").prop('readonly', false);
            document.getElementById("radio_location").value = "outhouse";
        }
        var visibleRes = data[i].visible;
        if (visibleRes == 'Y') {
            document.getElementById("visibleY").checked = true;
        } else if (visibleRes == 'N') {
            document.getElementById("visibleN").checked = true;
        } else {
            document.getElementById("visibleY").checked = false;
            document.getElementById("visibleN").checked = false;
        }
    }
}

function fetchRC(workshopid, stateID) {
    var data = "workshopid=" + workshopid + "+" + stateID;
    $.ajax({
        url: "pages/DAOSetRC.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setRC,
        error: onError
    });
}

function setRC(data) {
    $("#remotecenter").html("");
    var option = "<option value=\"-1\">--Select a Remote Center--</option>";
    for (var i = 0; i < data.length; i++) {
        option += "<option value=\"" + data[i].remoteCenterId + "\">" + data[i].remoteCenterName + ", " + data[i].rc_city + "</option>";
    }
    $("#remotecenter").append(option);

}

function fetchRCMain(workshopid, stateID) {
    var data = "workshopid=" + workshopid + "+" + stateID;
    $.ajax({
        url: "pages/DAOSetRCCMain.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setRCMain,
        error: onError
    });
}

function setRCMain(data) {
    $("#remotecenter").html("");
    var option = "<option value=\"-1\">--Select a Remote Center--</option>";
    for (var i = 0; i < data.length; i++) {
        option += "<option value=\"" + data[i].remoteCenterId + "\">" + data[i].remoteCenterName + ", " + data[i].rc_city + "</option>";
    }
    $("#remotecenter").append(option);

}

function changeParticipantStatus(i, participantid, status, email, context, cc, lms_moodle, isfaculty, rc_flag, rc_payment_flag) {
    var data = "data=" + i + "+" + participantid + "+" + email + "+" + context + "+" + cc + "+" + status + "+" + isfaculty;
    $.ajax({
        url: "pages/DAOChangeStatus.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setChangedStatus,
        error: onError
    });
    if (lms_moodle == 1) {
        //    function moodle(participantid, status, email) {

        //        if(status == "Accepted"){
        //            if (cc == 7) {
        //                window.open("http://PATH/moodle/moodle-enrolment.php?id=" + participantid + "&ide=" + email + "&type=main")
        //            } 
        //        }
        if (status == "Cancelled") {
            if (cc == 5 || cc == 7 || cc == 8) {
                window.open("http://PATH/moodle/moodle-unenrolment.php?id=" + participantid + "&ide=" + email + "&type=main")
            }
            if (cc == 4) {
                window.open("http://PATH/moodle/moodle-unenrolment.php?id=" + participantid + "&ide=" + email + "&type=coordinator")
            }
            if (cc == 6) {
                window.open("http://PATH/moodle/moodle-unenrolment.php?id=" + participantid + "&ide=" + email + "&type=main")
            }
        }
        if (status == "Withdrawn") {
            if (cc == 5) {
                window.open("http://PATH/moodle/moodle-unenrolment.php?id=" + participantid + "&ide=" + email + "&type=main")
            }
            if (cc == 4) {
                window.open("http://PATH/moodle/moodle-unenrolment.php?id=" + participantid + "&ide=" + email + "&type=coordinator")
            }
        }

        if (status == "Request Approved") {
            if (cc == 5 || cc == 8) {
                if (cc == 8 && rc_flag == 0) {
                    if (rc_payment_flag == 1) {
                        //window.open("http://PATH/moodle/moodle-enrolment.php?id=" + participantid + "&ide=" + email + "&type=coordinator")
                    } else {
                        window.open("http://PATH/moodle/moodle-enrolment.php?id=" + participantid + "&ide=" + email + "&type=coordinator")
                    }

                } else {
                    // window.open("http://PATH/moodle/moodle-enrolment.php?id=" + participantid + "&ide=" + email + "&type=main")
                }
            }
            if (cc == 4) {
                window.open("http://PATH/moodle/moodle-enrolment.php?id=" + participantid + "&ide=" + email + "&type=coordinator")
            }
            if (cc == 6) {
                window.open("http://PATH/moodle/moodle-enrolment.php?id=" + participantid + "&ide=" + email + "&type=main")
            }
        }
    }
//    }
}
function setChangedStatus(data) {
    if (data[1] == "notupdated") {
        alert("Error. Please try again later");
    } else {
        if (data[2] == "7" && data[1] == "Accepted") {
            location.reload();
        }
        else if (data[2] == "8" && data[1] == "Accepted") {
            location.reload();
        }
        else {
            document.getElementById(data[0]).innerHTML = data[1];
        }
    }
}

function sendMailToRcc(workshopid) {
    var data = "data=" + workshopid;
    $.ajax({
        url: "pages/DAOSendMailToRcc.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setMailSentToRcc,
        error: onError
    });
}
function setMailSentToRcc(data) {
    if (data[1] == 0) {
        alert("Error in Ajax Call");
    } else {
        alert("Mail Sent Successfully !");
    }
}

function fetchInstituteDetails(instituteid) {
    var data = "id=" + instituteid;
    $.ajax({
        url: "pages/DAOSetInstituteDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setInstituteDetails,
        error: onError
    });
}

function setInstituteDetails(data) {
    for (var i = 0; i < data.length; i++) {
        if (data[i].instituteAddress == 'undefined' || data[i].instituteAddress == null) {
            document.getElementById("instituteAddress").value = "";
            document.getElementById("instituteAddress").readOnly = false;
        } else {
            document.getElementById("instituteAddress").value = data[i].instituteAddress;
            document.getElementById("instituteAddress").readOnly = true;
        }
        if (data[i].pincode == 0 || data[i].pincode == null) {
            document.getElementById("pincodeInstitute").value = "";
            document.getElementById("pincodeInstitute").readOnly = false;
        } else {
            document.getElementById("pincodeInstitute").value = data[i].pincode;
            document.getElementById("pincodeInstitute").readOnly = true;
        }
    }
}
function createExcel(workshopid, categorycode, rcid, res_coid) {
    var data = "data=" + workshopid + "+" + categorycode + "+" + rcid + "+" + res_coid;
    $.ajax({
        url: "pages/DAOCreateExcel_participantDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: excel_success,
        error: onError
    });
}
function excel_success(data) {
    if (data[0] == 0) {
        alert("Error in Ajax Call");
    } else {
        if (data[1] != "all")
        {
            var url = "Excel_Sheets/" + data[2] + "_" + data[1] + ".xls";
            //            window.open("Excel_Sheets/"+data[2]+"_"+data[1]+".xls",'Download');
            window.location.assign(url);
        } else
        {
            var url = "Excel_Sheets/" + data[2] + ".xls";
            //            window.open("Excel_Sheets/"+data[2]+".xls",'Download');
            window.location.assign(url);
        }
    }
}


function fetchPartcipantInstitute(cityId, userid) {
    var data = "city=" + cityId + "&userid=" + userid;
    $.ajax({
        url: "pages/DAOSetPaInstitute.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setInstitutes,
        error: onError
    });
}

function setPartcipantInstitutes(data) {
    $("#institute").html("");
    var option = "<option value=\"-1\">--Select the institute--</option>";
    for (var i = 0; i < data.length; i++) {
        option += "<option value=\"" + data[i].instituteId + "\">" + data[i].instituteName + "</option>";
    }
    option += "<option value=\"other\">Other</option>";
    $("#institute").append(option);
}
function fetchAccommodation(rcid, workshopid) {
    var data = "data=" + rcid + "+" + workshopid;
    $.ajax({
        url: "pages/DAOSetAccomodationDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setAccommodationDetails,
        error: onError
    });
}
function setAccommodationDetails(data) {
    if (data == -1) {
        alert("Error in Ajax Call");
    } else {
        if (data == 0) {
            alert("Accommodation is not available for the chosen Remote Center");
            document.getElementById("acco2").checked = true;
            document.getElementById("acco2").disabled = true;
            document.getElementById("acco1").disabled = true;
        }
        if (data > 0) {
            //            alert("Accommodation is available for the chosen Remote Center");
        }
    }
}


function fetchInstituteHeadDetails(instituteid, streamid) {
    var data = "id=" + instituteid + "&stream=" + streamid;
    $.ajax({
        url: "pages/DAOSetInstituteHeadDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setInstituteHeadDetails,
        error: onError
    });
}

function setInstituteHeadDetails(data) {
    if (data == null || data == '') {
        document.getElementById("headName").value = "";
        document.getElementById("headEmail").value = "";
        document.getElementById("headPhone").value = "";
        document.getElementById("headAddress").value = "";
        document.getElementById("headTitle").value = '-1';
        document.getElementById("headDesignation").value = '-1';

        document.getElementById("headName").readOnly = false;
        document.getElementById("headPhone").readOnly = false;
        document.getElementById("headEmail").readOnly = false;
        document.getElementById("headAddress").readOnly = false;
        document.getElementById("headTitle").disabled = false;
        document.getElementById("headDesignation").disabled = false;
    }
    for (var i = 0; i < data.length; i++) {
        document.getElementById("headName").value = data[i].name;
        document.getElementById("headEmail").value = data[i].email;
        document.getElementById("headPhone").value = data[i].headphone;
        document.getElementById("headAddress").value = data[i].headaddress;
        document.getElementById("headTitle").value = data[i].headtitle.headTitleId;
        document.getElementById("headDesignation").value = data[i].headdesignation.headDesignationId;
        var phone = document.getElementById("headPhone").value;
        var firstNum = phone.charAt(0);
        if (firstNum != 0) {
            phone = '0' + phone;
        } else if (firstNum == 0) {
            phone = phone;
        }
        document.getElementById("headPhone").value = phone;

        var hname = document.getElementById("headName").value;
        var hemail = document.getElementById("headEmail").value;
        var hphone = document.getElementById("headPhone").value;
        var haddress = document.getElementById("headAddress").value;
        var htitle = document.getElementById("headTitle").value;
        var hdesig = document.getElementById("headDesignation").value;

        if (hname == '' || hname == null) {
            document.getElementById("headName").readOnly = false;
        } else {
            document.getElementById("headName").readOnly = true;
        }
        if (hemail == '' || hemail == null) {
            document.getElementById("headEmail").readOnly = false;
        } else {
            document.getElementById("headEmail").readOnly = true;
        }

        if (hphone == '' || hphone == null) {
            document.getElementById("headPhone").readOnly = false;
        } else {
            document.getElementById("headPhone").readOnly = true;
        }
        if (haddress == '' || haddress == null) {
            document.getElementById("headAddress").readOnly = false;
        } else {
            document.getElementById("headAddress").readOnly = true;
        }
        if (htitle == '-1' || htitle == null) {
            document.getElementById("headTitle").disabled = false;
        } else {
            document.getElementById("headTitle").disabled = true;
        }
        if (hdesig == '-1' || hdesig == null) {
            document.getElementById("headDesignation").disabled = false;
        } else {
            document.getElementById("headDesignation").disabled = true;
        }

        document.getElementById("hidden_headtitle").value = data[i].headtitle.headTitleId;
        document.getElementById("hidden_headdesignation").value = data[i].headdesignation.headDesignationId;
    }
}


function changeStatusForInvalidParticipant(i, participantid, status, email, context, cc, code) {
    var data = "tem1=" + i + "&tem2=" + participantid + "&tem3=" + email + "&tem4=" + context + "&tem5=" + status + "&tem6=" + code;
    $.ajax({
        url: "pages/DAOChangeInvalidStatus.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setChangedStatus,
        error: onError
    });
}

//function setChangedStatus(data) {
//    if (data[1] == "notupdated") {
//        alert("Error in Ajax Call");
//    } else {
//        document.getElementById(data[0]).innerHTML = data[1];
//    }
//}


function fetclistlookups() {
    var data = "";
    $.ajax({
        url: "pages/DAOGetInvalidReasons.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setlookups,
        error: onError
    });
}

function setlookups(data) {
    document.getElementById("invalid_list").innerHTML = "";
    for (var i = 0; i < data.length; i++) {
        // document.getElementById("invalid_Res").value=data[0].description;
        // document.getElementById("c_text").value=data[0].description;
        var parentdiv = document.getElementById("invalid_list");
        var checkbox = document.createElement('input');
        checkbox.type = "checkbox";
        checkbox.name = "invalid_res";
        checkbox.value = data[i].description;
        checkbox.id = "invalid_res";

        var label = document.createElement('label')
        label.htmlFor = "id";
        label.appendChild(document.createTextNode(" " + data[i].description));
        parentdiv.appendChild(checkbox);
        parentdiv.appendChild(label);
        parentdiv.appendChild(document.createElement("br"));
    }

}

function personCity(stateId) {
    var data = "state=" + stateId;
    $.ajax({
        url: "pages/DAOSetCity.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setPersonCity,
        error: onError
    });
}

function setPersonCity(data) {
    $("#personCity").html("");
    var option = "<option value=\"-1\">--Select the city--</option>";
    for (var i = 0; i < data.length; i++) {
        option += "<option value=\"" + data[i].cityId + "\">" + data[i].cityName + "</option>";
    }
    option += "<option value=\"-2\">Other</option>";
    $("#personCity").append(option);
}


function checkUserName() {
    document.getElementById('usernameAvaliable').style.display = "none";
    document.getElementById('usernamenotAvaliable').style.display = "none";
    var userName = document.getElementById('username').value.trim();
    if (userName.length == 0) {
    } else {
        if (!onlyAlphaNumeric(userName))
        {
            document.getElementById('usernameError').style.display = "inline";
        } else {
            if (xmlhttp) {
                xmlhttp.open("GET", "pages/DAOcheckUsername.jsp?username=" + userName, true);
                xmlhttp.onreadystatechange = handleUsernameServerResponses;
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send(null);
            }
        }
    }
}

function handleUsernameServerResponses()
{
    if (xmlhttp.readyState == 4) {
        if (xmlhttp.status == 200) {
            var res = xmlhttp.responseText; //Update the HTML Form element
            document.getElementById('usernameError').style.display = "none";
            if (res.match("true") != null) {
                document.getElementById('usernameAvaliable').style.display = "inline";
                document.getElementById('username').style.border = "1px solid red";
                //document.getElementById('usernamenotAvaliable').style.display = "none";
            } else {
                document.getElementById('usernameAvaliable').style.display = "none";
                document.getElementById('username').style.border = "none";
                // document.getElementById('usernamenotAvaliable').style.display = "inline";
            }
        } else {
            alert("Error! Please try again.");
        }
    }
}

function personCity1(stateId, userId) {
    var param = 'editP';
    var data = "state=" + stateId + "&id=" + userId + "&call=" + param;
    $.ajax({
        url: "pages/DAOSetCity.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setPersonCity1,
        error: onError
    });
}

function setPersonCity1(data) {
    $("#personCity").html("");
    var option = "<option value=\"-1\">--Select the city--</option>";
    for (var i = 0; i < data.length; i++) {
        option += "<option value=\"" + data[i].cityId + "\">" + data[i].cityName + "</option>";
    }
    $("#personCity").append(option);
}

function ifEmailExist(email) {
    var data = "email=" + email;
    $.ajax({
        url: "pages/DAOGetEmail.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setEmailExist,
        error: onError
    });
}

function setEmailExist(data) {
    if (data == 0) {
        alert("Email of the user does not exist in database");
        document.getElementById("emailError").style.display = "inline";
        document.getElementById("ifEmailExists").value = "0";
    } else {
        document.getElementById("emailError").style.display = "none";
        document.getElementById("ifEmailExists").value = 1;
    }
}

function fetchConfigDetails(category) {
    var data = "category=" + category;
    $.ajax({
        url: "pages/DAOSetConfigDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setConfigDetails,
        error: onError
    });
}

function setConfigDetails(data) {
    document.getElementById("configtable1").style.display = "inline";
    var table = $("#configtable1").dataTable();
    table.fnClearTable();
    var j = 0;
    for (var i = 0; i < data.length; i++) {
        j++;
        table.fnAddData([
            i + 1,
            data[i].category,
            data[i].code,
            data[i].description,
            data[i].comment,
            data[i].isactive,
            "<button class=\"approvedButton\" onclick=\"updateConfigfn('" + data[i].lookup_id_enc + "');\">Update</button>"]);
    }
}
function fetchInstitute12(cityId) {
    var data = "city=" + cityId;
    $.ajax({
        url: "pages/DAOSetInstitute.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setInstitutes12,
        error: onError
    });
}

function setInstitutes12(data) {
    $("#institute").html("");
    var option = "<option value=\"-1\">--Select the institute--</option>";
    for (var i = 0; i < data.length; i++) {
        option += "<option value=\"" + data[i].instituteId + "\">" + data[i].instituteName + "</option>";
    }
    $("#institute").append(option);

}

//function callShowSession1(){    
//    //    var dataTbl = $('#schedule1').dataTable();
//    var dataTab=document.getElementById("schedule1body");
//    var size1= dataTab.rows.length;    
//    //    dataTbl.clear();
//    //    var size = dataTbl.rows().length;
//    //    alert("size "+size);
//    var j = 0;
//    for (var i = 0; i < size1; i++) {       
//        j++;
//        var id1="session_"+j;
//        var session_no=  dataTab.rows[i].cells[1].innerHTML;  
//        alert(session_no);
//        if(!(session_no == 1)){
//            alert("is not 1")
//           dataTab.rows[i].style.display="none"; 
//        }       
//    }
//}

function updateSessionComment(comment, sessionid, time_slot_from, time_slot_to, isActive, update_till) {
    var data = "comment=" + comment + "&sessionid=" + sessionid + "&time_slot_from=" + time_slot_from + "&time_slot_to=" + time_slot_to + "&isActive=" + isActive + "&update_till=" + update_till;
    $.ajax({
        url: "pages/DAOSetUpdateComment.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setUpdateSessionComment,
        error: onError
    });
}

function setUpdateSessionComment(data) {
    if (data > 0) {
        alert("Data Updated Successfully");
    } else {
        alert("Error in ajax");
    }
}

//insertNewSession(dateOfSession,comment)
function insertNewSession(dateOfSession, comment, workshopid, time_slot_from, time_slot_to, isActive, update_till) {
    var data = "date=" + dateOfSession + "&comment=" + comment + "&workshopid=" + workshopid + "&timeSlotFrom=" + time_slot_from + "&timeSlotTo=" + time_slot_to + "&isActive=" + isActive + "&update_till=" + update_till;
    $.ajax({
        url: "pages/DAOCreateNewSession.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setinsertNewSession,
        error: onError
    });
}

function setinsertNewSession(data) {
    if (data > 0) {
        alert("Data Updated Successfully");
        location.reload();
    } else {
        alert("Error in ajax");
    }

}
function deleteSessionComment(sessionid) {
    var data = "sessionid=" + sessionid;
    $.ajax({
        url: "pages/DAOSetDeleteProgramSession.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setDeleteSessionComment,
        error: onError
    });
}

function setDeleteSessionComment(data) {
    if (data > 0) {
        alert("Session Deleted Successfully");
        document.getElementById("row_to_be_deleted").value = "yes";
        var rowid = document.getElementById("row_del").value;
        document.getElementById("schedule1").deleteRow(rowid);
    } else {
        alert("Error in ajax");
    }

}

function generateAttendanceSheet(workshopid) {
    var data = "workshopid=" + workshopid;
    $.ajax({
        url: "pages/DAOGenerateAttendanceSheet.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setGenerateAttendanceSheet,
        error: onError
    });
}

function setGenerateAttendanceSheet(data) {
    if (data > 0) {
        alert("Attendance Sheet Created Successfully");
        document.getElementById("generateAttendanceButton").style.display = "none";
    } else {
        alert("Error in ajax");
    }

}

function updateSessionOfParticipant(workshopid, participantid, date_tbl, session_update) {
    var data = "workshopid=" + workshopid + "&participantid=" + participantid + "&date=" + date_tbl + "&session_update=" + session_update;
    $.ajax({
        url: "pages/DAOSetUpdateSessionOfParticipant.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setUpdateSessionOfParticipant,
        error: onError
    });
}

function setUpdateSessionOfParticipant(data) {
    if (data > 0) {
        alert("Updated Successfully");
        var trid = document.getElementById("trid_temp").value;
        data--;
        document.getElementById(trid + "_sessionAttended").innerHTML = data;
    } else {
        alert("Error. Please try again Later.");
    }
}

function showReasons1(participantid, status) {
    var data = "participantid=" + participantid + "&status=" + status;
    $.ajax({
        url: "pages/DAOGetStatusReasons.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setShowReasons,
        error: onError
    });
}

function setShowReasons(data) {
    if (data != "" || data != null) {
        alert("Reasons : " + data);
    } else {
        alert("Error. Please try again Later.");
    }
}

function downloadPDFWSCAttendanceSheet(date, rcid, workshopid) {
    var data = "date=" + date + "&rcid=" + rcid + "&workshopid=" + workshopid;
    $.ajax({
        url: "pages/DAODownloadAttendanceSheetWSC.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setDownloadPDFWSCAttendanceSheet,
        error: onError
    });
}

function setDownloadPDFWSCAttendanceSheet(data) {
    var temp = data.split("*");
    if (temp[0] > 0) {
        alert(temp[1]);
        var openWin = window.open(temp[1]);
        //alert(openWin);
        if (!openWin) {
            alert("A pop-up blocker was detected in the browser. Please Remove popupblocker for this site");
        } else {

        }
    } else {
        alert("Error in ajax");
    }
}

function updateSessionOfParticipant1(workshopid, participantid, date_tbl, session_update) {
    var data = "workshopid=" + workshopid + "&participantid=" + participantid + "&date=" + date_tbl + "&session_update=" + session_update;
    $.ajax({
        url: "pages/DAOSetUpdateSessionOfParticipant.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setUpdateSessionOfParticipant1,
        error: onError
    });
}

function setUpdateSessionOfParticipant1(data) {
    if (data > 0) {
        alert("Updated Successfully");
    } else {
        alert("Error. Please try again Later.");
    }
}

function updateSessionOfParticipant2(workshopid, participantid, date_tbl, session_update) {
    var data = "workshopid=" + workshopid + "&participantid=" + participantid + "&date=" + date_tbl + "&session_update=" + session_update;
    $.ajax({
        url: "pages/DAOSetUpdateSessionOfParticipant.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setUpdateSessionOfParticipant2,
        error: onError
    });
}

function setUpdateSessionOfParticipant2(data) {
    if (data > 0) {
    } else {
        alert("Error. Please try again Later.");
    }
}

function fetchParticipantDetails3(rcid, workshopid, status) {
    var data = "rcid=" + rcid + "+" + workshopid + "+" + status + "+" + 0;
    $.ajax({
        url: "pages/DAOSetParticipantDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setParticipantDetails3,
        error: onError
    });
}

function setParticipantDetails3(data) {
    var table = $("#dispatchdetail").dataTable();
    table.fnClearTable();
    var j = 0;
    for (var i = 0; i < data.length; i++) {
        if (data[i].institute["instituteName"] != "cc4")
        {
            j++;
            var status = data[i].registrationDetails["status"];
            if (data[i].registrationDetails["status"] == "Request Approved") {
                status = "Verified";
            }
            table.fnAddData([
                j,
                data[i].registrationDetails["participantid"],
                data[i].firstName + " " + data[i].lastName,
                data[i].designation["designationName"],
                data[i].remoteCenter["remoteCenterId"],
                data[i].remoteCenter["remoteCenterName"],
                data[i].institute["instituteName"],
                data[i].remoteCenter["rc_state"],
                status
            ]);
        } else {
            j++;
            var status = data[i].registrationDetails["status"];
            if (data[i].registrationDetails["status"] == "Request Approved") {
                status = "Verified";
            }
            table.fnAddData([
                j,
                data[i].registrationDetails["participantid"],
                data[i].firstName + " " + data[i].lastName,
                data[i].designation["designationName"],
                data[i].remoteCenter["remoteCenterId"],
                data[i].remoteCenter["remoteCenterName"],
                data[i].remoteCenter["rc_state"],
                status
            ]);
        }
    }
}

function sendConfirmedEmailSSM(workshopid, context) {
    var data = "workshopid=" + workshopid + "&context=" + context;
    $.ajax({
        url: "pages/DAOSendConfirmedEmailSSM.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setSendConfirmedEmailSSM,
        error: onError
    });
}

function setSendConfirmedEmailSSM(data) {
    if (data > 0) {
        alert("Confirmed email sent successfully.");
    } else {
        alert("Error sending email.")
    }
}

function fetchParticipantDetails4(rcid, workshopid, status) {
    var data = "rcid=" + rcid + "+" + workshopid + "+" + status + "+" + 0;
    $.ajax({
        url: "pages/DAOSetParticipantDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setParticipantDetails4,
        error: onError
    });
}

function setParticipantDetails4(data) {
    var table = $("#dispatchdetail").dataTable();
    table.fnClearTable();
    var j = 0;
    for (var i = 0; i < data.length; i++) {
        if (data[i].institute["instituteName"] != "cc4")
        {
            j++;
            var status = data[i].registrationDetails["status"];
            if (data[i].registrationDetails["status"] == "Request Approved") {
                status = "Verified";
            }
            table.fnAddData([
                j,
                data[i].registrationDetails["participantid"],
                data[i].firstName + " " + data[i].lastName,
                data[i].mobileNumber,
                data[i].email,
                data[i].gender,
                data[i].designation["designationName"],
                data[i].remoteCenter["remoteCenterId"],
                data[i].remoteCenter["remoteCenterName"],
                data[i].institute["instituteName"],
                data[i].remoteCenter["rc_state"],
                data[i].registrationDetails["accomodation"],
                status
            ]);
        } else {
            j++;
            var status = data[i].registrationDetails["status"];
            if (data[i].registrationDetails["status"] == "Request Approved") {
                status = "Verified";
            }
            table.fnAddData([
                j,
                data[i].registrationDetails["participantid"],
                data[i].firstName + " " + data[i].lastName,
                data[i].mobileNumber,
                data[i].email,
                data[i].gender,
                data[i].designation["designationName"],
                data[i].remoteCenter["remoteCenterId"],
                data[i].remoteCenter["remoteCenterName"],
                data[i].remoteCenter["rc_state"],
                data[i].registrationDetails["accomodation"],
                status
            ]);
        }
    }
}
function fetchParticipantDetails5(rcid, workshopid, status) {
    var data = "rcid=" + rcid + "+" + workshopid + "+" + status + "+" + 0;
    $.ajax({
        url: "pages/DAOSetParticipantDetails.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setParticipantDetails5,
        error: onError
    });
}

function setParticipantDetails5(data) {
    var table = $("#dispatchdetail").dataTable();
    table.fnClearTable();
    var j = 0;
    for (var i = 0; i < data.length; i++) {
        if (data[i].institute["instituteName"] != "cc4")
        {
            j++;
            table.fnAddData([
                j,
                data[i].registrationDetails["participantid"],
                data[i].firstName + " " + data[i].lastName,
                data[i].mobileNumber,
                data[i].email,
                data[i].gender,
                data[i].designation["designationName"],
                data[i].remoteCenter["remoteCenterId"],
                data[i].remoteCenter["remoteCenterName"],
                data[i].institute["instituteName"],
                data[i].remoteCenter["rc_state"],
                data[i].registrationDetails["accomodation"],
                data[i].registrationDetails["status"]
            ]);
        } else {
            j++;
            table.fnAddData([
                j,
                data[i].registrationDetails["participantid"],
                data[i].firstName + " " + data[i].lastName,
                data[i].mobileNumber,
                data[i].email,
                data[i].gender,
                data[i].designation["designationName"],
                data[i].remoteCenter["remoteCenterId"],
                data[i].remoteCenter["remoteCenterName"],
                data[i].remoteCenter["rc_state"],
                data[i].registrationDetails["accomodation"],
                data[i].registrationDetails["status"]

            ]);
        }
    }
}

function generateCertificate(workshopid, rcid, context) {
    $('#loader').show();
    var data = "workshopid=" + workshopid + "&rcid=" + rcid + "&context=" + context;
    $.ajax({
        url: "pages/DAOGenerateCertificates.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setGenerateCertificate,
        error: onError
    });
}

function setGenerateCertificate(data) {
    $('#loader').hide();
    if (data > 0) {
        alert("Certificate Generated Successfully");
        location.reload();
    } else {
        alert("Error. Please try again later.");
    }
}

function changeState_BMW(userInterfaceId, val) {
    var data = "userInterfaceId=" + userInterfaceId + "&val=" + val;
    $.ajax({
        url: "pages/DAOChangeState_BMW.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setChangeState_BMW,
        error: onError
    });
}

function setChangeState_BMW(data) {
    if (data > 0) {
        alert("Updated Successfully");
        location.reload();
    } else {
        alert("Error in ajax");
    }
}
function fetchRC_1(workshopid, stateID) {
    var data = "workshopid=" + workshopid + "+" + stateID;
    $.ajax({
        url: "pages/DAOSetRC.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setRC_1,
        error: onError
    });
}

function setRC_1(data) {
    $("#remotecenter").html("");
    var option = "<option value=\"-1\">--Select a Remote Center--</option>";
    for (var i = 0; i < data.length; i++) {
        option += "<option value=\"" + data[i].remoteCenterId + "\">" + data[i].remoteCenterId + " - " + data[i].remoteCenterName + ", " + data[i].rc_city + "</option>";
    }
    $("#remotecenter").append(option);

}

function fetchWSCEmail(workshopid, rcid) {
    var data = "workshopid=" + workshopid + "&rcid=" + rcid;
    $.ajax({
        url: "pages/DAOFetchWSCEmail.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setWSCEmail,
        error: onError
    });
}

function setWSCEmail(data) {
    document.getElementById("wsc_email").value = data[0];
    if (data[1] > 0) {
        document.getElementById("ifCanBeNominated").value = "0";
        document.getElementById("ifCanBeNominated_msg").style.display = "inline";
    } else {
        document.getElementById("ifCanBeNominated").value = "1";
        document.getElementById("ifCanBeNominated_msg").style.display = "none";
    }
}

function fetchPersonByEmail(email) {
    var data = "email=" + email.trim();
    $.ajax({
        url: "pages/DAOGetPersonByEmail.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setPersonByEmail,
        error: onError
    });
}

function setPersonByEmail(data) {
    if (data.loginName != "undefined" && data.loginName != null)
    {
        document.getElementById("nominee_email_msg").innerHTML = data.firstName + " " + data.lastName + " is the name of the person available in our database.";
        document.getElementById("nominee_email_msg").style.color = "green";
        document.getElementById("nominee_email_msg").style.display = "inline";
        document.getElementById("isNomineeEmailValid").value = "1";
    } else {
        document.getElementById("nominee_email_msg").innerHTML = "The entered email id is not a registered user of our website. Please enter a valid email."
        document.getElementById("nominee_email_msg").style.color = "red";
        document.getElementById("nominee_email_msg").style.display = "inline";
        document.getElementById("isNomineeEmailValid").value = "0";
    }
}

function updateNominatedWSC(id, active_till) {
    var data = "id=" + id + "&active_till=" + active_till;
    $.ajax({
        url: "pages/DAOUpdateNominatedWSC.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setUpdateNominatedWSC,
        error: onError
    });
}

function setUpdateNominatedWSC(data) {
    if (data > 0) {
        alert("Updated Successfully");
    }
}

function checkIfCanBeWSC(email, workshopid, rcid) {
    var data = "email=" + email + "&workshopid=" + workshopid + "&rcid=" + rcid;
    $.ajax({
        url: "pages/DAOCheckIfCanBeWSC.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setIfCanBeWSC,
        error: onError
    });
}

function setIfCanBeWSC(data) {
    if (data[0] > 0) {
        document.getElementById("isNomineeEmailValid").value = 1;
        fetchPersonByEmail(data[1]);
    } else {
        document.getElementById("isNomineeEmailValid").value = 0;
        document.getElementById("nominee_email_msg").innerHTML = data[0];
        document.getElementById("nominee_email_msg").style.display = "inline";
        document.getElementById("nominee_email_msg").style.color = "red";
    }
}


function initiateRefundOfParticipant(participantid, workshopid, reason, updatedBy, email, workshopName, refund_type) {
    var data = "participantid=" + participantid + "&workshopid=" + workshopid + "&reason=" + reason + "&updatedBy=" + updatedBy + "&email=" + email + "&workshopName=" + workshopName + "&refund_type=" + refund_type;
    $.ajax({
        url: "pages/DAOInitiateRefund.jsp",
        type: "GET",
        data: data,
        dataType: "json",
        success: setInitiateRefund,
        error: onError
    });
}

function setInitiateRefund(data) {
    if (data != "" || data != null) {
        alert("Request for refund successful");
        location.reload();
    } else {
        alert("Error. Please try again Later.");
    }
}

