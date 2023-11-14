<!--#include file="connection.asp"-->
<%
	pid = Request.QueryString("pid")
	sql = "delete from 0203466_product_1682 where pid = " & pid 
	conn.execute sql
	Session("product_error")="Xóa thành công!"
	Response.redirect("product_view.asp")
%>