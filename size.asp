<!--#include file="connection.asp"-->
<%
	sql = "select * from 0203466_size_1682"
	rs.open sql, conn 
%>
<html>
	<head>
		<meta charset="utf-8">
		<title>Tiêu đề trang web</title>
	</head>
	<body>
		<h1 align=center>Size</h1>
		<center>
			<font color=red>
				<%=Session("size_error")%>
			</font>
		
		<br>
		<a href="size_add.asp">Thêm mới size</a>
		</center>
		<table border=1 cellspacing=5 cellpadding=5 align=center>
			<tr>
				<th>Mã</th>
				<th>Size</th>
				<th>Trạng thái</th>
				<th>Sửa</th>
				<th>Xóa</th>
			</tr>
			<%
				if (rs.eof) then
					response.write("<tr><td colspan=5>Bảng không có dữ liệu!</td></tr>")
				else 
					while not rs.eof 
					%>
						<tr>
							<td><%=rs("sizeid")%></td>
							<td><%=rs("sizename")%></td>
							<td>
								<% if (rs("sizestatus")=0) then
										response.write("Ngừng hoạt động")
								   else 
										response.write("Hoạt động")
								   end if 
								%>
							</td>
							<td><a href="size_edit.asp?sizeid=<%=rs("sizeid")%>">Edit
								
							</a>
							</td>
                            <td>
                                <a onclick="return confirm('Bạn có chắc muốn xoá <%=rs("sizename")%> hay ko?');"  href="size_delete.asp?sizeid=<%=rs("sizeid")%>">Xóa</a>
                            </td>

					<%		
					rs.movenext
					wend 
				end if
				rs.close 
				conn.close 
			%>
		</table>
	</body>
</html>