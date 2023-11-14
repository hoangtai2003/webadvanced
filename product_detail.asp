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
	<style>
		.commnet-section {
			width: 100%;
			display: flex;
			align-items: center;
			justify-content: center;
		}

		.container {
			display: flex;
			flex-direction: column;
			width: 800px;
			border-radius: 4px;
			padding: 12px;
		}
		.comments {
			display: flex;
			flex-direction: column;
			width: 800px;
			gap: 24px;
		}
		.comment {
			display: flex;
			flex-direction: column;
			gap: 8px;
			border-bottom: 1px solid #979797
		}
		.commnet-content {
			width: 100%;
		}

		input {
			width: 100%;
		}

		.user-info {
			display: flex;
			gap: 30px;
			align-items: center;
		}
		.commnet-username {
			font-size: 18px;
			color: gray
		}
		.date {
			color: gray;
			font-size: 14px
		}
		.commnet-content {
			font-size: 18px;
			font-weight: 600
		}
		.commnet-email {
			color: gray;
			font-size: 14px
		}
		.commnet-header {
			display: flex;
			justify-content: space-between;
		}
		.reaction {
			display: flex;
			gap: 12px
		}
		.like {
			border-radius: 4px;
			border: 1px solid #DCDCDC;
			background-color: #EDEDED;
			padding: 0px 8px;
			cursor: pointer;
		}
		.dislike {
			border-radius: 4px;
			border: 1px solid #DCDCDC;
			background-color: #EDEDED;
			padding: 0px 8px;
			cursor: pointer;
		}
		</style>
	<body>
		<h1 align=center>Thêm mới một sản phẩm</h1>
		<center><font color=red><%=Session("product_edit_error")%></font></center>

			<table border=0 align=center width=400>
				<tr>
					<td>Tên sản phẩm:</td>
					<td><label><%=rs("pname")%></label></td>
				</tr>
				<tr>
					<td>Mô tả:</td>
					<td><label><%=rs("pdesc")%></label></td>
				</tr>
				<tr>
					<td>Ảnh:</td>
					<td><label><%=rs("pimage")%></label></td>
				</tr>
				<tr>
					<td>Giá:</td>
					<td><label><%=rs("pprice")%></label></td>
				</tr>
				<tr>
					<td>Số lượng:</td>
					<td><label><%=rs("pquantity")%></labe></td>
				</tr>
				<tr>
					<td>Danh mục:</td>
					<td>
                        <% while not rs1.eof 
                                if rs("cid")=rs1("cid") then	
                                %>
                                    <label><%=rs1("cname")%></label>
                                <%
                                end if 
                            rs1.movenext
                            wend
                            rs1.close
                        %>
					</td>
				</tr>
				<tr>
					<td>Nhà Cung cấp:</td>
					<td>
                        <% while not rs2.eof 
                                if rs("sid")=rs2("sid") then	
                                %>
                                    <label><%=rs2("sname")%></label>
                                <%
                                end if 
                            rs2.movenext
                            wend
                            rs2.close
                        %>
					</td>
				</tr>
				<tr>
					<td>Size:</td>
					<td>
                        <% while not rs3.eof 
                                if rs("sizeid")=rs3("sizeid") then	
                                %>
                                    <label><%=rs3("sizename")%></label>
                                <%
                                end if 
                            rs3.movenext
                            wend
                            rs3.close
                        %>
					</td>
				</tr>
                <tr>
                    <td>số lượt xem </td>
                    <td>
                        <label><%=rs("pview")%></label>
                    </td>
                </tr>
				<tr>
					<td><button><a href="product_view.asp">Quay lại</a></button></td>
				</tr>
			</table>
			</br>
		<h1 align=center>Danh sách comment</h1>
		<center><font color=red><%=Session("product_comment")%></font></center>

		<div class="commnet-section">
			<div class="container">
				<div class="comments">
					<%
					rs4.open "select * from comment",conn
					while not rs4.eof 
					%> 
							
					<div class="comment">
						<div class="commnet-header">
							<div class="date"><%=rs4("codate")%></div>
							<div class="reaction">
								<div class="like">like</div>
								<div class="dislike">dislike</div>
							</div>
						</div>
						<div class="commnet-info">
							<div class="commnet-content"><%=rs4("coContent")%></div>
								<div class="user-info">
									<div class="commnet-username"><%=rs4("username")%></div>
									<div class="commnet-email"><%=rs4("email")%></div>
								</div>
							</div>
					</div>
					<%
						rs4.movenext
						wend
						rs4.close			
					%>
				</div>
			</div>
		</div>
		<h1 align=center>Thêm mới comment</h1>
		<center><font color=red><%=Session("comment_add_error")%></font></center>
		<form method=POST action="comment_action.asp">
			<table border=0 align=center width=400>
				<tr>
					<td>Username:</td>
					<td><input style="width:180px" type=text name=username required></td>
				</tr>
				
				<tr>
					<td>Email:</td>
					<td><input type=Email  style="width:180px" name=email required></td>
				</tr>
				<tr>
					<td>Nội dung:</td>
					<td><textarea cols=20 style="width:180px" rows=6 name=tacontent required></textarea></td>
				</tr>


				<tr>
					<td align=right><input type=submit value="Thêm mới"></td>
					<td><input type=reset value="Làm lại">
						<input type=hidden name="pid" value=<%=pid%>>
				</tr>

			</table>
	</body>
</html>
<%
	end if 
	Session("product_edit_error")=""
	conn.close
%>