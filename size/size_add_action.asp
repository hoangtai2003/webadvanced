<!--#include file="connection.asp"-->
<%
	sizename = Request.Form("txtSizename")
	sizestatus = Request.Form("rdSizestatus")
	sql="select * from 0203466_size_1682 where sizename like '" & sizename & "'"
	rs.open sql,conn 
	if (not rs.eof) then
		session("size_add_error")="size " & sizename & " đã tồn tại!"
		Response.Redirect("size_add.asp")
	else 
		'chèn vào CSDL
		sql = "insert into 0203466_size_1682(sizename, sizestatus) values ('" & sizename & "'," & sizestatus & ")"
		conn.execute sql 
		session("size_error")="Thêm mới thành công!"
		response.redirect("size.asp")
	end if 
	rs.close
	conn.close
%>
<html>
	<head>
		<meta charset="utf-8">
		<title>Tiêu đề trang web</title>
	</head>
	<body>
	</body>
</html>