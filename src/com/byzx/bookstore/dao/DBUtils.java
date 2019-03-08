package com.byzx.bookstore.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.byzx.bookstore.vo.Book;
import com.byzx.bookstore.vo.BookShopcart;
import com.byzx.bookstore.vo.User;

public class DBUtils {

	// 获取数据库连接
	public static Connection getConn() {
		try {
			Class.forName(DBInfo.JDBC_DRIVER);
			Connection conn = DriverManager.getConnection(DBInfo.JDBC_URL, DBInfo.JDBC_USERNAME, DBInfo.JDBC_PASSWORD);
			return conn;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 查询user表
	public static List<User> findUser(String sql){
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement ps = null;
		List<User> users = new ArrayList<User>();
		try {
			conn = DBUtils.getConn();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUid(rs.getInt("uid"));
				user.setUname(rs.getString("uname"));
				user.setPassword(rs.getString("password"));
				user.setSex(rs.getString("sex"));
				user.setAddress(rs.getString("address"));
				user.setIdentity(rs.getInt("Identity"));
				
				users.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBUtils.close(conn, ps, rs);
		}
		return users;
	}
	
	// 查询book表
	public static List<Book> findBook(String sql){
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement ps = null;
		List<Book> books = new ArrayList<Book>();
		try {
			conn = DBUtils.getConn();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				Book book = new Book();
				book.setBid(rs.getInt("bid"));
				book.setBname(rs.getString("bname"));
				book.setAuthor(rs.getString("author"));
				book.setType(rs.getString("type"));
				book.setPublisher(rs.getString("publisher"));
				book.setCount(rs.getInt("count"));
				book.setSrc(rs.getString("src"));
				book.setDesc(rs.getString("desc"));
				book.setPrice(rs.getDouble("price"));
				
				books.add(book);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBUtils.close(conn, ps, rs);
		}
		return books;
	}
	
	// 查询shopcart表
	public static boolean findShopcart(String sql){
		boolean isBought = false;
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBUtils.getConn();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			isBought = rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBUtils.close(conn, ps, rs);
		}
		return isBought;
	}
	
	// book,shopcart两表联查
	public static List<BookShopcart> findBookShopcart(String sql){
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement ps = null;
		List<BookShopcart> bscs = new ArrayList<BookShopcart>();
		try {
			conn = DBUtils.getConn();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				BookShopcart bsc = new BookShopcart();
				bsc.setBid(rs.getInt("bid"));
				bsc.setBname(rs.getString("bname"));
				bsc.setPrice(rs.getDouble("price"));
				bsc.setNum(rs.getInt("num"));
				bscs.add(bsc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBUtils.close(conn, ps, rs);
		}
		return bscs;
	}
	
	// 对表进行增删改
	public static int updateTable(String sql){
		int updateRows = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBUtils.getConn();
			ps = conn.prepareStatement(sql);
			updateRows = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBUtils.close(conn, ps, null);
		}
		return updateRows;
	}
	
	// 关闭流
	public static void close(Connection conn,PreparedStatement ps,ResultSet rs) {
		try {
			if(null != rs) {
				rs.close();
			}
			if(null != ps) {
				ps.close();
			}
			if(null != conn && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}






















