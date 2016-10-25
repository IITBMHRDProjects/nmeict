<%-- 
    Document   : faqAdmin
    Created on : 24 Sep, 2015, 4:35:01 PM
    Author     : Abinaya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<script>
    function togglediv(id){
        var style1=document.getElementById(id).style.display;        
        if(style1 == "none"){
            document.getElementById(id).style.display="inline";
        }else{
            document.getElementById(id).style.display="none";
        }
        for(var i=1; i<=8;i++){
            if(id != i){
                document.getElementById(i).style.display="none"; 
            }
        }
    }
</script>
<h3>Topics - FAQ for Administrator Interface</h3><br/>
<div>
    <b id="a1"><a href="faqAdmin.html#a1" style="color:#474686" onclick="togglediv(1)">Manage Workshops </a></b>
    <div id="1" style="display:none;">
        <br/><br/><b>If a coordinator workshop is created, a main workshop (Self Sustained (SSM) / Funded) of the chosen type will be automatically created.</b>

        <br/><br/><b>Q)  Will the Main workshop be visible to public?</b><br/>
        A) No. To make it visible, go to manage announcement page and choose 'Visible' for that particular workshop.

        <br/><br/><b>Q) What will be the start date and the end date of the main workshop created?</b><br/>
        A) 90 days interval is added to the start date from the coordinator workshop date.

        <br/><br/><b>Q) What is the name of the main workshop created?</b><br/>
        A) The name will be “Main- #Coordinator Workshop Name#”. It can be updated later while making it visible to the public.

        <br/><br/><b>Q) What is the content of the main workshop created?</b><br/>
        A) The content of the coordinator workshop is replicated. It can be updated later while making it visible to the public.

        <br/><br/><b>Q) How will the workshop coordinators be created for the main workshop?</b><br/>
        A) After the end of coordinator workshop, the participants whose status is 'Confirmed' or 	'Completed' will  be made as workshop coordinators for the Main workshop by updating 	the content of Main  workshop. This should be done before making it visible to public. 

        <br/><br/><b>Q) Can a Main Workshop (Self Sustained / Funded) be created independently?</b><br/>
        A) Yes. Please make sure to enter a respective coordinator workshop id.
    </div>
    <br/><br/>
    <b id="a2"><a href="faqAdmin.html#a2" style="color:#474686" onclick="togglediv(2)">Coordinator Workshop Registration</a></b>
    <div id="2" style="display:none;">
        <br/><br/><b>Q) When will the registration start?</b><br/>
        A) Will start on the "start date of registration" specified in the Manage Workshops page.

        <br/><br/><b>Q) How many remote centers will be displayed for the registration process?</b><br/>
        A) Remote centers which are active will be displayed.

        <br/><br/><b>Q) What should be done for making a remote center active/ inactive for the coordinator workshops?</b><br/>
        A) Go to Manage Remote Center page in the admin interface, make the remote center 	active/inactive accordingly.

        <br/><br/><b>Q) Is permission letter mandatory?</b><br/>
        A) It depends on the chosen flag in Manage Workshops Page while creating the workshop. It can be changed accordingly.

        <br/><br/><b>Q) How many participants can register from a remote center?</b><br/>
        A) Only one can register and attend the coordinator's workshop in IIT Bombay. Although, if there is any fake registration, that registration can be 'Cancelled' for allowing the other 	genuine participant.

        <br/><br/><b>Q) Can participants update their registration?</b><br/>
        A) Yes. The permission letter can be re-uploaded while their status is 'Registered' or 'Invalid'.  They cannot update the chosen Remote Center.  

        <br/><br/><b>Q) Will accommodation always be available?</b><br/>
        A) It depends on the chosen flag in Manage Workshops Page while creating the workshop. It can be changed accordingly.

        <br/><br/><b>Q) Can a Remote Center coordinator register as a workshop coordinator?</b><br/>
        A) No. If a remote center coordinator desires to attend the workshop then a different email should be used for registering. 
    </div>
    <br/><br/>

    <b id="a3"><a href="faqAdmin.html#a3" style="color:#474686" onclick="togglediv(3)">Remote Center Capacity </a></b>

    <div id="3" style="display:none;">
        <br/><br/><b>Q) How will the remote center capacity be filled by the Remote center coordinator (RCC)?</b><br/>
        A) RCC can fill the capacity in the "Manage Remote Center Capacity" by logging in to the site.

        <br/><br/><b>Q) How will the RCC be identified by the web site?</b><br/>
        A) A person, whose email is present in the “Manage Remote Center Interface” for that particular remote center will become the RCC.

        <br/><br/><b>Q) How many RCCs can fill the capacity information for a specific Main Workshop?</b><br/>
        A) Participants from remote centers whose status is 'Confirmed' or 'Completed' in the respective coordinator's workshop.

        <br/><br/><b>Q) Can they update the capacity filled?</b><br/>
        A) No. If any updates are to be done, they should send an email to (receiver). Admin can update it from Manage Remote Center Capacity Interface.

        <br/><br/><b>Q) When will link for "filling capacity" be displayed in RCC home page?</b><br/>
        A) After the respective coordinator workshop is Complete (after the end date), the link will be shown for filling  the capacity in RCC home page.

        <br/><br/><b>Q) What should be done if a RCC does not fill the capacity?</b><br/>
        A) A reminder mail with the link to fill the capacity, can be sent to all the RCCs who have not filled the information by clicking on the “Send Mail Button” in the Manage Remote 	Center Capacity Interface of admin. If the RCC still doesn't fill the information, the Remote 	center will not be eligible to host the main workshop (i.e, remote center will not be listed in 	main workshop registration page for participants).

        <br/><br/><b>Q) Will the email be sent to RCCs who have already filled the capacity info?</b><br/>
        A) No.

        <br/><br/><b>Q) Will the accommodation and food costs be displayed to all main workshops?</b><br/>
        A) No. It will be displayed only for Self Sustained Model.


    </div><br/><br/>
    <b id="a4"><a href="faqAdmin.html#a4" style="color:#474686" onclick="togglediv(4)">Main Workshop Registration</a></b></b>

