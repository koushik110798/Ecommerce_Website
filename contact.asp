<%
    strFirstName = Request.QueryString("fName")
    strLastName = Request.QueryString("lName")
    strEmail = Request.QueryString("email")
    strMessage = Request.QueryString("message")

    submitForm = Request.QueryString("submitForm")
    submitDate = Request.QueryString("submitDate")
    pageID = Request.QueryString("pageID")

    strErrors = "N"
    strErrorMessage = ""
     Dim NameRegExp, EmailRegExp

    Set NameRegExp = New RegExp   'Create a RegExp object instance
    Set EmailRegExp = New RegExp   'Create a RegExp object instance
    NameRegExp.Pattern = "[^a-zA-Z' \-]"
    EmailRegExp.Pattern =   "^[-+.\w]{1,64}@[-.\w]{1,64}\.[-.\w]{2,6}$"
    If submitForm = 1 Then
        
        If Len(strFirstName) < 3  then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "* The first name field must contain atleast 3 characters. <br>"
        End If

        If NameRegExp.Test(strFirstName) then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "* The first name is not valid. <br>"
        End If

        If Len(strLastName) < 3  then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "*The last name field must contain atleast 3 characters. <br>"
        End If

        If NameRegExp.Test(strLastName) then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "* The last name is not valid. <br>"
        End If

        If Len(strMessage) < 10  then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "*The Message field must contain atleast 10 characters. <br>"
        End If

        If NOT EmailRegExp.Test(strEmail) then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "* The email is not valid. <br>"
        End If
        
      
        
       

        
     formOutputMessage = ""

        If strErrors = "Y" Then
            formOutputMessage = "Errors: <br>" & strErrorMessage    
        Else
           
           ' strMessageBody = "Sender: " & strFirstName & " " & strLastName & "<br><br>Send Date: " & submitDate & "<br><br>Message: " & strMessage
           ' Set myMail = CreateObject("CDO.Message")
           ' myMail.Subject = "Web Form Message"
           ' myMail.From = strEmail
           ' myMail.To = "customerService@unm.edu"
           ' myMail.HTMLBody = strMessageBody
           ' myMail.Send
           ' set myMail = nothing
            strFirstName = ""
            strLastName = ""
            strEmail = ""
            strMessage = ""
            formOutputMessage = "Your message has been sent."
        End IF
%>

<table>
    <tr>
        <td style="width: 394px; align-content: center; color: red" colspan="2" class="normalRed">
            <% =formOutputMessage  %>
        </td>
    </tr>
    <tr>
        <td style="width: 394px; height: 20px" colspan="2"></td>
    </tr>
</table>
<% 
        End IF

%>

<h3>Contact Form</h3>

<form action="index.asp" name="myForm" method="get">
    First Name<br>
    <input type="text" name="fName" value="<% =strFirstName %>"><br>
    <br />

    Last Name<br>
    <input type="text" name="lName" value="<% =strLastName %>"><br>
    <br />

    Email<br>
    <input type="text" name="email" value="<% =strEmail %>"><br>
    <br />

    Message<br />
    <textarea rows="2" cols="20" name="message"><% =strMessage %></textarea><br />
    <br />

    <br />

    <input type="submit" value="Submit Button"><br />
    <input type="hidden" name="pageID" value="4" />
    <input type="hidden" name="submitForm" value="1" />
    <input type="hidden" name="submitDate" value="<% =date() %>" />
</form>


