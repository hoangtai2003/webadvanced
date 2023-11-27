<!--#include file="connection.asp"-->
<% 
    rs.open "select * from 0203466_categories_1682", conn
%>
<html>
	<head>
		<meta charset="utf-8">
		<title>Tiêu đề trang web</title>
	</head>
	<body>
		<h1 align=center>Thêm mới quảng cáo</h1>
		<center>
			<font color=red>
				<%=Session("quangcao_add_error")%>
			</font>
		</center>
		<form action="quangcao_add_action.asp" method=POST>
			<table border=0 cellspacing=5 cellpadding=5 align=center>
				<tr>
					<td>Tên Quảng Cáo:</td>
					<td><input type=text name=ten></td>
				</tr>
				<tr>
					<td>Từ Ngày:</td>
					<td><input type=date  name=tungay></td>
				</tr>
                <tr>
					<td>Đến Ngày:</td>
					<td><input type=date  name=denngay></td>
				</tr>
				<tr>
					<td>Ảnh:</td>
					<td><input type=text name=anh></td>
				</tr>
				<tr>
					<td>Link:</td>
					<td><input type=text name=link></td>
				</tr>
				<tr>
					<td>Danh mục sản phẩm:</td>
                    <td>
                        <select name = slCid>
                            <%
                                while not rs.eof

                            %>
                                <option value="<%=rs("cid")%>"><%=rs("cname")%></option>
                            <%
                                rs.movenext
                                wend
                                rs.close
                                conn.close
                            %>
                        </select>
                    </td>
				</tr>
				<tr>
					<td align=right><input type=submit value="Gửi đi">
					</td>
					<td><input type=reset value="Hủy bỏ"></td>
				</tr>
			</table>
		</form>
	</body>
</html>