<div id="4" style="display:none;">
    <br/><br/><b>Q) When will the registration start?</b><br/>
    A) Will start on the "start date of registration" specified in the Manage Workshops page.

    <br/><br/><b>Q) How many remote centers will be displayed for the registration process?</b><br/>
    A) Remote centers which filled the capacity information will be displayed.

    <br/><br/><b>Q) What should be done for making a remote center - display/ remove for the Main workshop?</b><br/>
    A) Go to Manage Remote Center Capacity interface in the admin interface, add/ delete the remote center capacity accordingly.

    <br/><br/><b>Q) Is permission letter mandatory?</b><br/>
    A) It depends on the chosen flag in Manage Workshops Page while creating the workshop. It can be changed accordingly.

    <br/><br/><b>Q) How many participants can register in a remote center?</b><br/>
    A) As many participants can register for a remote center. If the filled capacity exceeds, participants can be requested to change remote centers or the remote centers can be 	requested to increase the seating capacity by workshop team.

    <br/><br/><b>Q) Where can the capacity information be viewed by participant?</b><br/>
    A) The available seats, accommodation, food & accommodation cost (only for SSM) can be viewed in the link given in workshop registration page.

    <br/><br/><b>Q) Can participants update their registration?</b><br/>
    A) Yes. The permission letter can be re-uploaded while their status is 'Registered' or 'Invalid'. 

    <br/><br/><b>Q) Will accommodation always be available?</b><br/>
    A) It depends on the chosen flag in Manage Workshops Page while creating the workshop. It can be changed accordingly.

    <br/><br/><b>Q) How many participants can choose 'Yes' for accommodation if available?</b><br/>
    A) As many as the number of accommodation seats provided  by RCC. It displays an alert if accommodation is not available.

    <br/><br/><b>Q) Can a Remote Center coordinator register as a participant?</b><br/>
    A) No. If a remote center coordinator desires to attend the workshop then a different email should be used for registering. 

    <br/><br/><b>Q) Can a Workshop Coordinator (WSC) register as a participant?</b><br/>
    A) No. But, WSC can register as a participant for other workshops for which he is not a workshop coordinator.
