<%-- 
    Document   : viewInstituteHeadDetails
    Created on : 30 Mar, 2015, 12:59:08 PM
    Author     : asl
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">       
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title>'Project Name' | Empowerment of Students & Teachers through Synchronous and Asynchronous Instruction</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" href="css/tipTip.css"/>
<link rel="stylesheet" href="css/css3-buttons.css"/>
<!-- modernizr enables HTML5 elements and feature detects -->
<script type="text/javascript" src="js/modernizr-1.5.min.js"></script>   
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.easing-sooper.js"></script>
<script type="text/javascript" src="js/jquery.sooperfish.js"></script>
<script type="text/javascript" src="js/project_common.js"></script>
<script type="text/javascript" src="js/jquery.tipTip.minified.js"></script>
<script>
    var $jQuery1 = $.noConflict(true);
</script>
<style type="text/css">
    @import "template_table_2/jquery.dataTables.css";
</style>

<!--css added for the pagination and table css-->
<script type="text/javascript" language="javascript" src="template_table_2/jquery-1.11.1.min.js"></script>
<script type="text/javascript" language="javascript" src="template_table_2/jquery.dataTables.js"></script>
<script language="JavaScript" src="js/jquery.tipTip.minified.js"></script>
<script>
    var $jQuery2 = jQuery.noConflict(true);
</script>
<script type="text/javascript">
   /* $(function() {
        $(".tipTip").tipTip({defaultPosition: "right"});
    });*/
    
    $jQuery1(function() {
         $jQuery1(".tipTip").tipTip({defaultPosition: "right"});
    });
</script>
<script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<%@ taglib prefix="s" uri="/struts-tags" %>
<body>
    <s:if test='%{#session.loggedInUser.roleId > 1}'>
        <% String id = request.getParameter("instituteid");%>
        <div style="padding: 15px; overflow: auto; overflow-y: hidden;">
            <p style="width: 100%; border: 1px solid black; font-size: 18px; border-radius: 10px; background: #036; color: white;  padding-top: 3px; padding-bottom: 3px; text-align: center;" >
                <%= id%>&nbsp;&nbsp;
                <s:property value="institute.instituteName"/>
            </p><br>
            <s:if test='%{#session.loggedInUser.roleId == 3}'>

            </s:if>
            <s:else>
            <p style="padding: 10px;">
                <input style=" background: #0b370a; border-radius: 8px; border: 0; height: 25px; padding: 2px 0 3px 0; padding-left: 15px; padding-right: 15px; color: white;" type="button" value="Add New" onclick="addNewHead('<%= id%>')"/> <b>Click Here for Add New</b>
            </p><br><br>
            </s:else>
            <table id="mytable" class="table">
                <thead id="tablehead">
                    <tr>
                        <th>Head Name</th>
                        <th>Head Email</th>
                        <th>Head Address</th>
                        <th>Head Contact</th>
                        <th>Head Title</th>
                        <th>Head Designation</th>
                        <th>Head Stream</th>
                        <th>Head IsActive</th>
                      <s:if test='%{#session.loggedInUser.roleId == 3}'>

                      </s:if>
                      <s:else>
                        <th>Update</th>
                      </s:else>
                   </tr>
                </thead>
                <tbody id="mytable" name="tablebody">
                    <s:iterator value="headdetails">
                        <tr>
                            <td><s:property value="name"/></td>
                            <td><s:property value="email"/></td>
                            <td><s:property value="headaddress"/></td>
                            <td><s:property value="headphone"/></td>
                            <td><s:property value="headtitle.headTitleName"/></td>
                            <td><s:property value="headdesignation.headDesignationName"/></td>
                            <td><s:property value="stream.streamName"/></td>
                            
                                <s:if test="isActive == 0">
                                    <td>In Active</td>
                                </s:if>
                                <s:elseif test="isActive == -1">
                                    <td>Not Approved</td>
                                </s:elseif>
                                <s:elseif test="isActive == 1">
                                    <td>Active</td>
                                </s:elseif> 
                                <s:else>
                                    <td></td>
                                </s:else>   
                            
                            
                            <s:if test='%{#session.loggedInUser.roleId == 3}'>

                            </s:if>
                            <s:else>
                            <td>
                                <input style="border-radius: 8px; border: 0; height: 25px; padding: 2px 0 3px 0; padding-left: 15px; padding-right: 15px; background: #1e90ff; color: white;" type="button" onclick="updateHead('<%= id%>', '<s:property value="stream.streamId"/>')" value="Update"/>
                            </td>
                            </s:else>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>
        </div>
    </s:if> 
    <script>
        $jQuery2(function(){
            $jQuery2('#mytable').dataTable({
                // paging: false,
                //searching: false 
                //iDisplayLength: 50,
               // "order": []
            });
        });
    </script>
    <script type="text/javascript">
       /* $(document).ready(function() {
            $('#mytable').dataTable({
                // paging: false,
                //searching: false                                                                                             "scrollX": true
            });
        });*/
    
         /* $jQuery2(function(){
              $jQuery2('#mytable').dataTable({
                // paging: false,
                //searching: false                                                                                             "scrollX": true
            });
          });*/
    </script>
</body>
