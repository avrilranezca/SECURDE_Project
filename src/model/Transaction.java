package model;

import java.util.Date;

public class Transaction {
	
	private int id;
	private int user_id;
	private Date date;
	
	public Transaction(int id, int user_id, Date date) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.date = date;
	}
	
	public Transaction(int user_id, Date date) {
		super();
		this.user_id = user_id;
		this.date = date;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	public String getDateTime() {
		java.text.SimpleDateFormat sdf = 
			     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String currentTime = sdf.format(date);
		
		return currentTime;
	}

}
