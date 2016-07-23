package model;

import java.util.Date;

public class Review {
	
	private int id;
	private int user_id;
	private int product_id;
	private String review;
	private Date date;
	private int rating;
	
	public Review(int id, int user_id, int product_id, String review,
			Date date, int rating) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.product_id = product_id;
		this.review = review;
		this.date = date;
		this.rating = rating;
	}
	
	public Review(int user_id, int product_id, String review,
			Date date, int rating) {
		super();
		this.user_id = user_id;
		this.product_id = product_id;
		this.review = review;
		this.date = date;
		this.rating = rating;
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

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}
	
	

}
