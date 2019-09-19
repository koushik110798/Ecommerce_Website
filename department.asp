<%
    Set conn =Server.CreateObject("ADODB.Connection")
    conn.Open dbConn
    deptID = Request.QueryString("deptID")
    IF NOT deptID > 0 Then
    DeptID = 0 ' If no deptID passed, set to 0
    End if

    SQLValidate = "select count(*) as Total from department where deptID = " & deptID & ";"
    Set RSvalidate = conn.Execute(SQLValidate)

    If RSvalidate("Total") = 0 Then
        SQLStmt = "select pageID=1, linkID='deptID', deptID as useID, name, [desc] from department;"

        Set RS = conn.Execute(SQLStmt)
    
        strHeader = "Departments"
    ELSE
        SQLStmt = "select pageID=2, linkID='catID',c.catID as useID, c.name, c.[desc], d.name as dName FROM category c, department d WHERE c.deptID = d.deptID and c.deptID = " & deptID & ";"
        Set RS = conn.Execute(SQLStmt)
    
        strHeader = "department: " & RS("dName")

    End If
%>


<table>
    <tr>
        <td><% =strHeader %></td>
    </tr>
    <% do while not RS.eof %>

    <tr>
        <td>
            <a href="index.asp?pageID=<% =RS("pageID") %>&<% =RS("linkID")  %>=<% =RS("useID") %>"><% =RS("name") %></a>
        </td>
    </tr>
    <tr>
        <td><% =RS("desc") %></td>
    </tr>

    <%
    RS.movenext
    Loop
    %>
</table>

<%
    RSvalidate.Close() 'Close the recordset
    RS.Close() 'Close the recordset
    conn.Close 'Close the database connection
%>
