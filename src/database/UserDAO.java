package database;

import model.AccountTypeEnum;
import model.AccountTypeEnum.AccountType;
import model.Address;
import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;

//import java.sql.Date;


public class UserDAO {

	private Connection conn;
	
	public UserDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	
	public User getUser(String user_name, String password) {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT * FROM user WHERE user_name = ?");
			ps.setString(1, user_name);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				//System.out.println("Password: " + password);
				//System.out.println("From db password: " + rs.getString("password"));
				
				if(Password.checkPassword(password, rs.getString("password"))) {

					int id = rs.getInt("id");
					
					User user = new User(id, rs.getString("first_name"), rs.getString("last_name"), rs.getString("middle_initial"),
							rs.getString("user_name"), rs.getString("email"), rs.getString("account_type_enum"), rs.getInt("isActive"));
					
					setLastLogin(id);
					
					ps.close();
					rs.close();
					return user;
				}
				
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
		
		
		return null;
		
	}
	
	public User getUser(String user_name) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		User user = null;
		try {
			ps = conn.prepareStatement("SELECT * FROM user WHERE user_name = ?");
			ps.setString(1, user_name);
			
			rs = ps.executeQuery();
			
			//while rs.next(); return user;
			rs.next();
				
					user = new User(rs.getInt("id"), rs.getString("first_name"), rs.getString("last_name"), rs.getString("middle_initial"),
							rs.getString("user_name"), rs.getString("email"), rs.getString("account_type_enum"), rs.getInt("isActive"));
					
					user.setBilling_address_id(rs.getInt("billing_address_id"));
					user.setShipping_address_id(rs.getInt("shipping_address_id"));

			
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
		return user;
		
	}
	