</div>
<br/><br/>
<b id="a5"><a href="faqAdmin.html#a5" style="color:#474686" onclick="togglediv(5)">Updating status of Participants</a></b>
<div id="5" style="display:none;">
    <br/><br/><b>Q) What buttons will be displayed for a particular status?</b><br/>
    A) Below is the status matrix, which explains the buttons to be displayed.
    <table class="content_container">
        <thead><tr>
                <td style="font-weight: bold;">Initial Status</td>
                <td style="font-weight: bold;">Registered</td>
                <td style="font-weight: bold;">Invalid</td>
                <td style="font-weight: bold;">Approved</td>
                <td style="font-weight: bold;">Confirmed</td>
                <td style="font-weight: bold;">Completed</td>
                <td style="font-weight: bold;">Cancelled</td>
            </tr></thead>
        <tbody>
            <s:iterator value="statusMatrix">
                <tr>
                    <td><s:property value="initialStatus"/></td>
                    <td style="text-align: center;"><s:property value="ifDisplayRegistered"/></td>
                    <td style="text-align: center;"><s:property value="ifDisplayInvalid"/></td>
                    <td style="text-align: center;"><s:property value="ifDisplayApproved"/></td>
                    <td style="text-align: center;"><s:property value="ifDisplayConfirmed"/></td>
                    <td style="text-align: center;"><s:property value="ifDisplayCompleted"/></td>
                    <td style="text-align: center;"><s:property value="ifDisplayCancelled"/></td>
                </tr>
            </s:iterator>
        </tbody>
    </table>   
    <br/><b>Q) Where will the reasons of registration invalid / cancelled be seen by admin?</b><br/>
    A) The reasons are displayed for the admin by clicking on the status.

    <br/><br/><b>Q) Will the mails be sent to all change in status?</b><br/>
    A) Mails will be sent while the participant is made “Invalid/ Cancelled” with reasons specified.

    For SSM model, mails will be sent when a RCC rejects the participant in his interface. 	
    Also a mail will be sent while Approving the participants (for funded and SSM). 

    Confirmation mail is not sent for SSM model.
    <br/><br/><b>Q) How will the participant get enrolled in moodle for that particular workshop?</b><br/>
    A) The participant will be mapped to moodle and a user account is created if not registered already in moodle. The credentials will be mailed to the participant on his successful enrollment. 

    For funded main workshops, the moodle enrollment happens when a participant is approved.
    For SSM, a button for enrolling the “Accepted Participants” is available in the update status page for admin.

    <br/><br/><b>Q) How many participants will be displayed in RCC interface for “Accepting/ Rejecting ” the participants in SSM Model?</b><br/>
    A) The participants who are “Approved” by the workshop team in an SSM workshop will be 	displayed in the RCC page for Manage Participants.

    <br/><br/><b>Q) Will the RCC receive an email when he rejects a participant in SSM workshops?</b><br/>
    A) Yes.

    <br/><br/><b>Q) Will Manage Participants in RCC interface be shown for normal funded main workshops?</b><br/>
    A) No. However, Manage Participants will be displayed if there is any SSM workshops on-	going.

    <br/><br/><b>Q) Can a workshop coordinator “Accept/ Reject” participants?</b><br/> 
    A) No.

    <br/><br/><b>Q) What if the moodle throws an error “The course does not exist”?</b><br/>
    A) Please make sure that the course name in moodle is same as the workshop name. Also, if the course is available in moodle.

    <br/><br/><b>Q) What if moodle fails while a participant is being mapped?</b><br/>
    A) The status of the participant will be “Approved (In-Process) ”. The software team can map the participants to moodle.

    <br/><br/><b>Q) What if a participant wishes to change the remote center after the registration is approved  by admin team?</b><br/>
    A) The participant should first be cancelled and then made invalid. Then the registration can be updated by the participant. Note that, in this process, two email will be sent to the 	participant (Cancelled and Invalid).

    <br/><br/><b>Q) How to map workshop coordinators to moodle for a main workshop?</b><br/>
    A) By clicking on a Button “Auto Enroll Workshop Coordinators to moodle” in Manage Remote Center Capacity Interface.

    <br/><br/><b>Q) Can the participant status be changed to  “Cancelled” after generating the attendance sheet?</b><br/>
    A) Yes. The participant's entry will be deleted from the attendance sheet automatically.

    <br/><br/><b>Q) Can the participant status be changed to  “Confirmed” after generating the attendance sheet?</b><br/>
    A) No. If required, Please contact Software Team.
