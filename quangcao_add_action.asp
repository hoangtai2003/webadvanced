<!--#include file="connection.asp"-->
<%
	ten = Request.Form("ten")
	tungay = Request.Form("tungay")
	denngay = Request.Form("denngay")
	anh = Request.Form("anh")
	link = Request.Form("link")
    cid = Request.Form("slCid")
	sql="select * from QuangCao where ten like '" & ten & "'"
	rs.open sql,conn 
	if (not rs.eof) then
		session("quangcao_add_error")="Quảng cáo" & ten & " đã tồn tại!"
		Response.Redirect("quangcao_add.asp")
	else 
		'chèn vào CSDL
		sql = "insert into QuangCao(ten, tungay, denngay, anh, link, cid) values ('" & ten & "','" & tungay & "','" & denngay & "','" & anh & "','" & link & "', "& cid &")"
		conn.execute sql 
		session("quangcao_error")="Thêm mới thành công!"
		response.redirect("quangcao_add.asp")
	end if 
	rs.close
	conn.close
%>