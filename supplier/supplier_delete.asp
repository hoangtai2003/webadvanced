<!--#include file="connection.asp"-->
<%
	sid = Request.QueryString("sid")
	sql = "delete from 0203466_supplier_1682 where sid=" & sid 
	conn.execute sql 
	conn.close
	session("supplier_error")="Xóa thành công!"
	Response.Redirect("supplier.asp")
	
%>