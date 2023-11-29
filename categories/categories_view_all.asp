<!--#include file="connection.asp"-->
<%
	action =Request("action")
	cid = Request("cid")
	select case action
	case "add_new"
		cname=Request.Form("txtCname")
		cdesc=Request.Form("taCdesc")
		cimage=Request.Form("txtCimage")
        corder=Request.Form("txtCorder")
		cstatus=Request.Form("rdCstatus")
		'Kiểm tra nếu tên danh mục có rồi thì báo lỗi
		sql="select * From 0203466_categories_1682 where cname='" & cname &"'"
		rs.open sql, conn 
		if (not rs.eof) then
			Session("categories_error")="Tên danh mục: " & cname &" đã có rồi!"	
		else 
			sql = "insert into 0203466_categories_1682(cname,cdesc,cimage,corder,cstatus) values ('" & cname & "','" & cdesc & "','" & cimage & "'," & corder & "," & cstatus & ")"
			'Response.write(sql)
			conn.execute sql 
			Session("categories_error")="Thêm mới thành công"
		end if
		rs.close 
	case "save_edit"
		cname=Request.Form("txtCname")
		cdesc=Request.Form("taCdesc")
		cimage=Request.Form("txtCimage")
		corder=Request.Form("txtCorder")
		cstatus=Request.Form("rdCstatus")
		'Kiểm tra nếu tên danh mục có rồi thì báo lỗi
		sql="select * From 0203466_categories_1682 where cname='" & cname &"' and cid<>" & cid 
		rs.open sql, conn 
		if (not rs.eof) then
			Session("categories_error")="Tên sản phẩm: " & cname &" đã có rồi!"
				
		else 
			sql = "update 0203466_categories_1682 set cname='" & cname & "', cdesc='" & cdesc & "',cimage ='" & cimage & "', corder = " & corder & ",cstatus = " & cstatus & " where cid = " & cid 
			'Response.write(sql)
			conn.execute sql 
			Session("categories_error")="Cập nhật thành công"
		end if
		rs.close 
    case "delete"
        sql = "delete from 0203466_categories_1682 where cid=" & cid 
        conn.execute sql 
        session("categories_error")="Xóa thành công!"
	end select 
	sql = "select * from 0203466_categories_1682"
	rs.open sql, conn  
%>
<html>
	<head>
		<title>Tiêu đề trang web</title>
		<meta charset="utf-8">
	</head>
	<body>
			<h1 align=center>Danh sách danh mục trong hệ thống</h1>
			<center><font color=red><%=Session("categories_error")%></center>
			<br>
			<center><a href="?action=add">Thêm mới một danh mục</a></center>
			<table border=1 width=100% align=center>
				<tr>
					<th>Mã danh mục</th>
					<th>Tên danh mục</th>
					<th>Mô tả</th>
					<th>Ảnh</th>
					<th>Sắp xếp</th>
					<th>Trạng thái</th>
					<th>Sửa</th>
					<th>Xóa</th>
				</tr>
				<%
				if (rs.eof) then
					response.write("<tr><td colspan=8>Tập dữ liệu rỗng!</td></tr>")
				else
					while not rs.eof 
					if ((action="edit") and (rs("cid")=cint(cid))) then
					%>
						<form method=POST action="categories_view_all.asp?action=save_edit&cid=<%=cid%>">
							<tr valign=top>
								<td><%=rs("cid")%></td>
								<td><input type=text name=txtCname value="<%=rs("cname")%>"></td>
								<td><textarea name=taCdesc cols=25 rows=5><%=rs("cdesc")%></textarea></td>
								<td><input type=text name=txtCimage value="<%=rs("cimage")%>"></td>
                                <td><input type=text name=txtCorder value="<%=rs("corder")%>"></td>
								<td>
									<input type=radio
										<% if (rs("cstatus")=1) then 
											response.write(" checked ")
											end if 
										%>
									name=rdCstatus value=1>Hoạt động
										<br>
										<input type=radio
										<% if (rs("cstatus")=0) then 
											response.write(" checked")
											end if 
										%>
										name=rdCstatus value=0>Ngừng Hoạt động
									
								</td>
								<td><input type=submit value="Cập nhật"></td>
								<td><input type=button onclick="window.location='categories_view_all.asp';" value="Hủy bỏ"></td>
							</tr>	
						</form>
					<%
					else 
				%>
					<tr>
						<td><%=rs("cid")%></td>
						<td><%=rs("cname")%></td>
						<td><%=rs("cdesc")%></td>
						<td><img src="images/<%=rs("cimage")%>" width=200></td>
						<td><%=rs("corder")%></td>
						<td><%
								if (rs("cstatus")=1) then
									response.write("Hoạt động")
								else 
									response.write("Ngừng hoạt động")
								end if 
						%></td>
						<td><a href="categories_view_all.asp?action=edit&cid=<%=rs("cid")%>">Sửa</a></td>
						<td><a onclick="return confirm('Bạn có chắc muốn xoá <%=rs("cname")%> hay ko?');"  href="categories_view_all.asp?action=delete&cid=<%=rs("cid")%>">Xóa</a></td>
					</tr>
				<%
					end if 
					rs.movenext
					wend
					rs.close
					'conn.close 
				%>
				<%
					end if
					%>
			</table>
			<center><a href="?action=add">Thêm mới nhóm sản phẩm</a></center>			
			<%
				if (Request("action")="add") then 
				rs.open "select * from 0203466_categories_1682", conn 
			%>
			<h1 align=center>Thêm mới một sản phẩm</h1>
			<center>
                <font color=red>
                    <%=Session("categories_add_error")%>
                </font>
		    </center>
		<form action="categories_view_all.asp" method=POST>
			<table border=0 cellspacing=5 cellpadding=5 align=center>
				<tr>
					<td>Tên nhóm:</td>
					<td><input type=text name=txtCname></td>
				</tr>
				<tr>
					<td>Mô tả:</td>
					<td><textarea cols=20 rows=6 name=taCdesc></textarea></td>
				</tr>
				<tr>
					<td>Ảnh:</td>
					<td><input type=text name=txtCimage></td>
				</tr>
				<tr>
					<td>Thứ tự sắp xếp:</td>
					<td><input type=text name=txtCorder></td>
				</tr>
				<tr>
					<td>Trạng thái:</td>
					<td>
						<input type=radio name=rdCstatus value=1 checked>Hoạt động
						<Input type=radio name=rdCstatus value=0>Ngừng hoạt động
					</td>
				</tr>
				<tr>
					<td align=right><input type=submit value="Gửi đi">
					</td>
					<td><input type=reset value="Hủy bỏ"></td>
				</tr>
			</table>
		</form>
			
			<%
				end if 
				conn.close
				Session("categories_error") =""
			%>
	</body>
</html>
