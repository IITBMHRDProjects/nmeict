<%-- 
    Document   : displayPaymentDetails
    Created on : 3 Feb, 2016, 4:26:52 PM
    Author     : dipesh
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.project.utilities.SimpleStringCipher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags" %>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<%
    SimpleStringCipher cipher = new SimpleStringCipher();
    String update = (request.getParameter("update"));
    String decrypt_update = cipher.decrypt(update);

%>
<body>
    <s:if test='%{#session.loggedInUser != null && #session.loggedInUser.roleId != 1}'>
        <div style="text-align: center;">
            <h2 style="color: #183d83;"><b>Workshops Index</b></h2>
        </div>
        <div class="" style="width: 99%; overflow: scroll; margin-left: 10px;"> 
            <table id="mytable" class="table" style="">
                <thead id="tablehead" name="tablehead">
                    <tr>
                        <th>Workshop Id</th>
                        <th>Workshop Name</th>
                        <th>Payment Details</th>
                        <th>Total Registered</th>
                        <th>Total Amount</th>
                    </tr>
                </thead>
                <tbody id="mytablebody"  name="tablebody">
                    <s:iterator value="workshopContents" status="userStatus">
                        <s:if test="%{categorycode ==5 || categorycode == 7|| categorycode == 8}">
                            <tr id="session_">

                                <td><s:property value="workshopid"/></td>
                                <td><s:property value="workshopname"/></td>
                                <s:if test="%{categorycode == 8}">
                                    <%
                                        String ssdate = "";
                                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                        Date convertedCurrentDate = sdf.parse("2016-01-01");
                                        String payWorlkshopStart = sdf.format(convertedCurrentDate);
                                        try {
                                            ssdate = (String) request.getAttribute("startdatereg");
                                            System.out.println(ssdate);
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    %>
                                    <% if (ssdate.compareTo(payWorlkshopStart) >= 0) {%>
                                    <td><a href="paymentDetails.html?workshopid=<s:property value="workshopid_encrypted"/>">Click Here</a></td>
                                    <td><s:property value="totalCount"/></td>
                                    <td><s:property value="totalSumOfPayment"/></td>
                                    <% } else { %>
                                    <td>NA</td>
                                    <td><s:property value="totalCount"/></td>
                                    <td>NA</td>
                                    <% } %>
                                </s:if><s:else>
                                    <td>NA</td>
                                    <td><s:property value="totalCount"/></td>
                                    <td>NA</td>
                                </s:else>
                            </tr>
                        </s:if>
                    </s:iterator>
                </tbody>
            </table>


            <%--
            <table id="mytable" class="table" style="">
                <thead id="tablehead" name="tablehead">
                    <tr>
                        <td>Workshop Id</td>
                        <td>Workshop Name</td>
                        <td>Details</td>
                    </tr>
                </thead>
                <tbody>
                    <s:iterator value="workshopContents">
                        <s:if test="%{workshopExpiry == 1}">
                            <tr>     
                                <% if (decrypt_update.equals("paymentdetails")) {
                                %>      
                                <s:if test="%{categorycode ==5 || categorycode == 7}">
                                    <td><s:property value="workshopid"/></td>
                                    <td><s:property value="workshopname"/></td>
                                    <s:if test="%{categorycode == 7}">
                                        <td><a href="paymentDetails.html?workshopid=<s:property value="workshopid_encrypted"/>">Click Here</a></td>
                                    </s:if><s:else>
                                        <td></td>
                                    </s:else>

                                </s:if>
                                <%  }
                                %>

                            </tr>
                        </s:if>
                    </s:iterator>

                </tbody> 
            </table>--%>
        </div>
    </s:if>
    <s:else>
    </s:else>
    <script type="text/javascript">
        /*$(document).ready(function () {
    $('#mytable').dataTable({
        // paging: false,
        //searching: false 
        iDisplayLength: 25,
        "order": []
    });
});*/
        
        $(document).ready(function () {
            $('#mytable').dataTable({
                // paging: false,
                //searching: false 
                iDisplayLength: 10,
                "order": []
            });
        });
    </script>
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
</body>



