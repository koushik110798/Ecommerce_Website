<%@  language="VBScript" %>
<!--#include file="includes/dbconn.asp"-->
<!--#include file="includes/common.asp"-->
<link href="includes/styles.css" rel="stylesheet" type="text/css">
<script src="includes/commonJS.js"></script>

<%
 call getCustID()
 response.write("VisitorID: " & session("VisitorID") & " cartID: " & session("cartID"))
 %>

<html>
<head>
    <title>MGMT 632</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<body bgcolor="#f8f8f8">
    <center>
<% sPageID = Request.QueryString("pageID") %>

<table cellspacing="0" cellpadding="0" border="0" width="1024">
    <tr><td colspan="2"><!--#include file="includes/header.asp"--></td></tr>
	<tr>
		<td class="normal" width="215" valign="top" align="left"><!--#include file="includes/leftNav.asp"--></td>
		<td class="normal" width="809" height="400" valign="top">
			<!-- Begin Page -->
				<% 
					If sPageID = 1 Then
						'display department page based on deptID
                    %>
                        <!--#include file="department.asp"-->
                    <%
					ElseIf sPageID = 2 Then
						'display category page based on catID
                    %>
                        <!--#include file="category.asp"-->
                    <%
					ElseIf sPageID = 3 Then
						'display product page based on prodID
                    %>
                        <!--#include file="product.asp"-->
                    <%
					ElseIf sPageID = 4 Then
						'display contact us
                    %>
                        <!--#include file="contact.asp"-->
                    <%
					ElseIf sPageID = 5 Then
						'display shoppingCart page
                    %>
                        <!--#include file="cart.asp"-->
                    <%
					ElseIf sPageID = 6 Then
						'display login page
                    %>
                        <!--#include file="login.asp"-->
                    <%
					ElseIf sPageID = 7 Then
						'display create account page
                    %>
                        <!--#include file="createAccount.asp"-->
                    <%
					Else
						'display homepage
                    %>
                        <!--#include file="home.asp"-->
                    <%
					End If
				%>
			<!-- End Page -->
		</td>
	</tr>
    <tr><td colspan="2"><!--#include file="includes/footer.asp"--></td></tr>
</table>
</center>
</body>
</html>
