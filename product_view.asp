<!--#include file="connection.asp"-->
<%
	sql = "select [0203466_product_1682].*, [0203466_categories_1682].cname, [0203466_supplier_1682].sname, [0203466_size_1682].sizename from [0203466_product_1682], [0203466_categories_1682], [0203466_size_1682],[0203466_supplier_1682] where [0203466_product_1682].cid = [0203466_categories_1682].cid and [0203466_product_1682].sid = [0203466_supplier_1682].sid and [0203466_product_1682].sizeid = [0203466_size_1682].sizeid" 
	rs.open sql, conn
%>
<html>
	<head>
		<title>Tiêu đề trang web</title>
		<meta charset="utf-8">
	</head>
	<body>
			<h1 align=center>Danh sách các sản phẩm trong hệ thống</h1>
			<center><font color=red><%=Session("product_error")%></center>
			<br>
			<center><a href="product_add.asp">Thêm mới một sản phẩm</a></center>
			<table border=1 width=800 align=center>
				<tr>
					<th>Mã sản phẩm</th>
					<th>Tên sản phẩm </th>
					<th>Mô tả</th>
					<th>Ảnh</th>
					<th>Giá tiền </th>
					<th>Số lượng </th>
					<th>Nhóm sản phẩm</th>
					<th>Nhà cung cấp</th>
					<th>Size</th>
					<th>Trạng thái</th>
					<th>Sửa</th>
					<th>Xóa</th>
					<th>Chi tiết sản phẩm</th>
				</tr>
			<%
				if (rs.eof) then
					response.write("<tr><td colspan=10>Bảng không có dữ liệu!</td></tr>")
				else 
					while not rs.eof 
					%>
						<tr>
							<td><%=rs("pid")%></td>
							<td><%=rs("pname")%></td>
							<td><%=rs("pdesc")%></td>
							<td><img src="images/<%=rs("pimage")%>" width=200></td>
							<td><%=rs("pprice")%></td>
							<td><%=rs("pquantity")%></td>
							<td><%=rs("cname")%></td>
							<td><%=rs("sname")%></td>
							<td><%=rs("sizename")%></td>
							<td>
								<% if (rs("pstatus")=0) then
										response.write("Ngừng hoạt động")
								   else 
										response.write("Hoạt động")
								   end if 
								%>
							</td>
							<td><a href="product_edit.asp?pid=<%=rs("pid")%>" class="btn btn-sm btn-primary">
								Sửa
							</a>
							</td>
							<td><a onclick="return confirm('Bạn có chắc muốn xóa <%=rs("pname")%>?')" href="product_delete_action.asp?pid=<%=rs("pid")%>">
								Xóa
							</a>
							</td>
							<td>
								<a href="product_detail_action	.asp?pid=<%=rs("pid")%>">Chi tiết</a>
							</td>
					<%		
					rs.movenext
					wend 
				end if
				rs.close 
				conn.close 
				Session.Contents.Remove("product_error")
			%>
			</table>		
	</body>
</html>
