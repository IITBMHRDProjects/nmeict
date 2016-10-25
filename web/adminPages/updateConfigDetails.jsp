<%-- 
    Document   : updateConfigDetails
    Created on : 18 Feb, 2015, 2:44:54 PM
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
    <h3>Configuration Data </h3>
    <div class="headmessage">Field marked with * are mandatory </div>
    <div class="form_settings">
        <div class="form_enclosure">
            <p style="display:none;">
                <input type="text" value="<s:property value='lookUpDetail.category'/>"/>
                <s:iterator value="lookups" >
                    <input type="text" value="<s:property value='category'/>**<s:property value='lookUpDetail.category'/>"/>
                </s:iterator>

            </p>

            <form action="doUpdateConfig.html" method="post" onsubmit="return validateConfigForm(this);">
                <s:if test="%{isNewConfig == 1}">
                    <input type="hidden" value="1" name="lookUpDetail.isNewConfig" id="isNew" />
                </s:if>
                <s:else> 
                    <input type="hidden" value="0" name="lookUpDetail.isNewConfig" id="isNew" />
                </s:else>
                <p><br/>
                    <span>Select Config Table <sup><img src="images/star.png"></sup></span>

                    <s:if test="%{isNewConfig == 1}">
                        <select id="category" name="lookUpDetail.category" onchange="categorychange();">
                            <option value="-1">--Select Category--</option>
                            <s:iterator value="lookups" var="lookups">
                                <s:if test="%{#lookups.category.equals(lookUpDetail.category)}" >
                                    <option selected value="<s:property value="category"/>"><s:property value="category"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="category"/>"><s:property value="category"/></option>
                                </s:else>                       
                            </s:iterator>
                            <s:if test="%{isNewConfig == 1}">
                                <option value="newConfigCategory">New Category</option>
                            </s:if>
                        </select>
                    </s:if><s:else>
                        <s:iterator value="lookups" var="lookups">
                            <s:if test="%{#lookups.category.equals(lookUpDetail.category)}" >
                                <input type="hidden" id="category" name="lookUpDetail.category" value="<s:property value="category"/>"/>
                            </s:if>                                                 
                        </s:iterator>
                        <select id="category1" name="lookUpDetail.category" disabled>
                            <option value="-1">--Select Category--</option>
                            <s:iterator value="lookups" var="lookups">
                                <s:if test="%{#lookups.category.equals(lookUpDetail.category)}" >
                                    <option selected value="<s:property value="category"/>"><s:property value="category"/></option>
                                </s:if>
                                <s:else>
                                    <option value="<s:property value="category"/>"><s:property value="category"/></option>
                                </s:else>                       
                            </s:iterator>                           
                        </select>
                    </s:else>               
                    <label id="categoryError"  class="errormsg"><s:property value="getText('form.categoryError')"/></label>
                </p><br/>

                <p id="newcategory1" style="display:none;">
                    <span>Enter New Category <sup><img src="images/star.png"></sup></span>
                            <s:if test="%{isNewConfig == 1}">
                        <input type="text" id="newCategory" name="lookUpDetail.newCategory" value="" class="tipTip"  title="<s:property value="getText('form.rcid')"/>"/>                        
                    </s:if>                    
                    <label id="newCategoryError"  class="errormsg"><s:property value="getText('form.newCategoryError')"/></label>
                    <br/> <br/>
                </p>
                <input type="hidden" value="0" id="isNewCategory" name="lookupDetail.isNewCategory"/>
                <p>
                    <span>Code <sup><img src="images/star.png"></sup></span>
                            <s:if test="%{isNewConfig == 1}">
                        <input type="text" id="code" name="lookUpDetail.code" value="<s:property value='lookUpDetail.code'/>" class="tipTip"  title="<s:property value="getText('form.rcid')"/>"/>                        
                    </s:if>
                    <s:else>     
                        <input type="hidden" id="code" name="lookUpDetail.code" value="<s:property value='lookUpDetail.code'/>" />                        
                        <input type="text" id="code1"  value="<s:property value='lookUpDetail.code'/>"  readonly />                        
                    </s:else>
                    <label id="codeError"  class="errormsg"><s:property value="getText('form.codeError')"/></label>
                </p><br/> 
                <p>
                    <span>Description <sup><img src="images/star.png"></sup></span>
                    <input type="text" id="description" name="lookUpDetail.description" value="<s:property value='lookUpDetail.description'/>" class="tipTip"  title="<s:property value="getText('form.rcid')"/>"/>                        
                    <label id="descriptionError"  class="errormsg"><s:property value="getText('form.descriptionError')"/></label>
                </p><br/> 
                <p>
                    <span>Comments</span>
                    <input type="text" id="comment" name="lookUpDetail.comment" value="<s:property value='lookUpDetail.comment'/>" class="tipTip"  title="<s:property value="getText('form.rcid')"/>"/>                        
                </p><br/><br/>
                <div class="radiobutton">
                    <p>
                        <span>Active / In-active <sup><img src="images/star.png"></sup></span>
                        <span class="s"  style="width: 270px; font-size: 90%">
                            <s:if test="lookUpDetail.isactive == 1 ">
                                <input  style="width: 13px;height: 13px;padding:0 0 0 0; " id="acco1" type="radio" name="lookUpDetail.isactive" value="1" checked  />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </s:if>
                            <s:else>                                           
                                <input style="width: 13px;height: 13px;padding:0 0 0 0; " id="acco1" type="radio" name="lookUpDetail.isactive" value="1" />&nbsp;&nbsp;&nbsp;&nbsp; Yes   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </s:else>                   

                            <s:if test="lookUpDetail.isactive == 0">
                                <input  style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="acco2" name="lookUpDetail.isactive" value="0" checked/>&nbsp;&nbsp;&nbsp; No
                            </s:if>
                            <s:else>                                         
                                <input style="width: 13px;height: 13px;padding:0 0 0 0; " type="radio" id="acco2" name="lookUpDetail.isactive" value="0" />&nbsp;&nbsp;&nbsp; No
                            </s:else>
                        </span>
                        <span id="isActiveError" class="errormsg" style="left: 40px;bottom: 15px;"><s:property value="getText('form.isActiveError')" /></span>
                    </p>
                </div>
                <br/><br/><br/>
                <p><input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" /><input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="resetConfigForm();"/></p>
            </form>
        </div>
    </div>
</body>