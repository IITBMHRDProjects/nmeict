/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var ADDRSTRING = "^[A-Za-z0-9 .\r\n\\/()&:',_-]*$";
var pincoderegex = /^[1-9]{1}[0-9]{5}$/;
var phoneregex = /^\+?[0][0-9]{8,12}$/;
var isnumber = /^0|[1-9]\d*$/;

function validateLoginForm() {
    var result = true;
    var value = 0;
    //getting form values
    var user = document.getElementById("username").value.trim();
    var password = document.getElementById("password").value.trim();
    //clearing the previous errors
    document.getElementById("userNameError").style.display = "none";
    document.getElementById("passwordError").style.display = "none";
    document.getElementById("username").style.border = "";
    document.getElementById("password").style.border = "";
    if ((user) == "" || !emailValidator(user)) {
        borderRedError("username");
        document.getElementById("userNameError").style.display = "inline";
        value++;
    }
    if ((password) == "" || !isStringInRange(password, 8, 15)) {
        borderRedError("password");
        document.getElementById("passwordError").style.display = "inline";
        value++;
    }
    if (value > 0) {
        return false;
    }
    return result;
}

function resetLoginForm() {
    document.getElementById("username").value = "";
    document.getElementById("password").value = "";
    document.getElementById("passwordError").style.display = "none";
    document.getElementById("userNameError").style.display = "none";
    document.getElementById("username").style.border = "";
    document.getElementById("password").style.border = "";
}


function validateRegistrationForm(registrationForm) {
    var result = true;
    var value = 0;
    //getting form values
    var email = alltrim(document.getElementById("email").value.toLowerCase());
    var cemail = alltrim(document.getElementById("cemail").value.toLowerCase());
    var password = alltrim(document.getElementById("password").value);
    var cpassword = alltrim(document.getElementById("cpassword").value);
    var title = alltrim(document.getElementById("title").value);
    var firstName = alltrim(document.getElementById("firstName").value);
    var lastName = alltrim(document.getElementById("lastName").value);
    var qualification = alltrim(document.getElementById("qualification").value);
    var designation = alltrim(document.getElementById("designation").value);
    var discipline = alltrim(document.getElementById("discipline").value);
    var stateInstitute = alltrim(document.getElementById("stateInstitute").value);
    var cityInstitute = alltrim(document.getElementById("cityInstitute").value);
    var institute = alltrim(document.getElementById("institute").value);
    var instituteAddress = alltrim(document.getElementById("instituteAddress").value);
    var pincodeInstitute = alltrim(document.getElementById("pincodeInstitute").value);
    var homeAddress = alltrim(document.getElementById("homeAddress").value);
    var cityHome = alltrim(document.getElementById("cityHome").value);
    var pincodeHome = alltrim(document.getElementById("pincodeHome").value);
    var mobile = alltrim(document.getElementById("mobile").value);
    var phoneHome = alltrim(document.getElementById("phoneHome").value);
    var headTitle = alltrim(document.getElementById("headTitle").value);
    var headName = alltrim(document.getElementById("headName").value);
    var headDesignation = alltrim(document.getElementById("headDesignation").value);
    var headEmail = alltrim(document.getElementById("headEmail").value);
    var headPhone = alltrim(document.getElementById("headPhone").value);
    var headAddress = alltrim(document.getElementById("headAddress").value);
    var experience = $('input[id=experience]:checked').val();
    var gender = $('input[id=gender]:checked').val();
    var captchaAnswer = alltrim(document.getElementById("captchaText").value);
    var capcheck = alltrim(document.getElementById('capCheck').value);

    // var aadharId = alltrim(document.getElementById('aadharid').value);
    //  var yearOfBirth = alltrim(document.getElementById('yearofbirth').value);
    //  var userName = alltrim(document.getElementById('username').value);
    var personState = alltrim(document.getElementById("personState").value);
    var personCity = alltrim(document.getElementById("personCity").value);
    var photo = registrationForm.photo.value;

    //clearing the previous errors
    document.getElementById("emailError").style.display = "none";
    document.getElementById("cerror").style.display = "none";
    document.getElementById("passwordError").style.display = "none";
    document.getElementById("cpassworderror").style.display = "none";
    document.getElementById("titleError").style.display = "none";
    document.getElementById("firstNameError").style.display = "none";
    document.getElementById('lastNameError').style.display = "none";
    document.getElementById('qualificationError').style.display = "none";
    document.getElementById('designationError').style.display = "none";
    document.getElementById('disciplineError').style.display = "none";
    document.getElementById('experienceError').style.display = "none";
    document.getElementById('genderError').style.display = "none";
    document.getElementById('stateInstituteError').style.display = "none";
    document.getElementById('cityInstituteError').style.display = "none";
    document.getElementById('instituteError').style.display = "none";
    document.getElementById('instituteAddressError').style.display = "none";
    document.getElementById('institutePincodeError').style.display = "none";
    document.getElementById('homeAddressError').style.display = "none";
    document.getElementById('homeCityError').style.display = "none";
    document.getElementById('homePincodeError').style.display = "none";
    document.getElementById('mobileError').style.display = "none";
    document.getElementById('homePhoneError').style.display = "none";
    document.getElementById('headTitleError').style.display = "none";
    document.getElementById('headNameError').style.display = "none";
    document.getElementById('headDesignationError').style.display = "none";
    document.getElementById('headEmailError').style.display = "none";
    document.getElementById('headPhoneError').style.display = "none";
    document.getElementById('headAddressError').style.display = "none";
    document.getElementById('captchaError').style.display = "none";
    document.getElementById('termsError').style.display = "none";
    document.getElementById('sameNumberError').style.display = "none";

    // document.getElementById('aadharidError').style.display = "none";
    // document.getElementById('yearofbirthError').style.display = "none";
    // document.getElementById('usernameError').style.display = "none";
    document.getElementById('personStateError').style.display = "none";
    document.getElementById('personCityError').style.display = "none";
    document.getElementById('otherCityError').style.display = "none";

    document.getElementById("photoError").style.display = "none";
    document.getElementById('facultyStatusCheckError').style.display = "none";
    //resetting the border for the previous messages. 
    document.getElementById("email").style.border = "";
    document.getElementById("cemail").style.border = "";
    document.getElementById("password").style.border = "";
    document.getElementById("cpassword").style.border = "";
    document.getElementById("title").style.border = "";
    document.getElementById("firstName").style.border = "";
    document.getElementById("lastName").style.border = "";
    document.getElementById("qualification").style.border = "";
    document.getElementById("designation").style.border = "";
    document.getElementById("discipline").style.border = "";
    document.getElementById("stateInstitute").style.border = "";
    document.getElementById("cityInstitute").style.border = "";
    document.getElementById("institute").style.border = "";
    document.getElementById("instituteAddress").style.border = "";
    document.getElementById("pincodeInstitute").style.border = "";
    document.getElementById("homeAddress").style.border = "";
    document.getElementById("cityHome").style.border = "";
    document.getElementById("pincodeHome").style.border = "";
    document.getElementById("mobile").style.border = "";
    document.getElementById("phoneHome").style.border = "";
    document.getElementById("headTitle").style.border = "";
    document.getElementById("headName").style.border = "";
    document.getElementById("headDesignation").style.border = "";
    document.getElementById("headEmail").style.border = "";
    document.getElementById("headPhone").style.border = "";
    document.getElementById("headAddress").style.border = "";
    document.getElementById("captchaText").style.border = "";

    //  document.getElementById("aadharid").style.border = "";
    //  document.getElementById("yearofbirth").style.border = "";
    //  document.getElementById("username").style.border = "";
    document.getElementById("personState").style.border = "";
    document.getElementById("personCity").style.border = "";
    document.getElementById('otherCity').style.border = "";

    document.getElementById("photo").style.border = "";
    //validations starts
    if ((email) == "" || !emailValidator(email)) {
        borderRedError("email");
        document.getElementById("emailError").style.display = "inline";
        value++;
    }
    if ((cemail) == "" || !emailValidator(cemail)) {
        borderRedError("cemail");
        document.getElementById("cerror").style.display = "inline";
        value++;
    }

    if (!((email) == (cemail))) {
        borderRedError("cemail");
        document.getElementById("cerror").style.display = "inline";
        value++;
    }

    if ((password) == "" || !isStringInRange(password, 8, 15)) {
        borderRedError("password");
        document.getElementById("passwordError").style.display = "inline";
        value++;
    }
    if ((cpassword) == "" || !isStringInRange(cpassword, 8, 15)) {
        borderRedError("cpassword");
        document.getElementById("cpassworderror").style.display = "inline";
        value++;
    }

    if (!((password) == (cpassword))) {
        borderRedError("cpassword");
        document.getElementById("cpassworderror").style.display = "inline";
        value++;
    }

    if (title == -1) {
        borderRedError("title");
        document.getElementById("titleError").style.display = "inline";
        value++;
    }
    if (!isStringInRange(firstName, 2, 30) || !validateName(firstName)) {
        borderRedError("firstName");
        document.getElementById("firstNameError").style.display = "inline";
        value++;
    }
    // if (!isStringInRange(lastName, 1, 30) || !validateName(lastName)) {
    //accept last name if blank
    if (lastName.length > 0) {
        //  if (lastName != '' || lastName != null) {
        if (!isStringInRange(lastName, 1, 30) || !validateLastName(lastName)) {
            borderRedError("lastName");
            document.getElementById('lastNameError').style.display = "inline";
            value++;
        }
        // }
    }

    if (qualification == -1) {
        borderRedError("qualification");
        document.getElementById('qualificationError').style.display = "inline";
        value++;
    }

    /*if (designation == -1) {
     borderRedError("designation");
     document.getElementById('designationError').style.display = "inline";
     value++;
     }*/

    if (discipline == -1) {
        borderRedError("discipline");
        document.getElementById('disciplineError').style.display = "inline";
        value++;
    }

    //    if((registrationForm.experience[0].checked == false ) && ( registrationForm.experience[1].checked == false ) && ( registrationForm.experience[2].checked == false ) &&  ( registrationForm.experience[3].checked == false ))
    /* if (experience == null || experience == "")
     {
     document.getElementById('experienceError').style.display = "inline";
     value++;
     }*/


    //    if((registrationForm.gender[0].checked == false ) && ( registrationForm.gender[1].checked == false ) && ( registrationForm.gender[2].checked == false ))
    if (gender == null || gender == "")
    {
        document.getElementById('genderError').style.display = "inline";
        value++;
    }


    /*if (stateInstitute == -1) {
     borderRedError("stateInstitute");
     document.getElementById('stateInstituteError').style.display = "inline";
     value++;
     }*/
    /*if (cityInstitute == -1) {
     borderRedError("cityInstitute");
     document.getElementById('cityInstituteError').style.display = "inline";
     value++;
     }*/

    //var isfacultyCheckVal = document.getElementById("facultyStCheck").checked;
    var isfacultyCheckVal = document.getElementById("facultyStCheckYes").checked;
    var isfacultyCheckVal2 = document.getElementById("facultyStCheckNo").checked;
    if (isfacultyCheckVal == false && isfacultyCheckVal2 == false) {
        document.getElementById('facultyStatusCheckError').style.display = "inline";
        value++;
    }

    if (isfacultyCheckVal == true) {
        document.getElementById("formDetails").style.display = "inline";
        document.getElementById("formInstitute").style.display = "inline";
        document.getElementById("formHeadOfInstitute").style.display = "inline";
        document.getElementById("facultyStatus").value = "1";
        if (designation == -1) {
            borderRedError("designation");
            document.getElementById('designationError').style.display = "inline";
            value++;
        }
        if (experience == null || experience == "")
        {
            document.getElementById('experienceError').style.display = "inline";
            value++;
        }
        if (stateInstitute == -1) {
            borderRedError("stateInstitute");
            document.getElementById('stateInstituteError').style.display = "inline";
            value++;
        }
        if (cityInstitute == -1) {
            borderRedError("cityInstitute");
            document.getElementById('cityInstituteError').style.display = "inline";
            value++;
        }
        if (institute == -1) {
            borderRedError("institute");
            document.getElementById('instituteError').style.display = "inline";
            value++;
        }
        if (!isStringInRange(instituteAddress, 5, 150) || !remarkValidator(instituteAddress)) {
            borderRedError("instituteAddress");
            document.getElementById('instituteAddressError').style.display = "inline";
            value++;
        }
        if (!pincodeInstitute.match(pincoderegex)) {
            borderRedError("pincodeInstitute");
            document.getElementById('institutePincodeError').style.display = "inline";
            value++;
        }
        if (headTitle == -1) {
            borderRedError("headTitle");
            document.getElementById('headTitleError').style.display = "inline";
            value++;
        }
        if (!isStringInRange(headName, 2, 50) || !validateName(headName)) {
            borderRedError("headName");
            document.getElementById("headNameError").style.display = "inline";
            value++;
        }
        if (headDesignation == -1) {
            borderRedError("headDesignation");
            document.getElementById('headDesignationError').style.display = "inline";
            value++;
        }
        if (alltrim(headEmail) == "" || !emailValidator(headEmail)) {
            borderRedError("headEmail");
            document.getElementById("headEmailError").style.display = "inline";
            value++;
        }
        if (!headPhone.match(phoneregex)) {
            borderRedError("headPhone");
            document.getElementById('headPhoneError').style.display = "inline";
            value++;
        }
        if (!isStringInRange(headAddress, 5, 175) || !remarkValidator(headAddress)) {
            borderRedError("headAddress");
            document.getElementById('headAddressError').style.display = "inline";
            value++;
        }
        if (!(photo == "" || photo == null)) {
            var size = registrationForm.photo.files[0].size;
            var val = validateLetter(photo);
            var val1 = checkFileSize(size, 262144);
            if (val == false || val1 == false) {
                borderRedError("photo");
                document.getElementById("photoError").style.display = "inline";
                value++;
            }
        } else {
            borderRedError("photo");
            document.getElementById("photoError").style.display = "inline";
            value++;
        }
    } else {
        //document.getElementById("formDetails").style.display = "inline";
        // document.getElementById("formInstitute").style.display = "inline";
        // document.getElementById("formHeadOfInstitute").style.display = "none";
        document.getElementById("facultyStatus").value = "0";
    }

    if (isfacultyCheckVal2 == true) {
        document.getElementById("formHeadOfInstitute").style.display = "none";
        document.getElementById("facultyStatus").value = "0";
        if (designation == -1) {
            borderRedError("designation");
            document.getElementById('designationError').style.display = "inline";
            value++;
        }
        if (experience == null || experience == "")
        {
            document.getElementById('experienceError').style.display = "inline";
            value++;
        }
        if (!(photo == "" || photo == null)) {
            var size = registrationForm.photo.files[0].size;
            var val = validateLetter(photo);
            var val1 = checkFileSize(size, 262144);
            if (val == false || val1 == false) {
                borderRedError("photo");
                document.getElementById("photoError").style.display = "inline";
                value++;
            }
        } else {
            borderRedError("photo");
            document.getElementById("photoError").style.display = "inline";
            value++;
        }

        // institute validation
        if (stateInstitute == -1) {
            borderRedError("stateInstitute");
            document.getElementById('stateInstituteError').style.display = "inline";
            value++;
        }
        if (cityInstitute == -1) {
            borderRedError("cityInstitute");
            document.getElementById('cityInstituteError').style.display = "inline";
            value++;
        }
        if (institute == -1) {
            borderRedError("institute");
            document.getElementById('instituteError').style.display = "inline";
            value++;
        }
        if (!isStringInRange(instituteAddress, 5, 150) || !remarkValidator(instituteAddress)) {
            borderRedError("instituteAddress");
            document.getElementById('instituteAddressError').style.display = "inline";
            value++;
        }
        if (!pincodeInstitute.match(pincoderegex)) {
            borderRedError("pincodeInstitute");
            document.getElementById('institutePincodeError').style.display = "inline";
            value++;
        }

    }

    /*if (institute == -1) {
     borderRedError("institute");
     document.getElementById('instituteError').style.display = "inline";
     value++;
     }*/

    /*if (!isStringInRange(instituteAddress, 5, 150) || !remarkValidator(instituteAddress)) {
     borderRedError("instituteAddress");
     document.getElementById('instituteAddressError').style.display = "inline";
     value++;
     }*/

    /*if (!pincodeInstitute.match(pincoderegex)) {
     borderRedError("pincodeInstitute");
     document.getElementById('institutePincodeError').style.display = "inline";
     value++;
     }*/
    if (!isStringInRange(homeAddress, 5, 150) || !remarkValidator(homeAddress)) {
        borderRedError("homeAddress");
        document.getElementById('homeAddressError').style.display = "inline";
        value++;
    }

    // if (!isStringInRangeNew(cityHome, 3, 30)) {
    /*if (!validateCityHome(cityHome, 3, 30)) {
     borderRedError("cityHome");
     document.getElementById('homeCityError').style.display = "inline";
     value++;
     }*/
    if (!pincodeHome.match(pincoderegex)) {
        borderRedError("pincodeHome");
        document.getElementById('homePincodeError').style.display = "inline";
        value++;
    }
    if (!validateMobilenumber(mobile)) {
        borderRedError("mobile");
        document.getElementById('mobileError').style.display = "inline";
        value++;
    }
    if (!phoneHome.match(phoneregex)) {
        borderRedError("phoneHome");
        document.getElementById('homePhoneError').style.display = "inline";
        value++;
    }
    /*if (headTitle == -1) {
     borderRedError("headTitle");
     document.getElementById('headTitleError').style.display = "inline";
     value++;
     }*/
    /*if (!isStringInRange(headName, 2, 50) || !validateName(headName)) {
     borderRedError("headName");
     document.getElementById("headNameError").style.display = "inline";
     value++;
     }*/
    /*if (headDesignation == -1) {
     borderRedError("headDesignation");
     document.getElementById('headDesignationError').style.display = "inline";
     value++;
     }*/
    /*if (alltrim(headEmail) == "" || !emailValidator(headEmail)) {
     borderRedError("headEmail");
     document.getElementById("headEmailError").style.display = "inline";
     value++;
     }*/
    /*if (!headPhone.match(phoneregex)) {
     borderRedError("headPhone");
     document.getElementById('headPhoneError').style.display = "inline";
     value++;
     }*/
    /*if (!isStringInRange(headAddress, 5, 175) || !remarkValidator(headAddress)) {
     borderRedError("headAddress");
     document.getElementById('headAddressError').style.display = "inline";
     value++;
     }*/

    if (!isStringInRange(captchaAnswer, 7, 7)) {
        borderRedError("captchaText");
        document.getElementById('captchaError').style.display = "inline";
        value++;
    }

    if (!registrationForm.termsAndConditions.checked == true) {
        document.getElementById('termsError').style.display = "inline";
        value++;
    }

    if (capcheck == "0") {
        borderRedError("captchaText");
        document.getElementById('captchaError').style.display = "inline";
        value++;
    }

    if (mobile.length != 0 && phoneHome != 0) {
        var res = checkPhoneNumber1();
        if (res == false) {
            document.getElementById('sameNumberError').style.display = "inline";
            value++;
        }
    }
    // validating the photo uploaded
    /* if (!(photo == "" || photo == null)) {
     var size = registrationForm.photo.files[0].size;
     var val = validateLetter(photo);
     var val1 = checkFileSize(size, 262144);
     if (val == false || val1 == false) {
     borderRedError("photo");
     document.getElementById("photoError").style.display = "inline";
     value++;
     }
     } else {
     borderRedError("photo");
     document.getElementById("photoError").style.display = "inline";
     value++;
     }*/
    /*if (yearOfBirth == "-1") {
     borderRedError("yearofbirth");
     document.getElementById("yearofbirthError").style.display = "inline";
     value++;
     }*/

    /*if (aadharId != "") {
     if (!onlyNumeric(aadharId) || !checklength(12, aadharId)) {
     borderRedError("aadharid");
     document.getElementById("aadharidError").style.display = "inline";
     value++;
     }
     }*/

    if (personState == -1) {
        borderRedError("personState");
        document.getElementById('personStateError').style.display = "inline";
        value++;
    }
    if (personCity == -1) {
        borderRedError("personCity");
        document.getElementById('personCityError').style.display = "inline";
        value++;
    } else if (personCity == -2) {
        var cityflag = alltrim(document.getElementById("hiddenCityFlag").value);
        var otherCity = alltrim(document.getElementById("otherCity").value);
        if (cityflag == 1 && otherCity.length == 0) {
            borderRedError("otherCity");
            document.getElementById('otherCityError').style.display = "inline";
            value++;
        } else if (cityflag == 1 && otherCity.length != 0) {
            if (!validateCityHome(otherCity, 3, 30)) {
                borderRedError("otherCity");
                document.getElementById('otherCityError').style.display = "inline";
                value++;
            }
        }
    }



    /*if (userName == "") {
     borderRedError("username");
     document.getElementById('usernameError').style.display = "inline";
     value++;
     }*/

    if (value > 0) {
        scrollWin();
        return false;
    }
    return result;
}

