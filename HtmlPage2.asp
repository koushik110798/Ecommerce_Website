<%
    Set conn = Server.CreateObject("ADODB.Connection") 'Set DB connection variable conn.Open dbConn 'open database connection
    SQLDept = "select deptID, name from department;" 'Select all departments
    Set RSDept = conn.Execute(SQLDept) 'Execute query to display the departments
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
</head>
<body>

</body>
</html>