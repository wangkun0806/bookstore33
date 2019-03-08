package com.byzx.bookstore.dao;

import java.util.List;

import com.byzx.bookstore.vo.Book;
import com.byzx.bookstore.vo.BookShopcart;
import com.byzx.bookstore.vo.User;

public class DBHelper {

	// 根据用户名查user
	public User findUserByName(String username) {
		String sql = "select * from user where uname='" + username + "'";
		List<User> users = DBUtils.findUser(sql);
		return users.size()==0?null:users.get(0);
	}
	
	// 全查book表
	public List<Book> findAllBook(){
		String sql = "select * from book";
		return DBUtils.findBook(sql);
	}
	
	// 根据id查book
	public Book findBookById(int bid) {
		String sql = "select * from book where bid=" + bid;
		List<Book> books = DBUtils.findBook(sql);
		return books.size()==0?null:books.get(0);
	}
	
	// 查询有没有买某本书
	public boolean findShopcart(int uid,int bid) {
		String sql = "select * from shopcart where uid=" + uid + " and bid=" + bid;
		return DBUtils.findShopcart(sql);
	}
	// 添加shopcart
	public int insertShopcart(int uid,int bid,int num) {
		String sql = "insert into shopcart values(" + uid + "," + bid + "," + num + ")";
		return DBUtils.updateTable(sql);
	}
	// 修改shopcart
	public int updateShopcart(int uid,int bid,int num) {
		String sql = "update shopcart set num=num+" + num + " where uid=" + uid + " and bid=" + bid;
		return DBUtils.updateTable(sql);
	}
	
	// 修改shopcart
	public int updateShopcart1(int uid,int bid,int num) {
		String sql = "update shopcart set num=" + num + " where uid=" + uid + " and bid=" + bid;
		return DBUtils.updateTable(sql);
	}
	
	// book,shopcart两表联查
	public List<BookShopcart> findBookShopcart(int uid){
		String sql = "select b.bid,b.bname,b.price,s.num from book b,shopcart s where b.bid=s.bid and s.uid=" + uid;
		return DBUtils.findBookShopcart(sql);
	}
	
	public static void main(String[] args) {
		DBHelper helper = new DBHelper();
		//helper.findUserByName("scottqq");
		//System.out.println(helper.findShopcart(1, 2));
	}
}










