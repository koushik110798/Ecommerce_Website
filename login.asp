<%
     loginAttempt = Request.Form("loginAttempt") 
    strLogout = Request.QueryString("logout")
    
    uName = Request.Form("email")
    pw = Request.Form("pwd")
    displayMessage = ""
    if(loginAttempt = 1) then
         Set conn =Server.CreateObject("ADODB.Connection")
        conn.Open dbConn
        SQLValidate = "select count(*) as TOTAL from customer where email='" & uName & "' and pword='" & pw & "';"
        RSSQLValidate = conn.Execute(SQLValidate)
        If ( RSSQLValidate("TOTAL") = 1) then
            SQLcustomerName = "select custID, fName from customer where email='" & uName & "' and pword='" & pw & "';"
           Set RSlogin = conn.Execute(SQLcustomerName)

            strOldVID = session("visitorID")

            SQLUpdate = "UPDATE orders set custID = " & RSlogin("custID") & " WHERE visitorID= '" & strOldVID & "';"

            SQLcartID = "SELECT OID from orders where visitorID = '" & strOldVID &"' and custID = " & RSlogin("custID")
            SQLcartValidate = "SELECT count(*) as TOTAL from orders where visitorID = '" & strOldVID &"' and custID = " & RSlogin("custID")

             Set RSUpdate = conn.Execute(SQLUpdate)
             Set RScartValidate = conn.Execute(SQLcartValidate)
             Set RSgetCart = conn.Execute(SQLcartID)

             If RScartValidate("TOTAL") > 1 Then
             session("cartID") = RSgetCart("OID")
             End If

             session("loginText") = "Welcome " & RSlogin("fName") & "(<a href='index.asp?pageID=6&logout=1' class='whiteLinks'>Logout</a>)"

             session("getVisitorID") = 1
             session("visitorID") = RSlogin("custID")
             session("userName") = RSlogin("fName")

             RSlogin.Close()
             RSUpdate.Close() 
             RSgetCart.Close()
            conn.Close

             response.Redirect "index.asp"
        ELSE
            displayMessage = "Invalid Email or Password"
        End If
        
    End If

    If strLogout = 1 then 
        session("loginText") = "<a href='index.asp?pageID=6' class='whiteLinks'>Login</a>"
        session("getVisitorID") = 0
        session("visitorID") = ""
        session("userName") = ""
        session("cartID") = 0
        response.Redirect "index.asp"
    End If

    %>
<div style="width: 394px; align-content: center; color: red" colspan="2" class="normalRed">
                <% =displayMessage  %>
            </div>
<div align="center" style="padding-top: 40px;">
    Sign In
     <br />
    <br />
    <form action="index.asp" name="loginForm" method="POST">
        Email<br>
        <input type="text" name="email" value="<% =strEmail %>"><br>
        <br />

        Password<br>
        <input type="password" name="pwd" value="<% =strPwd %>"><br>
        <br />
        <br />

        <input type="submit" value="Login Button"><br />
        <input type="hidden" name="pageID" value="6" />
        <input type="hidden" name="loginAttempt" value="1" />
        <br />

    </form>
    <hr />
    <br />
    <input type="button" value="Create Account" onclick="location.href = 'index.asp?pageID=7';" />

</div>
