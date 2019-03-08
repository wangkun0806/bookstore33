<%@page import="com.byzx.bookstore.vo.Book"%>
<%@page import="java.util.List"%>
<%@page import="com.byzx.bookstore.service.BookService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>首页面</title>
		<style>
			h1{text-align: center;}
			#head{text-align: right; padding: 10px 50px; font-size:20px;}
			.book{width: 22%; height: 380px; float: left; margin: 20px 18px;}
			.book:hover{cursor: pointer;}
			.book img{margin-left: 13%;}
			.book div{text-align: center; margin-top: 10px; font-size: 20px;}
			hr{clear: both;}
			#foot{font-size: 20px; text-align: center;}
		</style>
	</head>
	<body bgcolor="lightgreen">
		<div id="head">
			<%
				String flag = request.getParameter("flag");
				if(null != flag){ // 点击退出
					session.removeAttribute("UNAME");
				}
				Object obj = session.getAttribute("UNAME");
				if(null == obj){ // 未登录
			%>
					请<a href="login.jsp">登录</a>或<a href="register.jsp">注册</a>
			<%	
				}else{
			%>
					你好,<%=obj %>
					<a href="index.jsp?flag=exit">退出</a>
			<%		
				}
			%>
			<a href="shopcart.jsp">购物车</a>
			<a href="orderlist.jsp">全部订单</a>
		</div>
		<h1>博览群书</h1>
		<hr size="5" color="green" />
		<%
			BookService bs = new BookService();
			List<Book> books = bs.findAllBook();
			for(Book book: books){
				
		%>
				<div class="book" onclick="location.href='detail.jsp?bid=<%=book.getBid() %>';">
					<img src="<%=book.getSrc() %>" />
					<div>
						书名: <%=book.getBname() %><br/>
						价格: ￥<%=book.getPrice() %>元
					</div>
				</div>
		<%		
			}
		%>
		<hr size="5" color="green" />
		<div id="foot">
			书店地址：西安市长安北路体育场<br/>
			电话：029-01010101<br/>
			©博览群书店<br/><br/><br/><br/><br/><br/><br/><br/>
		</div>
	</body>
</html>











