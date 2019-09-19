<%
    Set conn =Server.CreateObject("ADODB.Connection")
    conn.Open dbConn
    strFirstName = Request.Form("fName")
    strLastName = Request.Form("lName")
    strEmail = Request.Form("email")
	strVeEmail = Request.Form("vemail")
	strPhone = Request.Form("Phone")
	strGender = Request.Form("gender")
	strbday = Request.Form("Birthday")
	strpswd = Request.Form("Password")
	strvpswd = Request.Form("VPassword")

    submitForm = Request.Form("submitForm")
    submitDate = Request.Form("submitDate")
    pageID = Request.Form("pageID")

    strErrors = "N"
    strErrorMessage = ""
     SQLCheckEmail = "SELECT count(email) as TOTAL FROM customer WHERE email = '" & strEmail & "';"
    Set RSEmail = conn.Execute(SQLCheckEmail)
   
    Set NameRegExp = New RegExp   'Create a RegExp object instance
    Set EmailRegExp = New RegExp   'Create a RegExp object instance
	Set PhoneRegExp = New RegExp   'Create a RegExp object instance
    NameRegExp.Pattern = "[^a-zA-Z'\- ]"
    EmailRegExp.Pattern =   "^[-+.\w]{1,64}@[-.\w]{1,64}\.[-.\w]{2,6}$"
	PhoneRegExp.Pattern =   "\d{3}-\d{3}-\d{4}"
    If submitForm = 1 Then

        If Len(strFirstName) < 3  then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "* length of first name should be greater than 2. <br>"
        End If

        If NameRegExp.Test(strFirstName) then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "* Please enter a valid first name. <br>"
        End If

        If Len(strLastName) < 3  then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "*length of last name should be greater than 2. <br>"
        End If

        If NameRegExp.Test(strLastName) then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "* Please enter a valid Last name. <br>"
        End If

        If NOT EmailRegExp.Test(strEmail) then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "* Please enter a valid email. <br>"
        End If

		If NOT (strVeEmail = strEmail)  then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "*Verify email doesn't match. " & strVeEmail  &  "----" & strEmail  & "<br>"
        End If

        If Len(strPhone) = 0 then
            strPhone = null
        ElseIf NOT PhoneRegExp.Test(strPhone) then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "* Phone number is not in correct format. <br>"
        ElseIf Len(strPhone) > 12  then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "*Phone number should not be more than 12 digits. <br>"
        End If

        If Not IsDate(strbday)  then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "*Birthday is not a valid date. <br>"
        End If

		If Len(strpswd) < 7  then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "*length of password should be greater than 6. <br>"
        End If

		If Not (strpswd) = (strvpswd)  then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "*Verify password doesn't match. <br>"
        End If

        If RSEmail("Total") > 0 then
            strErrors = "Y"
            strErrorMessage = strErrorMessage & "*This email is already registered. Either login or choose another email. <br>"
        End If

     formOutputMessage = ""

        If strErrors = "Y" Then
            formOutputMessage = "Errors: <br>" & strErrorMessage  
        Else 
            formOutputMessage = "Success"
            If strbday = "" Then
                SQLInsert = "INSERT into customer(email, fName, lName, phone, dob, gender, pword) values ('" & strEmail & "','" & strFirstName & "','" & strLastName & "','" & strPhone & "', NULL ,'" & strGender & "','" & strpswd & "');"
                conn.Execute(SQLInsert)
            ELSE
                SQLInsert = "INSERT into customer(email, fName, lName, phone, dob, gender, pword) values ('" & strEmail & "','" & strFirstName & "','" & strLastName & "','" & strPhone & "','" & strbday & "','" & strGender & "','" & strpswd &"');"
                conn.Execute(SQLInsert)
            End IF
            SQLGetCustdID = "SELECT max(custID) as cID from customer;"
            Set RScustID = conn.Execute(SQLGetCustdID)

            strOldVID = session("VisitorID")
            SQLUpdate = "UPDATE orders set custID = " & RScustID("cID") & " WHERE visitorID='" & strOldVID & "';"
            SQLcartValidate = "SELECT count(*) as TOTAL from orders where visitorID = '" & strOldVID &"' and custID = " & RScustID("cID")
            SQLcartID = "SELECT OID from orders where visitorID = '" & strOldVID &"' and custID = " & RScustID("cID")
             Set RSSQLUpdate = conn.Execute(SQLUpdate)
             Set RSSQLcartValidate = conn.Execute(SQLcartValidate)
            Set RSgetCart = conn.Execute(SQLcartID)

             If RSSQLcartValidate("TOTAL") > 0 then
                session("cartID") = RSgetCart("OID")
             End IF
             session("loginText") = "Welcome " & strFirstName & "(<a href='index.asp?pageID=6&logout=1' class='whiteLinks'>Logout</a>)"
             session("getVisitorID") = 1
             session("visitorID") = RScustID("cID")
             session("userName") = strFirstName
             conn.Close 'Close the database connection
             response.Redirect "index.asp"
        End IF
     End IF
    RSEmail.Close() 'Close the recordset
    conn.Close 'Close the database connection

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

    <form action="index.asp?pageID=7" name="myForm" method="post">
        First Name
        <br>
        <input type="text" name="fName" value="<% =strFirstName %>">
        <br>

        <br /> 
        Last Name
        <br>
        <input type="text" name="lName" value="<% =strLastName %>">
        <br>

        <br /> 
        Email
        <br>
        <input type="text" name="email" value="<% =strEmail %>">
        <br>
        <br /> Verify Email

        <br>
        <input type="text" name="vemail" value="<% =strVeEmail %>">
        <br>
        <br /> Phone

        <br>
        <input type="text" name="Phone" value="<% =strPhone %>">
        <br>
        <br /> Birthday

        <br>
        <input type="date" name="Birthday" value="<% =strbday %>">
        <br>
        <br /> Gender

        <br />
        <select name="gender">
            <option value="0">Male</option>
            <option value="1">Female</option>
        </select>
        <br /> Password

        <br>
        <input type="password" name="Password" value="<% =strpswd %>">
        <br>
        <br /> Verify Password

        <br>
        <input type="password" name="VPassword" value="<% =strvpswd %>">
        <br>
        <br />

        <br />

        <input type="submit" value="Submit Button">
        <br />
        <input type="hidden" name="pageID" value="7" />
        <input type="hidden" name="submitForm" value="1" />
        <input type="hidden" name="submitDate" value="<% =date() %>" />
    </form>