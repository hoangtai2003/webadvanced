<!--#include file="connection.asp"-->
<%
    pid = Request.QueryString("pid")
    sql = "select pview from 0203466_product_1682 where pid = " &pid
    rs.open sql, conn
    sql2 =  "update 0203466_product_1682 set pview = " & rs("pview") & " + 1 where pid = " & pid 
    conn.execute sql2
    rs.close
    conn.close
    Response.Redirect("product_detail.asp?pid=" & pid)
%>