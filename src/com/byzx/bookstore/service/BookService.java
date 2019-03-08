package com.byzx.bookstore.service;

import java.util.List;

import com.byzx.bookstore.dao.DBHelper;
import com.byzx.bookstore.vo.Book;
import com.byzx.bookstore.vo.BookShopcart;
import com.byzx.bookstore.vo.User;

public class BookService {

	DBHelper helper = new DBHelper();
	
	public User findUserByName(String uname) {
		return helper.findUserByName(uname);
	}
	// 判断用户名和密码的正确性
	public boolean isRightUser(String username,String password) {
		User user = findUserByName(username);
		if(null == user || !user.getPassword().equals(password)) {
			System.out.println("用户名或者密码错误");
			return false;
		}
		return true;
	}
	
	// 判断一个账号是否是管理员账号
	public boolean isAdmin(String username) {
		User user = findUserByName(username);
		if(null != user && user.getIdentity()==1) {
			return true;
		}
		return false;
	}
	
	// 全查book表
	public List<Book> findAllBook(){
		return helper.findAllBook();
	}
	
	// 根据id查book
	public Book findBookById(int bid) {
		return helper.findBookById(bid);
	}
	
	// 判断用户有没有买某本书
	// 买过，将数量更新
	// 没买过，给shopcart表添加一条数据
	public int updateShopcart(int uid,int bid,int num) {
		int updateRows = 0;
		if(helper.findShopcart(uid, bid)) { // 买过
			updateRows = helper.updateShopcart(uid, bid, num);
		}else { // 没买过
			updateRows = helper.insertShopcart(uid, bid, num);
		}
		return updateRows;
	}
	
	public int updateShopcart1(int uid,int bid,int num) {
		return helper.updateShopcart1(uid, bid, num);
	}
	
	// book,shopcart两表联查
	public List<BookShopcart> findBookShopcart(int uid){
		return helper.findBookShopcart(uid);
	}
}











