<%-- 
    Document   : team
    Created on : 25 Aug, 2014, 7:08:02 PM
    Author     : mayank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags" %>
<body> 
    <!-- Message Error -->
    <s:if test="hasActionErrors()">
        <div class="msg msg-error">
            <s:actionerror/>
            <a href="javascript:void(0);" class="close">close</a>
        </div>
    </s:if>
    <!-- End Message Error -->

    <h3>People</h3>
    <div class="headmessage">Click on the tabs to see the people in that team</div>
    <div class="form_enclosure">
        <div id="scroller-header"></div>
        <div style="padding: 0px 5px 0px 5px; width:98.8%; border: 1px solid #d8d8d8; border-radius: 4px;">
            <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: left;">
                <span style="font-size:14px; color:#2828283;">
                    <b>Principal Investigator</b>
                </span>
                <div style="clear: both;"></div>
                <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                    <div style="float:left; width:90px;">
                        <img width="85" src="team_photos/dbp-photo.gif"/>    
                    </div>
                </div>
                <div style="float:left; width:260px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                    <b>Prof. D. B. Phatak</b><br/>
                    <span style=" font-size:11px;">
                        (Subrao M. Nilekani Chair Professor)
                    </span>
                </div>
            </div>
            <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: right;">
                <span style="font-size:14px; color:#2828283;">
                    <b>Program Director</b>
                </span>
                <div style="clear: both;"></div>
                <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                    <div style="float:left; width:90px;">
                        <img width="85" src="team_photos/Avinash.jpg"/>    
                    </div>
                </div>
                <div style="float:left; width:260px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                    <b>Prof. Avinash Awate</b><br/>
                    <span style=" font-size:11px;">
                        (Program Director)
                    </span>
                </div>
            </div>
            <div style="clear: both;"></div>
            <br/>

            <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; float: left;">
                <span style="font-size:14px; color:#2828283;">
                    <b>Technical Advisor</b>
                </span>
                <div style="clear: both;"></div>
                <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                    <div style="float:left; width:90px;">
                        <img width="85" src="team_photos/default.jpg"/>    
                    </div>
                </div>
                <div style="float:left; width:260px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                    <b>Prof. Prakash Vaidya</b><br/>
                    <span style=" font-size:11px;">
                        (Technical Advisor)
                    </span>
                </div>
            </div>
            <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; float: right;">
                <span style="font-size:14px; color:#2828283;">
                    <b>Technical Advisor</b>
                </span>
                <div style="clear: both;"></div>
                <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                    <div style="float:left; width:90px;">
                        <img width="85" src="team_photos/default.jpg"/>    
                    </div>
                </div>
                <div style="float:left; width:260px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                    <b>Dr. Rajendra Lagu</b><br/>
                    <span style=" font-size:11px;">
                        (Technical Advisor)
                    </span>
                </div>
            </div>
            <div style="clear: both;"></div>
        </div>
        <br/><hr><br/>
        
        <%--Teams description starts here --%>
        <div style="margin-top: 10px; margin-bottom:10px;"><b>The Teams</b></div>
        <div class="liquid-slider" id="slider-id">
            
            <%-- Technical Team Starts Here --%>
            <div>
                <h2 class="title" id="teamtitle">Technical Team</h2>
                <div style="padding: 0px 5px 0px 5px; width:98.6%; border: 1px solid #d8d8d8; border-radius: 4px;">
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/Avinash.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Prof. Avinash Awate</b><br/>
                            <span style=" font-size:11px;">
                                (Program Director)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/Mayank.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Mayank Paliwal</b><br/>
                            <span style=" font-size:11px;">
                                (Software Engineer)
                            </span>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <br/>

                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; border-bottom: 1px solid #d8d8d8; border-radius: 4px; margin-bottom:4px; width:49%; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/Abinaya.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Miss Abinaya V.</b><br/>
                            <span style=" font-size:11px;">
                                (Software Engineer)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; border-bottom: 1px solid #d8d8d8; border-radius: 4px;  margin-bottom:4px; width:49%; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/Rajanikant.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Rajanikant Jangir</b><br/>
                            <span style=" font-size:11px;">
                                (Software Engineer)
                            </span>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <br/>
                    
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; border-bottom: 1px solid #d8d8d8; border-radius: 4px;  margin-bottom:4px; width:49%; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/default.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Dipesh Pawar</b><br/>
                            <span style=" font-size:11px;">
                                (Technical Assistant)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; border-bottom: 1px solid #d8d8d8; border-radius: 4px;  margin-bottom:4px; width:49%; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/default.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Dipesh Pawar</b><br/>
                            <span style=" font-size:11px;">
                                (Technical Assistant)
                            </span>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <br/>
                    
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/Abhilash.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Abhilash K.S.</b><br/>
                            <span style=" font-size:11px;">
                                (Project Manager - System Admin)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/Shwetha.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mrs. Shwetha Kiran</b><br/>
                            <span style=" font-size:11px;">
                                (Sr.System Admin)
                            </span>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                </div>
            </div>
            <%-- Technical Team Ends Here --%>

            <%-- Admin & Logistics Team Starts Here --%>
            <div>
                <h2 class="title" id="teamtitle">Admin & Logistics Team</h2>
                <div style="padding: 0px 5px 0px 5px; width:98.6%; border: 1px solid #d8d8d8; border-radius: 4px;">
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/mukta.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mrs. Mukta Atrey</b><br/>
                            <span style=" font-size:11px;">
                                (Sr. Project Manager - Admin)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/Mahendra.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Mahendra Parmar</b><br/>
                            <span style=" font-size:11px;">
                                (Project Manager - Admin)
                            </span>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <br/>

                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/default.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Ms. Kanan Dhebar</b><br/>
                            <span style=" font-size:11px;">
                                (Project Manager - Admin)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/default.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mrs. Rachna</b><br/>
                            <span style=" font-size:11px;">
                                (Project Manager - Admin)
                            </span>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                </div>
            </div>
            <%-- Admin & Logistics Team Ends Here --%>

            <%-- Accounts Team Starts Here --%>
            <div>
                <h2 class="title" id="teamtitle">Accounts Team</h2>
                <div style="padding: 0px 5px 0px 5px; width:98.6%; border: 1px solid #d8d8d8; border-radius: 4px;">
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/jaya.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mrs. Jaisheela Gaitonde</b><br/>
                            <span style=" font-size:11px;">
                                (Sr. Project Manager - Accounts)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/default.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Ms. Deepa Namagiri</b><br/>
                            <span style=" font-size:11px;">
                                (Assistant Project Manager)
                            </span>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <br/>

                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; border-bottom: 1px solid #d8d8d8; border-radius: 4px; margin-bottom:4px; width:49%; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/default.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Ms. Janhvi More</b><br/>
                            <span style=" font-size:11px;">
                                (Sr. Project Assistant)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; border-bottom: 1px solid #d8d8d8; border-radius: 4px;  margin-bottom:4px; width:49%; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/default.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mohd. Merajuddin</b><br/>
                            <span style=" font-size:11px;">
                                (Sr. Project Assistant)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/default.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mrs. Darshana Nitin Kadam</b><br/>
                            <span style=" font-size:11px;">
                                (Project Assistant)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/default.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Sushant Bammkant</b><br/>
                            <span style=" font-size:11px;">
                                (Project Assistant)
                            </span>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                </div>
            </div>
            <%-- Accounts Team Ends Here --%>

            <%-- Contents Team Starts Here --%>
            <div>
                <h2 class="title" id="teamtitle">Contents Team</h2>
                <div style="padding: 0px 5px 0px 5px; width:98.6%; border: 1px solid #d8d8d8; border-radius: 4px;">
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/kalpana.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mrs. Kalpana Kannan</b><br/>
                            <span style=" font-size:11px;">
                                (Sr. Project Manager - Contents)
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <%-- Contents Team Ends Here --%>

            <%-- Studio Team Starts Here --%>
            <div>
                <h2 class="title" id="teamtitle">Studio Team</h2>
                <div style="padding: 0px 5px 0px 5px; width:98.6%; border: 1px solid #d8d8d8; border-radius: 4px;">
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/sajjan.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Sajjan Kumar Dixit</b><br/>
                            <span style=" font-size:11px;">
                                (Sr. Project Manager - Technical)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; border-bottom: 1px solid #d8d8d8; border-radius: 4px; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/sushant.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Sushant Raktade</b><br/>
                            <span style=" font-size:11px;">
                                (Assistant Project Manager)
                            </span>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <br/>

                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; border-bottom: 1px solid #d8d8d8; border-radius: 4px; margin-bottom:4px; width:49%; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/prakash.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Prakash Jadiyar</b><br/>
                            <span style=" font-size:11px;">
                                (Sr. Video Editor)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; border-bottom: 1px solid #d8d8d8; border-radius: 4px;  margin-bottom:4px; width:49%; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/kailash.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Kailash Kadu</b><br/>
                            <span style=" font-size:11px;">
                                (Sr. Video Editor)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; float: left;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/deepak.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Deepak Jangir</b><br/>
                            <span style=" font-size:11px;">
                                (Multimedia Editor)
                            </span>
                        </div>
                    </div>
                    <div style="padding: 2px 2px 4px 2px; margin-top:4px; margin-bottom:4px; width:49%; float: right;">
                        <div style="clear: both;"></div>
                        <div style="float:left; margin:10px 0px 10px 0px; height:auto; overflow:hidden;">
                            <div style="float:left; width:90px;">
                                <img width="85" src="team_photos/shekhar.jpg"/>    
                            </div>
                        </div>
                        <div style="float:left; width:220px; height:94px; margin-top:10px; padding-top:5px; font-size: 13px;">
                            <b>Mr. Paudel Shekhar</b><br/>
                            <span style=" font-size:11px;">
                                (Sr. Video Cameraman)
                            </span>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                </div>
            </div>
            <%-- Studio Team Ends Here --%>
        </div>
    </div>
</body>
