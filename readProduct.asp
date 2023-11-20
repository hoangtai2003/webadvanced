<!--#include file="connection.asp"-->
<%
	keyword = Request.QueryString("keyword")
	sql = "select * from 0203466_Product_1682 where pname like '%"& keyword &"%'"
	rs.open sql, conn
%>
<html>
	<head>
		<meta charset="utf-8">
	</head>
	<body>
			<ul id="country-list">
				<% while not rs.eof
				%>
				<li onClick="selectCountry('<%=rs("pname")%>')">
					<%=rs("pname")%>
				</li>
				<% rs.movenext
                wend
                rs.close
				conn.close
				%>
			</ul>
	</body>
</html>