function resetRegistrationForm() {
    //resetting errors
    document.getElementById("emailError").style.display = "none";
    document.getElementById("cerror").style.display = "none";
    document.getElementById("passwordError").style.display = "none";
    document.getElementById("cpassworderror").style.display = "none";
    document.getElementById("titleError").style.display = "none";
    document.getElementById("firstNameError").style.display = "none";
    document.getElementById('lastNameError').style.display = "none";
    document.getElementById('qualificationError').style.display = "none";
    document.getElementById('designationError').style.display = "none";
    document.getElementById('disciplineError').style.display = "none";
    document.getElementById('experienceError').style.display = "none";
    document.getElementById('genderError').style.display = "none";
    document.getElementById('stateInstituteError').style.display = "none";
    document.getElementById('cityInstituteError').style.display = "none";
    document.getElementById('instituteError').style.display = "none";
    document.getElementById('instituteAddressError').style.display = "none";
    document.getElementById('institutePincodeError').style.display = "none";
    document.getElementById('homeAddressError').style.display = "none";
    document.getElementById('homeCityError').style.display = "none";
    document.getElementById('homePincodeError').style.display = "none";
    document.getElementById('mobileError').style.display = "none";
    document.getElementById('homePhoneError').style.display = "none";
    document.getElementById('headTitleError').style.display = "none";
    document.getElementById('headNameError').style.display = "none";
    document.getElementById('headDesignationError').style.display = "none";
    document.getElementById('headEmailError').style.display = "none";
    document.getElementById('headPhoneError').style.display = "none";
    document.getElementById('headAddressError').style.display = "none";
    document.getElementById("captchaError").style.display = "none";
    document.getElementById('termsError').style.display = "none";
    document.getElementById("photoError").style.display = "none";
    document.getElementById("personStateError").style.display = "none";
    document.getElementById("personCityError").style.display = "none";
    //resetting the border for the previous messages.
    document.getElementById("email").style.border = "";
    document.getElementById("cemail").style.border = "";
    document.getElementById("password").style.border = "";
    document.getElementById("cpassword").style.border = "";
    document.getElementById("title").style.border = "";
    document.getElementById("firstName").style.border = "";
    document.getElementById("lastName").style.border = "";
    document.getElementById("qualification").style.border = "";
    document.getElementById("designation").style.border = "";
    document.getElementById("discipline").style.border = "";
    document.getElementById("stateInstitute").style.border = "";
    document.getElementById("cityInstitute").style.border = "";
    document.getElementById("institute").style.border = "";
    document.getElementById("instituteAddress").style.border = "";
    document.getElementById("pincodeInstitute").style.border = "";
    document.getElementById("homeAddress").style.border = "";
    document.getElementById("cityHome").style.border = "";
    document.getElementById("pincodeHome").style.border = "";
    document.getElementById("mobile").style.border = "";
    document.getElementById("phoneHome").style.border = "";
    document.getElementById("headTitle").style.border = "";
    document.getElementById("headName").style.border = "";
    document.getElementById("headDesignation").style.border = "";
    document.getElementById("headEmail").style.border = "";
    document.getElementById("headPhone").style.border = "";
    document.getElementById("headAddress").style.border = "";
    document.getElementById("captchaText").style.border = "";
    document.getElementById("photo").style.border = "";
    document.getElementById("personState").style.border = "";
    document.getElementById("personCity").style.border = "";
    //resetting the values in the form
    document.getElementById("email").value = "";
    document.getElementById("cemail").value = "";
    document.getElementById("password").value = "";
    document.getElementById("cpassword").value = "";
    document.getElementById("title").value = "";
    document.getElementById("firstName").value = "";
    document.getElementById("lastName").value = "";
    document.getElementById("qualification").value = "";
    document.getElementById("designation").value = "";
    document.getElementById("discipline").value = "";
    document.getElementById("stateInstitute").value = "";
    document.getElementById("cityInstitute").value = "";
    document.getElementById("institute").value = "";
    document.getElementById("instituteAddress").value = "";
    document.getElementById("pincodeInstitute").value = "";
    document.getElementById("homeAddress").value = "";
    document.getElementById("cityHome").value = "";
    document.getElementById("pincodeHome").value = "";
    document.getElementById("mobile").value = "";
    document.getElementById("phoneHome").value = "";
    document.getElementById("headTitle").value = "";
    document.getElementById("headName").value = "";
    document.getElementById("headDesignation").value = "";
    document.getElementById("headEmail").value = "";
    document.getElementById("headPhone").value = "";
    document.getElementById("headAddress").value = "";
    document.getElementById("captchaText").value = "";
}

