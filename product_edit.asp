<!--#include file="connection.asp"-->
<%
	pid = Request.QueryString("pid")
	sql = "select * from 0203466_product_1682 where pid=" & pid
	rs.open sql, conn
	if (rs.eof) then 
		Session("product_error") = "Dữ liệu không tồn tại!"
		Response.Redirect("product_view.asp")
	else  
	rs1.open "select * from 0203466_categories_1682", conn 
	rs2.open "select * from 0203466_supplier_1682", conn 
	rs3.open "select * from 0203466_size_1682", conn 
%>

<html>
	<head>
		<meta charset="utf-8">
		<title>Tiêu đề trang web</title>
	</head>
	<body>
		<h1 align=center>Thêm mới một sản phẩm</h1>
		<center><font color=red><%=Session("product_edit_error")%></font></center>
		<form method=POST action="product_edit_action.asp?pid=<%=pid%>">
			<table border=0 align=center width=400>
				<tr>
					<td>Tên sản phẩm:</td>
					<td><input style="width:180px" type=text name=txtPname value="<%=rs("pname")%>"></td>
				</tr>
				<tr>
					<td>Mô tả:</td>
					<td><textarea cols=20 style="width:180px" rows=6 name=taPdesc><%=rs("pdesc")%></textarea></td>
				</tr>
				<tr>
					<td>Ảnh:</td>
					<td><input type=text  style="width:180px" name=txtPimage  value="<%=rs("pimage")%>"></td>
				</tr>
				<tr>
					<td>Giá:</td>
					<td><input type=text style="width:180px" name=txtPprice  value="<%=rs("pprice")%>"></td>
				</tr>
				<tr>
					<td>Số lượng:</td>
					<td><input type=text style="width:180px" name=txtPquantity value="<%=rs("pquantity")%>"></td>
				</tr>
				<tr>
					<td>Danh mục:</td>
					<td>
						<select name=slCid>
							<% while not rs1.eof 
							%>
								<option value="<%=rs1("cid")%>"
								<% if rs("cid")=rs1("cid") then	
									response.write(" selected ")
									end if 
								%>
								><%=rs1("cname")%></option>
							<%
								rs1.movenext
								wend
								rs1.close
								
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>Nhà Cung cấp:</td>
					<td>
						<select name=slSid>
							<% while not rs2.eof 
							%>
								<option value="<%=rs2("sid")%>"
								<% if rs("sid")=rs2("sid") then	
									response.write(" selected ")
									end if 
								%>
								><%=rs2("sname")%></option>
							<%
								rs2.movenext
								wend
								rs2.close	
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>Size:</td>
					<td>
						<select name=slSizeid>
							<% while not rs3.eof 
							%>
								<option value="<%=rs3("sizeid")%>"
								<% if rs("sizeid")=rs3("sizeid") then	
									response.write(" selected ")
									end if 
								%>
								><%=rs3("sizename")%></option>
							<%
								rs3.movenext
								wend
								rs3.close
								
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>Trạng thái:</td>
					<td><input type=radio
						<% if (rs("pstatus")=1) then 
							response.write(" checked ")
							end if 
						%>
					name=rdPstatus value=1>Hoạt động
						<input type=radio
						<% if (rs("pstatus")=0) then 
							response.write(" checked ")
							end if 
						%>
						name=rdPstatus value=0>Ngừng Hoạt động
					</td>
				</tr>
				<tr>
					<td align=right><input type=submit value="Cập nhật"></td>
					<td><input type=reset value="Làm lại">
				</tr>
			</table>
		</form>
	</body>
</html>
<%
	end if 
	Session("product_edit_error")=""
	conn.close
%>