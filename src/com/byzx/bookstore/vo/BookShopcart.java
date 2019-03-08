package com.byzx.bookstore.vo;

public class BookShopcart {

	private int bid;
	private String bname;
	private double price;
	private int num;
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	@Override
	public String toString() {
		return "BookShopcart [bid=" + bid + ", bname=" + bname + ", price=" + price + ", num=" + num + "]";
	}
}
