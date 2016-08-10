package database;

import java.sql.Connection;
//import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import model.AccountTypeEnum;
import model.Address;
import model.User;
import model.AccountTypeEnum.AccountType;


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
				
				//System.out.println("Password: " + password);
				//System.out.println("From db password: " + rs.getString("password"));
				
				if(Password.checkPassword(password, rs.getString("password"))) {

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
	
	public User getUser(String user_name) {
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE user_name = ?");
			ps.setString(1, user_name);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				
					User user = new User(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"), rs.getString("middle_initial"),
							rs.getString("user_name"), rs.getString("email"), rs.getString("account_type_enum"), rs.getInt("isActive"));
					return user;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	public void addUser(User u) {
		try{
			PreparedStatement ps = conn.prepareStatement("INSERT INTO user (first_name, last_name, middle_initial, user_name, password, email, account_type_enum, isActive, password_permanent) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);");
			ps.setString(1, u.getFirst_name());
			ps.setString(2, u.getLast_name());
			ps.setString(3, u.getMiddle_initial());
			ps.setString(4, u.getUser_name());
			ps.setString(5, Password.hashPassword(u.getPassword()));
			ps.setString(6, u.getEmail());
			ps.setString(7, u.getAccount_type());
			ps.setInt(8, 1);

			AccountTypeEnum customer = new AccountTypeEnum(AccountType.CUSTOMER);
			
			if(u.getAccount_type().equals(/*AccountTypeEnum.AccountType.CUSTOMER*/ customer.accountTypeDetails())) {
				ps.setInt(9, 1);
				//System.out.println("permanent");
			}
			else {
				ps.setInt(9, 0);
				//System.out.println("not permanent");
			}
			
			
			ps.execute();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void updatePassword(User u, String newPassword) {
		//User newUser = getUser(u.getUser_name(), u.getPassword());
		
		//if(newUser != null) {
			try {
				
				PreparedStatement ps = conn.prepareStatement("UPDATE user SET password = ?, password_permanent = 1 WHERE id = ?");
				ps.setString(1, Password.hashPassword(newPassword));
				ps.setInt(2, u.getId());
				
				ps.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		//}
		//else {
			//System.out.println("newUser is null");
		//}
		
		
	}
	
	public void updateBillingAddress(User u, Address a) {

		AddressDAO adao = new AddressDAO();
		
		adao.addAddress(a);
		
		try{
			PreparedStatement ps = conn.prepareStatement("UPDATE user SET billing_address_id = ? WHERE id = ?");
			
			ps.setInt(1, adao.getAddress(a));
			ps.setInt(2, u.getId());
			
			ps.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public void updateShippingAddress(User u, Address a) {
		
		AddressDAO adao = new AddressDAO();
		
		adao.addAddress(a);
		
		try{
			PreparedStatement ps = conn.prepareStatement("UPDATE user SET shipping_address_id = ? WHERE id = ?");
			ps.setInt(1, adao.getAddress(a));
			ps.setInt(2, u.getId());
			
			ps.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public void setUserSessionID(User u, String sessionID) {
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE user SET session_id = ? WHERE id = ?;");
			ps.setString(1, sessionID);
			ps.setInt(2, u.getId());
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//returns null if session id does not exist
	public String getUserSessionID(User u) {
		
		String session = "";
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT session_id FROM user WHERE id = ?;");
			ps.setInt(1, u.getId());
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				session = rs.getString("session_id");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if("".equals(session)) {
			session = "null";
		}
		
		return session;
	}
	
	public void lock(int id) {
		
		java.util.Date dt = new java.util.Date();
		
		java.text.SimpleDateFormat sdf = 
			     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String currentTime = sdf.format(dt);
		
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement("UPDATE user SET lockout_datetime = ? WHERE id = ?;");
			ps.setString(1, currentTime);
			ps.setInt(2, id);
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void unlock(int id) {
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE user SET lockout_datetime = ? WHERE id = ?;");
			ps.setNull(1, java.sql.Types.TIMESTAMP);
			ps.setInt(2, id);
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	//returns the Date if locked, returns null otherwise
	public Date isLocked(int id) {
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT lockout_datetime FROM user WHERE id = ?;");
			ps.setInt(1, id);
			
			ResultSet rs = ps.executeQuery();
			
			
			while(rs.next()) {
				
				Timestamp timestamp = rs.getTimestamp("lockout_datetime");
				java.util.Date date = timestamp;
				return date;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public Address getBillingAddress(int id) {
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement("SELECT A.* FROM user U INNER JOIN address A ON U.billing_address_id = A.id WHERE U.id = ?;");
			ps.setInt(1, id);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Address a = new Address(rs.getInt("id"), rs.getString("house_no"), rs.getString("street"), rs.getString("subdivision"), rs.getString("city"), rs.getString("postal_code"), rs.getString("country"));
				return a;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public Address getShippingAddress(int id) {
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement("SELECT A.* FROM user U INNER JOIN address A ON U.shipping_address_id = A.id WHERE U.id = ?;");
			ps.setInt(1, id);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Address a = new Address(rs.getInt("id"), rs.getString("house_no"), rs.getString("street"), rs.getString("subdivision"), rs.getString("city"), rs.getString("postal_code"), rs.getString("country"));
				return a;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
}
