<%@page import="com.byzx.bookstore.vo.User"%>
<%@page import="com.byzx.bookstore.vo.BookShopcart"%>
<%@page import="java.util.List"%>
<%@page import="com.byzx.bookstore.service.BookService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>购物车</title>
		<style>
			h1{text-align: center;}
			#user{padding: 10px 30px; font-size: 20px;}
			table{margin: 20px auto;text-align: center; font-size:20px;}
			td{width: 160px; height: 40px;}
			.num{width: 35px; text-align: center;}
		</style>
	</head>
	<body bgcolor="lightgreen">
		<%
			Object obj = session.getAttribute("UNAME");
			if(null == obj){
				response.sendRedirect("login.jsp");
				return;
			}
		%>
		<h1>购物车</h1>
		<div id="user">当前用户: <%=obj %></div>
		<hr size="5" color="green" />
		<table border="1">
			<tr>
				<td>
					<input type="checkbox" id="qx"  />
					编号
				</td>
				<td>书名</td>
				<td>价格</td>
				<td>数量</td>
				<td>小计</td>
				<td>操作</td>
			</tr>
			<%
				BookService bs = new BookService();
				String uname = String.valueOf(obj);
				User user = bs.findUserByName(uname);
				int uid = user.getUid();
				List<BookShopcart> bscs = bs.findBookShopcart(uid);
				double sum = 0;
				for(BookShopcart bsc: bscs){
					sum += bsc.getPrice()*bsc.getNum();
			%>
				<tr>
					<td>
						<input type="checkbox" class="book" value="<%=bsc.getPrice()*bsc.getNum() %>" />
						<%=bsc.getBid() %>
					</td>
					<td><%=bsc.getBname() %></td>
					<td><%=bsc.getPrice() %></td>
					<td>
						<button onclick="minus(this,<%=bsc.getBid() %>);">-</button>
						<input type="number" class="num" value="<%=bsc.getNum() %>" min="1" onchange="changeNum(this,<%=bsc.getBid() %>)" onkeyup="changeNum(this,<%=bsc.getBid() %>)" />
						<button onclick="add(this,<%=bsc.getBid() %>)">+</button>
					</td>
					<td><%=bsc.getPrice()*bsc.getNum() %></td>
					<td>
						<a href="#">移除购物车</a>
					</td>
				</tr>
			<%		
				}
			%>
			<tr>
				<td colspan="6">
					总计: <span id="total">0.00</span>元
					<button>生成订单</button>
				</td>
			</tr>
		</table>
		<a href="index.jsp">继续购物</a>
		<script>
			// 获取全选框
			var qx = document.getElementById("qx");
			// 获取所有的书的复选框
			var books = document.getElementsByClassName("book");
			// 获取总价对应的标签
			var total = document.getElementById("total");
			// 获取所有的数字框
			var numbers = document.getElementsByClassName("num");
			// 给全选框添加点击事件
			qx.onclick = function(){
				for(var i=0;i<books.length;i++){
					books[i].checked = this.checked;
				}
				// 对总计进行操作
				if(this.checked){
					total.innerHTML = <%=sum %>;
				}else{
					total.innerHTML = "0.00";
				}
			}
			// 给所有书的复选框添加点击事件
			for(var i=0;i<books.length;i++){
				var book = books[i];
				book.onclick = function(){
					// 获取小计
					var subtotal_txt = this.value;
					var subtotal = Number(subtotal_txt);
					// 获取总价
					var total_price_txt = total.innerHTML.trim();
					var total_price = Number(total_price_txt);
					if(this.checked){ // 选中的话将小计加到总价中
						total_price += subtotal;
					}else{ // 取消勾选时将小计从总价中减掉
						total_price -= subtotal;
						// 取消勾选时，如果全选框勾选了，则取消全选框的勾选
						if(qx.checked){
							qx.checked = false;
						}
					}
					total.innerHTML = total_price;
				}
			}
			
			// 给所有的数字框添加事件
			for(var i=0;i<numbers.length;i++){
				var number_input = numbers[i];
				// 给所有数字框添加onkeydown事件
				number_input.onkeydown = function(ev){
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
				// 给所有的数字框添加onblur事件
				number_input.onblur = function(){
					if(this.value == "" || this.value == "0"){
						this.value = 1;
					}
				}
			}
			
			// 点击减号的处理方法
			function minus(btn,bid){
				// btn 所点击的减号按钮
				// 所点击的减号按钮对应的数字框
				var num_input = btn.nextElementSibling;
				var num_txt = num_input.value.trim(); // "5"
				var num = parseInt(num_txt); // 5
				if(num>1){
					num--;
				}
				// 修改前端页面的数量
				num_input.value = num;
				// 请求后台servlet，修改表中的数量
				location.href = "updateshopcart1?bid=" + bid + "&num=" + num;
			}
			
			// 点击加号的处理方法
			function add(btn,bid){
				// btn 所点击的加号按钮
				// 所点击的加号按钮对应的数字框
				var num_input = btn.previousElementSibling;
				var num_txt = num_input.value.trim(); // "5"
				var num = parseInt(num_txt); // 5
				num++;
				// 修改前端页面的数量
				num_input.value = num;
				// 请求后台servlet，修改表中的数量
				location.href = "updateshopcart1?bid=" + bid + "&num=" + num;
			}
			
			// 数字框值改变的处理
			function changeNum(num_input,bid){
				// 所点击的加号按钮对应的数字框
				var num_txt = num_input.value.trim(); // "5"
				var num = parseInt(num_txt); // 5
				// 请求后台servlet，修改表中的数量
				location.href = "updateshopcart1?bid=" + bid + "&num=" + num;
			}
		</script>
	</body>
</html>








































