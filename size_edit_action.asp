<!--#include file="connection.asp"-->
<%
	sizeid = Request.Form("sizeid")
	sizename = Request.Form("txtSizename")
	sizestatus = Request.Form("rdSizestatus")
	sql = "update 0203466_size_1682 set sizename='" & sizename & "',sizestatus=" & sizestatus & " where sizeid = " & sizeid 
	conn.execute sql 
	conn.close
	session("size_error") = "Cập nhật thành công!"
	Response.Redirect("size.asp")
%>
<html>
	<head>
		<meta charset="utf-8">
		<title>Tiêu đề trang web</title>
	</head>
	<body>
	</body>
</html>