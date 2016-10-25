<%-- 
    Document   : AakashParticipantList
    Created on : 14 Nov, 2014, 3:38:02 PM
    Author     : asl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    #header{
        text-align: center;
        width: 50px;
    }
    #header2{
        text-align: center;
    }
</style>
<body>
    <h3>List of Registered Participants for Aakash Center</h3>
    <div id="details_coordinator" style="">
        <center>
        <table class="content_container1">
            <thead> <tr><td id="header">Sr No</td><td id="header2">Remote Center ID</td><td id="header2">Institute Name</td><td id="header2">City</td><td id="header2">State</td><td id="header2">Name</td><td id="header2">Status</td></tr></thead>
            <s:iterator value="participantCenters_main" status="itStatus">
                <!--
                <tr>
                    <td><s:property value="#itStatus.count" /></td>
                <td><s:property value="remoteCenter.remoteCenterName" /></td>
                <td><s:property value="#itStatus.count" /></td>
                <td><s:property value="#itStatus.count" /></td>
                <td><s:property value="#itStatus.count" /></td>
                <td><s:property value="#itStatus.count" /></td>
                <td><s:property value="#itStatus.count" /></td>
                </tr>
                -->
            </s:iterator>
             <tr>
                <td>1 </td>	<td>1034 </td>	<td>M. E. Society's IMCC</td>	<td>Pune</td>	<td>Maharashtra</td>	<td>Ravindra  Vaidya</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>2 </td>	<td>1177 </td>	<td>VELS University</td>	<td>Pallavaram</td>	<td>Tamil Nadu</td>	<td>C.  Dhanasekaran</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>3 </td>	<td>1002 </td>	<td>Amal Jyothi College Of Engineering</td>	<td>Kanjirappally</td>	<td>Kerala</td>	<td>Manoj  T.Joy</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>4 </td>	<td>1085 </td>	<td>Nirma University, Institute Of Technology</td>	<td>Ahmedabad</td>	<td>Gujarat</td>	<td>Vipul  Chudasama*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>5 </td>	<td>1066 </td>	<td>Shrinathji Institute Of Technology & Engineering</td>	<td>Nathdwara</td>	<td>Rajasthan</td>	<td>Mahesh  Porwal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>6 </td>	<td>1168 </td>	<td>BRCM College Of Engineering & Technology</td>	<td>Bahal</td>	<td>Haryana</td>	<td>Narender  Kumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>7 </td>	<td>1092 </td>	<td>K.I.T. College Of Engineering</td>	<td>Gokul Shirgaon</td>	<td>Maharashtra</td>	<td>Tanaji  Patil</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>8 </td>	<td>1046 </td>	<td>Sagar Institute Of Research & Technology - Excellence</td>	<td>Bhopal</td>	<td>Madhya Pradesh</td>	<td>Rajiv  Srivastava</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>9 </td>	<td>1015 </td>	<td>Vidya Pratisthan College Of Engineering</td>	<td>Baramati</td>	<td>Maharashtra</td>	<td>Shantanu  Jagdale</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>10 </td>	<td>1148 </td>	<td>Krishna Institute Of Engineering & Technology</td>	<td>Ghaziabad</td>	<td>Uttar Pradesh</td>	<td>Arun  Sharma</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>11 </td>	<td>1107 </td>	<td>Poornima College Of Engineering</td>	<td>Sitapura</td>	<td>Rajasthan</td>	<td>Ajay  Khunteta</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>12 </td>	<td>1114 </td>	<td>Sangam University, ITM</td>	<td>Bhilwara</td>	<td>Rajasthan</td>	<td>Dheeraj  Jain</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>13 </td>	<td>1048 </td>	<td>Royal College Of Engineering & Technology</td>	<td>Akkikavu</td>	<td>Kerala</td>	<td>Arunvinodh  Chellathurai</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>14 </td>	<td>1027 </td>	<td>Sudharsan Engineering College</td>	<td>Sathiyamangalam</td>	<td>Tamil Nadu</td>	<td>Praveen  Kumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>15 </td>	<td>1040 </td>	<td>College Of Engineering</td>	<td>Pune</td>	<td>Maharashtra</td>	<td>Abhijit  A.M</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>16 </td>	<td>1078 </td>	<td>Galaxy Global Group Of Institutions</td>	<td>Dinarpur</td>	<td>Haryana</td>	<td>Puneet  Goswami</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>17 </td>	<td>1117 </td>	<td>Shri Vaishnav Institute Of Technology & Science</td>	<td>Indore</td>	<td>Madhya Pradesh</td>	<td>Rajesh  Chakrawarti</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>18 </td>	<td>1008 </td>	<td>D.K.T.E Society's Textile & Engineering Institute</td>	<td>Ichalkaranji</td>	<td>Maharashtra</td>	<td>Dattatraya  Kodavade</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>19 </td>	<td>1026 </td>	<td>St. Xaviers Catholic College Of Engineering</td>	<td>Chunkankadai</td>	<td>Tamil Nadu</td>	<td>Edwin  Jose*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>20 </td>	<td>1069 </td>	<td>Alluri Institute Of Management Sciences</td>	<td>Warangal</td>	<td>Andhra Pradesh</td>	<td>Kiran  Kumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>21 </td>	<td>1157 </td>	<td>Sona College Of Technology</td>	<td>Salem</td>	<td>Tamil Nadu</td>	<td>David  S.</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>22 </td>	<td>1084 </td>	<td>Institute Of Road And Transport Technology</td>	<td>Erode</td>	<td>Tamil Nadu</td>	<td>Kulendran  Balamurugan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>23 </td>	<td>1159 </td>	<td>Agni College Of Technology</td>	<td>Thalambur</td>	<td>Tamil Nadu</td>	<td>Sathishkumar  Dhanapal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>24 </td>	<td>1012 </td>	<td>G H Raisoni College Of Engineering</td>	<td>Nagpur</td>	<td>Maharashtra</td>	<td>Sonali  Nimbhorkar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>25 </td>	<td>1152 </td>	<td>St. Joseph's College Of Engineering & Technology</td>	<td>Palai</td>	<td>Kerala</td>	<td>Jubilant.j  Kizhakkethottam</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>26 </td>	<td>1089 </td>	<td>K.L.E. College Of Engineering & Technology</td>	<td>Chikodi</td>	<td>Karnataka</td>	<td>Basavaraj  Choukimath</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>27 </td>	<td>1087 </td>	<td>Joginpally B. R. Engineering College</td>	<td>Yenkapally</td>	<td>Andhra Pradesh</td>	<td>G.  Krishnaiah</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>28 </td>	<td>1136 </td>	<td>PSG College Of Technology</td>	<td>Coimbatore</td>	<td>Tamil Nadu</td>	<td>Gopalswamy  Sundararaj</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>29 </td>	<td>1062 </td>	<td>Dungarpur College Of Engineering & Technology</td>	<td>Dungarpur</td>	<td>Rajasthan</td>	<td>Omprakash  Dave</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>30 </td>	<td>1142 </td>	<td>Government Engineering College</td>	<td>Sreekrishnapuram</td>	<td>Kerala</td>	<td>Raseek  C.*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>31 </td>	<td>1095 </td>	<td>M. S. Bidve Engineering College</td>	<td>Latur</td>	<td>Maharashtra</td>	<td>Nandkishor  Dharashive</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>32 </td>	<td>1160 </td>	<td>Anna University Of Technology</td>	<td>Madurai</td>	<td>Tamil Nadu</td>	<td>Arun  Vijayan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>33 </td>	<td>1056 </td>	<td>Malla Reddy College Of Engineering & Technology</td>	<td>Maisammaguda </td>	<td>Andhra Pradesh</td>	<td>Muralikrishna  Koppuravuri</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>34 </td>	<td>1098 </td>	<td>Marathwada Institute Of Technology</td>	<td>Aurangabad</td>	<td>Maharashtra</td>	<td>Chitra  Desai</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>35 </td>	<td>1137 </td>	<td>RK University, School Of Engineering</td>	<td>Kasturbadham</td>	<td>Gujarat</td>	<td>Rajani  Kanth</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>36 </td>	<td>1108 </td>	<td>R. C. Patel Institute Of Technology</td>	<td>Shirpur</td>	<td>Maharashtra</td>	<td>Navin  Haswani</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>37 </td>	<td>1001 </td>	<td>Maulana Azad National Institute Of Technology</td>	<td>Bhopal</td>	<td>Madhya Pradesh</td>	<td>Madhvi  Shakya</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>38 </td>	<td>1082 </td>	<td>Hindustan Institute Of Technology And Management</td>	<td>Agra</td>	<td>Uttar Pradesh</td>	<td>Velide  Srinath</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>39 </td>	<td>1096 </td>	<td>Mahakal Institute Of Technology</td>	<td>Ujjain</td>	<td>Madhya Pradesh</td>	<td>Abhishek  Raghuvanshi</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>40 </td>	<td>1143 </td>	<td>Indur Institute of Engineering & Technology</td>	<td>Siddipet</td>	<td>Andhra Pradesh</td>	<td>Prof.D. Parvateeshwar Rao</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>41 </td>	<td>1099 </td>	<td>Medi-Caps Institute Of Technology & Management</td>	<td>Pigdamber</td>	<td>Madhya Pradesh</td>	<td>Shamsher  Singh</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>42 </td>	<td>1100 </td>	<td>MES Pillai's Institute Of Information Technology</td>	<td>New Panvel</td>	<td>Maharashtra</td>	<td>Satishkumar  Varma</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>43 </td>	<td>1079 </td>	<td>Geeta Institute Of Management & Technology</td>	<td>Kurukshetra</td>	<td>Haryana</td>	<td>Anurag  Jain</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>44 </td>	<td>1111 </td>	<td>RVS College Of Engineering And Technology</td>	<td>Coimbatore</td>	<td>Tamil Nadu</td>	<td>Natarajan  Kaliappan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>45 </td>	<td>1109 </td>	<td>Rajiv Gandhi Proudyogiki Vishwavidyalay</td>	<td>Bhopal</td>	<td>Madhya Pradesh</td>	<td>Rakesh  Singhai</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>46 </td>	<td>1190 </td>	<td>Symbiosis Institute Of Computer Studies & Research</td>	<td>Pune</td>	<td>Maharashtra</td>	<td>Harshad  Gune</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>47 </td>	<td>1147 </td>	<td>Kongu Engineering College</td>	<td>Perundurai</td>	<td>Tamil Nadu</td>	<td>Kanimozhiselvi  C.s</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>48 </td>	<td>1050 </td>	<td>Prasad Engineering College</td>	<td>Jangaon</td>	<td>Andhra Pradesh</td>	<td>Swamy  Bhukya</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>49 </td>	<td>1119 </td>	<td>SSBT's College Of Engineering And Technology</td>	<td>Bambhori</td>	<td>Maharashtra</td>	<td>Manoj  Patil</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>50 </td>	<td>1122 </td>	<td>Techno India NJR Institute Of Technology</td>	<td>Udaipur</td>	<td>Rajasthan</td>	<td>Piyush  Javeria</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>51 </td>	<td>1071 </td>	<td>Amrita Vishwa Vidyapeetham</td>	<td>Amritanagar</td>	<td>Tamil Nadu</td>	<td>P.  Raghuram</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>52 </td>	<td>1149 </td>	<td>Lenora College Of Engineering</td>	<td>Rampachodavaram</td>	<td>Andhra Pradesh</td>	<td>Vijaykumar  Vasamsetti</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>53 </td>	<td>1070 </td>	<td>Amrita School Of Engineering</td>	<td>Bangalore</td>	<td>Karnataka</td>	<td>Dr. Veereshkumar  G.B</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>54 </td>	<td>1061 </td>	<td>Er. Perumal Manimekalai College Of Engineering</td>	<td>Krishnagiri</td>	<td>Tamil Nadu</td>	<td>Sadagopan  Dr.s.chitra</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>55 </td>	<td>1074 </td>	<td>Caarmel Engineering College</td>	<td>Ranni-Perunad</td>	<td>Kerala</td>	<td>Ajeesh  S.s.</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>56 </td>	<td>1173 </td>	<td>Thiagarajar College Of Engineering</td>	<td>Madurai</td>	<td>Tamil Nadu</td>	<td>Sivaram  Natarajan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>57 </td>	<td>1131 </td>	<td>Walchand Institute Of Technology</td>	<td>Solapur</td>	<td>Maharashtra</td>	<td>Raj  Kulkarni</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>58 </td>	<td>1162 </td>	<td>Asia Pacific Institute Of Information Technology SD India</td>	<td>Panipat</td>	<td>Haryana</td>	<td>Sanjeev  Saini</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>59 </td>	<td>1044 </td>	<td>Sasurie College Of Engineering</td>	<td>Vijayamangalam</td>	<td>Tamil Nadu</td>	<td>Satish Kumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>60 </td>	<td>1080 </td>	<td>GRIET</td>	<td>Kukatpally</td>	<td>Andhra Pradesh</td>	<td>R.Anil kumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>61 </td>	<td>1077 </td>	<td>Federal Institute Of Science And Technology</td>	<td>Mookkannoor</td>	<td>Kerala</td>	<td>Bejoy  Varghese</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>62 </td>	<td>1047 </td>	<td>S.D.M. College Of Engineering & Technology</td>	<td>Dhavalagiri</td>	<td>Karnataka</td>	<td>Jayateerth  Vadavi</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>63 </td>	<td>1165 </td>	<td>Bharati Vidyapeeth College Of Engineering</td>	<td>Navi Mumbai</td>	<td>Maharashtra</td>	<td>Ravindra  Agrawal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>64 </td>	<td>1031 </td>	<td>St. Margaret Engineering College</td>	<td>Neemrana</td>	<td>Rajasthan</td>	<td>Ram  Gurjar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>65 </td>	<td>1045 </td>	<td>Saveetha Engineering College</td>	<td>Thandalam</td>	<td>Tamil Nadu</td>	<td>Nagappan  Govindarajan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>66 </td>	<td>1094 </td>	<td>Lourdes Matha College Of Science & Technology</td>	<td>Trivandrum</td>	<td>Kerala</td>	<td>Justin  Russel</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>67 </td>	<td>1121 </td>	<td>SVP Engineering College</td>	<td>Visakhapatnam</td>	<td>Andhra Pradesh</td>	<td>Anandakumar  Thummapudi</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>68 </td>	<td>1014 </td>	<td>P. V. P. Siddhartha Institute Of Technology</td>	<td>Kanuru</td>	<td>Andhra Pradesh</td>	<td>Niranjankumar  Morampudi.s.r</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>69 </td>	<td>1051 </td>	<td>Pacific Institute Of Technology</td>	<td>Udaipur</td>	<td>Rajasthan</td>	<td>Deepti  Nathawat</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>70 </td>	<td>1030 </td>	<td>NIELIT - Formerly DOEACC</td>	<td>Srinagar</td>	<td>Jammu and Kashmir</td>	<td>Muneer  Ahmad Dar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>71 </td>	<td>1113 </td>	<td>S. B. Patil College Of Engineering</td>	<td>Indapur</td>	<td>Maharashtra</td>	<td>Shivaji  Jadhav</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>72 </td>	<td>1081 </td>	<td>GVIT</td>	<td>Bhimavaram</td>	<td>Andhra Pradesh</td>	<td>Venkata  Suryanarayana.s</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>73 </td>	<td>1163 </td>	<td>Avinashilingam University For Women</td>	<td>Coimbatore</td>	<td>Tamil Nadu</td>	<td>Lakshmipriya  Tks</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>74 </td>	<td>1055 </td>	<td>Mar Baselios College Of Engineering & Technology</td>	<td>Nalanchira</td>	<td>Kerala</td>	<td>Biju  Varghese</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>75 </td>	<td>1146 </td>	<td>Knowledge Institute Of Technology</td>	<td>Kakapalayam</td>	<td>Tamil Nadu</td>	<td>Karthikeyan  Thangaraj</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>76 </td>	<td>1028 </td>	<td>Tatyasaheb Kore Institute Of Engineering & Technology</td>	<td>Warananagar</td>	<td>Maharashtra</td>	<td>Nandkishor  Jadhav</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>77 </td>	<td>1106 </td>	<td>NITTTR</td>	<td>Chandigarh</td>	<td>Punjab</td>	<td>Amit  Doegar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>78 </td>	<td>1161 </td>	<td>Anurag Group Of Institutions, CVSR College Of Engineering</td>	<td>Ranga Reddy</td>	<td>Andhra Pradesh</td>	<td>Vishnu  Murthy</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>79 </td>	<td>1175 </td>	<td>TRUBA College Of Science & Technology</td>	<td>Bhopal</td>	<td>Madhya Pradesh</td>	<td>Namish  Mehta</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>80 </td>	<td>1132 </td>	<td>Sir Padampat Singhania University</td>	<td>Bhatewar</td>	<td>Rajasthan</td>	<td>Jinesh  Singh</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>81 </td>	<td>1037 </td>	<td>Jabalpur Engineering College</td>	<td>Jabalpur</td>	<td>Madhya Pradesh</td>	<td>Prashant  Jain</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>82 </td>	<td>1042 </td>	<td>Saintgits College of Engineering</td>	<td>Kottayam</td>	<td>Kerala</td>	<td>K.S  Rajesh</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>83 </td>	<td>1126 </td>	<td>Vignan Institute Of Technology And Science</td>	<td>Deshmukhi</td>	<td>Andhra Pradesh</td>	<td>Sudhakararao  Parvataneni</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>84 </td>	<td>1116 </td>	<td>S. G. S. Institute Of Technology & Science</td>	<td>Indore</td>	<td>Madhya Pradesh</td>	<td>D.a.  Mehta</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>85 </td>	<td>1003 </td>	<td>Government College Of Engineering</td>	<td>Salem</td>	<td>Tamil Nadu</td>	<td>Salma  Mehajabeen.s</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>86 </td>	<td>1174 </td>	<td>Toc H Institute Of Science & Technology</td>	<td>Arakkunnam</td>	<td>Kerala</td>	<td>Justin  George</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>87 </td>	<td>1073 </td>	<td>Bannari Amman Institute Of Technology</td>	<td>Sathyamangalam</td>	<td>Tamil Nadu</td>	<td>P  Prem</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>88 </td>	<td>1112 </td>	<td>S. V. U. College Of Engineering</td>	<td>Tirupati</td>	<td>Andhra Pradesh</td>	<td>Umamaheswara  Reddy.g</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>89 </td>	<td>1170 </td>	<td>Chitkara University</td>	<td>Chandigarh</td>	<td>Punjab</td>	<td>Pawan  Kumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>90 </td>	<td>1054 </td>	<td>National College Of Engineering</td>	<td>Muruthakulam</td>	<td>Tamil Nadu</td>	<td>Kother  Mohideen</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>91 </td>	<td>1072 </td>	<td>Angadi Institute Of Technology & Management</td>	<td>Belgaum</td>	<td>Karnataka</td>	<td>Vinayak  Joshi</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>92 </td>	<td>1118 </td>	<td>Sri Jayachamarajendra College Of Engineering</td>	<td>Mysore</td>	<td>Karnataka</td>	<td>Mullur  Pushpalatha</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>93 </td>	<td>1057 </td>	<td>Madhuben & Bhanubhai Patel Women's Institute Of Engineering</td>	<td>Anand</td>	<td>Gujarat</td>	<td>Shingala Nikunj R</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>94 </td>	<td>1130 </td>	<td>Walchand College Of Engineering</td>	<td>Sangli</td>	<td>Maharashtra</td>	<td>Prashant  Kharat*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>95 </td>	<td>1029 </td>	<td>Terna Engineering College</td>	<td>Nerul, Navi Mumbai</td>	<td>Maharashtra</td>	<td>Dnyaneshwar  Bavkar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>96 </td>	<td>1166 </td>	<td>Bhilai Institute Of Technology</td>	<td>Durg</td>	<td>Chhattisgarh</td>	<td>Deviprasad  Mishra</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>97 </td>	<td>1178 </td>	<td>Sitarambhai Naranji Patel Institute Of Technology And Research Centre</td>	<td>Umrakh</td>	<td>Gujarat</td>	<td>Jainish  Rana</td>	<td>Request Registered</td>	
            </tr>
            <tr>
                <td>98 </td>	<td>1052 </td>	<td>Noorul Islam Centre For Higher Education</td>	<td>Thuckalay</td>	<td>Tamil Nadu</td>	<td>A.shajin  Nargunam</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>99 </td>	<td>1101 </td>	<td>MKSSS Cummins College Of Engineering</td>	<td>Karvenagar</td>	<td>Maharashtra</td>	<td>Sunil  Divekar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>100 </td>	<td>1041 </td>	<td>Shri Mata Vaishno Devi University</td>	<td>Katra</td>	<td>Jammu and Kashmir</td>	<td>Naveen  Gondhi</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>101 </td>	<td>1021 </td>	<td>NERIST</td>	<td>Nirjuli</td>	<td>Arunachal Pradesh</td>	<td>Anu  Das</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>102 </td>	<td>1123 </td>	<td>Oriental College Of Technology - Formely Thakral College</td>	<td>Bhopal</td>	<td>Madhya Pradesh</td>	<td>Jitendra  Rathore</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>103 </td>	<td>1025 </td>	<td>National Institute Of Technology</td>	<td>Warangal</td>	<td>Andhra Pradesh</td>	<td>D.v.l.n  Somayajulu</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>104 </td>	<td>1167 </td>	<td>Birla Vishwakarma Mahavidyalaya Engg. College</td>	<td>Vallabh Vidhyanagar</td>	<td>Gujarat</td>	<td>Prashant   Swadas</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>105 </td>	<td>1032 </td>	<td>Muffakham Jah College Of Engineering & Technology</td>	<td>Hyderabad</td>	<td>Andhra Pradesh</td>	<td>Zakir  Hussain</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>106 </td>	<td>1097 </td>	<td>Maharaja Institute Of Technology</td>	<td>Belavadi</td>	<td>Karnataka</td>	<td>Nandakumar  R.b.</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>107 </td>	<td>1058 </td>	<td>Goa College Of Engineering</td>	<td>Ponda</td>	<td>Goa</td>	<td>Vinayak  Shet</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>108 </td>	<td>1010 </td>	<td>Sardar Vallabhbhai National Institute Of Technology</td>	<td>Surat</td>	<td>Gujarat</td>	<td>Rakesh  Gohil</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>109 </td>	<td>1060 </td>	<td>EBET Group Of Institutions</td>	<td>Nathakadaiyur</td>	<td>Tamil Nadu</td>	<td>S.B.  Gopal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>110 </td>	<td>1139 </td>	<td>Rajarambapu Institute Of Technology</td>	<td>Islampur</td>	<td>Maharashtra</td>	<td>Savita  Patil</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>111 </td>	<td>1127 </td>	<td>Vishwakarma Institute Of Technology</td>	<td>Pune</td>	<td>Maharashtra</td>	<td>Manasi  Patwardhan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>112 </td>	<td>1138 </td>	<td>Rajalakshmi Engineering College</td>	<td>Chennai</td>	<td>Tamil Nadu</td>	<td>Poonkuzhali  Sugumaran</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>113 </td>	<td>1155 </td>	<td>Yeshwantrao Chavan College Of Engineering</td>	<td>Wanadongri</td>	<td>Maharashtra</td>	<td>Ajay  Thatere</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>114 </td>	<td>1033 </td>	<td>Manipal Institute Of Technology</td>	<td>Manipal</td>	<td>Karnataka</td>	<td>Balachandra  Muniyal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>115 </td>	<td>1011 </td>	<td>Jaipur Engineering College</td>	<td>Kukas</td>	<td>Rajasthan</td>	<td>Narendra  Agrawal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>116 </td>	<td>1059 </td>	<td>GF Gharda Institute Of Technology</td>	<td>Lavel</td>	<td>Maharashtra</td>	<td>Mahesh  Khandke</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>117 </td>	<td>1140 </td>	<td>SASTRA University</td>	<td>Tirumalaisamudram</td>	<td>Tamil Nadu</td>	<td>Shankar  Sriram</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>118 </td>	<td>1129 </td>	<td>VIT University</td>	<td>Vellore</td>	<td>Tamil Nadu</td>	<td>N.  Rajasekar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>119 </td>	<td>1154 </td>	<td>Thanthai Periyar Government Institute Of Technology</td>	<td>Vellore</td>	<td>Tamil Nadu</td>	<td>Sreerambabu  Janakiraman</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>120 </td>	<td>1068 </td>	<td>Thakur College Of Engineering & Technology</td>	<td>Kandivali</td>	<td>Maharashtra</td>	<td>Kamal  Shah</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>121 </td>	<td>1171 </td>	<td>DMIETR</td>	<td>Sarod Hirapur</td>	<td>Maharashtra</td>	<td>Sachin  Balvir*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>122 </td>	<td>1187 </td>	<td>Government Engineering College</td>	<td>Thrissur</td>	<td>Kerala</td>	<td>Dileesh  E.D</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>123 </td>	<td>1102 </td>	<td>Mother Teresa Institute Of Science & Technology</td>	<td>Sathupally</td>	<td>Andhra Pradesh</td>	<td>Popuri  Sureshbabu</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>124 </td>	<td>1181 </td>	<td>Vivekananda Institute Of Technology</td>	<td>Jagatpura</td>	<td>Rajasthan</td>	<td>Baldev  singh</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>125 </td>	<td>1135 </td>	<td>Periyar Maniammai University</td>	<td>Vallam</td>	<td>Tamil Nadu</td>	<td>Baskaran  Subramanian</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>126 </td>	<td>1145 </td>	<td>KMEA Engineering College</td>	<td>Aluva</td>	<td>Kerala</td>	<td>Basil  Paulose</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>127 </td>	<td>1036 </td>	<td>Kakinada Institute Of Engineering & Technology</td>	<td>Kakinada</td>	<td>Andhra Pradesh</td>	<td>K.Ravikumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>128 </td>	<td>1064 </td>	<td>Deenbandhu Chhotu Ram University Of Science & Technology</td>	<td>Murthal</td>	<td>Haryana</td>	<td>Darshana  Hooda</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>129 </td>	<td>1164 </td>	<td>Bhagwan Parshuram Institute of Technology</td>	<td>Rohini</td>	<td>Delhi</td>	<td>Dr. Bhawna  Suri</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>130 </td>	<td>1075 </td>	<td>D. Y. Patil College Of Engineering & Technology</td>	<td>Kolhapur</td>	<td>Maharashtra</td>	<td>Ganapati  Patil</td>	<td>Request Registered</td>	
            </tr>
            <tr>
                <td>131 </td>	<td>1035 </td>	<td>Srinivasa Institute Of Engineering & Technology</td>	<td>Cheyyeru (V)</td>	<td>Andhra Pradesh</td>	<td>Venkata  Varma</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>132 </td>	<td>1043 </td>	<td>Sarvajanik College Of Engineering & Technology</td>	<td>Surat</td>	<td>Gujarat</td>	<td>Keyur  Rana</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>133 </td>	<td>1067 </td>	<td>St. Francis Institute Of Technology</td>	<td>Borivali</td>	<td>Maharashtra</td>	<td>Santosh  Chapaneri</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>134 </td>	<td>1120 </td>	<td>St. Aloysius Institute Of Technology</td>	<td>Jabalpur</td>	<td>Madhya Pradesh</td>	<td>Veeresh  Fuskele</td>	<td>Request Registered</td>	
            </tr>
            <tr>
                <td>135 </td>	<td>1065 </td>	<td>Finolex Academy Of Management Technology</td>	<td>Ratnagiri</td>	<td>Maharashtra</td>	<td>Shashikant  Goilkar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>136 </td>	<td>1004 </td>	<td>National Institute Of Technology</td>	<td>Calicut</td>	<td>Kerala</td>	<td>Gopakumar  Gopalakrishnan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>137 </td>	<td>1006 </td>	<td>National Institute Of Technology</td>	<td>Tiruchirappalli</td>	<td>Tamil Nadu</td>	<td>Balasundaram  S.r.</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>138 </td>	<td>1128 </td>	<td>Visvesvaraya National Institute Of Technology</td>	<td>Nagpur</td>	<td>Maharashtra</td>	<td>M.M  Dhabu</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>139 </td>	<td>1133 </td>	<td>National Institute Of Technology</td>	<td>Agartala</td>	<td>Tripura</td>	<td>Suman  Deb</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>140 </td>	<td>1013 </td>	<td>Mepco Schlenk Engineering College</td>	<td>Sivakasi</td>	<td>Tamil Nadu</td>	<td>T.  Revathi</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>141 </td>	<td>1153 </td>	<td>Tezpur University</td>	<td>Tezpur</td>	<td>Assam</td>	<td>Soumik  Roy</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>142 </td>	<td>1125 </td>	<td>Turbomachinery Institute Of Technology & Science</td>	<td>Patancheru</td>	<td>Andhra Pradesh</td>	<td>Madhusudhan  Reddy.y</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>143 </td>	<td>1144 </td>	<td>Sushila Devi Bansal College Of Engineering (KCB Technical Academy)</td>	<td>Indore</td>	<td>Madhya Pradesh</td>	<td>Kamal  Borana</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>144 </td>	<td>1016 </td>	<td>K. J. Somaiya College Of Engineering</td>	<td>Vidyavihar</td>	<td>Maharashtra</td>	<td>Deepak  Sharma</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>145 </td>	<td>1017 </td>	<td>PVG's College Of Engineering & Technology</td>	<td>Pune</td>	<td>Maharashtra</td>	<td>Surekha  Deshmukh*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>146 </td>	<td>1020 </td>	<td>Don Bosco College Of Engineering & Technology</td>	<td>Azara</td>	<td>Assam</td>	<td>Vijay  Prasad</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>147 </td>	<td>1022 </td>	<td>Shri Sant Gajanan Maharaj College Of Engineering</td>	<td>Shegaon</td>	<td>Maharashtra</td>	<td>Cmmankar  Mankar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>148 </td>	<td>1176 </td>	<td>University B.D.T. College Of Engineering</td>	<td>Davangere</td>	<td>Karnataka</td>	<td>B.n.veerappa  B.n.veerappa</td>	<td>Request Registered</td>	
            </tr>
            <tr>
                <td>149 </td>	<td>1258 </td>	<td>Om Institute Of Technology & Management</td>	<td>Hisar</td>	<td>Haryana</td>	<td>Saurabh  Chiraya</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>150 </td>	<td>1259 </td>	<td>N.D.M.V.P. Samaj’s K.B.T. College Of Engineering</td>	<td>Nashik</td>	<td>Maharashtra</td>	<td>Seema  Jadhav</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>151 </td>	<td>1200 </td>	<td>IES College Of Technology</td>	<td>Bhopal</td>	<td>Madhya Pradesh</td>	<td>Mayank  Mishra</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>152 </td>	<td>1260 </td>	<td>S.K.N. Sinhgad College Of Engineering</td>	<td>Pandharpur</td>	<td>Maharashtra</td>	<td>Somnath  Thigale</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>153 </td>	<td>1247 </td>	<td>School Of Management Sciences, Technical Campus</td>	<td>Kasimpur Biruha</td>	<td>Uttar Pradesh</td>	<td>Prof.dr.b.r.  Singh</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>154 </td>	<td>1201 </td>	<td>Islamic University Of Science And Technology</td>	<td>Awantipora</td>	<td>Jammu and Kashmir</td>	<td>Asif  Naqeshbandi*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>155 </td>	<td>1268 </td>	<td>Techno India College Of Technology</td>	<td>Rajarhat Kolkata</td>	<td>West Bengal</td>	<td>Swagata  Paul</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>156 </td>	<td>1216 </td>	<td>BSA College Of Engineering & Technology</td>	<td>Mathura</td>	<td>Uttar Pradesh</td>	<td>Manoj  Kumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>157 </td>	<td>1252 </td>	<td>Narayana Engineering College</td>	<td>Nellore</td>	<td>Andhra Pradesh</td>	<td>Munaswamy  Pidugu</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>158 </td>	<td>1235 </td>	<td>Dr. Mahalingam College Of Engineering & Technology</td>	<td>Pollachi</td>	<td>Tamil Nadu</td>	<td>Dr.a.  Rathinavelu</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>159 </td>	<td>1249 </td>	<td>Sri Ramakrishna Institute Of Technology</td>	<td>Coimbatore</td>	<td>Tamil Nadu</td>	<td>Jothi  K.r</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>160 </td>	<td>1243 </td>	<td>National Institute Of Science & Technology</td>	<td>Berhampur</td>	<td>Orissa</td>	<td> Shom Prasad Das</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>161 </td>	<td>1244 </td>	<td>Archana College Of Engineering</td>	<td>Palamel</td>	<td>Kerala</td>	<td>Radhakrishnan  Nair</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>162 </td>	<td>1237 </td>	<td>Mewar University</td>	<td>Gangrar</td>	<td>Rajasthan</td>	<td>Bala  Krishna</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>163 </td>	<td>1196 </td>	<td>Balaji Institute Of Technology & Science</td>	<td>Narsampet</td>	<td>Andhra Pradesh</td>	<td>Suresh  Salendra</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>164 </td>	<td>1217 </td>	<td>SIES Graduate School Of Technology</td>	<td>Nerul, Navi Mumbai</td>	<td>Maharashtra</td>	<td>Preeti  Godbole*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>165 </td>	<td>1231 </td>	<td>Bhajarang Engineering College</td>	<td>Thiruvallur</td>	<td>Tamil Nadu</td>	<td>Srinivasan  Ramakrishnan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>166 </td>	<td>1236 </td>	<td>EXCEL Engineering College</td>	<td>Komarapalayam</td>	<td>Tamil Nadu</td>	<td>Sachidhanandam  .p</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>167 </td>	<td>1228 </td>	<td>Loyola-ICAM College Of Engineering & Technology</td>	<td>Chennai</td>	<td>Tamil Nadu</td>	<td>Gopalakrishnan  Kaliaperumal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>168 </td>	<td>1257 </td>	<td>HCTM Technical Campus</td>	<td>Kaithal</td>	<td>Haryana</td>	<td>Bhupinderkaur  Srao</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>169 </td>	<td>1263 </td>	<td>Techno India</td>	<td>Salt Lake Kolkata</td>	<td>West Bengal</td>	<td>Soumitra  Sasmal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>170 </td>	<td>1214 </td>	<td>Srinivas Institute Of Technology</td>	<td>Valachil, Mangalore</td>	<td>Karnataka</td>	<td>Aravind  Naik</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>171 </td>	<td>1229 </td>	<td>Sardar Patel Institute Of Technology</td>	<td>Mumbai</td>	<td>Maharashtra</td>	<td>Dayanand  Ambawade</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>172 </td>	<td>1195 </td>	<td>Bansal College Of Engineering</td>	<td>Mandideep, Bhopal</td>	<td>Madhya Pradesh</td>	<td>Amit  Rathore</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>173 </td>	<td>1253 </td>	<td>SSM College Of Engineering</td>	<td>Komarapalayam</td>	<td>Tamil Nadu</td>	<td>A T Ravi</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>174 </td>	<td>1224 </td>	<td>Reva Institute Of Technology & Management</td>	<td>Yelahanka</td>	<td>Karnataka</td>	<td>Prasad  Sarappadi </td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>175 </td>	<td>1225 </td>	<td>BMS College Of Engineering</td>	<td>Bengaluru</td>	<td>Karnataka</td>	<td>Girish  K.</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>176 </td>	<td>1266 </td>	<td>Netaji Subhash Engineering College</td>	<td>Garia</td>	<td>West Bengal</td>	<td>Swapna  Roy</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>177 </td>	<td>1208 </td>	<td>Regional Centre Of Anna University, Tirunelveli</td>	<td>Tirunelveli</td>	<td>Tamil Nadu</td>	<td>Saravanan  Krishnan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>178 </td>	<td>1219 </td>	<td>Prestige Institute Of Engineering & Science</td>	<td>Indore</td>	<td>Madhya Pradesh</td>	<td>Dipali  Sarvate</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>179 </td>	<td>1212 </td>	<td>Kalyani Government Engineering College</td>	<td>Kalyani</td>	<td>West Bengal</td>	<td>Kousik  Dasgupta</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>180 </td>	<td>1255 </td>	<td>Mount Zion College Of Engineering & Technology</td>	<td>Lena Vilakku</td>	<td>Tamil Nadu</td>	<td>Vivian  Jayson</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>181 </td>	<td>1238 </td>	<td>Maharaja Agrasen Institute Of Technology</td>	<td>Rohini</td>	<td>Delhi</td>	<td>Namita  Gupta</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>182 </td>	<td>1248 </td>	<td>Shri Sant Gadge Baba College Of Engineering & Technology</td>	<td>Bhusawal</td>	<td>Maharashtra</td>	<td>Gajanan  Patil</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>183 </td>	<td>1234 </td>	<td>Meghnad Saha Institute Of Technology</td>	<td>Uchhepota</td>	<td>West Bengal</td>	<td>Utpal  Gangopadhyay</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>184 </td>	<td>1240 </td>	<td>Shri Shankaracharya Institute Of Professional Management & Technology</td>	<td>Raipur</td>	<td>Chhattisgarh</td>	<td>Jyotiprakash  Patra</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>185 </td>	<td>1256 </td>	<td>Sree Dattha Institute Of Engineering & Science</td>	<td>Hyderabad</td>	<td>Andhra Pradesh</td>	<td>Gorti  Subba</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>186 </td>	<td>1264 </td>	<td>Shoolini University</td>	<td>Solan</td>	<td>Himachal Pradesh</td>	<td>Amit  Nayyer</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>187 </td>	<td>1267 </td>	<td>Sri Shakthi Institute Of Engineering & Technology</td>	<td>Chinniyampalayam</td>	<td>Tamil Nadu</td>	<td>Selvakumar  Guruswamy</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>188 </td>	<td>1197 </td>	<td>G. H. Raisoni Institute Of Engineering & Technology</td>	<td>Pune</td>	<td>Maharashtra</td>	<td>Nagnath  Hulle</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>189 </td>	<td>1202 </td>	<td>RatnaVel Subramaniam College Of Engineering And Technology</td>	<td>Dindigul</td>	<td>Tamil Nadu</td>	<td>Balaji  Sethuramasamyra</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>190 </td>	<td>1221 </td>	<td>N.P.R. College Of Engineering & Technology</td>	<td>Natham</td>	<td>Tamil Nadu</td>	<td>M.I.THAJUDEEN  THAMEEM</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>191 </td>	<td>1198 </td>	<td>Mata Raj Kaur Institute Of Engineering & Technology</td>	<td>Rewari</td>	<td>Haryana</td>	<td>Raj  Kumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>192 </td>	<td>1226 </td>	<td>SKP Engineering College</td>	<td>Tiruvannamalai</td>	<td>Tamil Nadu</td>	<td>Senthil  Muthal Reddy*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>193 </td>	<td>1205 </td>	<td>Mahatma Gandhi Missions College Of Engineering & Technology</td>	<td>Noida</td>	<td>Uttar Pradesh</td>	<td>Shilpi  Shukla</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>194 </td>	<td>1220 </td>	<td>Kurukshetra Institute Of Technology & Management</td>	<td>Kurukshetra</td>	<td>Haryana</td>	<td>Deepak  Sharma</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>195 </td>	<td>1271 </td>	<td>Jawaharlal Nehru National College Of Engineering</td>	<td>Shimoga</td>	<td>Karnataka</td>	<td>Dr.ushadevi  M.b</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>196 </td>	<td>1269 </td>	<td>IERCEM Institute Of Information Technology</td>	<td>Banipur</td>	<td>West Bengal</td>	<td>Priyaranjan  Bandyopadhyay</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>197 </td>	<td>1272 </td>	<td>Mangalayatan University</td>	<td>Beswan</td>	<td>Uttar Pradesh</td>	<td>Om  Jain</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>198 </td>	<td>1213 </td>	<td>St. Peter's Engineering College</td>	<td>Hyderabad</td>	<td>Andhra Pradesh</td>	<td>Vinay  Kumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>199 </td>	<td>1242 </td>	<td>K.L.E. Society's College Of Engineering & Technology</td>	<td>Belgaum</td>	<td>Karnataka</td>	<td>Umesh  Somanatti</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>200 </td>	<td>1241 </td>	<td>NRI Institute Of Information Science & Technology</td>	<td>Bhopal</td>	<td>Madhya Pradesh</td>	<td>Sini  Shibhu</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>201 </td>	<td>1250 </td>	<td>Sharad Institute Of Technology College of Engineering</td>	<td>Yadrav</td>	<td>Maharashtra</td>	<td>Mubarak  Mullani</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>202 </td>	<td>1207 </td>	<td>Jawaharlal Institute Of Technology</td>	<td>Borawan</td>	<td>Madhya Pradesh</td>	<td>Sanjay  Chouhan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>203 </td>	<td>1199 </td>	<td>G. H. Raisoni Institute Of Engineering & Management</td>	<td>Jalgaon</td>	<td>Maharashtra</td>	<td>Rahul  Chinchore</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>204 </td>	<td>1223 </td>	<td>RBS Engineering Technical Campus</td>	<td>Bichpuri</td>	<td>Uttar Pradesh</td>	<td>B.d.k.  Patro</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>205 </td>	<td>1251 </td>	<td>Jaypee Institute Of Information Technology</td>	<td>Noida-128</td>	<td>Uttar Pradesh</td>	<td>Devpriya  Soni</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>206 </td>	<td>1245 </td>	<td>STC School Of Engineering & Research Technology</td>	<td>Khamgaon</td>	<td>Maharashtra</td>	<td>Pooja  Rathi</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>207 </td>	<td>1193 </td>	<td>Prof. Ram Meghe Institute Of Technology & Research</td>	<td>Badnera</td>	<td>Maharashtra</td>	<td>Shrikant P.  Akarte</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>208 </td>	<td>1230 </td>	<td>Vidyaa Vikas College Of Engineering & Technology</td>	<td>Tiruchengode</td>	<td>Tamil Nadu</td>	<td>Manikandan  Murugan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>209 </td>	<td>1262 </td>	<td>Apex Institute Of Technology & Management</td>	<td>Pahala, Bhubaneswar</td>	<td>Orissa</td>	<td>Siddhartha  Neelamani</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>210 </td>	<td>1209 </td>	<td>KIIT College Of Engineering</td>	<td>Bhondsi</td>	<td>Haryana</td>	<td>Preeti  Aggarwal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>211 </td>	<td>1273 </td>	<td>Gudlavalleru Engineering College</td>	<td>Gudlavalleru</td>	<td>Andhra Pradesh</td>	<td>Baburao  Markapudi</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>212 </td>	<td>1265 </td>	<td>Madhav Institute Of Technology & Science</td>	<td>Gwalior</td>	<td>Madhya Pradesh</td>	<td>Sanjeev  Jain</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>213 </td>	<td>1283 </td>	<td>KANKSA Academy Of Technology & Management</td>	<td>Panagarh</td>	<td>West Bengal</td>	<td>Kaushik  Nath</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>214 </td>	<td>1278 </td>	<td>S.D.M. Institute Of Technology</td>	<td>Ujire</td>	<td>Karnataka</td>	<td>Manjunatha  Sh</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>215 </td>	<td>1281 </td>	<td>SVERI's College Of Engineering</td>	<td>Pandharpur</td>	<td>Maharashtra</td>	<td>Shailendrakumar  Mukane</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>216 </td>	<td>1194 </td>	<td>Gandhi Engineering College</td>	<td>Badaraghunathpur</td>	<td>Orissa</td>	<td>Kailash  Shaw</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>217 </td>	<td>1276 </td>	<td>Sankalchand Patel College Of Engineering</td>	<td>Visnagar</td>	<td>Gujarat</td>	<td>Hiren  Patel</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>218 </td>	<td>1277 </td>	<td>Technology Education & Research Integrated Institutions</td>	<td>Kurukshetra</td>	<td>Haryana</td>	<td>Sumit   Aggarwal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>219 </td>	<td>1284 </td>	<td>Saroj Mohan Institute Of Technology</td>	<td>Guptipara</td>	<td>West Bengal</td>	<td>Amit  Mandal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>220 </td>	<td>1286 </td>	<td>U V Patel College Of Engineering</td>	<td>Kherva</td>	<td>Gujarat</td>	<td>Rakesh  Vanzara</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>221 </td>	<td>1279 </td>	<td>Mandsaur Institute Of Technology</td>	<td>Mandsaur</td>	<td>Madhya Pradesh</td>	<td>Nandkishore  Patidar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>222 </td>	<td>1274 </td>	<td>SVS Group Of Institutions</td>	<td>Hanamkonda</td>	<td>Andhra Pradesh</td>	<td>Sandeep  Adevelli</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>223 </td>	<td>1206 </td>	<td>Bansal Institute Of Research & Technology</td>	<td>Bhopal</td>	<td>Madhya Pradesh</td>	<td>Vivek  Tiwari</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>224 </td>	<td>1285 </td>	<td>Siddaganga Institute Of Technolgy</td>	<td>Tumkur</td>	<td>Karnataka</td>	<td>Prasannakumar  K.r</td>	<td>Request Registered</td>	
            </tr>
            <tr>
                <td>225 </td>	<td>1275 </td>	<td>B H Gardi College Of Engineering & Technology</td>	<td>Rajkot</td>	<td>Gujarat</td>	<td>Prashant  Mehta*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>226 </td>	<td>1282 </td>	<td>Sri Eshwar College Of Engineering</td>	<td>Coimbatore</td>	<td>Tamil Nadu</td>	<td>Vignesh  Saravanan</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>227 </td>	<td>1287 </td>	<td>Rayat-Bahra Innovative Institute Of Technology & Management</td>	<td>Ganaur</td>	<td>Haryana</td>	<td>Swimpy  Pahuja</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>228 </td>	<td>1289 </td>	<td>B K Birla Institute Of Engineering & Technology</td>	<td>Pilani</td>	<td>Rajasthan</td>	<td>Nimish  Kumar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>229 </td>	<td>1288 </td>	<td>Vidyalankar Institute Of Technology</td>	<td>Mumbai</td>	<td>Maharashtra</td>	<td>Shrikant  Velankar</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>230 </td>	<td>1179 </td>	<td>Viswajyothi College of Engineering & Technology</td>	<td>Vazhkulam</td>	<td>Kerala</td>	<td>Jacob  Mathai</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>231 </td>	<td>1151 </td>	<td>SRM University</td>	<td>Kancheepuram </td>	<td>Tamil Nadu</td>	<td>Vasanthadev  Suryakala</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>232 </td>	<td>1134 </td>	<td>National Institute Of Technology</td>	<td>Kurukshetra</td>	<td>Haryana</td>	<td>J.  Lather</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>233 </td>	<td>1076 </td>	<td>Devi Ahilya University, IET</td>	<td>Indore</td>	<td>Madhya Pradesh</td>	<td>Hemant  Makwana</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>234 </td>	<td>1039 </td>	<td>IPS Academy</td>	<td>Indore</td>	<td>Madhya Pradesh</td>	<td>Naziya  Hussain</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>235 </td>	<td>1124 </td>	<td>TRUBA College Of Engineering & Technology</td>	<td>Indore</td>	<td>Madhya Pradesh</td>	<td>Lalji  Prasad*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>236 </td>	<td>1290 </td>	<td>CDAC</td>	<td>Noida</td>	<td>Uttar Pradesh</td>	<td>Laxmi  Kalyani</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>237 </td>	<td>1083 </td>	<td>IIIT</td>	<td>Hyderabad</td>	<td>Andhra Pradesh</td>	<td>Raji  Bagga</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>238 </td>	<td>1009 </td>	<td>Veermata Jijabai Technological Institute</td>	<td>Matunga</td>	<td>Maharashtra</td>	<td>Girish  Bhole</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>239 </td>	<td>1110 </td>	<td>Regency Institute Of Technology</td>	<td>Adivipolam</td>	<td>Pondicherry</td>	<td>Mushini  Prasad</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>240 </td>	<td>1063 </td>	<td>Dr. D.Y. Patil Institute Of Engineering & Technology</td>	<td>Pimpri</td>	<td>Maharashtra</td>	<td>Madhavi  Repe*</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>241 </td>	<td>1150 </td>	<td>Sou Sushila Danchand Ghodawat Charitable Trust's SGI</td>	<td>Atigre</td>	<td>Maharashtra</td>	<td>Naresh  Kamble</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>242 </td>	<td>1280 </td>	<td>Priyadarshini College Of Engineering Nagpur</td>	<td>Nagpur</td>	<td>Maharashtra</td>	<td>Animesh  Tayal</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>243 </td>	<td>1090 </td>	<td>K.C.E. Society, COEIT</td>	<td>Jalgaon</td>	<td>Maharashtra</td>	<td>Swapnil  Shete</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>244 </td>	<td>1210 </td>	<td>Gogte Institute Of Technology</td>	<td>Udyambag</td>	<td>Karnataka</td>	<td>Deepakraj  Mangalwede</td>	<td>Aakash Registration Confirmed</td>	
            </tr>
            <tr>
                <td>245 </td>	<td>1246 </td>	<td>C. U. Shah College Of Engineering & Technology</td>	<td>Wadhwan</td>	<td>Gujarat</td>	<td>Sohil  Gadhiya</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>246 </td>	<td>1172 </td>	<td>Theem College Of Engineering</td>	<td>Boisar East</td>	<td>Maharashtra</td>	<td>Rajat  Singh</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>247 </td>	<td>1115 </td>	<td>Shivaji University</td>	<td>Kolhapur</td>	<td>Maharashtra</td>	<td>Pradip  Bhaskar</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>248 </td>	<td>1211 </td>	<td>Sri Shanmugha College Of Engineering & Technology</td>	<td>Pullipalayam</td>	<td>Tamil Nadu</td>	<td>Muthaiah  Uchimuthu</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>249 </td>	<td>1182 </td>	<td>NK Orchid College Of Engineering & Technology</td>	<td>Hipparaga</td>	<td>Maharashtra</td>	<td>Vipul  Bag</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>250 </td>	<td>1222 </td>	<td>Chameli Devi Group Of Institutions</td>	<td>Indore</td>	<td>Madhya Pradesh</td>	<td>Jasvant  Mandloi</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>251 </td>	<td>1315 </td>	<td>Selvam College Of Technology</td>	<td>Namakkal</td>	<td>Tamil Nadu</td>	<td>John  Justinthangaraj</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>252 </td>	<td>1295 </td>	<td>Gitam University - Hyderabad Campus</td>	<td>Rudraram, Patancheru</td>	<td>Andhra Pradesh</td>	<td>Phanikumar  Singamsetty</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>253 </td>	<td>1298 </td>	<td>Sardar Vallabhbhai Patel Institute Of Technology</td>	<td>Vasad</td>	<td>Gujarat</td>	<td>Vishal  Shah</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>254 </td>	<td>1322 </td>	<td>CHARUSAT Charotar University Of Science & Technology</td>	<td>Nadiad</td>	<td>Gujarat</td>	<td>Ayesha  Shaikh</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>255 </td>	<td>1311 </td>	<td>Arunai College Of Engineering</td>	<td>Tiruvannamalai</td>	<td>Tamil Nadu</td>	<td>Selvakumar  Raja</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>256 </td>	<td>1005 </td>	<td>Anna University</td>	<td>Chennai</td>	<td>Tamil Nadu</td>	<td>Bhuvaneswaran  Rs</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>257 </td>	<td>1024 </td>	<td>Vivekanandha College Of Engineering For Women</td>	<td>Tiruchengode</td>	<td>Tamil Nadu</td>	<td>Nagarajan  P.</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>258 </td>	<td>1296 </td>	<td>Nagole Institute Of Technology & Science</td>	<td>Hyderabad</td>	<td>Andhra Pradesh</td>	<td>Srinivasa  Reddy</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>259 </td>	<td>1292 </td>	<td>Sagar Institute Of Science Technology & Engineering</td>	<td>Sikandrabad</td>	<td>Madhya Pradesh</td>	<td>Rachna  Singh</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>260 </td>	<td>1293 </td>	<td>Seacom Engineering College</td>	<td>Jaladhulagari, Sankrail</td>	<td>West Bengal</td>	<td>Abhijit  Aich*</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>261 </td>	<td>1299 </td>	<td>Dronacharya College Of Engineering</td>	<td>Farrukh Nagar</td>	<td>Haryana</td>	<td>Chesta  Agarwal</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>262 </td>	<td>1301 </td>	<td>K.L.E. Institute Of Technology</td>	<td>Hubli</td>	<td>Karnataka</td>	<td>Manohar  Madgi</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>263 </td>	<td>1105 </td>	<td>Nitte Meenakshi Institute Of Technology</td>	<td>Yelahanka</td>	<td>Karnataka</td>	<td>Nagaraja  Sr</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>264 </td>	<td>1103 </td>	<td>NMIM MPSTME</td>	<td>Shirpur</td>	<td>Maharashtra</td>	<td>Nitin  Choubey*</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>265 </td>	<td>1184 </td>	<td>National Institute Of Technology</td>	<td>Silchar</td>	<td>Assam</td>	<td>Wasim  Arif</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>266 </td>	<td>1232 </td>	<td>Jayalakshmi Institute Of Technology</td>	<td>Thoppur</td>	<td>Tamil Nadu</td>	<td>Sivaraaj  Nr</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>267 </td>	<td>1318 </td>	<td>Amity University Haryana</td>	<td>Manesar</td>	<td>Haryana</td>	<td>Karamjit  Kaur</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>268 </td>	<td>1317 </td>	<td>Government Engineering College</td>	<td>Bikaner</td>	<td>Rajasthan</td>	<td>Ajay  Chaudhary</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>269 </td>	<td>1314 </td>	<td>Kathir College Of Engineering</td>	<td>Coimbatore</td>	<td>Tamil Nadu</td>	<td>Dhayanandh  .s</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>270 </td>	<td>1088 </td>	<td>K. K. Wagh Institute Of Engineering Education & Research</td>	<td>Nashik</td>	<td>Maharashtra</td>	<td>Shirish  Sane</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>271 </td>	<td>1261 </td>	<td>MET's Institute Of Engineering</td>	<td>Nashik</td>	<td>Maharashtra</td>	<td>Remya  Panicker</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>272 </td>	<td>1141 </td>	<td>Government Engineering College</td>	<td>Painavu</td>	<td>Kerala</td>	<td>Unni  Krishnan.k</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>273 </td>	<td>1239 </td>	<td>Mohandas College Of Engineering & Technology</td>	<td>Trivandrum</td>	<td>Kerala</td>	<td>Aswathy R S</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>274 </td>	<td>1316 </td>	<td>Dronacharya College Of Engineering</td>	<td>Greater Noida</td>	<td>Uttar Pradesh</td>	<td>B.l.  Kaul</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>275 </td>	<td>1302 </td>	<td>Sree Buddha College Of Engineering</td>	<td>Nooranad</td>	<td>Kerala</td>	<td>Gopu  Darsan</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>276 </td>	<td>1049 </td>	<td>PDE Association`s College Of Engineering</td>	<td>Pune</td>	<td>Maharashtra</td>	<td>Amol  Gadewar</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>277 </td>	<td>1319 </td>	<td>Mukesh Patel School Of Technology Management & Engg.</td>	<td>Mumbai</td>	<td>Maharashtra</td>	<td>Dhirendra  Mishra</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>278 </td>	<td>1227 </td>	<td>Dr. J.J. Magdum College Of Engineering</td>	<td>Jaysingpur</td>	<td>Maharashtra</td>	<td>Dipali  Nikam</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>279 </td>	<td>1300 </td>	<td>Kurukshetra University - Electronic Science Department</td>	<td>Kurukshetra</td>	<td>Haryana</td>	<td>Anil  Vohra</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>280 </td>	<td>1203 </td>	<td>Gnanamani College Of Engineering</td>	<td>Namakkal </td>	<td>Tamil Nadu</td>	<td>Murugan  Chelliah</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>281 </td>	<td>1303 </td>	<td>Sree Narayana Gurukulam College Of Engineering</td>	<td>Kadayiruppu</td>	<td>Kerala</td>	<td>Sujithkumar  C.s</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>282 </td>	<td>1218 </td>	<td>Bansal Institute Of Engineering & Technology</td>	<td>Lucknow</td>	<td>Uttar Pradesh</td>	<td>Ashutosh  Singh</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>283 </td>	<td>1192 </td>	<td>MGM's College Of Engineering</td>	<td>Nanded</td>	<td>Maharashtra</td>	<td>Jyoti  Patil</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>284 </td>	<td>1306 </td>	<td>Shree L. R. Tiwari College Of Engineering</td>	<td>Mira Road</td>	<td>Maharashtra</td>	<td>Ravi  Prakash</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>285 </td>	<td>1215 </td>	<td>G L Bajaj Group Of Institutions</td>	<td>Akbarpur</td>	<td>Uttar Pradesh</td>	<td>Ankush  Agrawal*</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>286 </td>	<td>1018 </td>	<td>Samrat Ashok Technological Institute</td>	<td>Vidisha</td>	<td>Madhya Pradesh</td>	<td>Shailendra  Shrivastava</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>287 </td>	<td>1297 </td>	<td>Sardar Patel Institute Of Technology</td>	<td>Piludra</td>	<td>Gujarat</td>	<td>Bhavik  Prajapati</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>288 </td>	<td>1309 </td>	<td>Silicon Institute Of Technology</td>	<td>Bhubaneswar</td>	<td>Orissa</td>	<td>Samleshwari Prasad</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>289 </td>	<td>1185 </td>	<td>Amrutvahini College Of Engineering</td>	<td>Sangamner</td>	<td>Maharashtra</td>	<td>Mubin  Tamboli</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>290 </td>	<td>1233 </td>	<td>P E S College Of Engineering</td>	<td>Mandya</td>	<td>Karnataka</td>	<td>Holalu  Sheshadri</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>291 </td>	<td>1294 </td>	<td>Geethanjali Institute Of Science & Techonology</td>	<td>Gangavaram</td>	<td>Andhra Pradesh</td>	<td>Kvijayabhaskar  Reddy</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>292 </td>	<td>1307 </td>	<td>Gandhi Institute For Technology</td>	<td>Bhubaneswar</td>	<td>Orissa</td>	<td>Sujit  Panda</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>293 </td>	<td>1308 </td>	<td>Roland Institute Of Technology</td>	<td>Berhampur</td>	<td>Orissa</td>	<td>Sunil  Nahak</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>294 </td>	<td>1270 </td>	<td>University Of Petroleum & Energy Studies</td>	<td>Bidholi</td>	<td>Uttaranchal</td>	<td>Shrihari  Honwad</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>295 </td>	<td>1304 </td>	<td>G.H. Raisoni College Of Engineering And Management</td>	<td>Ahmadnagar</td>	<td>Maharashtra</td>	<td>Poonamkumar  Hanwate</td>	<td>Provisionally Registered</td>	
            </tr>
            <tr>
                <td>296 </td>	<td>1312 </td>	<td>DMI College Of Engineering</td>	<td>Palanjur</td>	<td>Tamil Nadu</td>	<td>Ananth  J.p.</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>297 </td>	<td>1313 </td>	<td>K.S. Rangasamy College Of Technology</td>	<td>Tiruchengode</td>	<td>Tamil Nadu</td>	<td>Elango  Mk</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>298 </td>	<td>1053 </td>	<td>NIELIT - Formerly DOEACC</td>	<td>Chennai</td>	<td>Tamil Nadu</td>	<td>Sureshbabu  J.r.</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>299 </td>	<td>1091 </td>	<td>KMM Institute Of Technology & Science</td>	<td>Tirupati</td>	<td>Andhra Pradesh</td>	<td>Dr. Venkata  ramana</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>300 </td>	<td>1156 </td>	<td>NITK</td>	<td>Surathkal</td>	<td>Karnataka</td>	<td>Annappa  Basava</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>301 </td>	<td>1321 </td>	<td>Coimbatore Institute Of Engineering & Technology</td>	<td>Coimbatore</td>	<td>Tamil Nadu</td>	<td>Gokul  Shanmugan</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>302 </td>	<td>1310 </td>	<td>Silicon Institute Of Technology</td>	<td>Sambalpur</td>	<td>Orissa</td>	<td>Abhinandan  Panda</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>303 </td>	<td>1183 </td>	<td>Vignan's Institute Of Information Technology</td>	<td>Duvvada</td>	<td>Andhra Pradesh</td>	<td>Dharmaiah  Devarapalli</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>304 </td>	<td>1305 </td>	<td>Kavikulguru Institute Of Technology & Science</td>	<td>Ramtek</td>	<td>Maharashtra</td>	<td>Bhushan  Deshpande</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>305 </td>	<td>1086 </td>	<td>JNTU College Of Engineering</td>	<td>Hyderabad</td>	<td>Andhra Pradesh</td>	<td>Supreethi  Pujari</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>306 </td>	<td>1254 </td>	<td>Raj Kumar Goel Institute Of Technology For Women</td>	<td>Ghaziabad</td>	<td>Uttar Pradesh</td>	<td>Neeta  Awasthy</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>307 </td>	<td>1323 </td>	<td>Paavai Engineering College</td>	<td>Namakkal</td>	<td>Tamil Nadu</td>	<td>Supha  Lakshmi</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>308 </td>	<td>1093 </td>	<td>LDRP Institute Of Technology & Research</td>	<td>Gandhinagar </td>	<td>Gujarat</td>	<td>Abhinav  Jain</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>309 </td>	<td>1325 </td>	<td>OP Jindal Institute Of Technology</td>	<td>Punjipathra</td>	<td>Chhattisgarh</td>	<td>Ram Narayan Shukla</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>310 </td>	<td>1330 </td>	<td>Motilal Nehru National Institute Of Technology</td>	<td>Allahabad</td>	<td>Uttar Pradesh</td>	<td>Gp  Sahu</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>311 </td>	<td>1326 </td>	<td>L.R. Institute Of Engineering And Technology</td>	<td>Solan</td>	<td>Himachal Pradesh</td>	<td>Sandeep  Salhotra</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>312 </td>	<td>1327 </td>	<td>B.N. College Of Engineering And Technology</td>	<td>Lucknow</td>	<td>Uttar Pradesh</td>	<td>Monica  Mehrotra</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>313 </td>	<td>1329 </td>	<td>Central University Of Rajasthan</td>	<td>Bandarsindri, Kishangarh</td>	<td>Rajasthan</td>	<td>Naga  Raju</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>314 </td>	<td>1334 </td>	<td>Siliguri Institute Of Technology</td>	<td>Siliguri</td>	<td>West Bengal</td>	<td>subhanil  maity</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>315 </td>	<td>1332 </td>	<td>Kashi Institute Of Technology</td>	<td>Mirzamurad</td>	<td>Uttar Pradesh</td>	<td>Jaba  Banik</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>316 </td>	<td>1335 </td>	<td>JIS College Of Engineering</td>	<td>Kalyani</td>	<td>West Bengal</td>	<td>Soham  Sengupta</td>	<td>Aakash Registration Approved</td>	
            </tr>
            <tr>
                <td>317 </td>	<td>1336 </td>	<td>College Of Engineering & Management</td>	<td>Kolaghat</td>	<td>West Bengal</td>	<td>Apurba  Roy</td>	<td>Provisionally Registered</td>	
            </tr>
        </table>
        </center>
    </div>  
</body>

