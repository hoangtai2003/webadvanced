<!--#include file="connection.asp"-->
<%
	action =Request("action")
	pid = Request("pid")
	select case action
	case "add_new"
		pname=Request.Form("txtPname")
		pdesc=Request.Form("taPdesc")
		pimage=Request.Form("txtPimage")
		cid=Request.Form("slCid")
		pprice = Request.Form("txtPprice")
		pquantity = Request.Form("txtPquantity")
		pstatus=Request.Form("rdPstatus")
		mathuonghieu = Request.Form("mathuonghieu")
		manhacc = Request.Form("manhacc")
		'Kiểm tra nếu tên sản phẩm có rồi thì báo lỗi
		sql="select * From 0203466_product_1682 where pname='" & pname &"'"
		rs.open sql, conn 
		if (not rs.eof) then
			Session("product_error")="Tên sản phẩm: " & pname &" đã có rồi!"	
		else 
			sql = "insert into 0203466_product_1682(pname,pdesc,pimage,cid,pstatus,pprice,pquantity,mathuonghieu, manhacc ) values ('" & pname & "','" & pdesc & "','" & pimage & "'," & cid & "," & pstatus & "," &pprice & "," & pquantity & ", "& mathuonghieu &", "& manhacc &")"
			'Response.write(sql)
			conn.execute sql 
			Session("product_error")="Thêm mới thành công"
		end if
		rs.close 
	case "save_edit"
		pname=Request.Form("txtPname")
		pdesc=Request.Form("taPdesc")
		pimage=Request.Form("txtPimage")
		cid=Request.Form("slCid")
		pstatus=Request.Form("rdPstatus")
		mathuonghieu = Request.Form("mathuonghieu")
		manhacc = Request.Form("manhacc")
		'Kiểm tra nếu tên danh mục có rồi thì báo lỗi
		sql="select * From 0203466_product_1682 where pname='" & pname &"' and pid<>" & pid 
		rs.open sql, conn 
		if (not rs.eof) then
			Session("product_error")="Tên sản phẩm: " & pname &" đã có rồi!"
				
		else 
			sql = "update 0203466_product_1682 set pname='" & pname & "',pdesc='" & pdesc & "',pimage ='" & pimage & "', cid = " & cid & ",pstatus = " & pstatus & ", mathuonghieu = "& mathuonghieu &", manhacc = "& manhacc &" where pid = " & pid 
			'Response.write(sql)
			conn.execute sql 
			Session("product_error")="Cập nhật thành công"
		end if
		rs.close 
	case "delete"
		sql = "delete from 0203466_product_1682 where pid=" & pid 
        conn.execute sql 
        session("product_error")="Xóa thành công!"
	end select 
	sql = "select [0203466_product_1682].*,[0203466_categories_1682].cname, Thuonghieu.tenthuonghieu, Nhacungcap.tennhacc from 0203466_product_1682, 0203466_categories_1682, Thuonghieu, Nhacungcap where [0203466_product_1682].cid = [0203466_categories_1682].cid and [0203466_product_1682].mathuonghieu = Thuonghieu.mathuonghieu and [0203466_product_1682].manhacc = Nhacungcap.manhacc "
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
			<center><a href="?action=add">Thêm mới một sản phẩm</a></center>
			<table border=1 width=100% align=center>
				<tr>
					<th>Mã sản phẩm</th>
					<th>Tên sản phẩm </th>
					<th>Mô tả</th>
					<th>Ảnh</th>
					<th>Nhóm sản phẩm</th>
					<th>Tên thương hiệu</th>
					<th>Tên nhà cung cấp</th>
					<th>Trạng thái</th>
					<th>Sửa</th>
					<th>Xóa</th>
				</tr>
				<%
				if (rs.eof) then
					response.write("<tr><td colspan=10>Tập dữ liệu rỗng!</td></tr>")
				else
					while not rs.eof 
					if ((action="edit") and (rs("pid")=cint(pid))) then
					%>
						<form method=POST action="product_view_all.asp?action=save_edit&pid=<%=pid%>">
							<tr valign=top>
								<td><%=rs("pid")%></td>
								<td><input type=text name=txtPname value="<%=rs("pname")%>"></td>
								<td><textarea name=taPdesc cols=25 rows=5><%=rs("pdesc")%></textarea></td>
								<td><input type=text name=txtPimage value="<%=rs("pimage")%>"></td>
								<td>
									<select name=slCid>
										<% 
											rs2.open "select * from 0203466_categories_1682", conn 
										while not rs2.eof 
										%>
											<option value="<%=rs2("cid")%>"
											<% if rs2("cid")=rs("cid") then	
												response.write(" selected ")
												end if 
											%>
											><%=rs2("cname")%></option>
										<%
											rs2.movenext
											wend
											rs2.close
											
										%>
									</select>
								</td>
								<td>
									<select name=mathuonghieu>
										<% 
											rs3.open "select * from Thuonghieu", conn 
										while not rs3.eof 
										%>
											<option value="<%=rs3("mathuonghieu")%>"
											<% if rs3("mathuonghieu")=rs("mathuonghieu") then	
												response.write(" selected ")
												end if 
											%>
											><%=rs3("tenthuonghieu")%></option>
										<%
											rs3.movenext
											wend
											rs3.close
											
										%>
									</select>
								</td>
								<td>
									<select name=manhacc>
										<% 
											rs4.open "select * from Nhacungcap", conn 
										while not rs4.eof 
										%>
											<option value="<%=rs4("manhacc")%>"
											<% if rs4("manhacc")=rs("manhacc") then	
												response.write(" selected ")
												end if 
											%>
											><%=rs4("tennhacc")%></option>
										<%
											rs4.movenext
											wend
											rs4.close
											
										%>
									</select>
								</td>
								<td>
									<input type=radio
										<% if (rs("pstatus")=1) then 
											response.write(" checked ")
											end if 
										%>
									name=rdPstatus value=1>Hoạt động
										<br>
										<input type=radio
										<% if (rs("pstatus")=0) then 
											response.write(" checked")
											end if 
										%>
										name=rdPstatus value=0>Ngừng Hoạt động
									
								</td>
								<td><input type=submit value="Cập nhật"></td>
								<td><input type=button onclick="window.location='product_view_all.asp';" value="Hủy bỏ"></td>
							</tr>	
						</form>
					<%
					else 
				%>
					<tr>
						<td><%=rs("pid")%></td>
						<td><%=rs("pname")%></td>
						<td><%=rs("pdesc")%></td>
						<td><img src="images/<%=rs("pimage")%>" width=200></td>
						<td><%=rs("cname")%></td>
						<td><%=rs("tenthuonghieu")%></td>
						<td><%=rs("tennhacc")%></td>
						<td><a href="product_view_all.asp?action=edit&pid=<%=rs("pid")%>">Sửa</a></td>
						<td><a onclick="return confirm('Bạn có chắc muốn xoá <%=rs("pname")%> hay ko?');"  href="product_view_all.asp?action=delete&pid=<%=rs("pid")%>">Xóa</a></td>
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
			<center><a href="?action=add">Thêm mới một sản phẩm</a></center>			
			<%
				if (Request("action")="add") then 
				rs.open "select * from 0203466_categories_1682", conn 
				sql1 = "select * from Thuonghieu"
				rs1.open sql1, conn
				sql2 = "select * from Nhacungcap"
				rs2.open sql2, conn
			%>
			<h1 align=center>Thêm mới một sản phẩm</h1>
		<center><font color=red><%=Session("product_add_error")%></font></center>
		<form method=POST action="product_view_all.asp">
			<table border=0 align=center width=400>
				<tr>
					<td>Tên sản phẩm:</td>
					<td><input style="width:180px" type=text name=txtPname></td>
				</tr>
				<tr>
					<td>Mô tả:</td>
					<td><textarea cols=20 style="width:180px" rows=6 name=taPdesc></textarea></td>
				</tr>
				<tr>
					<td>Ảnh:</td>
					<td><input type=text  style="width:180px" name=txtPimage></td>
				</tr>
				<tr>
					<td>Giá:</td>
					<td><input type=text style="width:180px" name=txtPprice></td>
				</tr>
				<tr>
					<td>Số lượng:</td>
					<td><input type=text style="width:180px" name=txtPquantity></td>
				</tr>
				<%
				 %>
				<tr>
					<td>Danh mục:</td>
					<td>
						<select name=slCid>
							<% while not rs.eof 
							%>
								<option value="<%=rs("cid")%>"><%=rs("cname")%></option>
							<%
								rs.movenext
								wend
								rs.close
								'conn.close
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>Thương hiệu:</td>
					<td>
						<select name=mathuonghieu>
							<% while not rs1.eof 
							%>
								<option value="<%=rs1("mathuonghieu")%>"><%=rs1("tenthuonghieu")%></option>
							<%
								rs1.movenext
								wend
								rs1.close
								'conn.close
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>Nhà cung cấp:</td>
					<td>
						<select name=manhacc>
							<% while not rs2.eof 
							%>
								<option value="<%=rs2("manhacc")%>"><%=rs2("tennhacc")%></option>
							<%
								rs2.movenext
								wend
								rs2.close
								'conn.close
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>Trạng thái:</td>
					<td><input type=radio checked name=rdPstatus value=1>Hoạt động
						<input type=radio name=rdPstatus value=0>Ngừng Hoạt động
					</td>
				</tr>
				<tr>
					<td align=right><input type=submit value="Thêm mới"></td>
					<td><input type=reset value="Làm lại">
						<input type=hidden name="action" value="add_new">
				</tr>
			</table>
		</form>
			
			<%
				end if 
				conn.close
				Session("product_error") =""
			%>
	</body>
</html>
