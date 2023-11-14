<!--#include file="connection.asp"-->
<%
    pid = Request.Form("pid")
	username=Request.Form("username")
    email = Request.Form("email")
    content = Request.Form("tacontent")
	
	sql = "insert into comment (username,email,coContent,pid) values ('" & username & "','" & email & "','" & content & "'," & pid & ")"
	conn.execute sql 
	conn.close
	Session("comment_add_error")="Thêm mới thành công"
	Response.Redirect("product_detail.asp?pid="&pid)
	
%>