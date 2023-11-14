<!--#include file="connection.asp"-->
<%
	sizeid = Request.QueryString("sizeid")
	sql = "delete from 0203466_size_1682 where sizeid=" & sizeid 
	conn.execute sql 
	conn.close
	session("size_error")="Xóa thành công!"
	Response.Redirect("size.asp")
	
%>