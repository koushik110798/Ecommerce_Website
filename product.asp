
<%
prodID = Request.QueryString("prodID")
IF NOT prodID > 0 Then
prodID = 0 ' If no prodID passed, set to 0
End if
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open dbConn

    SQLValidate = "select count(*) as Total from product where prodID = " & prodID & ";"
    Set RSvalidate = conn.Execute(SQLValidate)

    If RSvalidate("Total") = 0 Then
    %>
    <table cellspacing="0" cellpadding="0" border="0" width="809">
       <tr><td height="5" colspan="2"></td></tr>
    <tr>
        <td class="productTitle" width="200" valign="top" rowspan="11">
            No Product Found
        </td>
    </tr>
</table>
<%
    ELSE
    SQLStmt = "SELECT prodID, prodName, prodHeadline, [desc], nImage, rPrice, sPrice FROM product WHERE prodID = " & prodID & ";"
    Set RS = conn.Execute(SQLStmt)
    regPrice = CSng(RS("rPrice"))
    salePrice = CSng(RS("sPrice"))
    %>

<img  src ="<% =RS("nImage")%>" style="height:286px; width:191px"/>
<p>Product Name: <% =RS("prodName")%></p>
<p>Product Headline: <% =RS("prodHeadline")%></p>
<p>Product Description: <% =RS("desc")%></p>
<% If regPrice = salePrice Then %>
<p>Product Price : <b> <% =FormatCurrency(RS("sPrice")) %></b></p> 
<% ELSE %>
<p>Product Price : <b style="text-decoration:line-through"> <% =FormatCurrency(RS("rPrice")) %></b></p> 
<p>Sale Price : <b> <% =FormatCurrency(RS("sPrice")) %></b></p>
<% End If %>
<br />
<input type="button" value="Add to cart"  onclick="addToCart(<% =prodID %>,<% =salePrice %>)">
<div id="itemAdded"></div>
<br>      
<% End If %>