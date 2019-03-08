<%@page import="com.byzx.bookstore.vo.Book"%>
<%@page import="java.util.List"%>
<%@page import="com.byzx.bookstore.service.BookService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>管理员页面</title>
		<style>
			h1{text-align: center;}
			#username{padding: 5px 20px; font-size: 20px;}
			table{margin: 20px auto; font-size: 20px; text-align: center;}
			td{width: 150px; height: 40px;}
		</style>
	</head>
	<body bgcolor="lightgreen">
		<h1>博览群书</h1>
		<div id="username">
			你好，<%=session.getAttribute("UNAME") %>
			<a href="index.jsp?flag=exit">退出</a>
		</div>
		<hr size="5" color="green" />
		<%
			// 分页查询
			// 每页显示条数
			int pageSize = 4;
			// 总条数
			int count = 0;
			// 当前是第几页
			int pageNum = 1;
			// 总共有多少页
			int pageCount = 0;
			
			// count
			BookService bs = new BookService();
			List<Book> books = bs.findAllBook();
			count = books.size();
			
			// pageNum
			String pn = request.getParameter("pageNum");
			if(null == pn){
				pageNum = 1;
			}else{
				pageNum = Integer.parseInt(pn);
			}
			// pageCount
			pageCount = count%pageSize==0?count/pageSize:count/pageSize+1;
		%>
		<table border="1">
			<tr>
				<td colspan="7">
					每页显示<%=pageSize %>条，共<%=count %>条，
					当前是第<%=pageNum %>页，共<%=pageCount %>页。
				</td>
			</tr>
			<tr>
				<td>编号</td>
				<td>书名</td>
				<td>价格</td>
				<td>作者</td>
				<td>类型</td>
				<td>出版社</td>
				<td>操作</td>
			</tr>
			<%
				// 计算遍历的区间
				int start = (pageNum-1)*pageSize;
				int end = pageNum==pageCount?count-1:pageNum*pageSize-1;
				for(int i=start;i<=end;i++){
					// 获取某一本书
					Book book = books.get(i);
			%>
				<tr>
					<td><%=book.getBid() %></td>
					<td><%=book.getBname() %></td>
					<td><%=book.getPrice() %></td>
					<td><%=book.getAuthor() %></td>
					<td><%=book.getType() %></td>
					<td><%=book.getPublisher() %></td>
					<td>
						<a href="#">修改</a>
						<a href="#">删除</a>
					</td>
				</tr>
			<%		
				}
			%>
			<tr>
				<td colspan="7">
					<%
						// 第一页  首页和上一页不可点击
						if(pageNum==1){
					%>
							首页 上一页
					<%		
						}else{
					%>
							<a href="admin.jsp?pageNum=1">首页</a>
							<a href="admin.jsp?pageNum=<%=pageNum-1 %>">上一页</a>
					<%		
						}
						// 最后一页 下一页和末页不可点击
						if(pageNum==pageCount){
					%>
							下一页 末页
					<%		
						}else{
					%>
							<a href="admin.jsp?pageNum=<%=pageNum+1 %>">下一页</a>
							<a href="admin.jsp?pageNum=<%=pageCount %>">末页</a>
					<%		
						}
					%>
				</td>
			</tr>
		</table>
	</body>
</html>

















