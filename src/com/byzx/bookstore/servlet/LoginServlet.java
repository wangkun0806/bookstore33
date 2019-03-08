package com.byzx.bookstore.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.byzx.bookstore.service.BookService;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("*********LoginServlet********");
		// 设置编码
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		// 获取out对象
		PrintWriter out = response.getWriter();
		// 获取session对象
		HttpSession session = request.getSession();
		
		// 获取login.jsp页面的参数
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String identity = request.getParameter("identity");
		String rem = request.getParameter("rem");
		System.out.println("用户名:" + username);
		
		// 调用service方法，根据用户的正确性做相应跳转
		// jsp或servlet中只能直接调用service层的方法
		BookService bs = new BookService();
		if(bs.isRightUser(username, password)) {
			// 1. 将用户名存到session中
			session.setAttribute("UNAME", username);
			// 2. 记住密码的处理
			Cookie ckName = null;
			Cookie ckPass = null;
			if(null != rem) { // 记住密码
				ckName = new Cookie("UNAME",URLEncoder.encode(username, "UTF-8"));
				ckPass = new Cookie("UPASS",password);
			}else {
				ckName = new Cookie("UNAME","");
				ckPass = new Cookie("UPASS","");
			}
			// 设置存活时间
			ckName.setMaxAge(60*60*24*30);
			ckPass.setMaxAge(60*60*24*30);
			// 将Cookie写到客户端硬盘
			response.addCookie(ckName);
			response.addCookie(ckPass);
			// 3. 跳转
			// 用户选择管理员并且该账号是管理员账号，跳向admin.jsp
			// 其它情况跳向index.jsp
			if(identity.equals("1") && bs.isAdmin(username)) {
				out.println("<script>alert('管理员登录成功!!!');location.href='admin.jsp';</script>");
			}else {
				String page = "index.jsp";
				Object obj = session.getAttribute("page");
				if(null == obj) {
					page = "index.jsp";
				}else {
					page = String.valueOf(obj);
				}
				out.println("<script>alert('会员登录成功');location.href='" + page + "';</script>");
			}
		}else {
			out.println("<script>alert('登录失败');location.href='login.jsp';</script>");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