	public void addUser(User u) {
		PreparedStatement ps = null;
		
		try{
			ps = conn.prepareStatement("INSERT INTO user (first_name, last_name, middle_initial, user_name, password, email, account_type_enum, isActive, password_permanent) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);");
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
	
	public void deactivateUser(int id) {
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("UPDATE user SET isActive = 0 WHERE id = ?;");
			
			ps.executeUpdate();
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
		}
	}
	
	public boolean checkIfUserNameExists(String user_name) {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT user_name FROM user WHERE user_name LIKE ?");
			ps.setString(1, user_name);
			
			rs = ps.executeQuery();
			
			if (!rs.next()) {
			    //System.out.println("no data");
				rs.close();
				ps.close();
				return false;
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
		return true;
	}
	
	public void updatePassword(User u, String newPassword) {
		//User newUser = getUser(u.getUser_name(), u.getPassword());
		
		//if(newUser != null) {
		PreparedStatement ps = null;
		
		try {
			
			ps = conn.prepareStatement("UPDATE user SET password = ?, password_permanent = 1 WHERE id = ?");
			ps.setString(1, Password.hashPassword(newPassword));
			ps.setInt(2, u.getId());
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		//}
		//else {
			//System.out.println("newUser is null");
		//}
		
		
	}
	
	public void updateBillingAddress(User u, Address a) {

		PreparedStatement ps = null;
		AddressDAO adao = new AddressDAO();
		
		adao.addAddress(a);
		
		try{
			ps = conn.prepareStatement("UPDATE user SET billing_address_id = ? WHERE id = ?");
			
			ps.setInt(1, adao.getAddress(a));
			ps.setInt(2, u.getId());
			
			ps.executeUpdate();
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
	
	public void updateShippingAddress(User u, Address a) {
		
		PreparedStatement ps = null;
		AddressDAO adao = new AddressDAO();
		
		adao.addAddress(a);
		
		try{
			ps = conn.prepareStatement("UPDATE user SET shipping_address_id = ? WHERE id = ?");
			ps.setInt(1, adao.getAddress(a));
			ps.setInt(2, u.getId());
			
			ps.executeUpdate();
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
	
	public void setUserSessionID(User u, String sessionID) {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("UPDATE user SET session_id = ? WHERE id = ?;");
			ps.setString(1, sessionID);
			ps.setInt(2, u.getId());
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
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
	
	//returns null if session id does not exist
	public String getUserSessionID(User u) {
		
		String session = "";

		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("SELECT session_id FROM user WHERE id = ?;");
			ps.setInt(1, u.getId());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				session = rs.getString("session_id");
			}
			
		} catch (SQLException e) {
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
		
		if("".equals(session) || "null".equals(session)) {
			session = "null";
		}
		
		return session;
	}
	
	public void lock(int id) {
		
		java.util.Date dt = new java.util.Date();
		
		java.text.SimpleDateFormat sdf = 
			     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String currentTime = sdf.format(dt);
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("UPDATE user SET lockout_datetime = ? WHERE id = ?;");
			ps.setString(1, currentTime);
			ps.setInt(2, id);
			
			ps.executeUpdate();
			
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
		}
	}
	
	public void unlock(int id) {
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("UPDATE user SET lockout_datetime = ? WHERE id = ?;");
			ps.setNull(1, java.sql.Types.TIMESTAMP);
			ps.setInt(2, id);
			
			ps.executeUpdate();
			
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
		}
	}
	
	
	//returns the Date if locked, returns null otherwise
	public Date isLocked(int id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("SELECT lockout_datetime FROM user WHERE id = ?;");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				Timestamp timestamp = rs.getTimestamp("lockout_datetime");
				java.util.Date date = timestamp;
				rs.close();
				ps.close();
				return date;
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
		return null;
	}
	
	public Address getBillingAddress(int id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("SELECT A.* FROM user U INNER JOIN address A ON U.billing_address_id = A.id WHERE A.id = ?;");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Address a = new Address(rs.getInt("id"), rs.getString("house_no"), rs.getString("street"), rs.getString("subdivision"), rs.getString("city"), rs.getString("postal_code"), rs.getString("country"));
				rs.close();
				ps.close();
				return a;
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
		return null;
	}
	
	public Address getShippingAddress(int id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("SELECT A.* FROM user U INNER JOIN address A ON U.shipping_address_id = A.id WHERE A.id = ?;");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Address a = new Address(rs.getInt("id"), rs.getString("house_no"), rs.getString("street"), rs.getString("subdivision"), rs.getString("city"), rs.getString("postal_code"), rs.getString("country"));
				
				rs.close();
				ps.close();
				return a;
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
		return null;
	}
	
	public void resetLogInAttempts(int id) {
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("UPDATE user SET log_in_attempts = 0 WHERE id = ?;");
			ps.setInt(1, id);
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
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
	
	public void incrementLogInAttempts(int id) {
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("UPDATE user SET log_in_attempts = log_in_attempts + 1 WHERE id = ?;");
			ps.setInt(1, id);
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
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
	
	public int getLogInAttempts(int id) {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT log_in_attempts FROM user WHERE id = ?;");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				return rs.getInt("log_in_attempts");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
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
	//returns the Date of last Login, null otherwise (but should be very rare)
	public Date getLastLoginDate(int id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT last_login FROM user WHERE id = ?;");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Timestamp timestamp = rs.getTimestamp("last_login");
				java.util.Date date = timestamp;
				rs.close();
				ps.close();
				return date;
			}
			
		} catch (SQLException e) {
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
		return null;
	}
	
	public void setLastLogin(int id) {
		java.util.Date dt = new java.util.Date();
		
		java.text.SimpleDateFormat sdf = 
			     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String currentTime = sdf.format(dt);
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("UPDATE user SET last_login = ? WHERE id = ?;");
			ps.setString(1, currentTime);
			ps.setInt(2, id);
			
			ps.executeUpdate();
		} catch (SQLException e) {
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
	
	public ArrayList<User> getAllUsers() {
		ArrayList<User> userList = new ArrayList<User>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT first_name, last_name, middle_initial, user_name, email, account_type_enum, isActive FROM user WHERE isActive = 1 AND account_type_enum NOT LIKE \"CUSTOMER\" ORDER BY account_type_enum, user_name;");
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				User u = new User(rs.getString("first_name"), rs.getString("last_name"), rs.getString("middle_initial"), rs.getString("user_name"), rs.getString("email"), rs.getString("account_type_enum"), rs.getInt("isActive"));
				userList.add(u);
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
		
		return userList;
	}
	
	public ArrayList<User> getAllAccountingManagers() {
		
		ArrayList<User> userList = new ArrayList<User>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT first_name, last_name, middle_initial, user_name, email, account_type_enum, isActive FROM user WHERE isActive = 1 AND account_type_enum LIKE \"ACCOUNTING_MANAGER\" ORDER BY user_name;");
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				User u = new User(rs.getString("first_name"), rs.getString("last_name"), rs.getString("middle_initial"), rs.getString("user_name"), rs.getString("email"), rs.getString("account_type_enum"), rs.getInt("isActive"));
				userList.add(u);
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
		
		return userList;
	}
	
	public ArrayList<User> getAllProductManagers() {
		
		ArrayList<User> userList = new ArrayList<User>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT first_name, last_name, middle_initial, user_name, email, account_type_enum, isActive FROM user WHERE isActive = 1 AND account_type_enum LIKE \"PRODUCT_MANAGER\" ORDER BY user_name;");
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				User u = new User(rs.getString("first_name"), rs.getString("last_name"), rs.getString("middle_initial"), rs.getString("user_name"), rs.getString("email"), rs.getString("account_type_enum"), rs.getInt("isActive"));
				userList.add(u);	
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
		
		return userList;
	}
	
	public ArrayList<User> getAllAdmins() {
		
		ArrayList<User> userList = new ArrayList<User>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT first_name, last_name, middle_initial, user_name, email, account_type_enum, isActive FROM user WHERE isActive = 1 AND account_type_enum LIKE \"ADMIN\" ORDER BY user_name;");
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				User u = new User(rs.getString("first_name"), rs.getString("last_name"), rs.getString("middle_initial"), rs.getString("user_name"), rs.getString("email"), rs.getString("account_type_enum"), rs.getInt("isActive"));
				userList.add(u);	
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
		
		return userList;
	}
	
	public String getAccountType(int id) {

		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT account_type_enum FROM user WHERE id = ?");
			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				return rs.getString("account_type_enum");
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
		return null;
	}
	
}