function validateProfilePage(registrationForm) {
    var result = true;
    var value = 0;
    //getting form values
    var email = alltrim(document.getElementById("email").value.toLowerCase());
    //var cemail = alltrim(document.getElementById("cemail").value.toLowerCase());
    var title = alltrim(document.getElementById("title").value);
    var firstName = alltrim(document.getElementById("firstName").value);
    var lastName = alltrim(document.getElementById("lastName").value);
    var qualification = alltrim(document.getElementById("qualification").value);
    var designation = alltrim(document.getElementById("designation").value);
    var discipline = alltrim(document.getElementById("discipline").value);
    var stateInstitute = alltrim(document.getElementById("stateInstitute").value);
    var cityInstitute = alltrim(document.getElementById("cityInstitute").value);
    var institute = alltrim(document.getElementById("institute").value);
    var instituteAddress = alltrim(document.getElementById("instituteAddress").value);
    var pincodeInstitute = alltrim(document.getElementById("pincodeInstitute").value);
    var homeAddress = alltrim(document.getElementById("homeAddress").value);
    var cityHome = alltrim(document.getElementById("cityHome").value);
    var pincodeHome = alltrim(document.getElementById("pincodeHome").value);
    var mobile = alltrim(document.getElementById("mobile").value);
    var phoneHome = alltrim(document.getElementById("phoneHome").value);
    var headTitle = alltrim(document.getElementById("headTitle").value);
    var headName = alltrim(document.getElementById("headName").value);
    var headDesignation = alltrim(document.getElementById("headDesignation").value);
    var headEmail = alltrim(document.getElementById("headEmail").value);
    var headPhone = alltrim(document.getElementById("headPhone").value);
    var headAddress = alltrim(document.getElementById("headAddress").value);
    var experience = $('input[id=experience]:checked').val();
    var gender = $('input[id=gender]:checked').val();
    var captchaAnswer = alltrim(document.getElementById("captchaText").value);
    var capcheck = alltrim(document.getElementById('capCheck').value);

    // var aadharId = alltrim(document.getElementById('aadharid').value);
    // var yearOfBirth = alltrim(document.getElementById('yearofbirth').value);
    // var userName = alltrim(document.getElementById('username').value);
    var personState = alltrim(document.getElementById("personState").value);
    var personCity = alltrim(document.getElementById("personCity").value);
    var photopath = alltrim(document.getElementById('photoPath').value);
    //clearing the previous errors
    document.getElementById("emailError").style.display = "none";
    //document.getElementById("cerror").style.display = "none";
    document.getElementById("titleError").style.display = "none";
    document.getElementById("firstNameError").style.display = "none";
    document.getElementById('lastNameError').style.display = "none";
    document.getElementById('qualificationError').style.display = "none";
    document.getElementById('designationError').style.display = "none";
    document.getElementById('disciplineError').style.display = "none";
    document.getElementById('experienceError').style.display = "none";
    document.getElementById('genderError').style.display = "none";
    document.getElementById('stateInstituteError').style.display = "none";
    document.getElementById('cityInstituteError').style.display = "none";
    document.getElementById('instituteError').style.display = "none";
    document.getElementById('instituteAddressError').style.display = "none";
    document.getElementById('institutePincodeError').style.display = "none";
    document.getElementById('homeAddressError').style.display = "none";
    document.getElementById('homeCityError').style.display = "none";
    document.getElementById('homePincodeError').style.display = "none";
    document.getElementById('mobileError').style.display = "none";
    document.getElementById('homePhoneError').style.display = "none";
    document.getElementById('headTitleError').style.display = "none";
    document.getElementById('headNameError').style.display = "none";
    document.getElementById('headDesignationError').style.display = "none";
    document.getElementById('headEmailError').style.display = "none";
    document.getElementById('headPhoneError').style.display = "none";
    document.getElementById('headAddressError').style.display = "none";
    document.getElementById('captchaError').style.display = "none";
    document.getElementById('termsError').style.display = "none";
    document.getElementById('sameNumberError').style.display = "none";

    //  document.getElementById('aadharidError').style.display = "none";
    //  document.getElementById('yearofbirthError').style.display = "none";
    //   document.getElementById('usernameError').style.display = "none";
    document.getElementById('personStateError').style.display = "none";
    document.getElementById('personCityError').style.display = "none";
    document.getElementById("photoError").style.display = "none";
    document.getElementById('otherCityError').style.display = "none";
    //resetting the border for the previous messages. 
    document.getElementById("email").style.border = "";
    //document.getElementById("cemail").style.border = "";
    document.getElementById("title").style.border = "";
    document.getElementById("firstName").style.border = "";
    document.getElementById("lastName").style.border = "";
    document.getElementById("qualification").style.border = "";
    document.getElementById("designation").style.border = "";
    document.getElementById("discipline").style.border = "";
    document.getElementById("stateInstitute").style.border = "";
    document.getElementById("cityInstitute").style.border = "";
    document.getElementById("institute").style.border = "";
    document.getElementById("instituteAddress").style.border = "";
    document.getElementById("pincodeInstitute").style.border = "";
    document.getElementById("homeAddress").style.border = "";
    document.getElementById("cityHome").style.border = "";
    document.getElementById("pincodeHome").style.border = "";
    document.getElementById("mobile").style.border = "";
    document.getElementById("phoneHome").style.border = "";
    document.getElementById("headTitle").style.border = "";
    document.getElementById("headName").style.border = "";
    document.getElementById("headDesignation").style.border = "";
    document.getElementById("headEmail").style.border = "";
    document.getElementById("headPhone").style.border = "";
    document.getElementById("headAddress").style.border = "";
    document.getElementById("captchaText").style.border = "";

    //   document.getElementById("aadharid").style.border = "";
    //   document.getElementById("yearofbirth").style.border = "";
    //   document.getElementById("username").style.border = "";
    document.getElementById("personState").style.border = "";
    document.getElementById("personCity").style.border = "";
    document.getElementById("photo").style.border = "";
    document.getElementById('otherCity').style.border = "";
    //validations starts
    if ((email) == "" || !emailValidator(email)) {
        borderRedError("email");
        document.getElementById("emailError").style.display = "inline";
        value++;
    }
    /*if ((cemail) == "" || !emailValidator(cemail)) {
     borderRedError("cemail");
     document.getElementById("cerror").style.display = "inline";
     value++;
     }*/

    /*if (!((email) == (cemail))) {
     borderRedError("cemail");
     document.getElementById("cerror").style.display = "inline";
     value++;
     }*/
    if (title == -1) {
        borderRedError("title");
        document.getElementById("titleError").style.display = "inline";
        value++;
    }
    /*if (!isStringInRange(firstName, 3, 30) || !isAlphabet(firstName)) {
     borderRedError("firstName");
     document.getElementById("firstNameError").style.display = "inline";
     value++;
     }*/
    /*if (!isStringInRange(firstName, 2, 30) || !validateName(firstName)) {
     borderRedError("firstName");
     document.getElementById("firstNameError").style.display = "inline";
     value++;
     }*/
    if (!isStringInRange(firstName, 2, 30) || !validateLastName(firstName)) {
        borderRedError("firstName");
        document.getElementById("firstNameError").style.display = "inline";
        value++;
    }
    /*if (!isStringInRange(lastName, 3, 30) || !isAlphabet(lastName)) {
     borderRedError("lastName");
     document.getElementById('lastNameError').style.display = "inline";
     value++;
     }*/
    if (lastName.length > 0) {
        //if (!lastname == "" || !lastname == null) {
        if (!isStringInRange(lastName, 1, 30) || !validateLastName(lastName)) {
            borderRedError("lastName");
            document.getElementById('lastNameError').style.display = "inline";
            value++;
        }
    }
    if (qualification == -1) {
        borderRedError("qualification");
        document.getElementById('qualificationError').style.display = "inline";
        value++;
    }
    /* if (designation == -1) {
     borderRedError("designation");
     document.getElementById('designationError').style.display = "inline";
     value++;
     }*/

    if (discipline == -1) {
        borderRedError("discipline");
        document.getElementById('disciplineError').style.display = "inline";
        value++;
    }

    /*if (experience == null || experience == "")
     {
     document.getElementById('experienceError').style.display = "inline";
     value++;
     }*/

    if (gender == null || gender == "")
    {
        document.getElementById('genderError').style.display = "inline";
        value++;
    }

    //var isfacultyCheckVal = document.getElementById("facultyStCheck").checked;
    var isfacultyCheckVal = document.getElementById("facultyStCheckYes").checked;
    if (isfacultyCheckVal == true) {
        document.getElementById("formDetails").style.display = "inline";
        document.getElementById("formInstitute").style.display = "inline";
        document.getElementById("formHeadOfInstitute").style.display = "inline";
        document.getElementById("facultyStatus").value = "1";

        if (designation == -1) {
            borderRedError("designation");
            document.getElementById('designationError').style.display = "inline";
            value++;
        }
        if (experience == null || experience == "")
        {
            document.getElementById('experienceError').style.display = "inline";
            value++;
        }
        if (stateInstitute == -1) {
            borderRedError("stateInstitute");
            document.getElementById('stateInstituteError').style.display = "inline";
            value++;
        }
        if (cityInstitute == -1) {
            borderRedError("cityInstitute");
            document.getElementById('cityInstituteError').style.display = "inline";
            value++;
        }
        if (institute == -1) {
            borderRedError("institute");
            document.getElementById('instituteError').style.display = "inline";
            value++;
        }
        if (!isStringInRange(instituteAddress, 5, 150) || !remarkValidator(instituteAddress)) {
            borderRedError("instituteAddress");
            document.getElementById('instituteAddressError').style.display = "inline";
            value++;
        }
        if (!pincodeInstitute.match(pincoderegex)) {
            borderRedError("pincodeInstitute");
            document.getElementById('institutePincodeError').style.display = "inline";
            value++;
        }
        if (headTitle == -1) {
            borderRedError("headTitle");
            document.getElementById('headTitleError').style.display = "inline";
            value++;
        }
        if (!isStringInRange(headName, 2, 50) || !validateLastName(headName)) {
            borderRedError("headName");
            document.getElementById("headNameError").style.display = "inline";
            value++;
        }
        if (headDesignation == -1) {
            borderRedError("headDesignation");
            document.getElementById('headDesignationError').style.display = "inline";
            value++;
        }
        if (alltrim(headEmail) == "" || !emailValidator(headEmail)) {
            borderRedError("headEmail");
            document.getElementById("headEmailError").style.display = "inline";
            value++;
        }
        if (!headPhone.match(phoneregex)) {
            borderRedError("headPhone");
            document.getElementById('headPhoneError').style.display = "inline";
            value++;
        }
        if (!isStringInRange(headAddress, 5, 175) || !remarkValidator(headAddress)) {
            borderRedError("headAddress");
            document.getElementById('headAddressError').style.display = "inline";
            value++;
        }

        var photo_check = "";
        if (photopath.trim() != '') {
            photo_check = "photo_exist";
            //check for validation
        } else {
            photo_check = "no photo";
            //set the error 
        }
        if (photo_check == 'no photo') {
            var input_file = alltrim(document.getElementById('photo').value);
            if (input_file == '') {
                borderRedError("photo");
                document.getElementById("photoError").style.display = "inline";
                value++;
                // scrollWin();
            } else {
                var photo_file = document.getElementById('photo');
                var res = check_photo(photo_file);
                if (res > 0) {
                    document.getElementById('photoError').innerHTML = "Only jpg / jpeg file.(max 256 kb)";
                    value++;
                }
            }
            //check for input file upload
        } else if (photo_check == 'photo_exist') {
            var input_file2 = alltrim(document.getElementById('photo').value);
            if (input_file2 == '') {
            } else {
                var photo_file = document.getElementById('photo');
                var res = check_photo(photo_file);
                if (res > 0) {
                    document.getElementById('photoError').innerHTML = "Only jpg / jpeg file.(max 256 kb)";
                    value++;
                }
            }
        }
    } else {
        document.getElementById("formDetails").style.display = "inline";
        document.getElementById("formInstitute").style.display = "inline";
        document.getElementById("formHeadOfInstitute").style.display = "none";
        document.getElementById("facultyStatus").value = "0";
    }

    var isfacultyCheckVal2 = document.getElementById("facultyStCheckNo").checked;
    if (isfacultyCheckVal2 == true) {
        document.getElementById("formHeadOfInstitute").style.display = "none";
        document.getElementById("facultyStatus").value = "0";
        if (designation == -1) {
            borderRedError("designation");
            document.getElementById('designationError').style.display = "inline";
            value++;
        }
        if (experience == null || experience == "")
        {
            document.getElementById('experienceError').style.display = "inline";
            value++;
        }
        if (stateInstitute == -1) {
            borderRedError("stateInstitute");
            document.getElementById('stateInstituteError').style.display = "inline";
            value++;
        }
        if (cityInstitute == -1) {
            borderRedError("cityInstitute");
            document.getElementById('cityInstituteError').style.display = "inline";
            value++;
        }
        if (institute == -1) {
            borderRedError("institute");
            document.getElementById('instituteError').style.display = "inline";
            value++;
        }
        if (!isStringInRange(instituteAddress, 5, 150) || !remarkValidator(instituteAddress)) {
            borderRedError("instituteAddress");
            document.getElementById('instituteAddressError').style.display = "inline";
            value++;
        }
        if (!pincodeInstitute.match(pincoderegex)) {
            borderRedError("pincodeInstitute");
            document.getElementById('institutePincodeError').style.display = "inline";
            value++;
        }
        var photo_check = "";
        if (photopath.trim() != '') {
            photo_check = "photo_exist";
            //check for validation
        } else {
            photo_check = "no photo";
            //set the error 
        }
        if (photo_check == 'no photo') {
            var input_file = alltrim(document.getElementById('photo').value);
            if (input_file == '') {
                borderRedError("photo");
                document.getElementById("photoError").style.display = "inline";
                value++;
                // scrollWin();
            } else {
                var photo_file = document.getElementById('photo');
                var res = check_photo(photo_file);
                if (res > 0) {
                    document.getElementById('photoError').innerHTML = "Only jpg / jpeg file.(max 256 kb)";
                    value++;
                }
            }
            //check for input file upload
        } else if (photo_check == 'photo_exist') {
            var input_file2 = alltrim(document.getElementById('photo').value);
            if (input_file2 == '') {
            } else {
                var photo_file = document.getElementById('photo');
                var res = check_photo(photo_file);
                if (res > 0) {
                    document.getElementById('photoError').innerHTML = "Only jpg / jpeg file.(max 256 kb)";
                    value++;
                }
            }
        }
    }

    /*if (stateInstitute == -1) {
     borderRedError("stateInstitute");
     document.getElementById('stateInstituteError').style.display = "inline";
     value++;
     }*/
    /*if (cityInstitute == -1) {
     borderRedError("cityInstitute");
     document.getElementById('cityInstituteError').style.display = "inline";
     value++;
     }*/
    /*if (institute == -1) {
     borderRedError("institute");
     document.getElementById('instituteError').style.display = "inline";
     value++;
     }*/

    /*if (!isStringInRange(instituteAddress, 5, 150) || !remarkValidator(instituteAddress)) {
     borderRedError("instituteAddress");
     document.getElementById('instituteAddressError').style.display = "inline";
     value++;
     }*/

    /*if (!pincodeInstitute.match(pincoderegex)) {
     borderRedError("pincodeInstitute");
     document.getElementById('institutePincodeError').style.display = "inline";
     value++;
     }*/
    if (!isStringInRange(homeAddress, 5, 150) || !remarkValidator(homeAddress)) {
        borderRedError("homeAddress");
        document.getElementById('homeAddressError').style.display = "inline";
        value++;
    }

    /*if (!isStringInRange(cityHome, 3, 30)) {
     borderRedError("cityHome");
     document.getElementById('homeCityError').style.display = "inline";
     value++;
     }*/
    /*if (!validateCityHome(cityHome, 3, 30)) {
     borderRedError("cityHome");
     document.getElementById('homeCityError').style.display = "inline";
     value++;
     }*/
    if (!pincodeHome.match(pincoderegex)) {
        borderRedError("pincodeHome");
        document.getElementById('homePincodeError').style.display = "inline";
        value++;
    }
    if (!validateMobilenumber(mobile)) {
        borderRedError("mobile");
        document.getElementById('mobileError').style.display = "inline";
        value++;
    }
    if (!phoneHome.match(phoneregex)) {
        borderRedError("phoneHome");
        document.getElementById('homePhoneError').style.display = "inline";
        value++;
    }
    /*if (headTitle == -1) {
     borderRedError("headTitle");
     document.getElementById('headTitleError').style.display = "inline";
     value++;
     }*/
    /* if (!isStringInRange(headName, 2, 50) || !isAlphabet(headName)) {
     borderRedError("headName");
     document.getElementById("headNameError").style.display = "inline";
     value++;
     }*/
    /*if (!isStringInRange(headName, 2, 50) || !validateLastName(headName)) {
     borderRedError("headName");
     document.getElementById("headNameError").style.display = "inline";
     value++;
     }
     if (headDesignation == -1) {
     borderRedError("headDesignation");
     document.getElementById('headDesignationError').style.display = "inline";
     value++;
     }
     if (alltrim(headEmail) == "" || !emailValidator(headEmail)) {
     borderRedError("headEmail");
     document.getElementById("headEmailError").style.display = "inline";
     value++;
     }
     if (!headPhone.match(phoneregex)) {
     borderRedError("headPhone");
     document.getElementById('headPhoneError').style.display = "inline";
     value++;
     }
     if (!isStringInRange(headAddress, 5, 175) || !remarkValidator(headAddress)) {
     borderRedError("headAddress");
     document.getElementById('headAddressError').style.display = "inline";
     value++;
     }*/

    if (!isStringInRange(captchaAnswer, 7, 7)) {
        borderRedError("captchaText");
        document.getElementById('captchaError').style.display = "inline";
        value++;
    }

    if (!registrationForm.termsAndConditions.checked == true) {
        document.getElementById('termsError').style.display = "inline";
        value++;
    }

    if (capcheck == "0") {
        borderRedError("captchaText");
        document.getElementById('captchaError').style.display = "inline";
        value++;
    }

    var res = checkPhoneNumber1();
    if (res == false) {
        document.getElementById('sameNumberError').style.display = "inline";
        value++;
    }
    /* if (yearOfBirth == "-1") {
     borderRedError("yearofbirth");
     document.getElementById("yearofbirthError").style.display = "inline";
     value++;
     }*/

    /*if (aadharId != "") {
     if (!onlyNumeric(aadharId) || !checklength(12, aadharId)) {
     borderRedError("aadharid");
     document.getElementById("aadharidError").style.display = "inline";
     value++;
     }
     }*/

    if (personState == -1) {
        borderRedError("personState");
        document.getElementById('personStateError').style.display = "inline";
        value++;
    }
    if (personCity == -1) {
        borderRedError("personCity");
        document.getElementById('personCityError').style.display = "inline";
        value++;
    } else if (personCity == -2) {
        var cityflag = alltrim(document.getElementById("hiddenCityFlag").value);
        var otherCity = alltrim(document.getElementById("otherCity").value);
        if (cityflag == 1 && otherCity.length == 0) {
            borderRedError("otherCity");
            document.getElementById('otherCityError').style.display = "inline";
            value++;
        } else if (cityflag == 1 && otherCity.length != 0) {
            if (!validateCityHome(otherCity, 3, 30)) {
                borderRedError("otherCity");
                document.getElementById('otherCityError').style.display = "inline";
                value++;
            }
        }
    }

    /*if (userName == "") {
     borderRedError("username");
     document.getElementById('usernameError').style.display = "inline";
     value++;
     }*/

    /* var photo_check = "";
     if (photopath.trim() != '') {
     photo_check = "photo_exist";
     //check for validation
     } else {
     photo_check = "no photo";
     //set the error 
     }
     if (photo_check == 'no photo') {
     var input_file = alltrim(document.getElementById('photo').value);
     if (input_file == '') {
     borderRedError("photo");
     document.getElementById("photoError").style.display = "inline";
     value++;
     // scrollWin();
     } else {
     var photo_file = document.getElementById('photo');
     var res = check_photo(photo_file);
     if (res > 0) {
     document.getElementById('photoError').innerHTML = "Only jpg / jpeg file.(max 256 kb)";
     value++;
     }
     }
     //check for input file upload
     } else if (photo_check == 'photo_exist') {
     var input_file2 = alltrim(document.getElementById('photo').value);
     if (input_file2 == '') {
     } else {
     var photo_file = document.getElementById('photo');
     var res = check_photo(photo_file);
     if (res > 0) {
     document.getElementById('photoError').innerHTML = "Only jpg / jpeg file.(max 256 kb)";
     value++;
     }
     }
     }*/

    if (value > 0) {
        scrollWin();
        return false;
    }
    return result;
}

function resetProfileForm() {
    //resetting errors
    document.getElementById("emailError").style.display = "none";
    // document.getElementById("cerror").style.display = "none";
    document.getElementById("titleError").style.display = "none";
    document.getElementById("firstNameError").style.display = "none";
    document.getElementById('lastNameError').style.display = "none";
    document.getElementById('qualificationError').style.display = "none";
    document.getElementById('designationError').style.display = "none";
    document.getElementById('disciplineError').style.display = "none";
    document.getElementById('experienceError').style.display = "none";
    document.getElementById('genderError').style.display = "none";
    document.getElementById('stateInstituteError').style.display = "none";
    document.getElementById('cityInstituteError').style.display = "none";
    document.getElementById('instituteError').style.display = "none";
    document.getElementById('instituteAddressError').style.display = "none";
    document.getElementById('institutePincodeError').style.display = "none";
    document.getElementById('homeAddressError').style.display = "none";
    document.getElementById('homeCityError').style.display = "none";
    document.getElementById('homePincodeError').style.display = "none";
    document.getElementById('mobileError').style.display = "none";
    document.getElementById('homePhoneError').style.display = "none";
    // document.getElementById('headTitleError').style.display = "none";
    // document.getElementById('headNameError').style.display = "none";
    // document.getElementById('headDesignationError').style.display = "none";
    //  document.getElementById('headEmailError').style.display = "none";
    //  document.getElementById('headPhoneError').style.display = "none";
    // document.getElementById('headAddressError').style.display = "none";
    document.getElementById("captchaError").style.display = "none";
    document.getElementById('termsError').style.display = "none";
    //resetting the border for the previous messages.
    document.getElementById("email").style.border = "";
    //  document.getElementById("cemail").style.border = "";
    document.getElementById("title").style.border = "";
    document.getElementById("firstName").style.border = "";
    document.getElementById("lastName").style.border = "";
    document.getElementById("qualification").style.border = "";
    document.getElementById("designation").style.border = "";
    document.getElementById("discipline").style.border = "";
    document.getElementById("stateInstitute").style.border = "";
    document.getElementById("cityInstitute").style.border = "";
    document.getElementById("institute").style.border = "";
    document.getElementById("instituteAddress").style.border = "";
    document.getElementById("pincodeInstitute").style.border = "";
    document.getElementById("homeAddress").style.border = "";
    document.getElementById("cityHome").style.border = "";
    document.getElementById("pincodeHome").style.border = "";
    document.getElementById("mobile").style.border = "";
    document.getElementById("phoneHome").style.border = "";
    //  document.getElementById("headTitle").style.border = "";
    //   document.getElementById("headName").style.border = "";
    //   document.getElementById("headDesignation").style.border = "";
    //    document.getElementById("headEmail").style.border = "";
    //   document.getElementById("headPhone").style.border = "";
    //   document.getElementById("headAddress").style.border = "";
    document.getElementById("captchaText").style.border = "";
    //resetting the values in the form
    // document.getElementById("email").value = "";
    // document.getElementById("cemail").value = ""; 
    document.getElementById("title").value = "-1";
    document.getElementById("firstName").value = "";
    document.getElementById("lastName").value = "";
    document.getElementById("qualification").value = "-1";
    document.getElementById("designation").value = "-1";
    document.getElementById("discipline").value = "-1";
    document.getElementById("stateInstitute").value = "-1";
    document.getElementById("cityInstitute").value = "-1";
    document.getElementById("institute").value = "-1";
    document.getElementById("instituteAddress").value = "";
    document.getElementById("pincodeInstitute").value = "";
    document.getElementById("homeAddress").value = "";
    document.getElementById("cityHome").value = "";
    document.getElementById("pincodeHome").value = "";
    document.getElementById("mobile").value = "";
    document.getElementById("phoneHome").value = "";
    var w = document.getElementsByTagName('input');
    for (var i = 0; i < w.length; i++) {
        if (w[i].type == 'radio') {
            w[i].checked = false;
        }
    }
    //   document.getElementById("headTitle").value = "";
    //  document.getElementById("headName").value = "";
    //  document.getElementById("headDesignation").value = "";
    //  document.getElementById("headEmail").value = "";
    //   document.getElementById("headPhone").value = "";
    //  document.getElementById("headAddress").value = "";
    document.getElementById("captchaText").value = "";
}

function validateChangePassForm() {
    var result = true;
    var value = 0;
    //getting form values
    var epassword = document.getElementById("epassword").value;
    var password = document.getElementById("password").value;
    var cpassword = document.getElementById("cpassword").value;
    //clearing the previous errors
    document.getElementById("epasswordError").style.display = "none";
    document.getElementById("passwordError").style.display = "none";
    document.getElementById("cpasswordError").style.display = "none";
    document.getElementById("epassword").style.border = "";
    document.getElementById("password").style.border = "";
    document.getElementById("cpassword").style.border = "";
    if ((epassword) == "" || !isStringInRange(epassword, 8, 15)) {
        borderRedError("epassword");
        document.getElementById("epasswordError").style.display = "inline";
        value++;
    }
    if ((password) == "" || !isStringInRange(password, 8, 15)) {
        borderRedError("password");
        document.getElementById("passwordError").style.display = "inline";
        value++;
    }
    if ((cpassword) == "" || !isStringInRange(cpassword, 8, 15)) {
        borderRedError("cpassword");
        document.getElementById("cpasswordError").style.display = "inline";
        value++;
    }
    if (!((password) == (cpassword))) {
        borderRedError("cpassword");
        document.getElementById("cpasswordError").style.display = "inline";
        value++;
    }
    if (value > 0) {
        return false;
    }
    return result;
}

function resetChangePassForm() {
    document.getElementById("epasswordError").style.display = "none";
    document.getElementById("passwordError").style.display = "none";
    document.getElementById("cpasswordError").style.display = "none";
    document.getElementById("epassword").style.border = "";
    document.getElementById("password").style.border = "";
    document.getElementById("cpassword").style.border = "";
    document.getElementById("epassword").value = "";
    document.getElementById("password").value = "";
    document.getElementById("cpassword").value = "";
}

function validateAccessAccountForm()
{
    //Variable declaration
    var result = true;
    var email = document.accessaccountForm.email.value;
    var captchaAnswer = document.accessaccountForm.captchaText.value;
    var capcheck = document.getElementById('capCheck').value;
    //trim all the form values
    email = alltrim(email);
    captchaAnswer = alltrim(captchaAnswer);

    //Validation of different fields
    if (!emailValidator(email)) {
        borderRedError("email");
        document.getElementById('emailError').style.display = "inline";
        result = false;
    }
    if (!isStringInRange(captchaAnswer, 7, 7)) {
        borderRedError("captchaText");
        document.getElementById('captchaError').style.display = "inline";
        result = false;
    }
    if (capcheck == "0") {
        borderRedError("captchaText");
        document.getElementById('captchaError').style.display = "inline";
        result = false;
    }
    return result;
}

