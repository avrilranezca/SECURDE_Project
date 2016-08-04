package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Product;
import model.Review;

public class ReviewDAO {
	
	private Connection conn;
	
	public ReviewDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public void addReview(Review r) {
		try{
			PreparedStatement ps = conn.prepareStatement("INSERT INTO review (user_id, product_id, review, date, rating) VALUES (?,?,?,?,?);");
			ps.setInt(1, r.getUser_id());
			ps.setInt(2, r.getProduct_id());
			ps.setString(3, r.getReview());
			ps.setString(4, r.getDateTime());
			ps.setInt(5, r.getRating());
			
			ps.execute();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Review> getReviewByProduct(Product p) {
		PreparedStatement ps;

		ArrayList<Review> reviewList = new ArrayList<Review>();
		try {
			ps = conn.prepareStatement("SELECT * FROM review WHERE product_id = ?;");
			ps.setInt(1, p.getId());

			ResultSet rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Review r = new Review(rs.getInt("id"), rs.getInt("user_id"), rs.getInt("product_id"), rs.getString("review"), rs.getDate("date"), rs.getInt("rating"));
				reviewList.add(r);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return reviewList;
	}
	
	// returns negative if no ratings exist
	public Double getAverageRating(Product p) {
		
		//Double value = null;
		
		int numOfReviews = getNumberOfReviews(p);
		
		if(numOfReviews == 0) {
			return null;
		}
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT AVG(rating) AS average FROM review WHERE product_id = ?;");
			ps.setInt(1, p.getId());
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				return rs.getDouble("average");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -1.0;
	}
	
	public int getNumberOfReviews(Product p) {
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) AS count FROM review WHERE product_id = ?;");
			ps.setInt(1, p.getId());
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

}
