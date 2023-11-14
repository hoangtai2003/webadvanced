<!--#include file="connection.asp"-->
<%
	'lấy dữ liệu sắp xếp theo corder giảm dần
	sql = "select * from 0203466_categories_1682"
	rs.open sql, conn 
%>
<html>
	<head>
		<meta charset="utf-8">
		<title>Tiêu đề trang web</title>
	</head>
	<body>
		<h1 align=center>Danh mục nhóm sản phẩm</h1>
		<center>
			<font color=red>
				<%=Session("categories_error")%>
			</font>
		
		<br>
		<a href="categories_add.asp">Thêm mới một danh mục</a>
		</center>
		<table border=1 cellspacing=5 cellpadding=5 align=center>
			<tr>
				<th>Mã</th>
				<th>Tên</th>
				<th>Mô tả</th>
				<th>Ảnh</th>
				<th>Sắp xếp</th>
				<th>Trạng thái</th>
				<th>Sửa</th>
				<th>Xóa</th>
			</tr>
			<%
				if (rs.eof) then
					response.write("<tr><td colspan=6>Bảng không có dữ liệu!</td></tr>")
				else 
					while not rs.eof 
					%>
						<tr>
							<td><%=rs("cid")%></td>
							<td><%=rs("cname")%></td>
							<td><%=rs("cdesc")%></td>
							<td><img src="images/<%=rs("cimage")%>" width=200></td>
							<td><%=rs("corder")%></td>
							<td>
								<% if (rs("cstatus")=0) then
										response.write("Ngừng hoạt động")
								   else 
										response.write("Hoạt động")
								   end if 
								%>
							</td>
							<td><a href="categories_edit.asp?cid=<%=rs("cid")%>">Edit
								
							</a>
							</td>
							<td><a href="categories_delete.asp?cid=<%=rs("cid")%>">Delete
								
							</a>
							</td>
					<%		
					rs.movenext
					wend 
				end if
				rs.close 
				conn.close 
			%>
		</table>
		<center>
		<a href="categories_add.asp">Thêm mới một danh mục</a>
		</center>
	</body>
</html>