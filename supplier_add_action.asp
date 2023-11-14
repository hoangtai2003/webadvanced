<!--#include file="connection.asp"-->
<%
	sname = Request.Form("txtSname")
	saddress = Request.Form("txtSaddress")
	sphone = Request.Form("txtSphone")
	stax = Request.Form("txtStax")
	sstatus = Request.Form("rdSstatus")
	sql="select * from 0203466_supplier_1682 where sname like '" & sname & "'"
	rs.open sql,conn 
	if (not rs.eof) then
		session("supplier_add_error")="Tên nhà cung cấp " & sname & " đã tồn tại!"
		Response.Redirect("supplier_add.asp")
	else 
		'chèn vào CSDL
		sql = "insert into 0203466_supplier_1682(sname,saddress,sphone,stax, sstatus) values ('" & sname & "','" & saddress & "','" & sphone & "'," & stax & "," & sstatus & ")"
		conn.execute sql 
		session("supplier_error")="Thêm mới thành công!"
		response.redirect("supplier.asp")
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