package com.byzx.bookstore.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.byzx.bookstore.service.BookService;
import com.byzx.bookstore.vo.User;

/**
 * Servlet implementation class UpdateShopcart
 */
public class UpdateShopcart1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateShopcart1() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("*********UpdateShopcart1*********");
		// 获取uid
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("UNAME");
		if(null == obj) {
			response.sendRedirect("login.jsp");
			return;
		}
		String uname = String.valueOf(obj);
		BookService bs = new BookService();
		User user = bs.findUserByName(uname);
		int uid = user.getUid();
		// bid,num
		String bidstr = request.getParameter("bid");
		String numstr = request.getParameter("num");
		int bid = 0;
		int num = 0;
		if(null != bidstr && null != numstr) {
			bid = Integer.parseInt(bidstr);
			num = Integer.parseInt(numstr);
		}
		// 修改shopcart表
		bs.updateShopcart1(uid, bid, num);
		//request.getRequestDispatcher("shopcart.jsp").forward(request, response);
		response.sendRedirect("shopcart.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
