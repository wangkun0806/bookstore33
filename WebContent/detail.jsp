<%@page import="com.byzx.bookstore.vo.Book"%>
<%@page import="com.byzx.bookstore.service.BookService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>详情页面</title>
		<style>
			h1,h2{text-align: center;}
			table{margin-left: 100px;}
			td{width: 260px; height: 50px; padding-left: 30px;}
			td img{width: 100%; height: 800%; }
			#num{width: 35px; text-align: center;}
		</style>
	</head>
	<body bgcolor="lightgreen">
		<h1>图书详情</h1>
		<a href="index.jsp">返回</a>
		<hr size="5" color="green" />
		<%
			// 获取index.jsp传过来的bid
			String bidstr = request.getParameter("bid");
			if(null == bidstr){
				response.sendRedirect("index.jsp");
				return;
			}
			int bid = Integer.parseInt(bidstr);
			BookService bs = new BookService();
			Book book = bs.findBookById(bid);
			session.setAttribute("page", "detail.jsp?bid=" + bid);
		%>
		<form action="updateshopcart" method="post">
			<table>
				<tr>
					<td rowspan="8">
						<img src="<%=book.getSrc() %>" />
					</td>
					<td>
						编号: <%=book.getBid() %>
						<input type="hidden" name="bid" value="<%=book.getBid() %>" />
					</td>
				</tr>
				<tr>
					<td>书名: <%=book.getBname() %></td>
				</tr>
				<tr>
					<td>作者: <%=book.getAuthor() %></td>
				</tr>
				<tr>
					<td>类型: <%=book.getType() %></td>
				</tr>
				<tr>
					<td>价格: <%=book.getPrice() %>元</td>
				</tr>
				<tr>
					<td>出版社: <%=book.getPublisher() %></td>
				</tr>
				<tr>
					<td>
						数量: <input id="num" type="number" name="num" min="1" value="1" >本
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="加入购物车" />
					</td>
				</tr>
			</table>
		</form>
		<script>
			// 显示数字框数字字母或其它特殊字符
			var num_input = document.getElementById("num");
			// 给数字框添加onkeydown事件
			num_input.onkeydown = function(ev){
				var keyCode = ev.keyCode;
				// keyCode --> keyChar
				var keyChar = String.fromCharCode(keyCode);
				console.log("keyCode=" + keyCode + ",keyChar=" + keyChar);
				if(keyChar>='0' && keyChar<='9' || keyCode==8 || keyCode==37 || keyCode==39){
					// 只有满足上述条件的按键才会起作用
					return true;
				}
				return false;
			}
			// 给数字框添加焦点失去事件
			num_input.onblur = function(){
				if(this.value == ""  || this.value == "0"){
					this.value = 1;
				}
			}
		
		
		
		</script>
		<hr size="5" color="green" />
		<h2>内容简介</h2>
		<%=book.getDesc() %>
		<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	</body>
</html>














