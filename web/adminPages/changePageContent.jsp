<%-- 
    Document   : changePageContent
    Created on : 5 Mar, 2015, 5:57:20 PM
    Author     : asl
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s"  uri="/struts-tags"%>
<style>
    .content{
        height: 300px;
        width: 95%;
        border: 1px solid black;
        overflow: scroll;
        padding-left: 10px;
    }

    .button_view{
        width: 100px;
        background: black; 
        color: white; 
        border-radius: 10px; 
        padding: 4px;
    }

    .comments{
        height: 150px;
        width: 60% ;
        /*border: 1px solid black;*/
        margin-right: 5%;
        /*overflow: scroll;*/
        float: right;
        padding-left: 10px;
        padding-top: 5px;
    }

    #mastertable{
        width: 100%;
    }

    .tablePart1{
        width: 36%;
        padding: 10px;
    }

    .tablePart2{
        width: 12%;
    }

    .tablePart3{
        width: 50%;
    }
</style>
<body>
    <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId != 1}'>
        <table id="mastertable" cellspacing="5">
            <tr>
                <td class="tablePart1" colspan="2">
                    <p>
                        <label style="font-size: 15px; padding-left: 0.8%;"><b>Select the Page :</b></label> 
                        <select id="selectPageType" name="pageType" onchange="getContentData(this.value)">
                            <option value="-1">Select Page </option>
                            <s:iterator value="content">
                                <option value="<s:property value="name"/>"><s:property value="description"/></option>
                            </s:iterator>
                        </select>
                    </p>
                </td>

                <td class="tablePart3">
                    <span style="margin-left: 0.5%;"><label style="font-size: 15px;"><!--<b>Page Type : </b>--></label>
                        <input type="radio" id="class_type1" name="class_type" value="1" style=""/> <b>Public Page</b>&nbsp;&nbsp;&nbsp;
                        <input type="radio" id="class_type2" name="class_type" value="2" style=""/> <b>User Page</b>&nbsp;&nbsp;&nbsp;
                        <input type="radio" id="class_type3" name="class_type" value="3" style=""/> <b>Participant</b>
                    </span>
                </td>
            </tr>
            <tr>
                <td class="tablePart1">
                    <br>
                    <div style="height: 300px; width: 90%; border: 1px solid black; margin-left: 2%;  float: left;">
                        <textarea id="htmlcontent" name="htmlcontent" rows="18" cols="60%" style="width: 95%;"></textarea>
                    </div>
                    <br>
                </td>
                <td class="tablePart2">
                    <div id="function" style="margin-left: 5%; float: left; text-align: center; vertical-align: top;">
                        <input type="button" value="Preview" class="button_view" onclick="previewContent()"/><br><br>
                        <input type="button" value="Submit" class="button_view" onclick="submitContent('<s:property value="%{#session.loggedInUser.loginId}"/>')"/><br><br>
                        <input type="reset" value="Reset" class="button_view" onclick="resetContent()"/>
                    </div>
                </td>
                <td>
                    <br>
                    <div id="content" class="content">

                    </div>
                    <br>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <label style="vertical-align: top; padding-left: 20px; font-size: 11px;"><b> Comments <sup><img src="images/star.png"></sup> </b></label> 
                </td>
                <td>
                    <textarea id="txtcomment" name="txtcomments" rows="5" cols="80"></textarea>
                    <br><label id="commentError" style="color: red; font-size: 12px;"></label>
                </td>
            </tr>
        </table>
    </s:if>
    <script>
        $(document).ready(function () {
            document.getElementById("class_type1").disabled = true;
            document.getElementById("class_type2").disabled = true;
            document.getElementById("class_type3").disabled = true;
        });
    </script>
</body>
