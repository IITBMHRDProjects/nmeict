<%-- 
    Document   : createProgramAttendance
    Created on : 19 May, 2015, 10:08:34 AM
    Author     : Abinaya
--%>

<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>   
    <head>
        <!--for autocomplete jquery--> 
        <!--        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
                <script src="//code.jquery.com/jquery-1.10.2.js"></script>
                <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>-->
        <!--for date picker-->
        <link rel="stylesheet" href="css/datepicker-jquery-ui.css">
        <script src="js/jquery-1.11.1.min.js"></script>
        <script src="js/datepicker-jquery-ui.js"></script>
        <link rel="stylesheet" href="css/jquery.timepicker.css">
        <script src="js/jquery.timepicker.js"></script>
        <script type="text/javascript" language="JavaScript" src="js/ajaxedit.js"></script>
        <script src="validation/validate.js"></script>
        <script>
            function loadDateOfInput() {
                $(".datefield").datepicker({ dateFormat: 'dd-mm-yy' }) 
                $(".datefield1").datepicker({ dateFormat: 'dd-mm-yy' })                    
            }
            function loadTimeOfInput() {
                $(".timepicker").timepicker({ 
                    scrollbar: true,
                    interval :5,  
                    minHour: 8,maxHour: 20 , 
                    timeFormat: 'HH:mm',
                    change: function(time) {
                        // the input field
                        var element = $(this), text;
                        // get access to this TimePicker instance
                        var timepicker = element.timepicker();
                        text = 'Selected time is: ' + timepicker.format(time);
                        element.siblings('span.help-line').text(text);
                    }
                })                 
            }
            function loadDateOfUpdateTill(){               
                $(".datefield1").datepicker({ dateFormat: 'dd-mm-yy' })               
                         
            }
        </script>         
        <script type="text/javascript">
            function createSession(no_of_days){
                // check if its a number else give error;
                var division=document.getElementById("total_sessions");  
                // clear previous values
                division.innerHTML="";
               
                // create the number of elements as per days
                for(var j=1, k=0;j <= no_of_days; j++, k++){
                    // create para
                    var p=document.createElement("p");
                    p.id=k;
                    p.textContent="Day "+j+" :";
                    //p.style.fontWeight="bold";
                    var break1=document.createElement("br");
                    p.appendChild(break1);
                    p.appendChild(break1);
                    // add span as child
                    var span2=document.createElement("span");
                    span2.textContent="Enter the date";
                    
                    // for star in sup
                    var sup=document.createElement("sup");
                    var img=document.createElement("img");
                    img.src = "images/star.png";
                    sup.appendChild(img);
                    span2.appendChild(sup);
                    
                    
                    // add input as child
                    var input2=document.createElement("input");
                    input2.type="text";
                    input2.name = "schedule["+k+"].dateOfSession";
                    input2.id = "date_of_day"+j; 
                    input2.className= "datefield";
                    input2.readonly=true;
                   
                    // add update till field here
                    input2.onchange=function addUpdateTill(){                       
                        // for setting the date after 2 days
                        
                        var i1=this.value;
                        var kk=this.id;
                        var res=kk.split("day");
                        var date2 = $('#'+kk).datepicker('getDate', { dateFormat: 'dd-mm-yy' });
                        // set default date as session date + 2 days
                        date2.setDate(date2.getDate()+2);   
                        // change to date format dd-mm-yyyy
                        var dd = date2.getDate();
                        var mm = date2.getMonth()+1; //January is 0!
                        var yyyy = date2.getFullYear();
                        if(dd < 10){dd = '0'+ dd;}
                        if(mm < 10){mm = '0' + mm;}
                        var temp_date = dd+'-'+mm+'-'+yyyy;
                        document.getElementById("date_till_1"+res[1]).value=temp_date;
                        // append the div's child nodes                                                       
                        
                    }
                   
                    // onclick load date               
                    //input2.onload(loadDateOfInput(j)); 
                    
                    p.appendChild(span2);
                    p.appendChild(input2);
                    var break2=document.createElement("br");
                    p.appendChild(break2);
                    p.appendChild(break2);
                    //                    p.appendChild(break2);
                    // add span as child
                    var span1=document.createElement("span");
                    span1.textContent="Enter number of sessions";                    
                    
                    // for star in sup
                    var sup1=document.createElement("sup");
                    var img1=document.createElement("img");
                    img1.src = "images/star.png";
                    sup1.appendChild(img1);
                    span1.appendChild(sup1);
                    // add input as child
                    var input1 = document.createElement("input");
                    input1.type = "text";
                    input1.name = "schedule["+k+"].numberOfSessions";
                    input1.id = "sessions_of_day"+j;
                    input1.onchange=function session_Comments(){
                       
                        var i1=this.value;
                        var kk=this.id;
                        var res=kk.split("day");
                        var div_id=res[1]-1;  
                        // clear previous div
                        var elem = document.getElementById("comment_div_"+div_id);                       
                        elem.innerHTML = '';
                        // append new div
                        var div_to_be_appended = document.getElementById("comment_div_"+div_id);
                       
                        for(var l=0;l<i1;l++){
                            //time slot span
                            var span_time=document.createElement("span");
                            span_time.textContent="Time Slot for session"+(l+1);
                            span_time.style.fontWeight="bold";
                            
                            var time_input=document.createElement("input");
                            time_input.type="text";
                            time_input.name="schedule["+div_id+"].session_time["+l+"]";
                            time_input.id = "time_of_day"+res[1]+"session"+l; 
                            time_input.value=" ";
                            time_input.className= "timepicker";
                            //time_input.setAttribute("readonly", true);
                            time_input.style="width:110px;"
                            // time slot to
                            var span_time_to=document.createElement("span");
                            span_time_to.textContent="Time for session"+(l+1)+" - To";
                            var time_input_to=document.createElement("input");
                            time_input_to.type="text";
                            time_input_to.name="schedule["+div_id+"].session_time_to["+l+"]";
                            time_input_to.id = "time_of_day"+res[1]+"session_to"+l; 
                            time_input_to.value=" ";
                            time_input_to.className= "timepicker";
                            //time_input_to.setAttribute("readonly", true);
                            time_input_to.style="width:110px;"
                            
                            var span_time1=document.createElement("span");
                            span_time1.textContent="Topic of session"+(l+1);
                            var time_input1=document.createElement("textarea");
                            time_input1.type="text";
                            time_input1.name="schedule["+div_id+"].session_comm["+l+"]";
                            time_input1.id = "comm_of_day"+res[1]+"session"+l; 
                            time_input1.value=" ";
                            
                            //comment/topic span
                            var span3=document.createElement("span");
                            span3.textContent="Topic/Schedule for the session "+(l+1);
                            // add input as child 
                            var input3=document.createElement("textarea");
                            input3.type="text";
                            input3.name="schedule["+div_id+"].session_comment["+l+"]";
                            input3.id = "comments_of_day"+res[1]+"session"+l; 
                            input3.value=" ";
                            input3.setAttribute("spellcheck","true");
                            
                            // span for radio button
                            
                            //comment/topic span
                            var span_radio_msg=document.createElement("span");
                            span_radio_msg.textContent="if attendance counted for the session "+(l+1);
                            // add input as child 
                            var span_radio_msg1=document.createElement("span");
                            span_radio_msg1.className="s";
                            span_radio_msg1.style="width: 270px; font-size: 90%";
                          
                            /*create text node for Radio button*/
                            var textYes = document.createTextNode("Yes");
                            textYes.style="position:relative;left:15px;";
                            var textNo = document.createTextNode("No");
                            textNo.style="position:relative;left:15px;";
                            
                            var radio1=document.createElement("input");
                            radio1.type="radio";
                            radio1.name="schedule["+div_id+"].session_radio["+l+"]";
                            radio1.id = "radio_of_day"+res[1]+"session"+l; 
                            radio1.value="1";
                            radio1.setAttribute("checked", "checked");
                            radio1.style=" width: 13px;height: 13px;padding:0 0 0 0;";
                            
                            var radio2=document.createElement("input");
                            radio2.type="radio";
                            radio2.name="schedule["+div_id+"].session_radio["+l+"]";
                            radio2.id = "radio_of_day"+res[1]+"session"+l; 
                            radio2.value="0";
                            radio2.style=" width: 13px;height: 13px;padding:0 0 0 0;";
                            
                            
                            div_to_be_appended.appendChild(span_time);
                            div_to_be_appended.appendChild(time_input);                            
                            var text=document.createElement("text");
                            text.textContent=" to ";
                            //                            div_to_be_appended.appendChild(span_time_to);
                            div_to_be_appended.appendChild(text);
                            div_to_be_appended.appendChild(time_input_to);
                            var break10=document.createElement("br");
                            div_to_be_appended.appendChild(break10);
                            div_to_be_appended.appendChild(break10);
                            var break7=document.createElement("br");
                            div_to_be_appended.appendChild(break7);
                            div_to_be_appended.appendChild(break7);
                            div_to_be_appended.appendChild(span_time1);
                            div_to_be_appended.appendChild(time_input1);
                            var break4=document.createElement("br");
                            div_to_be_appended.appendChild(break4);
                            div_to_be_appended.appendChild(break4);
                            
                           
                            span_radio_msg1.innerHTML += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'; 
                            span_radio_msg1.appendChild(radio1);    
                            span_radio_msg1.appendChild(textYes);
                            span_radio_msg1.innerHTML += '&nbsp;&nbsp;&nbsp;'; 
                            span_radio_msg1.innerHTML += '&nbsp;&nbsp;&nbsp;';                            
                            span_radio_msg1.appendChild(radio2);                 
                            span_radio_msg1.appendChild(textNo);                           
                           
                            
                            var div_radio=document.createElement("div");
                            div_radio.className="radiobutton";
                            div_radio.appendChild(span_radio_msg);
                            div_radio.appendChild(span_radio_msg1);
                           
                           
                            var break9=document.createElement("br");
                            div_to_be_appended.appendChild(break9);
                            div_to_be_appended.appendChild(div_radio);
                           
                           
                            var break8=document.createElement("br");                           
                            div_to_be_appended.appendChild(break8);
                            div_to_be_appended.appendChild(break8);
                            
                           
                            var break11=document.createElement("br");
                            div_to_be_appended.appendChild(break11);
                            div_to_be_appended.appendChild(break11);
                            var break12=document.createElement("br");
                            div_to_be_appended.appendChild(break12);
                            div_to_be_appended.appendChild(break12);
                            var break13=document.createElement("br");
                            div_to_be_appended.appendChild(break13);
                            div_to_be_appended.appendChild(break13);                             
                        }
                        loadTimeOfInput();loadDateOfInput();
                    };                   
                    
            
                    p.appendChild(span1);
                    p.appendChild(input1);
                    var break3=document.createElement("br");
                    p.appendChild(break3);
                    p.appendChild(break3);
                    // update till date
                    var span4=document.createElement("span");
                    span4.textContent="Valid for update till";
                    var date_till=document.createElement("input");
                    date_till.type="text";
                    date_till.name="schedule["+k+"].date_till_1";
                    date_till.id = "date_till_1"+j; 
                    date_till.className="datefield1";
                    date_till.value=null;
                    p.appendChild(span4);
                    p.appendChild(date_till);
                    var break14=document.createElement("br");
                    p.appendChild(break14);
                    p.appendChild(break14);
                                       
                    var comment_division=document.createElement("div");
                    comment_division.id="comment_div_"+k;
                    // append it to the division
                    division.appendChild(p);
                    division.appendChild(comment_division);
                    //create break and add to division
                    var break_div=document.createElement("br");
                    division.appendChild(break_div);
                    loadDateOfInput();
                }
           
            }            
           
            function resetForm(){
                document.getElementById("sessions").value="";
                document.getElementById("total_sessions").innerHTML="";
            }
        </script> 
    </head>
    <body>
        <s:iterator value="workshopContent">
            <h3>Programme Schedule</h3>
            <div class="headmessage">Field marked with * are mandatory </div>
            <div class="form_enclosure">        
                <h1><s:property value="workshopname" /></h1>
                <h4 align="center">National Mission on Education through ICT (MHRD, Govt. of India)</h4>
                <br/>
                <h4 align="center"><b><s:property  value="startdate"/> to <s:property value="enddate"/></b></h4>    

                <form action="doCreateProgramSchedule.html?workshopid=<s:property value="workshopid_encrypted"/>" method="post" onsubmit="return validateScheduleForm(this);">

                    <p style="display:none"><input type="hidden" id="categorycode" name="workshopContent.categorycode" value="<s:property value="categorycode"/>"></p>
                    <p style="display:none"><input type="hidden" id="workshopid" name="workshopContent.workshopid" value="<s:property value="workshopid"/>"></p>
                    <p style="display:none"><input type="hidden" id="workshopname" name="workshopContent.workshopname" value="<s:property value="workshopname"/>"></p>
                    <p style="display:none"><input type="hidden" id="accommodation" name="workshopContent.accommodation" value="<s:property value="accommodation"/>"></p>
                    <p style="display:none"><input type="hidden" id="permission_ifreq" name="workshopContent.permissionIfRequired" value="<s:property value="permissionIfRequired"/>"></p>
                    <p style="display: none"><input type="hidden" id="resCoWorkshopid" name="workshopContent.respectiveCoWorkshopid" value="<s:property value="respectiveCoWorkshopid"/>"></p>

                    <div class="form_settings">
                        <div class="form_box">
                            <h2><b>STTP Details</b></h2><br/>
                            <p><span>Enter the number of days</span>
                                <input type="text" id="sessions" style="font-size: 110%;" value="" onblur="createSession(this.value);"/>
                            </p>
                            <div id="total_sessions">

                            </div>                           
                            <p>
                                <input style="position: relative;right: 50px" class="submit" type="submit" name="submit" value="Submit" />
                                <input style="position: relative; right:75px"  class="submit" type="button" name="reset" value="Reset" onclick="resetForm();"/>
                            </p>
                        </div>                      
                    </div>                        
                </form>         
            </div>
        </s:iterator>
    </body>
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
</html>
