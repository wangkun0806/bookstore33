<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>登录页面</title>
		<style>
			h1{text-align: center;}
			table{margin: 30px auto; font-size:20px;text-align: center;}
			td{width: 240px; height: 50px;}
			.wh{width: 200px; height: 25px; font-size: 20px;}
			.rc{width: 18px; height: 18px;}
			.size{font-size:20px;}
		</style>
	</head>
	<body bgcolor="lightgreen">
		<h1>欢迎访问博览群书</h1>
		<hr size="5" color="green" />
		<%
			String uname = "";
			String upass = "";
			// 在硬盘中获取Cookie，将Cookie信息写到用户名和密码框中
			Cookie[] cks = request.getCookies();
			if(null != cks){
				for(Cookie ck: cks){
					if(ck.getName().equals("UNAME")){
						uname = ck.getValue();
						// 对用户名进行解码
						uname = URLDecoder.decode(uname,"UTF-8");
					}
					if(ck.getName().equals("UPASS")){
						upass = ck.getValue();
					}
				}
			}
		%>
		<form action="login" method="post" onsubmit="return checkuser();">
			<table border="1">
				<tr>
					<td>用户名</td>
					<td>
						<input type="text" class="wh" name="username" placeholder="请输入用户名" value="<%=uname %>" />
					</td>
				</tr>
				<tr>
					<td>密码</td>
					<td>
						<input type="password" class="wh" name="password" placeholder="请输入密码" value="<%=upass %>" />
					</td>
				</tr>
				<tr>
					<td>身份</td>
					<td>
						<input type="radio" class="rc" name="identity" value="0" checked /> 会员
						<input type="radio" class="rc" name="identity" value="1" /> 管理员
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="checkbox" class="rc" name="rem" /> 记住密码<br/>
						<input type="submit" class="size" value="登录" />
						<input type="reset" class="size" value="取消" />
						<a href="register.jsp">用户注册</a>
					</td>
				</tr>
			</table>
		</form>
		<script>
			// 获取用户名和密码框
			var user_input = document.getElementsByName("username")[0];
			var pass_input = document.getElementsByName("password")[0];
			// 获取记住密码框
			var rem = document.getElementsByName("rem")[0];
			// 如果之前在Cookie中存了账号密码信息，记住密码应该自动勾选
			var user_txt = "<%=uname %>";
			var pass_txt = "<%=upass %>";
			if(user_txt != "" && pass_txt != ""){
				rem.checked = true;
			}
			
			function checkuser(){
				// 获取用户名和密码的文本内容
				var username = user_input.value;
				var password = pass_input.value;
				//console.log("用户名:" + username + ",密码:" + password);
				// 用户名 3-16
				if(username.length<3 || username.length>16){
					alert("用户名不符合要求");
					return false;
				}
				// 密码 5-20
				if(password.length<5 || password.length>20){
					alert("密码长度不符合要求，应为5-20位");
					return false;
				}
				// 密码必须同时包含字母和数字
				var letterCount = 0;
				var numberCount = 0;
				for(var i=0;i<password.length;i++){
					var ch = password.charAt(i);
					if(ch>='0' && ch<='9'){ // 数字
						numberCount++;
					}
					if(ch>='a' && ch<='z' || ch>='A' && ch<='Z'){ // 字母
						letterCount++;
					}
				}
				if(numberCount == 0 || letterCount == 0){
					alert("密码必须同时包含字母和数字");
					return false;
				}
				return true;
			}
		</script>
	</body>
</html>







