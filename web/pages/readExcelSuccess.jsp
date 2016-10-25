<%-- 
    Document   : readExcelSuccess
    Created on : 16 Jun, 2015, 11:58:03 AM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<script>
    function validateAllWithRespId(val) {

        if (!val == null || !val == "" || !val == 0) {
            validateAll(val);
        } else {
            alert("no value");
        }
    }

    function validateAll(val) {
        var data = "fileid=" + val;
        $.ajax({
            url: "pages/DAOGetValidateExcelData.jsp",
            type: "GET",
            data: data,
            dataType: "json",
            success: setValidateAll,
            error: onError
        });
    }

    function setValidateAll(data) {
        alert("validate Successfully")
        data = data.trim();
        var res_sp;
        var val_rs = 0, inval_rs = 0, totl_rs = 0;
        if (data != "") {
            res_sp = data.split("#");
            totl_rs = res_sp[0];
            val_rs = res_sp[1];
            inval_rs = res_sp[2];
            document.getElementById("totalnum").innerHTML = totl_rs;
            document.getElementById("validnum").innerHTML = val_rs;
            document.getElementById("invalidnum").innerHTML = inval_rs;
            if (totl_rs > 0) {
                document.getElementById("outRes").style.display = "inline";
            }
            if (inval_rs > 0) {
                document.getElementById("inValData").style.display = "inline";
            }if(val_rs > 0){
                document.getElementById("sendmailValid").style.display="inline";
            }

        } else {

        }
    }

    function onError(jqXHR, textStatus) {
        alert("Error : " + textStatus);
    }

    function showAllInvalidData(val) {
        var data = "fileid=" + val;
        $.ajax({
            url: "pages/DAOGetInvalidExcelData.jsp",
            type: "GET",
            data: data,
            dataType: "json",
            success: setAllInvalidData,
            error: onError
        });
    }

    function setAllInvalidData(data) {
       // alert(data)
        document.getElementById("invalres").style.display = "inline";
        var j = 0;
        var table = document.getElementById("tabbody");
        for (var i = 0; i < data.length; i++) {
            j++;
            var row = table.insertRow(i);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);

            //alert(data[i].per_workshopid)
            //  alert(data[i].email);
            //  alert(data[i].firstName);
            cell1.innerHTML = j;
            //   if (data[i].per_workshopid == 0) {
            //       cell2.innerHTML = "";
            //    } else if(data[i].per_workshopid != 0) {
            cell2.innerHTML = data[i].per_workshopid;
            //     }

            //     if (data[i].email == "") {
            //         cell3.innerHTML = "";
            //      } else if(data[i].email != ""){
            cell3.innerHTML = data[i].email;
            //    }

            //     if (data[i].firstName == "") {
            //        cell4.innerHTML = "";
            //     } else if(data[i].firstname !=""){
            cell4.innerHTML = data[i].firstName;
            //   }
            //   if (data[i].lastName == "") {
            //       cell5.innerHTML = "";
            //    } else {
            cell5.innerHTML = data[i].lastName;
            //   }
            //   if (data[i].institute.instituteName == "") {
            //       cell6.innerHTML = "";
            //   } else {
            cell6.innerHTML = data[i].institute.instituteName;
            //   }
            //    if (data[i].per_errormessage == "") {
            //       cell7.innerHTML = "";
            //    } else {
            //  var errors=data[i].per_errormessage;
            //  errors.replace('@',' ');
            var errors = data[i].per_errormessage.split("@").join(" ");
            var errormesg=errors.replace("@", " ");
            
            cell7.innerHTML = errors;
            //   }




        }

    }
    
    function sendMailToValidData(val){
         var data = "fileid=" + val;
        $.ajax({
            url: "pages/DAOSendMailToValidExcelData.jsp",
            type: "GET",
            data: data,
            dataType: "json",
            success: setAllValidExcelData,
            error: onError
        });
    }
    
    function setAllValidExcelData(data){
        alert('total mail send '+data);
        document.getElementById("sendMailRes").style.display="inline";
        document.getElementById("sendmailcount").innerHTML=data;
    }
</script>
<!DOCTYPE html>
<%
    String res = null;
    try {
        res = (String) session.getAttribute("result");
        session.removeAttribute("result");
        if (res == null) {
            res = "";
        }
    } catch (Exception e) {
        e.printStackTrace();
        res = "";
    }
%>
<body>
    <%-- View Data <input type="button" value="Click here" onclick=""/><br>--%>
    <% if (res.equals("success")) { %>
    <p id="suberr">Data Read and Inserted Successfully </p>

    validate data click here <input type="button" value="validate Data" onclick="validateAllWithRespId('<s:property value="uploadId"/>');">
    <br><br>
    <div id="outRes" style="display: none;">
        <p>Total Numbers of Records in file : <label id="totalnum"></label></p>
        <p>Total Numbers of Valid Records in file : <label id="validnum"></label></p>
        <p>Total Numbers of Invalid Records in file : <label id="invalidnum"></label></p>
    </div>
    <div id="inValData" style="display: none;">
        <p>To see Invalid Records and Reasons <input type="button" onclick="showAllInvalidData('<s:property value="uploadId"/>')" value="Click Here"></p>
    </div>
    <div id="invalres" style="display: none; height: 500px; overflow-y: scroll; border: 1px solid black;">
        
        <table>
            <thead>
                <tr>
                    <th>Sr No</th>
                    <th>Workshopid</th>
                    <th>Email</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Institute Name</th>
                    <th>Errors</th>
                </tr>
            </thead>
            <tbody id="tabbody">

            </tbody>
        </table>
    </div>
    <div id="sendmailValid" style="display: none;">
        To send mail to Valid Participants <input type="button" value="Click Here" onclick="sendMailToValidData('<s:property value="uploadId"/>')"/>
        <p id="sendMailRes" style="display: none;">
            <br>  Total Mail Send is : <label id="sendmailcount"></label>
        </p>
    </div>
     
    <% } else if (res.equals("fail")) {%>
    <p id="suberr">
        Unable to Perform operation..error <input type="button" style="width: 50px;" value="close"/>
    </p>
    <% }%>
</body>

