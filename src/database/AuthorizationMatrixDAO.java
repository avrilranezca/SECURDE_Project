package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthorizationMatrixDAO {
	
	private Connection conn;
	
	public AuthorizationMatrixDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public boolean isAuthorized(String user_name, String url) {
		
		String account_type = "";
		
		UserDAO udao = new UserDAO();
		account_type = udao.getAccountType(udao.getUser(user_name).getId());
		account_type = account_type.toLowerCase();
		
		System.out.println(account_type);
		
		if(account_type == null) {
			return false;
		}
		
		try {
			
			PreparedStatement ps = conn.prepareStatement("SELECT page_url, customer, admin, accounting_manager, product_manager FROM authorization_matrix WHERE page_url LIKE ?;");
			//ps.setString(1, account_type);
			ps.setString(1, url);
			
			ResultSet rs = ps.executeQuery();
			
			int index = 1;
			if(account_type.equals("customer")) 
				index = 2;
			else if(account_type.equals("admin"))
				index = 3;
			else if(account_type.equals("accounting_manager"))
				index = 4;
			else if(account_type.equals("product_manager"))
				index = 5;
			
			while(rs.next()) {
				return rs.getBoolean(index);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return false;
	}

}
