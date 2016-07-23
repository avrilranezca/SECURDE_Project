package database;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Address;
import model.User;


public class UserDAO {

	private Connection conn;
	
	public UserDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	
	public User getUser(String user_name, String password) {
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE user_name = ?");
			ps.setString(1, user_name);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				
				if(BCrypt.checkpw(password, rs.getString("password"))) {

					User user = new User(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"), rs.getString("middle_initial"),
							rs.getString("user_name"), rs.getString("email"), rs.getString("account_type_enum"), rs.getInt("isActive"));
					return user;
				}
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
		
	}
	
	public void addUser(User u) {
		try{
			PreparedStatement ps = conn.prepareStatement("INSERT INTO user (first_name, last_name, middle_initial, user_name, password, email, account_type_enum, isActive) VALUES(?, ?, ?, ?, ?, ?, ?, ?);");
			ps.setString(1, u.getFirst_name());
			ps.setString(2, u.getLast_name());
			ps.setString(3, u.getMiddle_initial());
			ps.setString(4, u.getUser_name());
			ps.setString(5, Password.hashPassword(u.getPassword()));
			ps.setString(6, u.getEmail());
			ps.setString(7, u.getAccount_type());
			ps.setInt(8, 1);
			
			ps.execute();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void updateBillingAddress(User u, Address a) {
		try{
			PreparedStatement ps = conn.prepareStatement("UPDATE user SET billing_address_id = ? WHERE id = ?");
			ps.setInt(1, a.getId());
			ps.setInt(2, u.getId());
			
			ps.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void updateShippingAddress(User u, Address a) {
		try{
			PreparedStatement ps = conn.prepareStatement("UPDATE user SET shipping_address_id = ? WHERE id = ?");
			ps.setInt(1, a.getId());
			ps.setInt(2, u.getId());
			
			ps.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
}