function resetAccessAccountForm() {
    document.getElementById("email").value = "";
    document.getElementById("captchaText").value = "";
    document.getElementById("emailError").style.display = "none";
    document.getElementById("emailAvaliable").style.display = "none";
    document.getElementById("emailnotAvaliable").style.display = "none";
    document.getElementById("captchaError").style.display = "none";
    document.getElementById("email").style.border = "";
    document.getElementById("captchaText").style.border = "";
    document.getElementById('capCheck').value = 0;
}

function validateTempPasswordForm() {
    var result = true;
    var value = 0;
    //getting form values
    var password = document.getElementById("password").value;
    var cpassword = document.getElementById("cpassword").value;
    //clearing the previous errors
    document.getElementById("passwordError").style.display = "none";
    document.getElementById("cpasswordError").style.display = "none";
    document.getElementById("password").style.border = "";
    document.getElementById("cpassword").style.border = "";
    if ((password) == "" || !isStringInRange(password, 8, 15)) {
        borderRedError("password");
        document.getElementById("passwordError").style.display = "inline";
        value++;
    }
    if ((cpassword) == "" || !isStringInRange(cpassword, 8, 15)) {
        borderRedError("cpassword");
        document.getElementById("cpasswordError").style.display = "inline";
        value++;
    }
    if (!((password) == (cpassword))) {
        borderRedError("cpassword");
        document.getElementById("cpasswordError").style.display = "inline";
        value++;
    }
    if (value > 0) {
        return false;
    }
    return result;
}

function resetTempPassForm() {
    document.getElementById("passwordError").style.display = "none";
    document.getElementById("cpasswordError").style.display = "none";
    document.getElementById("password").style.border = "";
    document.getElementById("cpassword").style.border = "";
    document.getElementById("password").value = "";
    document.getElementById("cpassword").value = "";
}

function validateContactPage(contactUsForm) {
    var result = true;
    var name = document.getElementById("name").value;
    var email = document.getElementById("email").value;
    var message = document.getElementById("message").value;
    document.getElementById("nameError").style.display = "none";
    document.getElementById("emailError").style.display = "none";
    document.getElementById("messageError").style.display = "none";
    document.getElementById("name").style.border = "";
    document.getElementById("email").style.border = "";
    document.getElementById("message").style.border = "";
    //Validation of different fields
    if (!emailValidator(email)) {
        borderRedError("email");
        document.getElementById('emailError').style.display = "inline";
        result = false;
    }
    if (!isStringInRange(message, 5, 200) || !remarkValidator(message)) {
        borderRedError("message");
        document.getElementById('messageError').style.display = "inline";
        result = false;
    }
    if (!isStringInRange(name, 3, 40) || !isAlphabet(name)) {
        borderRedError("name");
        document.getElementById("nameError").style.display = "inline";
        result = false;
    }
    return result;
}

function resetContactUsPage() {
    document.getElementById("email").value = "";
    document.getElementById("name").value = "";
    document.getElementById("message").value = "";
    document.getElementById("emailError").style.display = "none";
    document.getElementById("nameError").style.display = "none";
    document.getElementById("messageError").style.display = "none";
    document.getElementById("email").style.border = "";
    document.getElementById("name").style.border = "";
    document.getElementById("message").style.border = "";
}

function validateUsername() {
    var result = true;
    document.getElementById("usernameError").style.display = "none";
    document.getElementById("username").style.border = "";
    var user = document.getElementById("username").value;
    if (alltrim(user) == "") {
        borderRedError("username");
        document.getElementById("usernameError").style.display = "inline";
        result = false;
    }
    return result;
}
function validatePassword() {
    var result = true;
    document.getElementById("passwordError").style.display = "none";
    document.getElementById("password").style.border = "";
    var password = document.getElementById("password").value;
    if (alltrim(password) == "") {
        borderRedError("password");
        document.getElementById("passwordError").style.display = "inline";
        result = false;
    }
    return result;
}


function trimstr(s)
{
    return s.replace(/^\s+|\s+$/g, '');
}

/* to check white space and remove  */
function alltrim(str)
{
    return str.replace(/^\s+|\s+$/g, '');
}


/*
 * isStringInRange() method is used to check that the given string is valid and
 * it's length is in a given range.
 * If given string is not null and it's length is in a given range return true otherwise false.
 * There are three parameters to this function namely str, minLength and maxLength.
 * This function returns a boolean value depending on the validity of the string.
 */
function isStringInRange(str, minLength, maxLength) {
    var result = false;
    str = alltrim(str);
    if (isStringValid(str)) {
        if (str.length >= minLength && str.length <= maxLength) {
            result = true;
        }
    }
    return result;
}

/*
 * isStringInRange() method is used to check that the given string is valid and
 * it's length is in a given range.
 * If given string is not null and it's length is in a given range return true otherwise false.
 * There are three parameters to this function namely str, minLength and maxLength.
 * This function returns a boolean value depending on the validity of the string.
 */
function isStringInRangeNew(str, minLength, maxLength) {
    var result = false;
    str = alltrim(str);
    if (isAlphabet(str)) {
        if (str.length >= minLength && str.length <= maxLength) {
            result = true;
        }
    }
    return result;
}


/*
 * isStringValid() method is used to check that the given string is not null and
 * it's length is in a given range.
 * If given string is not null and it's length is in a given range return true otherwise false.
 * It has one parameter, a string that is to be checked for validity.
 * it returns true or false depending on the validity of the string.
 */
function isStringValid(str) {
    var result = true;
    str = alltrim(str);
    if (str == "") {
        result = false;
    }
    return result;
}


/*
 * isStringCheck() method is used to check that the given string is not null and
 * it's length is in a given range.
 * If given string is not null and it's length is in a given range return true otherwise false.
 * It has one parameter, a string that is to be checked for validity.
 * it returns true or false depending on the validity of the string.
 */
function isStringCheck(str) {
    var result = false;
    var string = "^[a-zA-Z0-9\\- ]+$";
    str = alltrim(str);
    if (str == "") {
        result = false;
    }
    if (str.match(string)) {
        result = true;
    }
    return result;
}


function validateName(str) {
    var result = false;
    var dispNameExp = /^[a-zA-Z][a-zA-Z\. ]+$/;
    if (str.match(dispNameExp)) {
        var previous = str.charAt(0);
        var current;
        for (i = 1; i < str.length; i++) {
            current = str.charAt(i);
            if (previous == current && previous == ' ') {
                return false;
            }
            previous = current;
        }
        result = true;
    }
    if (str.match(dispNameExp)) {
        var previous = str.charAt(0);
        var current;
        for (i = 1; i < str.length; i++) {
            current = str.charAt(i);
            if (previous == current && previous == '.') {
                return false;
            }
            previous = current;
        }
        result = true;
    }
    return result;
}


function isAlphabet(str) {
    var result = false;
    var alphaExp = /^[a-zA-Z ]+$/;
    if (str.match(alphaExp)) {
        result = true;
    }
    return result;
}

function isNumber(num) {
    var result = false;
    var regexp = /^[7-9][0-9]*$/;
    if (num.match(regexp)) {
        result = true;
    }
    return result;
}

/* function to check valid Mobile Number */
function validateMobilenumber(mobilenumber)
{
    /* mobilenumber should be 10 digits (beginning 9/8/7) long (at most 11 if beginning 0) */
    var result = (mobilenumber != null) && (mobilenumber.length > 0) &&
            (((mobilenumber.length == 10) && (mobilenumber.match("^[7-9][0-9]*$") != null)) ||
                    ((mobilenumber.length == 11) && (mobilenumber.match("^[0][7-9][0-9]*$") != null)));
    return result;
}

function validatenumber(number)
{
    var result = false;
    if ((number != null) && (number.length <= 12) && (number.length >= 5) && (number.match("^[0-9]*$")))
        result = true;
    return result;
}

function validatestd(number)
{
    var result = false;
    if ((number != null) && (number.length <= 6) && (number.length >= 2) && (number.match("^[0-9]*$")))
        result = true;
    return result;
}

function validateURL(url)
{
    /* url should be at least 1 character long (at most 50) with alphabets and . */
    var result = false;

    if ((url != null) && (url.length >= 1) && (url.length <= 50) && (url.match("^[A-Za-z /\\-:_..]*$") != null)) {
        result = true;
    }
    return result;
}

function emailValidator(email) {
    var result = false;
    var emailExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
    if (email.match(emailExp)) {
        result = true;
    }
    return result;
}

