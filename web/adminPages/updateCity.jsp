<%-- 
    Document   : updateCity
    Created on : 24 Feb, 2015, 3:00:47 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript" src="validation/validate.js"></script>
<script type="text/javascript" src="js/ajaxedit.js"></script>
<script type="text/javascript" >
    function categorychange(){
        var category=document.getElementById("category").value;
        if(category == "newConfigCategory"){
            document.getElementById("newcategory1").style.display="inline";
            document.getElementById("isNewCategory").value="1";
        }else{
            document.getElementById("newcategory1").style.display="none";
            document.getElementById("isNewCategory").value="0";
        }
    }
    
</script>
<body> 
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <h3>City Data </h3>
    <div class="headmessage">Field marked with * are mandatory </div>
    <div class="form_settings">
        <div class="form_enclosure">
            
            <form action="doUpdateCity.html" method="post" onsubmit="return validateCityForm(this);">
                <s:if test="%{isNewConfig == 1}">
                    <input type="hidden" value="1" name="cityDetail.isNewConfig" id="isNew" />
                </s:if>
                <s:else> 
                    <input type="hidden" value="0" name="cityDetail.isNewConfig" id="isNew" />
                    <input type="hidden" id="cityId" name="cityDetail.cityId" value="<s:property value='cityDetail.cityId'/>"/>
                </s:else>
                <p><br/>
                    <span>Select State <sup><img src="images/star.png"></sup></span>
                     <select id="state" name="cityDetail.state.stateId">
                            <option value="-1">--Select State--</option>
                            <s:iterator value="stateList" var="stateList">
                                <s:if test="%{#stateList.stateId.equals(cityDetail.state.stateId)}" >
                                    <option selected value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="stateId"/>"><s:property value="stateName"/></option>
                                </s:else>                       
                            </s:iterator>
                            <%--s:if test="%{isNewConfig == 1}">
                                <option value="newConfigCategory">New State</option>
                            </s:if --%>
                        </select>                            
                    <label id="stateError"  class="errormsg"><s:property value="getText('instituteUpdate.NwstateError')"/></label>
                </p><br/>

                <input type="hidden" value="0" id="isNewCategory" name="lookupDetail.isNewCategory"/>
                <p>
                    <span>City Name <sup><img src="images/star.png"></sup></span>
                            <s:if test="%{isNewConfig == 1}">
                        <input type="text" id="cityName" name="cityDetail.cityName" value="<s:property value='cityDetail.code'/>" class="tipTip"  title="<s:property value="getText('form.rcid')"/>"/>                        
                    </s:if>
                    <s:else>     
                        <input type="text" id="cityName" name="cityDetail.cityName" value="<s:property value='cityDetail.cityName'/>" />                        
                        <!--<input type="text" id="code1"  value="<s:property value='cityDetail.cityName'/>"  readonly />-->                        
                    </s:else>
                    <label id="cityNameError"  class="errormsg"><s:property value="getText('instituteUpdate.NwcityError')"/></label>
                </p><br/> 
                <br/>
                <div class="radiobutton">
                    <p>
                        <span>Active / In-active <sup><img src="images/star.png"></sup></span>
                        <span class="s"  style="width: 270px; font-size: 90%">
                            <s:if test="cityDetail.isActive == 1 ">
                                <input  style="width: 13px;height: 13px;padding:0 0 0 0; " id="acco1" type="radio" name="cityDetail.isActive" value="1" checked  />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </s:if>
                            <s:else>                                           
                                <input style="width: 13px;height: 13px;padding:0 0 0 0; " id="acco1" type="radio" name="cityDetail.isActive" value="1" />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </s:else>                   

                            <s:if test="cityDetail.isActive == 0">
                                <input  style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="acco2" name="cityDetail.isActive" value="0" checked/>&nbsp;&nbsp;&nbsp; No
                            </s:if>
                            <s:else>                                         
                                <input style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="acco2" name="cityDetail.isActive" value="0" />&nbsp;&nbsp;&nbsp; No
                            </s:else>
                        </span>
                        <span id="isActiveError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('form.isActiveError')" /></span>
                    </p>
                </div>
                <br/><br/><br/>
                <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" /><input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="resetCityForm();"/></p>
            </form>
        </div>
    </div>
</body>