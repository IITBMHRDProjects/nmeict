/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function getXMLObject() //XML Object
{
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

var xmlhttp = new getXMLObject(); //xmlhttp holds the ajax objec

function checkUserEmail() {
    document.getElementById('emailAvaliable').style.display = "none";
    document.getElementById('emailnotAvaliable').style.display = "none";
    var email = document.getElementById('email').value.trim();
    if (!emailValidator(email))
    {
        document.getElementById('emailError').style.display = "inline";
    } else {
        if (xmlhttp) {
            xmlhttp.open("GET", "pages/DAOcheckemail.jsp?email=" + email, true);
            xmlhttp.onreadystatechange = handleEmailServerResponses;
            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp.send(null);
        }
    }
}

function handleEmailServerResponses()
{
    if (xmlhttp.readyState == 4) {
        if (xmlhttp.status == 200) {
            var res = xmlhttp.responseText; //Update the HTML Form element
            document.getElementById('emailError').style.display = "none";
            if (res.match("true") != null) {
                document.getElementById('emailnotAvaliable').style.display = "none";
                document.getElementById('emailAvaliable').style.display = "inline";
            } else {
                document.getElementById('emailAvaliable').style.display = "none";
                document.getElementById('emailnotAvaliable').style.display = "inline";
            }
        } else {
            alert("Error! Please try again.");
        }
    }
}

function checkCaptcha() {

    var answer = document.getElementById('captchaText').value;
    if (!isStringInRange(answer, 7, 7)) {
        document.getElementById('captchaError').style.display = "inline";
    } else {
        if (xmlhttp) {
            xmlhttp.open("GET", "pages/validateCaptcha.jsp?answer=" + answer, true);
            xmlhttp.onreadystatechange = function() {
                if (xmlhttp.readyState == 4) {
                    if (xmlhttp.status == 200) {
                        var res = xmlhttp.responseText; //Update the HTML Form element
                        if (res.match("false") != null) {
                            document.getElementById('captchaError').style.display = "inline";
                            document.getElementById('capCheck').value = "0";
                            borderRedError("captchaText");
                        } else {
                            document.getElementById('captchaError').style.display = "none";
                            document.getElementById('capCheck').value = "1";
                            document.getElementById('captchaText').style.border = "none";
                        }
                    }
                    else {
                        alert("Error during ajax call. Please try again");
                    }
                }
            };
            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp.send(null);
        }
    }
}

function handleCheckCaptchaServerResponse() {
    if (xmlhttp.readyState == 4) {
        if (xmlhttp.status == 200) {
            var res = xmlhttp.responseText; //Update the HTML Form element
            if (res.match("false") != null) {
                document.getElementById('captchaError').style.display = "inline";
                document.getElementById('capStatus').value = "invalid";
            } else {
                document.getElementById('capStatus').value = "valid";
            }
        }
        else {
            alert("Error! Please try again.");
            document.getElementById('capHide').value = "false";
        }
    }
}

