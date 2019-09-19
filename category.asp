<% 
  catID = Request.QueryString("catID")
IF NOT catID > 0 Then
catID = 0 ' If no catID passed, set to 0
End if  
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open dbConn

    SQLValidate = "select count(*) as Total from product where catID = " & catID & ";"
    Set RSvalidate = conn.Execute(SQLValidate)

    If RSvalidate("Total") = 0 Then
    Response.Redirect "index.asp?pageID=1"

ELSE
    SQLStmt = "SELECT p.prodID, p.prodName, p.prodHeadline, p.tImage, c.name as cName, d.name as dName from product p, category c, department d where p.catID = c.catID and c.deptID = d.deptID and p.catID = " & catID & ";"
    Set RS = conn.Execute(SQLStmt)
    strHeader = "Department: " & RS("dName") & " > " & "Category: " & RS("cName")
END IF

%>

<table>
    <tr>
        <td><% =strHeader %></td>
    </tr>
    <% do while not RS.eof %>

    <tr>
        <td>

            <a href="index.asp?pageID=3&prodID=<% =RS("prodID") %>">
                <table>
                    <tr>
                        <td><img src ="<% =RS("tImage") %>" /></td>
                        <td>
                            <div><h3>Product Headline : <% =RS("prodHeadline") %></h3></div>
                            <div>Product Name : <% =RS("prodName") %></div>
                            <div>Category Name : <% =RS("cName") %></div>
                            <div>Department Name : <% =RS("dName") %></div>
                        </td>
                    </tr>
                </table>

              

            </a>
        </td>
    </tr>

    <%
    RS.movenext
    Loop
    %>
    </table>
