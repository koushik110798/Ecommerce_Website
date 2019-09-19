<%@ Language=VBScript %>
<!-- #include file="dbconn.asp" -->
<%
'On Error Resume Next
    Response.Write("123")
%>
<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <title></title>
</head>
<body>
<% 
'svr = "Server=np:\\.\pipe\LOCALDB#2908c42c\TSQL\QUERY;"
'provider = "DRIVER={SQL Server};"
'dbname = "Database=MGMT632;"
'creds = "uid=dbuser;pwd=asdf4321!!;"

'---CONNSTR IS THE CONNECTION STRING TO THE DB
'connstr = provider & svr & dbname & creds
'connstr = "Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Database=MGMT632;uid=dbuser;pwd=asdf4321!!;"

'---OPEN THE CONNECTION
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open connstr
'Response.Write(Err.Description)
'Response.End()

'---EXECUTE SQL STATEMENT
SQLStmt = "SELECT * FROM customer"
Set RS = conn.Execute(SQLStmt)
Response.Write(Err.Description)

'---TEST DATA
If Not(RS.EOF) Then
    RS.MoveFirst
Response.Write(Err.Description)
    c = 0
    Do While Not(RS.EOF)
        Response.Write("custID=" & RS("custID") & ", name=" & RS("fName") & "<br />")
        Response.Write(Err.Description)

        If c > 100 Then
            '--- COMMENT IN TO GENERATE ERROR Exit While
            Exit Do
        End If
        c = c + 1

        RS.MoveNext
    Loop
Else
    Response.Write("NO DATA<br />")
End If


'---CLOSE RECORDSET AND CONNECTION
RS.Close()
conn.Close

Response.Write("PAGE COMPLETE..." & Now())
%>

</body>
</html>