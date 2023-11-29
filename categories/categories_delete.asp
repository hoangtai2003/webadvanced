<!--#include file="connection.asp"-->
<%
	cid = Request.QueryString("cid")
	sql = "delete from 0203466_categories_1682 where cid=" & cid 
	conn.execute sql 
	conn.close
	session("categories_error")="Xóa thành công!"
	Response.Redirect("categories_view.asp")
	
%>