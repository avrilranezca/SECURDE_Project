package model;

import java.util.Date;

public class Review {
	
	private int id;
	private int user_id;
	private String user_name;
	private int product_id;
	private String review;
	private Date date;
	private int rating;
	
	public Review(int id, String user_name, int product_id, String review,
			Date date, int rating) {
		super();
		this.id = id;
		this.user_name = user_name;
		this.product_id = product_id;
		this.review = review;
		this.date = date;
		this.rating = rating;
	}
	
	public Review(String user_name, int product_id, String review,
			Date date, int rating) {
		super();
		this.user_name = user_name;
		this.product_id = product_id;
		this.review = review;
		this.date = date;
		this.rating = rating;
	}
	
	public String toString() {
		return "\nID: " + id + " UserID: " + user_id + " ProductID: " + product_id + " Review: " + review + " Date: " + date + " Rating: " + rating;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
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

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}
	
	

}