</div>
<br/><br/>
<b id="a6"><a href="faqAdmin.html#a6" style="color:#474686" onclick="togglediv(6)">Creating Programme Schedule</a></b>
<div id="6" style="display:none;"><br/><br/>
    <b> Q)What will be the default update till date?</b><br/>
    A) Interval of 2 days from the actual day.

    <br/><br/><b>Q) Can the update till date be updated after creating the programme schedule?</b><br/>
    A) Yes. It can be updated. If a session (update till date) is updated, it updates for all the sessions of that particular day.

    <br/><br/><b>Q) Can the actual date be edited?</b><br/>
    A) No. The sessions are to be deleted. If required new sessions can be added.

    <br/><br/><b>Q) Can we add/ delete new sessions after generating the attendance sheet?</b><br/>
    A) Yes.

    <br/><br/><b>Q) When will the generate attendance button be visible?</b><br/>
    A) It will be available 5 days before the actual start date of the workshop.
</div>
<br/><br/>
<b id="a7"><a href="faqAdmin.html#a7" style="color:#474686" onclick="togglediv(7)">Attendance Module </a></b>

<div id="7" style="display:none;">
    <br/><br/><b>Q) Will all the participants be listed in the attendance sheet generated?</b><br/>
    A) Participants whose status is 'Confirmed' will be listed in the attendance sheet.

    <br/><br/><b>Q) What is the default value of the attendance generated?</b><br/>
    A) Absent. (Empty check boxes will be displayed)

    <br/><br/><b>Q) When will the WSC access the attendance page?</b><br/>
    A) Same day the workshop starts.

    <br/><br/><b>Q) Till when the attendance can be updated by WSC?</b><br/>
    A) Till the update till date of that particular day. By default, it is two days from the day of session. If failed to update, mail will be sent to the participants that they have been marked absent. 

    <br/><br/><b>Q)Till when the scanned sheet of attendance be uploaded?</b><br/>
    A) Two days more than the last "update till" date.

    <br/><br/><b>Q) Will all participants receive email on update of attendance?</b><br/>
    A) No. Only participants who have been marked absent will be sent an automated email.

    <br/><br/><b>Q) Till when the attendance be displayed to the WSC?</b><br/>
    A) Duration of two months after the actual end date of the workshop.

    <br/><br/><b>Q) Can RCC view the attendance?</b><br/>
    A) Yes. RCC can view the attendance and export as read only (.xls ) in the RCC home page. It will be displayed for two months from actual end date.
    'P' or 'A' is given instead of disabled check boxes in RCC interface.

    <br/><br/><b>Q) How can WSC identify if the attendance sheet is filled for the particular day?</b><br/>
    A) Date buttons with different color codes are available in attendance module.
    1. grey - not active
    2. faded green - filled and not active
    3. blue - active and not filled
    4. green - filled and active
</div>
<br/><br/>	
<b id="a8"><a href="faqAdmin.html#a8" style="color:#474686" onclick="togglediv(8)">Invite User For Registration</a></b>
<div id="8" style="display:none;">

    <br/><br/><b>Q)  What should be the type and maximum size of the file  uploaded ?</b><br/>
    A)  The file should be in “.xls” format and should be less than  2MB.

    <br/><br/><b>Q) Where is the "default template" available to fill participant data?</b><br/>
    A) The default  template is given in “invite user of registration” interface.
    All mandatory fields to be filled are already mentioned in the interface.

    <br/><br/><b>Q) What should be done if  error is displayed while trying to upload a file?</b><br/>
    A)  Make sure the excel file type and  size  matches with specification.
    Also the excel file template should match with given default template.

    <br/><br/><b>Q) What should be done for sending the registration link to invalid records ?</b><br/>
    A) Reasons for invalid records can be checked by clicking on “To see Invalid Records and Reasons”  button. Correct the data and upload the file again. After validation, link can be sent for registration.

    <br/><br/><b>Q)  Is participant registered for workshop automatically by sending invite link ?</b><br/>
    A) No. The participants has to register by clicking on the invite link.

    <br/><br/><b>Q) What should be done if  “RC not Found in Database”  error is thrown ?</b><br/>
    A) Please add the new remote center in Manage Remote Center Interface.

    <br/><br/><b>Q) What should be done if  “Wrong institute name” error is thrown , even after entering the appropriate institute name in excel file?</b><br/>
    A) Institute name should match the 'Project Name' database.

    <br/><br/><b>Q) How to cancel the participants who have been sent an Invitation link?</b><br/>
    A) Enable / Disable the participants by clicking on the button in "Participants Invited But not Registered" page.

    <br/><br/><b>Q) Is there a way to know if the participants who have been sent the link, but not registered for the workshop?</b><br/>
    A) Yes.  It can be viewed in “Participants Invited but not Registered” interface.
</div>

</div>