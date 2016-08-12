package database;

import model.Product;
import model.Review;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReviewDAO {
	
	private Connection conn;
	
	public ReviewDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public void addReview(Review r) {
		
		PreparedStatement ps = null;
		
		try{
			ps = conn.prepareStatement("INSERT INTO review (user_id, user_name, product_id, review, date, rating) VALUES (?,?,?,?,?,?);");
			
			UserDAO udao = new UserDAO();
			User u = udao.getUser(r.getUser_name());
			
			ps.setInt(1, u.getId());
			ps.setString(2, r.getUser_name());
			ps.setInt(3, r.getProduct_id());
			ps.setString(4, r.getReview());
			ps.setString(5, r.getDateTime());
			ps.setInt(6, r.getRating());
			
			ps.execute();
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public ArrayList<Review> getReviewByProduct(Product p) {
		PreparedStatement ps = null;
		ResultSet rs = null;

		ArrayList<Review> reviewList = new ArrayList<Review>();
		try {
			ps = conn.prepareStatement("SELECT R.id, U.user_name, R.product_id, R.review, R.date, R.rating FROM review R INNER JOIN user U ON R.user_id = U.id WHERE product_id = ?;");
			ps.setInt(1, p.getId());

			rs = ps.executeQuery();
			
			while(rs.next()) {
				Review r = new Review(rs.getInt("id"), rs.getString("user_name"), rs.getInt("product_id"), rs.getString("review"), rs.getDate("date"), rs.getInt("rating"));
				reviewList.add(r);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return reviewList;
	}
	
	// returns negative if no ratings exist
	public Double getAverageRating(Product p) {
		
		//Double value = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int numOfReviews = getNumberOfReviews(p);
		System.out.println("rev: "+numOfReviews);
		if(numOfReviews == 0) {
			return Double.valueOf(0);
		}
		
		try {
			ps = conn.prepareStatement("SELECT AVG(rating) AS average FROM review WHERE product_id = ?;");
			ps.setInt(1, p.getId());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				return rs.getDouble("average");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return 0.0;
	}
	
	public int getNumberOfReviews(Product p) {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT COUNT(*) AS 'count' FROM review WHERE product_id = ?;");
			ps.setInt(1, p.getId());

			rs = ps.executeQuery();

			while(rs.next()) {
				return rs.getInt("count");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return 0;
	}
	
	public boolean hasBought(User u, Product p){
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT T.id, user_id, user_name FROM transaction T INNER JOIN transaction_entry TE ON T.id = TE.transaction_id INNER JOIN user U on U.id = T.user_id WHERE U.user_name = ? AND TE.product_id = ?;");
			ps.setString(1, u.getUser_name());
			ps.setInt(2, p.getId());
			
			rs = ps.executeQuery();
			
			
			if (!rs.isBeforeFirst() ) {
				ps.close();
				rs.close();
			    return false;
			} 
			else {
				ps.close();
				rs.close();
				return true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return false;
		
	}

}
