<!--#include file="connection.asp"-->
<%
	pid = Request.QueryString("pid")
	pname=Request.Form("txtPname")
	pdesc=Request.Form("taPdesc")
	pimage=Request.Form("txtPimage")
	cid=Request.Form("slCid")
	sid=Request.Form("slSid")
	sizeid=Request.Form("slSizeid")
	pprice = Request.Form("txtPprice")
	pquantity = Request.Form("txtPquantity")
	pstatus=Request.Form("rdPstatus")
	'Kiểm tra nếu tên danh mục có rồi thì báo lỗi
	sql="select * From 0203466_product_1682 where pname='" & pname &"' and pid<>" & pid 
	rs.open sql, conn 
	if (not rs.eof) then
		Session("product_edit_error")="Tên sản phẩm: " & pname &" đã có rồi!"
		Response.Redirect("product_edit.asp")	
    else 
		sql = "update 0203466_product_1682 set pname='" & pname & "',pdesc='" & pdesc & "',pimage ='" & pimage & "',pprice = " & pprice & ",pquantity = " & pquantity & ",cid = " & cid & ",sid = " & sid & ",sizeid = " & sizeid & ",pstatus = " & pstatus & " where pid = " & pid 
		'Response.write(sql)
		conn.execute sql 
		conn.close
		Session("product_edit_error")=""
		Session("product_error")="Cập nhật thành công"
		Response.Redirect("product_view.asp")
	end if		
	
%>
<html>
	<head>
		<meta charset="utf-8">
		<title>Tiêu đề trang web</title>
	</head>
	<body>
	
	</body>
</html>