function remarkValidator(remark) {
    var result = false;
    var remarkstr = /^[A-Za-z0-9 .\r\n\\/()&:',_;-]*$/;
    if (remark.match(remarkstr)) {
        result = true;
    }
    return result;
}

function showRequiredInfo(id) {
    lastId = id;
    document.getElementById(id).style.display = "inline";
}

function hideRequiredInfo() {
    document.getElementById(lastId).style.display = "none";
}

//call the function to display the border of the input red for error
function borderRedError(id) {
    document.getElementById(id).style.border = '1px solid red';
}

function validateAnnouncementForm() {
    var flag1 = true;
    document.getElementById("announcement_blankerr").style.display = "none";
    document.getElementById("link_blankerr").style.display = "none";
    document.getElementById("startdate_blankerr").style.display = "none";
    document.getElementById("enddate_blankerr").style.display = "none";
    document.getElementById("visible_blankerr").style.display = "none";
    var announcement = document.getElementById("announcementText").value.trim();
    var link = document.getElementById("link").value.trim();
    var startdate = document.getElementById("datepicker1").value.trim();
    var enddate = document.getElementById("datepicker2").value.trim();
    // var startdate = new Date(document.getElementById("datepicker1").value.trim());
    // var enddate = new Date(document.getElementById("datepicker2").value.trim());
    var ann_id = document.getElementById("announcement").value.trim();
    if (ann_id == '-1') {
        flag1 = false;
        alert('please select announcement')
    } else if (ann_id != '-1') {
        if (announcement == "" || announcement == null) {
            document.getElementById("announcement_blankerr").style.display = "inline";
            flag1 = false;
        }
        if (link == "" || link == null) {
            document.getElementById("link_blankerr").style.display = "inline";
            flag1 = false;
        }
        if (startdate == "" || startdate == null) {
            document.getElementById("startdate_blankerr").style.display = "inline";
            flag1 = false;
        }
        if (enddate == "" || enddate == null) {
            document.getElementById("enddate_blankerr").style.display = "inline";
            flag1 = false;
        }
        var res_flag = 0;
        if (!startdate == '' && !enddate == '') {
            res_flag = checkDate(startdate, enddate);
        }
        if (res_flag == 1) {
            flag1 = false;
            alert("end date should be greater then start date");
        }
        if (enddate < startdate) {
            //flag1 = false;
            // alert("end date should be greater then start date");
        }
        var location = document.getElementsByName("location");
        if (location[0].checked || location[1].checked) {
            document.getElementById("location_blankerr").style.display = "none";
        } else if (!location[0].checked && !location[1].checked) {
            document.getElementById("location_blankerr").style.display = "inline";
            flag1 = false;
        }

        var visible = document.getElementsByName("announcement.visible");
        if (visible[0].checked || visible[1].checked) {
            document.getElementById("visible_blankerr").style.display = "none";
        } else if (!visible[0].checked && !visible[1].checked) {
            document.getElementById("visible_blankerr").style.display = "inline";
            flag1 = false;
        }
    }
    return flag1;
}

function checkDate(startdate, enddate) {
    var startd = startdate.split("-");
    var endd = enddate.split("-");
    var flag = 0;
    var start_day = startd[0], start_month = startd[1], start_year = startd[2];
    var endd_day = endd[0], endd_month = endd[1], endd_year = endd[2];
    if (endd_year < start_year) {
        flag = 1;
    } else if (endd_year == start_year) {
        if (endd_month < start_month) {
            flag = 1;
        } else if (endd_month == start_month) {
            if (endd_day < start_day) {
                flag = 1;
            } /*else if (endd_day == start_day) {
             flag = 1;
             }*/
            else {
                flag = 2;
            }
        }
    }
    return flag;
}
function checkenddate() {
    var enddate = document.getElementById('datepicker4').value;
    var startdate = document.getElementById('datepicker3').value;
    if (enddate < startdate)
    {
        alert("enter an end date greater  than start date");
        document.getElementById('datepicker1').value = "";
    }

}

function checklastdatereg()
{
    var enddate = document.getElementById('datepicker2').value;
    var startdate = document.getElementById('datepicker1').value;
    if (enddate > startdate)
    {
        alert("enter last date of reg lesser  than start date");
        document.getElementById('datepicker2').value = ""
    }
}
function validateWorkshopForm(workshopForm) {
    //    validate workshop form    
    resetErrorAndBorderWorkshop();
    var value = 0;
    var workshopName = document.getElementById("workshopName").value;
    var sponsor = document.getElementById("sponsor").value;
    var categorycode1 = document.getElementById("categorycode1").checked;
    var categorycode2 = document.getElementById("categorycode2").checked;
    var categorycode3 = document.getElementById("categorycode3").checked;
    var categorycode4 = document.getElementById("categorycode4").checked;
    var categorycode5 = document.getElementById("categorycode5").checked;
    var workshopid = document.getElementById("workshopid").value;
    var workshopid1 = document.getElementById("workshopid1").value;
    var rescoid = document.getElementById("resCoWorkshopidInput").value;
    var author = document.getElementById("author").value;
    var durationvenue = document.getElementById("durationvenue").value;
    var coursefee = document.getElementById("coursefee").value;
    var introduction = document.getElementById("introduction").value;
    var objectives = document.getElementById("objectives").value;
    var teachingfaculty = document.getElementById("teachingfaculty").value;
    var whoshouldattend = document.getElementById("whoshouldattend").value;
    var note = document.getElementById("note").value;
    var accommodation = document.getElementById("accomodation").value;
    var howtoapply = document.getElementById("howtoapply").value;
    var contact = document.getElementById("contact").value;
    var coursewarestatus1 = document.getElementById("coursewarestatus1").checked;
    var coursewarestatus2 = document.getElementById("coursewarestatus2").checked;
    // var certificatepath = document.getElementById("certificatepath").value;
    var resourcepath = document.getElementById("resourcepath").value;
    var announcement = document.getElementById("announcement").value;

    var startregdate2 = (document.getElementById('datepicker1').value);
    var lastregdate2 = (document.getElementById('datepicker2').value);
    var startdate2 = (document.getElementById('datepicker3').value);
    var enddate2 = (document.getElementById('datepicker4').value);
    var startregdate1 = (document.getElementById('datepicker1').value).split("-");
    var lastregdate1 = (document.getElementById('datepicker2').value).split("-");
    var startdate1 = (document.getElementById('datepicker3').value).split("-");
    var enddate1 = (document.getElementById('datepicker4').value).split("-");

    var startregdate = new Date(startregdate1[2], startregdate1[1], startregdate1[0]);
    var lastregdate = new Date(lastregdate1[2], lastregdate1[1], lastregdate1[0]);
    var startdate = new Date(startdate1[2], startdate1[1], startdate1[0]);
    var enddate = new Date(enddate1[2], enddate1[1], enddate1[0]);

    var lms1 = document.getElementById("lms1").checked;
    var lms2 = document.getElementById("lms2").checked;

    var certificategroup1 = document.getElementById("certificategroup1").checked;
    var certificategroup2 = document.getElementById("certificategroup2").checked;

    var resCoWorkshopidInput = document.getElementById("resCoWorkshopidInput").value;

    var instructions = document.getElementById("instructions").value;
    var certificateCriteria = document.getElementById("certificateCriteria").value;

    var maincc1 = document.getElementById("maincc1").checked;
    var maincc2 = document.getElementById("maincc2").checked;
    var maincc3 = document.getElementById("maincc3").checked;

    var ifNewWorkshop = document.getElementById("selectWorkshop").value;

    if (categorycode1 == true && ifNewWorkshop == "newWorkshop") {
        if ((maincc1 || maincc2 || maincc3) == false) {
            document.getElementById("mainccError").style.display = "inline";
            value++;
        }
    }

    if (resCoWorkshopidInput == "") {
        borderRedError("resCoWorkshopidInput");
        document.getElementById("resCoWorkshopidError").style.display = "inline";
        value++;
    }
    if (instructions == "") {
        borderRedError("instructions");
        document.getElementById("instructionsError").style.display = "inline";
        value++;
    }
    if (certificateCriteria == "") {
        borderRedError("certificateCriteria");
        document.getElementById("certificateCriteriaError").style.display = "inline";
        value++;
    }
    if (workshopName == "") {
        borderRedError("workshopName");
        document.getElementById("workshopNameError").style.display = "inline";
        value++;
    }

    if (sponsor == "") {
        borderRedError("sponsor");
        document.getElementById("sponsorError").style.display = "inline";
        value++;
    }
    if ((categorycode1 || categorycode2 || categorycode3 || categorycode4 || categorycode5) == false) {
        document.getElementById("categoryError").style.display = "inline";
        value++;
    }
    if (workshopid1 == "") {
        borderRedError("workshopid");
        document.getElementById("workshopidError").style.display = "inline";
        value++;
    }

    if (document.getElementById("categorycode2").checked) {
        if (rescoid == "") {
            borderRedError("resCoWorkshopidInput");
            document.getElementById("resCoWorkshopidError").style.display = "inline";
            value++;
        }
    }
    if (author == "") {
        borderRedError("author");
        document.getElementById("authorError").style.display = "inline";
        value++;
    }

    if (durationvenue == "") {
        borderRedError("durationvenue");
        document.getElementById("durationvenueError").style.display = "inline";
        value++;
    }
    if (coursefee == "") {
        borderRedError("coursefee");
        document.getElementById("coursefeeError").style.display = "inline";
        value++;
    }
    if (introduction == "") {
        borderRedError("introduction");
        document.getElementById("introductionError").style.display = "inline";
        value++;
    }
    if (objectives == "") {
        borderRedError("objectives");
        document.getElementById("objectivesError").style.display = "inline";
        value++;
    }

    if (teachingfaculty == "") {
        borderRedError("teachingfaculty");
        document.getElementById("teachingfacultyError").style.display = "inline";
        value++;
    }
    if (whoshouldattend == "") {
        borderRedError("whoshouldattend");
        document.getElementById("whoshouldattendError").style.display = "inline";
        value++;
    }
    if (note == "") {
        borderRedError("note");
        document.getElementById("noteError").style.display = "inline";
        value++;
    }
    if (accommodation == "") {
        borderRedError("accomodation");
        document.getElementById("accomodationError").style.display = "inline";
        value++;
    }
    if (howtoapply == "") {
        borderRedError("howtoapply");
        document.getElementById("howtoapplyError").style.display = "inline";
        value++;
    }

    if (contact == "") {
        borderRedError("contact");
        document.getElementById("contactError").style.display = "inline";
        value++;
    }
    if ((coursewarestatus1 || coursewarestatus2) == false) {
        document.getElementById("coursewarestatusError").style.display = "inline";
        value++;
    }
    //    if (certificatepath == "") {
    //        borderRedError("certificatepath");
    //        document.getElementById("certificatepathError").style.display = "inline";
    //        value++;
    //    }
    //    if(resourcepath=="" ){
    //        borderRedError("resourcepath");
    //        document.getElementById("resourcepathError").style.display = "inline";
    //        value++;
    //    }
    if (announcement == "") {
        borderRedError("announcement");
        document.getElementById("announcementError").style.display = "inline";
        value++;
    }

    if (startregdate2.toString() == "") {
        borderRedError("datepicker1");
        document.getElementById("regstartdateError").style.display = "inline";
        value++;
    }
    if (lastregdate2.toString() == "") {
        borderRedError("datepicker2");
        document.getElementById("reglastdateError").style.display = "inline";
        value++;
    }
    if (startdate2 == "") {
        borderRedError("datepicker3");
        document.getElementById("startdateError").style.display = "inline";
        value++;
    }
    if (enddate2 == "") {
        borderRedError("datepicker4");
        document.getElementById("enddateError").style.display = "inline";
        value++;
    }

    //        if((accommodation1  || accommodation2)==false){  
    //        document.getElementById("accommodationError").style.display = "inline";
    //        value++;
    //    }
    //    if(permissionIfRequired=="-1"){
    //        borderRedError("permissionIfRequired");
    //        document.getElementById("permissionIfRequiredError").style.display = "inline";
    //        value++; 
    //    }


    if (startregdate > lastregdate)
    {
        alert("Enter Last Date of Application greater than Start Date of Application");
        document.getElementById('datepicker2').value = "";
        document.getElementById("reglastdateError").style.display = "inline";
        value++;
    }
    if (enddate < startdate)
    {
//        alert("Enter an End Date greater than Start Date");
        document.getElementById('datepicker4').value = "";
        document.getElementById("enddateError").style.display = "inline";
        value++;
    }
    if (lastregdate >= startdate)
    {
        var val = confirm("Warning : The Last Date of Registration is greater than the Start Date of the Workshop");
        //        document.getElementById('datepicker2').value = "";
        //        document.getElementById("reglastdateError").style.display = "inline";
        if (val == true) {
        } else
            value++;
    }

    if ((lms1 || lms2) == false) {
        document.getElementById("lmsError").style.display = "inline";
        value++;
    }

    if ((certificategroup1 || certificategroup2) == false) {
        document.getElementById("certificateGroupError").style.display = "inline";
        value++;
    }

    if (document.getElementById("categorycode5").checked) {
        var feepay = document.getElementById("feeAmount").value.trim();
        if (feepay == '' || feepay == '0') {
            document.getElementById("feeAmount").style.border = 'red';
            document.getElementById("feeAmountError").style.display = "inline";
            value++;
        }
        if (feepay.split('.').length > 2) {
            document.getElementById("feeAmount").style.border = 'red';
            document.getElementById("feeAmountError").style.display = "inline";
            value++;
        }
        var firstNum = feepay.substring(0, 1);
        if (firstNum == '0') {
            document.getElementById("feeAmount").style.border = 'red';
            document.getElementById("feeAmountError").style.display = "inline";
            value++;
        }
    }
    if (document.getElementById("categorycode1").checked && document.getElementById("maincc3").checked) {
//        var feepay = document.getElementById("feeAmount").value.trim();
//        if (feepay == '' || feepay == '0') {
//            document.getElementById("feeAmount").style.border = 'red';
//            document.getElementById("feeAmountError").style.display = "inline";
//            value++;
//        }
//        if (feepay.split('.').length > 2) {
//            document.getElementById("feeAmount").style.border = 'red';
//            document.getElementById("feeAmountError").style.display = "inline";
//            value++;
//        }
//        var firstNum = feepay.substring(0, 1);
//        if (firstNum == '0') {
//            document.getElementById("feeAmount").style.border = 'red';
//            document.getElementById("feeAmountError").style.display = "inline";
//            value++;
//        }
    }

    var x = document.getElementById("permissionLetter");
    if (value > 0)
    {
        scrollWin();
        return false;
    } else
    {
        return true;
    }

}
function resetWorkshopManageform() {
    //resetting values in the form
    document.getElementById("workshopName").value = "";
    document.getElementById("sponsor").value = "";
    document.getElementById("categorycode1").checked = false;
    document.getElementById("categorycode2").checked = false;
    document.getElementById("categorycode3").checked = false;
    document.getElementById("categorycode4").checked = false;
    document.getElementById("categorycode5").checked = false;
    document.getElementById("workshopid").value = "";
    document.getElementById("workshopid1").value = "";
    document.getElementById("resCoWorkshopidInput").value = "";
    document.getElementById("author").value = "";
    document.getElementById("durationvenue").value = "";
    document.getElementById("coursefee").value = "";
    document.getElementById("introduction").value = "";
    document.getElementById("objectives").value = "";
    document.getElementById("teachingfaculty").value = "";
    document.getElementById("whoshouldattend").value = "";
    document.getElementById("note").value = "";
    document.getElementById("accomodation").value = "";
    document.getElementById("howtoapply").value = "";
    document.getElementById("contact").value = "";
    document.getElementById("datepicker1").value = "";
    document.getElementById("datepicker2").value = "";
    document.getElementById("datepicker3").value = "";
    document.getElementById("datepicker4").value = "";
    document.getElementById("coursewarestatus1").checked = false;
    document.getElementById("coursewarestatus2").checked = false;
    //document.getElementById("certificatepath").value = "";
    document.getElementById("resourcepath").value = "";
    document.getElementById("announcement").value = "";
    //    document.getElementById("accommodation1").checked = false;    
    //    document.getElementById("accommodation2").checked = false;
    //    document.getElementById("permissionIfRequired").value = "-1";
    document.getElementById("permissionLetterPath").innerHTML = "";
    document.getElementById("brochurePath").innerHTML = "";
    document.getElementById("eligibilityPath").innerHTML = "";
    document.getElementById("mailcontentPath").innerHTML = "";
    document.getElementById("resCoWorkshopid").style.display = "none";
    document.getElementById("lms1").checked = false;
    document.getElementById("lms2").checked = false;
    document.getElementById("certificategroup1").checked = false;
    document.getElementById("certificategroup2").checked = false;

    document.getElementById("certificateCriteria").value = "";
    document.getElementById("instructions").value = "";
    document.getElementById("maincc1").checked = false;
    document.getElementById("maincc2").checked = false;
    document.getElementById("maincc3").checked = false;
    document.getElementById("feeAmount").value = "";


    // resetting all the payment mode
    document.getElementById("payment_div").style.display = "none";
    document.getElementById("without_rc_div").style.display = "none";
    document.getElementById("payment_mode_1").checked = false;
    document.getElementById("payment_mode_2").checked = false;

    document.getElementById("without_RC1").checked = false;
    document.getElementById("without_RC2").checked = false;

    document.getElementById("withdrawal_div").style.display = "none";
    document.getElementById("withdraw1").checked = false;
    document.getElementById("withdraw2").checked = true;

    document.getElementById("resMWToBeCreated").style.display = "none";

    resetErrorAndBorderWorkshop();
}


function resetErrorAndBorderWorkshop() {
    //resetting error messages
    document.getElementById("sponsorError").style.display = "none";
    document.getElementById("categoryError").style.display = "none";
    document.getElementById("workshopidError").style.display = "none";
    document.getElementById("workshopNameError").style.display = "none";
    document.getElementById("resCoWorkshopidError").style.display = "none";
    document.getElementById('authorError').style.display = "none";
    document.getElementById('durationvenueError').style.display = "none";
    document.getElementById('coursefeeError').style.display = "none";
    document.getElementById('introductionError').style.display = "none";
    document.getElementById('objectivesError').style.display = "none";
    document.getElementById('teachingfacultyError').style.display = "none";
    document.getElementById('whoshouldattendError').style.display = "none";
    document.getElementById('noteError').style.display = "none";
    document.getElementById('accomodationError').style.display = "none";
    document.getElementById('howtoapplyError').style.display = "none";
    document.getElementById('contactError').style.display = "none";
    document.getElementById('coursewarestatusError').style.display = "none";
    //document.getElementById('certificatepathError').style.display = "none";
    document.getElementById('resourcepathError').style.display = "none";
    //    document.getElementById('homePincodeError').style.display = "none";
    document.getElementById('announcementError').style.display = "none";
    document.getElementById('regstartdateError').style.display = "none";
    document.getElementById('reglastdateError').style.display = "none";
    document.getElementById('startdateError').style.display = "none";
    document.getElementById('enddateError').style.display = "none";
    //    document.getElementById("accommodationError").style.display = "none";
    //    document.getElementById("permissionIfRequiredError").style.display = "none";
    document.getElementById("lmsError").style.display = "none";
    document.getElementById("certificateGroupError").style.display = "none";
    document.getElementById("instructionsError").style.display = "none";
    document.getElementById("certificateCriteriaError").style.display = "none";
    document.getElementById("mainccError").style.display = "none";
    document.getElementById("feeAmountError").style.display = "none";
    // resetting borders
    //    document.getElementById("workshopName").style.border = "";
    document.getElementById("sponsor").style.border = "";
    document.getElementById("workshopid").style.border = "";
    document.getElementById("workshopName").style.border = "";
    document.getElementById("resCoWorkshopidInput").style.border = "";
    document.getElementById("author").style.border = "";
    document.getElementById("durationvenue").style.border = "";
    document.getElementById("coursefee").style.border = "";
    document.getElementById("introduction").style.border = "";
    document.getElementById("objectives").style.border = "";
    document.getElementById("teachingfaculty").style.border = "";
    document.getElementById("whoshouldattend").style.border = "";
    document.getElementById("note").style.border = "";
    document.getElementById("accomodation").style.border = "";
    document.getElementById("howtoapply").style.border = "";
    document.getElementById("contact").style.border = "";
    //document.getElementById("certificatepath").style.border = "";
    document.getElementById("resourcepath").style.border = "";
    document.getElementById("announcement").style.border = "";
    document.getElementById("datepicker1").style.border = "";
    document.getElementById("datepicker2").style.border = "";
    document.getElementById("datepicker3").style.border = "";
    document.getElementById("datepicker4").style.border = "";
    //    document.getElementById("permissionIfRequired").style.border = "";
    document.getElementById("instructions").style.border = "";
    document.getElementById("certificateCriteria").style.border = "";

}
function validateRCCDetails() {
    var flag1 = true;
    document.getElementById("workshopid").style.border = '';
    document.getElementById("rcid").style.border = '';
    document.getElementById("avaseats").style.border = '';
    document.getElementById("avaccom").style.border = '';
    var workshopid = document.getElementById("workshopid").value;
    var rcid = document.getElementById("rcid").value;
    var avaseats = document.getElementById("avaseats").value;
    var avaccom = document.getElementById("avaccom").value;

    var cc = document.getElementById("cc").value;

    if (cc == 7) {
        document.getElementById("acco_cost").style.border = '';
        document.getElementById("food_cost").style.border = '';
        document.getElementById("acco_costBlank").style.display = "none";
        document.getElementById("food_costBlank").style.display = "none";
        var acco_cost = document.getElementById("acco_cost").value;
        var food_cost = document.getElementById("food_cost").value;
        if (acco_cost == '' || acco_cost == null) {
            flag1 = false;
            document.getElementById("acco_costBlank").style.display = "inline";
            document.getElementById("acco_cost").style.border.color = 'red';
        }
        if (food_cost == '' || food_cost == null) {
            flag1 = false;
            document.getElementById("food_costBlank").style.display = "inline";
            document.getElementById("food_cost").style.border.color = 'red';
        }
    }
    document.getElementById("widBlank").style.display = "none";
    document.getElementById("rcidBlank").style.display = "none";
    document.getElementById("aseatsBlank").style.display = "none";
    document.getElementById("accomBlank").style.display = "none";

    if (workshopid == '' || workshopid == null) {
        flag1 = false;
        document.getElementById("widBlank").style.display = "inline";
        document.getElementById("workshopid").style.border.color = 'red';
    }
    if (rcid == '' || rcid == null) {
        flag1 = false;
        document.getElementById("rcidBlank").style.display = "inline";
        document.getElementById("rcid").style.border.color = 'red';
    }
    if (avaseats == '' || avaseats == null) {
        flag1 = false;
        document.getElementById("aseatsBlank").style.display = "inline";
        document.getElementById("avaseats").style.border.color = 'red';
    }
    if (avaccom == '' || avaccom == null) {
        flag1 = false;
        document.getElementById("accomBlank").style.display = "inline";
        document.getElementById("avaccom").style.border.color = 'red';
    }
    flag1 == false;
    return flag1;
}
function validateWRForm(WRForm) {
    var value = 0;
    clearWRFormErrorsAndBorder();

    if (WRForm.without_RC == 0) {
        var state = document.getElementById("state").value;
        var rc = document.getElementById("remotecenter").value;
        var rcid = document.getElementById("rcid").value;
        var acc1 = document.getElementById("acco1").checked;
        var acc2 = document.getElementById("acco2").checked;
    }
    // for checking if institute is a rc
    var categorycode = WRForm.categorycode.value;
    var permission_ifreq = WRForm.permission_ifreq.value;
    var resCoWorkshopid = WRForm.resCoWorkshopid.value;
    var accommodation = WRForm.accommodation.value;
    var terms = WRForm.termsAndConditions.checked;
    var facultyStatus = WRForm.facultyStatus.value;

    var terms1 = WRForm.termsAndConditions1.checked;

    if (categorycode == 4 && resCoWorkshopid > 0) {
        document.getElementById("ifrcError").style.display = "";
    }
    if (permission_ifreq == 1) {
        document.getElementById("permissionLetter").style.border = "";
        document.getElementById("permissionLetterError").style.display = "";
    }

    if (permission_ifreq == 1) {
        if (categorycode == 8) {
            if (facultyStatus == 1) {
                var checkVal = document.getElementById("facultycheck").checked;
                //var checkVal2 = document.getElementById("facultyCertcheck").checked
                var isfacultycertcheckY = document.getElementById('facultyCertCheckYes').checked;
                var isfacultycertcheckN = document.getElementById('facultyCertCheckNo').checked;
                document.getElementById("facultyCertCheckError").style.display = "none";
                if (isfacultycertcheckY == false && isfacultycertcheckN == false) {
                    document.getElementById("facultyCertCheckError").style.display = "inline";
                    value++;
                }
                //if (checkVal == true && checkVal2 == true) {
                if (checkVal == true && isfacultycertcheckY == true) {
                    var permissionLetter = WRForm.permissionLetter.value;
                    if (!(permissionLetter == "" || permissionLetter == null)) {
                        var size = WRForm.permissionLetter.files[0].size;
                        var val = validateLetter(permissionLetter);
                        var val1 = checkFileSize(size, 262144);
                        if (val == false || val1 == false) {
                            borderRedError("permissionLetter");
                            document.getElementById("permissionLetterError").style.display = "inline";
                            value++;
                        }
                    } else {
                        borderRedError("permissionLetter");
                        document.getElementById("permissionLetterError").style.display = "inline";
                        value++;
                    }
                } else {
                    // do nothing 
                }
            }
        } else {
            var permissionLetter = WRForm.permissionLetter.value;
            if (!(permissionLetter == "" || permissionLetter == null)) {
                var size = WRForm.permissionLetter.files[0].size;
                var val = validateLetter(permissionLetter);
                var val1 = checkFileSize(size, 262144);
                if (val == false || val1 == false) {
                    borderRedError("permissionLetter");
                    document.getElementById("permissionLetterError").style.display = "inline";
                    value++;
                }
            } else {
                borderRedError("permissionLetter");
                document.getElementById("permissionLetterError").style.display = "inline";
                value++;
            }
        }
    }

    if (categorycode == 4 && resCoWorkshopid > 0) {
        var ifrc1 = document.getElementById("ifrc1").checked;
        var ifrc2 = document.getElementById("ifrc2").checked;
        if (!(ifrc1 || ifrc2))
        {
            document.getElementById("ifrcError").style.display = "inline";
            value++;
        }
    }


    var ins_name = document.getElementById("ins_name_hidden").value;


    if (facultyStatus == 0) {
        // institute needn't be checked for participants who aren't faculty.
        if (ins_name == "" || ins_name == null) {
            document.getElementById('instituteError').style.display = "inline";
            value++;
        }
    } else {
        if (ins_name == "" || ins_name == null) {
            document.getElementById('instituteError').style.display = "inline";
            value++;
        }
    }

    if (WRForm.without_RC == 0) {
        if (state == "" || state == null || state == "-1")
        {
            borderRedError("state");
            document.getElementById('stateError').style.display = "inline";
            value++;
        }
        if (rc == "" || rc == null || rc == "-1") {

            borderRedError("remotecenter");
            document.getElementById("remotecenterError").style.display = "inline";
            value++;
        }
        if (rcid == "" || rcid == null) {

            borderRedError("rcid");
            document.getElementById("remotecenterIdError").style.display = "inline";
            value++;
        }
        if (accommodation == 1) {
            if (!(acc1 || acc2))
            {
                document.getElementById("accomodationError").style.display = "inline";
                value++;
            }
        }
    }

    if (!terms)
    {
        document.getElementById("termsError").style.display = "inline";
        value++;
    }
    if (!terms1)

    {
        document.getElementById("termsError1").style.display = "inline";
        value++;
    }
    if (value > 0) {
        return false;
    } else {
        return true;
    }
}
function clearWRFormErrorsAndBorder() {
    //clearing border
    var without_RC = document.getElementById('without_RC').value;
    if (without_RC == 0) {
        document.getElementById("state").style.border = "";
        document.getElementById("remotecenter").style.border = "";
        document.getElementById("rcid").style.border = "";
        document.getElementById("stateError").style.display = "";
        document.getElementById("remotecenterError").style.display = "";
        document.getElementById("remotecenterIdError").style.display = "";
        document.getElementById("accomodationError").style.display = "";
    }
    document.getElementById("instituteError").style.display = "";
    document.getElementById("permissionLetter").style.border = "";
    document.getElementById("permissionLetterError").style.display = "";
    document.getElementById("termsError").style.display = "";
    document.getElementById("termsError1").style.display = "";
}
function resetWRForm() {
    clearWRFormErrorsAndBorder();

    var without_RC = document.getElementById("without_RC").value;

    if (without_RC == 0) {
        document.getElementById('state').value = "-1";
        var x = document.getElementById("remotecenter");
        for (var i = x.length; i > 0; i--) {
            x.remove(i);
        }
        document.getElementById("remotecenter").value = "-1";
        document.getElementById("rcid").value = "";
        document.getElementById("stateID").value = "-1";
        document.getElementById("acco1").checked = false;
        document.getElementById("acco2").checked = false;
        document.getElementById("ifrcError").style.display = "";
    }
    document.getElementById("permissionLetter").value = "";
}
// update workshop registration form validate
function validateWRForm2(WRUForm) {
    var value = 0;
    clearWRFormErrorsAndBorder2(WRUForm);
    if (WRUForm.without_RC == 0) {
        var state = document.getElementById('state').value;
        var rc = document.getElementById('remotecenter').value;
        var rcid = document.getElementById('rcid').value;
        var acc1 = document.getElementById('acco1').checked;
        var acc2 = document.getElementById('acco2').checked;

        if (cc == 5) {
            if (state == "" || state == null || state == "-1")
            {
                borderRedError("state");
                document.getElementById('stateError').style.display = "inline";
                value++;
            }
            if (rc == "" || rc == null || rc == "-1") {

                borderRedError("remotecenter");
                document.getElementById("remotecenterError").style.display = "inline";
                value++;
            }
            if (rcid == "" || rcid == null) {

                borderRedError("rcid");
                document.getElementById("remotecenterIdError").style.display = "inline";
                value++;
            }
        }
        if (!(acc1 || acc2))
        {
            document.getElementById("accomodationError").style.display = "inline";
            value++;
        }
    }

    var permissionLetter = WRUForm.permissionLetter.value;

    var cc = document.getElementById('categorycode').value;
    var facultyStatus = WRUForm.facultyStatus.value;
    var terms = WRUForm.termsAndConditions.checked;

    if (cc == 8) {
        if (facultyStatus == 1) {
            var checkVal = document.getElementById("facultycheck").checked;
            //var checkVal2 = document.getElementById("facultyCertcheck").checked
            var isfacultycertcheckY = document.getElementById('facultyCertCheckYes').checked;
            var isfacultycertcheckN = document.getElementById('facultyCertCheckNo').checked;
            document.getElementById("facultyCertCheckError").style.display = "none";
            if (isfacultycertcheckY == false && isfacultycertcheckN == false) {
                document.getElementById("facultyCertCheckError").style.display = "inline";
                value++;
            }
            //if (checkVal == true && checkVal2 == true) {
            if (checkVal == true && isfacultycertcheckY == true) {
                var permissionLetter = WRUForm.permissionLetter.value;
                if (!(permissionLetter == "" || permissionLetter == null)) {
                    var size = WRUForm.permissionLetter.files[0].size;
                    var val = validateLetter(permissionLetter);
                    var val1 = checkFileSize(size, 262144);
                    if (val == false || val1 == false) {
                        borderRedError("permissionLetter");
                        document.getElementById("permissionLetterError").style.display = "inline";
                        value++;
                    }
                } else {
                    borderRedError("permissionLetter");
                    document.getElementById("permissionLetterError").style.display = "inline";
                    value++;
                }
            } else {
                // do nothing 
            }
        }
    } else {
        if (!(permissionLetter == "" || permissionLetter == null)) {
            var size = WRUForm.permissionLetter.files[0].size;
            var val = validateLetter(permissionLetter);
            var val1 = checkFileSize(size, 262144);
            if (val == false || val1 == false) {
                borderRedError("permissionLetter");
                document.getElementById("permissionLetterError").style.display = "inline";
                value++;
            }
        } else {
            borderRedError("permissionLetter");
            document.getElementById("permissionLetterError").style.display = "inline";
            value++;
        }
    }

    if (!terms)
    {
        document.getElementById("termsError").style.display = "inline";
        value++;
    }
    if (value > 0) {
        return false;
    } else {
        return true;
    }

}
function clearWRFormErrorsAndBorder2(WRUForm) {
    //clearing border

    if (WRUForm.without_RC == 0) {
        document.getElementById('state').style.border = "";
        document.getElementById('remotecenter').style.border = "";
        document.getElementById("rcid").style.border = "";
        document.getElementById('accomodationError').style.display = "";

        var cc = document.getElementById('categorycode').value;
        if (cc == 5) {
            document.getElementById('stateError').style.display = "";
            document.getElementById('remotecenterError').style.display = "";
            document.getElementById('remotecenterIdError').style.display = "";
        }
    }
    document.getElementById('permissionLetterError').style.display = "";

    document.getElementById('permissionLetter').style.border = "";



}
function resetWRForm2() {
    clearWRFormErrorsAndBorder2();

    var without_RC = document.getElementById("without_RC").value;

    if (without_RC == 0) {
        document.getElementById("acco1").checked = false;
        document.getElementById("acco2").checked = false;
        document.getElementById('state').value = "-1";
        var x = document.getElementById("remotecenter");
        for (var i = x.length; i > 0; i--) {
            x.remove(i);
        }
        document.getElementById("stateID").value = "-1";
        document.getElementById("remotecenter").value = "-1";
    }
    var cc = document.getElementById('categorycode').value;
    if (cc == 5) {
        document.getElementById("rcid").value = "";
    }
    document.getElementById("permissionLetter").value = "";
}
function resetWRForm_ExceptPermissionLetter() {
    clearWRFormErrorsAndBorder();
    document.getElementById("state").value = "-1";
    var x = document.getElementById("remotecenter");
    for (var i = x.length; i > 0; i--) {
        x.remove(i);
    }
    document.getElementById("remotecenter").value = "-1";
    document.getElementById("stateID").value = "-1";
    document.getElementById("rcid").value = "";
    document.getElementById("acco1").checked = false;
    document.getElementById("acco2").checked = false;
}

function validateLetter(letter, size)
{
    var result = false;
    var filext = (getExt(letter)).toLowerCase();
    result = ((letter != null) && (letter != "") && (filext == "jpeg" || filext == "jpg"));
    return result;
}
function getExt(filename) {
    var dot_pos = filename.lastIndexOf(".");
    if (dot_pos == -1)
        return "";
    return filename.substr(dot_pos + 1).toLowerCase();
}
function checkFileSize(size, requiredSize) {
    var result = false;
    if (size != 0 && size <= requiredSize) {
        result = true;
    }
    return result;
}

/**
 * This function will check if contact number is 
 * match with mobile number 
 * if both number are same then only displaying
 * alert
 * @returns {undefined}
 */
function checkPhoneNumber() {
    var mobile = document.getElementById("mobile").value.trim();
    var contact = document.getElementById("phoneHome").value.trim();
    if (mobile.length != 0 && contact.length != 0) {
        var firstNum = mobile.charAt(0);
        var changeNum;
        if (firstNum != 0) {
            changeNum = '0' + mobile;
        } else if (firstNum == 0) {
            changeNum = mobile;
        }
        if (changeNum == contact) {
            alert("Contact Number Should not same as Mobile Number");
        }
    }
}

function checkPhoneNumber1() {
    var res = false;
    var mobile = document.getElementById("mobile").value.trim();
    var contact = document.getElementById("phoneHome").value.trim();
    var firstNum = mobile.charAt(0);
    var changeNum;
    if (firstNum != 0) {
        changeNum = '0' + mobile;
    } else if (firstNum == 0) {
        changeNum = mobile;
    }
    if (changeNum == contact) {
        res = false;
    } else if (changeNum != contact) {
        res = true;
    }
    return res;
}

/**
 * this metod will check the given string has 
 * alphabates,period, space then it will return true
 * else it will return false and also chekcing for
 * sequence of dot
 * @param {type} str
 * @returns {Boolean}
 */
function validateLastName(str) {
    var result = false;
    var alphaExp = /^[a-zA-Z. ]+$/;
    if (str.match(alphaExp)) {
        result = true;
    }
    if (str.match(alphaExp)) {
        var previous = str.charAt(0);
        if (previous == '.') {
            result = false;
        }
        var current;
        for (i = 1; i < str.length; i++) {
            current = str.charAt(i);
            if (previous == current && previous == '.') {
                return false;
            }
            previous = current;
        }
        result = true;
    }
    return result;
}

function checkZero()
{
    var headphone = document.getElementById("headPhone").value;
    var homephone = document.getElementById("phoneHome").value;
    var firstNum = headphone.charAt(0);
    var firstNum2 = homephone.charAt(0);
    if (firstNum != 0) {
        headphone = '0' + headphone;
    } else if (firstNum == 0) {
        headphone = headphone;
    }

    if (firstNum2 != 0) {
        homephone = '0' + homephone;
    } else if (firstNum2 == 0) {
        homephone = homephone;
    }
    var Hephone = document.getElementById("headPhone");
    var Hphone = document.getElementById("phoneHome");
    Hephone.value = headphone;
    Hphone.value = homephone;
}

/**
 * These method will check the enter string
 * can accept only alphabates, number, hypen
 * and also checking minimum and maximum length
 * of string
 * @param {type} str
 * @param {type} minLength
 * @param {type} maxLength
 * @returns {Boolean}
 */
function validateCityHome(str, minLength, maxLength) {
    var result = false;
    var alphaExp = /^[a-zA-Z0-9- ]+$/;
    if (str.match(alphaExp)) {
        if (str.length >= minLength && str.length <= maxLength) {
            result = true;
        }
    }
    return result;
}


function resetInstituteDetails() {
    document.getElementById("other").value = "";
    document.getElementById("instituteAddress").value = "";
    document.getElementById("pincodeInstitute").value = "";
    document.getElementById("headName").value = "";
    document.getElementById("headEmail").value = "";
    document.getElementById("headPhone").value = "";
    document.getElementById("headAddress").value = "";
    document.getElementById("headTitle").value = "-1";
    document.getElementById("headDesignation").value = "-1";
    //allowing for edit
    document.getElementById("headTitle").disabled = false;
    document.getElementById("headDesignation").disabled = false;
    document.getElementById("instituteAddress").readOnly = false;
    document.getElementById("pincodeInstitute").readOnly = false;
    document.getElementById("headName").readOnly = false;
    document.getElementById("headEmail").readOnly = false;
    document.getElementById("headPhone").readOnly = false;
    document.getElementById("headAddress").readOnly = false;
}

function validateEditDetailsPage(wrform) {
    var result = true;
    var value = 0;
    //getting form values
    var facultyStatus = document.getElementById("facultyStatus").value;
    var email = alltrim(document.getElementById("email").value.toLowerCase());
    //var cemail = alltrim(document.getElementById("cemail").value.toLowerCase());
    var title = alltrim(document.getElementById("title").value);
    var firstName = alltrim(document.getElementById("firstName").value);
    var lastName = alltrim(document.getElementById("lastName").value);
    var qualification = alltrim(document.getElementById("qualification").value);
    if (facultyStatus == 1) {
        var designation = alltrim(document.getElementById("designation").value);
        var experience = $('input[id=experience]:checked').val();
        var stateInstitute = alltrim(document.getElementById("stateInstitute").value);
        var cityInstitute = alltrim(document.getElementById("cityInstitute").value);
        var institute = alltrim(document.getElementById("institute").value);
        document.getElementById('designationError').style.display = "none";
        document.getElementById('experienceError').style.display = "none";

    }
    var discipline = alltrim(document.getElementById("discipline").value);
    var instituteAddress = alltrim(document.getElementById("instituteAddress").value);
    var pincodeInstitute = alltrim(document.getElementById("pincodeInstitute").value);
    var homeAddress = alltrim(document.getElementById("homeAddress").value);
    var cityHome = alltrim(document.getElementById("cityHome").value);
    var pincodeHome = alltrim(document.getElementById("pincodeHome").value);
    var mobile = alltrim(document.getElementById("mobile").value);
    var phoneHome = alltrim(document.getElementById("phoneHome").value);
    var headTitle = alltrim(document.getElementById("headTitle").value);
    var headName = alltrim(document.getElementById("headName").value);
    var headDesignation = alltrim(document.getElementById("headDesignation").value);
    var headEmail = alltrim(document.getElementById("headEmail").value);
    var headPhone = alltrim(document.getElementById("headPhone").value);
    var headAddress = alltrim(document.getElementById("headAddress").value);
    var gender = $('input[id=gender]:checked').val();
    //clearing the previous errors
    document.getElementById("emailError").style.display = "none";
    //document.getElementById("cerror").style.display = "none";
    document.getElementById("titleError").style.display = "none";
    document.getElementById("firstNameError").style.display = "none";
    document.getElementById('lastNameError').style.display = "none";
    document.getElementById('qualificationError').style.display = "none";
    document.getElementById('disciplineError').style.display = "none";
    document.getElementById('genderError').style.display = "none";
    document.getElementById('stateInstituteError').style.display = "none";
    document.getElementById('cityInstituteError').style.display = "none";
    document.getElementById('instituteError').style.display = "none";
    document.getElementById('instituteAddressError').style.display = "none";
    document.getElementById('institutePincodeError').style.display = "none";
    document.getElementById('homeAddressError').style.display = "none";
    document.getElementById('homeCityError').style.display = "none";
    document.getElementById('homePincodeError').style.display = "none";
    document.getElementById('mobileError').style.display = "none";
    document.getElementById('homePhoneError').style.display = "none";
    document.getElementById('headTitleError').style.display = "none";
    document.getElementById('headNameError').style.display = "none";
    document.getElementById('headDesignationError').style.display = "none";
    document.getElementById('headEmailError').style.display = "none";
    document.getElementById('headPhoneError').style.display = "none";
    document.getElementById('headAddressError').style.display = "none";
    //resetting the border for the previous messages. 
    document.getElementById("email").style.border = "";
    //document.getElementById("cemail").style.border = "";
    document.getElementById("title").style.border = "";
    document.getElementById("firstName").style.border = "";
    document.getElementById("lastName").style.border = "";
    document.getElementById("qualification").style.border = "";
    document.getElementById("designation").style.border = "";
    document.getElementById("discipline").style.border = "";
    document.getElementById("stateInstitute").style.border = "";
    document.getElementById("cityInstitute").style.border = "";
    document.getElementById("institute").style.border = "";
    document.getElementById("instituteAddress").style.border = "";
    document.getElementById("pincodeInstitute").style.border = "";
    document.getElementById("homeAddress").style.border = "";
    document.getElementById("cityHome").style.border = "";
    document.getElementById("pincodeHome").style.border = "";
    document.getElementById("mobile").style.border = "";
    document.getElementById("phoneHome").style.border = "";
    document.getElementById("headTitle").style.border = "";
    document.getElementById("headName").style.border = "";
    document.getElementById("headDesignation").style.border = "";
    document.getElementById("headEmail").style.border = "";
    document.getElementById("headPhone").style.border = "";
    document.getElementById("headAddress").style.border = "";
    //validations starts
    if ((email) == "" || !emailValidator(email)) {
        borderRedError("email");
        document.getElementById("emailError").style.display = "inline";
        value++;
    }
    if (title == -1) {
        borderRedError("title");
        document.getElementById("titleError").style.display = "inline";
        value++;
    }
    if (!isStringInRange(firstName, 2, 30) || !validateLastName(firstName)) {
        borderRedError("firstName");
        document.getElementById("firstNameError").style.display = "inline";
        value++;
    }
    if (!lastname == "" || !lastname == null) {
        if (!isStringInRange(lastName, 1, 30) || !validateLastName(lastName)) {
            borderRedError("lastName");
            document.getElementById('lastNameError').style.display = "inline";
            value++;
        }
    }
    if (qualification == -1) {
        borderRedError("qualification");
        document.getElementById('qualificationError').style.display = "inline";
        value++;
    }
    if (facultyStatus == 1) {
        if (designation == -1) {
            borderRedError("designation");
            document.getElementById('designationError').style.display = "inline";
            value++;
        }
        if (experience == null || experience == "")
        {
            document.getElementById('experienceError').style.display = "inline";
            value++;
        }
        if (institute == -1) {
            borderRedError("institute");
            document.getElementById('instituteError').style.display = "inline";
            value++;
        }
    }

    if (discipline == -1) {
        borderRedError("discipline");
        document.getElementById('disciplineError').style.display = "inline";
        value++;
    }

    if (gender == null || gender == "")
    {
        document.getElementById('genderError').style.display = "inline";
        value++;
    }
    if (stateInstitute == -1) {
        borderRedError("stateInstitute");
        document.getElementById('stateInstituteError').style.display = "inline";
        value++;
    }
    if (cityInstitute == -1) {
        borderRedError("cityInstitute");
        document.getElementById('cityInstituteError').style.display = "inline";
        value++;
    }


    //    if (!isStringInRange(instituteAddress, 5, 150) || !remarkValidator(instituteAddress)) {
    //        borderRedError("instituteAddress");
    //        document.getElementById('instituteAddressError').style.display = "inline";
    //        value++;
    //    }
    //
    //    if (!pincodeInstitute.match(pincoderegex)) {
    //        borderRedError("pincodeInstitute");
    //        document.getElementById('institutePincodeError').style.display = "inline";
    //        value++;
    //    }
    if (!isStringInRange(homeAddress, 5, 150) || !remarkValidator(homeAddress)) {
        borderRedError("homeAddress");
        document.getElementById('homeAddressError').style.display = "inline";
        value++;
    }

    if (!validateCityHome(cityHome, 3, 30)) {
        borderRedError("cityHome");
        document.getElementById('homeCityError').style.display = "inline";
        value++;
    }
    if (!pincodeHome.match(pincoderegex)) {
        borderRedError("pincodeHome");
        document.getElementById('homePincodeError').style.display = "inline";
        value++;
    }
    if (!validateMobilenumber(mobile)) {
        borderRedError("mobile");
        document.getElementById('mobileError').style.display = "inline";
        value++;
    }
    if (!phoneHome.match(phoneregex)) {
        borderRedError("phoneHome");
        document.getElementById('homePhoneError').style.display = "inline";
        value++;
    }
    //    if (headTitle == -1) {
    //        borderRedError("headTitle");
    //        document.getElementById('headTitleError').style.display = "inline";
    //        value++;
    //    }
    //    if (!isStringInRange(headName, 2, 50) || !isAlphabet(headName)) {
    //        borderRedError("headName");
    //        document.getElementById("headNameError").style.display = "inline";
    //        value++;
    //    }
    //    if (!isStringInRange(headName, 2, 50) || !validateLastName(headName)) {
    //        borderRedError("headName");
    //        document.getElementById("headNameError").style.display = "inline";
    //        value++;
    //    }
    //    if (headDesignation == -1) {
    //        borderRedError("headDesignation");
    //        document.getElementById('headDesignationError').style.display = "inline";
    //        value++;
    //    }
    //    if (alltrim(headEmail) == "" || !emailValidator(headEmail)) {
    //        borderRedError("headEmail");
    //        document.getElementById("headEmailError").style.display = "inline";
    //        value++;
    //    }
    //    if (!headPhone.match(phoneregex)) {
    //        borderRedError("headPhone");
    //        document.getElementById('headPhoneError').style.display = "inline";
    //        value++;
    //    }
    //    if (!isStringInRange(headAddress, 5, 175) || !remarkValidator(headAddress)) {
    //        borderRedError("headAddress");
    //        document.getElementById('headAddressError').style.display = "inline";
    //        value++;
    //    }

    //    clearWRFormErrorsAndBorder();
    document.getElementById("state").style.border = "";
    document.getElementById("remotecenter").style.border = "";
    document.getElementById("rcid").style.border = "";
    document.getElementById("permissionLetter").style.border = "";
    document.getElementById("stateError").style.display = "";
    document.getElementById("remotecenterError").style.display = "";
    document.getElementById("remotecenterIdError").style.display = "";
    document.getElementById("accomodationError").style.display = "";
    document.getElementById("permissionLetterError").style.display = "";

    var state = document.getElementById("state").value;
    var rc = document.getElementById("remotecenter").value;
    var rcid = document.getElementById("rcid").value;
    var acc1 = document.getElementById("acco1").checked;
    var acc2 = document.getElementById("acco2").checked;
    var permissionLetter = wrform.permissionLetter.value;

    if (state == "" || state == null || state == "-1")
    {
        borderRedError("state");
        document.getElementById('stateError').style.display = "inline";
        value++;
    }
    if (rc == "" || rc == null || rc == "-1") {

        borderRedError("remotecenter");
        document.getElementById("remotecenterError").style.display = "inline";
        value++;
    }
    if (rcid == "" || rcid == null) {

        borderRedError("rcid");
        document.getElementById("remotecenterIdError").style.display = "inline";
        value++;
    }
    if (!(acc1 || acc2))
    {
        document.getElementById("accomodationError").style.display = "inline";
        value++;
    }
    if (!(permissionLetter == "" || permissionLetter == null)) {
        var size = wrform.permissionLetter.files[0].size;
        var val = validateLetter(permissionLetter);
        var val1 = checkFileSize(size, 262144);
        if (val == false || val1 == false) {
            borderRedError("permissionLetter");
            document.getElementById("permissionLetterError").style.display = "inline";
            value++;
        }
    }

    if (value > 0) {
        return false;
    }
    return result;
}

function onlyNumeric(str) {
    var result = false;
    var alphaExp = /^[0-9]+$/;
    if (str.match(alphaExp)) {
        result = true;
    } else {
        result = false;
    }
    return result;
}

function onlyAlphaNumeric(str) {
    var result = false;
    var alphaExp = /^[a-zA-Z0-9]+$/;
    if (str.match(alphaExp)) {
        result = true;
    } else {
        result = false;
    }
    return result;
}

function checklength(length, str) {
    var result = false;
    var ent_length = str.length;
    if (ent_length == length) {
        result = true;
    } else {
        result = false;
    }
    return result;
}

function scrollWin() {
    window.scrollTo(0, 10);
}

function check_photo(photoFile) {
    var size = photoFile.files[0].size;
    var value = 0;
    var photo_name = photoFile.value;
    var val = validateLetter(photo_name);
    var val1 = checkFileSize(size, 262144);
    if (val == false || val1 == false) {
        borderRedError("photo");
        document.getElementById("photoError").style.display = "inline";
        value++;
    }
    return value;
}

function validateRCForm(RCForm) {
    var value = 0;
    clearBorderandErrorsRCUpdate();
    var state = document.getElementById("state").value;
    var rc = document.getElementById("rc").value;
    var rcid = document.getElementById("rcid").value;
    var isActive1 = document.getElementById("isActive1").checked;
    var isActive2 = document.getElementById("isActive2").checked;
    var isActive3 = document.getElementById("isActive3").checked;
    var city = document.getElementById("cityInstitute").value;
    var institute = document.getElementById("institute").value;
    var district = document.getElementById("district").value;
    var pincode = document.getElementById("pincode").value;
    var isnewrc = document.getElementById("isnewrc").value;
    var rc_email = document.getElementById("rc_email").value;
    var isStatus1 = document.getElementById("isStatus1").checked;
    var isStatus2 = document.getElementById("isStatus2").checked;
    var isStatus3 = document.getElementById("isStatus3").checked;
    var isStatus4 = document.getElementById("isStatus4").checked;
    if (city == "" || city == null || city == "-1")
    {
        borderRedError("cityInstitute");
        document.getElementById('cityError').style.display = "inline";
        value++;
    }

    if (institute == "" || institute == null || institute == "-1")
    {
        borderRedError("institute");
        document.getElementById('instituteError').style.display = "inline";
        value++;
    }

    if (state == "" || state == null || state == "-1")
    {
        borderRedError("state");
        document.getElementById('stateError').style.display = "inline";
        value++;
    }
    if ((rc == "" || rc == null)) {
        borderRedError("rc");
        document.getElementById("rcError").style.display = "inline";
        value++;
    }
    if (rc.match(isnumber)) {
        borderRedError("rc");
        document.getElementById("rcError").style.display = "inline";
        value++;
    }
    if (rcid == "" || rcid == null) {
        borderRedError("rcid");
        document.getElementById("rcidError").style.display = "inline";
        value++;
    }
    if ((!rcid.match(isnumber) && isnewrc == 1))
    {
        borderRedError("rcid");
        document.getElementById("rcidError").style.display = "inline";
        value++;
    }
    if (!(isActive1 || isActive2 || isActive3))
    {
        document.getElementById("isActiveError").style.display = "inline";
        value++;
    }
    if (district == "" || district == null) {
        borderRedError("district");
        document.getElementById("districtError").style.display = "inline";
        value++;
    }
    if (!validateCityHome(district, 3, 30)) {
        borderRedError("district");
        document.getElementById("districtError").style.display = "inline";
        value++;
    }
    if (district.match(isnumber)) {
        borderRedError("district");
        document.getElementById("districtError").style.display = "inline";
        value++;
    }
    if (!pincode.match(pincoderegex)) {
        borderRedError("pincode");
        document.getElementById("pincodeError").style.display = "inline";
        value++;
    }

    if (rc_email == "" || rc_email == null) {
        borderRedError("rc_email");
        document.getElementById("rcemailError").style.display = "inline";
        value++;
    }
    if (!emailValidator(rc_email)) {
        borderRedError("rc_email");
        document.getElementById("rcemailError").style.display = "inline";
        value++;
    }

    if (!(isStatus1 || isStatus2))
    {
        document.getElementById("isStatusError").style.display = "inline";
        value++;
    }
    if (!(isStatus3 || isStatus4))
    {
        document.getElementById("isStatusError1").style.display = "inline";
        value++;
    }

    if (value > 0) {
        return false;
    } else {
        return true;
    }
    return false;
}

function resetRCUpdateForm() {
    clearBorderandErrorsRCUpdate();
    document.getElementById("state").value = "-1";
    document.getElementById("pincode").value = "";
    document.getElementById("district").value = "";
    var x = document.getElementById("cityInstitute");
    for (var i = x.length; i > 0; i--) {
        x.remove(i);
    }
    var y = document.getElementById("institute");
    for (var j = y.length; j > 0; j--) {
        y.remove(j);
    }
    document.getElementById("cityInstitute").value = "-1";
    document.getElementById("institute").value = "-1";
    document.getElementById("isActive1").checked = false;
    document.getElementById("isActive2").checked = false;
    document.getElementById("isActive3").checked = false;
    var isnewrc = document.getElementById("isnewrc").value;
    if (isnewrc == 1) {
        document.getElementById("rcid").value = "";
        document.getElementById("rc").value = "";
    }
    document.getElementById("isStatus1").checked = false;
    document.getElementById("isStatus2").checked = false;
    document.getElementById("isStatus3").checked = false;
    document.getElementById("isStatus4").checked = false;
    document.getElementById("academic_cal_startdate").value = "";
    document.getElementById("affiliated_univ").value = "";
    document.getElementById("rc_email").value = "";
}
function clearBorderandErrorsRCUpdate() {
    // clear error
    document.getElementById("districtError").style.display = "none";
    document.getElementById("pincodeError").style.display = "none";
    document.getElementById('stateError').style.display = "none";
    document.getElementById('cityError').style.display = "none";
    document.getElementById('instituteError').style.display = "none";
    document.getElementById('isActiveError').style.display = "none";
    document.getElementById('rcError').style.display = "none";
    document.getElementById('rcidError').style.display = "none";
    document.getElementById('rcemailError').style.display = "none";
    document.getElementById('isStatusError').style.display = "none";
    document.getElementById('isStatusError1').style.display = "none";
    // clear border
    document.getElementById("state").style.border = "";
    document.getElementById("cityInstitute").style.border = "";
    document.getElementById("institute").style.border = "";
    document.getElementById("rc").style.border = "";
    document.getElementById("pincode").style.border = "";
    document.getElementById("district").style.border = "";
    document.getElementById("rcid").style.border = "";
    document.getElementById("rc_email").style.border = "";
}
function validateConfigForm(ConfigForm) {
    var value = 0;
    clearConfigFormErrorsAndBorder(ConfigForm);
    var category = document.getElementById('category').value;
    var code = document.getElementById('code').value;
    var description = document.getElementById('description').value;
    var acc1 = document.getElementById('acco1').checked;
    var acc2 = document.getElementById('acco2').checked;
    var comment = document.getElementById('comment').value;

    var isNew = document.getElementById('isNew').value;

    if (isNew == 1) {
        if (category == "" || category == null || category == "-1")
        {
            borderRedError("category");
            document.getElementById('categoryError').style.display = "inline";
            value++;
        }
        if (code == "" || code == null || code == "-1") {

            borderRedError("code");
            document.getElementById("codeError").style.display = "inline";
            value++;
        }

        var isNewCategory = document.getElementById("isNewCategory").value;
        var newCategory = document.getElementById("newCategory").value;
        if (isNewCategory == 1 && (newCategory == "" || newCategory == null)) {
            borderRedError("newCategory");
            document.getElementById('newCategoryError').style.display = "inline";
            value++;
        }

    }
    if (!(acc1 || acc2))
    {
        document.getElementById("isActiveError").style.display = "inline";
        value++;
    }
    if (description == "" || description == null || description == "-1") {

        borderRedError("description");
        document.getElementById("descriptionError").style.display = "inline";
        value++;
    }

    if (value > 0) {
        return false;
    } else {
        return true;
    }

}

function clearConfigFormErrorsAndBorder(ConfigForm) {
    //clearing border
    var isNew = document.getElementById('isNew').value;
    if (isNew == 1) {
        document.getElementById('category').style.border = "";
        document.getElementById('categoryError').style.display = "";
        document.getElementById('code').style.border = "";
        document.getElementById('codeError').style.display = "";
        document.getElementById('newCategory').style.border = "";
        document.getElementById("newCategoryError").style.display = "";
    }
    document.getElementById("description").style.border = "";
    document.getElementById('descriptionError').style.display = "";
    document.getElementById('isActiveError').style.display = "";

}
function resetConfigForm() {
    clearConfigFormErrorsAndBorder();

    var isNew = document.getElementById('isNew').value;

    if (isNew == 1) {
        document.getElementById('category').value = "-1";
        document.getElementById("code").value = "";
        document.getElementById("newCategory").value = "0";
        document.getElementById("newcategory1").style.display = "none";
    }
    document.getElementById("acco1").checked = false;
    document.getElementById("acco2").checked = false;

    document.getElementById("description").value = "";
    document.getElementById("comment").value = "";

}

function validateCityForm(CityForm) {
    var value = 0;
    clearCityFormErrorsAndBorder(CityForm);
    var state = document.getElementById('state').value;
    var cityName = document.getElementById('cityName').value;
    var acc1 = document.getElementById('acco1').checked;
    var acc2 = document.getElementById('acco2').checked;
    if (state == "" || state == null || state == "-1")
    {
        borderRedError("state");
        document.getElementById('stateError').style.display = "inline";
        value++;
    }
    if (cityName == "" || cityName == null || cityName == "-1") {

        borderRedError("cityName");
        document.getElementById("cityNameError").style.display = "inline";
        value++;
    }

    if (!(acc1 || acc2))
    {
        document.getElementById("isActiveError").style.display = "inline";
        value++;
    }

    if (value > 0) {
        return false;
    } else {
        return true;
    }

}

function clearCityFormErrorsAndBorder(CityForm) {
    //clearing border   
    document.getElementById('state').style.border = "";
    document.getElementById('stateError').style.display = "";
    document.getElementById('cityName').style.border = "";
    document.getElementById('cityNameError').style.display = "";
    document.getElementById('isActiveError').style.display = "";

}
function resetCityForm() {
    clearCityFormErrorsAndBorder();
    document.getElementById('state').value = "-1";
    document.getElementById("cityName").value = "";
    document.getElementById("acco1").checked = false;
    document.getElementById("acco2").checked = false;

}

function validateScheduleForm(form) {
    var value = 0;
    var no_of_sessions = form.sessions.value;

    for (var i = 1; i <= no_of_sessions; i++) {

        var date_of_day = document.getElementById("date_of_day" + i).value;
        var sessions_of_day = document.getElementById("sessions_of_day" + i).value;


        if ((date_of_day == "" || date_of_day == null)) {
            // error
            borderRedError("date_of_day" + i);

            value++;
        }

        if ((sessions_of_day == "") || (sessions_of_day == null)) {
            // error

            borderRedError("sessions_of_day" + i);
            value++;
        }

        if (sessions_of_day.match(isnumber)) {

        }

    }
    if (value > 0) {
        return false;
    } else {
        return true;
    }
}
function validateProfilePage1(registrationForm) {

    var result = true;
    var value = 0;
    //getting form values
    var email = alltrim(document.getElementById("email").value.toLowerCase());
    //var cemail = alltrim(document.getElementById("cemail").value.toLowerCase());
    var title = alltrim(document.getElementById("title").value);
    var firstName = alltrim(document.getElementById("firstName").value);
    var lastName = alltrim(document.getElementById("lastName").value);
    var qualification = alltrim(document.getElementById("qualification").value);
    var designation = alltrim(document.getElementById("designation").value);
    var discipline = alltrim(document.getElementById("discipline").value);
    var stateInstitute = alltrim(document.getElementById("stateInstitute").value);
    var cityInstitute = alltrim(document.getElementById("cityInstitute").value);
    var institute = alltrim(document.getElementById("institute").value);
    var instituteAddress = alltrim(document.getElementById("instituteAddress").value);
    var pincodeInstitute = alltrim(document.getElementById("pincodeInstitute").value);
    var homeAddress = alltrim(document.getElementById("homeAddress").value);
    var cityHome = alltrim(document.getElementById("cityHome").value);
    var pincodeHome = alltrim(document.getElementById("pincodeHome").value);
    var mobile = alltrim(document.getElementById("mobile").value);
    var phoneHome = alltrim(document.getElementById("phoneHome").value);
    var headTitle = alltrim(document.getElementById("headTitle").value);
    var headName = alltrim(document.getElementById("headName").value);
    var headDesignation = alltrim(document.getElementById("headDesignation").value);
    var headEmail = alltrim(document.getElementById("headEmail").value);
    var headPhone = alltrim(document.getElementById("headPhone").value);
    var headAddress = alltrim(document.getElementById("headAddress").value);
    var experience = $('input[id=experience]:checked').val();
    var gender = $('input[id=gender]:checked').val();
    var captchaAnswer = alltrim(document.getElementById("captchaText").value);
    var capcheck = alltrim(document.getElementById('capCheck').value);

    var isNewUser = document.getElementById("isNewUser").value;
    var notInLogin = document.getElementById("notInLogin").value;

    // var password = document.getElementById("password").value;
    //  var cpassword = document.getElementById("cpassword").value;
    //new code added 11-1-2016
    var password = "", cpassword = "";
    if (isNewUser == 1) {
        password = document.getElementById("password").value;
        cpassword = document.getElementById("cpassword").value;
    }

    var personState = alltrim(document.getElementById("personState").value);
    var personCity = alltrim(document.getElementById("personCity").value);
    var photopath = alltrim(document.getElementById('photoPath').value);
    //clearing the previous errors
    if (isNewUser == 1) {
        document.getElementById("passwordError").style.display = "none";
        document.getElementById("cpassworderror").style.display = "none";
    }
    document.getElementById("emailError").style.display = "none";
    document.getElementById("titleError").style.display = "none";
    document.getElementById("firstNameError").style.display = "none";
    document.getElementById('lastNameError').style.display = "none";
    document.getElementById('qualificationError').style.display = "none";
    document.getElementById('designationError').style.display = "none";
    document.getElementById('disciplineError').style.display = "none";
    document.getElementById('experienceError').style.display = "none";
    document.getElementById('genderError').style.display = "none";
    document.getElementById('stateInstituteError').style.display = "none";
    document.getElementById('cityInstituteError').style.display = "none";
    document.getElementById('instituteError').style.display = "none";
    document.getElementById('instituteAddressError').style.display = "none";
    document.getElementById('institutePincodeError').style.display = "none";
    document.getElementById('homeAddressError').style.display = "none";
    document.getElementById('homeCityError').style.display = "none";
    document.getElementById('homePincodeError').style.display = "none";
    document.getElementById('mobileError').style.display = "none";
    document.getElementById('homePhoneError').style.display = "none";
    document.getElementById('headTitleError').style.display = "none";
    document.getElementById('headNameError').style.display = "none";
    document.getElementById('headDesignationError').style.display = "none";
    document.getElementById('headEmailError').style.display = "none";
    document.getElementById('headPhoneError').style.display = "none";
    document.getElementById('headAddressError').style.display = "none";
    document.getElementById('captchaError').style.display = "none";
    document.getElementById('termsError').style.display = "none";
    document.getElementById('sameNumberError').style.display = "none";

    document.getElementById('personStateError').style.display = "none";
    document.getElementById('personCityError').style.display = "none";
    document.getElementById("photoError").style.display = "none";
    document.getElementById('otherCityError').style.display = "none";
    //resetting the border for the previous messages. 
    document.getElementById("email").style.border = "";
    //document.getElementById("cemail").style.border = "";
    document.getElementById("title").style.border = "";
    document.getElementById("firstName").style.border = "";
    document.getElementById("lastName").style.border = "";
    document.getElementById("qualification").style.border = "";
    document.getElementById("designation").style.border = "";
    document.getElementById("discipline").style.border = "";
    document.getElementById("stateInstitute").style.border = "";
    document.getElementById("cityInstitute").style.border = "";
    document.getElementById("institute").style.border = "";
    document.getElementById("instituteAddress").style.border = "";
    document.getElementById("pincodeInstitute").style.border = "";
    document.getElementById("homeAddress").style.border = "";
    document.getElementById("cityHome").style.border = "";
    document.getElementById("pincodeHome").style.border = "";
    document.getElementById("mobile").style.border = "";
    document.getElementById("phoneHome").style.border = "";
    document.getElementById("headTitle").style.border = "";
    document.getElementById("headName").style.border = "";
    document.getElementById("headDesignation").style.border = "";
    document.getElementById("headEmail").style.border = "";
    document.getElementById("headPhone").style.border = "";
    document.getElementById("headAddress").style.border = "";
    document.getElementById("captchaText").style.border = "";

    document.getElementById("personState").style.border = "";
    document.getElementById("personCity").style.border = "";
    document.getElementById("photo").style.border = "";
    document.getElementById('otherCity').style.border = "";
    //validations starts
    if ((email) == "" || !emailValidator(email)) {
        borderRedError("email");
        document.getElementById("emailError").style.display = "inline";
        value++;
    }


    if ((isNewUser == 1) || (notInLogin == 1)) {
        if ((password) == "" || !isStringInRange(password, 8, 15)) {
            borderRedError("password");
            document.getElementById("passwordError").style.display = "inline";
            value++;
        }
        if ((cpassword) == "" || !isStringInRange(cpassword, 8, 15)) {
            borderRedError("cpassword");
            document.getElementById("cpassworderror").style.display = "inline";
            value++;
        }
        if (!((password) == (cpassword))) {
            borderRedError("cpassword");
            document.getElementById("cpasswordError").style.display = "inline";
            value++;
        }
    }
    if (title == -1) {
        borderRedError("title");
        document.getElementById("titleError").style.display = "inline";
        value++;
    }

    if (!isStringInRange(firstName, 2, 30) || !validateLastName(firstName)) {
        borderRedError("firstName");
        document.getElementById("firstNameError").style.display = "inline";
        value++;
    }
    if (!(lastname == "" || lastname == null)) {
        if (!isStringInRange(lastName, 1, 30) || !validateLastName(lastName)) {
            borderRedError("lastName");
            document.getElementById('lastNameError').style.display = "inline";
            value++;
        }
    }
    if (qualification == -1) {
        borderRedError("qualification");
        document.getElementById('qualificationError').style.display = "inline";
        value++;
    }
    if (designation == -1) {
        borderRedError("designation");
        document.getElementById('designationError').style.display = "inline";
        value++;
    }

    if (discipline == -1) {
        borderRedError("discipline");
        document.getElementById('disciplineError').style.display = "inline";
        value++;
    }

    if (experience == null || experience == "")
    {
        document.getElementById('experienceError').style.display = "inline";
        value++;
    }

    if (gender == null || gender == "")
    {
        document.getElementById('genderError').style.display = "inline";
        value++;
    }
    if (stateInstitute == -1) {
        borderRedError("stateInstitute");
        document.getElementById('stateInstituteError').style.display = "inline";
        value++;
    }
    if (cityInstitute == -1) {
        borderRedError("cityInstitute");
        document.getElementById('cityInstituteError').style.display = "inline";
        value++;
    }
    if (institute == -1) {
        borderRedError("institute");
        document.getElementById('instituteError').style.display = "inline";
        value++;
    }

    if (!isStringInRange(instituteAddress, 5, 150) || !remarkValidator(instituteAddress)) {
        borderRedError("instituteAddress");
        document.getElementById('instituteAddressError').style.display = "inline";
        value++;
    }

    if (!pincodeInstitute.match(pincoderegex)) {
        borderRedError("pincodeInstitute");
        document.getElementById('institutePincodeError').style.display = "inline";
        value++;
    }
    if (!isStringInRange(homeAddress, 5, 150) || !remarkValidator(homeAddress)) {
        borderRedError("homeAddress");
        document.getElementById('homeAddressError').style.display = "inline";
        value++;
    }

    if (!pincodeHome.match(pincoderegex)) {
        borderRedError("pincodeHome");
        document.getElementById('homePincodeError').style.display = "inline";
        value++;
    }
    if (!validateMobilenumber(mobile)) {
        borderRedError("mobile");
        document.getElementById('mobileError').style.display = "inline";
        value++;
    }
    if (!phoneHome.match(phoneregex)) {
        borderRedError("phoneHome");
        document.getElementById('homePhoneError').style.display = "inline";
        value++;
    }
    if (headTitle == -1) {
        borderRedError("headTitle");
        document.getElementById('headTitleError').style.display = "inline";
        value++;
    }

    if (!isStringInRange(headName, 2, 50) || !validateLastName(headName)) {
        borderRedError("headName");
        document.getElementById("headNameError").style.display = "inline";
        value++;
    }
    if (headDesignation == -1) {
        borderRedError("headDesignation");
        document.getElementById('headDesignationError').style.display = "inline";
        value++;
    }
    if (alltrim(headEmail) == "" || !emailValidator(headEmail)) {
        borderRedError("headEmail");
        document.getElementById("headEmailError").style.display = "inline";
        value++;
    }
    if (!headPhone.match(phoneregex)) {
        borderRedError("headPhone");
        document.getElementById('headPhoneError').style.display = "inline";
        value++;
    }
    if (!isStringInRange(headAddress, 5, 175) || !remarkValidator(headAddress)) {
        borderRedError("headAddress");
        document.getElementById('headAddressError').style.display = "inline";
        value++;
    }

    if (!isStringInRange(captchaAnswer, 7, 7)) {
        borderRedError("captchaText");
        document.getElementById('captchaError').style.display = "inline";
        value++;
    }

    if (!registrationForm.termsAndConditions.checked == true) {
        document.getElementById('termsError').style.display = "inline";
        value++;
    }

    if (capcheck == "0") {
        borderRedError("captchaText");
        document.getElementById('captchaError').style.display = "inline";
        value++;
    }

    var res = checkPhoneNumber1();
    if (res == false) {
        document.getElementById('sameNumberError').style.display = "inline";
        value++;
    }

    if (personState == -1) {
        borderRedError("personState");
        document.getElementById('personStateError').style.display = "inline";
        value++;
    }
    if (personCity == -1) {
        borderRedError("personCity");
        document.getElementById('personCityError').style.display = "inline";
        value++;
    } else if (personCity == -2) {
        var cityflag = alltrim(document.getElementById("hiddenCityFlag").value);
        var otherCity = alltrim(document.getElementById("otherCity").value);
        if (cityflag == 1 && otherCity.length == 0) {
            borderRedError("otherCity");
            document.getElementById('otherCityError').style.display = "inline";
            value++;
        } else if (cityflag == 1 && otherCity.length != 0) {
            if (!validateCityHome(otherCity, 3, 30)) {
                borderRedError("otherCity");
                document.getElementById('otherCityError').style.display = "inline";
                value++;
            }
        }
    }


    var photo_check = "";
    if (photopath.trim() != '') {
        photo_check = "photo_exist";
        //check for validation
    } else {
        photo_check = "no photo";
        //set the error 
    }
    if (photo_check == 'no photo') {
        var input_file = alltrim(document.getElementById('photo').value);
        if (input_file == '') {
            borderRedError("photo");
            document.getElementById("photoError").style.display = "inline";
            value++;
            // scrollWin();
        } else {
            var photo_file = document.getElementById('photo');
            var res = check_photo(photo_file);
            if (res > 0) {
                document.getElementById('photoError').innerHTML = "Only jpg / jpeg file.(max 256 kb)";
                value++;
            }
        }
        //check for input file upload
    } else if (photo_check == 'photo_exist') {
        var input_file2 = alltrim(document.getElementById('photo').value);
        if (input_file2 == '') {
        } else {
            var photo_file = document.getElementById('photo');
            var res = check_photo(photo_file);
            if (res > 0) {
                document.getElementById('photoError').innerHTML = "Only jpg / jpeg file.(max 256 kb)";
                value++;
            }
        }
    }

    // validation for RC

    document.getElementById('state').style.border = "";
    document.getElementById('remotecenter').style.border = "";
    document.getElementById("rcid").style.border = "";
    document.getElementById('stateError').style.display = "";
    document.getElementById('remotecenterError').style.display = "";
    document.getElementById('remotecenterIdError').style.display = "";

    var state = document.getElementById('state').value;
    var rc = document.getElementById('remotecenter').value;
    var rcid = document.getElementById('rcid').value;
    var acc1 = document.getElementById('acco1').checked;
    var acc2 = document.getElementById('acco2').checked;
    var cc = document.getElementById('categorycode').value;
    if (cc == 5 || cc == 6) {
        if (state == "" || state == null || state == "-1")
        {
            borderRedError("state");
            document.getElementById('stateError').style.display = "inline";
            value++;
        }
        if (rc == "" || rc == null || rc == "-1") {

            borderRedError("remotecenter");
            document.getElementById("remotecenterError").style.display = "inline";
            value++;
        }
        if (rcid == "" || rcid == null) {

            borderRedError("rcid");
            document.getElementById("remotecenterIdError").style.display = "inline";
            value++;
        }
    }
    if (!(acc1 || acc2))
    {
        document.getElementById("accomodationError").style.display = "inline";
        value++;
    }

    //new validation for permissionletter added on 11-1-2016
    var letter_flag = document.getElementById("permissionletter_flag").value.trim();
    if (letter_flag == 1 || letter_flag == 3) {
        var letter_file = alltrim(document.getElementById('permissionLetter').value);
        if (letter_file == '') {
            document.getElementById('permissionLetterError').style.display = "inline";
            value++;
        } else {
            var res = check_photo(letter_file);
            if (res > 0) {
                document.getElementById('permissionLetterError').style.display = "inline";
                value++;
            }
        }
    }

    if (value > 0) {
        scrollWin();
        return false;
    }
    return result;
}

function validateWSCNominateForm() {
    resetBordersAndErrorsWSCNominateForm();
    var isNomineeEmailValid = alltrim(document.getElementById("isNomineeEmailValid").value);
    var workshopid = alltrim(document.getElementById("workshopid").value);
    var remotecenter = alltrim(document.getElementById("remotecenter").value);
    var wsc_email = alltrim(document.getElementById("wsc_email").value);
    var nominee_email = alltrim(document.getElementById("nominee_email").value);
    var active_date = alltrim(document.getElementById("datepicker1").value);
    var ifCanBeNominated = alltrim(document.getElementById("ifCanBeNominated").value);
    var value = 0;

    if (workshopid == "" || workshopid == null || workshopid == "selectWorkshop") {
        borderRedError("workshopid");
        document.getElementById("wcError").style.display = "inline";
        value++;
    }

    if (remotecenter == "-1" || remotecenter == null || remotecenter == "") {
        borderRedError("remotecenter");
        document.getElementById("rcError").style.display = "inline";
        value++;
    }

    if (wsc_email == "" || wsc_email == null) {
        borderRedError("wsc_email");
        document.getElementById("wscError").style.display = "inline";
        value++;
    }

    if (nominee_email == "" || nominee_email == null || isNomineeEmailValid == 0) {
        borderRedError("nominee_email");
        document.getElementById("nominee_Error").style.display = "inline";
        value++;
    }

    if (active_date == "" || active_date == null) {
        borderRedError("datepicker1");
        document.getElementById("activeDateError").style.display = "inline";
        value++;
    }
    if (ifCanBeNominated == 0) {
        document.getElementById("ifCanBeNominated_msg").style.display = "inline";
        value++;
    }
    if (value > 0) {
        scrollWin();
        return false;
    } else {
        return true;
    }
}
function resetWSCNominateForm() {

    resetBordersAndErrorsWSCNominateForm();

    document.getElementById("isNomineeEmailValid").value = "0";
    document.getElementById("workshopid").value = "selectWorkshop";

    var x = document.getElementById("remotecenter");
    for (var i = x.length; i > 0; i--) {
        x.remove(i);
    }

    document.getElementById("remotecenter").value = "-1";

    document.getElementById("wsc_email").value = "";
    document.getElementById("nominee_email").value = "";
    document.getElementById("nominee_email_msg").innerHTML = "";
    document.getElementById("datepicker1").value = "";
    //    nominee_email_msg
    document.getElementById("ifCanBeNominated_msg").style.display = "none";

}
function resetBordersAndErrorsWSCNominateForm() {
    // reset borders
    document.getElementById("workshopid").style.border = "";
    document.getElementById("remotecenter").style.border = "";
    document.getElementById("wsc_email").style.border = "";
    document.getElementById("nominee_email").style.border = "";
    document.getElementById("datepicker1").style.border = "";
    // reset errors

    document.getElementById('wcError').style.display = "none";
    document.getElementById('rcError').style.display = "none";
    document.getElementById("wscError").style.display = "none";
    document.getElementById('nominee_Error').style.display = "none";
    document.getElementById('activeDateError').style.display = "none";
}
function validateSubscriptionForm1() {
    var result = true;
    var value = 0;
    //getting form values
    var user = document.getElementById("username").value.trim();
    //clearing the previous errors
    document.getElementById("userNameError").style.display = "none";
    document.getElementById("username").style.border = "";
    if ((user) == "" || !emailValidator(user)) {
        borderRedError("username");
        document.getElementById("userNameError").style.display = "inline";
        value++;
    }
    if (value > 0) {
        return false;
    }
    return result;
}
